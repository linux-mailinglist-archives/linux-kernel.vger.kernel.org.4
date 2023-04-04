Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C7E6D6A94
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbjDDR3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbjDDR3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:29:14 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15567ABE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ks6lF7XM92fVtbLc1GstlC2PeTTVOLYAwGHWmZXAK29xf0eLXe47MjhT8N6o8CRd5h5gQcDsniEe8NRTQLa3JHOLwzI4mosZYe6Alv2K4HC+NJGh5zb4mnMqVVWdUWXOHfplkE5K5Tj14ZHYlUzuf7/Gwx7dokf5kLxDpG2Oy1ecqENSqIdZ+DlsFGeQ+d0vb8Id1HJAZozFaB0wnXnDv22Wlcl5vfli52epXmAjY68epcspI65FGpPhlovREXAte8lkiCVDvqrenmxNqBd7gAWa3jUgO0X8EoQg/Yt03dUrxYapLTS+6vPemMbxtW/zqSfSi50cuMoUfX5jQmiLHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fywtEUg2/HZm1kyVt0BIb7qHBiBH78lJ5UPD7c11XIM=;
 b=EGHzFlzJTGfTaCQ3MB36UldrFR/iXb8o7bMeTpiMLP/kyKT+CymqERwNklzknX6xUrhmN+4cdaMNDH6pAwWGcGKDQDJSOHItSjVuvYs17RD18sw28qCOXS/Y/1IGacQihAEHppb0nkhaJNJH+yhICD6HvUpDJztpcOmeiZ/867nKG1uXYcn5YzE5t34u4Lh0Zy5XkAG8sioKPceTUzeobA/O2eHflyrBw+sHaY8uks1YYooD1XrtqvaK79s0JKP7yEsh9gP5V4afcjC8839VQhpGIm7IpYwy+6EsqF0ey32N9xtIt/A0W0s/PSgP6MymeZ5X8jL/7EYmRNZOC2D1+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fywtEUg2/HZm1kyVt0BIb7qHBiBH78lJ5UPD7c11XIM=;
 b=xz48Mp7OY14YHConZ6zf0hg73ttPDR7nFsmSi8bdZdgGyegEwgepdlSxf/dnldQ1c7ccpEnDm5rAPvEuF9rozbDbAsqobLK06VSmX/byjQQOEYHeU9OXL8BfKOAgregbNGfvktfsOKFOwu3KeV3nuSM9WAq4XTn1koyV4x28M0c=
Received: from DM6PR06CA0100.namprd06.prod.outlook.com (2603:10b6:5:336::33)
 by DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 17:24:01 +0000
Received: from DS1PEPF0000E644.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::e0) by DM6PR06CA0100.outlook.office365.com
 (2603:10b6:5:336::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Tue, 4 Apr 2023 17:24:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E644.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 4 Apr 2023 17:24:01 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 4 Apr 2023 12:24:00 -0500
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
Subject: [PATCH v7 5/6] x86/sev: Add SNP-specific unaccepted memory support
Date:   Tue, 4 Apr 2023 12:23:05 -0500
Message-ID: <1dd6d5e89d04fe421e650a1e53d550a264a77ad7.1680628986.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1680628986.git.thomas.lendacky@amd.com>
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com> <cover.1680628986.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E644:EE_|DM6PR12MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e6ca5c-8d83-47c0-5dbb-08db3531620f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sj0X4H66Ycr8Sl2SHMbm4xyEgiXwvhGW4rWXgo2CiXWNu4lypTmCD3TjNDDAFbL5wsLql9kRTLaxVjV1y0Ry20YoBe6WLlTrBedcqcLOiHOyQHXQs33mAA11o/V7eEzwCvQxcJ1yxC34Y4kArqx0ecWd6Dtqx3XpVulGbWjeGKIgM99ndRq7tMaBy/ioWp06QGwarJC9fYnCLR/9K7l3CKt31u0edLN2i+9tOsNuD0NEOLcoz/+QlC3aS6Me708eUZwfSOV94MgRRvEqsv4iaPtSvmqTImNNPTFmfjUBtqs0xKB7XvLuTQunO11lFSyFCIfzDOkSXUaIl/HA0/WkErXvmRkCL7a4KXSwDbRlXLNsit7LSkHB4cG9OfhnZ2xoPp8i1iy9mmoA6/hK4CxTrK5nliSBMSfWNTQlpfbk9zO8Ka/aCorGyzXQeMn1lMaJHeAuT1ScIRPXuDott0wDPDvCxDlND04r37d+9V9jGnd+UfImsAm7H0reW5CJ3PgfoWW2Tk/7c1gYy9IjjV3d3XjOE0YT5P4f/me839JQZcfAY7NuFpLF4NxaJwEBx4YW3aeYSPGYFjsDfqFdg80ct06aunIB04aOsXoDu4iDWLeuYx6QXWfkIFvCxXC1ot0KiaiBmWgDtUevxGVTZ7aP2QD+1FBDvUHu+fll//xqQOAILsL3uxHZSvITP1jWaGXCgskSmAfhwen8aEWquMeHtzkwqaw+MNgxuRdte0RnWJw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(478600001)(316002)(110136005)(40460700003)(54906003)(8676002)(5660300002)(8936002)(36756003)(86362001)(30864003)(82310400005)(2906002)(7416002)(4326008)(40480700001)(82740400003)(70206006)(70586007)(356005)(41300700001)(81166007)(186003)(16526019)(47076005)(26005)(426003)(336012)(2616005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 17:24:01.7275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e6ca5c-8d83-47c0-5dbb-08db3531620f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E644.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE,
        T_FILL_THIS_FORM_SHORT autolearn=no autolearn_force=no version=3.4.6
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
 arch/x86/Kconfig                |   2 +
 arch/x86/boot/compressed/mem.c  |   3 +
 arch/x86/boot/compressed/sev.c  |  54 ++++++++++++++-
 arch/x86/boot/compressed/sev.h  |  23 +++++++
 arch/x86/include/asm/sev.h      |   3 +
 arch/x86/kernel/sev-shared.c    | 103 +++++++++++++++++++++++++++++
 arch/x86/kernel/sev.c           | 112 ++++----------------------------
 arch/x86/mm/unaccepted_memory.c |   4 ++
 8 files changed, 205 insertions(+), 99 deletions(-)
 create mode 100644 arch/x86/boot/compressed/sev.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 448cd869f0bd..9fd69128a7d8 100644
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
index e6b92e822ddd..e6ab88dcfd7e 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -6,6 +6,7 @@
 #include "find.h"
 #include "math.h"
 #include "tdx.h"
+#include "sev.h"
 #include <asm/shared/tdx.h>
 
 #define PMD_SHIFT	21
@@ -45,6 +46,8 @@ static inline void __accept_memory(phys_addr_t start, phys_addr_t end)
 	/* Platform-specific memory-acceptance call goes here */
 	if (early_is_tdx_guest())
 		tdx_accept_memory(start, end);
+	else if (sev_snp_enabled())
+		snp_accept_memory(start, end);
 	else
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
index 91b4f712ef18..67e81141a873 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -201,6 +201,7 @@ void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err);
+void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -225,6 +226,8 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
 {
 	return -ENOTTY;
 }
+
+static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 3a5b0c9c4fcc..be312db48a49 100644
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
+		validate = (e->operation == SNP_PAGE_STATE_PRIVATE) ? true : false;
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
index 93de70340427..48cb926e28ae 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -655,38 +655,6 @@ static u64 __init get_jump_table_addr(void)
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
-		validate = (e->operation == SNP_PAGE_STATE_PRIVATE) ? true : false;
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
@@ -794,72 +762,6 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
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
@@ -964,6 +866,20 @@ void snp_set_memory_private(unsigned long vaddr, unsigned long npages)
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
diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
index a521f8c0987d..7e08f7a8bd63 100644
--- a/arch/x86/mm/unaccepted_memory.c
+++ b/arch/x86/mm/unaccepted_memory.c
@@ -8,6 +8,7 @@
 #include <asm/setup.h>
 #include <asm/shared/tdx.h>
 #include <asm/unaccepted_memory.h>
+#include <asm/sev.h>
 
 /* Protects unaccepted memory bitmap */
 static DEFINE_SPINLOCK(unaccepted_memory_lock);
@@ -65,6 +66,9 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
 		if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
 			tdx_accept_memory(range_start * PMD_SIZE,
 					  range_end * PMD_SIZE);
+		} else if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
+			snp_accept_memory(range_start * PMD_SIZE,
+					  range_end * PMD_SIZE);
 		} else {
 			panic("Cannot accept memory: unknown platform\n");
 		}
-- 
2.40.0

