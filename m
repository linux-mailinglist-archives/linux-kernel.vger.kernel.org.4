Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C58632359
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiKUNWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiKUNW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:22:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45698BB;
        Mon, 21 Nov 2022 05:22:25 -0800 (PST)
Date:   Mon, 21 Nov 2022 13:22:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669036943;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jfhKsxVdcYuSS4iVLaMXHyFpJCAusOp0IRAhGPptqaw=;
        b=hmyUWD+wABAkTih7MeofHzD3Ij2JLyozdukr3NAjkQmg3+cgNMm6cbm3ODDkYd0U8KL9QS
        UODEc9+iXZJnkhUPDgoC49qRVz5K3Mus7LAYYJhvov2O9Evbj5e2fg3OPdOiKswLPDgP2j
        AiZCoOX86Hp+I3ptPPRpPV5pbyiJO6vcjMWYz8x+Kg+QpqAaCPj7Vu8ICeuJWbyhDo7QxT
        Z5y8WRoSgH8sWUbGhR2uNjGgosM+KDIao5ecmhHPbEeEGcca7cL+33yuxlfPQSebpYM8WF
        OGGFfOdePtZnfbRxbNz4/ZKNUcsa1+eh00dhtBc9C/2x409NiaMEp4yPG7LW0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669036943;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jfhKsxVdcYuSS4iVLaMXHyFpJCAusOp0IRAhGPptqaw=;
        b=wVzr8HN4kYEk/1CyjjgSxIFge2rTi9wFzl8O4RnwJ0qRDsAproZjpRIb1QxplLddcDaRPK
        AvronD3WMxZo+rCA==
From:   "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/tsx: Add a feature bit for TSX control MSR support
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <stable@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cde619764e1d98afbb7a5fa58424f1278ede37b45=2E16685?=
 =?utf-8?q?39735=2Egit=2Epawan=2Ekumar=2Egupta=40linux=2Eintel=2Ecom=3E?=
References: =?utf-8?q?=3Cde619764e1d98afbb7a5fa58424f1278ede37b45=2E166853?=
 =?utf-8?q?9735=2Egit=2Epawan=2Ekumar=2Egupta=40linux=2Eintel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <166903694262.4906.2840275250764271155.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     aaa65d17eec372c6a9756833f3964ba05b05ea14
Gitweb:        https://git.kernel.org/tip/aaa65d17eec372c6a9756833f3964ba05b05ea14
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Tue, 15 Nov 2022 11:17:05 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 21 Nov 2022 14:08:20 +01:00

x86/tsx: Add a feature bit for TSX control MSR support

Support for the TSX control MSR is enumerated in MSR_IA32_ARCH_CAPABILITIES.
This is different from how other CPU features are enumerated i.e. via
CPUID. Currently, a call to tsx_ctrl_is_supported() is required for
enumerating the feature. In the absence of a feature bit for TSX control,
any code that relies on checking feature bits directly will not work.

In preparation for adding a feature bit check in MSR save/restore
during suspend/resume, set a new feature bit X86_FEATURE_TSX_CTRL when
MSR_IA32_TSX_CTRL is present. Also make tsx_ctrl_is_supported() use the
new feature bit to avoid any overhead of reading the MSR.

  [ bp: Remove tsx_ctrl_is_supported(), add room for two more feature
    bits in word 11 which are coming up in the next merge window. ]

Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/de619764e1d98afbb7a5fa58424f1278ede37b45.1668539735.git.pawan.kumar.gupta@linux.intel.com
---
 arch/x86/include/asm/cpufeatures.h |  3 ++-
 arch/x86/kernel/cpu/tsx.c          | 38 ++++++++++++-----------------
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index b71f4f2..b2da7cb 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -305,6 +305,9 @@
 #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime firmware calls */
 #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit when EIBRS is enabled */
 
+
+#define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
+
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index ec7bbac..8009c83 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -58,24 +58,6 @@ static void tsx_enable(void)
 	wrmsrl(MSR_IA32_TSX_CTRL, tsx);
 }
 
-static bool tsx_ctrl_is_supported(void)
-{
-	u64 ia32_cap = x86_read_arch_cap_msr();
-
-	/*
-	 * TSX is controlled via MSR_IA32_TSX_CTRL.  However, support for this
-	 * MSR is enumerated by ARCH_CAP_TSX_MSR bit in MSR_IA32_ARCH_CAPABILITIES.
-	 *
-	 * TSX control (aka MSR_IA32_TSX_CTRL) is only available after a
-	 * microcode update on CPUs that have their MSR_IA32_ARCH_CAPABILITIES
-	 * bit MDS_NO=1. CPUs with MDS_NO=0 are not planned to get
-	 * MSR_IA32_TSX_CTRL support even after a microcode update. Thus,
-	 * tsx= cmdline requests will do nothing on CPUs without
-	 * MSR_IA32_TSX_CTRL support.
-	 */
-	return !!(ia32_cap & ARCH_CAP_TSX_CTRL_MSR);
-}
-
 static enum tsx_ctrl_states x86_get_tsx_auto_mode(void)
 {
 	if (boot_cpu_has_bug(X86_BUG_TAA))
@@ -135,7 +117,7 @@ static void tsx_clear_cpuid(void)
 		rdmsrl(MSR_TSX_FORCE_ABORT, msr);
 		msr |= MSR_TFA_TSX_CPUID_CLEAR;
 		wrmsrl(MSR_TSX_FORCE_ABORT, msr);
-	} else if (tsx_ctrl_is_supported()) {
+	} else if (cpu_feature_enabled(X86_FEATURE_MSR_TSX_CTRL)) {
 		rdmsrl(MSR_IA32_TSX_CTRL, msr);
 		msr |= TSX_CTRL_CPUID_CLEAR;
 		wrmsrl(MSR_IA32_TSX_CTRL, msr);
@@ -158,7 +140,8 @@ static void tsx_dev_mode_disable(void)
 	u64 mcu_opt_ctrl;
 
 	/* Check if RTM_ALLOW exists */
-	if (!boot_cpu_has_bug(X86_BUG_TAA) || !tsx_ctrl_is_supported() ||
+	if (!boot_cpu_has_bug(X86_BUG_TAA) ||
+	    !cpu_feature_enabled(X86_FEATURE_MSR_TSX_CTRL) ||
 	    !cpu_feature_enabled(X86_FEATURE_SRBDS_CTRL))
 		return;
 
@@ -191,7 +174,20 @@ void __init tsx_init(void)
 		return;
 	}
 
-	if (!tsx_ctrl_is_supported()) {
+	/*
+	 * TSX is controlled via MSR_IA32_TSX_CTRL.  However, support for this
+	 * MSR is enumerated by ARCH_CAP_TSX_MSR bit in MSR_IA32_ARCH_CAPABILITIES.
+	 *
+	 * TSX control (aka MSR_IA32_TSX_CTRL) is only available after a
+	 * microcode update on CPUs that have their MSR_IA32_ARCH_CAPABILITIES
+	 * bit MDS_NO=1. CPUs with MDS_NO=0 are not planned to get
+	 * MSR_IA32_TSX_CTRL support even after a microcode update. Thus,
+	 * tsx= cmdline requests will do nothing on CPUs without
+	 * MSR_IA32_TSX_CTRL support.
+	 */
+	if (x86_read_arch_cap_msr() & ARCH_CAP_TSX_CTRL_MSR) {
+		setup_force_cpu_cap(X86_FEATURE_MSR_TSX_CTRL);
+	} else {
 		tsx_ctrl_state = TSX_CTRL_NOT_SUPPORTED;
 		return;
 	}
