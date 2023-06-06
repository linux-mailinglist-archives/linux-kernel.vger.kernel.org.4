Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759D37246DE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238432AbjFFOxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238480AbjFFOwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:52:51 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463C31BCF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hl4/SzWq2ZjIfN0Stg9WujsvKEskSoORHXNPDUpg5wQJc8pB2gT5gJnrZmGqqjxCMPqOTtyR7ta2Gef78rhaL8JvGpSyK3kPUfzHPQGKUZ/zbI2BykTNBmsjSc6OdIf+jE1FVzr/CI6Uj+N6va5mLZIb2b5kFHqHo6MlOCRWmCEmpD8OutGebmUk251ucBrMJqaMOoi/E5NH/LsDDvZpcw/FzBoTqvHQ5rIvYU2tVjfaaxW/3vVKPJtDcdn4rIadxpVLkcI4kizDBugOIzORFy7pIQuuMvFLXSfndSHct9qRNxjhBnFCvuRRzKYLvZ4BPX2O6mvQFyw9gc9HR/1Dvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcHcxgB8hmsPJvHDrFtnkzlRV/I3Gc+1vg7l0zhuuF4=;
 b=TLVKI1d781gaABM5v9nW43aWU7gpdqfmCOSoqbIfGqiFxktTZWvNDQVLmyl2Ve59q3IIS+ZLzKdZfiFT/SfIaJnPwKFh/eu2RHCC4a8LuRYg6XGqx8F+/uzdeYKAqe2dpisQJcZzNFbJ5/VjrpZg4oGmkLy07SQern42efNaG1vW96byERj0MuTa6pLub/iFJHG4+El47ny3zhEKi//RrVAeNtZJWt+/1fZiQ1NzFpMZ7aqP3sD9TA8axyMGFJBn63mWZ2nz8PAkoAN4fvj/dle21T5pMsxSDyUxujqgL6WKWsWKVxR7Cn1L7bFpRMIUNMY6uQUpMrSt2kAvsAocyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcHcxgB8hmsPJvHDrFtnkzlRV/I3Gc+1vg7l0zhuuF4=;
 b=ULUktT5m8do1hFCvTv/STxZMtRiwGI1rhzTMy1H8bmkurRtgmX1UWb4ozTydg3rcJbT5c76a7uyZULsN5T1KuIW0IXVow/z0zv60kz+5Z7ZDJPOWo+o6Pyhl2QV4xBHbzpe1lOCb45e3BNJvKhUlzm2tDO7wx2DxiH95wiTwczQ=
Received: from MW2PR16CA0068.namprd16.prod.outlook.com (2603:10b6:907:1::45)
 by DM4PR12MB6472.namprd12.prod.outlook.com (2603:10b6:8:bc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Tue, 6 Jun 2023 14:52:27 +0000
Received: from CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::a4) by MW2PR16CA0068.outlook.office365.com
 (2603:10b6:907:1::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Tue, 6 Jun 2023 14:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT116.mail.protection.outlook.com (10.13.174.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.36 via Frontend Transport; Tue, 6 Jun 2023 14:52:27 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 6 Jun 2023 09:52:24 -0500
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v9 5/6] x86/sev: Add SNP-specific unaccepted memory support
Date:   Tue, 6 Jun 2023 09:51:26 -0500
Message-ID: <a52fa69f460fd1876d70074b20ad68210dfc31dd.1686063086.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686063086.git.thomas.lendacky@amd.com>
References: <20230606142637.5171-1-kirill.shutemov@linux.intel.com> <cover.1686063086.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT116:EE_|DM4PR12MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: a597f66c-c6f3-478a-830b-08db669da546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F/tr2sC7YBRng3s1k8b6lXSMMXE3/aO/gB/Ukm6rzG4fuxZSuT/xDFbmV4brYqd6uoS63tbLTKZTW7M6D/LDnubR8jplhx3AcwS4myxilUGsOK3jCY9wfWYONyNTQkagKZnXRWHv+ppi47sEYT06MO69r73cPBS0gFqPgT7VGDqLQIJkPjUWRGQhYGZ5M5bRyrcxwtzLFrATcCdhiNuN0MUvpvXWpOGmG5WfuL++4gc+lq5AbJ+ZnBajRqQAtX1Y9QI/DbFIQQiRUpY+ARPbLqf4rNEOjL2eLBRlQ7nijDx/Kl2C33hKzezh63qM5/TLAcLHj4zc1gUpOyU9Xs34fu0Hfri9dcwdoTISI3vRM/mWOQ/gtklXLAxjI3XqZ3Go8LVch7diBZ/Hvp5lyzDjwvt816rhHUL8Oz8MfVAGqNE6JhoP3O32xM2KhZQf2hF69UNVB0PnAqxTCmNrkfHLcEgxiViSn3Qam7IWvuFMXWPPv5aD0pO5jowo2Uy3PX7du/dcjqFe5+MBK5E0ueLrBTc+8mXwD/qhkxHVP+ubU1h+WIb457WtSOb3PFzsPtZkXt2oxXAZjT4yTBC41hcNm5pismuHksztVLUN0kCGogkyJLZ85utc7rc/crr+B/VEAEiFPx0PVaiOL2Y5AkPJth7nPItM30FGiI3A+0ROZWUCBhjQSQkOhzHc3VZdxjYqea1aGrIEF/YBkaA4Kdyff4AD1vz9TtJyPRi0FEk1rjuL0hrF4jpldySxxrn9MeGNcFJhKPN9I771lX5d2+bcvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(8676002)(8936002)(478600001)(110136005)(54906003)(41300700001)(5660300002)(316002)(16526019)(26005)(7416002)(70586007)(70206006)(4326008)(2616005)(186003)(83380400001)(40460700003)(2906002)(47076005)(30864003)(426003)(336012)(81166007)(82740400003)(356005)(40480700001)(36860700001)(86362001)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 14:52:27.0411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a597f66c-c6f3-478a-830b-08db669da546
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6472
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SNP-specific hooks to the unaccepted memory support in the boot
path (__accept_memory()) and the core kernel (accept_memory()) in order
to support booting SNP guests when unaccepted memory is present. Without
this support, SNP guests will fail to boot and/or panic() when unaccepted
memory is present in the EFI memory map.

The process of accepting memory under SNP involves invoking the hypervisor
to perform a page state change for the page to private memory and then
issuing a PVALIDATE instruction to accept the page.

Since the boot path and the core kernel paths perform similar operations,
move the pvalidate_pages() and vmgexit_psc() functions into sev-shared.c
to avoid code duplication.

Create the new header file arch/x86/boot/compressed/sev.h because adding
the function declaration to any of the existing SEV related header files
pulls in too many other header files, causing the build to fail.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/Kconfig                         |   2 +
 arch/x86/boot/compressed/mem.c           |   3 +
 arch/x86/boot/compressed/sev.c           |  54 ++++++++++-
 arch/x86/boot/compressed/sev.h           |  23 +++++
 arch/x86/include/asm/sev.h               |   3 +
 arch/x86/include/asm/unaccepted_memory.h |   3 +
 arch/x86/kernel/sev-shared.c             | 103 +++++++++++++++++++++
 arch/x86/kernel/sev.c                    | 112 +++--------------------
 8 files changed, 204 insertions(+), 99 deletions(-)
 create mode 100644 arch/x86/boot/compressed/sev.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5c72067c06d4..b9c451f75d5e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1543,11 +1543,13 @@ config X86_MEM_ENCRYPT
 config AMD_MEM_ENCRYPT
 	bool "AMD Secure Memory Encryption (SME) support"
 	depends on X86_64 && CPU_SUP_AMD
+	depends on EFI_STUB
 	select DMA_COHERENT_POOL
 	select ARCH_USE_MEMREMAP_PROT
 	select INSTRUCTION_DECODER
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MEM_ENCRYPT
+	select UNACCEPTED_MEMORY
 	help
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index f04b29f3572f..3c1609245f2a 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -3,6 +3,7 @@
 #include "error.h"
 #include "misc.h"
 #include "tdx.h"
+#include "sev.h"
 #include <asm/shared/tdx.h>
 
 /*
@@ -37,6 +38,8 @@ void arch_accept_memory(phys_addr_t start, phys_addr_t end)
 	if (early_is_tdx_guest()) {
 		if (!tdx_accept_memory(start, end))
 			panic("TDX: Failed to accept memory\n");
+	} else if (sev_snp_enabled()) {
+		snp_accept_memory(start, end);
 	} else {
 		error("Cannot accept memory: unknown platform\n");
 	}
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 014b89c89088..09dc8c187b3c 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -115,7 +115,7 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 /* Include code for early handlers */
 #include "../../kernel/sev-shared.c"
 
-static inline bool sev_snp_enabled(void)
+bool sev_snp_enabled(void)
 {
 	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
 }
@@ -181,6 +181,58 @@ static bool early_setup_ghcb(void)
 	return true;
 }
 
+static phys_addr_t __snp_accept_memory(struct snp_psc_desc *desc,
+				       phys_addr_t pa, phys_addr_t pa_end)
+{
+	struct psc_hdr *hdr;
+	struct psc_entry *e;
+	unsigned int i;
+
+	hdr = &desc->hdr;
+	memset(hdr, 0, sizeof(*hdr));
+
+	e = desc->entries;
+
+	i = 0;
+	while (pa < pa_end && i < VMGEXIT_PSC_MAX_ENTRY) {
+		hdr->end_entry = i;
+
+		e->gfn = pa >> PAGE_SHIFT;
+		e->operation = SNP_PAGE_STATE_PRIVATE;
+		if (IS_ALIGNED(pa, PMD_SIZE) && (pa_end - pa) >= PMD_SIZE) {
+			e->pagesize = RMP_PG_SIZE_2M;
+			pa += PMD_SIZE;
+		} else {
+			e->pagesize = RMP_PG_SIZE_4K;
+			pa += PAGE_SIZE;
+		}
+
+		e++;
+		i++;
+	}
+
+	if (vmgexit_psc(boot_ghcb, desc))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
+
+	pvalidate_pages(desc);
+
+	return pa;
+}
+
+void snp_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	struct snp_psc_desc desc = {};
+	unsigned int i;
+	phys_addr_t pa;
+
+	if (!boot_ghcb && !early_setup_ghcb())
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
+
+	pa = start;
+	while (pa < end)
+		pa = __snp_accept_memory(&desc, pa, end);
+}
+
 void sev_es_shutdown_ghcb(void)
 {
 	if (!boot_ghcb)
diff --git a/arch/x86/boot/compressed/sev.h b/arch/x86/boot/compressed/sev.h
new file mode 100644
index 000000000000..fc725a981b09
--- /dev/null
+++ b/arch/x86/boot/compressed/sev.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AMD SEV header for early boot related functions.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ */
+
+#ifndef BOOT_COMPRESSED_SEV_H
+#define BOOT_COMPRESSED_SEV_H
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+
+bool sev_snp_enabled(void);
+void snp_accept_memory(phys_addr_t start, phys_addr_t end);
+
+#else
+
+static inline bool sev_snp_enabled(void) { return false; }
+static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
+
+#endif
+
+#endif
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index e21e1c5397c1..86e1296e87f5 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -206,6 +206,7 @@ void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
+void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -229,6 +230,8 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
 {
 	return -ENOTTY;
 }
+
+static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 #endif
 
 #endif
diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
index 572514e36fde..f5937e9866ac 100644
--- a/arch/x86/include/asm/unaccepted_memory.h
+++ b/arch/x86/include/asm/unaccepted_memory.h
@@ -3,6 +3,7 @@
 
 #include <linux/efi.h>
 #include <asm/tdx.h>
+#include <asm/sev.h>
 
 static inline void arch_accept_memory(phys_addr_t start, phys_addr_t end)
 {
@@ -10,6 +11,8 @@ static inline void arch_accept_memory(phys_addr_t start, phys_addr_t end)
 	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
 		if (!tdx_accept_memory(start, end))
 			panic("TDX: Failed to accept memory\n");
+	} else if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
+		snp_accept_memory(start, end);
 	} else {
 		panic("Cannot accept memory: unknown platform\n");
 	}
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 3a5b0c9c4fcc..2eabccde94fb 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -12,6 +12,9 @@
 #ifndef __BOOT_COMPRESSED
 #define error(v)	pr_err(v)
 #define has_cpuflag(f)	boot_cpu_has(f)
+#else
+#undef WARN
+#define WARN(condition, format...) (!!(condition))
 #endif
 
 /* I/O parameters for CPUID-related helpers */
@@ -991,3 +994,103 @@ static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 			cpuid_ext_range_max = fn->eax;
 	}
 }
+
+static void pvalidate_pages(struct snp_psc_desc *desc)
+{
+	struct psc_entry *e;
+	unsigned long vaddr;
+	unsigned int size;
+	unsigned int i;
+	bool validate;
+	int rc;
+
+	for (i = 0; i <= desc->hdr.end_entry; i++) {
+		e = &desc->entries[i];
+
+		vaddr = (unsigned long)pfn_to_kaddr(e->gfn);
+		size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
+		validate = e->operation == SNP_PAGE_STATE_PRIVATE;
+
+		rc = pvalidate(vaddr, size, validate);
+		if (rc == PVALIDATE_FAIL_SIZEMISMATCH && size == RMP_PG_SIZE_2M) {
+			unsigned long vaddr_end = vaddr + PMD_SIZE;
+
+			for (; vaddr < vaddr_end; vaddr += PAGE_SIZE) {
+				rc = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
+				if (rc)
+					break;
+			}
+		}
+
+		if (rc) {
+			WARN(1, "Failed to validate address 0x%lx ret %d", vaddr, rc);
+			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+		}
+	}
+}
+
+static int vmgexit_psc(struct ghcb *ghcb, struct snp_psc_desc *desc)
+{
+	int cur_entry, end_entry, ret = 0;
+	struct snp_psc_desc *data;
+	struct es_em_ctxt ctxt;
+
+	vc_ghcb_invalidate(ghcb);
+
+	/* Copy the input desc into GHCB shared buffer */
+	data = (struct snp_psc_desc *)ghcb->shared_buffer;
+	memcpy(ghcb->shared_buffer, desc, min_t(int, GHCB_SHARED_BUF_SIZE, sizeof(*desc)));
+
+	/*
+	 * As per the GHCB specification, the hypervisor can resume the guest
+	 * before processing all the entries. Check whether all the entries
+	 * are processed. If not, then keep retrying. Note, the hypervisor
+	 * will update the data memory directly to indicate the status, so
+	 * reference the data->hdr everywhere.
+	 *
+	 * The strategy here is to wait for the hypervisor to change the page
+	 * state in the RMP table before guest accesses the memory pages. If the
+	 * page state change was not successful, then later memory access will
+	 * result in a crash.
+	 */
+	cur_entry = data->hdr.cur_entry;
+	end_entry = data->hdr.end_entry;
+
+	while (data->hdr.cur_entry <= data->hdr.end_entry) {
+		ghcb_set_sw_scratch(ghcb, (u64)__pa(data));
+
+		/* This will advance the shared buffer data points to. */
+		ret = sev_es_ghcb_hv_call(ghcb, &ctxt, SVM_VMGEXIT_PSC, 0, 0);
+
+		/*
+		 * Page State Change VMGEXIT can pass error code through
+		 * exit_info_2.
+		 */
+		if (WARN(ret || ghcb->save.sw_exit_info_2,
+			 "SNP: PSC failed ret=%d exit_info_2=%llx\n",
+			 ret, ghcb->save.sw_exit_info_2)) {
+			ret = 1;
+			goto out;
+		}
+
+		/* Verify that reserved bit is not set */
+		if (WARN(data->hdr.reserved, "Reserved bit is set in the PSC header\n")) {
+			ret = 1;
+			goto out;
+		}
+
+		/*
+		 * Sanity check that entry processing is not going backwards.
+		 * This will happen only if hypervisor is tricking us.
+		 */
+		if (WARN(data->hdr.end_entry > end_entry || cur_entry > data->hdr.cur_entry,
+"SNP: PSC processing going backward, end_entry %d (got %d) cur_entry %d (got %d)\n",
+			 end_entry, data->hdr.end_entry, cur_entry, data->hdr.cur_entry)) {
+			ret = 1;
+			goto out;
+		}
+	}
+
+out:
+	return ret;
+}
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 17b3d003b2ea..ea2546e5130f 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -657,38 +657,6 @@ static u64 __init get_jump_table_addr(void)
 	return ret;
 }
 
-static void pvalidate_pages(struct snp_psc_desc *desc)
-{
-	struct psc_entry *e;
-	unsigned long vaddr;
-	unsigned int size;
-	unsigned int i;
-	bool validate;
-	int rc;
-
-	for (i = 0; i <= desc->hdr.end_entry; i++) {
-		e = &desc->entries[i];
-
-		vaddr = (unsigned long)pfn_to_kaddr(e->gfn);
-		size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
-		validate = e->operation == SNP_PAGE_STATE_PRIVATE;
-
-		rc = pvalidate(vaddr, size, validate);
-		if (rc == PVALIDATE_FAIL_SIZEMISMATCH && size == RMP_PG_SIZE_2M) {
-			unsigned long vaddr_end = vaddr + PMD_SIZE;
-
-			for (; vaddr < vaddr_end; vaddr += PAGE_SIZE) {
-				rc = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
-				if (rc)
-					break;
-			}
-		}
-
-		if (WARN(rc, "Failed to validate address 0x%lx ret %d", vaddr, rc))
-			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
-	}
-}
-
 static void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 				  unsigned long npages, enum psc_op op)
 {
@@ -796,72 +764,6 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
 		WARN(1, "invalid memory op %d\n", op);
 }
 
-static int vmgexit_psc(struct ghcb *ghcb, struct snp_psc_desc *desc)
-{
-	int cur_entry, end_entry, ret = 0;
-	struct snp_psc_desc *data;
-	struct es_em_ctxt ctxt;
-
-	vc_ghcb_invalidate(ghcb);
-
-	/* Copy the input desc into GHCB shared buffer */
-	data = (struct snp_psc_desc *)ghcb->shared_buffer;
-	memcpy(ghcb->shared_buffer, desc, min_t(int, GHCB_SHARED_BUF_SIZE, sizeof(*desc)));
-
-	/*
-	 * As per the GHCB specification, the hypervisor can resume the guest
-	 * before processing all the entries. Check whether all the entries
-	 * are processed. If not, then keep retrying. Note, the hypervisor
-	 * will update the data memory directly to indicate the status, so
-	 * reference the data->hdr everywhere.
-	 *
-	 * The strategy here is to wait for the hypervisor to change the page
-	 * state in the RMP table before guest accesses the memory pages. If the
-	 * page state change was not successful, then later memory access will
-	 * result in a crash.
-	 */
-	cur_entry = data->hdr.cur_entry;
-	end_entry = data->hdr.end_entry;
-
-	while (data->hdr.cur_entry <= data->hdr.end_entry) {
-		ghcb_set_sw_scratch(ghcb, (u64)__pa(data));
-
-		/* This will advance the shared buffer data points to. */
-		ret = sev_es_ghcb_hv_call(ghcb, &ctxt, SVM_VMGEXIT_PSC, 0, 0);
-
-		/*
-		 * Page State Change VMGEXIT can pass error code through
-		 * exit_info_2.
-		 */
-		if (WARN(ret || ghcb->save.sw_exit_info_2,
-			 "SNP: PSC failed ret=%d exit_info_2=%llx\n",
-			 ret, ghcb->save.sw_exit_info_2)) {
-			ret = 1;
-			goto out;
-		}
-
-		/* Verify that reserved bit is not set */
-		if (WARN(data->hdr.reserved, "Reserved bit is set in the PSC header\n")) {
-			ret = 1;
-			goto out;
-		}
-
-		/*
-		 * Sanity check that entry processing is not going backwards.
-		 * This will happen only if hypervisor is tricking us.
-		 */
-		if (WARN(data->hdr.end_entry > end_entry || cur_entry > data->hdr.cur_entry,
-"SNP: PSC processing going backward, end_entry %d (got %d) cur_entry %d (got %d)\n",
-			 end_entry, data->hdr.end_entry, cur_entry, data->hdr.cur_entry)) {
-			ret = 1;
-			goto out;
-		}
-	}
-
-out:
-	return ret;
-}
-
 static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 				       unsigned long vaddr_end, int op)
 {
@@ -966,6 +868,20 @@ void snp_set_memory_private(unsigned long vaddr, unsigned long npages)
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
 }
 
+void snp_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	unsigned long vaddr;
+	unsigned int npages;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	vaddr = (unsigned long)__va(start);
+	npages = (end - start) >> PAGE_SHIFT;
+
+	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
+}
+
 static int snp_set_vmsa(void *va, bool vmsa)
 {
 	u64 attrs;
-- 
2.40.1

