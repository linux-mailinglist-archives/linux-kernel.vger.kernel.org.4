Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5722B733968
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345883AbjFPTRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjFPTQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:16:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1D23A89;
        Fri, 16 Jun 2023 12:16:54 -0700 (PDT)
Date:   Fri, 16 Jun 2023 19:16:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686943013;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qWh/uv/IOxzofOXqu/vw8jGxKqMCPqxajzUehM3UiHI=;
        b=a8+PDz2lSpjfGQYtbtyy2PdVuEb5FKc4bfSZWAA7cKlpv8naLZoWwWeXh43R0drNSzVko2
        suPrn8TWS/Vzy/50YboJoUYa1K5NFoY6RgKwY38pezUEP72NhwPH+2JLiIz8sm1VTpRDTI
        8mI2wsZXnluDpie4SY6UCC42h4lVjUL0WNpOriAPYqVnsEuc8CSgGGRyNa57DpCk0MrbRz
        TtbGrFkARuG8/7j9AMy2cjqdJzFuuXsuGkIGXlyottXskO6oG68NVPczeAbjAxAsSR9PCg
        BeofWlBZP7MFY+KfFhaaVaKy1Glhl3sZelME/IlPraYTRojGC4J+mx8zvzjyTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686943013;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qWh/uv/IOxzofOXqu/vw8jGxKqMCPqxajzUehM3UiHI=;
        b=rKuoPAu1tLIftrK66EjC23r2T9ld8v056g7j783taiCfM5FzcOSOqac05LZpzYD6cO2cVo
        6zjT5Stav4pOUoDg==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/cpufeatures: Enable CET CR4 bit for shadow stack
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168694301275.404.7996656612537090188.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     101c5ebd3d94551038d115485895b020d838a9ea
Gitweb:        https://git.kernel.org/tip/101c5ebd3d94551038d115485895b020d838a9ea
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:11:04 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Jun 2023 16:31:34 -07:00

x86/cpufeatures: Enable CET CR4 bit for shadow stack

Setting CR4.CET is a prerequisite for utilizing any CET features, most of
which also require setting MSRs.

Kernel IBT already enables the CET CR4 bit when it detects IBT HW support
and is configured with kernel IBT. However, future patches that enable
userspace shadow stack support will need the bit set as well. So change
the logic to enable it in either case.

Clear MSR_IA32_U_CET in cet_disable() so that it can't live to see
userspace in a new kexec-ed kernel that has CR4.CET set from kernel IBT.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-39-rick.p.edgecombe%40intel.com
---
 arch/x86/kernel/cpu/common.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 80710a6..3ea06b0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -601,27 +601,43 @@ __noendbr void ibt_restore(u64 save)
 
 static __always_inline void setup_cet(struct cpuinfo_x86 *c)
 {
-	u64 msr = CET_ENDBR_EN;
+	bool user_shstk, kernel_ibt;
 
-	if (!HAS_KERNEL_IBT ||
-	    !cpu_feature_enabled(X86_FEATURE_IBT))
+	if (!IS_ENABLED(CONFIG_X86_CET))
 		return;
 
-	wrmsrl(MSR_IA32_S_CET, msr);
+	kernel_ibt = HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT);
+	user_shstk = cpu_feature_enabled(X86_FEATURE_SHSTK) &&
+		     IS_ENABLED(CONFIG_X86_USER_SHADOW_STACK);
+
+	if (!kernel_ibt && !user_shstk)
+		return;
+
+	if (user_shstk)
+		set_cpu_cap(c, X86_FEATURE_USER_SHSTK);
+
+	if (kernel_ibt)
+		wrmsrl(MSR_IA32_S_CET, CET_ENDBR_EN);
+	else
+		wrmsrl(MSR_IA32_S_CET, 0);
+
 	cr4_set_bits(X86_CR4_CET);
 
-	if (!ibt_selftest()) {
+	if (kernel_ibt && !ibt_selftest()) {
 		pr_err("IBT selftest: Failed!\n");
 		wrmsrl(MSR_IA32_S_CET, 0);
 		setup_clear_cpu_cap(X86_FEATURE_IBT);
-		return;
 	}
 }
 
 __noendbr void cet_disable(void)
 {
-	if (cpu_feature_enabled(X86_FEATURE_IBT))
-		wrmsrl(MSR_IA32_S_CET, 0);
+	if (!(cpu_feature_enabled(X86_FEATURE_IBT) ||
+	      cpu_feature_enabled(X86_FEATURE_SHSTK)))
+		return;
+
+	wrmsrl(MSR_IA32_S_CET, 0);
+	wrmsrl(MSR_IA32_U_CET, 0);
 }
 
 /*
@@ -1483,6 +1499,9 @@ static void __init cpu_parse_early_param(void)
 	if (cmdline_find_option_bool(boot_command_line, "noxsaves"))
 		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
 
+	if (cmdline_find_option_bool(boot_command_line, "nousershstk"))
+		setup_clear_cpu_cap(X86_FEATURE_USER_SHSTK);
+
 	arglen = cmdline_find_option(boot_command_line, "clearcpuid", arg, sizeof(arg));
 	if (arglen <= 0)
 		return;
