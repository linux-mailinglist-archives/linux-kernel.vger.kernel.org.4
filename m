Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F25862423C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiKJMWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiKJMWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:22:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BC071F39;
        Thu, 10 Nov 2022 04:21:59 -0800 (PST)
Date:   Thu, 10 Nov 2022 12:21:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668082918;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aLcUelJ2A0i8y7/IOu2BtBIP0gHvDvi3R6Me7UncgnA=;
        b=scZwJADqttdDQB9jffBstrgW81K6mAgWff7VZKY1fWj+5384ZOhuNC4rTEcy0lvZjmdS6L
        96FkYdlUF1cbInbsFHNfe/hnqrSiNPsVIEUY4kDgT5nlBkqEmMw1Ege7rwOIp5CnX7iv7f
        WWeO0fbpg20OxoZom+c+5oNaeG+YgjC2BN2QE2myB1ynjAul0FrOFIs8CNoechn7D8y+te
        ot7+manaS4h7ZnmtwCQORfdp9SKoaav/hiFY0zD508mTyW0KHLAtujEGX3alhF7mp0BEX1
        uxG6dHEbKdz6FbOZUJ9RjOikDDbboaz50CqpW0JB2IW4xlCd42cU/5c/txA2tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668082918;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aLcUelJ2A0i8y7/IOu2BtBIP0gHvDvi3R6Me7UncgnA=;
        b=NgEPCkQ0BgAQ7ue9reic0Tlgpp3jX/A13kmYg8NpnBEn2nHKYfxrWQi5X0bYOwGtIBfJ5i
        8t/LOCprNybL26Dg==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mtrr: Split MTRR-specific handling from cache dis/enabling
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221102074713.21493-6-jgross@suse.com>
References: <20221102074713.21493-6-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <166808291702.4906.9360364596007729426.tip-bot2@tip-bot2>
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

Commit-ID:     4ad7149e46d048d3a543c96d35c1d255208dd33a
Gitweb:        https://git.kernel.org/tip/4ad7149e46d048d3a543c96d35c1d255208dd33a
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Wed, 02 Nov 2022 08:47:02 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 10 Nov 2022 13:12:44 +01:00

x86/mtrr: Split MTRR-specific handling from cache dis/enabling

Split the MTRR-specific actions from cache_disable() and cache_enable()
into new functions mtrr_disable() and mtrr_enable().

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221102074713.21493-6-jgross@suse.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/mtrr.h        |  4 ++++
 arch/x86/kernel/cpu/mtrr/generic.c | 26 +++++++++++++++++++-------
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 76d7260..12a16ca 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -48,6 +48,8 @@ extern void mtrr_aps_init(void);
 extern void mtrr_bp_restore(void);
 extern int mtrr_trim_uncached_memory(unsigned long end_pfn);
 extern int amd_special_default_mtrr(void);
+void mtrr_disable(void);
+void mtrr_enable(void);
 #  else
 static inline u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform)
 {
@@ -87,6 +89,8 @@ static inline void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi)
 #define set_mtrr_aps_delayed_init() do {} while (0)
 #define mtrr_aps_init() do {} while (0)
 #define mtrr_bp_restore() do {} while (0)
+#define mtrr_disable() do {} while (0)
+#define mtrr_enable() do {} while (0)
 #  endif
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 2f3fc28..0db0770 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -716,6 +716,21 @@ static unsigned long set_mtrr_state(void)
 	return change_mask;
 }
 
+void mtrr_disable(void)
+{
+	/* Save MTRR state */
+	rdmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
+
+	/* Disable MTRRs, and set the default type to uncached */
+	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo & ~0xcff, deftype_hi);
+}
+
+void mtrr_enable(void)
+{
+	/* Intel (P6) standard MTRRs */
+	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
+}
+
 /*
  * Disable and enable caches. Needed for changing MTRRs and the PAT MSR.
  *
@@ -764,11 +779,8 @@ void cache_disable(void) __acquires(cache_disable_lock)
 	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
 	flush_tlb_local();
 
-	/* Save MTRR state */
-	rdmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
-
-	/* Disable MTRRs, and set the default type to uncached */
-	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo & ~0xcff, deftype_hi);
+	if (cpu_feature_enabled(X86_FEATURE_MTRR))
+		mtrr_disable();
 
 	/* Again, only flush caches if we have to. */
 	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
@@ -781,8 +793,8 @@ void cache_enable(void) __releases(cache_disable_lock)
 	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
 	flush_tlb_local();
 
-	/* Intel (P6) standard MTRRs */
-	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
+	if (cpu_feature_enabled(X86_FEATURE_MTRR))
+		mtrr_enable();
 
 	/* Enable caches */
 	write_cr0(read_cr0() & ~X86_CR0_CD);
