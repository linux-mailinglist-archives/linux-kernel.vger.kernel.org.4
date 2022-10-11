Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79B35FBBFC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 22:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJKUTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 16:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJKUTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:19:46 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A13B7E6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:19:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b4so23321001wrs.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lGWehY1Bm3rplFUyH6FrKkjNWDXGbkL//Be8lZY1fww=;
        b=Nrul0TCKLW5gUjM2Y+IfAlVUWxJl7AZTAUzUqDXpwWashk57TDhBB6Dc08RrBixYbJ
         Qm+iEcCn0BuOdbGFmvrtOWhKWYQQ4F7XayotOqMK/0RwhOUnG3ziqRSiAAbKPRTICdyL
         LXHATmftG+oEvlZFxBDX7DYMbM9uln+9syympkjRFiArLBJbLufOHsXqMQSN/ci7eJEy
         QugBZqNO8EvjV6ccVY5O5GCZ+uAJt7PeqzLhMPMbUUSDEnZ6mZ98EkS/dJ45JhmIYUtL
         fWJ0Zi0RNXi/9gjZGi+cgRhncHd8YK2vZdUyeJNF5KoanZ2BEmJzkfBy9FNbvwJLqTQV
         k9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGWehY1Bm3rplFUyH6FrKkjNWDXGbkL//Be8lZY1fww=;
        b=Etv4tzjzYe6CnqLGj1pAprPStY6gYwKlkOwkc8oat6FteSlfsMtJhaceBwAL3NyJS3
         A9+7LnSQJSMH17SW/Kg/SImgEHX3nZ9m4HbQNSfE/uFonKSurcdD0PeF6eI9qUQvqUyk
         by4R2sd4rCnl6DN7XtolI1wRXCAFHAbc5CGC+otkjuF2/Kv6kjYAglgCLZKnKaORZ2CP
         je9BViHsHhU4woyQaNnWO7K2PNzHbv17D2HWKIT/MR5w8zWx5giujH65Jj7vVwgme5Jq
         /5uajhvGMgu+myWWSU9idpmhBdm0Z+aOKn4B9nnhE+e/HIR89MEyNLniRpdeB6AjCfL3
         AdKw==
X-Gm-Message-State: ACrzQf1QATcPJ2UnnLvuD97/uPwljuANil9rQapTHtJsbNSSMeGU6n04
        Usdt1z88w1pglehvw+iH9g==
X-Google-Smtp-Source: AMsMyM4eLHTh94prq8SYudLaqoFSacqojkJKB7SenaCa/aD/pevZZjABLXCSqlbyKU/q/JFr5/hpvQ==
X-Received: by 2002:a05:6000:1212:b0:22e:65ae:b390 with SMTP id e18-20020a056000121200b0022e65aeb390mr16243527wrx.680.1665519581618;
        Tue, 11 Oct 2022 13:19:41 -0700 (PDT)
Received: from localhost.localdomain ([46.53.252.4])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c4f0200b003a682354f63sm21556680wmq.11.2022.10.11.13.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 13:19:41 -0700 (PDT)
Date:   Tue, 11 Oct 2022 23:19:39 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2 -tip] x86: add and use cpu_is_amd() wrapper
Message-ID: <Y0XP23d9L/7V2zaf@localhost.localdomain>
References: <Y0XPSlDqAlpnLMoB@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0XPSlDqAlpnLMoB@localhost.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is small, easy to remember function name.

Don't bother with 32-bit CPU vendors.
If someone wants to add Hygon, be my guest.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/events/amd/uncore.c              |    2 +-
 arch/x86/include/asm/acpi.h               |    2 +-
 arch/x86/include/asm/amd_nb.h             |    2 +-
 arch/x86/include/asm/geode.h              |    2 +-
 arch/x86/include/asm/processor.h          |    5 +++++
 arch/x86/include/asm/virtext.h            |    2 +-
 arch/x86/kernel/acpi/cppc.c               |    2 +-
 arch/x86/kernel/amd_nb.c                  |    4 ++--
 arch/x86/kernel/apic/apic.c               |    4 ++--
 arch/x86/kernel/cpu/bugs.c                |    8 ++++----
 arch/x86/kernel/cpu/cacheinfo.c           |    2 +-
 arch/x86/kernel/cpu/mce/core.c            |    4 ++--
 arch/x86/kernel/cpu/mce/dev-mcelog.c      |    2 +-
 arch/x86/kernel/cpu/mce/severity.c        |    2 +-
 arch/x86/kernel/cpu/mtrr/cleanup.c        |    2 +-
 arch/x86/kernel/cpu/mtrr/generic.c        |    2 +-
 arch/x86/kernel/cpu/resctrl/core.c        |    4 ++--
 arch/x86/kernel/smpboot.c                 |    4 ++--
 arch/x86/mm/fault.c                       |    2 +-
 arch/x86/pci/amd_bus.c                    |    2 +-
 arch/x86/xen/pmu.c                        |    2 +-
 drivers/acpi/processor_perflib.c          |    2 +-
 drivers/acpi/x86/s2idle.c                 |    2 +-
 drivers/cpufreq/acpi-cpufreq.c            |    6 +++---
 drivers/cpufreq/amd-pstate.c              |    2 +-
 drivers/cpufreq/amd_freq_sensitivity.c    |    2 +-
 drivers/infiniband/hw/qib/qib_wc_x86_64.c |    2 +-
 drivers/mtd/nand/raw/cs553x_nand.c        |    2 +-
 drivers/platform/x86/amd/hsmp.c           |    2 +-
 drivers/platform/x86/thinkpad_acpi.c      |    2 +-
 drivers/rtc/rtc-mc146818-lib.c            |    2 +-
 31 files changed, 45 insertions(+), 40 deletions(-)

--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -649,7 +649,7 @@ static int __init amd_uncore_init(void)
 	union cpuid_0x80000022_ebx ebx;
 	int ret = -ENODEV;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	if (!cpu_is_amd() &&
 	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return -ENODEV;
 
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -75,7 +75,7 @@ static inline unsigned int acpi_processor_cstate_check(unsigned int max_cstate)
 	 * Steppings 0x0A and later are good
 	 */
 	if (boot_cpu_data.x86 == 0x0F &&
-	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
+	    cpu_is_amd() &&
 	    boot_cpu_data.x86_model <= 0x05 &&
 	    boot_cpu_data.x86_stepping < 0x0A)
 		return 1;
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -101,7 +101,7 @@ static inline u16 amd_pci_dev_to_node_id(struct pci_dev *pdev)
 
 static inline bool amd_gart_present(void)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (!cpu_is_amd())
 		return false;
 
 	/* GART present only on Fam15h, upto model 0fh */
--- a/arch/x86/include/asm/geode.h
+++ b/arch/x86/include/asm/geode.h
@@ -20,7 +20,7 @@ static inline int is_geode_gx(void)
 
 static inline int is_geode_lx(void)
 {
-	return ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
+	return (cpu_is_amd() &&
 		(boot_cpu_data.x86 == 5) &&
 		(boot_cpu_data.x86_model == 10));
 }
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -182,6 +182,11 @@ static inline bool cpu_is_intel(void)
 	return boot_cpu_data.x86_vendor == X86_VENDOR_INTEL;
 }
 
+static inline bool cpu_is_amd(void)
+{
+	return boot_cpu_data.x86_vendor == X86_VENDOR_AMD;
+}
+
 extern __u32			cpu_caps_cleared[NCAPINTS + NBUGINTS];
 extern __u32			cpu_caps_set[NCAPINTS + NBUGINTS];
 
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -94,7 +94,7 @@ static inline void cpu_emergency_vmxoff(void)
  */
 static inline int cpu_has_svm(const char **msg)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	if (!cpu_is_amd() &&
 	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON) {
 		if (msg)
 			*msg = "not amd or hygon";
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -107,7 +107,7 @@ void init_freq_invariance_cppc(void)
 	if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
 		return;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (!cpu_is_amd())
 		return;
 
 	mutex_lock(&freq_invariance_lock);
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -314,7 +314,7 @@ bool __init early_is_amd_nb(u32 device)
 	const struct pci_device_id *id;
 	u32 vendor = device & 0xffff;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	if (!cpu_is_amd() &&
 	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return false;
 
@@ -334,7 +334,7 @@ struct resource *amd_get_mmconfig_range(struct resource *res)
 	u64 base, msr;
 	unsigned int segn_busn_bits;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	if (!cpu_is_amd() &&
 	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return NULL;
 
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -227,7 +227,7 @@ static inline int lapic_is_integrated(void)
 static int modern_apic(void)
 {
 	/* AMD systems use old APIC versions, so check the CPU */
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
+	if (cpu_is_amd() &&
 	    boot_cpu_data.x86 >= 0xf)
 		return 1;
 
@@ -1279,7 +1279,7 @@ void __init sync_Arb_IDs(void)
 	 * Unsupported on P4 - see Intel Dev. Manual Vol. 3, Ch. 8.6.1 And not
 	 * needed on AMD.
 	 */
-	if (modern_apic() || boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	if (modern_apic() || cpu_is_amd())
 		return;
 
 	/*
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -882,7 +882,7 @@ static void __init retbleed_select_mitigation(void)
 do_cmd_auto:
 	case RETBLEED_CMD_AUTO:
 	default:
-		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+		if (cpu_is_amd() ||
 		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
 			if (IS_ENABLED(CONFIG_CPU_UNRET_ENTRY))
 				retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
@@ -904,7 +904,7 @@ static void __init retbleed_select_mitigation(void)
 		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
 		setup_force_cpu_cap(X86_FEATURE_UNRET);
 
-		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+		if (!cpu_is_amd() &&
 		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 			pr_err(RETBLEED_UNTRAIN_MSG);
 
@@ -1551,7 +1551,7 @@ static void __init spectre_v2_select_mitigation(void)
 	 */
 	if (boot_cpu_has_bug(X86_BUG_RETBLEED) &&
 	    boot_cpu_has(X86_FEATURE_IBPB) &&
-	    (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    (cpu_is_amd() ||
 	     boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)) {
 
 		if (retbleed_cmd != RETBLEED_CMD_IBPB) {
@@ -2369,7 +2369,7 @@ static ssize_t retbleed_show_state(char *buf)
 {
 	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET ||
 	    retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
-	    if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    if (!cpu_is_amd() &&
 		boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		    return sprintf(buf, "Vulnerable: untrained return thunk / IBPB on non-AMD based uarch\n");
 
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -603,7 +603,7 @@ cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *this_leaf)
 	union _cpuid4_leaf_ecx	ecx;
 	unsigned		edx;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+	if (cpu_is_amd()) {
 		if (boot_cpu_has(X86_FEATURE_TOPOEXT))
 			cpuid_count(0x8000001d, index, &eax.full,
 				    &ebx.full, &ecx.full, &edx);
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2064,7 +2064,7 @@ static void __mcheck_cpu_init_timer(void)
 
 bool filter_mce(struct mce *m)
 {
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	if (cpu_is_amd())
 		return amd_filter_mce(m);
 	if (cpu_is_intel())
 		return intel_filter_mce(m);
@@ -2311,7 +2311,7 @@ static void vendor_disable_error_reporting(void)
 	 */
 	if (cpu_is_intel() ||
 	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ||
-	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    cpu_is_amd() ||
 	    boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN)
 		return;
 
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -67,7 +67,7 @@ static int dev_mce_log(struct notifier_block *nb, unsigned long val,
 unlock:
 	mutex_unlock(&mce_chrdev_read_mutex);
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (!cpu_is_amd())
 		mce->kflags |= MCE_HANDLED_MCELOG;
 
 	return NOTIFY_OK;
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -400,7 +400,7 @@ static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs, char
 
 int noinstr mce_severity(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
 {
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	if (cpu_is_amd() ||
 	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		return mce_severity_amd(m, regs, msg, is_excp);
 	else
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -830,7 +830,7 @@ int __init amd_special_default_mtrr(void)
 {
 	u32 l, h;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	if (!cpu_is_amd() &&
 	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return 0;
 	if (boot_cpu_data.x86 < 0xf)
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -49,7 +49,7 @@ static inline void k8_check_syscfg_dram_mod_en(void)
 {
 	u32 lo, hi;
 
-	if (!((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
+	if (!(cpu_is_amd() &&
 	      (boot_cpu_data.x86 >= 0x0f)))
 		return;
 
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -734,7 +734,7 @@ static __init bool get_mem_config(void)
 
 	if (cpu_is_intel())
 		return __get_mem_config_intel(&hw_res->r_resctrl);
-	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	else if (cpu_is_amd())
 		return __rdt_get_mem_config_amd(&hw_res->r_resctrl);
 
 	return false;
@@ -867,7 +867,7 @@ static __init void rdt_init_res_defs(void)
 {
 	if (cpu_is_intel())
 		rdt_init_res_defs_intel();
-	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	else if (cpu_is_amd())
 		rdt_init_res_defs_amd();
 }
 
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -779,7 +779,7 @@ static void __init smp_quirk_init_udelay(void)
 	/* if modern processor, use no delay */
 	if ((cpu_is_intel() && (boot_cpu_data.x86 == 6)) ||
 	    ((boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) && (boot_cpu_data.x86 >= 0x18)) ||
-	    ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) && (boot_cpu_data.x86 >= 0xF))) {
+	    (cpu_is_amd() && (boot_cpu_data.x86 >= 0xF))) {
 		init_udelay = 0;
 		return;
 	}
@@ -1752,7 +1752,7 @@ static inline void mwait_play_dead(void)
 	void *mwait_ptr;
 	int i;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	if (cpu_is_amd() ||
 	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		return;
 	if (!this_cpu_has(X86_FEATURE_MWAIT))
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -438,7 +438,7 @@ static void dump_pagetable(unsigned long address)
 static int is_errata93(struct pt_regs *regs, unsigned long address)
 {
 #if defined(CONFIG_X86_64) && defined(CONFIG_CPU_SUP_AMD)
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD
+	if (!cpu_is_amd()
 	    || boot_cpu_data.x86 != 0xf)
 		return 0;
 
--- a/arch/x86/pci/amd_bus.c
+++ b/arch/x86/pci/amd_bus.c
@@ -391,7 +391,7 @@ static int __init pci_io_ecs_init(void)
 
 static int __init amd_postcore_init(void)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	if (!cpu_is_amd() &&
 	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return 0;
 
--- a/arch/x86/xen/pmu.c
+++ b/arch/x86/xen/pmu.c
@@ -69,7 +69,7 @@ static __read_mostly int intel_num_arch_counters, intel_num_fixed_counters;
 
 static void xen_pmu_arch_init(void)
 {
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+	if (cpu_is_amd()) {
 
 		switch (boot_cpu_data.x86) {
 		case 0x15:
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -257,7 +257,7 @@ static void amd_fixup_frequency(struct acpi_processor_px *px, int i)
 	u32 hi, lo, fid, did;
 	int index = px->control & 0x00000007;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (!cpu_is_amd())
 		return;
 
 	if ((boot_cpu_data.x86 == 0x10 && boot_cpu_data.x86_model < 10)
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -341,7 +341,7 @@ static void acpi_sleep_run_lps0_dsm(unsigned int func, unsigned int func_mask, g
 
 static bool acpi_s2idle_vendor_amd(void)
 {
-	return boot_cpu_data.x86_vendor == X86_VENDOR_AMD;
+	return cpu_is_amd();
 }
 
 static int validate_dsm(acpi_handle handle, const char *uuid, int rev, guid_t *dsm_guid)
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -217,7 +217,7 @@ static unsigned extract_msr(struct cpufreq_policy *policy, u32 msr)
 	struct cpufreq_frequency_table *pos;
 	struct acpi_processor_performance *perf;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	if (cpu_is_amd())
 		msr &= AMD_MSR_RANGE;
 	else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		msr &= HYGON_MSR_RANGE;
@@ -651,7 +651,7 @@ static u64 get_max_boost_ratio(unsigned int cpu)
 		return 0;
 	}
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	if (cpu_is_amd())
 		highest_perf = amd_get_highest_perf();
 	else
 		highest_perf = perf_caps.highest_perf;
@@ -763,7 +763,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	switch (perf->control_register.space_id) {
 	case ACPI_ADR_SPACE_SYSTEM_IO:
-		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
+		if (cpu_is_amd() &&
 		    boot_cpu_data.x86 == 0xf) {
 			pr_debug("AMD K8 systems must use native drivers.\n");
 			result = -ENODEV;
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -614,7 +614,7 @@ static int __init amd_pstate_init(void)
 {
 	int ret;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (!cpu_is_amd())
 		return -ENODEV;
 
 	if (!acpi_cpc_valid()) {
--- a/drivers/cpufreq/amd_freq_sensitivity.c
+++ b/drivers/cpufreq/amd_freq_sensitivity.c
@@ -112,7 +112,7 @@ static int __init amd_freq_sensitivity_init(void)
 	struct pci_dev *pcidev;
 	unsigned int pci_vendor;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	if (cpu_is_amd())
 		pci_vendor = PCI_VENDOR_ID_AMD;
 	else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		pci_vendor = PCI_VENDOR_ID_HYGON;
--- a/drivers/infiniband/hw/qib/qib_wc_x86_64.c
+++ b/drivers/infiniband/hw/qib/qib_wc_x86_64.c
@@ -146,5 +146,5 @@ void qib_disable_wc(struct qib_devdata *dd)
  */
 int qib_unordered_wc(void)
 {
-	return boot_cpu_data.x86_vendor != X86_VENDOR_AMD;
+	return !cpu_is_amd();
 }
--- a/drivers/mtd/nand/raw/cs553x_nand.c
+++ b/drivers/mtd/nand/raw/cs553x_nand.c
@@ -326,7 +326,7 @@ static int __init cs553x_init_one(int cs, int mmio, unsigned long adr)
 static int is_geode(void)
 {
 	/* These are the CPUs which will have a CS553[56] companion chip */
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
+	if (cpu_is_amd() &&
 	    boot_cpu_data.x86 == 5 &&
 	    boot_cpu_data.x86_model == 10)
 		return 1; /* Geode LX */
--- a/drivers/platform/x86/amd/hsmp.c
+++ b/drivers/platform/x86/amd/hsmp.c
@@ -363,7 +363,7 @@ static int __init hsmp_plt_init(void)
 	u16 num_sockets;
 	int i;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD || boot_cpu_data.x86 < 0x19) {
+	if (!cpu_is_amd() || boot_cpu_data.x86 < 0x19) {
 		pr_err("HSMP is not supported on Family:%x model:%x\n",
 		       boot_cpu_data.x86, boot_cpu_data.x86_model);
 		return ret;
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10567,7 +10567,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 		}
 	} else if (dytc_capabilities & BIT(DYTC_FC_PSC)) { /* PSC MODE */
 		/* Support for this only works on AMD platforms */
-		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
+		if (!cpu_is_amd()) {
 			dbg_printk(TPACPI_DBG_INIT, "PSC not support on Intel platforms\n");
 			return -ENODEV;
 		}
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -180,7 +180,7 @@ EXPORT_SYMBOL_GPL(mc146818_get_time);
 static bool apply_amd_register_a_behavior(void)
 {
 #ifdef CONFIG_X86
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	if (cpu_is_amd() ||
 	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		return true;
 #endif
