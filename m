Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D8C6B9F40
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjCNTCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjCNTB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:01:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AD92D66
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678820472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=HRaKPhoc2o/dyfmAGwpM6cYdTDahEMUEDBWaTmQOBWk=;
        b=DGKn9ZgYNgT5NEKf+R0LbbYGS11iRHgbhYU0yWavyQ90PIqKbuqddHylVz0yF5+1ggiuRy
        ZTR1M2oj+HockFFOLE0lsjx9V30A53D8m3yjxlAHcx7t7d1wYYxbdBBmVer6VC2t42vB5b
        O6O6vh+7MuxJ95MrRaAVh6Nw3hxoykA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-82bnoofIMDyQIZinJMuk6w-1; Tue, 14 Mar 2023 15:01:06 -0400
X-MC-Unique: 82bnoofIMDyQIZinJMuk6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1355B3C11781;
        Tue, 14 Mar 2023 19:01:05 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B8D792166B26;
        Tue, 14 Mar 2023 19:01:04 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 6B8274039C291; Tue, 14 Mar 2023 16:00:44 -0300 (-03)
Message-ID: <20230314185951.704136431@redhat.com>
User-Agent: quilt/0.67
Date:   Tue, 14 Mar 2023 15:59:21 -0300
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
Subject: [PATCH v6 07/12] mm/vmstat: switch counter modification to cmpxchg
References: <20230314185914.836510860@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for switching vmstat shepherd to flush
per-CPU counters remotely, switch the __{mod,inc,dec} functions that
modify the counters to use cmpxchg.

To facilitate reviewing, functions are ordered in the text file, as:

__{mod,inc,dec}_{zone,node}_page_state
#ifdef CONFIG_HAVE_CMPXCHG_LOCAL
{mod,inc,dec}_{zone,node}_page_state
#else
{mod,inc,dec}_{zone,node}_page_state
#endif

This patch defines the __ versions for the
CONFIG_HAVE_CMPXCHG_LOCAL case to be their non-"__" counterparts:

#ifdef CONFIG_HAVE_CMPXCHG_LOCAL
{mod,inc,dec}_{zone,node}_page_state
__{mod,inc,dec}_{zone,node}_page_state = {mod,inc,dec}_{zone,node}_page_state
#else
{mod,inc,dec}_{zone,node}_page_state
__{mod,inc,dec}_{zone,node}_page_state
#endif

To test the performance difference, a page allocator microbenchmark:
https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/mm/bench/page_bench01.c 
with loops=1000000 was used, on Intel Core i7-11850H @ 2.50GHz.

For the single_page_alloc_free test, which does

        /** Loop to measure **/
        for (i = 0; i < rec->loops; i++) {
                my_page = alloc_page(gfp_mask);
                if (unlikely(my_page == NULL))
                        return 0;
                __free_page(my_page);
        }

Unit is cycles.

Vanilla			Patched		Diff
115.25			117		1.4%

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-vmstat-remote/mm/vmstat.c
===================================================================
--- linux-vmstat-remote.orig/mm/vmstat.c
+++ linux-vmstat-remote/mm/vmstat.c
@@ -334,6 +334,188 @@ void set_pgdat_percpu_threshold(pg_data_
 	}
 }
 
+#ifdef CONFIG_HAVE_CMPXCHG_LOCAL
+/*
+ * If we have cmpxchg_local support then we do not need to incur the overhead
+ * that comes with local_irq_save/restore if we use this_cpu_cmpxchg.
+ *
+ * mod_state() modifies the zone counter state through atomic per cpu
+ * operations.
+ *
+ * Overstep mode specifies how overstep should handled:
+ *     0       No overstepping
+ *     1       Overstepping half of threshold
+ *     -1      Overstepping minus half of threshold
+ */
+static inline void mod_zone_state(struct zone *zone, enum zone_stat_item item,
+				  long delta, int overstep_mode)
+{
+	struct per_cpu_zonestat __percpu *pcp = zone->per_cpu_zonestats;
+	s8 __percpu *p = pcp->vm_stat_diff + item;
+	long o, n, t, z;
+
+	do {
+		z = 0;  /* overflow to zone counters */
+
+		/*
+		 * The fetching of the stat_threshold is racy. We may apply
+		 * a counter threshold to the wrong the cpu if we get
+		 * rescheduled while executing here. However, the next
+		 * counter update will apply the threshold again and
+		 * therefore bring the counter under the threshold again.
+		 *
+		 * Most of the time the thresholds are the same anyways
+		 * for all cpus in a zone.
+		 */
+		t = this_cpu_read(pcp->stat_threshold);
+
+		o = this_cpu_read(*p);
+		n = delta + o;
+
+		if (abs(n) > t) {
+			int os = overstep_mode * (t >> 1);
+
+			/* Overflow must be added to zone counters */
+			z = n + os;
+			n = -os;
+		}
+	} while (this_cpu_cmpxchg(*p, o, n) != o);
+
+	if (z)
+		zone_page_state_add(z, zone, item);
+}
+
+void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
+			 long delta)
+{
+	mod_zone_state(zone, item, delta, 0);
+}
+EXPORT_SYMBOL(mod_zone_page_state);
+
+void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
+			   long delta)
+{
+	mod_zone_state(zone, item, delta, 0);
+}
+EXPORT_SYMBOL(__mod_zone_page_state);
+
+void inc_zone_page_state(struct page *page, enum zone_stat_item item)
+{
+	mod_zone_state(page_zone(page), item, 1, 1);
+}
+EXPORT_SYMBOL(inc_zone_page_state);
+
+void __inc_zone_page_state(struct page *page, enum zone_stat_item item)
+{
+	mod_zone_state(page_zone(page), item, 1, 1);
+}
+EXPORT_SYMBOL(__inc_zone_page_state);
+
+void dec_zone_page_state(struct page *page, enum zone_stat_item item)
+{
+	mod_zone_state(page_zone(page), item, -1, -1);
+}
+EXPORT_SYMBOL(dec_zone_page_state);
+
+void __dec_zone_page_state(struct page *page, enum zone_stat_item item)
+{
+	mod_zone_state(page_zone(page), item, -1, -1);
+}
+EXPORT_SYMBOL(__dec_zone_page_state);
+
+static inline void mod_node_state(struct pglist_data *pgdat,
+				  enum node_stat_item item,
+				  int delta, int overstep_mode)
+{
+	struct per_cpu_nodestat __percpu *pcp = pgdat->per_cpu_nodestats;
+	s8 __percpu *p = pcp->vm_node_stat_diff + item;
+	long o, n, t, z;
+
+	if (vmstat_item_in_bytes(item)) {
+		/*
+		 * Only cgroups use subpage accounting right now; at
+		 * the global level, these items still change in
+		 * multiples of whole pages. Store them as pages
+		 * internally to keep the per-cpu counters compact.
+		 */
+		VM_WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
+		delta >>= PAGE_SHIFT;
+	}
+
+	do {
+		z = 0;  /* overflow to node counters */
+
+		/*
+		 * The fetching of the stat_threshold is racy. We may apply
+		 * a counter threshold to the wrong the cpu if we get
+		 * rescheduled while executing here. However, the next
+		 * counter update will apply the threshold again and
+		 * therefore bring the counter under the threshold again.
+		 *
+		 * Most of the time the thresholds are the same anyways
+		 * for all cpus in a node.
+		 */
+		t = this_cpu_read(pcp->stat_threshold);
+
+		o = this_cpu_read(*p);
+		n = delta + o;
+
+		if (abs(n) > t) {
+			int os = overstep_mode * (t >> 1);
+
+			/* Overflow must be added to node counters */
+			z = n + os;
+			n = -os;
+		}
+	} while (this_cpu_cmpxchg(*p, o, n) != o);
+
+	if (z)
+		node_page_state_add(z, pgdat, item);
+}
+
+void mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
+					long delta)
+{
+	mod_node_state(pgdat, item, delta, 0);
+}
+EXPORT_SYMBOL(mod_node_page_state);
+
+void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
+					long delta)
+{
+	mod_node_state(pgdat, item, delta, 0);
+}
+EXPORT_SYMBOL(__mod_node_page_state);
+
+void inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
+{
+	mod_node_state(pgdat, item, 1, 1);
+}
+
+void inc_node_page_state(struct page *page, enum node_stat_item item)
+{
+	mod_node_state(page_pgdat(page), item, 1, 1);
+}
+EXPORT_SYMBOL(inc_node_page_state);
+
+void __inc_node_page_state(struct page *page, enum node_stat_item item)
+{
+	mod_node_state(page_pgdat(page), item, 1, 1);
+}
+EXPORT_SYMBOL(__inc_node_page_state);
+
+void dec_node_page_state(struct page *page, enum node_stat_item item)
+{
+	mod_node_state(page_pgdat(page), item, -1, -1);
+}
+EXPORT_SYMBOL(dec_node_page_state);
+
+void __dec_node_page_state(struct page *page, enum node_stat_item item)
+{
+	mod_node_state(page_pgdat(page), item, -1, -1);
+}
+EXPORT_SYMBOL(__dec_node_page_state);
+#else
 /*
  * For use when we know that interrupts are disabled,
  * or when we know that preemption is disabled and that
@@ -541,149 +723,6 @@ void __dec_node_page_state(struct page *
 }
 EXPORT_SYMBOL(__dec_node_page_state);
 
-#ifdef CONFIG_HAVE_CMPXCHG_LOCAL
-/*
- * If we have cmpxchg_local support then we do not need to incur the overhead
- * that comes with local_irq_save/restore if we use this_cpu_cmpxchg.
- *
- * mod_state() modifies the zone counter state through atomic per cpu
- * operations.
- *
- * Overstep mode specifies how overstep should handled:
- *     0       No overstepping
- *     1       Overstepping half of threshold
- *     -1      Overstepping minus half of threshold
-*/
-static inline void mod_zone_state(struct zone *zone,
-       enum zone_stat_item item, long delta, int overstep_mode)
-{
-	struct per_cpu_zonestat __percpu *pcp = zone->per_cpu_zonestats;
-	s8 __percpu *p = pcp->vm_stat_diff + item;
-	long o, n, t, z;
-
-	do {
-		z = 0;  /* overflow to zone counters */
-
-		/*
-		 * The fetching of the stat_threshold is racy. We may apply
-		 * a counter threshold to the wrong the cpu if we get
-		 * rescheduled while executing here. However, the next
-		 * counter update will apply the threshold again and
-		 * therefore bring the counter under the threshold again.
-		 *
-		 * Most of the time the thresholds are the same anyways
-		 * for all cpus in a zone.
-		 */
-		t = this_cpu_read(pcp->stat_threshold);
-
-		o = this_cpu_read(*p);
-		n = delta + o;
-
-		if (abs(n) > t) {
-			int os = overstep_mode * (t >> 1) ;
-
-			/* Overflow must be added to zone counters */
-			z = n + os;
-			n = -os;
-		}
-	} while (this_cpu_cmpxchg(*p, o, n) != o);
-
-	if (z)
-		zone_page_state_add(z, zone, item);
-}
-
-void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
-			 long delta)
-{
-	mod_zone_state(zone, item, delta, 0);
-}
-EXPORT_SYMBOL(mod_zone_page_state);
-
-void inc_zone_page_state(struct page *page, enum zone_stat_item item)
-{
-	mod_zone_state(page_zone(page), item, 1, 1);
-}
-EXPORT_SYMBOL(inc_zone_page_state);
-
-void dec_zone_page_state(struct page *page, enum zone_stat_item item)
-{
-	mod_zone_state(page_zone(page), item, -1, -1);
-}
-EXPORT_SYMBOL(dec_zone_page_state);
-
-static inline void mod_node_state(struct pglist_data *pgdat,
-       enum node_stat_item item, int delta, int overstep_mode)
-{
-	struct per_cpu_nodestat __percpu *pcp = pgdat->per_cpu_nodestats;
-	s8 __percpu *p = pcp->vm_node_stat_diff + item;
-	long o, n, t, z;
-
-	if (vmstat_item_in_bytes(item)) {
-		/*
-		 * Only cgroups use subpage accounting right now; at
-		 * the global level, these items still change in
-		 * multiples of whole pages. Store them as pages
-		 * internally to keep the per-cpu counters compact.
-		 */
-		VM_WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
-		delta >>= PAGE_SHIFT;
-	}
-
-	do {
-		z = 0;  /* overflow to node counters */
-
-		/*
-		 * The fetching of the stat_threshold is racy. We may apply
-		 * a counter threshold to the wrong the cpu if we get
-		 * rescheduled while executing here. However, the next
-		 * counter update will apply the threshold again and
-		 * therefore bring the counter under the threshold again.
-		 *
-		 * Most of the time the thresholds are the same anyways
-		 * for all cpus in a node.
-		 */
-		t = this_cpu_read(pcp->stat_threshold);
-
-		o = this_cpu_read(*p);
-		n = delta + o;
-
-		if (abs(n) > t) {
-			int os = overstep_mode * (t >> 1) ;
-
-			/* Overflow must be added to node counters */
-			z = n + os;
-			n = -os;
-		}
-	} while (this_cpu_cmpxchg(*p, o, n) != o);
-
-	if (z)
-		node_page_state_add(z, pgdat, item);
-}
-
-void mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
-					long delta)
-{
-	mod_node_state(pgdat, item, delta, 0);
-}
-EXPORT_SYMBOL(mod_node_page_state);
-
-void inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
-{
-	mod_node_state(pgdat, item, 1, 1);
-}
-
-void inc_node_page_state(struct page *page, enum node_stat_item item)
-{
-	mod_node_state(page_pgdat(page), item, 1, 1);
-}
-EXPORT_SYMBOL(inc_node_page_state);
-
-void dec_node_page_state(struct page *page, enum node_stat_item item)
-{
-	mod_node_state(page_pgdat(page), item, -1, -1);
-}
-EXPORT_SYMBOL(dec_node_page_state);
-#else
 /*
  * Use interrupt disable to serialize counter updates
  */
Index: linux-vmstat-remote/mm/page_alloc.c
===================================================================
--- linux-vmstat-remote.orig/mm/page_alloc.c
+++ linux-vmstat-remote/mm/page_alloc.c
@@ -8628,9 +8628,6 @@ static int page_alloc_cpu_dead(unsigned
 	/*
 	 * Zero the differential counters of the dead processor
 	 * so that the vm statistics are consistent.
-	 *
-	 * This is only okay since the processor is dead and cannot
-	 * race with what we are doing.
 	 */
 	cpu_vm_stats_fold(cpu);
 


