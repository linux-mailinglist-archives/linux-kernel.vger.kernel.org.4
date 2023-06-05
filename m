Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8406722F96
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjFETRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbjFETQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:16:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EE5102;
        Mon,  5 Jun 2023 12:16:22 -0700 (PDT)
Date:   Mon, 05 Jun 2023 19:16:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685992580;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fEWMzxMynrAbFiAuaLcnjQ/qJYv2G9iaD4QrsdirL5w=;
        b=lf7hxeExGKv1jRXj3FFN9mmIl777NwNCqVIvyxMTp+HIY4ANJNG5mRt20wNEoaNQlLaZXU
        H+e6SMgYXcAAkyDax0B1lr8asoD0j9fHScp+q7yvQQntT8B9T8qydPsWzaESLkJ7mNxsxO
        U+4UCLo6XLGGD+xSdH/OWQF+Y+QR6/qfdz2KHk3/gN7QoRT1q1Iwb0rvTTFM84sWa4AkIy
        yj4JHt/ALqRF6biTvpAfjWxOpisXfxLg/WfBug4eu+vJAsBeqljoz6kxv9apB5d1Ho6kwX
        EVIMWDZumidhpqQ3mdxW7cAUoimTkDkp6MH2msTAR2vYk/4RFSlSa2z6eCOqBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685992580;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fEWMzxMynrAbFiAuaLcnjQ/qJYv2G9iaD4QrsdirL5w=;
        b=WHBKDGg0JPbv89jsk8ZH0S2T5uLQWzHEZZF0twkmKuIa6g4EMkG9eeo8SlRT22oecjFJaN
        1+vparJUO+5UWBDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86/sched: Rewrite topology setup
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168599258020.404.9381359145432578623.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8f2d6c41e5a649fe217724364cbb1a7d2e6ff205
Gitweb:        https://git.kernel.org/tip/8f2d6c41e5a649fe217724364cbb1a7d2e6ff205
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 01 Jun 2023 18:00:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 21:11:03 +02:00

x86/sched: Rewrite topology setup

Instead of having a number of fixed topologies to pick from; build one
on the fly. This is both simpler now and simpler to extend in the
future.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230601153522.GB559993%40hirez.programming.kicks-ass.net
---
 arch/x86/kernel/smpboot.c | 94 +++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 51 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 34066f6..28fcd29 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -563,50 +563,57 @@ static int x86_cluster_flags(void)
 #endif
 #endif
 
-static struct sched_domain_topology_level x86_numa_in_package_topology[] = {
-#ifdef CONFIG_SCHED_SMT
-	{ cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT) },
-#endif
-#ifdef CONFIG_SCHED_CLUSTER
-	{ cpu_clustergroup_mask, x86_cluster_flags, SD_INIT_NAME(CLS) },
-#endif
-#ifdef CONFIG_SCHED_MC
-	{ cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC) },
-#endif
-	{ NULL, },
-};
+/*
+ * Set if a package/die has multiple NUMA nodes inside.
+ * AMD Magny-Cours, Intel Cluster-on-Die, and Intel
+ * Sub-NUMA Clustering have this.
+ */
+static bool x86_has_numa_in_package;
 
-static struct sched_domain_topology_level x86_hybrid_topology[] = {
-#ifdef CONFIG_SCHED_SMT
-	{ cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT) },
-#endif
-#ifdef CONFIG_SCHED_MC
-	{ cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC) },
-#endif
-	{ cpu_cpu_mask, x86_sched_itmt_flags, SD_INIT_NAME(DIE) },
-	{ NULL, },
-};
+static struct sched_domain_topology_level x86_topology[6];
+
+static void __init build_sched_topology(void)
+{
+	int i = 0;
 
-static struct sched_domain_topology_level x86_topology[] = {
 #ifdef CONFIG_SCHED_SMT
-	{ cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT) },
+	x86_topology[i++] = (struct sched_domain_topology_level){
+		cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT)
+	};
 #endif
 #ifdef CONFIG_SCHED_CLUSTER
-	{ cpu_clustergroup_mask, x86_cluster_flags, SD_INIT_NAME(CLS) },
+	/*
+	 * For now, skip the cluster domain on Hybrid.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU)) {
+		x86_topology[i++] = (struct sched_domain_topology_level){
+			cpu_clustergroup_mask, x86_cluster_flags, SD_INIT_NAME(CLS)
+		};
+	}
 #endif
 #ifdef CONFIG_SCHED_MC
-	{ cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC) },
+	x86_topology[i++] = (struct sched_domain_topology_level){
+		cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC)
+	};
 #endif
-	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
-	{ NULL, },
-};
+	/*
+	 * When there is NUMA topology inside the package skip the DIE domain
+	 * since the NUMA domains will auto-magically create the right spanning
+	 * domains based on the SLIT.
+	 */
+	if (!x86_has_numa_in_package) {
+		x86_topology[i++] = (struct sched_domain_topology_level){
+			cpu_cpu_mask, SD_INIT_NAME(DIE)
+		};
+	}
 
-/*
- * Set if a package/die has multiple NUMA nodes inside.
- * AMD Magny-Cours, Intel Cluster-on-Die, and Intel
- * Sub-NUMA Clustering have this.
- */
-static bool x86_has_numa_in_package;
+	/*
+	 * There must be one trailing NULL entry left.
+	 */
+	BUG_ON(i >= ARRAY_SIZE(x86_topology)-1);
+
+	set_sched_topology(x86_topology);
+}
 
 void set_cpu_sibling_map(int cpu)
 {
@@ -1390,15 +1397,6 @@ void __init smp_prepare_cpus_common(void)
 		zalloc_cpumask_var(&per_cpu(cpu_l2c_shared_map, i), GFP_KERNEL);
 	}
 
-	/*
-	 * Set 'default' x86 topology, this matches default_topology() in that
-	 * it has NUMA nodes as a topology level. See also
-	 * native_smp_cpus_done().
-	 *
-	 * Must be done before set_cpus_sibling_map() is ran.
-	 */
-	set_sched_topology(x86_topology);
-
 	set_cpu_sibling_map(0);
 }
 
@@ -1490,13 +1488,7 @@ void __init native_smp_cpus_done(unsigned int max_cpus)
 	pr_debug("Boot done\n");
 
 	calculate_max_logical_packages();
-
-	/* XXX for now assume numa-in-package and hybrid don't overlap */
-	if (x86_has_numa_in_package)
-		set_sched_topology(x86_numa_in_package_topology);
-	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
-		set_sched_topology(x86_hybrid_topology);
-
+	build_sched_topology();
 	nmi_selftest();
 	impress_friends();
 	cache_aps_init();
