Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F37271A2CE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbjFAPfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbjFAPfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:35:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC67E2;
        Thu,  1 Jun 2023 08:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8vJ4jlCm4JD8b0ZAMYbvLnh/K4gBTRR2bBXIOF5Psy0=; b=QTM/cHOqB+YcXdVBx7OlggjqiI
        0EkVjfTdNqGcQT0H567Fuok29BdUBMqJGwXo4wGoanaW9ZZXBdxqLgiUuftBp/VfDCch3mpasAUUV
        RbFYjrRk7yzG5pYPYddz8N+Y27JJ9WNfBBlxfvYTGL7XyGEKvsy1/P/vP/9nLEbh+00q5Zq17VqEF
        LfuQJkw/yZA+1eEGt/xsKqLj8FGY6JAQFJrakT51np/+atAYKGV8JCbTvD8T7zWlJo1rHb7bAbbqX
        XW4/ft899LcfgOG1X8gvP+RVoACKe6/abe6O1NnhIWYrN0av/1tWlHjVj5wLOa9DcXyto5RfnlqHJ
        1ik7hUtw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q4kKh-008UUb-CF; Thu, 01 Jun 2023 15:35:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D5D943002A9;
        Thu,  1 Jun 2023 17:35:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B2FBD202BDCAD; Thu,  1 Jun 2023 17:35:22 +0200 (CEST)
Date:   Thu, 1 Jun 2023 17:35:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, x86@kernel.org,
        Gautham Shenoy <gautham.shenoy@amd.com>
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Message-ID: <20230601153522.GB559993@hirez.programming.kicks-ass.net>
References: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
 <3de5c24f-6437-f21b-ed61-76b86a199e8c@amd.com>
 <20230601111326.GV4253@hirez.programming.kicks-ass.net>
 <20230601115643.GX4253@hirez.programming.kicks-ass.net>
 <20230601120001.GJ38236@hirez.programming.kicks-ass.net>
 <20230601144706.GA559454@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601144706.GA559454@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 04:47:06PM +0200, Peter Zijlstra wrote:

> One way to fix all this would be by having arch/x86/kernel/smpboot.c set
> an AMD specific set_sched_topology() that has a CCD domain above the MC
> and below the DIE domain that groups 'near' CCDs together based on some
> AMD specific topology information.
> 
> Then for small systems that will probably be just a single CCD domain
> and the degenerate code will make it go away, but for these large
> systems it will do what is right for their respective configuration.
> 
> Then, since this new multi-llc code uses MC->parent it will end up on
> the fancy new CCD domain and not scan the *entire* socket.
> 
> Hmm?

Something like the (untested) below might be a nice base to go from.

Then all you have to do is add something like:

	if (x86_has_ccd_topology) {
		x86_topology[i++] = (struct sched_domain_topology_level){
			cpu_ccd_mask, SD_INIT_NAME(CCD)
		};
	}

(and construct cpu_ccd_mask obviously...)

---
 arch/x86/kernel/smpboot.c | 94 ++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 51 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 34066f6735dd..0a22d719b6b6 100644
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
