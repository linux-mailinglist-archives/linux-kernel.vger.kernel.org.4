Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475FC5ED0E6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 01:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiI0XRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 19:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiI0XRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 19:17:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009471129CC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 16:17:00 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7ee329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ee:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 732D21EC0426;
        Wed, 28 Sep 2022 01:16:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664320615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BsS2yAAp8a7eteydGjz/1IIbcCWf8fm6O9bJHVnMIgE=;
        b=MDAqIYvETvvwwVfPadefvCT9E+d7+i9sxLo6dDkj6g/t1gln+Ku8fF14E8fBM8W7T/0vla
        3AR8k+QlxFLx1Uf0QzANuyU5aIlg8QG0tkFNTzBqUsWwqwERemmu96QmVorvJr3SDA8XHU
        b4cizwfQvMC9A+15M/lhgR8yDrnvnbI=
Date:   Wed, 28 Sep 2022 01:16:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
Message-ID: <YzOEYsqM0UEsiFuS@zn.tnic>
References: <20220908084914.21703-1-jgross@suse.com>
 <20220908084914.21703-9-jgross@suse.com>
 <YzIVfj/lvzQrK15Y@zn.tnic>
 <ce8cb1d3-a7d2-7484-26eb-60d3e29fa369@suse.com>
 <YzLMKk4OK9FtjjKQ@zn.tnic>
 <c0872933-e046-0c5e-b63f-861d2d343794@suse.com>
 <YzLcSOS6ZLIoPwBl@zn.tnic>
 <d3cd5c50-24e7-ffba-de2d-cf00400f6e38@suse.com>
 <YzLo9IFDYW1T8BVZ@zn.tnic>
 <314e3bd3-3405-c0c3-225c-646d88cbfb1a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <314e3bd3-3405-c0c3-225c-646d88cbfb1a@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 02:21:17PM +0200, Juergen Gross wrote:
> So replacing the bool with "(system_state != SYSTEM_RUNNING)" is fine
> with you right now? We can later switch that to the "more elegant"
> solution when it shows up.

Ok, I think I have something. And it was staring me straight in the
face but I didn't see it: the MTRR code needs a hotplug notifier. In
that notifier it can do the immediate, i.e., non-delayed init while the
delayed init becomes the default, see below.

And ignore the pr_info debugging gunk pls.

mtrr_ap_init() becomes the notifier callback. It doesn't need to be
called in identify_secondary_cpu() anymore as in the init case that
function doesn't do anything - delayed=true - and in the hotplug case
the notifier runs.

mtrr_aps_init() - "aps" in plural - does the delayed init after all CPUs
have been brought online after the box has booted. That might need some
renaming.

And yes, there's a lot more to cleanup after this. This code has grown
wart after wart over the years...

Fun.

---
diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 76d726074c16..1a3dad244bba 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -42,8 +42,6 @@ extern int mtrr_add_page(unsigned long base, unsigned long size,
 extern int mtrr_del(int reg, unsigned long base, unsigned long size);
 extern int mtrr_del_page(int reg, unsigned long base, unsigned long size);
 extern void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi);
-extern void mtrr_ap_init(void);
-extern void set_mtrr_aps_delayed_init(void);
 extern void mtrr_aps_init(void);
 extern void mtrr_bp_restore(void);
 extern int mtrr_trim_uncached_memory(unsigned long end_pfn);
@@ -83,8 +81,6 @@ static inline int mtrr_trim_uncached_memory(unsigned long end_pfn)
 static inline void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi)
 {
 }
-#define mtrr_ap_init() do {} while (0)
-#define set_mtrr_aps_delayed_init() do {} while (0)
 #define mtrr_aps_init() do {} while (0)
 #define mtrr_bp_restore() do {} while (0)
 #  endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3e508f239098..deef1b5b27cc 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1948,7 +1948,6 @@ void identify_secondary_cpu(struct cpuinfo_x86 *c)
 #ifdef CONFIG_X86_32
 	enable_sep_cpu();
 #endif
-	mtrr_ap_init();
 	validate_apic_and_package_id(c);
 	x86_spec_ctrl_setup_ap();
 	update_srbds_msr();
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 2746cac9d8a9..abbf7cb8a430 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -69,7 +69,6 @@ unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
 static DEFINE_MUTEX(mtrr_mutex);
 
 u64 size_or_mask, size_and_mask;
-static bool mtrr_aps_delayed_init;
 
 static const struct mtrr_ops *mtrr_ops[X86_VENDOR_NUM] __ro_after_init;
 
@@ -176,7 +175,7 @@ static int mtrr_rendezvous_handler(void *info)
 	if (data->smp_reg != ~0U) {
 		mtrr_if->set(data->smp_reg, data->smp_base,
 			     data->smp_size, data->smp_type);
-	} else if (mtrr_aps_delayed_init || !cpu_online(smp_processor_id())) {
+	} else if (!cpu_online(smp_processor_id())) {
 		mtrr_if->set_all();
 	}
 	return 0;
@@ -784,13 +783,16 @@ void __init mtrr_bp_init(void)
 	}
 }
 
-void mtrr_ap_init(void)
+static int mtrr_ap_init(unsigned int cpu)
 {
+	pr_info("%s: single AP entry, use_intel: %d, mtrr_enabled: %d, mtrr_aps_delayed_init\n",
+		__func__, use_intel(), mtrr_enabled());
+
 	if (!mtrr_enabled())
-		return;
+		return 1;
 
-	if (!use_intel() || mtrr_aps_delayed_init)
-		return;
+	if (!use_intel())
+		return 1;
 
 	/*
 	 * Ideally we should hold mtrr_mutex here to avoid mtrr entries
@@ -806,6 +808,8 @@ void mtrr_ap_init(void)
 	 *      lock to prevent mtrr entry changes
 	 */
 	set_mtrr_from_inactive_cpu(~0U, 0, 0, 0);
+
+	return 0;
 }
 
 /**
@@ -820,37 +824,24 @@ void mtrr_save_state(void)
 		return;
 
 	first_cpu = cpumask_first(cpu_online_mask);
-	smp_call_function_single(first_cpu, mtrr_save_fixed_ranges, NULL, 1);
-}
 
-void set_mtrr_aps_delayed_init(void)
-{
-	if (!mtrr_enabled())
-		return;
-	if (!use_intel())
-		return;
+	pr_info("%s: first_cpu: %d\n", __func__, first_cpu);
 
-	mtrr_aps_delayed_init = true;
+	smp_call_function_single(first_cpu, mtrr_save_fixed_ranges, NULL, 1);
 }
 
 /*
- * Delayed MTRR initialization for all AP's
+ * Delayed MTRR initialization for all APs
  */
 void mtrr_aps_init(void)
 {
-	if (!use_intel() || !mtrr_enabled())
-		return;
+	pr_info("%s: entry, use_intel: %d, mtrr_enabled: %d, mtrr_aps_delayed_init\n",
+		__func__, use_intel(), mtrr_enabled());
 
-	/*
-	 * Check if someone has requested the delay of AP MTRR initialization,
-	 * by doing set_mtrr_aps_delayed_init(), prior to this point. If not,
-	 * then we are done.
-	 */
-	if (!mtrr_aps_delayed_init)
+	if (!use_intel() || !mtrr_enabled())
 		return;
 
 	set_mtrr(~0U, 0, 0, 0);
-	mtrr_aps_delayed_init = false;
 }
 
 void mtrr_bp_restore(void)
@@ -869,6 +860,10 @@ static int __init mtrr_init_finialize(void)
 	if (use_intel()) {
 		if (!changed_by_mtrr_cleanup)
 			mtrr_state_warn();
+
+		cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "x86/mtrr:online",
+				  mtrr_ap_init, NULL);
+
 		return 0;
 	}
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index f24227bc3220..171acef35201 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1428,7 +1428,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 
 	uv_system_init();
 
-	set_mtrr_aps_delayed_init();
+	pr_info("%s: set_mtrr_aps_delayed_init\n", __func__);
 
 	smp_quirk_init_udelay();
 
@@ -1439,7 +1439,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 
 void arch_thaw_secondary_cpus_begin(void)
 {
-	set_mtrr_aps_delayed_init();
+	pr_info("%s: set_mtrr_aps_delayed_init\n", __func__);
 }
 
 void arch_thaw_secondary_cpus_end(void)
diff --git a/kernel/cpu.c b/kernel/cpu.c
index bbad5e375d3b..fc14601b908c 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -591,6 +591,8 @@ static int bringup_cpu(unsigned int cpu)
 	struct task_struct *idle = idle_thread_get(cpu);
 	int ret;
 
+	pr_info("%s: CPU%d\n", __func__, cpu);
+
 	/*
 	 * Reset stale stack state from the last time this CPU was online.
 	 */


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
