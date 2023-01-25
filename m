Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FA667A861
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 02:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbjAYB3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 20:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjAYB3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 20:29:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99B44861D;
        Tue, 24 Jan 2023 17:29:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53B44613CA;
        Wed, 25 Jan 2023 01:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B589C433D2;
        Wed, 25 Jan 2023 01:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674610154;
        bh=qacr7FT84UU+OMGQ5FClPg3n2mRyclLWZC5vVi0D71s=;
        h=From:To:Cc:Subject:Date:From;
        b=vAPi1JlnUiCJEgS86MZv2BP79Vrj/Ey1ClRGvKU2+s6W4knCFXrPevIlidgsCbkhr
         l9dPMebiifFGF+0uG2l/DqoEmCCSjIGwIS8Q3G40Q4CBY94PNA0DzQQRVxrd+Q2ZWh
         Ek7eZdHjVGYigMwrtdrwZ2VceExSeipTpBdkLB0RSAfwJSVbTxS19BG2ihB0potoFG
         hnfLHQbxUVv7hn1PcIKAv3j4mL/c63V4VNlTsaFdlVPDAukQs8RYAfDrPy/F7UljcG
         LMgRsSQRs6eI9n3aAgLHcQ64vezbwhU8MdfegXMBoWTbAFxhECunIrRiHk+kfi4SPE
         Ycs46Uj0+IHsA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Roxana Bradescu <roxabee@chromium.org>,
        Adam Langley <agl@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] x86: enable Data Operand Independent Timing Mode
Date:   Tue, 24 Jan 2023 17:28:01 -0800
Message-Id: <20230125012801.362496-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

[ I'm sending this patch out to hopefully get people interested in
  mitigating this Intel CPU vulnerability, as the original thread at
  https://lore.kernel.org/lkml/YwgCrqutxmX0W72r@gmail.com/T/#u died out
  after DIT was enabled on arm64, but nothing was done for x86.  Note:
  I don't currently have a way to properly test this patch, as I don't
  have hardware with Ice Lake or later.  Help with testing this on the
  actual hardware would be greatly appreciated.  I've tested that the
  command line options and sysfs file seem to be wired up properly. ]

According to documentation that Intel published recently [1], Intel CPUs
based on the Ice Lake and later microarchitectures don't guarantee "data
operand independent timing" by default.  I.e., instruction execution
times may depend on the values of data operated on.  This is true for a
wide variety of instructions, including many instructions that are
heavily used in cryptography and have always been assumed to be
constant-time, e.g. additions, XORs, and even the AES-NI instructions.

Cryptography algorithms require constant-time instructions to prevent
side-channel attacks that recover cryptographic keys based on execution
times.  Therefore, without this CPU vulnerability mitigated, it's
generally impossible to safely do cryptography on the latest Intel CPUs.

It's also plausible that this CPU vulnerability can expose privileged
kernel data to unprivileged userspace processes more generally.

To mitigate this CPU vulnerability, it's possible to enable "Data
Operand Independent Timing Mode" (DOITM) by setting a bit in a MSR.
While Intel's documentation suggests that this bit should only be set
where "necessary", that is highly impractical, given the fact that
cryptography can happen nearly anywhere in the kernel and userspace, and
the fact that the entire kernel likely needs to be protected anyway.

Therefore, let's simply enable DOITM globally by default to fix this
vulnerability.  At most this gives up an "optimization" on the very
latest CPUs, restoring the correct behavior from previous CPUs.

Note: this patch does not address the separate but related vulnerability
of MXCSR Configuration Dependent Timing (MCDT) that the Intel document
describes.  A separate patch would need to address that.

[1] https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/best-practices/data-operand-independent-timing-isa-guidance.html

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      |  1 +
 Documentation/admin-guide/hw-vuln/dodt.rst    | 37 ++++++++++++
 Documentation/admin-guide/hw-vuln/index.rst   |  1 +
 .../admin-guide/kernel-parameters.txt         |  7 +++
 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/msr-index.h              |  8 +++
 arch/x86/kernel/cpu/bugs.c                    | 56 +++++++++++++++++++
 arch/x86/kernel/cpu/common.c                  |  4 ++
 arch/x86/kernel/cpu/cpu.h                     |  1 +
 drivers/base/cpu.c                            |  8 +++
 include/linux/cpu.h                           |  2 +
 11 files changed, 126 insertions(+)
 create mode 100644 Documentation/admin-guide/hw-vuln/dodt.rst

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index f54867cadb0f6..b76966aac3470 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -524,6 +524,7 @@ What:		/sys/devices/system/cpu/vulnerabilities
 		/sys/devices/system/cpu/vulnerabilities/itlb_multihit
 		/sys/devices/system/cpu/vulnerabilities/mmio_stale_data
 		/sys/devices/system/cpu/vulnerabilities/retbleed
+		/sys/devices/system/cpu/vulnerabilities/dodt
 Date:		January 2018
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:	Information about CPU vulnerabilities
diff --git a/Documentation/admin-guide/hw-vuln/dodt.rst b/Documentation/admin-guide/hw-vuln/dodt.rst
new file mode 100644
index 0000000000000..03d24f4d97100
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/dodt.rst
@@ -0,0 +1,37 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+DODT - Data Operand Dependent Timing
+====================================
+
+Data Operand Dependent Timing (DODT) is a CPU vulnerability that makes the
+execution times of instructions depend on the values of the data operated on.
+
+This vulnerability potentially enables side-channel attacks on data, including
+cryptographic keys.  Most cryptography algorithms require that a variety of
+instructions be constant-time in order to prevent side-channel attacks.
+
+Affected CPUs
+-------------
+
+This vulnerability affects Intel Core family processors based on the Ice Lake
+and later microarchitectures, and Intel Atom family processors based on the
+Gracemont and later microarchitectures.  For more information, see Intel's
+documentation [1]_.
+
+Mitigation
+----------
+
+Mitigation of this vulnerability involves setting a Model Specific Register
+(MSR) bit to enable Data Operand Independent Timing Mode (DOITM).
+
+By the default, the kernel does this on all CPUs.  This mitigation is global, so
+it applies to both the kernel and userspace.
+
+This mitigation can be disabled by adding ``doitm=off`` to the kernel command
+line.  It's also one of the mitigations that can be disabled by
+``mitigations=off``.
+
+References
+----------
+.. [1] Data Operand Independent Timing Instruction Set Architecture (ISA) Guidance
+   https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/best-practices/data-operand-independent-timing-isa-guidance.html
diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
index 4df436e7c4177..cd962f9634dad 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -18,3 +18,4 @@ are configurable at compile, boot or run time.
    core-scheduling.rst
    l1d_flush.rst
    processor_mmio_stale_data.rst
+   dodt.rst
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6cfa6e3996cf7..a6a872c4365e6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1119,6 +1119,12 @@
 			The filter can be disabled or changed to another
 			driver later using sysfs.
 
+	doitm=off	[X86,INTEL] Disable the use of Data Operand Independent
+			Timing Mode (DOITM).  I.e., disable the mitigation for
+			the Data Operand Dependent Timing (DODT) CPU
+			vulnerability.  For details, see
+			Documentation/admin-guide/hw-vuln/dodt.rst
+
 	driver_async_probe=  [KNL]
 			List of driver names to be probed asynchronously. *
 			matches with all driver names. If * is specified, the
@@ -3259,6 +3265,7 @@
 					       no_uaccess_flush [PPC]
 					       mmio_stale_data=off [X86]
 					       retbleed=off [X86]
+					       doitm=off [X86,INTEL]
 
 				Exceptions:
 					       This does not have any effect on
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 61012476d66e0..7ddb7390c8a60 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -466,5 +466,6 @@
 #define X86_BUG_MMIO_UNKNOWN		X86_BUG(26) /* CPU is too old and its MMIO Stale Data status is unknown */
 #define X86_BUG_RETBLEED		X86_BUG(27) /* CPU is affected by RETBleed */
 #define X86_BUG_EIBRS_PBRSB		X86_BUG(28) /* EIBRS is vulnerable to Post Barrier RSB Predictions */
+#define X86_BUG_DODT			X86_BUG(29) /* CPU has data operand dependent timing by default */
 
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 37ff47552bcb7..1d929ad4301a8 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -114,6 +114,11 @@
 						 * Not susceptible to
 						 * TSX Async Abort (TAA) vulnerabilities.
 						 */
+#define ARCH_CAP_DOITM			BIT(12)	/*
+						 * The processor supports Data Operand
+						 * Independent Timing Mode, i.e. it is
+						 * vulnerable to data operand dependent timing.
+						 */
 #define ARCH_CAP_SBDR_SSDP_NO		BIT(13)	/*
 						 * Not susceptible to SBDR and SSDP
 						 * variants of Processor MMIO stale data
@@ -155,6 +160,9 @@
 						 * supported
 						 */
 
+#define MSR_IA32_UARCH_MISC_CTL		0x00001b01
+#define UARCH_MISC_DOITM		BIT(0)	/* Enable Data Operand Independent Timing Mode. */
+
 #define MSR_IA32_FLUSH_CMD		0x0000010b
 #define L1D_FLUSH			BIT(0)	/*
 						 * Writeback and invalidate the
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index bca0bd8f48464..7ea20a2618232 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -49,6 +49,7 @@ static void __init taa_select_mitigation(void);
 static void __init mmio_select_mitigation(void);
 static void __init srbds_select_mitigation(void);
 static void __init l1d_flush_select_mitigation(void);
+static void __init dodt_select_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR without task-specific bits set */
 u64 x86_spec_ctrl_base;
@@ -124,6 +125,8 @@ DEFINE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
 DEFINE_STATIC_KEY_FALSE(mmio_stale_data_clear);
 EXPORT_SYMBOL_GPL(mmio_stale_data_clear);
 
+static bool __ro_after_init doitm_off;
+
 void __init check_bugs(void)
 {
 	identify_boot_cpu();
@@ -167,6 +170,7 @@ void __init check_bugs(void)
 	md_clear_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
+	dodt_select_mitigation();
 
 	arch_smt_update();
 
@@ -2218,6 +2222,42 @@ static int __init l1tf_cmdline(char *str)
 }
 early_param("l1tf", l1tf_cmdline);
 
+#undef pr_fmt
+#define pr_fmt(fmt)	"DODT: " fmt
+
+static __init int doitm_parse_cmdline(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!boot_cpu_has_bug(X86_BUG_DODT))
+		return 0;
+
+	doitm_off = !strcmp(str, "off");
+	if (doitm_off)
+		pr_info("'doitm=off' specified, not enabling Data Operand Independent Timing Mode\n");
+	return 0;
+}
+early_param("doitm", doitm_parse_cmdline);
+
+static __init void dodt_select_mitigation(void)
+{
+	if (cpu_mitigations_off() || !boot_cpu_has_bug(X86_BUG_DODT))
+		doitm_off = true;
+	update_doitm_msr();
+}
+
+void update_doitm_msr(void)
+{
+	u64 msr;
+
+	if (doitm_off)
+		return;
+
+	rdmsrl(MSR_IA32_UARCH_MISC_CTL, msr);
+	wrmsrl(MSR_IA32_UARCH_MISC_CTL, msr | UARCH_MISC_DOITM);
+}
+
 #undef pr_fmt
 #define pr_fmt(fmt) fmt
 
@@ -2415,6 +2455,14 @@ static ssize_t retbleed_show_state(char *buf)
 	return sysfs_emit(buf, "%s\n", retbleed_strings[retbleed_mitigation]);
 }
 
+static ssize_t dodt_show_state(char *buf)
+{
+	if (doitm_off)
+		return sysfs_emit(buf, "Vulnerable\n");
+	else
+		return sysfs_emit(buf, "Mitigation: DOITM\n");
+}
+
 static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
 			       char *buf, unsigned int bug)
 {
@@ -2464,6 +2512,9 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 	case X86_BUG_RETBLEED:
 		return retbleed_show_state(buf);
 
+	case X86_BUG_DODT:
+		return dodt_show_state(buf);
+
 	default:
 		break;
 	}
@@ -2528,4 +2579,9 @@ ssize_t cpu_show_retbleed(struct device *dev, struct device_attribute *attr, cha
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_RETBLEED);
 }
+
+ssize_t cpu_show_dodt(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_DODT);
+}
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9cfca3d7d0e20..b27fa7e730f32 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1325,6 +1325,9 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	    !(ia32_cap & ARCH_CAP_PSCHANGE_MC_NO))
 		setup_force_cpu_bug(X86_BUG_ITLB_MULTIHIT);
 
+	if (ia32_cap & ARCH_CAP_DOITM)
+		setup_force_cpu_bug(X86_BUG_DODT);
+
 	if (cpu_matches(cpu_vuln_whitelist, NO_SPECULATION))
 		return;
 
@@ -1972,6 +1975,7 @@ void identify_secondary_cpu(struct cpuinfo_x86 *c)
 	validate_apic_and_package_id(c);
 	x86_spec_ctrl_setup_ap();
 	update_srbds_msr();
+	update_doitm_msr();
 
 	tsx_ap_init();
 }
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 7c9b5893c30ab..187190cf1ccca 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -82,6 +82,7 @@ unsigned int aperfmperf_get_khz(int cpu);
 
 extern void x86_spec_ctrl_setup_ap(void);
 extern void update_srbds_msr(void);
+extern void update_doitm_msr(void);
 
 extern u64 x86_read_arch_cap_msr(void);
 
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 4c98849577d4e..281d4e18dddd2 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -576,6 +576,12 @@ ssize_t __weak cpu_show_retbleed(struct device *dev,
 	return sysfs_emit(buf, "Not affected\n");
 }
 
+ssize_t __weak cpu_show_dodt(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "Not affected\n");
+}
+
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
 static DEVICE_ATTR(spectre_v2, 0444, cpu_show_spectre_v2, NULL);
@@ -587,6 +593,7 @@ static DEVICE_ATTR(itlb_multihit, 0444, cpu_show_itlb_multihit, NULL);
 static DEVICE_ATTR(srbds, 0444, cpu_show_srbds, NULL);
 static DEVICE_ATTR(mmio_stale_data, 0444, cpu_show_mmio_stale_data, NULL);
 static DEVICE_ATTR(retbleed, 0444, cpu_show_retbleed, NULL);
+static DEVICE_ATTR(dodt, 0444, cpu_show_dodt, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
@@ -600,6 +607,7 @@ static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_srbds.attr,
 	&dev_attr_mmio_stale_data.attr,
 	&dev_attr_retbleed.attr,
+	&dev_attr_dodt.attr,
 	NULL
 };
 
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 314802f98b9da..8fa28be9f48bc 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -70,6 +70,8 @@ extern ssize_t cpu_show_mmio_stale_data(struct device *dev,
 					char *buf);
 extern ssize_t cpu_show_retbleed(struct device *dev,
 				 struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_dodt(struct device *dev,
+			     struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,

base-commit: fb6e71db53f3d4351dada7c130fb652eecf994d6
-- 
2.39.1

