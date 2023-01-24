Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0ED967942B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjAXJ1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjAXJ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:26:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B603C2B6;
        Tue, 24 Jan 2023 01:26:42 -0800 (PST)
Date:   Tue, 24 Jan 2023 09:26:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674552399;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dnf5OxTqtwRZWHfDL5Y82HKCbs6WMuRg4L9/vFsyM8Y=;
        b=srL8lrRYHABS38tjO/bKNVXynAITV8pjNS4w0fLsjBisbVA+Eln+E02ZmLZzSyfwwl9YY6
        3PEzVzVeC5JJ8RuBXXGExYWAqrLY4b3VxHqP7rUOBfAhI9xvskFPXWViePBHEwTo20N38L
        JIvTUkNmSgebbxzsHEe3UN1KG1FqddoPEU1up+7ySN3BdSs233imiqRtDgQABYZtaz9Rls
        ioWNdy4VxS7zwrUlAQn7fHJyegnRQa7c9zVjDSWk/N3C0GXsaixLyjxVwSBAwGQkT7Db50
        7FPzUqPIi6pazO/fvSEx0sMB/+UCfsJp945ZAkZ2EG/NNI5o2u9kA56685shJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674552399;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dnf5OxTqtwRZWHfDL5Y82HKCbs6WMuRg4L9/vFsyM8Y=;
        b=H5P8b/GP0H6ncGrHgxgj2PV6124neGd1BAPsBm1boJRlrZUmBeNWiIoOW0ssFM+p42GPwn
        i0H6LQuNox7HbhBg==
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Replace smp_call_function_many() with
 on_each_cpu_mask()
Cc:     Babu Moger <babu.moger@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230113152039.770054-2-babu.moger@amd.com>
References: <20230113152039.770054-2-babu.moger@amd.com>
MIME-Version: 1.0
Message-ID: <167455239862.4906.1148088040021992069.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     fc3b618c87833e4d258b66acfca3557c49c4fe97
Gitweb:        https://git.kernel.org/tip/fc3b618c87833e4d258b66acfca3557c49c4fe97
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 13 Jan 2023 09:20:27 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 23 Jan 2023 17:38:04 +01:00

x86/resctrl: Replace smp_call_function_many() with on_each_cpu_mask()

on_each_cpu_mask() runs the function on each CPU specified by cpumask,
which may include the local processor.

Replace smp_call_function_many() with on_each_cpu_mask() to simplify
the code.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20230113152039.770054-2-babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 11 ++------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 29 ++++++----------------
 2 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 1df0e32..7eece3d 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -310,7 +310,6 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 	enum resctrl_conf_type t;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
-	int cpu;
 	u32 idx;
 
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
@@ -341,13 +340,9 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 
 	if (cpumask_empty(cpu_mask))
 		goto done;
-	cpu = get_cpu();
-	/* Update resource control msr on this CPU if it's in cpu_mask. */
-	if (cpumask_test_cpu(cpu, cpu_mask))
-		rdt_ctrl_update(&msr_param);
-	/* Update resource control msr on other CPUs. */
-	smp_call_function_many(cpu_mask, rdt_ctrl_update, &msr_param, 1);
-	put_cpu();
+
+	/* Update resource control msr on all the CPUs. */
+	on_each_cpu_mask(cpu_mask, rdt_ctrl_update, &msr_param, 1);
 
 done:
 	free_cpumask_var(cpu_mask);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5993da2..d23fbc4 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -325,12 +325,7 @@ static void update_cpu_closid_rmid(void *info)
 static void
 update_closid_rmid(const struct cpumask *cpu_mask, struct rdtgroup *r)
 {
-	int cpu = get_cpu();
-
-	if (cpumask_test_cpu(cpu, cpu_mask))
-		update_cpu_closid_rmid(r);
-	smp_call_function_many(cpu_mask, update_cpu_closid_rmid, r, 1);
-	put_cpu();
+	on_each_cpu_mask(cpu_mask, update_cpu_closid_rmid, r, 1);
 }
 
 static int cpus_mon_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
@@ -1866,13 +1861,9 @@ static int set_cache_qos_cfg(int level, bool enable)
 			/* Pick one CPU from each domain instance to update MSR */
 			cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
 	}
-	cpu = get_cpu();
-	/* Update QOS_CFG MSR on this cpu if it's in cpu_mask. */
-	if (cpumask_test_cpu(cpu, cpu_mask))
-		update(&enable);
-	/* Update QOS_CFG MSR on all other cpus in cpu_mask. */
-	smp_call_function_many(cpu_mask, update, &enable, 1);
-	put_cpu();
+
+	/* Update QOS_CFG MSR on all the CPUs in cpu_mask */
+	on_each_cpu_mask(cpu_mask, update, &enable, 1);
 
 	free_cpumask_var(cpu_mask);
 
@@ -2349,7 +2340,7 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	struct msr_param msr_param;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
-	int i, cpu;
+	int i;
 
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
 		return -ENOMEM;
@@ -2370,13 +2361,9 @@ static int reset_all_ctrls(struct rdt_resource *r)
 		for (i = 0; i < hw_res->num_closid; i++)
 			hw_dom->ctrl_val[i] = r->default_ctrl;
 	}
-	cpu = get_cpu();
-	/* Update CBM on this cpu if it's in cpu_mask. */
-	if (cpumask_test_cpu(cpu, cpu_mask))
-		rdt_ctrl_update(&msr_param);
-	/* Update CBM on all other cpus in cpu_mask. */
-	smp_call_function_many(cpu_mask, rdt_ctrl_update, &msr_param, 1);
-	put_cpu();
+
+	/* Update CBM on all the CPUs in cpu_mask */
+	on_each_cpu_mask(cpu_mask, rdt_ctrl_update, &msr_param, 1);
 
 	free_cpumask_var(cpu_mask);
 
