Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D8B6B9F41
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjCNTCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjCNTB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:01:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D8B11168
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678820473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Nr9fYbpF3v+q6jpxCLVFeOy0r5BagqTS2hiKgCt5CBQ=;
        b=hjFoXZpfMW9p8ngb+SLkNjE4Xaiq2/eCQ0HevZBtNPzXkeS0t3UJfbjDsHgStlUfQufBOm
        5cWjCD6o7xLlmMvGRRyIrviiLwtjxNx+B0677rekjOg5vOZdGLiJZpmvkFBG4qL/v3nzLd
        Z45jHcaeLNNqixTFOQCqjNHL+SWmmjs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-FUxLZ_pZN0q1wQRTUiKORQ-1; Tue, 14 Mar 2023 15:01:06 -0400
X-MC-Unique: FUxLZ_pZN0q1wQRTUiKORQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1088728004F0;
        Tue, 14 Mar 2023 19:01:05 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D9360C164E7;
        Tue, 14 Mar 2023 19:01:04 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 78F4D4039C294; Tue, 14 Mar 2023 16:00:44 -0300 (-03)
Message-ID: <20230314185951.779596601@redhat.com>
User-Agent: quilt/0.67
Date:   Tue, 14 Mar 2023 15:59:24 -0300
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
        Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v6 10/12] mm/vmstat: switch vmstat shepherd to flush per-CPU counters remotely
References: <20230314185914.836510860@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Now that the counters are modified via cmpxchg both CPU locally
(via the account functions), and remotely (via cpu_vm_stats_fold),
its possible to switch vmstat_shepherd to perform the per-CPU 
vmstats folding remotely.

This fixes the following two problems:

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

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-vmstat-remote/mm/vmstat.c
===================================================================
--- linux-vmstat-remote.orig/mm/vmstat.c
+++ linux-vmstat-remote/mm/vmstat.c
@@ -2043,6 +2043,23 @@ static void vmstat_shepherd(struct work_
 
 static DECLARE_DEFERRABLE_WORK(shepherd, vmstat_shepherd);
 
+#ifdef CONFIG_HAVE_CMPXCHG_LOCAL
+/* Flush counters remotely if CPU uses cmpxchg to update its per-CPU counters */
+static void vmstat_shepherd(struct work_struct *w)
+{
+	int cpu;
+
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		cpu_vm_stats_fold(cpu);
+		cond_resched();
+	}
+	cpus_read_unlock();
+
+	schedule_delayed_work(&shepherd,
+		round_jiffies_relative(sysctl_stat_interval));
+}
+#else
 static void vmstat_shepherd(struct work_struct *w)
 {
 	int cpu;
@@ -2062,6 +2079,7 @@ static void vmstat_shepherd(struct work_
 	schedule_delayed_work(&shepherd,
 		round_jiffies_relative(sysctl_stat_interval));
 }
+#endif
 
 static void __init start_shepherd_timer(void)
 {


