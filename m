Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064AC722866
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbjFEOJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbjFEOIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:08:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A94E52;
        Mon,  5 Jun 2023 07:08:19 -0700 (PDT)
Date:   Mon, 05 Jun 2023 14:08:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685974097;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IMASNQXLiYv3zDUFUZ6wkhcxEXx/lGSnr/FdQPi8F0U=;
        b=m0lnw26ZZEv8DMw4AdcHHEbhb0lBD+XjamMRqED38/wuOOdIXv9JaEU+Mcaqd0KaxsbyFs
        zv3RHLjMGtjyI/KI/R2/0+D698nEiKAXHM1I6/jcne5UAqmUdIaH6PGcQFcH+6FBc0kZFl
        s08s/CLkbi/B/YizFGwA52vHhalQNA3gShoE/6RB72dvQH+Dw15knueut+vvAHMRuQUawJ
        2za2n0/tsjLJh3Hq8p34HUCeeCfi5obzC6QgoCRkJvFW79py7GhvFHX1GAhqqqLpQbqQtn
        D6hPcV48LgdxC8P1E53+w6Fev8J03CKKoGwoNP6ntP6xOLeNuAtpROWqoZYrBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685974097;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IMASNQXLiYv3zDUFUZ6wkhcxEXx/lGSnr/FdQPi8F0U=;
        b=14aBrR2N2jYuXU1ZMsbNouiw4p4L+eevkEUKtELerL3RsrDyPBtJ4MnrmIwtTMOBIWGzK/
        uWvr+YG6qSpnh9Bw==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mtrr] x86/mtrr: Support setting MTRR state for software
 defined MTRRs
Cc:     Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3CBYAPR21MB16883ABC186566BD4D2A1451D7FE9=40BYAPR21MB?=
 =?utf-8?q?1688=2Enamprd21=2Eprod=2Eoutlook=2Ecom=3E?=
References: =?utf-8?q?=3CBYAPR21MB16883ABC186566BD4D2A1451D7FE9=40BYAPR21M?=
 =?utf-8?q?B1688=2Enamprd21=2Eprod=2Eoutlook=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <168597409717.404.6474758887257669176.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mtrr branch of tip:

Commit-ID:     29055dc74287467bd7a053d60b4afe753832960d
Gitweb:        https://git.kernel.org/tip/29055dc74287467bd7a053d60b4afe753832960d
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Tue, 02 May 2023 14:09:18 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 01 Jun 2023 15:04:32 +02:00

x86/mtrr: Support setting MTRR state for software defined MTRRs

When running virtualized, MTRR access can be reduced (e.g. in Xen PV
guests or when running as a SEV-SNP guest under Hyper-V). Typically, the
hypervisor will not advertize the MTRR feature in CPUID data, resulting
in no MTRR memory type information being available for the kernel.

This has turned out to result in problems (Link tags below):

- Hyper-V SEV-SNP guests using uncached mappings where they shouldn't
- Xen PV dom0 mapping memory as WB which should be UC- instead

Solve those problems by allowing an MTRR static state override,
overwriting the empty state used today. In case such a state has been
set, don't call get_mtrr_state() in mtrr_bp_init().

The set state will only be used by mtrr_type_lookup(), as in all other
cases mtrr_enabled() is being checked, which will return false. Accept
the overwrite call only for selected cases when running as a guest.
Disable X86_FEATURE_MTRR in order to avoid any MTRR modifications by
just refusing them.

  [ bp: Massage. ]

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/all/4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de/
Link: https://lore.kernel.org/lkml/BYAPR21MB16883ABC186566BD4D2A1451D7FE9@BYAPR21MB1688.namprd21.prod.outlook.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/mtrr.h        |  8 ++++-
 arch/x86/kernel/cpu/mtrr/generic.c | 60 ++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/mtrr/mtrr.c    | 14 ++++++-
 arch/x86/kernel/setup.c            |  2 +-
 4 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 1421fe8..1bae790 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -58,6 +58,8 @@ struct mtrr_state_type {
  */
 # ifdef CONFIG_MTRR
 void mtrr_bp_init(void);
+void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_var,
+			  mtrr_type def_type);
 extern u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform);
 extern void mtrr_save_fixed_ranges(void *);
 extern void mtrr_save_state(void);
@@ -75,6 +77,12 @@ void mtrr_disable(void);
 void mtrr_enable(void);
 void mtrr_generic_set_state(void);
 #  else
+static inline void mtrr_overwrite_state(struct mtrr_var_range *var,
+					unsigned int num_var,
+					mtrr_type def_type)
+{
+}
+
 static inline u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform)
 {
 	/*
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 08ba558..e81d832 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -8,10 +8,12 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/mm.h>
-
+#include <linux/cc_platform.h>
 #include <asm/processor-flags.h>
 #include <asm/cacheinfo.h>
 #include <asm/cpufeature.h>
+#include <asm/hypervisor.h>
+#include <asm/mshyperv.h>
 #include <asm/tlbflush.h>
 #include <asm/mtrr.h>
 #include <asm/msr.h>
@@ -243,6 +245,62 @@ static u8 mtrr_type_lookup_variable(u64 start, u64 end, u64 *partial_end,
 }
 
 /**
+ * mtrr_overwrite_state - set static MTRR state
+ *
+ * Used to set MTRR state via different means (e.g. with data obtained from
+ * a hypervisor).
+ * Is allowed only for special cases when running virtualized. Must be called
+ * from the x86_init.hyper.init_platform() hook.  It can be called only once.
+ * The MTRR state can't be changed afterwards.  To ensure that, X86_FEATURE_MTRR
+ * is cleared.
+ */
+void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_var,
+			  mtrr_type def_type)
+{
+	unsigned int i;
+
+	/* Only allowed to be called once before mtrr_bp_init(). */
+	if (WARN_ON_ONCE(mtrr_state_set))
+		return;
+
+	/* Only allowed when running virtualized. */
+	if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+		return;
+
+	/*
+	 * Only allowed for special virtualization cases:
+	 * - when running as Hyper-V, SEV-SNP guest using vTOM
+	 * - when running as Xen PV guest
+	 * - when running as SEV-SNP or TDX guest to avoid unnecessary
+	 *   VMM communication/Virtualization exceptions (#VC, #VE)
+	 */
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP) &&
+	    !hv_is_isolation_supported() &&
+	    !cpu_feature_enabled(X86_FEATURE_XENPV) &&
+	    !cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return;
+
+	/* Disable MTRR in order to disable MTRR modifications. */
+	setup_clear_cpu_cap(X86_FEATURE_MTRR);
+
+	if (var) {
+		if (num_var > MTRR_MAX_VAR_RANGES) {
+			pr_warn("Trying to overwrite MTRR state with %u variable entries\n",
+				num_var);
+			num_var = MTRR_MAX_VAR_RANGES;
+		}
+		for (i = 0; i < num_var; i++)
+			mtrr_state.var_ranges[i] = var[i];
+		num_var_ranges = num_var;
+	}
+
+	mtrr_state.def_type = def_type;
+	mtrr_state.enabled |= MTRR_STATE_MTRR_ENABLED;
+
+	mtrr_state_set = 1;
+}
+
+/**
  * mtrr_type_lookup - look up memory type in MTRR
  *
  * Return Values:
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 1067f12..be35a0b 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -625,11 +625,23 @@ int __initdata changed_by_mtrr_cleanup;
  */
 void __init mtrr_bp_init(void)
 {
+	bool generic_mtrrs = cpu_feature_enabled(X86_FEATURE_MTRR);
 	const char *why = "(not available)";
 
 	phys_hi_rsvd = GENMASK(31, boot_cpu_data.x86_phys_bits - 32);
 
-	if (cpu_feature_enabled(X86_FEATURE_MTRR)) {
+	if (!generic_mtrrs && mtrr_state.enabled) {
+		/*
+		 * Software overwrite of MTRR state, only for generic case.
+		 * Note that X86_FEATURE_MTRR has been reset in this case.
+		 */
+		init_table();
+		pr_info("MTRRs set to read-only\n");
+
+		return;
+	}
+
+	if (generic_mtrrs) {
 		mtrr_if = &generic_mtrr_ops;
 	} else {
 		switch (boot_cpu_data.x86_vendor) {
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 16babff..0cccfeb 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1037,6 +1037,8 @@ void __init setup_arch(char **cmdline_p)
 	/*
 	 * VMware detection requires dmi to be available, so this
 	 * needs to be done after dmi_setup(), for the boot CPU.
+	 * For some guest types (Xen PV, SEV-SNP, TDX) it is required to be
+	 * called before cache_bp_init() for setting up MTRR state.
 	 */
 	init_hypervisor_platform();
 
