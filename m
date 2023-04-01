Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03FB6D2EB5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 08:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbjDAGiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 02:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjDAGiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 02:38:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA9720C32
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 23:37:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7A0CB219FD;
        Sat,  1 Apr 2023 06:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680331055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mZHEzRhRpsOluDYn0rKzRSXTPPE43ZmgbokxRzXTPPA=;
        b=uUgy4V32tKBB48WW+9iOl5pSw3Z4xAs6bMDyJfBU1BnGbQoIUh6ZvcigaivyNPpL5pqOxn
        sloDs/1xBI2b5VynXFAVt2ixI3wVx2eJ1tsI6BH9tCUB4oIXbhJciEYzAYDY2ExmdNBtk2
        YNktr9WD4Ik+bToK8AgiLdmYrbnUEdE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E2AE134FB;
        Sat,  1 Apr 2023 06:37:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zSTiCS/RJ2RbdwAAMHmgww
        (envelope-from <jgross@suse.com>); Sat, 01 Apr 2023 06:37:35 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v5 07/15] x86/mtrr: replace vendor tests in MTRR code
Date:   Sat,  1 Apr 2023 08:36:44 +0200
Message-Id: <20230401063652.23522-8-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230401063652.23522-1-jgross@suse.com>
References: <20230401063652.23522-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modern CPUs all share the same MTRR interface implemented via
generic_mtrr_ops.

At several places in MTRR code this generic interface is deduced via
is_cpu(INTEL) tests, which is only working due to X86_VENDOR_INTEL
being 0 (the is_cpu() macro is testing mtrr_if->vendor, which isn't
explicitly set in generic_mtrr_ops).

Fix that by replacing the is_cpu(INTEL) tests with testing for mtrr_if
to be &generic_mtrr_ops.

The only other place where the .vendor member of struct mtrr_ops is
being used is in set_num_var_ranges(), where depending on the vendor
the number of MTRR registers is determined. This can easily be changed
by replacing .vendor with the static number of MTRR registers.

It should be noted that the test "is_cpu(HYGON)" wasn't ever returning
true, as there is no struct mtrr_ops with that vendor information.

Signed-off-by: Juergen Gross <jgross@suse.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
---
V3:
- new patch
V4:
- use cpu_feature_enabled(X86_FEATURE_MTRR) for testing generic MTRRs
  (Boris Petkov)
---
 arch/x86/kernel/cpu/mtrr/amd.c     | 2 +-
 arch/x86/kernel/cpu/mtrr/centaur.c | 2 +-
 arch/x86/kernel/cpu/mtrr/cleanup.c | 4 ++--
 arch/x86/kernel/cpu/mtrr/cyrix.c   | 2 +-
 arch/x86/kernel/cpu/mtrr/generic.c | 2 +-
 arch/x86/kernel/cpu/mtrr/mtrr.c    | 8 +++-----
 arch/x86/kernel/cpu/mtrr/mtrr.h    | 4 +---
 7 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/amd.c b/arch/x86/kernel/cpu/mtrr/amd.c
index eff6ac62c0ff..ef3e8e42b782 100644
--- a/arch/x86/kernel/cpu/mtrr/amd.c
+++ b/arch/x86/kernel/cpu/mtrr/amd.c
@@ -110,7 +110,7 @@ amd_validate_add_page(unsigned long base, unsigned long size, unsigned int type)
 }
 
 const struct mtrr_ops amd_mtrr_ops = {
-	.vendor            = X86_VENDOR_AMD,
+	.var_regs          = 2,
 	.set               = amd_set_mtrr,
 	.get               = amd_get_mtrr,
 	.get_free_region   = generic_get_free_region,
diff --git a/arch/x86/kernel/cpu/mtrr/centaur.c b/arch/x86/kernel/cpu/mtrr/centaur.c
index b8a74eddde83..4466ddeb0125 100644
--- a/arch/x86/kernel/cpu/mtrr/centaur.c
+++ b/arch/x86/kernel/cpu/mtrr/centaur.c
@@ -112,7 +112,7 @@ centaur_validate_add_page(unsigned long base, unsigned long size, unsigned int t
 }
 
 const struct mtrr_ops centaur_mtrr_ops = {
-	.vendor            = X86_VENDOR_CENTAUR,
+	.var_regs          = 8,
 	.set               = centaur_set_mcr,
 	.get               = centaur_get_mcr,
 	.get_free_region   = centaur_get_free_region,
diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cleanup.c
index ce45d7617874..0f27c38f3ff9 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -689,7 +689,7 @@ int __init mtrr_cleanup(unsigned address_bits)
 	int index_good;
 	int i;
 
-	if (!is_cpu(INTEL) || enable_mtrr_cleanup < 1)
+	if (!cpu_feature_enabled(X86_FEATURE_MTRR) || enable_mtrr_cleanup < 1)
 		return 0;
 
 	rdmsr(MSR_MTRRdefType, def, dummy);
@@ -886,7 +886,7 @@ int __init mtrr_trim_uncached_memory(unsigned long end_pfn)
 	 * Make sure we only trim uncachable memory on machines that
 	 * support the Intel MTRR architecture:
 	 */
-	if (!is_cpu(INTEL) || disable_mtrr_trim)
+	if (!cpu_feature_enabled(X86_FEATURE_MTRR) || disable_mtrr_trim)
 		return 0;
 
 	rdmsr(MSR_MTRRdefType, def, dummy);
diff --git a/arch/x86/kernel/cpu/mtrr/cyrix.c b/arch/x86/kernel/cpu/mtrr/cyrix.c
index 173b9e01e623..238dad57d4d6 100644
--- a/arch/x86/kernel/cpu/mtrr/cyrix.c
+++ b/arch/x86/kernel/cpu/mtrr/cyrix.c
@@ -235,7 +235,7 @@ static void cyrix_set_arr(unsigned int reg, unsigned long base,
 }
 
 const struct mtrr_ops cyrix_mtrr_ops = {
-	.vendor            = X86_VENDOR_CYRIX,
+	.var_regs          = 8,
 	.set               = cyrix_set_arr,
 	.get               = cyrix_get_arr,
 	.get_free_region   = cyrix_get_free_region,
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 0794f3f1cc27..5d60b46187f7 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -846,7 +846,7 @@ int generic_validate_add_page(unsigned long base, unsigned long size,
 	 * For Intel PPro stepping <= 7
 	 * must be 4 MiB aligned and not touch 0x70000000 -> 0x7003FFFF
 	 */
-	if (is_cpu(INTEL) && boot_cpu_data.x86 == 6 &&
+	if (mtrr_if == &generic_mtrr_ops && boot_cpu_data.x86 == 6 &&
 	    boot_cpu_data.x86_model == 1 &&
 	    boot_cpu_data.x86_stepping <= 7) {
 		if (base & ((1 << (22 - PAGE_SHIFT)) - 1)) {
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 1c19d67ddab3..46aae69d259e 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -108,14 +108,12 @@ static int have_wrcomb(void)
 /*  This function returns the number of variable MTRRs  */
 static void __init set_num_var_ranges(bool use_generic)
 {
-	unsigned long config = 0, dummy;
+	unsigned long config, dummy;
 
 	if (use_generic)
 		rdmsr(MSR_MTRRcap, config, dummy);
-	else if (is_cpu(AMD) || is_cpu(HYGON))
-		config = 2;
-	else if (is_cpu(CYRIX) || is_cpu(CENTAUR))
-		config = 8;
+	else
+		config = mtrr_if->var_regs;
 
 	num_var_ranges = config & MTRR_CONFIG_NUM_VAR_MASK;
 }
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index 02eb5871492d..a3c362d3d5bf 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -13,7 +13,7 @@
 extern unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
 
 struct mtrr_ops {
-	u32	vendor;
+	u32	var_regs;
 	void	(*set)(unsigned int reg, unsigned long base,
 		       unsigned long size, mtrr_type type);
 	void	(*get)(unsigned int reg, unsigned long *base,
@@ -54,8 +54,6 @@ bool get_mtrr_state(void);
 extern u64 size_or_mask, size_and_mask;
 extern const struct mtrr_ops *mtrr_if;
 
-#define is_cpu(vnd)	(mtrr_if && mtrr_if->vendor == X86_VENDOR_##vnd)
-
 extern unsigned int num_var_ranges;
 extern u64 mtrr_tom2;
 extern struct mtrr_state_type mtrr_state;
-- 
2.35.3

