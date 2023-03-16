Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1078A6BCD73
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjCPLE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCPLEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:04:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79846F95F;
        Thu, 16 Mar 2023 04:04:21 -0700 (PDT)
Date:   Thu, 16 Mar 2023 11:04:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678964659;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sZlU2pKxAMcTbPq1A4MQlpVefaseF7Jb/tqM8ClnzbU=;
        b=qvJtQYz70XSHkRM9BMzP8Uwp443ka7eke3cpCyzHPC0WOcvMatN3qfNSvDlmyj5UmkIjmf
        iZrS+h4H0A8QxYRKn4QImjjYJawE09+3W8tcOqRpQK5+ALXOX0IfeFvWbIQDSqbpL6jytW
        tfDK7VeWjqOwCwZ/o6dq4COtJRJWhYZ/VJo6++bWzdKaqtbhXLKkZ0SfziQPM0EuwmnBz2
        NuoCfYXbVeW6fjbeOuZhmjmXzXhputxriWANpybxcWQ22VzlfsROaEiMXqEkNCKaqi26ma
        5tDYtaf2wmhdUVpB793icW4OZetu6JXKu7ogGCcMmEoVMkUFb/6TAK/NQ+ghBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678964659;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sZlU2pKxAMcTbPq1A4MQlpVefaseF7Jb/tqM8ClnzbU=;
        b=w7Mv5gDacfSwMBukktA8XYL89Ci7oDaf+6ZuMLITciwBcA7pqP8L1JuiBIjAM/zhUi6r26
        l92MS2g2NUWymYAw==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/CPU/AMD: Make sure EFER[AIBRSE] is set
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230224185257.o3mcmloei5zqu7wa@treble>
References: <20230224185257.o3mcmloei5zqu7wa@treble>
MIME-Version: 1.0
Message-ID: <167896465869.5837.816655048478460304.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     8cc68c9c9e92dbaae51a711454c66eb668045508
Gitweb:        https://git.kernel.org/tip/8cc68c9c9e92dbaae51a711454c66eb668045508
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Sat, 25 Feb 2023 01:11:31 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 16 Mar 2023 11:50:00 +01:00

x86/CPU/AMD: Make sure EFER[AIBRSE] is set

The AutoIBRS bit gets set only on the BSP as part of determining which
mitigation to enable on AMD. Setting on the APs relies on the
circumstance that the APs get booted through the trampoline and EFER
- the MSR which contains that bit - gets replicated on every AP from the
BSP.

However, this can change in the future and considering the security
implications of this bit not being set on every CPU, make sure it is set
by verifying EFER later in the boot process and on every AP.

Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20230224185257.o3mcmloei5zqu7wa@treble
---
 arch/x86/kernel/cpu/amd.c  | 11 +++++++++++
 arch/x86/kernel/cpu/bugs.c | 10 +---------
 arch/x86/kernel/cpu/cpu.h  |  8 ++++++++
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 380753b..dd32dbc 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -996,6 +996,17 @@ static void init_amd(struct cpuinfo_x86 *c)
 		msr_set_bit(MSR_K7_HWCR, MSR_K7_HWCR_IRPERF_EN_BIT);
 
 	check_null_seg_clears_base(c);
+
+	/*
+	 * Make sure EFER[AIBRSE - Automatic IBRS Enable] is set. The APs are brought up
+	 * using the trampoline code and as part of it, MSR_EFER gets prepared there in
+	 * order to be replicated onto them. Regardless, set it here again, if not set,
+	 * to protect against any future refactoring/code reorganization which might
+	 * miss setting this important bit.
+	 */
+	if (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
+	    cpu_has(c, X86_FEATURE_AUTOIBRS))
+		WARN_ON_ONCE(msr_set_bit(MSR_EFER, _EFER_AUTOIBRS));
 }
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f9d060e..182af64 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -784,8 +784,7 @@ static int __init nospectre_v1_cmdline(char *str)
 }
 early_param("nospectre_v1", nospectre_v1_cmdline);
 
-static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
-	SPECTRE_V2_NONE;
+enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init = SPECTRE_V2_NONE;
 
 #undef pr_fmt
 #define pr_fmt(fmt)     "RETBleed: " fmt
@@ -1133,13 +1132,6 @@ spectre_v2_parse_user_cmdline(void)
 	return SPECTRE_V2_USER_CMD_AUTO;
 }
 
-static inline bool spectre_v2_in_eibrs_mode(enum spectre_v2_mitigation mode)
-{
-	return mode == SPECTRE_V2_EIBRS ||
-	       mode == SPECTRE_V2_EIBRS_RETPOLINE ||
-	       mode == SPECTRE_V2_EIBRS_LFENCE;
-}
-
 static inline bool spectre_v2_in_ibrs_mode(enum spectre_v2_mitigation mode)
 {
 	return spectre_v2_in_eibrs_mode(mode) || mode == SPECTRE_V2_IBRS;
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 57a5349..f97b0fe 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -83,4 +83,12 @@ unsigned int aperfmperf_get_khz(int cpu);
 extern void x86_spec_ctrl_setup_ap(void);
 extern void update_srbds_msr(void);
 
+extern enum spectre_v2_mitigation spectre_v2_enabled;
+
+static inline bool spectre_v2_in_eibrs_mode(enum spectre_v2_mitigation mode)
+{
+	return mode == SPECTRE_V2_EIBRS ||
+	       mode == SPECTRE_V2_EIBRS_RETPOLINE ||
+	       mode == SPECTRE_V2_EIBRS_LFENCE;
+}
 #endif /* ARCH_X86_CPU_H */
