Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0546F7413CA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjF1OWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:22:41 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:45535 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjF1OV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:21:56 -0400
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fba8e2a9ecso19048835e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 07:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687962115; x=1690554115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NUnbzC6rK2LRciIx9biQ+vCgd300E5xF0u5wVny0t9s=;
        b=eXZLggkmP8czJdcKOvKirRqPlPO1ijfTU1wZZUQVSmIOBhT0XUIZ3L6tjn4GFfJdGV
         Sz9o9c4yCicpxLTpVS/GrD9svCMnZiuQ7zLM5YiU0nifPkKx67gecU9qIj0DWnaJwTpM
         /irQTYCNnewlRU7XI96N/AxJCLl7pez/PzGIGwHwHT4x7CYjr/FLz1kt3f1KjKlfaUYg
         9/U09MMu2RdFAcNbnuMsOYbxDWnvXYz2DTSYNkI3tlKz/0JrU9vN3djMRv41S6QmmUwK
         8YOQXJVngxez78ygy8s9njvwXgIRy1x7cUdmpG3G5dtrckrLeBDkZDgdIkyepg30GHg3
         4CxQ==
X-Gm-Message-State: AC+VfDwz9djs7M459J4ZVS0DRrfEfe2vWXf/kLj0Z7JbFnCSBYGdjGKv
        mze1RcjzsetJaxSbkPamvMI=
X-Google-Smtp-Source: ACHHUZ4C04j3TwBu+4K82kzwTg5x4gX4i9Ohi1egF5iYFv00VAL7O1xIY5uMntd7mswSvpRQpFM9yw==
X-Received: by 2002:a05:600c:2294:b0:3fb:b4fc:be62 with SMTP id 20-20020a05600c229400b003fbb4fcbe62mr504719wmf.17.1687962114933;
        Wed, 28 Jun 2023 07:21:54 -0700 (PDT)
Received: from localhost (fwdproxy-cln-013.fbsv.net. [2a03:2880:31ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c024900b003fbb1bf7e0fsm1828229wmj.35.2023.06.28.07.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 07:21:54 -0700 (PDT)
From:   leitao@debian.org
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     leit@meta.com, Breno Leitao <leitao@debian.org>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v3] x86/bugs: Add a separate config for each mitigation
Date:   Wed, 28 Jun 2023 07:21:28 -0700
Message-Id: <20230628142129.2468174-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Breno Leitao <leitao@debian.org>

Create an entry for each CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
them at compilation time.

If a mitigation is disabled at compilation time, it could be enabled at
runtime using kernel command line arguments.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
V1:
	* Creates a way to mitigate all (or none) hardware bugs
V2:
	* Create KCONFIGs entries only some hardware bugs (MDS, TAA, MMIO)
V3:
	* Expand the mitigations KCONFIGs to all hardware bugs that are
	  Linux mitigates.
---
 arch/x86/Kconfig           | 93 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/bugs.c | 50 +++++++++++++++++---
 2 files changed, 137 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 53bab123a8ee..53a751927a57 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2649,6 +2649,99 @@ config SLS
 	  against straight line speculation. The kernel image might be slightly
 	  larger.
 
+config MITIGATE_MDS
+	bool "Mitigate Microarchitectural Data Sampling (MDS) hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for Microarchitectural Data Sampling (MDS). MDS is
+	  a hardware vulnerability which allows unprivileged speculative access
+	  to data which is available in various CPU internal buffer. Deeper
+	  technical information is available in the MDS specific x86 architecture
+	  section: Documentation/arch/x86/mds.rst.
+
+config MITIGATE_TAA
+	bool "Mitigate TSX Asynchronous Abort (TAA) hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for TSX Asynchronous Abort (TAA). TAA is a hardware
+	  vulnerability that allows unprivileged speculative access to data
+	  which is available in various CPU internal buffers by using
+	  asynchronous aborts within an Intel TSX transactional region.
+
+config MITIGATE_MMIO_STALE_DATA
+	bool "Mitigate MMIO Stale Data hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for MMIO Stale Data hardware bugs.  Processor MMIO
+	  Stale Data Vulnerabilities are a class of memory-mapped I/O (MMIO)
+	  vulnerabilities that can expose data. The vulnerabilities require the
+	  attacker to have access to MMIO.
+
+config MITIGATE_L1TF
+	bool "Mitigate L1 Terminal Fault (L1TF) hardware bug"
+	default y
+	help
+	  Mitigate L1 Terminal Fault (L1TF) hardware bug. L1 Terminal Fault is a
+	  hardware vulnerability which allows unprivileged speculative access to data
+	  which is available in the Level 1 Data Cache when the page table
+	  entry controlling the virtual address.
+
+config MITIGATE_RETBLEED
+	bool "Mitigate RETBleed hardware bug"
+	default y
+	help
+	  Enable mitigation for RETBleed (Arbitrary Speculative Code Execution
+	  with Return Instructions) vulnerability.  RETBleed is a speculative
+	  execution attack which takes advantage of microarchitectural behavior
+	  in many modern microprocessors, similar to Spectre v2. An
+	  unprivileged attacker can use these flaws to bypass conventional
+	  memory security restrictions to gain read access to privileged memory
+	  that would otherwise be inaccessible.
+
+config MITIGATE_SPECTRE_V1
+	bool "Mitigate SPECTRE V1 hardware bug"
+	default y
+	help
+	  Enable mitigation for Spectre V1 (Bounds Check Bypass). Spectre V1 is a
+	  class of side channel attacks that takes advantage of speculative
+	  execution that bypasses conditional branch instructions used for
+	  memory access bounds check.
+
+config MITIGATE_SPECTRE_V2
+	bool "Mitigate SPECTRE V2 hardware bug"
+	default y
+	help
+	  Enable mitigation for Spectre V2 (Branch Target Injection). Spectre
+	  V2 is a class of side channel attacks that takes advantage of
+	  indirect branch predictors inside the processor. In Spectre variant 2
+	  attacks, the attacker can steer speculative indirect branches in the
+	  victim to gadget code by poisoning the branch target buffer of a CPU
+	  used for predicting indirect branch addresses.
+
+config MITIGATE_SRBDS
+	bool "Mitigate Special Register Buffer Data Sampling (SRBDS) hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for Special Register Buffer Data Sampling (SRBDS).
+	  SRBDS is a hardware vulnerability that allows Microarchitectural Data
+	  Sampling (MDS) techniques to infer values returned from special
+	  register accesses. An unprivileged user can extract values returned
+	  from RDRAND and RDSEED executed on another core or sibling thread
+	  using MDS techniques.
+
+config MITIGATE_SSB
+	bool "Mitigate Speculative Store Bypass (SSB) hardware bug"
+	default y
+	help
+	  Enable mitigation for Speculative Store Bypass (SSB). SSB is a
+	  hardware security vulnerability and its exploitation takes advantage
+	  of speculative execution in a similar way to the Meltdown and Spectre
+	  security vulnerabilities.
+
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 182af64387d0..c351eed75a14 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -267,7 +267,11 @@ static void x86_amd_ssb_disable(void)
 #define pr_fmt(fmt)	"MDS: " fmt
 
 /* Default mitigation for MDS-affected CPUs */
+#if IS_ENABLED(CONFIG_MITIGATE_MDS)
 static enum mds_mitigations mds_mitigation __ro_after_init = MDS_MITIGATION_FULL;
+#else
+static enum mds_mitigations mds_mitigation __ro_after_init = MDS_MITIGATION_OFF;
+#endif
 static bool mds_nosmt __ro_after_init = false;
 
 static const char * const mds_strings[] = {
@@ -327,7 +331,11 @@ enum taa_mitigations {
 };
 
 /* Default mitigation for TAA-affected CPUs */
+#if IS_ENABLED(CONFIG_MITIGATE_TAA)
 static enum taa_mitigations taa_mitigation __ro_after_init = TAA_MITIGATION_VERW;
+#else
+static enum taa_mitigations taa_mitigation __ro_after_init = TAA_MITIGATION_OFF;
+#endif
 static bool taa_nosmt __ro_after_init;
 
 static const char * const taa_strings[] = {
@@ -428,7 +436,11 @@ enum mmio_mitigations {
 };
 
 /* Default mitigation for Processor MMIO Stale Data vulnerabilities */
+#if IS_ENABLED(CONFIG_MITIGATE_MMIO_STALE_DATA)
 static enum mmio_mitigations mmio_mitigation __ro_after_init = MMIO_MITIGATION_VERW;
+#else
+static enum mmio_mitigations mmio_mitigation __ro_after_init = MMIO_MITIGATION_OFF;
+#endif
 static bool mmio_nosmt __ro_after_init = false;
 
 static const char * const mmio_strings[] = {
@@ -577,7 +589,11 @@ enum srbds_mitigations {
 	SRBDS_MITIGATION_HYPERVISOR,
 };
 
+#if IS_ENABLED(CONFIG_MITIGATE_SRBDS)
 static enum srbds_mitigations srbds_mitigation __ro_after_init = SRBDS_MITIGATION_FULL;
+#else
+static enum srbds_mitigations srbds_mitigation __ro_after_init = SRBDS_MITIGATION_OFF;
+#endif
 
 static const char * const srbds_strings[] = {
 	[SRBDS_MITIGATION_OFF]		= "Vulnerable",
@@ -702,8 +718,13 @@ enum spectre_v1_mitigation {
 	SPECTRE_V1_MITIGATION_AUTO,
 };
 
+#if IS_ENABLED(CONFIG_MITIGATE_SPECTRE_V1)
 static enum spectre_v1_mitigation spectre_v1_mitigation __ro_after_init =
 	SPECTRE_V1_MITIGATION_AUTO;
+#else
+static enum spectre_v1_mitigation spectre_v1_mitigation __ro_after_init =
+	SPECTRE_V1_MITIGATION_NONE;
+#endif
 
 static const char * const spectre_v1_strings[] = {
 	[SPECTRE_V1_MITIGATION_NONE] = "Vulnerable: __user pointer sanitization and usercopy barriers only; no swapgs barriers",
@@ -817,8 +838,13 @@ static const char * const retbleed_strings[] = {
 
 static enum retbleed_mitigation retbleed_mitigation __ro_after_init =
 	RETBLEED_MITIGATION_NONE;
+#if IS_ENABLED(CONFIG_MITIGATE_RETBLEED)
 static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
 	RETBLEED_CMD_AUTO;
+#else
+static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
+	RETBLEED_CMD_OFF;
+#endif
 
 static int __ro_after_init retbleed_nosmt = false;
 
@@ -1273,7 +1299,11 @@ static void __init spec_v2_print_cond(const char *reason, bool secure)
 
 static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 {
+#if IS_ENABLED(CONFIG_MITIGATE_SPECTRE_V2)
 	enum spectre_v2_mitigation_cmd cmd = SPECTRE_V2_CMD_AUTO;
+#else
+	enum spectre_v2_mitigation_cmd cmd = SPECTRE_V2_CMD_NONE;
+#endif
 	char arg[20];
 	int ret, i;
 
@@ -1283,7 +1313,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 
 	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
 	if (ret < 0)
-		return SPECTRE_V2_CMD_AUTO;
+		return cmd;
 
 	for (i = 0; i < ARRAY_SIZE(mitigation_options); i++) {
 		if (!match_option(arg, ret, mitigation_options[i].option))
@@ -1293,8 +1323,8 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	}
 
 	if (i >= ARRAY_SIZE(mitigation_options)) {
-		pr_err("unknown option (%s). Switching to AUTO select\n", arg);
-		return SPECTRE_V2_CMD_AUTO;
+		pr_err("unknown option (%s). Switching to default mode\n", arg);
+		return cmd;
 	}
 
 	if ((cmd == SPECTRE_V2_CMD_RETPOLINE ||
@@ -1767,7 +1797,11 @@ static const struct {
 
 static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 {
+#if IS_ENABLED(CONFIG_MITIGATE_SSB)
 	enum ssb_mitigation_cmd cmd = SPEC_STORE_BYPASS_CMD_AUTO;
+#else
+	enum ssb_mitigation_cmd cmd = SPEC_STORE_BYPASS_CMD_NONE;
+#endif
 	char arg[20];
 	int ret, i;
 
@@ -1778,7 +1812,7 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 		ret = cmdline_find_option(boot_command_line, "spec_store_bypass_disable",
 					  arg, sizeof(arg));
 		if (ret < 0)
-			return SPEC_STORE_BYPASS_CMD_AUTO;
+			return cmd;
 
 		for (i = 0; i < ARRAY_SIZE(ssb_mitigation_options); i++) {
 			if (!match_option(arg, ret, ssb_mitigation_options[i].option))
@@ -1789,8 +1823,8 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 		}
 
 		if (i >= ARRAY_SIZE(ssb_mitigation_options)) {
-			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
-			return SPEC_STORE_BYPASS_CMD_AUTO;
+			pr_err("unknown option (%s). Switching to default mode\n", arg);
+			return cmd;
 		}
 	}
 
@@ -2116,7 +2150,11 @@ EXPORT_SYMBOL_GPL(itlb_multihit_kvm_mitigation);
 #define pr_fmt(fmt)	"L1TF: " fmt
 
 /* Default mitigation for L1TF-affected CPUs */
+#if IS_ENABLED(CONFIG_MITIGATE_L1TF)
 enum l1tf_mitigations l1tf_mitigation __ro_after_init = L1TF_MITIGATION_FLUSH;
+#else
+enum l1tf_mitigations l1tf_mitigation __ro_after_init = L1TF_MITIGATION_OFF;
+#endif
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 EXPORT_SYMBOL_GPL(l1tf_mitigation);
 #endif
-- 
2.34.1

