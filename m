Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063C56B9F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjCNTCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjCNTBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:01:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705813593
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678820470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=AyHd4n90cFHn3Luv5sQXSwJ2Z0MI24C3Jhi1jfEoG60=;
        b=UMgmDclUDK2/lKivA4Z7OKobBLsHlHaspT/UwPvHHGihiVKh0jXZ4Jvj9krnmW+2mFQteO
        eliHTON/Q/8o4TLrtgKBaXjjm8MvO+LoIZkEsQtbNOCbpum+VLyKmBWetZI4rpPbFAq2Iu
        Odb2ad/1MRCOc2yzn6vdrl0zQiyt/1U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-ysHsOFL6P62V2VFkUCAX5w-1; Tue, 14 Mar 2023 15:01:04 -0400
X-MC-Unique: ysHsOFL6P62V2VFkUCAX5w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A18D8857AA4;
        Tue, 14 Mar 2023 19:01:03 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B21A1731B;
        Tue, 14 Mar 2023 19:01:03 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 520C34038EDB3; Tue, 14 Mar 2023 16:00:44 -0300 (-03)
Message-ID: <20230314185914.836510860@redhat.com>
User-Agent: quilt/0.67
Date:   Tue, 14 Mar 2023 15:59:14 -0300
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
Subject: [PATCH v6 00/12] fold per-CPU vmstats remotely
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

 1. A customer provided evidence which indicates that
    the idle tick was stopped; albeit, CPU-specific vmstat
    counters still remained populated.

    Thus one can only assume quiet_vmstat() was not
    invoked on return to the idle loop. If I understand
    correctly, I suspect this divergence might erroneously
    prevent a reclaim attempt by kswapd. If the number of
    zone specific free pages are below their per-cpu drift
    value then zone_page_state_snapshot() is used to
    compute a more accurate view of the aforementioned
    statistic.  Thus any task blocked on the NUMA node
    specific pfmemalloc_wait queue will be unable to make
    significant progress via direct reclaim unless it is
    killed after being woken up by kswapd
    (see throttle_direct_reclaim()). The evidence is:

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

 2. With a SCHED_FIFO task that busy loops on a given CPU,
    and kworker for that CPU at SCHED_OTHER priority,
    queuing work to sync per-vmstats will either cause that
    work to never execute, or stalld (i.e. stall daemon)
    boosts kworker priority which causes a latency
    violation

By having vmstat_shepherd flush the per-CPU counters to the
global counters from remote CPUs.

This is done using cmpxchg to manipulate the counters,
both CPU locally (via the account functions),
and remotely (via cpu_vm_stats_fold).

Thanks to Aaron Tomlin for diagnosing issue 1 and writing
the initial patch series.

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
 arch/x86/include/asm/percpu.h       |   39 +++----
 include/asm-generic/percpu.h        |   17 +++
 include/linux/mmzone.h              |    3 
 include/linux/percpu-defs.h         |    2 
 kernel/fork.c                       |    2 
 kernel/scs.c                        |    2 
 mm/page_alloc.c                     |   23 ----
 mm/vmstat.c                         |  424 +++++++++++++++++++++++++++++++++++++++++------------------------------------
 11 files changed, 307 insertions(+), 249 deletions(-)



