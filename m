Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E92E704001
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245623AbjEOVnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243061AbjEOVnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:43:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F401127;
        Mon, 15 May 2023 14:43:19 -0700 (PDT)
Date:   Mon, 15 May 2023 21:43:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684186998;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vHOj8rxEVzbfdZ6HoDOFnIQx8ksd17t4zRCw9CvGBRY=;
        b=iTX2y4XyelsJfs24xxSRiW2TfF4Jkh9JZgfsVMHGjvplH+cynxTAKtialhFaLjrghzf6Kf
        HCKfjjtaTHClwB57qqOplr7H1RU9l2saeZynHftJhxkAVszUogTOZuzIazoGoyf45xNG9R
        8fT2RY2Vcp6RwWNVAP7Xs8bHdoLoThX0TSPyMM7ZJl61bONwhtgRqPmperZqvlG9kO0Jqy
        LIZ8ibUsY9PlOZbwVZ9P0UzBpoYQpRYK5PwQktCzmRAokGX9Vido3miJ78TDfeiSS8pwIq
        8C/PtjLGwEJlZoE1XQM4T5ShrHNMbVAP6FPT8mDMuhEy9BNbJFFKU+dYv83phA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684186998;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vHOj8rxEVzbfdZ6HoDOFnIQx8ksd17t4zRCw9CvGBRY=;
        b=W4NqLoYE+DCj30qBKwkbig1u4yMfITS5LyJqL6/sthLDDAypHHaaRXP30P6sg3AmMuxGwu
        zcCWnaId19SSf0Bw==
From:   "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Remove X86_FEATURE_NAMES
Cc:     Borislav Petkov <bp@alien8.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230510065713.10996-3-lukas.bulwahn@gmail.com>
References: <20230510065713.10996-3-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Message-ID: <168418699755.404.9114186141681237882.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     7583e8fbdc49a4dbd916d14863cf1deeddb982f9
Gitweb:        https://git.kernel.org/tip/7583e8fbdc49a4dbd916d14863cf1deeddb982f9
Author:        Lukas Bulwahn <lukas.bulwahn@gmail.com>
AuthorDate:    Wed, 10 May 2023 08:57:13 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 May 2023 20:03:08 +02:00

x86/cpu: Remove X86_FEATURE_NAMES

While discussing to change the visibility of X86_FEATURE_NAMES (see Link)
in order to remove CONFIG_EMBEDDED, Boris suggested to simply make the
X86_FEATURE_NAMES functionality unconditional.

As the need for really tiny kernel images has gone away and kernel images
with !X86_FEATURE_NAMES are hardly tested, remove this config and the whole
ifdeffery in the source code.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/20230509084007.24373-1-lukas.bulwahn@gmail.com/
Link: https://lore.kernel.org/r/20230510065713.10996-3-lukas.bulwahn@gmail.com
---
 arch/x86/Kconfig                  | 12 ------------
 arch/x86/Kconfig.cpu              |  2 +-
 arch/x86/boot/Makefile            |  2 --
 arch/x86/boot/cpu.c               | 13 -------------
 arch/x86/include/asm/cpufeature.h |  5 -----
 arch/x86/kernel/cpu/Makefile      |  4 +---
 arch/x86/kernel/cpu/common.c      |  4 ----
 7 files changed, 2 insertions(+), 40 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a7db116..f6aa7e0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -291,7 +291,6 @@ config X86
 	select TRACE_IRQFLAGS_NMI_SUPPORT
 	select USER_STACKTRACE_SUPPORT
 	select HAVE_ARCH_KCSAN			if X86_64
-	select X86_FEATURE_NAMES		if PROC_FS
 	select PROC_PID_ARCH_STATUS		if PROC_FS
 	select HAVE_ARCH_NODE_DEV_GROUP		if X86_SGX
 	select FUNCTION_ALIGNMENT_16B		if X86_64 || X86_ALIGNMENT_16
@@ -441,17 +440,6 @@ config SMP
 
 	  If you don't know what to do here, say N.
 
-config X86_FEATURE_NAMES
-	bool
-	default y
-	help
-	  This option compiles in a table of x86 feature bits and corresponding
-	  names.  This is required to support /proc/cpuinfo and a few kernel
-	  messages.  You can disable this to save space, at the expense of
-	  making those few kernel messages show numeric feature bits instead.
-
-	  If in doubt, say Y.
-
 config X86_X2APIC
 	bool "Support x2apic"
 	depends on X86_LOCAL_APIC && X86_64 && (IRQ_REMAP || HYPERVISOR_GUEST)
diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 542377c..00468ad 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -389,7 +389,7 @@ config IA32_FEAT_CTL
 
 config X86_VMX_FEATURE_NAMES
 	def_bool y
-	depends on IA32_FEAT_CTL && X86_FEATURE_NAMES
+	depends on IA32_FEAT_CTL
 
 menuconfig PROCESSOR_SELECT
 	bool "Supported processor vendors" if EXPERT
diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 9e38ffa..f33e45e 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -55,14 +55,12 @@ HOST_EXTRACFLAGS += -I$(srctree)/tools/include \
 		    -include include/generated/autoconf.h \
 	            -D__EXPORTED_HEADERS__
 
-ifdef CONFIG_X86_FEATURE_NAMES
 $(obj)/cpu.o: $(obj)/cpustr.h
 
 quiet_cmd_cpustr = CPUSTR  $@
       cmd_cpustr = $(obj)/mkcpustr > $@
 $(obj)/cpustr.h: $(obj)/mkcpustr FORCE
 	$(call if_changed,cpustr)
-endif
 targets += cpustr.h
 
 # ---------------------------------------------------------------------------
diff --git a/arch/x86/boot/cpu.c b/arch/x86/boot/cpu.c
index 0bbf4f3..feb6dbd 100644
--- a/arch/x86/boot/cpu.c
+++ b/arch/x86/boot/cpu.c
@@ -14,9 +14,7 @@
  */
 
 #include "boot.h"
-#ifdef CONFIG_X86_FEATURE_NAMES
 #include "cpustr.h"
-#endif
 
 static char *cpu_name(int level)
 {
@@ -35,7 +33,6 @@ static char *cpu_name(int level)
 static void show_cap_strs(u32 *err_flags)
 {
 	int i, j;
-#ifdef CONFIG_X86_FEATURE_NAMES
 	const unsigned char *msg_strs = (const unsigned char *)x86_cap_strs;
 	for (i = 0; i < NCAPINTS; i++) {
 		u32 e = err_flags[i];
@@ -58,16 +55,6 @@ static void show_cap_strs(u32 *err_flags)
 			e >>= 1;
 		}
 	}
-#else
-	for (i = 0; i < NCAPINTS; i++) {
-		u32 e = err_flags[i];
-		for (j = 0; j < 32; j++) {
-			if (e & 1)
-				printf("%d:%d ", i, j);
-			e >>= 1;
-		}
-	}
-#endif
 }
 
 int validate_cpu(void)
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index ce0c8f7..a26bebb 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -38,15 +38,10 @@ enum cpuid_leafs
 #define X86_CAP_FMT_NUM "%d:%d"
 #define x86_cap_flag_num(flag) ((flag) >> 5), ((flag) & 31)
 
-#ifdef CONFIG_X86_FEATURE_NAMES
 extern const char * const x86_cap_flags[NCAPINTS*32];
 extern const char * const x86_power_flags[32];
 #define X86_CAP_FMT "%s"
 #define x86_cap_flag(flag) x86_cap_flags[flag]
-#else
-#define X86_CAP_FMT X86_CAP_FMT_NUM
-#define x86_cap_flag x86_cap_flag_num
-#endif
 
 /*
  * In order to save room, we index into this array by doing
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index d7e3cea..4350f6b 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -27,7 +27,7 @@ obj-y			+= cpuid-deps.o
 obj-y			+= umwait.o
 
 obj-$(CONFIG_PROC_FS)	+= proc.o
-obj-$(CONFIG_X86_FEATURE_NAMES) += capflags.o powerflags.o
+obj-y += capflags.o powerflags.o
 
 obj-$(CONFIG_IA32_FEAT_CTL) += feat_ctl.o
 ifdef CONFIG_CPU_SUP_INTEL
@@ -54,7 +54,6 @@ obj-$(CONFIG_X86_LOCAL_APIC)		+= perfctr-watchdog.o
 obj-$(CONFIG_HYPERVISOR_GUEST)		+= vmware.o hypervisor.o mshyperv.o
 obj-$(CONFIG_ACRN_GUEST)		+= acrn.o
 
-ifdef CONFIG_X86_FEATURE_NAMES
 quiet_cmd_mkcapflags = MKCAP   $@
       cmd_mkcapflags = $(CONFIG_SHELL) $(srctree)/$(src)/mkcapflags.sh $@ $^
 
@@ -63,5 +62,4 @@ vmxfeature = $(src)/../../include/asm/vmxfeatures.h
 
 $(obj)/capflags.c: $(cpufeature) $(vmxfeature) $(src)/mkcapflags.sh FORCE
 	$(call if_changed,mkcapflags)
-endif
 targets += capflags.c
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 80710a6..849ed7e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1502,12 +1502,10 @@ static void __init cpu_parse_early_param(void)
 		if (!kstrtouint(opt, 10, &bit)) {
 			if (bit < NCAPINTS * 32) {
 
-#ifdef CONFIG_X86_FEATURE_NAMES
 				/* empty-string, i.e., ""-defined feature flags */
 				if (!x86_cap_flags[bit])
 					pr_cont(" " X86_CAP_FMT_NUM, x86_cap_flag_num(bit));
 				else
-#endif
 					pr_cont(" " X86_CAP_FMT, x86_cap_flag(bit));
 
 				setup_clear_cpu_cap(bit);
@@ -1520,7 +1518,6 @@ static void __init cpu_parse_early_param(void)
 			continue;
 		}
 
-#ifdef CONFIG_X86_FEATURE_NAMES
 		for (bit = 0; bit < 32 * NCAPINTS; bit++) {
 			if (!x86_cap_flag(bit))
 				continue;
@@ -1537,7 +1534,6 @@ static void __init cpu_parse_early_param(void)
 
 		if (!found)
 			pr_cont(" (unknown: %s)", opt);
-#endif
 	}
 	pr_cont("\n");
 
