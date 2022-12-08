Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D242964730B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiLHPbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiLHPaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:30:13 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FC9786BC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:30:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYZUS+jQhERyiptvX6DcvJGVCG5TvGl2VeLQUkWcgNwPMSh23j+B9jWSAlj25R3F2vgD5gkKjIK1SNmsg/mR31tH0fZ/dMC5XoctdUJohdx02kHLT5mETvb4cC6WcvJW9cRQ/XgOvZYe1WbN5nsVEWxQPO7vlzs2iXd5Vx9KrJZJdyApEgrswNBOJdHNwmSix/Jyxz0iQ+jAtPItkm1JuasrFMVEBiInzdx2wLJBhgzRORDrvqnFt57BLV5oYMhOpbpkXyBVn1w/oBeYlJoisDwxmL22Aprq06h6TnSlOgShmpaQsfp7wDGopKjH/8EWuABRJs+kBMBqc3o8LHXtQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxMzqp2Z2pxGGIzmVZJMAt/Z6apMwiRB4n6378Cj0Uw=;
 b=VAxHMkkrswG0mwjrvpxk1kUXyCyn//t5h5UzbPzeT34964/2eEEVI1Z23bdJJjdg8MMLF8zW2HSLc9MRBuVAmPK5jBcYS2j3PTXANfKrJ7PYDza7fzQPxVOT8d4vwlZdjd2ndccARtrpiRCa4gBJ8BQaMo68ANa2QiQ6m68LOR7Wc/MbLm8YrtcsvlNftD7bC+HHqN8HawJ6ncrEkm6NT6deDRb4zF3BG9WiVO4i4aWDjcpztbcxcah7DBNK7OhU876gsRpQ7OcE21NOnNGsK7u+HJm5tmHKxutt3gv95+qKRWDcZCn7F6uCa7xoqjnqKQ64Gg7Oh+GPzsU2TQ12kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxMzqp2Z2pxGGIzmVZJMAt/Z6apMwiRB4n6378Cj0Uw=;
 b=5AO68NL30/hilWfVyShnFO6NGzymzgHSz0XvttVnTDaOQec5wIHaHtoHAQDIbrNu2lXjruXDUhMYHGt84uHJBg3FKsMTzJqkHhh747ziJCBBkakwaeKd+XtVoCdtNRzz3RhJPxjvK2wL7VNtMVJ3ymBj2HiVDjCnI3JnroREiWg=
Received: from BN9PR03CA0160.namprd03.prod.outlook.com (2603:10b6:408:f4::15)
 by CY5PR12MB6324.namprd12.prod.outlook.com (2603:10b6:930:f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 15:30:09 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::b5) by BN9PR03CA0160.outlook.office365.com
 (2603:10b6:408:f4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 15:30:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Thu, 8 Dec 2022 15:30:09 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 09:30:08 -0600
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v6 4/5] x86/sev: Use large PSC requests if applicable
Date:   Thu, 8 Dec 2022 09:29:12 -0600
Message-ID: <926e256b9159293f162d9068c8fd327e4819b76f.1670513353.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1670513353.git.thomas.lendacky@amd.com>
References: <20221207014933.8435-1-kirill.shutemov@linux.intel.com> <cover.1670513353.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT060:EE_|CY5PR12MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 335c0322-b9e8-469d-f203-08dad931172c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +4I6LFfZdUckX+DXXL8RwXB+fTGz8pP8P6b5t7VRbmGydtqvpkOUtH8PbQwJa2e87pWlsN+LCyDYfrmzi8rOHii8hune3q6cxBc2QLjSOQRdDqYwT/qpby6UzewtEcYnbqG+G/ePfJYn+jcjhTW+jDNEUI6kM8M4kEqBBNzmdAqnZsshzBooBQbRZD0OQ/FJqDPwNuifTxtctRvK0lSO1WxDsQAAFgRXeLk0kZ35xlgNEQ7asNbE+y1/D+iXNZOHXufdoYJPZ8XYFj5MtXB3thVQzmC5l8WLc4GMdupeMiEn2JUMSnyGmgLTDDmap3SLcTcXAQT6+ekZ0L5Od/dp57bm9NoNR/afE7yMofVXLAtmDWfiL7eCuNwkkOdb/z/hs6svG7mDBDL0gqGE8YwijxMWsEjPtQPtHpJELjiU6cVRWBHWIC5dKjFMs6temK9EcOz/rB0WNiPK47vi86iTE7cmYZ4uoW81qxZw7l6upuGiNdLORX2bJwDVii+o/+ScVbteduc5m5l4XWzhPVw89oGc302kQBeJFWHmXUacGS2PbUdQR7ubfh7AzEj5K3wscGDS3wOgTj1vSK0w6QIxZtWHC/jMj/IfNRLDg5XTkmzMjdIVBTN8E6ZY+MgrTOIPIZkbxiAfaYMVXLKN6bQ61Ij17UKWLblv1Glv4VwS/hfAKlOml3oz9grE8rZuYQbfaYLxJeFHoi+clk2K5v5R7Rr4lHCWxlvcLYJFo228Clc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(478600001)(83380400001)(8936002)(86362001)(356005)(40460700003)(2906002)(70586007)(81166007)(5660300002)(7416002)(4326008)(41300700001)(70206006)(47076005)(82310400005)(8676002)(26005)(7696005)(336012)(16526019)(186003)(6666004)(426003)(40480700001)(110136005)(2616005)(316002)(82740400003)(54906003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 15:30:09.1324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 335c0322-b9e8-469d-f203-08dad931172c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6324
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
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
index 8f40f9377602..a5b0a75d9e56 100644
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
2.38.1

