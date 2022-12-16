Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A4264F202
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiLPTxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiLPTx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:53:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB56B659BD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671220360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=9wyWU7q9zcUtfqIAPMNd6wk67vz331U9cm7/N6A7Uqs=;
        b=dcdZftYi0TFH49OTVvuAAMSFL6RxwI3H8OowtCnFXia6uxZ85ENoIv+ooBNEqgkHlyoDz/
        1Kb+57MKQ9u6OrUA4VK2IMbebCi7c3zSjAYYrUfq93XzYRB8zRODnwLsyCkXyFSafeAmfP
        XClf1wrIgXRjTYuZzvhHxT+k157ShQ4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-59YoxDBaO_aCqgO6Mf_Ftg-1; Fri, 16 Dec 2022 14:52:36 -0500
X-MC-Unique: 59YoxDBaO_aCqgO6Mf_Ftg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28D2D2805585;
        Fri, 16 Dec 2022 19:52:36 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6250649BB6A;
        Fri, 16 Dec 2022 19:52:35 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id C7D304269CA80; Fri, 16 Dec 2022 16:52:10 -0300 (-03)
Message-ID: <20221216194904.115519799@redhat.com>
User-Agent: quilt/0.66
Date:   Fri, 16 Dec 2022 16:45:42 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     atomlin@redhat.com, frederic@kernel.org
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v10 2/6] mm/vmstat: Use vmstat_dirty to track CPU-specific vmstat discrepancies
References: <20221216194540.202752779@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Tomlin <atomlin@redhat.com>

This patch will now use the previously introduced CPU-specific variable
namely vmstat_dirty to indicate if a vmstat differential/or imbalance is
present for a given CPU. So, at the appropriate time, vmstat processing can
be initiated. The hope is that this particular approach is "cheaper" when
compared to need_update(). The idea is based on Marcelo's patch [1].

[1]: https://lore.kernel.org/lkml/20220204173554.763888172@fedora.localdomain/

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
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
@@ -606,6 +608,7 @@ static inline void mod_zone_state(struct
 
 	if (z)
 		zone_page_state_add(z, zone, item);
+	vmstat_mark_dirty();
 }
 
 void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
@@ -674,6 +677,7 @@ static inline void mod_node_state(struct
 
 	if (z)
 		node_page_state_add(z, pgdat, item);
+	vmstat_mark_dirty();
 }
 
 void mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
@@ -828,6 +832,14 @@ static int refresh_cpu_vm_stats(bool do_
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
@@ -1957,35 +1969,6 @@ static void vmstat_update(struct work_st
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
@@ -1995,10 +1978,7 @@ void quiet_vmstat(void)
 	if (system_state != SYSTEM_RUNNING)
 		return;
 
-	if (!delayed_work_pending(this_cpu_ptr(&vmstat_work)))
-		return;
-
-	if (!need_update(smp_processor_id()))
+	if (!is_vmstat_dirty())
 		return;
 
 	/*
@@ -2029,7 +2009,7 @@ static void vmstat_shepherd(struct work_
 	for_each_online_cpu(cpu) {
 		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
 
-		if (!delayed_work_pending(dw) && need_update(cpu))
+		if (!delayed_work_pending(dw) && per_cpu(vmstat_dirty, cpu))
 			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
 
 		cond_resched();


