Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54DE6011C5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiJQOzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiJQOyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:54:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F301C7646;
        Mon, 17 Oct 2022 07:53:57 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018430;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iESZwYUsl9VoA6IO1HubGWuLJwmOnpSg5W5sq0VFvpY=;
        b=PG0VFA76O1XYhaJnSTqSv9Ybwy6Z2TLurVWS35R8xqpaTMKWLeW9lQ934SJggY5jfcaAwl
        eeq1pHnProYSusosXb6h4fYFIfHIqEezjFt/bG8+qD+CFLRYJ3U1mmMv6GSvjrNUrSEr37
        kaKxT1gTNOMUDcZg62qOso51o6Sd4fz26p+VEgTr4O/tY3Ra1Q3+hbtNJZgoM1zyuN+Tzn
        mtHPSQnhhZ5IhlqgvPkTWdySdTSRGJNFR3D66zK1I5+YBih/itxtBVd3JOIVm3h/kluXjn
        VpvgNSzREv6q3mkGyBQGnCDYj8emxY9nuchefs6MiA88Mq2MY343jSN2N8Cs/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018430;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iESZwYUsl9VoA6IO1HubGWuLJwmOnpSg5W5sq0VFvpY=;
        b=3iWFNB49as2W4iJ5CuFkEnoytp/x0lSUlN0ahOFoxSKOtpDgywdXUTqXMOsz2qoQNJaMGj
        mUghQYI4pywObKAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/retbleed: Add X86_FEATURE_CALL_DEPTH
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111147.056176424@infradead.org>
References: <20220915111147.056176424@infradead.org>
MIME-Version: 1.0
Message-ID: <166601842920.401.2168961504911360398.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     80e4c1cd42fff110bfdae8fce7ac4f22465f9664
Gitweb:        https://git.kernel.org/tip/80e4c1cd42fff110bfdae8fce7ac4f22465f9664
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:11:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:11 +02:00

x86/retbleed: Add X86_FEATURE_CALL_DEPTH

Intel SKL CPUs fall back to other predictors when the RSB underflows. The
only microcode mitigation is IBRS which is insanely expensive. It comes
with performance drops of up to 30% depending on the workload.

A way less expensive, but nevertheless horrible mitigation is to track the
call depth in software and overeagerly fill the RSB when returns underflow
the software counter.

Provide a configuration symbol and a CPU misfeature bit.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111147.056176424@infradead.org
---
 arch/x86/Kconfig                         | 19 +++++++++++++++++++
 arch/x86/include/asm/cpufeatures.h       |  1 +
 arch/x86/include/asm/disabled-features.h |  9 ++++++++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e368fc0..6ae7fa4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2523,6 +2523,25 @@ config CPU_UNRET_ENTRY
 	help
 	  Compile the kernel with support for the retbleed=unret mitigation.
 
+config CALL_DEPTH_TRACKING
+	bool "Mitigate RSB underflow with call depth tracking"
+	depends on CPU_SUP_INTEL && HAVE_CALL_THUNKS
+	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
+	select CALL_THUNKS
+	default y
+	help
+	  Compile the kernel with call depth tracking to mitigate the Intel
+	  SKL Return-Speculation-Buffer (RSB) underflow issue. The
+	  mitigation is off by default and needs to be enabled on the
+	  kernel command line via the retbleed=stuff option. For
+	  non-affected systems the overhead of this option is marginal as
+	  the call depth tracking is using run-time generated call thunks
+	  in a compiler generated padding area and call patching. This
+	  increases text size by ~5%. For non affected systems this space
+	  is unused. On affected SKL systems this results in a significant
+	  performance gain over the IBRS mitigation.
+
+
 config CPU_IBPB_ENTRY
 	bool "Enable IBPB on kernel entry"
 	depends on CPU_SUP_AMD && X86_64
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index b71f4f2..aefd081 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -304,6 +304,7 @@
 #define X86_FEATURE_UNRET		(11*32+15) /* "" AMD BTB untrain return */
 #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime firmware calls */
 #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit when EIBRS is enabled */
+#define X86_FEATURE_CALL_DEPTH		(11*32+18) /* "" Call depth tracking for RSB stuffing */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 33d2cd0..bbb03b2 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -69,6 +69,12 @@
 # define DISABLE_UNRET		(1 << (X86_FEATURE_UNRET & 31))
 #endif
 
+#ifdef CONFIG_CALL_DEPTH_TRACKING
+# define DISABLE_CALL_DEPTH_TRACKING	0
+#else
+# define DISABLE_CALL_DEPTH_TRACKING	(1 << (X86_FEATURE_CALL_DEPTH & 31))
+#endif
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 # define DISABLE_ENQCMD		0
 #else
@@ -101,7 +107,8 @@
 #define DISABLED_MASK8	(DISABLE_TDX_GUEST)
 #define DISABLED_MASK9	(DISABLE_SGX)
 #define DISABLED_MASK10	0
-#define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET)
+#define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
+			 DISABLE_CALL_DEPTH_TRACKING)
 #define DISABLED_MASK12	0
 #define DISABLED_MASK13	0
 #define DISABLED_MASK14	0
