Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95F66F435E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjEBMKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjEBMKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:10:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D175B91
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:10:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 519131F8BE;
        Tue,  2 May 2023 12:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683029399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iz4BA8Ek2PzktS8oo1/Q1i3Iw9Dle1tAUkZ/LigItnA=;
        b=IBsmynQOKerg+++i2T4viCklaDY9nYRLO1sajvBgcvXbv9HclACbC4xc9tT6csDzx+bhjD
        xHyb3ZoTY/30ovgTvex/1Esj/RpEsYybANl3XOlaR3+pOGn9Jq35pzZFeL0R7bSFxAzxSM
        Kay7lr4vFQCiAzIXmzdnUwkCib28clM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0CCD5139C3;
        Tue,  2 May 2023 12:09:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xv7YAZf9UGSeLwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 02 May 2023 12:09:59 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     mikelley@microsoft.com, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v6 03/16] x86/mtrr: support setting MTRR state for software defined MTRRs
Date:   Tue,  2 May 2023 14:09:18 +0200
Message-Id: <20230502120931.20719-4-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230502120931.20719-1-jgross@suse.com>
References: <20230502120931.20719-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running virtualized, MTRR access can be reduced (e.g. in Xen PV
guests or when running as a SEV-SNP guest under Hyper-V). Typically
the hypervisor will reset the MTRR feature in CPUID data, resulting
in no MTRR memory type information being available for the kernel.

This has turned out to result in problems:

- Hyper-V SEV-SNP guests using uncached mappings where they shouldn't
- Xen PV dom0 mapping memory as WB which should be UC- instead

Solve those problems allowing an MTRR static state override,
overwriting the empty state used today. In case such a state has been
set, don't call get_mtrr_state() in mtrr_bp_init(). The set state
will only be used by mtrr_type_lookup(), as in all other cases
mtrr_enabled() is being checked, which will return false. Accept the
overwrite call only for selected cases when running as a guest.
Disable X86_FEATURE_MTRR in order to avoid any MTRR modifications by
just refusing them.

Link: https://lore.kernel.org/lkml/BYAPR21MB16883ABC186566BD4D2A1451D7FE9@BYAPR21MB1688.namprd21.prod.outlook.com/
Link: https://lore.kernel.org/all/4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de/
Signed-off-by: Juergen Gross <jgross@suse.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
---
V2:
- new patch
V3:
- omit fixed MTRRs, as those are currently not needed
- disable X86_FEATURE_MTRR instead of testing it
- provide a stub for !CONFIG_MTRR (Michael Kelley)
- use cpu_feature_enabled() (Boris Petkov)
- add tests for mtrr_overwrite_state() being allowed (Boris Petkov)
V4:
- add test for hv_is_isolation_supported() (Michael Kelley)
V5:
- drop test for running as native (Boris Petkov)
- split large complex test into multiple simple ones (Boris Petkov)
- enhance test in mtrr_bp_init() (Boris Petkov)
V6:
- expand comments (Kai Huang)
- add links to commit message (Boris Petkov)
---
 arch/x86/include/asm/mtrr.h        |  8 ++++
 arch/x86/kernel/cpu/mtrr/generic.c | 60 +++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/mtrr/mtrr.c    | 14 ++++++-
 arch/x86/kernel/setup.c            |  2 +
 4 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 15379aa41edc..9837fe34e58b 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -50,6 +50,8 @@
  */
 # ifdef CONFIG_MTRR
 void mtrr_bp_init(void);
+void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_var,
+			  mtrr_type def_type);
 extern u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform);
 extern void mtrr_save_fixed_ranges(void *);
 extern void mtrr_save_state(void);
@@ -67,6 +69,12 @@ void mtrr_disable(void);
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
index ad2a396233c1..29e3bf921f26 100644
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
@@ -249,6 +251,62 @@ static u8 mtrr_type_lookup_variable(u64 start, u64 end, u64 *partial_end,
 	return mtrr_state.def_type;
 }
 
+/**
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
+	if (WARN_ON(mtrr_state_set))
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
 /**
  * mtrr_type_lookup - look up memory type in MTRR
  *
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index fddc4e0c6626..9173ed396508 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -625,11 +625,23 @@ int __initdata changed_by_mtrr_cleanup;
  */
 void __init mtrr_bp_init(void)
 {
+	bool generic_mtrrs = cpu_feature_enabled(X86_FEATURE_MTRR);
 	const char *why = "(not available)";
 
 	mtrr_set_mask();
 
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
index 16babff771bd..0cccfeb67c3a 100644
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
 
-- 
2.35.3

