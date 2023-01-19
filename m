Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9336673F1E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjASQlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjASQlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:41:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DAF4F84E;
        Thu, 19 Jan 2023 08:41:40 -0800 (PST)
Date:   Thu, 19 Jan 2023 16:41:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674146499;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qMM9mAJ4gy0pB1mB2sNJc/V2GtaePJ1LX3sgYLDZJzA=;
        b=1BPZ44s2EGV2DF9+QzEdT1gTc/pTmNwZz9Y16x8MIPHth0iCZCxqc1VC6GhPyLY7PH2kYX
        NwKqKu/DGRFIflVCaQiN6Ik2jyi4tD090/K42KXMlsjh1VN2JS8vFyI4BAyfaIXcB34Vkn
        kX3yGpgwvRnAgAdJpd35//K/hK/xAqqGl8tZILSMkUgZNmJF28UP0+x0ZPMnC5guwpNdqm
        +A+/tpjIc7HSG734DGoZr3YP5Xi52dLzMomUReY453RRQND4ZtcgPOqcjNxSkvjkQYVk5t
        KirENEykF0j0VdJSaqIVMRcIea7V9hw2hWd8KvBBC4VBzyvwn/jLWKuhND4s6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674146499;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qMM9mAJ4gy0pB1mB2sNJc/V2GtaePJ1LX3sgYLDZJzA=;
        b=Azesd3adk+s7wPKX4Ycf9vUuPY7y4/3tBm73S67QvDMoAX36jOKFnE8lwJgHfX5FW0DBmb
        YmuudISubvuJ6UBw==
From:   "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sev: Add SEV-SNP guest feature negotiation support
Cc:     Nikunj A Dadhania <nikunj@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, <stable@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230118061943.534309-1-nikunj@amd.com>
References: <20230118061943.534309-1-nikunj@amd.com>
MIME-Version: 1.0
Message-ID: <167414649850.4906.1693185384677559889.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     8c29f016540532582721cec1dbf6d144873433ba
Gitweb:        https://git.kernel.org/tip/8c29f016540532582721cec1dbf6d144873433ba
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Wed, 18 Jan 2023 11:49:43 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 19 Jan 2023 17:29:58 +01:00

x86/sev: Add SEV-SNP guest feature negotiation support

The hypervisor can enable various new features (SEV_FEATURES[1:63]) and start a
SNP guest. Some of these features need guest side implementation. If any of
these features are enabled without it, the behavior of the SNP guest will be
undefined.  It may fail booting in a non-obvious way making it difficult to
debug.

Instead of allowing the guest to continue and have it fail randomly later,
detect this early and fail gracefully.

The SEV_STATUS MSR indicates features which the hypervisor has enabled.  While
booting, SNP guests should ascertain that all the enabled features have guest
side implementation. In case a feature is not implemented in the guest, the
guest terminates booting with GHCB protocol Non-Automatic Exit(NAE) termination
request event, see "SEV-ES Guest-Hypervisor Communication Block Standardization"
document (currently at https://developer.amd.com/wp-content/resources/56421.pdf),
section "Termination Request".

Populate SW_EXITINFO2 with mask of unsupported features that the hypervisor can
easily report to the user.

More details in the AMD64 APM Vol 2, Section "SEV_STATUS MSR".

  [ bp:
    - Massage.
    - Move snp_check_features() call to C code.
    Note: the CC:stable@ aspect here is to be able to protect older, stable
    kernels when running on newer hypervisors. Or not "running" but fail
    reliably and in a well-defined manner instead of randomly. ]

Fixes: cbd3d4f7c4e5 ("x86/sev: Check SEV-SNP features support")
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20230118061943.534309-1-nikunj@amd.com
---
 Documentation/x86/amd-memory-encryption.rst | 36 ++++++++++-
 arch/x86/boot/compressed/ident_map_64.c     |  6 ++-
 arch/x86/boot/compressed/misc.h             |  2 +-
 arch/x86/boot/compressed/sev.c              | 70 ++++++++++++++++++++-
 arch/x86/include/asm/msr-index.h            | 20 ++++++-
 arch/x86/include/uapi/asm/svm.h             |  6 ++-
 6 files changed, 140 insertions(+)

diff --git a/Documentation/x86/amd-memory-encryption.rst b/Documentation/x86/amd-memory-encryption.rst
index a1940eb..934310c 100644
--- a/Documentation/x86/amd-memory-encryption.rst
+++ b/Documentation/x86/amd-memory-encryption.rst
@@ -95,3 +95,39 @@ by supplying mem_encrypt=on on the kernel command line.  However, if BIOS does
 not enable SME, then Linux will not be able to activate memory encryption, even
 if configured to do so by default or the mem_encrypt=on command line parameter
 is specified.
+
+Secure Nested Paging (SNP)
+==========================
+
+SEV-SNP introduces new features (SEV_FEATURES[1:63]) which can be enabled
+by the hypervisor for security enhancements. Some of these features need
+guest side implementation to function correctly. The below table lists the
+expected guest behavior with various possible scenarios of guest/hypervisor
+SNP feature support.
+
++-----------------+---------------+---------------+------------------+
+| Feature Enabled | Guest needs   | Guest has     | Guest boot       |
+| by the HV       | implementation| implementation| behaviour        |
++=================+===============+===============+==================+
+|      No         |      No       |      No       |     Boot         |
+|                 |               |               |                  |
++-----------------+---------------+---------------+------------------+
+|      No         |      Yes      |      No       |     Boot         |
+|                 |               |               |                  |
++-----------------+---------------+---------------+------------------+
+|      No         |      Yes      |      Yes      |     Boot         |
+|                 |               |               |                  |
++-----------------+---------------+---------------+------------------+
+|      Yes        |      No       |      No       | Boot with        |
+|                 |               |               | feature enabled  |
++-----------------+---------------+---------------+------------------+
+|      Yes        |      Yes      |      No       | Graceful boot    |
+|                 |               |               | failure          |
++-----------------+---------------+---------------+------------------+
+|      Yes        |      Yes      |      Yes      | Boot with        |
+|                 |               |               | feature enabled  |
++-----------------+---------------+---------------+------------------+
+
+More details in AMD64 APM[1] Vol 2: 15.34.10 SEV_STATUS MSR
+
+[1] https://www.amd.com/system/files/TechDocs/40332.pdf
diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index d4a314c..321a501 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -180,6 +180,12 @@ void initialize_identity_maps(void *rmode)
 
 	/* Load the new page-table. */
 	write_cr3(top_level_pgt);
+
+	/*
+	 * Now that the required page table mappings are established and a
+	 * GHCB can be used, check for SNP guest/HV feature compatibility.
+	 */
+	snp_check_features();
 }
 
 static pte_t *split_large_pmd(struct x86_mapping_info *info,
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 62208ec..20118fb 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -126,6 +126,7 @@ static inline void console_init(void)
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 void sev_enable(struct boot_params *bp);
+void snp_check_features(void);
 void sev_es_shutdown_ghcb(void);
 extern bool sev_es_check_ghcb_fault(unsigned long address);
 void snp_set_page_private(unsigned long paddr);
@@ -143,6 +144,7 @@ static inline void sev_enable(struct boot_params *bp)
 	if (bp)
 		bp->cc_blob_address = 0;
 }
+static inline void snp_check_features(void) { }
 static inline void sev_es_shutdown_ghcb(void) { }
 static inline bool sev_es_check_ghcb_fault(unsigned long address)
 {
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index c93930d..d63ad8f 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -208,6 +208,23 @@ void sev_es_shutdown_ghcb(void)
 		error("Can't unmap GHCB page");
 }
 
+static void __noreturn sev_es_ghcb_terminate(struct ghcb *ghcb, unsigned int set,
+					     unsigned int reason, u64 exit_info_2)
+{
+	u64 exit_info_1 = SVM_VMGEXIT_TERM_REASON(set, reason);
+
+	vc_ghcb_invalidate(ghcb);
+	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_TERM_REQUEST);
+	ghcb_set_sw_exit_info_1(ghcb, exit_info_1);
+	ghcb_set_sw_exit_info_2(ghcb, exit_info_2);
+
+	sev_es_wr_ghcb_msr(__pa(ghcb));
+	VMGEXIT();
+
+	while (true)
+		asm volatile("hlt\n" : : : "memory");
+}
+
 bool sev_es_check_ghcb_fault(unsigned long address)
 {
 	/* Check whether the fault was on the GHCB page */
@@ -270,6 +287,59 @@ static void enforce_vmpl0(void)
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
 }
 
+/*
+ * SNP_FEATURES_IMPL_REQ is the mask of SNP features that will need
+ * guest side implementation for proper functioning of the guest. If any
+ * of these features are enabled in the hypervisor but are lacking guest
+ * side implementation, the behavior of the guest will be undefined. The
+ * guest could fail in non-obvious way making it difficult to debug.
+ *
+ * As the behavior of reserved feature bits is unknown to be on the
+ * safe side add them to the required features mask.
+ */
+#define SNP_FEATURES_IMPL_REQ	(MSR_AMD64_SNP_VTOM |			\
+				 MSR_AMD64_SNP_REFLECT_VC |		\
+				 MSR_AMD64_SNP_RESTRICTED_INJ |		\
+				 MSR_AMD64_SNP_ALT_INJ |		\
+				 MSR_AMD64_SNP_DEBUG_SWAP |		\
+				 MSR_AMD64_SNP_VMPL_SSS |		\
+				 MSR_AMD64_SNP_SECURE_TSC |		\
+				 MSR_AMD64_SNP_VMGEXIT_PARAM |		\
+				 MSR_AMD64_SNP_VMSA_REG_PROTECTION |	\
+				 MSR_AMD64_SNP_RESERVED_BIT13 |		\
+				 MSR_AMD64_SNP_RESERVED_BIT15 |		\
+				 MSR_AMD64_SNP_RESERVED_MASK)
+
+/*
+ * SNP_FEATURES_PRESENT is the mask of SNP features that are implemented
+ * by the guest kernel. As and when a new feature is implemented in the
+ * guest kernel, a corresponding bit should be added to the mask.
+ */
+#define SNP_FEATURES_PRESENT (0)
+
+void snp_check_features(void)
+{
+	u64 unsupported;
+
+	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
+		return;
+
+	/*
+	 * Terminate the boot if hypervisor has enabled any feature lacking
+	 * guest side implementation. Pass on the unsupported features mask through
+	 * EXIT_INFO_2 of the GHCB protocol so that those features can be reported
+	 * as part of the guest boot failure.
+	 */
+	unsupported = sev_status & SNP_FEATURES_IMPL_REQ & ~SNP_FEATURES_PRESENT;
+	if (unsupported) {
+		if (ghcb_version < 2 || (!boot_ghcb && !early_setup_ghcb()))
+			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+
+		sev_es_ghcb_terminate(boot_ghcb, SEV_TERM_SET_GEN,
+				      GHCB_SNP_UNSUPPORTED, unsupported);
+	}
+}
+
 void sev_enable(struct boot_params *bp)
 {
 	unsigned int eax, ebx, ecx, edx;
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 37ff475..d3fe82c 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -566,6 +566,26 @@
 #define MSR_AMD64_SEV_ES_ENABLED	BIT_ULL(MSR_AMD64_SEV_ES_ENABLED_BIT)
 #define MSR_AMD64_SEV_SNP_ENABLED	BIT_ULL(MSR_AMD64_SEV_SNP_ENABLED_BIT)
 
+/* SNP feature bits enabled by the hypervisor */
+#define MSR_AMD64_SNP_VTOM			BIT_ULL(3)
+#define MSR_AMD64_SNP_REFLECT_VC		BIT_ULL(4)
+#define MSR_AMD64_SNP_RESTRICTED_INJ		BIT_ULL(5)
+#define MSR_AMD64_SNP_ALT_INJ			BIT_ULL(6)
+#define MSR_AMD64_SNP_DEBUG_SWAP		BIT_ULL(7)
+#define MSR_AMD64_SNP_PREVENT_HOST_IBS		BIT_ULL(8)
+#define MSR_AMD64_SNP_BTB_ISOLATION		BIT_ULL(9)
+#define MSR_AMD64_SNP_VMPL_SSS			BIT_ULL(10)
+#define MSR_AMD64_SNP_SECURE_TSC		BIT_ULL(11)
+#define MSR_AMD64_SNP_VMGEXIT_PARAM		BIT_ULL(12)
+#define MSR_AMD64_SNP_IBS_VIRT			BIT_ULL(14)
+#define MSR_AMD64_SNP_VMSA_REG_PROTECTION	BIT_ULL(16)
+#define MSR_AMD64_SNP_SMT_PROTECTION		BIT_ULL(17)
+
+/* SNP feature bits reserved for future use. */
+#define MSR_AMD64_SNP_RESERVED_BIT13		BIT_ULL(13)
+#define MSR_AMD64_SNP_RESERVED_BIT15		BIT_ULL(15)
+#define MSR_AMD64_SNP_RESERVED_MASK		GENMASK_ULL(63, 18)
+
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
 /* AMD Collaborative Processor Performance Control MSRs */
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index f69c168..80e1df4 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -116,6 +116,12 @@
 #define SVM_VMGEXIT_AP_CREATE			1
 #define SVM_VMGEXIT_AP_DESTROY			2
 #define SVM_VMGEXIT_HV_FEATURES			0x8000fffd
+#define SVM_VMGEXIT_TERM_REQUEST		0x8000fffe
+#define SVM_VMGEXIT_TERM_REASON(reason_set, reason_code)	\
+	/* SW_EXITINFO1[3:0] */					\
+	(((((u64)reason_set) & 0xf)) |				\
+	/* SW_EXITINFO1[11:4] */				\
+	((((u64)reason_code) & 0xff) << 4))
 #define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
 
 /* Exit code reserved for hypervisor/software use */
