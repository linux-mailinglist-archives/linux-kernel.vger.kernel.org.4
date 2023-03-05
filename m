Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7592C6AAFF7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 14:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCENmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 08:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjCENme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 08:42:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7FE13501
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 05:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678023708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=P/j9durd7jwFNaERdOWNyEIRSGeMnTudRhB5H/p/vA4=;
        b=Ir1ZffX0F6wAzNhWJzuH6JdoJ/U5gcEiuG+5eSNI79D7EB4z9DShyFarRiuvg6L2jJnbur
        harpAz1c06sRwkhvUaMs7HrYD+jvDtEbZrjNTMpjtJaRYvY95p5njJurkpgXXpiQleVlhc
        qZBvQQHgaBWafBFzWbcirqeGI+GfgrU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-pgC5_pukO-KO-VBM7OMrlQ-1; Sun, 05 Mar 2023 08:41:43 -0500
X-MC-Unique: pgC5_pukO-KO-VBM7OMrlQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBC9329AA38F;
        Sun,  5 Mar 2023 13:41:42 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A76DBC16029;
        Sun,  5 Mar 2023 13:41:42 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 14CA9401344B4; Sun,  5 Mar 2023 10:41:23 -0300 (-03)
Message-ID: <20230305133657.255737580@redhat.com>
User-Agent: quilt/0.67
Date:   Sun, 05 Mar 2023 10:36:57 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org
Subject: [PATCH v4 00/12] fold per-CPU vmstats remotely
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

    1. A customer provided some evidence which indicates that
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
       (see throttle_direct_reclaim())

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

v4:
- Switch per-CPU vmstat counters to s32, required for
  architectures that do not provide cmpxchg/xchg on
  8 bits

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
 arch/loongarch/include/asm/percpu.h |   23 +++
 arch/s390/include/asm/percpu.h      |    5 
 arch/x86/include/asm/percpu.h       |   39 +++---
 include/asm-generic/percpu.h        |   17 ++
 include/linux/mmzone.h              |   11 -
 include/linux/percpu-defs.h         |    2 
 kernel/fork.c                       |    2 
 kernel/scs.c                        |    2 
 mm/page_alloc.c                     |   23 ---
 mm/vmstat.c                         |  452 +++++++++++++++++++++++++++++++++++++++++------------------------------------
 11 files changed, 325 insertions(+), 267 deletions(-)

