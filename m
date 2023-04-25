Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69AF6EE89D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 21:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbjDYTuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 15:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbjDYTum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 15:50:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80505122
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 12:50:41 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 05A911EC054E;
        Tue, 25 Apr 2023 21:50:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1682452240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=uQb3cJDbr8NufWinJ2nO95njqU0edu2eFs6NC58m+Y8=;
        b=dA1ouBW/TU8s1DIdlebqgCPD/gDVsJPkan5ExvgXt33DdXBCLLkp8U6fjOhFTw5kla7fCQ
        qPj/Pg4p1OQ5TNkV6ipKAW4MWBlA4kpU+15IY4t/Ggkn+4lgUa5MQcOgOETtQgGA4jDEuI
        odm8IPDuapIZXzDh/QS1IR0CfAZizos=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/CPU/AMD: Rename the spectral chicken
Date:   Tue, 25 Apr 2023 21:50:24 +0200
Message-Id: <20230425195024.17808-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

We've had enough fun with the spectral chicken bit - name it what it
really does: it suppresses non-branch predictions.

Rename defines to make it clear that it is Zen2 only.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/msr-index.h |  6 ++++--
 arch/x86/kernel/cpu/amd.c        | 22 +++++++++++-----------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index ad35355ee43e..0094e6a1b553 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -625,8 +625,10 @@
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 
-#define MSR_ZEN2_SPECTRAL_CHICKEN	0xc00110e3
-#define MSR_ZEN2_SPECTRAL_CHICKEN_BIT	BIT_ULL(1)
+/* Fam 17h, Zen2 MSRs */
+#define MSR_ZEN2_DE_CFG2			0xc00110e3
+#define MSR_ZEN2_DE_CFG2_SUPPRESS_NOBR_PRED_BIT	1
+#define MSR_ZEN2_DE_CFG2_SUPPRESS_NOBR_PRED	BIT(MSR_ZEN2_DE_CFG2_SUPPRESS_NOBR_PRED_BIT)
 
 /* Fam 16h MSRs */
 #define MSR_F16H_L2I_PERF_CTL		0xc0010230
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 571abf808ea3..70a41088e900 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -860,23 +860,23 @@ static void init_amd_bd(struct cpuinfo_x86 *c)
 	clear_rdrand_cpuid_bit(c);
 }
 
-void init_spectral_chicken(struct cpuinfo_x86 *c)
+void init_amd_zn2(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_CPU_UNRET_ENTRY
 	u64 value;
 
 	/*
-	 * On Zen2 we offer this chicken (bit) on the altar of Speculation.
+	 * Suppress speculation from the middle of a basic block, i.e.
+	 * non-branch predictions.
 	 *
-	 * This suppresses speculation from the middle of a basic block, i.e. it
-	 * suppresses non-branch predictions.
-	 *
-	 * We use STIBP as a heuristic to filter out Zen2 from the rest of F17H
+	 * STIBP is used as a heuristic to filter out Zen2 from the rest
+	 * of family 0x17.
 	 */
-	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) && cpu_has(c, X86_FEATURE_AMD_STIBP)) {
-		if (!rdmsrl_safe(MSR_ZEN2_SPECTRAL_CHICKEN, &value)) {
-			value |= MSR_ZEN2_SPECTRAL_CHICKEN_BIT;
-			wrmsrl_safe(MSR_ZEN2_SPECTRAL_CHICKEN, value);
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
+	     cpu_has(c, X86_FEATURE_AMD_STIBP)) {
+		if (!rdmsrl_safe(MSR_ZEN2_DE_CFG2, &value)) {
+			value |= MSR_ZEN2_DE_CFG2_SUPPRESS_NOBR_PRED;
+			wrmsrl_safe(MSR_ZEN2_DE_CFG2, value);
 		}
 	}
 #endif
@@ -949,7 +949,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 	case 0x12: init_amd_ln(c); break;
 	case 0x15: init_amd_bd(c); break;
 	case 0x16: init_amd_jg(c); break;
-	case 0x17: init_spectral_chicken(c);
+	case 0x17: init_amd_zn2(c);
 		   fallthrough;
 	case 0x19: init_amd_zn(c); break;
 	}
-- 
2.35.1

