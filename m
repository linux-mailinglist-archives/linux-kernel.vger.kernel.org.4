Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5F962423D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiKJMWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiKJMWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:22:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB57C71F37;
        Thu, 10 Nov 2022 04:22:01 -0800 (PST)
Date:   Thu, 10 Nov 2022 12:21:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668082920;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YWlPPt79KZVQ4iVF+rQ2uLTDqlEKiYXb05/erd5wIAc=;
        b=VpwwBNHRpHnNA4BGE4NdGw8XWqeKb1REdhKei2LYNiXafcuX/ADrPCCgjCADUn5TgwTZyx
        VgbGZcIePDLD5QbTO1a8JkHzNzZGKPGXwE+js61QXWi7PMD05oA7auFF86+xqWNMDOb8YP
        HqRQoLxIswSUVia9rDnk6TczEtTDIEhWSB+T/meWlVWoRYYInmKR0Z/TILUudQDrHFmzSI
        1EN4VD7bjtHjZgomJsmcjO4snKVyxTagznI2VYpXkNLlMqvgx7QcmCyHhR7Cb2BjOCtH/X
        49uM+hlHHTkQG4x9X+BvyuEPFXtU9B8Bft0fiCvVopNz4HRw6AMZwXYJwV+TQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668082920;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YWlPPt79KZVQ4iVF+rQ2uLTDqlEKiYXb05/erd5wIAc=;
        b=We81QvbcApQDduVHkfkDX2V5FHfEgUDy/l34TPBbG5nTAvZI2MIDh2Dq6IAG/G2Kflr8Be
        +ws0lJP8llLPf+AA==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mtrr: Replace use_intel() with a local flag
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221102074713.21493-4-jgross@suse.com>
References: <20221102074713.21493-4-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <166808291924.4906.14811957457604547770.tip-bot2@tip-bot2>
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

Commit-ID:     45fa71f19a2d73f157d6892a8d677a738a0414fd
Gitweb:        https://git.kernel.org/tip/45fa71f19a2d73f157d6892a8d677a738a0414fd
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Wed, 02 Nov 2022 08:47:00 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 10 Nov 2022 13:12:44 +01:00

x86/mtrr: Replace use_intel() with a local flag

In MTRR code use_intel() is only used in one source file, and the
relevant use_intel_if member of struct mtrr_ops is set only in
generic_mtrr_ops.

Replace use_intel() with a single flag in cacheinfo.c which can be
set when assigning generic_mtrr_ops to mtrr_if. This allows to drop
use_intel_if from mtrr_ops, while preparing to decouple PAT from MTRR.
As another preparation for the PAT/MTRR decoupling use a bit for MTRR
control and one for PAT control. For now set both bits together, this
can be changed later.

As the new flag will be set only if mtrr_enabled is set, the test for
mtrr_enabled can be dropped at some places.

  [ bp: Massage commit message. ]

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221102074713.21493-4-jgross@suse.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/cacheinfo.h   |  5 +++++
 arch/x86/kernel/cpu/cacheinfo.c    |  3 +++
 arch/x86/kernel/cpu/mtrr/generic.c |  1 -
 arch/x86/kernel/cpu/mtrr/mtrr.c    | 28 +++++++++++++---------------
 arch/x86/kernel/cpu/mtrr/mtrr.h    |  2 --
 5 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
index 86b2e0d..c387396 100644
--- a/arch/x86/include/asm/cacheinfo.h
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -2,6 +2,11 @@
 #ifndef _ASM_X86_CACHEINFO_H
 #define _ASM_X86_CACHEINFO_H
 
+/* Kernel controls MTRR and/or PAT MSRs. */
+extern unsigned int memory_caching_control;
+#define CACHE_MTRR 0x01
+#define CACHE_PAT  0x02
+
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu);
 void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu);
 
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 6655683..32fb049 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -35,6 +35,9 @@ DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
 /* Shared L2 cache maps */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_l2c_shared_map);
 
+/* Kernel controls MTRR and/or PAT MSRs. */
+unsigned int memory_caching_control __ro_after_init;
+
 struct _cache_table {
 	unsigned char descriptor;
 	char cache_type;
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index c8f8951..7bbaba4 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -917,7 +917,6 @@ int positive_have_wrcomb(void)
  * Generic structure...
  */
 const struct mtrr_ops generic_mtrr_ops = {
-	.use_intel_if		= 1,
 	.set_all		= generic_set_all,
 	.get			= generic_get_mtrr,
 	.get_free_region	= generic_get_free_region,
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 2746cac..4209945 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -46,6 +46,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/rcupdate.h>
 
+#include <asm/cacheinfo.h>
 #include <asm/cpufeature.h>
 #include <asm/e820/api.h>
 #include <asm/mtrr.h>
@@ -119,11 +120,11 @@ static int have_wrcomb(void)
 }
 
 /*  This function returns the number of variable MTRRs  */
-static void __init set_num_var_ranges(void)
+static void __init set_num_var_ranges(bool use_generic)
 {
 	unsigned long config = 0, dummy;
 
-	if (use_intel())
+	if (use_generic)
 		rdmsr(MSR_MTRRcap, config, dummy);
 	else if (is_cpu(AMD) || is_cpu(HYGON))
 		config = 2;
@@ -756,14 +757,16 @@ void __init mtrr_bp_init(void)
 
 	if (mtrr_if) {
 		__mtrr_enabled = true;
-		set_num_var_ranges();
+		set_num_var_ranges(mtrr_if == &generic_mtrr_ops);
 		init_table();
-		if (use_intel()) {
+		if (mtrr_if == &generic_mtrr_ops) {
 			/* BIOS may override */
 			__mtrr_enabled = get_mtrr_state();
 
-			if (mtrr_enabled())
+			if (mtrr_enabled()) {
 				mtrr_bp_pat_init();
+				memory_caching_control |= CACHE_MTRR | CACHE_PAT;
+			}
 
 			if (mtrr_cleanup(phys_addr)) {
 				changed_by_mtrr_cleanup = 1;
@@ -786,10 +789,7 @@ void __init mtrr_bp_init(void)
 
 void mtrr_ap_init(void)
 {
-	if (!mtrr_enabled())
-		return;
-
-	if (!use_intel() || mtrr_aps_delayed_init)
+	if (!memory_caching_control || mtrr_aps_delayed_init)
 		return;
 
 	/*
@@ -825,9 +825,7 @@ void mtrr_save_state(void)
 
 void set_mtrr_aps_delayed_init(void)
 {
-	if (!mtrr_enabled())
-		return;
-	if (!use_intel())
+	if (!memory_caching_control)
 		return;
 
 	mtrr_aps_delayed_init = true;
@@ -838,7 +836,7 @@ void set_mtrr_aps_delayed_init(void)
  */
 void mtrr_aps_init(void)
 {
-	if (!use_intel() || !mtrr_enabled())
+	if (!memory_caching_control)
 		return;
 
 	/*
@@ -855,7 +853,7 @@ void mtrr_aps_init(void)
 
 void mtrr_bp_restore(void)
 {
-	if (!use_intel() || !mtrr_enabled())
+	if (!memory_caching_control)
 		return;
 
 	mtrr_if->set_all();
@@ -866,7 +864,7 @@ static int __init mtrr_init_finialize(void)
 	if (!mtrr_enabled())
 		return 0;
 
-	if (use_intel()) {
+	if (memory_caching_control & CACHE_MTRR) {
 		if (!changed_by_mtrr_cleanup)
 			mtrr_state_warn();
 		return 0;
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index 2ac99e5..88b1c4b 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -14,7 +14,6 @@ extern unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
 
 struct mtrr_ops {
 	u32	vendor;
-	u32	use_intel_if;
 	void	(*set)(unsigned int reg, unsigned long base,
 		       unsigned long size, mtrr_type type);
 	void	(*set_all)(void);
@@ -61,7 +60,6 @@ extern u64 size_or_mask, size_and_mask;
 extern const struct mtrr_ops *mtrr_if;
 
 #define is_cpu(vnd)	(mtrr_if && mtrr_if->vendor == X86_VENDOR_##vnd)
-#define use_intel()	(mtrr_if && mtrr_if->use_intel_if == 1)
 
 extern unsigned int num_var_ranges;
 extern u64 mtrr_tom2;
