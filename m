Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7475D615D1E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiKBHrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKBHrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:47:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC43625E8B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 00:47:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A41383373A;
        Wed,  2 Nov 2022 07:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667375252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z6gy2tyRJJ+OFyVFudtbf06b5xT5AM3xfmnxx6MsckU=;
        b=kB6M6YcMniF4XqArkgMZkLvV3UMLrbzfiFvOgWVIyGfmpeJvp3hRkiAbDedxmFIYgF2q2p
        ghgQo5Nl3tDpFd6AX7/hovwGDFmDXsurNIaH3Gpfy5HTKatdQV6wSsvr6LK7p9Kpc1rom/
        pKmdEsxvGDdJFcqRXP2Yz5Zc71NdyBo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B9761376E;
        Wed,  2 Nov 2022 07:47:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T0XlGJQgYmOmcgAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 02 Nov 2022 07:47:32 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 03/16] x86/mtrr: replace use_intel() with a local flag
Date:   Wed,  2 Nov 2022 08:47:00 +0100
Message-Id: <20221102074713.21493-4-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221102074713.21493-1-jgross@suse.com>
References: <20221102074713.21493-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In MTRR code use_intel() is only used in one source file, and the
relevant use_intel_if member of struct mtrr_ops is set only in
generic_mtrr_ops.

Replace use_intel() with a single flag in cacheinfo.c, which can be set
when assigning generic_mtrr_ops to mtrr_if. This allows to drop
use_intel_if from mtrr_ops, while preparing to support PAT without
MTRR. As another preparation for the PAT/MTRR decoupling use a bit for
MTRR control and one for PAT control. For now set both bits together,
this can be changed later.

As the new flag will be set only if mtrr_enabled is set, the test for
mtrr_enabled can be dropped at some places.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
V4:
- rename cache_generic to memory_caching_control (Borislav Petkov)
- rename CACHE_GENERIC_* to CACHE_* (Borislav Petkov)
- get rid of use_generic in mtrr_bp_init() (Borislav Petkov)
V5:
- keep mtrr_enabled() (Borislav Petkov)
---
 arch/x86/include/asm/cacheinfo.h   |  5 +++++
 arch/x86/kernel/cpu/cacheinfo.c    |  3 +++
 arch/x86/kernel/cpu/mtrr/generic.c |  1 -
 arch/x86/kernel/cpu/mtrr/mtrr.c    | 28 +++++++++++++---------------
 arch/x86/kernel/cpu/mtrr/mtrr.h    |  2 --
 5 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
index 86b2e0dcc4bf..c3873962a7cd 100644
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
index 66556833d7af..5228fb9a3798 100644
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
index cd64eab02393..81742870ecc5 100644
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
index 2746cac9d8a9..4209945c4e68 100644
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
index 2ac99e561181..88b1c4b6174a 100644
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
-- 
2.35.3

