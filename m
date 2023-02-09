Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC3F69012A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjBIHXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBIHXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:23:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AB31C59E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 23:22:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A942F34DB4;
        Thu,  9 Feb 2023 07:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675927354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6KlzZtRVU/BktL0oxuQOwlCZm+eOW7c+Ihxdj/RddRU=;
        b=SghSS7PtDhKUO4VPKdXdgTYUXvRc6OBO3BazFVVGVDSKJq1l9SDT4wz6p9G9ynon3ndyEI
        UetnZPhGah5APTgvI58VZrC1vMRgjtivd3NkzGtzqDzXMtLOF+mwAYOpTh4b9s22cC8Fka
        YnfIYXeaPFKaGefmU0jzkBfIdtmECHk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5CC2D1339E;
        Thu,  9 Feb 2023 07:22:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SPNcFTqf5GPzeAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 09 Feb 2023 07:22:34 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software defined MTRRs
Date:   Thu,  9 Feb 2023 08:22:14 +0100
Message-Id: <20230209072220.6836-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230209072220.6836-1-jgross@suse.com>
References: <20230209072220.6836-1-jgross@suse.com>
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

When running virtualized, MTRR access can be reduced (e.g. in Xen PV
guests or when running as a SEV-SNP guest under Hyper-V). Typically
the hypervisor will reset the MTRR feature in cpuid data, resulting
in no MTRR memory type information being available for the kernel.

This has turned out to result in problems:

- Hyper-V SEV-SNP guests using uncached mappings where they shouldn't
- Xen PV dom0 mapping memory as WB which should be UC- instead

Solve those problems by supporting to set a fixed MTRR state,
overwriting the empty state used today. In case such a state has been
set, don't call get_mtrr_state() in mtrr_bp_init(). The set state
will only be used by mtrr_type_lookup(), as in all other cases
mtrr_enabled() is being checked, which will return false. Accept the
overwrite call only in case of MTRRs being disabled in cpuid.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
---
 arch/x86/include/asm/mtrr.h        |  2 ++
 arch/x86/kernel/cpu/mtrr/generic.c | 38 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mtrr/mtrr.c    |  9 +++++++
 3 files changed, 49 insertions(+)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index f0eeaf6e5f5f..0b8f51d683dc 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -31,6 +31,8 @@
  */
 # ifdef CONFIG_MTRR
 void mtrr_bp_init(void);
+void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_var,
+			  mtrr_type *fixed, mtrr_type def_type);
 extern u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform);
 extern void mtrr_save_fixed_ranges(void *);
 extern void mtrr_save_state(void);
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index ee09d359e08f..788bc16888a5 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -240,6 +240,44 @@ static u8 mtrr_type_lookup_variable(u64 start, u64 end, u64 *partial_end,
 	return mtrr_state.def_type;
 }
 
+/**
+ * mtrr_overwrite_state - set fixed MTRR state
+ *
+ * Used to set MTRR state via different means (e.g. with data obtained from
+ * a hypervisor).
+ */
+void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_var,
+			  mtrr_type *fixed, mtrr_type def_type)
+{
+	unsigned int i;
+
+	if (boot_cpu_has(X86_FEATURE_MTRR))
+		return;
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
+	if (fixed) {
+		for (i = 0; i < MTRR_NUM_FIXED_RANGES; i++)
+			mtrr_state.fixed_ranges[i] = fixed[i];
+		mtrr_state.enabled |= MTRR_STATE_MTRR_FIXED_ENABLED;
+		mtrr_state.have_fixed = 1;
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
index 542ca5639dfd..b73fe243c7fd 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -668,6 +668,15 @@ void __init mtrr_bp_init(void)
 	const char *why = "(not available)";
 	unsigned int phys_addr;
 
+	if (mtrr_state.enabled) {
+		/* Software overwrite of MTRR state, only for generic case. */
+		mtrr_calc_physbits(true);
+		init_table();
+		pr_info("MTRRs set to read-only\n");
+
+		return;
+	}
+
 	phys_addr = mtrr_calc_physbits(boot_cpu_has(X86_FEATURE_MTRR));
 
 	if (boot_cpu_has(X86_FEATURE_MTRR)) {
-- 
2.35.3

