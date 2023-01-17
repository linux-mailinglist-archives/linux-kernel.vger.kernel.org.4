Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A67670DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjAQXgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjAQXez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:34:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0034ABFA;
        Tue, 17 Jan 2023 13:25:28 -0800 (PST)
Date:   Tue, 17 Jan 2023 21:25:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673990724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=npxTRuCXN8Zea0Y5+TsmPieCTiZPV77v7bfWVZBrhBY=;
        b=ebDD0jZZphOcD4ua2PdkST0jLkKJ6fpmF9O4BPstVQQPYY3tdRdG81lRdjT5lBlLYJ1sGC
        Wo0kow4hWm4qg2QB55jMZSUEIibNP1E8PDu2WZbRmX8Tret+JeENLLZkfy2gYSljATBcGj
        ZhJa7VIVU17daSYBJto03SpGV6QIs4i0Bq92cWYdTY0O2OOw5YAUa9QzFJkun3X/+YP03D
        GK08DVOR+xzAyVhUcNdLYvMSzQntKnWNpaqamJBFjeUpwNKuhV8M9u35K4rw3tbSr2SqdK
        /5fnoF5L8NDUX/Cc8Wmy+sgxctH89EUUJiij/jkNTOtEbzxmOT0vqF75jAFJbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673990724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=npxTRuCXN8Zea0Y5+TsmPieCTiZPV77v7bfWVZBrhBY=;
        b=r0NoYGO1JYA3Flb291jYZ3rrdCMLL/0iWPSFhegtq/ibCQ+THv7JZvWKah+POfXIIToDXF
        FUNqNJKnoNZMfwCw==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu, kvm: Add support for CPUID_80000021_EAX
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230110224643.452273-3-kim.phillips@amd.com>
References: <20230110224643.452273-3-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <167399072423.4906.5544069451240267115.tip-bot2@tip-bot2>
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

Commit-ID:     15fea09b029d43fd1f3069f5e957ce9dc282f052
Gitweb:        https://git.kernel.org/tip/15fea09b029d43fd1f3069f5e957ce9dc282f052
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Tue, 10 Jan 2023 16:46:37 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 17 Jan 2023 13:00:12 +01:00

x86/cpu, kvm: Add support for CPUID_80000021_EAX

Add support for CPUID leaf 80000021, EAX. The majority of the features will be
used in the kernel and thus a separate leaf is appropriate.

Include KVM's reverse_cpuid entry because features are used by VM guests, too.

  [ bp: Massage commit message. ]

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230110224643.452273-3-kim.phillips@amd.com
---
 arch/x86/include/asm/cpufeature.h        | 7 +++++--
 arch/x86/include/asm/cpufeatures.h       | 2 +-
 arch/x86/include/asm/disabled-features.h | 3 ++-
 arch/x86/include/asm/required-features.h | 3 ++-
 arch/x86/kernel/cpu/common.c             | 3 +++
 arch/x86/kvm/reverse_cpuid.h             | 1 +
 6 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 1a85e1f..ce0c8f7 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -32,6 +32,7 @@ enum cpuid_leafs
 	CPUID_8000_0007_EBX,
 	CPUID_7_EDX,
 	CPUID_8000_001F_EAX,
+	CPUID_8000_0021_EAX,
 };
 
 #define X86_CAP_FMT_NUM "%d:%d"
@@ -94,8 +95,9 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 17, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 18, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 19, feature_bit) ||	\
+	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 20, feature_bit) ||	\
 	   REQUIRED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 20))
+	   BUILD_BUG_ON_ZERO(NCAPINTS != 21))
 
 #define DISABLED_MASK_BIT_SET(feature_bit)				\
 	 ( CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  0, feature_bit) ||	\
@@ -118,8 +120,9 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 17, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 18, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 19, feature_bit) ||	\
+	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 20, feature_bit) ||	\
 	   DISABLED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 20))
+	   BUILD_BUG_ON_ZERO(NCAPINTS != 21))
 
 #define cpu_has(c, bit)							\
 	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index b70111a..b890058 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -13,7 +13,7 @@
 /*
  * Defines x86 CPU feature bits
  */
-#define NCAPINTS			20	   /* N 32-bit words worth of info */
+#define NCAPINTS			21	   /* N 32-bit words worth of info */
 #define NBUGINTS			1	   /* N 32-bit bug flags */
 
 /*
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index c44b56f..5dfa4fb 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -124,6 +124,7 @@
 #define DISABLED_MASK17	0
 #define DISABLED_MASK18	0
 #define DISABLED_MASK19	0
-#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 20)
+#define DISABLED_MASK20	0
+#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
 
 #endif /* _ASM_X86_DISABLED_FEATURES_H */
diff --git a/arch/x86/include/asm/required-features.h b/arch/x86/include/asm/required-features.h
index aff7747..7ba1726 100644
--- a/arch/x86/include/asm/required-features.h
+++ b/arch/x86/include/asm/required-features.h
@@ -98,6 +98,7 @@
 #define REQUIRED_MASK17	0
 #define REQUIRED_MASK18	0
 #define REQUIRED_MASK19	0
-#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 20)
+#define REQUIRED_MASK20	0
+#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
 
 #endif /* _ASM_X86_REQUIRED_FEATURES_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b7ac85a..e6f3234 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1093,6 +1093,9 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 	if (c->extended_cpuid_level >= 0x8000001f)
 		c->x86_capability[CPUID_8000_001F_EAX] = cpuid_eax(0x8000001f);
 
+	if (c->extended_cpuid_level >= 0x80000021)
+		c->x86_capability[CPUID_8000_0021_EAX] = cpuid_eax(0x80000021);
+
 	init_scattered_cpuid_features(c);
 	init_speculation_control(c);
 
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 042d0ac..81f4e9c 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -68,6 +68,7 @@ static const struct cpuid_reg reverse_cpuid[] = {
 	[CPUID_12_EAX]        = {0x00000012, 0, CPUID_EAX},
 	[CPUID_8000_001F_EAX] = {0x8000001f, 0, CPUID_EAX},
 	[CPUID_7_1_EDX]       = {         7, 1, CPUID_EDX},
+	[CPUID_8000_0021_EAX] = {0x80000021, 0, CPUID_EAX},
 };
 
 /*
