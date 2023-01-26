Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1578E67C81A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237043AbjAZKMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236911AbjAZKMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:12:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF639646A4;
        Thu, 26 Jan 2023 02:12:32 -0800 (PST)
Date:   Thu, 26 Jan 2023 10:12:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674727947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kA/2pfShbrv9r951XbAH8XdetMRq+kl9ocZsq4lHtqw=;
        b=wEMrsJoa0BvcC8WzTwKJgoEIcPsbt/5WVQrUn314U4UpnjeD0r6gD/bhvShtEC7nY8p+gi
        2WPmcypTwWRX1frNiGHJGXR8/3TNvbrpS0cKqV/NRAHYYsgPOgu6nmuVzlPifGajcqE45j
        nh8nsAHFUMI5gjHtp28CrLoal3w+fmrQhcGuKd1QhHrqDi+KVISgjHpcYQirswioBvou/J
        mqDn1wOSa7piJeTOZgO+DFjVzLEAH3TSKqK6H9V1Z3fMQYRQmgZpCtfw58jeWriovTsWd2
        SDlevV89zVZ68KtCk6L07VTjh4ZcTX6z59P0XsP9pg8mH727md6ecsJ2DiQUJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674727947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kA/2pfShbrv9r951XbAH8XdetMRq+kl9ocZsq4lHtqw=;
        b=INQGFUMBstWlH+1A4/h5Tqem0NKjjq7hdUn/Lljiq2nl3cpqtNSfZ0nfmCDDLUQKKhYBFh
        tcZsWEEtr24XbgAA==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu, kvm: Add the NO_NESTED_DATA_BP feature
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230124163319.2277355-4-kim.phillips@amd.com>
References: <20230124163319.2277355-4-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <167472794735.4906.7514311983673336382.tip-bot2@tip-bot2>
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

Commit-ID:     a9dc9ec5a1fafc3d2fe7a7b594eefaeaccf89a6b
Gitweb:        https://git.kernel.org/tip/a9dc9ec5a1fafc3d2fe7a7b594eefaeaccf89a6b
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Tue, 24 Jan 2023 10:33:14 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 25 Jan 2023 12:36:34 +01:00

x86/cpu, kvm: Add the NO_NESTED_DATA_BP feature

The "Processor ignores nested data breakpoints" feature was being
open-coded for KVM.  Add the feature to its newly introduced CPUID leaf
0x80000021 EAX proper.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20230124163319.2277355-4-kim.phillips@amd.com
---
 arch/x86/include/asm/cpufeatures.h | 3 +++
 arch/x86/kvm/cpuid.c               | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index b890058..1b2d40a 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -427,6 +427,9 @@
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* "" Virtual TSC_AUX */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
 
+/* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
+#define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* "" No Nested Data Breakpoints */
+
 /*
  * BUG word(s)
  */
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index f3edc35..aa3a6dc 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -742,7 +742,7 @@ void kvm_set_cpu_caps(void)
 		F(SME_COHERENT));
 
 	kvm_cpu_cap_mask(CPUID_8000_0021_EAX,
-		BIT(0) /* NO_NESTED_DATA_BP */ |
+		F(NO_NESTED_DATA_BP) |
 		BIT(2) /* LFENCE Always serializing */ | 0 /* SmmPgCfgLock */ |
 		BIT(6) /* NULL_SEL_CLR_BASE */ | 0 /* PrefetchCtlMsr */
 	);
