Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FF45EDA60
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiI1Ksn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbiI1Ksi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:48:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514EAACA0F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 03:48:37 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7ee329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ee:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B47101EC0576;
        Wed, 28 Sep 2022 12:48:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664362111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+FjFc+W0rnawZ+U2ZgyBD+QjFQbz7q8G3FqZ2msSnSQ=;
        b=HQZ3JES2YaWgiRYy36DiLeVqjOXJOHZdjiQN9UU3tQ9xM+RGF1wfzc0x8X2B7dXcSC66Fw
        E+L9vpk/MBaDR6QXaZ19OC6tMA8Y6qjTZMC+Pb0bMH1TPlkPzflgq4bqnmgfcStxxxTY5b
        66nDyM2K/OZefricc6GQCNO/gOkXE38=
Date:   Wed, 28 Sep 2022 12:48:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 08/10] x86/mtrr: let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
Message-ID: <YzQmeh50ne8dyR2P@zn.tnic>
References: <ce8cb1d3-a7d2-7484-26eb-60d3e29fa369@suse.com>
 <YzLMKk4OK9FtjjKQ@zn.tnic>
 <c0872933-e046-0c5e-b63f-861d2d343794@suse.com>
 <YzLcSOS6ZLIoPwBl@zn.tnic>
 <d3cd5c50-24e7-ffba-de2d-cf00400f6e38@suse.com>
 <YzLo9IFDYW1T8BVZ@zn.tnic>
 <314e3bd3-3405-c0c3-225c-646d88cbfb1a@suse.com>
 <YzOEYsqM0UEsiFuS@zn.tnic>
 <73d8fabd-8b93-2e65-da4b-ea509818e666@suse.com>
 <24088a15-50a1-f818-8c3e-6010925bffbf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24088a15-50a1-f818-8c3e-6010925bffbf@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 08:16:53AM +0200, Juergen Gross wrote:
> > Are sure the hotplug notifier doesn't get called in the boot and in the

It doesn't because it gets registered after smp_init()...

> > resume cases?

... but it gets called during resume because by that time the notifier
has been registered already. See my notes at the end of this mail of
what the code does currently.

> In case my suspicion is correct: this can still be solved by adding the
> hotplug notifier only in mtrr_aps_init(), and removing it again in
> arch_thaw_secondary_cpus_begin().

Pretty much. Yeah, we still need a bool. ;-(

But that bool has a much smaller scope and it is perfectly clear what it
does. And I've added a comment. Could've used comments for the delayed
init thing.

Anyway, it gets set in a thaw callback (I mean, might as well, since
we call into the MTRR code anyway). I probably can make this even
cleaner and not do any bool if I could query in the notifier whether I'm
resuming...

Thx.

---
diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 76d726074c16..86b8009d2429 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -42,9 +42,8 @@ extern int mtrr_add_page(unsigned long base, unsigned long size,
 extern int mtrr_del(int reg, unsigned long base, unsigned long size);
 extern int mtrr_del_page(int reg, unsigned long base, unsigned long size);
 extern void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi);
-extern void mtrr_ap_init(void);
-extern void set_mtrr_aps_delayed_init(void);
 extern void mtrr_aps_init(void);
+extern void mtrr_aps_thaw(void);
 extern void mtrr_bp_restore(void);
 extern int mtrr_trim_uncached_memory(unsigned long end_pfn);
 extern int amd_special_default_mtrr(void);
@@ -83,9 +82,8 @@ static inline int mtrr_trim_uncached_memory(unsigned long end_pfn)
 static inline void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi)
 {
 }
-#define mtrr_ap_init() do {} while (0)
-#define set_mtrr_aps_delayed_init() do {} while (0)
 #define mtrr_aps_init() do {} while (0)
+#define mtrr_aps_thaw() do {} while (0)
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
index 2746cac9d8a9..c4089fd2b477 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -69,7 +69,7 @@ unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
 static DEFINE_MUTEX(mtrr_mutex);
 
 u64 size_or_mask, size_and_mask;
-static bool mtrr_aps_delayed_init;
+static bool ap_notifier_disabled;
 
 static const struct mtrr_ops *mtrr_ops[X86_VENDOR_NUM] __ro_after_init;
 
@@ -176,7 +176,7 @@ static int mtrr_rendezvous_handler(void *info)
 	if (data->smp_reg != ~0U) {
 		mtrr_if->set(data->smp_reg, data->smp_base,
 			     data->smp_size, data->smp_type);
-	} else if (mtrr_aps_delayed_init || !cpu_online(smp_processor_id())) {
+	} else if (!cpu_online(smp_processor_id())) {
 		mtrr_if->set_all();
 	}
 	return 0;
@@ -784,13 +784,16 @@ void __init mtrr_bp_init(void)
 	}
 }
 
-void mtrr_ap_init(void)
+static int mtrr_ap_init(unsigned int cpu)
 {
 	if (!mtrr_enabled())
-		return;
+		return 1;
 
-	if (!use_intel() || mtrr_aps_delayed_init)
-		return;
+	if (!use_intel())
+		return 1;
+
+	if (ap_notifier_disabled)
+		return 0;
 
 	/*
 	 * Ideally we should hold mtrr_mutex here to avoid mtrr entries
@@ -806,6 +809,8 @@ void mtrr_ap_init(void)
 	 *      lock to prevent mtrr entry changes
 	 */
 	set_mtrr_from_inactive_cpu(~0U, 0, 0, 0);
+
+	return 0;
 }
 
 /**
@@ -823,34 +828,26 @@ void mtrr_save_state(void)
 	smp_call_function_single(first_cpu, mtrr_save_fixed_ranges, NULL, 1);
 }
 
-void set_mtrr_aps_delayed_init(void)
-{
-	if (!mtrr_enabled())
-		return;
-	if (!use_intel())
-		return;
-
-	mtrr_aps_delayed_init = true;
-}
-
 /*
- * Delayed MTRR initialization for all AP's
+ * Delayed MTRR initialization for all APs
  */
 void mtrr_aps_init(void)
 {
 	if (!use_intel() || !mtrr_enabled())
 		return;
 
-	/*
-	 * Check if someone has requested the delay of AP MTRR initialization,
-	 * by doing set_mtrr_aps_delayed_init(), prior to this point. If not,
-	 * then we are done.
-	 */
-	if (!mtrr_aps_delayed_init)
-		return;
-
 	set_mtrr(~0U, 0, 0, 0);
-	mtrr_aps_delayed_init = false;
+	ap_notifier_disabled = false;
+}
+
+/*
+ * Disable the AP notifier temporarily during resume. It is supposed to be active only
+ * during CPU hotplug as during resume mtrr_aps_init() takes care of the MTRR
+ * programming on all CPUs.
+ */
+void mtrr_aps_thaw(void)
+{
+	ap_notifier_disabled = true;
 }
 
 void mtrr_bp_restore(void)
@@ -869,6 +866,10 @@ static int __init mtrr_init_finialize(void)
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
index f24227bc3220..b90780dab88a 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1428,8 +1428,6 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 
 	uv_system_init();
 
-	set_mtrr_aps_delayed_init();
-
 	smp_quirk_init_udelay();
 
 	speculative_store_bypass_ht_init();
@@ -1439,7 +1437,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 
 void arch_thaw_secondary_cpus_begin(void)
 {
-	set_mtrr_aps_delayed_init();
+	mtrr_aps_thaw();
 }
 
 void arch_thaw_secondary_cpus_end(void)


Notes:
------

Boot sequence:

BSP:

[    0.272801] smpboot: native_smp_prepare_cpus: set_mtrr_aps_delayed_init

APs:

[    0.287190] mtrr_save_state: first_cpu: 0
[    0.287724] x86: Booting SMP configuration:
[    0.290292] .... node  #0, CPUs:        #1
[    0.061135] mtrr_ap_init: single AP entry, use_intel: 1, mtrr_enabled: 1, mtrr_aps_delayed_init: 1

 -> set_mtrr_from_inactive_cpu() gets skipped.

After all APs booted:

[    1.544506] mtrr_aps_init: entry, use_intel: 1, mtrr_enabled: 1, mtrr_aps_delayed_init: 1

 -> set_mtrr()

hotplug:

[  206.112651] smpboot: CPU 11 is now offline
[  208.286030] bringup_cpu: CPU11
[  208.286611] mtrr_save_state: first_cpu: 0
[  208.287416] smpboot: Booting Node 0 Processor 11 APIC 0xb
[  206.116567] mtrr_ap_init: single AP entry, use_intel: 1, mtrr_enabled: 1, mtrr_aps_delayed_init: 0

 -> set_mtrr_from_inactive_cpu()

suspend/resume:

BSP:

[  270.586643] smpboot: arch_thaw_secondary_cpus_begin: set_mtrr_aps_delayed_init

APs:

[  270.587947] bringup_cpu: CPU1
[  270.588470] mtrr_save_state: first_cpu: 0
[  270.589207] x86: Booting SMP configuration:
[  270.597971] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  270.530418] mtrr_ap_init: single AP entry, use_intel: 1, mtrr_enabled: 1, mtrr_aps_delayed_init: 1

After all APs booted:

[  270.694168] mtrr_aps_init: entry, use_intel: 1, mtrr_enabled: 1, mtrr_aps_delayed_init: 1
[  270.696923] ACPI: PM: Waking up from system sleep state S3


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
