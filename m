Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A2E65EB41
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbjAEM5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjAEM52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:57:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1156951310
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672923406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=AWWNy27PnDV2BzrRi18CQGy2pR4xt8zt+F15YzdMHas=;
        b=e0KcPP9wqxdWVV0zbR0iSSuB6efDhXeY/iNAAryZCN7Ikg4x5q2t7g7rCJSS++XRJVX6JE
        UIAnpXmkoPH2vqJ3I2lZSHaCBUnEMysbNioGxwxFzU1U5DfMSJ4X3V/9lPlC+YQpO6rD68
        45Ptab/DoQ1UKXnF+ZLrWuH2efBEo7Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191--cpSVXu9NI2oKV4L1YUfng-1; Thu, 05 Jan 2023 07:56:43 -0500
X-MC-Unique: -cpSVXu9NI2oKV4L1YUfng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD5AD80234E;
        Thu,  5 Jan 2023 12:56:42 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4916153A0;
        Thu,  5 Jan 2023 12:56:42 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 98FF240502F3A; Thu,  5 Jan 2023 09:54:47 -0300 (-03)
Message-ID: <20230105125248.813825852@redhat.com>
User-Agent: quilt/0.66
Date:   Thu, 05 Jan 2023 09:52:20 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     atomlin@atomlin.com, frederic@kernel.org
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v13 2/6] mm/vmstat: Use vmstat_dirty to track CPU-specific vmstat discrepancies
References: <20230105125218.031928326@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Aaron Tomlin <atomlin@atomlin.com>

This patch will now use the previously introduced CPU-specific variable
namely vmstat_dirty to indicate if a vmstat differential/or imbalance is
present for a given CPU. So, at the appropriate time, vmstat processing can
be initiated. The hope is that this particular approach is "cheaper" when
compared to need_update(). The idea is based on Marcelo's patch [1].

[1]: https://lore.kernel.org/lkml/20220204173554.763888172@fedora.localdomain/

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
---
 mm/vmstat.c |   48 ++++++++++++++----------------------------------
 1 file changed, 14 insertions(+), 34 deletions(-)

Index: linux-2.6/mm/vmstat.c
===================================================================
--- linux-2.6.orig/mm/vmstat.c
+++ linux-2.6/mm/vmstat.c
@@ -381,6 +381,7 @@ void __mod_zone_page_state(struct zone *
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+	vmstat_mark_dirty();
 
 	preempt_enable_nested();
 }
@@ -417,6 +418,7 @@ void __mod_node_page_state(struct pglist
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+	vmstat_mark_dirty();
 
 	preempt_enable_nested();
 }
@@ -577,6 +579,9 @@ static inline void mod_zone_state(struct
 	s8 __percpu *p = pcp->vm_stat_diff + item;
 	long o, n, t, z;
 
+	/* cmpxchg and vmstat_mark_dirty should happen on the same CPU */
+	preempt_disable();
+
 	do {
 		z = 0;  /* overflow to zone counters */
 
@@ -606,6 +611,8 @@ static inline void mod_zone_state(struct
 
 	if (z)
 		zone_page_state_add(z, zone, item);
+	vmstat_mark_dirty();
+	preempt_enable();
 }
 
 void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
@@ -645,6 +652,8 @@ static inline void mod_node_state(struct
 		delta >>= PAGE_SHIFT;
 	}
 
+	/* cmpxchg and vmstat_mark_dirty should happen on the same CPU */
+	preempt_disable();
 	do {
 		z = 0;  /* overflow to node counters */
 
@@ -674,6 +683,8 @@ static inline void mod_node_state(struct
 
 	if (z)
 		node_page_state_add(z, pgdat, item);
+	vmstat_mark_dirty();
+	preempt_enable();
 }
 
 void mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
@@ -828,6 +839,14 @@ static int refresh_cpu_vm_stats(bool do_
 	int global_node_diff[NR_VM_NODE_STAT_ITEMS] = { 0, };
 	int changes = 0;
 
+	/*
+	 * Clear vmstat_dirty before clearing the percpu vmstats.
+	 * If interrupts are enabled, it is possible that an interrupt
+	 * or another task modifies a percpu vmstat, which will
+	 * set vmstat_dirty to true.
+	 */
+	vmstat_clear_dirty();
+
 	for_each_populated_zone(zone) {
 		struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
 #ifdef CONFIG_NUMA
@@ -1957,35 +1976,6 @@ static void vmstat_update(struct work_st
 }
 
 /*
- * Check if the diffs for a certain cpu indicate that
- * an update is needed.
- */
-static bool need_update(int cpu)
-{
-	pg_data_t *last_pgdat = NULL;
-	struct zone *zone;
-
-	for_each_populated_zone(zone) {
-		struct per_cpu_zonestat *pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
-		struct per_cpu_nodestat *n;
-
-		/*
-		 * The fast way of checking if there are any vmstat diffs.
-		 */
-		if (memchr_inv(pzstats->vm_stat_diff, 0, sizeof(pzstats->vm_stat_diff)))
-			return true;
-
-		if (last_pgdat == zone->zone_pgdat)
-			continue;
-		last_pgdat = zone->zone_pgdat;
-		n = per_cpu_ptr(zone->zone_pgdat->per_cpu_nodestats, cpu);
-		if (memchr_inv(n->vm_node_stat_diff, 0, sizeof(n->vm_node_stat_diff)))
-			return true;
-	}
-	return false;
-}
-
-/*
  * Switch off vmstat processing and then fold all the remaining differentials
  * until the diffs stay at zero. The function is used by NOHZ and can only be
  * invoked when tick processing is not active.
@@ -1995,10 +1985,7 @@ void quiet_vmstat(void)
 	if (system_state != SYSTEM_RUNNING)
 		return;
 
-	if (!delayed_work_pending(this_cpu_ptr(&vmstat_work)))
-		return;
-
-	if (!need_update(smp_processor_id()))
+	if (!is_vmstat_dirty())
 		return;
 
 	/*
@@ -2029,7 +2016,7 @@ static void vmstat_shepherd(struct work_
 	for_each_online_cpu(cpu) {
 		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
 
-		if (!delayed_work_pending(dw) && need_update(cpu))
+		if (!delayed_work_pending(dw) && per_cpu(vmstat_dirty, cpu))
 			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
 
 		cond_resched();


