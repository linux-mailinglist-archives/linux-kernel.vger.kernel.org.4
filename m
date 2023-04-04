Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560216D6A8E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbjDDR1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbjDDR0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:26:43 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::61e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010204C15
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UODu6VZOwpTuozEeKEaqO14q+P1GWQzdISkqPQDXuyMyAAkn/nTpDMqSntxEshrKhOz6bNNO/HfwSoCRuNa85J4MTmr73ziYUQLTr+blRVx87DaWDSoKjMN8CGid9KTlLMCMpV3gD6lVAEDnkP2lS2pgHcZwIgV25SyTSmQxTOfWU/mRyCEtHfIu07DRCGLyh0X5vZnLLqOZYWpmOXRBsnLVPd7fYR5AzFiruRn7aNvhkOYljtVsmp12cqAT8ZJwO5Huyn6u1XkeMi84w11DREsFRz2WFaSIAcZWDs0YFkyiC2DPKucL13CwyOYX1/dsVu8Ya98rNY5uNwueIQqRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laBHCktuaTs49KBTaBTUNDul6UTEAJippVrSxK+ihMA=;
 b=UPFwXFRYDtcRyiPGS6/j2OW/UeSx8WJbV7CfA7h48LM3Pcap3hxHF3oyAAKsCRmtrVnVh2MpFMHMcKHkP1MjlANaooF6i60agyKPl8b/g/xkDc9ORqSpeFjz/kAuhyEUW4wFROD7b08uD6P6sGnes9ChFcLYBytvyjUYfUt838nYKW/CRN897HDgB//SnLEBLtkqgobP371FbX07Kl+GnyEA+b7iyUmVgiwV65jqPcfkRzD3SQeScC9c1BDeZZcV4bcadl6XZ2/YyJKkeknsuuHyCRDfVHjepO0wdkrkALKENJ5V928xuS+aoF7QQT+2LWnn82j2KAiyMOEnaCoKDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laBHCktuaTs49KBTaBTUNDul6UTEAJippVrSxK+ihMA=;
 b=f7htnHSB+r+7RBkhwpQ8Ur2AinDQekg3qXieaEsV1pjWU0nezNGkqsnvOBOAuaL6bhqSwLQgUT2J/IcdNaYx6amPdvpkVuJYK29aH75UVDyTcG15za9H+wejI1vF7BBcA/rtiIwBJdcz+YBKO3cXNIRpU5Gsxwd6ocRKpsttvik=
Received: from DM6PR08CA0062.namprd08.prod.outlook.com (2603:10b6:5:1e0::36)
 by DS0PR12MB8575.namprd12.prod.outlook.com (2603:10b6:8:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Tue, 4 Apr
 2023 17:23:55 +0000
Received: from DS1PEPF0000E643.namprd02.prod.outlook.com
 (2603:10b6:5:1e0:cafe::be) by DM6PR08CA0062.outlook.office365.com
 (2603:10b6:5:1e0::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35 via Frontend
 Transport; Tue, 4 Apr 2023 17:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E643.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 4 Apr 2023 17:23:55 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 4 Apr 2023 12:23:51 -0500
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
Subject: [PATCH v7 4/6] x86/sev: Use large PSC requests if applicable
Date:   Tue, 4 Apr 2023 12:23:04 -0500
Message-ID: <b1d2058b6b8cfe8f69fca9fca8824973ddf4de3e.1680628986.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E643:EE_|DS0PR12MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: 45fada3f-8644-4cd0-fa1e-08db35315e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HdhwSgvr5N4jMUayCc+teo/1DYgG1gmrwbpeasxE79/qxO1VGGiEdqA+P8B2YSWmeTjipS+Ytn6+UUlqpO6N9B44vd9dyvcKo0MiM2lhjZUVC/Ls5MBzwoZpgbqk2ATWoLnD8Kc8Wx54vnUFGWuFgl+u4cIRLE62AzwINCzftn5Q+hetrSA+HVg4qBcQUHscbqsokXgc51EUne60aAKC0KJC8b5FJZx5hEeGKhTrijgSgaA7GlEJC1xeWI6vQR9QLGlqBUzHVD1cgDnOxi7V/3wINvjuJOsw/rlbpQjsM2Br9oQICIXKX2UMhgnNgMq58YSHCg+81eJyQjCxPGR3QK3tPIqwFp9n5LuNpz+ycXg4se7q1KGEtlpKjPc2Z+1M4oTDqXsPlGcIpfVwQeyVSg9ZsSgyb201ZghToMIc5sfBsRTfNEw1iFlpLrcGBjxOA0Zr1KERpbjzbBaeQ4NCESNY/UNTOePwxt8jYx3Rif5w7jPJ7vQ1YRzVNRax2PIJDFd3iAhIUE0jy2KL4MYG2qRZU3wQAeD0v2IJDXaoaYZ6hYVH0yStcxXIOQZmcK/jIzeQ9bkbWSpLht8vIx/fVUdn4N6dgFFSex+bL3h1mRgp+OdGervKjbRl6peMja1UUPioaQjTPC2jF+dzdVu5WZQNUigTsbrAUl/e4QU4FBWrvlkKrdGne5Wp2g/lfNE3ZkqdwPbdxQ2mlR9pjJQAj7zfVeFyouGzuevDOGS41q4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(26005)(16526019)(186003)(40460700003)(36860700001)(82310400005)(478600001)(54906003)(316002)(110136005)(36756003)(7416002)(5660300002)(8936002)(2906002)(82740400003)(70206006)(86362001)(356005)(8676002)(4326008)(70586007)(81166007)(41300700001)(40480700001)(6666004)(2616005)(336012)(426003)(83380400001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 17:23:55.7390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45fada3f-8644-4cd0-fa1e-08db35315e7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E643.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8575
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE,
        T_FILL_THIS_FORM_SHORT autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In advance of providing support for unaccepted memory, request 2M Page
State Change (PSC) requests when the address range allows for it. By using
a 2M page size, more PSC operations can be handled in a single request to
the hypervisor. The hypervisor will determine if it can accommodate the
larger request by checking the mapping in the nested page table. If mapped
as a large page, then the 2M page request can be performed, otherwise the
2M page request will be broken down into 512 4K page requests. This is
still more efficient than having the guest perform multiple PSC requests
in order to process the 512 4K pages.

In conjunction with the 2M PSC requests, attempt to perform the associated
PVALIDATE instruction of the page using the 2M page size. If PVALIDATE
fails with a size mismatch, then fallback to validating 512 4K pages. To
do this, page validation is modified to work with the PSC structure and
not just a virtual address range.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/sev.h |   4 ++
 arch/x86/kernel/sev.c      | 125 ++++++++++++++++++++++++-------------
 2 files changed, 84 insertions(+), 45 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index a0a58c4122ec..91b4f712ef18 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -78,11 +78,15 @@ extern void vc_no_ghcb(void);
 extern void vc_boot_ghcb(void);
 extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 
+/* PVALIDATE return codes */
+#define PVALIDATE_FAIL_SIZEMISMATCH	6
+
 /* Software defined (when rFlags.CF = 1) */
 #define PVALIDATE_FAIL_NOUPDATE		255
 
 /* RMP page size */
 #define RMP_PG_SIZE_4K			0
+#define RMP_PG_SIZE_2M			1
 
 #define RMPADJUST_VMSA_PAGE_BIT		BIT(16)
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 1717bc4558f7..93de70340427 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -655,32 +655,58 @@ static u64 __init get_jump_table_addr(void)
 	return ret;
 }
 
-static void pvalidate_pages(unsigned long vaddr, unsigned long npages, bool validate)
+static void pvalidate_pages(struct snp_psc_desc *desc)
 {
-	unsigned long vaddr_end;
+	struct psc_entry *e;
+	unsigned long vaddr;
+	unsigned int size;
+	unsigned int i;
+	bool validate;
 	int rc;
 
-	vaddr = vaddr & PAGE_MASK;
-	vaddr_end = vaddr + (npages << PAGE_SHIFT);
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
 
-	while (vaddr < vaddr_end) {
-		rc = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
 		if (WARN(rc, "Failed to validate address 0x%lx ret %d", vaddr, rc))
 			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
-
-		vaddr = vaddr + PAGE_SIZE;
 	}
 }
 
-static void early_set_pages_state(unsigned long paddr, unsigned long npages, enum psc_op op)
+static void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
+				  unsigned long npages, enum psc_op op)
 {
 	unsigned long paddr_end;
 	u64 val;
+	int ret;
+
+	vaddr = vaddr & PAGE_MASK;
 
 	paddr = paddr & PAGE_MASK;
 	paddr_end = paddr + (npages << PAGE_SHIFT);
 
 	while (paddr < paddr_end) {
+		if (op == SNP_PAGE_STATE_SHARED) {
+			/* Page validation must be rescinded before changing to shared */
+			ret = pvalidate(vaddr, RMP_PG_SIZE_4K, false);
+			if (WARN(ret, "Failed to validate address 0x%lx ret %d", paddr, ret))
+				goto e_term;
+		}
+
 		/*
 		 * Use the MSR protocol because this function can be called before
 		 * the GHCB is established.
@@ -701,7 +727,15 @@ static void early_set_pages_state(unsigned long paddr, unsigned long npages, enu
 			 paddr, GHCB_MSR_PSC_RESP_VAL(val)))
 			goto e_term;
 
-		paddr = paddr + PAGE_SIZE;
+		if (op == SNP_PAGE_STATE_PRIVATE) {
+			/* Page validation must be performed after changing to private */
+			ret = pvalidate(vaddr, RMP_PG_SIZE_4K, true);
+			if (WARN(ret, "Failed to validate address 0x%lx ret %d", paddr, ret))
+				goto e_term;
+		}
+
+		vaddr += PAGE_SIZE;
+		paddr += PAGE_SIZE;
 	}
 
 	return;
@@ -726,10 +760,7 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 	  * Ask the hypervisor to mark the memory pages as private in the RMP
 	  * table.
 	  */
-	early_set_pages_state(paddr, npages, SNP_PAGE_STATE_PRIVATE);
-
-	/* Validate the memory pages after they've been added in the RMP table. */
-	pvalidate_pages(vaddr, npages, true);
+	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_PRIVATE);
 }
 
 void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
@@ -744,11 +775,8 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
 		return;
 
-	/* Invalidate the memory pages before they are marked shared in the RMP table. */
-	pvalidate_pages(vaddr, npages, false);
-
 	 /* Ask hypervisor to mark the memory pages shared in the RMP table. */
-	early_set_pages_state(paddr, npages, SNP_PAGE_STATE_SHARED);
+	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_SHARED);
 }
 
 void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op)
@@ -832,10 +860,11 @@ static int vmgexit_psc(struct ghcb *ghcb, struct snp_psc_desc *desc)
 	return ret;
 }
 
-static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
-			      unsigned long vaddr_end, int op)
+static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
+				       unsigned long vaddr_end, int op)
 {
 	struct ghcb_state state;
+	bool use_large_entry;
 	struct psc_hdr *hdr;
 	struct psc_entry *e;
 	unsigned long flags;
@@ -849,27 +878,37 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 	memset(data, 0, sizeof(*data));
 	i = 0;
 
-	while (vaddr < vaddr_end) {
-		if (is_vmalloc_addr((void *)vaddr))
+	while (vaddr < vaddr_end && i < ARRAY_SIZE(data->entries)) {
+		hdr->end_entry = i;
+
+		if (is_vmalloc_addr((void *)vaddr)) {
 			pfn = vmalloc_to_pfn((void *)vaddr);
-		else
+			use_large_entry = false;
+		} else {
 			pfn = __pa(vaddr) >> PAGE_SHIFT;
+			use_large_entry = true;
+		}
 
 		e->gfn = pfn;
 		e->operation = op;
-		hdr->end_entry = i;
 
-		/*
-		 * Current SNP implementation doesn't keep track of the RMP page
-		 * size so use 4K for simplicity.
-		 */
-		e->pagesize = RMP_PG_SIZE_4K;
+		if (use_large_entry && IS_ALIGNED(vaddr, PMD_SIZE) &&
+		    (vaddr_end - vaddr) >= PMD_SIZE) {
+			e->pagesize = RMP_PG_SIZE_2M;
+			vaddr += PMD_SIZE;
+		} else {
+			e->pagesize = RMP_PG_SIZE_4K;
+			vaddr += PAGE_SIZE;
+		}
 
-		vaddr = vaddr + PAGE_SIZE;
 		e++;
 		i++;
 	}
 
+	/* Page validation must be rescinded before changing to shared */
+	if (op == SNP_PAGE_STATE_SHARED)
+		pvalidate_pages(data);
+
 	local_irq_save(flags);
 
 	if (sev_cfg.ghcbs_initialized)
@@ -877,6 +916,7 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 	else
 		ghcb = boot_ghcb;
 
+	/* Invoke the hypervisor to perform the page state changes */
 	if (!ghcb || vmgexit_psc(ghcb, data))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
 
@@ -884,29 +924,28 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 		__sev_put_ghcb(&state);
 
 	local_irq_restore(flags);
+
+	/* Page validation must be performed after changing to private */
+	if (op == SNP_PAGE_STATE_PRIVATE)
+		pvalidate_pages(data);
+
+	return vaddr;
 }
 
 static void set_pages_state(unsigned long vaddr, unsigned long npages, int op)
 {
-	unsigned long vaddr_end, next_vaddr;
 	struct snp_psc_desc desc;
+	unsigned long vaddr_end;
 
 	/* Use the MSR protocol when a GHCB is not available. */
 	if (!boot_ghcb)
-		return early_set_pages_state(__pa(vaddr), npages, op);
+		return early_set_pages_state(vaddr, __pa(vaddr), npages, op);
 
 	vaddr = vaddr & PAGE_MASK;
 	vaddr_end = vaddr + (npages << PAGE_SHIFT);
 
-	while (vaddr < vaddr_end) {
-		/* Calculate the last vaddr that fits in one struct snp_psc_desc. */
-		next_vaddr = min_t(unsigned long, vaddr_end,
-				   (VMGEXIT_PSC_MAX_ENTRY * PAGE_SIZE) + vaddr);
-
-		__set_pages_state(&desc, vaddr, next_vaddr, op);
-
-		vaddr = next_vaddr;
-	}
+	while (vaddr < vaddr_end)
+		vaddr = __set_pages_state(&desc, vaddr, vaddr_end, op);
 }
 
 void snp_set_memory_shared(unsigned long vaddr, unsigned long npages)
@@ -914,8 +953,6 @@ void snp_set_memory_shared(unsigned long vaddr, unsigned long npages)
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return;
 
-	pvalidate_pages(vaddr, npages, false);
-
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_SHARED);
 }
 
@@ -925,8 +962,6 @@ void snp_set_memory_private(unsigned long vaddr, unsigned long npages)
 		return;
 
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
-
-	pvalidate_pages(vaddr, npages, true);
 }
 
 static int snp_set_vmsa(void *va, bool vmsa)
-- 
2.40.0

