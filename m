Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5F66C1CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjCTQu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjCTQtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:49:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D042298F3;
        Mon, 20 Mar 2023 09:42:17 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:39:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679330370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PV1zMBL8/kD5SBT4Ba63pSgdb3jwht8QqtfbRrNouUU=;
        b=VAQBhkoHnIzWg+0NlwwNLrV8DIQmi/1xBuMqdSsJVJ/EhdU2vyXentLbOuXVPNrF9xeBWf
        mu/F/N6DWhdIUJMErouvDUpziH3dBynjIxiCiNOrVSYZxM6azXK4KOJU3BiPsQUKB5EJrM
        6wDlNfVp9BLrOvTkkcORYBuDNGO8ZsfxinsDoBxJq3NIXU+kJbTYMs2DG3RnI4a/l+n0vz
        PuKAzGP75KHXCJU38GtMbAEH9qgVhCexMvUaaUbV0T5vEX8oUc87YjEfeKIX1p7D9pXniT
        DpmSCqEye6KPXuDvaAWv4JuNax2HhCdUljdG9Iln8fy0+SwtdxbwNstI6JAmYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679330370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PV1zMBL8/kD5SBT4Ba63pSgdb3jwht8QqtfbRrNouUU=;
        b=NPE3CyPOGckI4FHCEUmb3TVzf8b4MYUcJktnHwjtfaRbMyfCApMi8niq2x9zqT+Ur+RUBC
        rF2mgFyUB1QvUaBg==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/fpu/xstate: Introduce CET MSR and XSAVES
 supervisor states
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167933037035.5837.265279899602037254.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     44a100d0b9ee2c4dcb5c186d97e7dc711f5dfca9
Gitweb:        https://git.kernel.org/tip/44a100d0b9ee2c4dcb5c186d97e7dc711f5dfca9
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Sat, 18 Mar 2023 17:15:00 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 20 Mar 2023 09:01:08 -07:00

x86/fpu/xstate: Introduce CET MSR and XSAVES supervisor states

Shadow stack register state can be managed with XSAVE. The registers
can logically be separated into two groups:
        * Registers controlling user-mode operation
        * Registers controlling kernel-mode operation

The architecture has two new XSAVE state components: one for each group
of those groups of registers. This lets an OS manage them separately if
it chooses. Future patches for host userspace and KVM guests will only
utilize the user-mode registers, so only configure XSAVE to save
user-mode registers. This state will add 16 bytes to the xsave buffer
size.

Future patches will use the user-mode XSAVE area to save guest user-mode
CET state. However, VMCS includes new fields for guest CET supervisor
states. KVM can use these to save and restore guest supervisor state, so
host supervisor XSAVE support is not required.

Adding this exacerbates the already unwieldy if statement in
check_xstate_against_struct() that handles warning about un-implemented
xfeatures. So refactor these check's by having XCHECK_SZ() set a bool when
it actually check's the xfeature. This ends up exceeding 80 chars, but was
better on balance than other options explored. Pass the bool as pointer to
make it clear that XCHECK_SZ() can change the variable.

While configuring user-mode XSAVE, clarify kernel-mode registers are not
managed by XSAVE by defining the xfeature in
XFEATURE_MASK_SUPERVISOR_UNSUPPORTED, like is done for XFEATURE_MASK_PT.
This serves more of a documentation as code purpose, and functionally,
only enables a few safety checks.

Both XSAVE state components are supervisor states, even the state
controlling user-mode operation. This is a departure from earlier features
like protection keys where the PKRU state is a normal user
(non-supervisor) state. Having the user state be supervisor-managed
ensures there is no direct, unprivileged access to it, making it harder
for an attacker to subvert CET.

To facilitate this privileged access, define the two user-mode CET MSRs,
and the bits defined in those MSRs relevant to future shadow stack
enablement patches.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230319001535.23210-6-rick.p.edgecombe%40intel.com
---
 arch/x86/include/asm/fpu/types.h  | 16 ++++-
 arch/x86/include/asm/fpu/xstate.h |  6 +-
 arch/x86/kernel/fpu/xstate.c      | 90 ++++++++++++++----------------
 3 files changed, 61 insertions(+), 51 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 7f6d858..eb81007 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -115,8 +115,8 @@ enum xfeature {
 	XFEATURE_PT_UNIMPLEMENTED_SO_FAR,
 	XFEATURE_PKRU,
 	XFEATURE_PASID,
-	XFEATURE_RSRVD_COMP_11,
-	XFEATURE_RSRVD_COMP_12,
+	XFEATURE_CET_USER,
+	XFEATURE_CET_KERNEL_UNUSED,
 	XFEATURE_RSRVD_COMP_13,
 	XFEATURE_RSRVD_COMP_14,
 	XFEATURE_LBR,
@@ -138,6 +138,8 @@ enum xfeature {
 #define XFEATURE_MASK_PT		(1 << XFEATURE_PT_UNIMPLEMENTED_SO_FAR)
 #define XFEATURE_MASK_PKRU		(1 << XFEATURE_PKRU)
 #define XFEATURE_MASK_PASID		(1 << XFEATURE_PASID)
+#define XFEATURE_MASK_CET_USER		(1 << XFEATURE_CET_USER)
+#define XFEATURE_MASK_CET_KERNEL	(1 << XFEATURE_CET_KERNEL_UNUSED)
 #define XFEATURE_MASK_LBR		(1 << XFEATURE_LBR)
 #define XFEATURE_MASK_XTILE_CFG		(1 << XFEATURE_XTILE_CFG)
 #define XFEATURE_MASK_XTILE_DATA	(1 << XFEATURE_XTILE_DATA)
@@ -253,6 +255,16 @@ struct pkru_state {
 } __packed;
 
 /*
+ * State component 11 is Control-flow Enforcement user states
+ */
+struct cet_user_state {
+	/* user control-flow settings */
+	u64 user_cet;
+	/* user shadow stack pointer */
+	u64 user_ssp;
+};
+
+/*
  * State component 15: Architectural LBR configuration state.
  * The size of Arch LBR state depends on the number of LBRs (lbr_depth).
  */
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index cd3dd17..d4427b8 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -50,7 +50,8 @@
 #define XFEATURE_MASK_USER_DYNAMIC	XFEATURE_MASK_XTILE_DATA
 
 /* All currently supported supervisor features */
-#define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID)
+#define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID | \
+					    XFEATURE_MASK_CET_USER)
 
 /*
  * A supervisor state component may not always contain valuable information,
@@ -77,7 +78,8 @@
  * Unsupported supervisor features. When a supervisor feature in this mask is
  * supported in the future, move it to the supported supervisor feature mask.
  */
-#define XFEATURE_MASK_SUPERVISOR_UNSUPPORTED (XFEATURE_MASK_PT)
+#define XFEATURE_MASK_SUPERVISOR_UNSUPPORTED (XFEATURE_MASK_PT | \
+					      XFEATURE_MASK_CET_KERNEL)
 
 /* All supervisor states including supported and unsupported states. */
 #define XFEATURE_MASK_SUPERVISOR_ALL (XFEATURE_MASK_SUPERVISOR_SUPPORTED | \
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 714166c..13a8052 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -39,26 +39,26 @@
  */
 static const char *xfeature_names[] =
 {
-	"x87 floating point registers"	,
-	"SSE registers"			,
-	"AVX registers"			,
-	"MPX bounds registers"		,
-	"MPX CSR"			,
-	"AVX-512 opmask"		,
-	"AVX-512 Hi256"			,
-	"AVX-512 ZMM_Hi256"		,
-	"Processor Trace (unused)"	,
+	"x87 floating point registers",
+	"SSE registers",
+	"AVX registers",
+	"MPX bounds registers",
+	"MPX CSR",
+	"AVX-512 opmask",
+	"AVX-512 Hi256",
+	"AVX-512 ZMM_Hi256",
+	"Processor Trace (unused)",
 	"Protection Keys User registers",
 	"PASID state",
-	"unknown xstate feature"	,
-	"unknown xstate feature"	,
-	"unknown xstate feature"	,
-	"unknown xstate feature"	,
-	"unknown xstate feature"	,
-	"unknown xstate feature"	,
-	"AMX Tile config"		,
-	"AMX Tile data"			,
-	"unknown xstate feature"	,
+	"Control-flow User registers",
+	"Control-flow Kernel registers (unused)",
+	"unknown xstate feature",
+	"unknown xstate feature",
+	"unknown xstate feature",
+	"unknown xstate feature",
+	"AMX Tile config",
+	"AMX Tile data",
+	"unknown xstate feature",
 };
 
 static unsigned short xsave_cpuid_features[] __initdata = {
@@ -73,6 +73,7 @@ static unsigned short xsave_cpuid_features[] __initdata = {
 	[XFEATURE_PT_UNIMPLEMENTED_SO_FAR]	= X86_FEATURE_INTEL_PT,
 	[XFEATURE_PKRU]				= X86_FEATURE_PKU,
 	[XFEATURE_PASID]			= X86_FEATURE_ENQCMD,
+	[XFEATURE_CET_USER]			= X86_FEATURE_SHSTK,
 	[XFEATURE_XTILE_CFG]			= X86_FEATURE_AMX_TILE,
 	[XFEATURE_XTILE_DATA]			= X86_FEATURE_AMX_TILE,
 };
@@ -276,6 +277,7 @@ static void __init print_xstate_features(void)
 	print_xstate_feature(XFEATURE_MASK_Hi16_ZMM);
 	print_xstate_feature(XFEATURE_MASK_PKRU);
 	print_xstate_feature(XFEATURE_MASK_PASID);
+	print_xstate_feature(XFEATURE_MASK_CET_USER);
 	print_xstate_feature(XFEATURE_MASK_XTILE_CFG);
 	print_xstate_feature(XFEATURE_MASK_XTILE_DATA);
 }
@@ -344,6 +346,7 @@ static __init void os_xrstor_booting(struct xregs_state *xstate)
 	 XFEATURE_MASK_BNDREGS |		\
 	 XFEATURE_MASK_BNDCSR |			\
 	 XFEATURE_MASK_PASID |			\
+	 XFEATURE_MASK_CET_USER |		\
 	 XFEATURE_MASK_XTILE)
 
 /*
@@ -446,14 +449,15 @@ static void __init __xstate_dump_leaves(void)
 	}									\
 } while (0)
 
-#define XCHECK_SZ(sz, nr, nr_macro, __struct) do {			\
-	if ((nr == nr_macro) &&						\
-	    WARN_ONCE(sz != sizeof(__struct),				\
-		"%s: struct is %zu bytes, cpu state %d bytes\n",	\
-		__stringify(nr_macro), sizeof(__struct), sz)) {		\
+#define XCHECK_SZ(sz, nr, __struct) ({					\
+	if (WARN_ONCE(sz != sizeof(__struct),				\
+	    "[%s]: struct is %zu bytes, cpu state %d bytes\n",		\
+	    xfeature_names[nr], sizeof(__struct), sz)) {		\
 		__xstate_dump_leaves();					\
 	}								\
-} while (0)
+	true;								\
+})
+
 
 /**
  * check_xtile_data_against_struct - Check tile data state size.
@@ -527,36 +531,28 @@ static bool __init check_xstate_against_struct(int nr)
 	 * Ask the CPU for the size of the state.
 	 */
 	int sz = xfeature_size(nr);
+
 	/*
 	 * Match each CPU state with the corresponding software
 	 * structure.
 	 */
-	XCHECK_SZ(sz, nr, XFEATURE_YMM,       struct ymmh_struct);
-	XCHECK_SZ(sz, nr, XFEATURE_BNDREGS,   struct mpx_bndreg_state);
-	XCHECK_SZ(sz, nr, XFEATURE_BNDCSR,    struct mpx_bndcsr_state);
-	XCHECK_SZ(sz, nr, XFEATURE_OPMASK,    struct avx_512_opmask_state);
-	XCHECK_SZ(sz, nr, XFEATURE_ZMM_Hi256, struct avx_512_zmm_uppers_state);
-	XCHECK_SZ(sz, nr, XFEATURE_Hi16_ZMM,  struct avx_512_hi16_state);
-	XCHECK_SZ(sz, nr, XFEATURE_PKRU,      struct pkru_state);
-	XCHECK_SZ(sz, nr, XFEATURE_PASID,     struct ia32_pasid_state);
-	XCHECK_SZ(sz, nr, XFEATURE_XTILE_CFG, struct xtile_cfg);
-
-	/* The tile data size varies between implementations. */
-	if (nr == XFEATURE_XTILE_DATA)
-		check_xtile_data_against_struct(sz);
-
-	/*
-	 * Make *SURE* to add any feature numbers in below if
-	 * there are "holes" in the xsave state component
-	 * numbers.
-	 */
-	if ((nr < XFEATURE_YMM) ||
-	    (nr >= XFEATURE_MAX) ||
-	    (nr == XFEATURE_PT_UNIMPLEMENTED_SO_FAR) ||
-	    ((nr >= XFEATURE_RSRVD_COMP_11) && (nr <= XFEATURE_RSRVD_COMP_16))) {
+	switch (nr) {
+	case XFEATURE_YMM:	  return XCHECK_SZ(sz, nr, struct ymmh_struct);
+	case XFEATURE_BNDREGS:	  return XCHECK_SZ(sz, nr, struct mpx_bndreg_state);
+	case XFEATURE_BNDCSR:	  return XCHECK_SZ(sz, nr, struct mpx_bndcsr_state);
+	case XFEATURE_OPMASK:	  return XCHECK_SZ(sz, nr, struct avx_512_opmask_state);
+	case XFEATURE_ZMM_Hi256:  return XCHECK_SZ(sz, nr, struct avx_512_zmm_uppers_state);
+	case XFEATURE_Hi16_ZMM:	  return XCHECK_SZ(sz, nr, struct avx_512_hi16_state);
+	case XFEATURE_PKRU:	  return XCHECK_SZ(sz, nr, struct pkru_state);
+	case XFEATURE_PASID:	  return XCHECK_SZ(sz, nr, struct ia32_pasid_state);
+	case XFEATURE_XTILE_CFG:  return XCHECK_SZ(sz, nr, struct xtile_cfg);
+	case XFEATURE_CET_USER:	  return XCHECK_SZ(sz, nr, struct cet_user_state);
+	case XFEATURE_XTILE_DATA: check_xtile_data_against_struct(sz); return true;
+	default:
 		XSTATE_WARN_ON(1, "No structure for xstate: %d\n", nr);
 		return false;
 	}
+
 	return true;
 }
 
