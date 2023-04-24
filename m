Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD746ED596
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 21:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjDXTu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 15:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbjDXTtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:49:42 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261EE44A4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 12:49:40 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pr2Bj-0006Mz-Qx; Mon, 24 Apr 2023 21:49:27 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        paul.walmsley@sifive.com
Cc:     heiko@sntech.de, kito.cheng@sifive.com, jrtc27@jrtc27.com,
        conor.dooley@microchip.com, matthias.bgg@gmail.com,
        heinrich.schuchardt@canonical.com, greentime.hu@sifive.com,
        nick.knight@sifive.com, christoph.muellner@vrull.eu,
        philipp.tomsich@vrull.eu, richard.henderson@linaro.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH 4/4] RISC-V: add support for vendor-extensions via AT_BASE_PLATFORM and xthead
Date:   Mon, 24 Apr 2023 21:49:11 +0200
Message-Id: <20230424194911.264850-5-heiko.stuebner@vrull.eu>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230424194911.264850-1-heiko.stuebner@vrull.eu>
References: <20230424194911.264850-1-heiko.stuebner@vrull.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

T-Head cores support a number of own ISA extensions that also include
optimized instructions which could benefit userspace to improve
performance.

Extensions supported by current T-Head cores are:
* XTheadBa - bitmanipulation instructions for address calculation
* XTheadBb - conditional basic bit-manipulation instructions
* XTheadBs - instructions to access a single bit in a register
* XTheadCmo - cache management operations
* XTheadCondMov - conditional move instructions
* XTheadFMemIdx - indexed memory operations for floating-point registers
* XTheadFmv - double-precision floating-point high-bit data transmission
              intructions for RV32
* XTheadInt - instructions to reduce the code size of ISRs and/or the
              interrupt latencies that are caused by ISR entry/exit code
* XTheadMac - multiply-accumulate instructions
* XTheadMemIdx - indexed memory operations for GP registers
* XTheadMemPair - two-GPR memory operations
* XTheadSync - multi-core synchronization instructions

In-depth descriptions of these extensions can be found on
    https://github.com/T-head-Semi/thead-extension-spec

Support for those extensions was merged into the relevant toolchains
so userspace programs can select necessary optimizations when needed.

So a mechanism to the isa-string generation to export vendor-extension
lists via the errata mechanism and implement it for T-Head C9xx cores.

This exposes these vendor extensions then both in AT_BASE_PLATFORM
and /proc/cpuinfo.

Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 arch/riscv/errata/thead/errata.c     | 43 ++++++++++++++++++++++++++++
 arch/riscv/include/asm/alternative.h |  4 +++
 arch/riscv/kernel/alternative.c      | 21 ++++++++++++++
 arch/riscv/kernel/cpu.c              | 12 ++++++++
 4 files changed, 80 insertions(+)

diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index 1036b8f933ec..eb635bf80737 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -15,6 +15,7 @@
 #include <asm/errata_list.h>
 #include <asm/hwprobe.h>
 #include <asm/patch.h>
+#include <asm/switch_to.h>
 #include <asm/vendorid_list.h>
 
 static bool errata_probe_pbmt(unsigned int stage,
@@ -125,3 +126,45 @@ void __init_or_module thead_feature_probe_func(unsigned int cpu,
 	if ((archid == 0) && (impid == 0))
 		per_cpu(misaligned_access_speed, cpu) = RISCV_HWPROBE_MISALIGNED_FAST;
 }
+
+
+char *thead_extension_list_func(unsigned long archid,
+				unsigned long impid)
+{
+	if ((archid == 0) && (impid == 0)) {
+		const char *xbase1 = "xtheadba_xtheadbb_xtheadbs_xtheadcmo_xtheadcondmov";
+		const char *xbase2 = "_xtheadint_xtheadmac_xtheadmemidx_xtheadmempair_xtheadsync";
+		const char *xfpu = "_xtheadfmemIdx";
+#ifdef CONFIG_32BIT
+		const char *xfpu32 = "_xtheadfmv";
+#endif
+		int len = strlen(xbase1) + strlen(xbase2);
+		char *str;
+
+		if (has_fpu()) {
+			len += strlen(xfpu);
+#ifdef CONFIG_32BIT
+			len+= strlen(xfpu32);
+#endif
+		}
+
+		str = kzalloc(len, GFP_KERNEL);
+		if (!str)
+			return str;
+
+		strcpy(str, xbase1);
+
+		if (has_fpu()) {
+			strcat(str, xfpu);
+#ifdef CONFIG_32BIT
+			strcat(str, xfpu32);
+#endif
+		}
+
+		strcat(str, xbase2);
+
+		return str;
+	}
+
+	return NULL;
+}
diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
index a8f5cf6694a1..8c9aec196649 100644
--- a/arch/riscv/include/asm/alternative.h
+++ b/arch/riscv/include/asm/alternative.h
@@ -31,6 +31,7 @@
 #define ALT_ALT_PTR(a)			__ALT_PTR(a, alt_offset)
 
 void __init probe_vendor_features(unsigned int cpu);
+char *list_vendor_extensions(void);
 void __init apply_boot_alternatives(void);
 void __init apply_early_boot_alternatives(void);
 void apply_module_alternatives(void *start, size_t length);
@@ -55,6 +56,8 @@ void thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 
 void thead_feature_probe_func(unsigned int cpu, unsigned long archid,
 			      unsigned long impid);
+char *thead_extension_list_func(unsigned long archid,
+				unsigned long impid);
 
 void riscv_cpufeature_patch_func(struct alt_entry *begin, struct alt_entry *end,
 				 unsigned int stage);
@@ -62,6 +65,7 @@ void riscv_cpufeature_patch_func(struct alt_entry *begin, struct alt_entry *end,
 #else /* CONFIG_RISCV_ALTERNATIVE */
 
 static inline void probe_vendor_features(unsigned int cpu) { }
+static inline char *list_vendor_extensions(void) { return NULL; }
 static inline void apply_boot_alternatives(void) { }
 static inline void apply_early_boot_alternatives(void) { }
 static inline void apply_module_alternatives(void *start, size_t length) { }
diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
index fc65c9293ac5..18913fd1809f 100644
--- a/arch/riscv/kernel/alternative.c
+++ b/arch/riscv/kernel/alternative.c
@@ -29,6 +29,8 @@ struct cpu_manufacturer_info_t {
 				  unsigned int stage);
 	void (*feature_probe_func)(unsigned int cpu, unsigned long archid,
 				   unsigned long impid);
+	char *(*extension_list_func)(unsigned long archid,
+				    unsigned long impid);
 };
 
 static void __init_or_module riscv_fill_cpu_mfr_info(struct cpu_manufacturer_info_t *cpu_mfr_info)
@@ -54,6 +56,7 @@ static void __init_or_module riscv_fill_cpu_mfr_info(struct cpu_manufacturer_inf
 	case THEAD_VENDOR_ID:
 		cpu_mfr_info->patch_func = thead_errata_patch_func;
 		cpu_mfr_info->feature_probe_func = thead_feature_probe_func;
+		cpu_mfr_info->extension_list_func = thead_extension_list_func;
 		break;
 #endif
 	default:
@@ -157,6 +160,24 @@ void __init_or_module probe_vendor_features(unsigned int cpu)
 					cpu_mfr_info.imp_id);
 }
 
+/*
+ * Lists the vendor-specific extensions common to all cores.
+ * Returns a new underscore "_" concatenated string that the
+ * caller is supposed to free after use.
+ */
+char *list_vendor_extensions(void)
+{
+	struct cpu_manufacturer_info_t cpu_mfr_info;
+
+	riscv_fill_cpu_mfr_info(&cpu_mfr_info);
+	if (!cpu_mfr_info.extension_list_func)
+		return NULL;
+
+	return cpu_mfr_info.extension_list_func(cpu_mfr_info.arch_id,
+						cpu_mfr_info.imp_id);
+
+}
+
 /*
  * This is called very early in the boot process (directly after we run
  * a feature detect on the boot CPU). No need to worry about other CPUs
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 71770563199f..6a0a45b2eb20 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/seq_file.h>
 #include <linux/of.h>
+#include <asm/alternative.h>
 #include <asm/cpufeature.h>
 #include <asm/csr.h>
 #include <asm/hwcap.h>
@@ -260,6 +261,7 @@ static char *riscv_create_isa_string(void)
 {
 	int maxlen = 4;
 	char *isa_str;
+	char *vendor_isa;
 	int i;
 
 	/* calculate the needed string length */
@@ -268,6 +270,10 @@ static char *riscv_create_isa_string(void)
 			maxlen++;
 	maxlen += strlen_isa_ext();
 
+	vendor_isa = list_vendor_extensions();
+	if (vendor_isa)
+		maxlen += strlen(vendor_isa) + 1;
+
 	isa_str = kzalloc(maxlen, GFP_KERNEL);
 	if (!isa_str)
 		return ERR_PTR(-ENOMEM);
@@ -287,6 +293,12 @@ static char *riscv_create_isa_string(void)
 
 	strcat_isa_ext(isa_str);
 
+	if(vendor_isa) {
+		strcat(isa_str, "_");
+		strcat(isa_str, vendor_isa);
+		kfree(vendor_isa);
+	}
+
 	return isa_str;
 }
 
-- 
2.39.0

