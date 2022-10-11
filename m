Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBFC5FBBF0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 22:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiJKURY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 16:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJKURU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:17:20 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6261D67E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:17:18 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bu30so23276261wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ISGhn1RSIhURyXNv3DIvSbByTdA4CCXdQhV2IG/mEvQ=;
        b=i659YlohZqhjCiiHSCEAQEpkl4MSjGXBoieF73wskNRw4O6C0bN1ilr97qeba+E4Ed
         aFxtN3NH/1By7SCaZFI67exDUH1/H6Hxig49s90ER6zHRl1NmfaRTWw4GcKKeKznNoLp
         mu+T84G26+Iu4JpY46Qz74dFtwo1955ybIHvDdqxZLt5DLLrPbIK67d44Id5oDybWnw8
         pLQ47HQt58ThpxP/kUWIr2Dwjtwq5cOtwET3v+Wan1EXd/S2UMUGSnvZ8RW10mBCcRmN
         0JjaQBMZjkxsjgqf3pbgAYl5E9plQCrbSkr93MSbeCU8zDBZLBai4sUrusKWqa/cCdEo
         Za8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ISGhn1RSIhURyXNv3DIvSbByTdA4CCXdQhV2IG/mEvQ=;
        b=Q0ETpCRCLpMdh9vzOR50z5NS7LeKsNk5qlLYpKECG4Y2TytDtFp70/2h3dWlRDNQph
         1lVU7qItyTIXs4w1ZlvyNJ4b9yt6Bw/uxDZ1iFDaXR7FGbE5FOwRzK8Twgt1NT2bfDBW
         1cuGKp9lujxowBcWoUcKQd2vEu77YZJJnhzlgqnFPSucgEaQ3dfVpVmJ7kXLgYJ4o6Xg
         1xzHz6Wh6A3cIpux0hVRmuAwZ2zYeKGTLwDVRWfYSPOxx/0hJz1RZGu0NycUXfF6jEDU
         w57EDAL1hWWb1v5Xcyk8p7FI3De9b1N1gEsrMfkZfBFw74DVBpMiblHfIbnaemgpet7K
         lTZw==
X-Gm-Message-State: ACrzQf3/rRK27PrEratUQ8002Z3MS+PFNE09QC+BgC+gVkHeYx2nSwOe
        JGdFkrOH2CjLYI9aKxoFBg==
X-Google-Smtp-Source: AMsMyM6VMMQ4fN2s8fNsig0Hv6tuLQ6zwbF12uLjSY18xTsl1eBbUFo1oDkxX1/JPTNIQyZkiEPeFw==
X-Received: by 2002:a5d:456b:0:b0:230:9e5b:c64c with SMTP id a11-20020a5d456b000000b002309e5bc64cmr7553904wrc.211.1665519436941;
        Tue, 11 Oct 2022 13:17:16 -0700 (PDT)
Received: from localhost.localdomain ([46.53.252.4])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d444f000000b0022e035a4e93sm11724756wrr.87.2022.10.11.13.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 13:17:16 -0700 (PDT)
Date:   Tue, 11 Oct 2022 23:17:14 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, adobriyan@gmail.com
Subject: [PATCH 1/2 -tip] x86: add and use cpu_is_intel() wrapper
Message-ID: <Y0XPSlDqAlpnLMoB@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I realised that writing

	boot_cpu_data.x86_vendor == X86_VENDOR_INTEL

is simply too much.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/crypto/blowfish_glue.c                                |    2 +-
 arch/x86/crypto/camellia_glue.c                                |    2 +-
 arch/x86/crypto/des3_ede_glue.c                                |    2 +-
 arch/x86/crypto/twofish_glue_3way.c                            |    2 +-
 arch/x86/events/msr.c                                          |    2 +-
 arch/x86/include/asm/processor.h                               |    5 +++++
 arch/x86/kernel/apic/apic.c                                    |    2 +-
 arch/x86/kernel/apic/io_apic.c                                 |    4 ++--
 arch/x86/kernel/cpu/aperfmperf.c                               |    2 +-
 arch/x86/kernel/cpu/bugs.c                                     |    6 +++---
 arch/x86/kernel/cpu/common.c                                   |    2 +-
 arch/x86/kernel/cpu/intel.c                                    |    2 +-
 arch/x86/kernel/cpu/mce/core.c                                 |    6 +++---
 arch/x86/kernel/cpu/mce/intel.c                                |    2 +-
 arch/x86/kernel/cpu/mtrr/mtrr.c                                |    2 +-
 arch/x86/kernel/cpu/resctrl/core.c                             |    6 +++---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c                      |    2 +-
 arch/x86/kernel/hpet.c                                         |    2 +-
 arch/x86/kernel/smpboot.c                                      |    2 +-
 arch/x86/kernel/tsc.c                                          |    6 +++---
 arch/x86/kvm/pmu.h                                             |    4 +---
 arch/x86/mm/cpu_entry_area.c                                   |    2 +-
 arch/x86/xen/pmu.c                                             |    6 +++---
 drivers/acpi/processor_idle.c                                  |    2 +-
 drivers/cpufreq/cpufreq_ondemand.c                             |    2 +-
 drivers/cpufreq/intel_pstate.c                                 |    2 +-
 drivers/ras/cec.c                                              |    2 +-
 drivers/rtc/rtc-cmos.c                                         |    2 +-
 drivers/staging/media/atomisp/include/linux/atomisp_platform.h |    4 ++--
 29 files changed, 45 insertions(+), 42 deletions(-)

--- a/arch/x86/crypto/blowfish_glue.c
+++ b/arch/x86/crypto/blowfish_glue.c
@@ -284,7 +284,7 @@ static struct skcipher_alg bf_skcipher_algs[] = {
 
 static bool is_blacklisted_cpu(void)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	if (!cpu_is_intel())
 		return false;
 
 	if (boot_cpu_data.x86 == 0x0f) {
--- a/arch/x86/crypto/camellia_glue.c
+++ b/arch/x86/crypto/camellia_glue.c
@@ -1357,7 +1357,7 @@ static struct skcipher_alg camellia_skcipher_algs[] = {
 
 static bool is_blacklisted_cpu(void)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	if (!cpu_is_intel())
 		return false;
 
 	if (boot_cpu_data.x86 == 0x0f) {
--- a/arch/x86/crypto/des3_ede_glue.c
+++ b/arch/x86/crypto/des3_ede_glue.c
@@ -335,7 +335,7 @@ static struct skcipher_alg des3_ede_skciphers[] = {
 
 static bool is_blacklisted_cpu(void)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	if (!cpu_is_intel())
 		return false;
 
 	if (boot_cpu_data.x86 == 0x0f) {
--- a/arch/x86/crypto/twofish_glue_3way.c
+++ b/arch/x86/crypto/twofish_glue_3way.c
@@ -104,7 +104,7 @@ static struct skcipher_alg tf_skciphers[] = {
 
 static bool is_blacklisted_cpu(void)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	if (!cpu_is_intel())
 		return false;
 
 	if (boot_cpu_data.x86 == 0x06 &&
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -39,7 +39,7 @@ static bool test_therm_status(int idx, void *data)
 
 static bool test_intel(int idx, void *data)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL ||
+	if (!cpu_is_intel() ||
 	    boot_cpu_data.x86 != 6)
 		return false;
 
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -177,6 +177,11 @@ enum cpuid_regs_idx {
 extern struct cpuinfo_x86	boot_cpu_data;
 extern struct cpuinfo_x86	new_cpu_data;
 
+static inline bool cpu_is_intel(void)
+{
+	return boot_cpu_data.x86_vendor == X86_VENDOR_INTEL;
+}
+
 extern __u32			cpu_caps_cleared[NCAPINTS + NBUGINTS];
 extern __u32			cpu_caps_set[NCAPINTS + NBUGINTS];
 
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1390,7 +1390,7 @@ void __init init_bsp_APIC(void)
 
 #ifdef CONFIG_X86_32
 	/* This bit is reserved on P4/Xeon and should be cleared */
-	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) &&
+	if (cpu_is_intel() &&
 	    (boot_cpu_data.x86 == 15))
 		value &= ~APIC_SPIV_FOCUS_DISABLED;
 	else
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1567,7 +1567,7 @@ void __init setup_ioapic_ids_from_mpc(void)
 	 * Don't check I/O APIC IDs for xAPIC systems.  They have
 	 * no meaning without the serial APIC bus.
 	 */
-	if (!(boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+	if (!cpu_is_intel()
 		|| APIC_XAPIC(boot_cpu_apic_version))
 		return;
 	setup_ioapic_ids_from_mpc_nocheck();
@@ -2571,7 +2571,7 @@ static int io_apic_get_unique_id(int ioapic, int apic_id)
 
 static u8 io_apic_unique_id(int idx, u8 id)
 {
-	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) &&
+	if (cpu_is_intel() &&
 	    !APIC_XAPIC(boot_cpu_apic_version))
 		return io_apic_get_unique_id(idx, id);
 	else
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -321,7 +321,7 @@ void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled)
 
 static void __init bp_init_freq_invariance(void)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	if (!cpu_is_intel())
 		return;
 
 	if (intel_set_max_freq_ratio())
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -928,7 +928,7 @@ static void __init retbleed_select_mitigation(void)
 	 * Let IBRS trump all on Intel without affecting the effects of the
 	 * retbleed= cmdline option.
 	 */
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
+	if (cpu_is_intel()) {
 		switch (spectre_v2_enabled) {
 		case SPECTRE_V2_IBRS:
 			retbleed_mitigation = RETBLEED_MITIGATION_IBRS;
@@ -1290,7 +1290,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 		return SPECTRE_V2_CMD_AUTO;
 	}
 
-	if (cmd == SPECTRE_V2_CMD_IBRS && boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
+	if (cmd == SPECTRE_V2_CMD_IBRS && !cpu_is_intel()) {
 		pr_err("%s selected but not Intel CPU. Switching to AUTO select\n",
 		       mitigation_options[i].option);
 		return SPECTRE_V2_CMD_AUTO;
@@ -1414,7 +1414,7 @@ static void __init spectre_v2_select_mitigation(void)
 		    boot_cpu_has_bug(X86_BUG_RETBLEED) &&
 		    retbleed_cmd != RETBLEED_CMD_OFF &&
 		    boot_cpu_has(X86_FEATURE_IBRS) &&
-		    boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
+		    cpu_is_intel()) {
 			mode = SPECTRE_V2_IBRS;
 			break;
 		}
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2021,7 +2021,7 @@ static void wrmsrl_cstar(unsigned long val)
 	 * is so far ignored by the CPU, but raises a #VE trap in a TDX
 	 * guest. Avoid the pointless write on all Intel CPUs.
 	 */
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	if (!cpu_is_intel())
 		wrmsrl(MSR_CSTAR, val);
 }
 
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -384,7 +384,7 @@ static void bsp_init_intel(struct cpuinfo_x86 *c)
 int ppro_with_ram_bug(void)
 {
 	/* Uses data from early_cpu_detect now */
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
+	if (cpu_is_intel() &&
 	    boot_cpu_data.x86 == 6 &&
 	    boot_cpu_data.x86_model == 1 &&
 	    boot_cpu_data.x86_stepping < 8) {
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -471,7 +471,7 @@ int mce_usable_address(struct mce *m)
 		return 0;
 
 	/* Checks after this one are Intel/Zhaoxin-specific: */
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
+	if (!cpu_is_intel() &&
 	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN)
 		return 1;
 
@@ -2066,7 +2066,7 @@ bool filter_mce(struct mce *m)
 {
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
 		return amd_filter_mce(m);
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+	if (cpu_is_intel())
 		return intel_filter_mce(m);
 
 	return false;
@@ -2309,7 +2309,7 @@ static void vendor_disable_error_reporting(void)
 	 * the socket like the last level cache (LLC), the integrated memory
 	 * controller (iMC), etc.
 	 */
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL ||
+	if (cpu_is_intel() ||
 	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ||
 	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
 	    boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN)
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -85,7 +85,7 @@ static int cmci_supported(int *banks)
 	 * initialization is vendor keyed and this
 	 * makes sure none of the backdoors are entered otherwise.
 	 */
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
+	if (!cpu_is_intel() &&
 	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN)
 		return 0;
 
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -706,7 +706,7 @@ void __init mtrr_bp_init(void)
 		if (cpuid_eax(0x80000000) >= 0x80000008) {
 			phys_addr = cpuid_eax(0x80000008) & 0xff;
 			/* CPUID workaround for Intel 0F33/0F34 CPU */
-			if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
+			if (cpu_is_intel() &&
 			    boot_cpu_data.x86 == 0xF &&
 			    boot_cpu_data.x86_model == 0x3 &&
 			    (boot_cpu_data.x86_stepping == 0x3 ||
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -732,7 +732,7 @@ static __init bool get_mem_config(void)
 	if (!rdt_cpu_has(X86_FEATURE_MBA))
 		return false;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+	if (cpu_is_intel())
 		return __get_mem_config_intel(&hw_res->r_resctrl);
 	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
 		return __rdt_get_mem_config_amd(&hw_res->r_resctrl);
@@ -811,7 +811,7 @@ static __init void __check_quirks_intel(void)
 
 static __init void check_quirks(void)
 {
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+	if (cpu_is_intel())
 		__check_quirks_intel();
 }
 
@@ -865,7 +865,7 @@ static __init void rdt_init_res_defs_amd(void)
 
 static __init void rdt_init_res_defs(void)
 {
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+	if (cpu_is_intel())
 		rdt_init_res_defs_intel();
 	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
 		rdt_init_res_defs_amd();
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -70,7 +70,7 @@ static struct class *pseudo_lock_class;
  */
 static u64 get_prefetch_disable_bits(void)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL ||
+	if (!cpu_is_intel() ||
 	    boot_cpu_data.x86 != 6)
 		return 0;
 
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -921,7 +921,7 @@ static bool __init mwait_pc10_supported(void)
 {
 	unsigned int eax, ebx, ecx, mwait_substates;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	if (!cpu_is_intel())
 		return false;
 
 	if (!cpu_feature_enabled(X86_FEATURE_MWAIT))
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -777,7 +777,7 @@ static void __init smp_quirk_init_udelay(void)
 		return;
 
 	/* if modern processor, use no delay */
-	if (((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) && (boot_cpu_data.x86 == 6)) ||
+	if ((cpu_is_intel() && (boot_cpu_data.x86 == 6)) ||
 	    ((boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) && (boot_cpu_data.x86 >= 0x18)) ||
 	    ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) && (boot_cpu_data.x86 >= 0xF))) {
 		init_udelay = 0;
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -624,7 +624,7 @@ unsigned long native_calibrate_tsc(void)
 	unsigned int eax_denominator, ebx_numerator, ecx_hz, edx;
 	unsigned int crystal_khz;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	if (!cpu_is_intel())
 		return 0;
 
 	if (boot_cpu_data.cpuid_level < 0x15)
@@ -697,7 +697,7 @@ static unsigned long cpu_khz_from_cpuid(void)
 {
 	unsigned int eax_base_mhz, ebx_max_mhz, ecx_bus_mhz, edx;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	if (!cpu_is_intel())
 		return 0;
 
 	if (boot_cpu_data.cpuid_level < 0x16)
@@ -1244,7 +1244,7 @@ int unsynchronized_tsc(void)
 	 * Intel systems are normally all synchronized.
 	 * Exceptions must mark TSC as unstable:
 	 */
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
+	if (!cpu_is_intel()) {
 		/* assume multi socket systems are not synchronized: */
 		if (num_possible_cpus() > 1)
 			return 1;
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -162,15 +162,13 @@ extern struct x86_pmu_capability kvm_pmu_cap;
 
 static inline void kvm_init_pmu_capability(void)
 {
-	bool is_intel = boot_cpu_data.x86_vendor == X86_VENDOR_INTEL;
-
 	perf_get_x86_pmu_capability(&kvm_pmu_cap);
 
 	 /*
 	  * For Intel, only support guest architectural pmu
 	  * on a host with architectural pmu.
 	  */
-	if ((is_intel && !kvm_pmu_cap.version) || !kvm_pmu_cap.num_counters_gp)
+	if ((cpu_is_intel() && !kvm_pmu_cap.version) || !kvm_pmu_cap.num_counters_gp)
 		enable_pmu = false;
 
 	if (!enable_pmu) {
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -63,7 +63,7 @@ static void __init percpu_setup_debug_store(unsigned int cpu)
 	unsigned int npages;
 	void *cea;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	if (!cpu_is_intel())
 		return;
 
 	cea = &get_cpu_entry_area(cpu)->cpu_debug_store;
--- a/arch/x86/xen/pmu.c
+++ b/arch/x86/xen/pmu.c
@@ -292,7 +292,7 @@ static bool xen_amd_pmu_emulate(unsigned int msr, u64 *val, bool is_read)
 
 bool pmu_msr_read(unsigned int msr, uint64_t *val, int *err)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
+	if (!cpu_is_intel()) {
 		if (is_amd_pmu_msr(msr)) {
 			if (!xen_amd_pmu_emulate(msr, val, 1))
 				*val = native_read_msr_safe(msr, err);
@@ -315,7 +315,7 @@ bool pmu_msr_write(unsigned int msr, uint32_t low, uint32_t high, int *err)
 {
 	uint64_t val = ((uint64_t)high << 32) | low;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
+	if (!cpu_is_intel()) {
 		if (is_amd_pmu_msr(msr)) {
 			if (!xen_amd_pmu_emulate(msr, &val, 0))
 				*err = native_write_msr_safe(msr, low, high);
@@ -386,7 +386,7 @@ static unsigned long long xen_intel_read_pmc(int counter)
 
 unsigned long long xen_read_pmc(int counter)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	if (!cpu_is_intel())
 		return xen_amd_read_pmc(counter);
 	else
 		return xen_intel_read_pmc(counter);
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -537,7 +537,7 @@ static void wait_for_freeze(void)
 	 * are ancient and may need the dummy wait.  This also assumes
 	 * that the motivating chipset issue was Intel-only.
 	 */
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	if (!cpu_is_intel())
 		return;
 #endif
 	/*
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -45,7 +45,7 @@ static int should_io_be_busy(void)
 	/*
 	 * For Intel, Core 2 (model 15) and later have an efficient idle.
 	 */
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
+	if (cpu_is_intel() &&
 			boot_cpu_data.x86 == 6 &&
 			boot_cpu_data.x86_model >= 15)
 		return 1;
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3418,7 +3418,7 @@ static int __init intel_pstate_init(void)
 	const struct x86_cpu_id *id;
 	int rc;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	if (!cpu_is_intel())
 		return -ENODEV;
 
 	id = x86_match_cpu(hwp_support_ids);
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -561,7 +561,7 @@ static int __init cec_init(void)
 	 * if pages with corrected errors are aggressively
 	 * taken offline.
 	 */
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+	if (cpu_is_intel())
 		action_threshold = 2;
 
 	ce_arr.array = (void *)get_zeroed_page(GFP_KERNEL);
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -1257,7 +1257,7 @@ static void rtc_wake_off(struct device *dev)
 /* Enable use_acpi_alarm mode for Intel platforms no earlier than 2015 */
 static void use_acpi_alarm_quirks(void)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	if (!cpu_is_intel())
 		return;
 
 	if (!is_hpet_enabled())
--- a/drivers/staging/media/atomisp/include/linux/atomisp_platform.h
+++ b/drivers/staging/media/atomisp/include/linux/atomisp_platform.h
@@ -238,10 +238,10 @@ const struct atomisp_platform_data *atomisp_get_platform_data(void);
 const struct atomisp_camera_caps *atomisp_get_default_camera_caps(void);
 
 /* API from old platform_camera.h, new CPUID implementation */
-#define __IS_SOC(x) (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && \
+#define __IS_SOC(x) (cpu_is_intel() && \
 		     boot_cpu_data.x86 == 6 &&                       \
 		     boot_cpu_data.x86_model == (x))
-#define __IS_SOCS(x,y) (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && \
+#define __IS_SOCS(x,y) (cpu_is_intel() && \
 		        boot_cpu_data.x86 == 6 &&                       \
 		        (boot_cpu_data.x86_model == (x) || \
 		         boot_cpu_data.x86_model == (y)))
