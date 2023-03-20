Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BDF6C1F78
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjCTSVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjCTSUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:20:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296EA3B223
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679335929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=2/4zOYZZtH2WSGJk64M37M/sTAQLT68CCaLnUdPqKgU=;
        b=Tn64OC0ukcDCnDHYZsdi2e2CZM+rAxYIpRnPWNZ6ZnHiF4uXZmQBPrIJkpdiNW9EZGHqL9
        dpKHBWd40D+E4uO0S5s88w/Oyw64XR5PJFStnbWxFEuphZ9iXjwV7Uvm6f16NAm2cAo/VQ
        rDVj8txia6Q8h69/GW6cmG3glha3z28=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-zhto1ZHtMbmUSZaKIzWElw-1; Mon, 20 Mar 2023 14:12:04 -0400
X-MC-Unique: zhto1ZHtMbmUSZaKIzWElw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9500A38173D9;
        Mon, 20 Mar 2023 18:12:03 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 20A08C15BA0;
        Mon, 20 Mar 2023 18:12:03 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id CF185403A3E4B; Mon, 20 Mar 2023 15:08:02 -0300 (-03)
Message-ID: <20230320180332.102837832@redhat.com>
User-Agent: quilt/0.67
Date:   Mon, 20 Mar 2023 15:03:32 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v7 00/13] fold per-CPU vmstats remotely
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series addresses the following two problems:

1. A customer provided evidence indicating that a process
   was stalled in direct reclaim:

 - The process was trapped in throttle_direct_reclaim().
   The function wait_event_killable() was called to wait condition
   allow_direct_reclaim(pgdat) for current node to be true.
   The allow_direct_reclaim(pgdat) examined the number of free pages
   on the node by zone_page_state() which just returns value in
   zone->vm_stat[NR_FREE_PAGES].

 - On node #1, zone->vm_stat[NR_FREE_PAGES] was 0.
   However, the freelist on this node was not empty.

 - This inconsistent of vmstat value was caused by percpu vmstat on
   nohz_full cpus. Every increment/decrement of vmstat is performed
   on percpu vmstat counter at first, then pooled diffs are cumulated
   to the zone's vmstat counter in timely manner. However, on nohz_full
   cpus (in case of this customer's system, 48 of 52 cpus) these pooled
   diffs were not cumulated once the cpu had no event on it so that
   the cpu started sleeping infinitely.
   I checked percpu vmstat and found there were total 69 counts not
   cumulated to the zone's vmstat counter yet.

 - In this situation, kswapd did not help the trapped process.
   In pgdat_balanced(), zone_wakermark_ok_safe() examined the number
   of free pages on the node by zone_page_state_snapshot() which
   checks pending counts on percpu vmstat.
   Therefore kswapd could know there were 69 free pages correctly.
   Since zone->_watermark = {8, 20, 32}, kswapd did not work because
   69 was greater than 32 as high watermark.

 2. With a task that busy loops on a given CPU,
    the kworker interruption to execute vmstat_update
    is undesired and may exceed latency thresholds
    for certain applications.

By having vmstat_shepherd flush the per-CPU counters to the
global counters from remote CPUs.

This is done using cmpxchg to manipulate the counters,
both CPU locally (via the account functions),
and remotely (via cpu_vm_stats_fold).

Thanks to Aaron Tomlin for diagnosing issue 1 and writing
the initial patch series.


Performance details for the kworker interruption:

oslat   1094.456862: sys_mlock(start: 7f7ed0000b60, len: 1000)
oslat   1094.456971: workqueue_queue_work: ... function=vmstat_update ...
oslat   1094.456974: sched_switch: prev_comm=oslat ... ==> next_comm=kworker/5:1 ...
kworker 1094.456978: sched_switch: prev_comm=kworker/5:1 ==> next_comm=oslat ...
 
The example above shows an additional 7us for the

        oslat -> kworker -> oslat

switches. In the case of a virtualized CPU, and the vmstat_update
interruption in the host (of a qemu-kvm vcpu), the latency penalty
observed in the guest is higher than 50us, violating the acceptable
latency threshold for certain applications.

v7:
- Fix allow_direct_reclaim issue by using
  zone_page_state_snapshot				(Michal Hocko)

v6:
- Add more information on throttle_direct_reclaim problem 
  to commit logs	       			       (Michal Hocko)

v5:
- Drop "mm/vmstat: remove remote node draining"        (Vlastimil Babka)
- Implement remote node draining for cpu_vm_stats_fold (Vlastimil Babka)

v4:
- Switch per-CPU vmstat counters to s32, required 
  by RISC-V, ARC architectures			

v3:
- Removed unused drain_zone_pages and changes variable (David Hildenbrand)
- Use xchg instead of cmpxchg in refresh_cpu_vm_stats  (Peter Xu)
- Add drain_all_pages to vmstat_refresh to make
  stats more accurate				       (Peter Xu)
- Improve changelog of
  "mm/vmstat: switch counter modification to cmpxchg"  (Peter Xu / David)
- Improve changelog of
  "mm/vmstat: remove remote node draining"	       (David Hildenbrand)


v2:
- actually use LOCK CMPXCHG on counter mod/inc/dec functions
  (Christoph Lameter)
- use try_cmpxchg for cmpxchg loops
  (Uros Bizjak / Matthew Wilcox)

 arch/arm64/include/asm/percpu.h     |   16 ++
 arch/loongarch/include/asm/percpu.h |   23 +++-
 arch/s390/include/asm/percpu.h      |    5 
 arch/x86/include/asm/percpu.h       |   39 +++---
 include/asm-generic/percpu.h        |   17 ++
 include/linux/mmzone.h              |    8 -
 include/linux/percpu-defs.h         |    2 
 include/linux/vmstat.h              |    2 
 kernel/fork.c                       |    2 
 kernel/scs.c                        |    2 
 mm/page_alloc.c                     |    5 
 mm/vmscan.c                         |    2 
 mm/vmstat.c                         |  440 +++++++++++++++++++++++++++++++++++++++++++++++------------------------------
 13 files changed, 361 insertions(+), 202 deletions(-)


