Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A0F709C64
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjESQZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjESQZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:25:09 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24043E54
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:25:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcVM+mOc44rMOeLEHRGoYx9rdvOdQa/smUNa/4E9KV+IJeIY39eu+PyC/mkGSzb/t4PzwQNd6SzL3Itv+Jj3zSusgETTSdLQZsufH2yQVu//6nKU68CzpOPsSEA1Lqs4s0oe588ajfdnhxRAYhoPEe3Av6bq1sj7R0FMK1pk/J5IBKinfDZ2WuBrZCRmrWSiBIbpvdm2XtxYaABYAF2nLj9xLk1cuPGLANBxgp3iAgB/D1bUEpMpoGbl0XvcSwQHhtJ9Ga91IW1cgRRNInZMubx72RLJU3mwLj7eaH5fxfkU40GPa5dCahWPXHbyxMFktGs6yHrqsjgBXVD6DbAFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blqlGSo1u7qyUOO+G4REHTh7X/rBN0iZH9kWG9Z8W9U=;
 b=CYn6hdCKgUPxxm6rVGrsc9nSBpb/i4FOyEzLd0fdpxjWHGMIYsAYOA+ifsl5LqjZzTP+ZG2zNGNz4jnecGTxEcliZGnWiciKAifIGZy9kG8mP+BWEJcygDJm7hUiyzg1CvpV538F5QsxosGzqtdajc3wvQAhntnR1E8IL2nlZLCBF9wdjDkLx+PJzLRe//34xfVTPETOKIWUfRMg88AnHA6VJQhkzKAhLKKlZsVEtfw6seOYipTOvkc/WhHWB+vP/WYey3aDaysOc+WALESDUeXjp7l2Y7yDkuZce+kwXAWhzMEtg/cDFZXKK1azBg3Z9QI5lpv7XuP34P/fy1L7Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blqlGSo1u7qyUOO+G4REHTh7X/rBN0iZH9kWG9Z8W9U=;
 b=c0bm19etJOSc5E7mwdVRCCTQVjMv+TpQTcIFeWuTEzlsxmtoVRkjkR40gBn4jBPMyxBrmncW9kro33/UcpjbrJffq5WP+hkt/fJ74OSTHG9vZy1GZIQPf2n3tY8IhmoeEjReGneOa7cU4lbFtM9tabgCoBF0qbj9o++tEcS3Gx8=
Received: from MW4PR04CA0203.namprd04.prod.outlook.com (2603:10b6:303:86::28)
 by CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 16:25:00 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::4f) by MW4PR04CA0203.outlook.office365.com
 (2603:10b6:303:86::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 16:24:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 16:24:59 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 19 May 2023 11:24:57 -0500
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
Subject: [PATCH 4/6] x86/sev: Use large PSC requests if applicable
Date:   Fri, 19 May 2023 11:24:15 -0500
Message-ID: <c5448163eea57a878d9aeae504bf46ad52f9a879.1684513457.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230518231434.26080-1-kirill.shutemov@linux.intel.com>
References: <20230518231434.26080-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT058:EE_|CH3PR12MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ecbcf4-cbc7-4b8a-3b97-08db58859763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: szENTl/GmerTTlxyoxr3onBiHsWk6iFPMAqGdcnPlDu+37xbteXNru7RkWb9Ga5khWri4aSnH49EwvhAvhWwIYyCdO6gx1KBPXI+XsOzaZehbGOC5X/fgWxRT+ioFppUiVZUbo/lkJ4uFbK6Pjgg8g8oOd7Lgxg1fd+P0w1V1+gCAgK008b14LyRrmi5wHjBzvwafRv/GBqAbwsm4Ab69jBjiu/rEDoPhuP+oPkLsv1tX3QS7WwzGpi5ZpFbq59MqxyrASuvOI+kDgh1Zl8D9G7fXtw6A6KXYtyk4DCEOyuM6JH6Wsz09/2t5U9L5HdE/gmMaGr4E8c53+HUvFzTD1hMeVDxwY4vLnAQyWeqOlAuqyBYFWyl1fuNrZsePwBduDVu/vEdqVt54Ul87KlLM/i8qxUOS9yVBTyF90kk8OerO/WTHPjFO9Xx6hI6BGohKsoL+zu2/0cH5V+bck6//e2TU/51yDUIYqm9YouGidfEokYywz+E+YUeFphTWzf7xKubMoe+f1hAEDonPfzSyd8Sci7/qTL8gJRiCZo+NM1O1P/nUIjNcbr28qumcLEoa/FyO8QVSSN/nTT1cPxhUrcwZc0NJwrs7j3UpPfPzWSYNS+iLgdCiMzzl9DoRx65KI6DC8hHRWe+dq88hsWRXNKYyWs+9l5KC6hBV988BaJhTCwpt7VfqlI/h+c+jKp/5pBBt26GhkBc8TU5JwcCF+S5WeRLZHdkcAVG0aBUvyJEYBiyJcdHjOQUpyAPofyTNERIfkGfvWoaZtJTW/XSxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(36840700001)(46966006)(40470700004)(70206006)(478600001)(70586007)(5660300002)(2906002)(8936002)(316002)(8676002)(54906003)(110136005)(4326008)(41300700001)(6666004)(7416002)(26005)(40460700003)(36860700001)(356005)(16526019)(186003)(82740400003)(336012)(47076005)(40480700001)(426003)(36756003)(2616005)(83380400001)(86362001)(82310400005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 16:24:59.5408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ecbcf4-cbc7-4b8a-3b97-08db58859763
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7548
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
index 7ca5c9ec8b52..e21e1c5397c1 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -80,11 +80,15 @@ extern void vc_no_ghcb(void);
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
index 973756c89dac..8802a75e1c20 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -657,32 +657,58 @@ static u64 __init get_jump_table_addr(void)
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
@@ -703,7 +729,15 @@ static void early_set_pages_state(unsigned long paddr, unsigned long npages, enu
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
@@ -728,10 +762,7 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
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
@@ -746,11 +777,8 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
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
@@ -834,10 +862,11 @@ static int vmgexit_psc(struct ghcb *ghcb, struct snp_psc_desc *desc)
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
@@ -851,27 +880,37 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
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
@@ -879,6 +918,7 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 	else
 		ghcb = boot_ghcb;
 
+	/* Invoke the hypervisor to perform the page state changes */
 	if (!ghcb || vmgexit_psc(ghcb, data))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
 
@@ -886,29 +926,28 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
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
@@ -916,8 +955,6 @@ void snp_set_memory_shared(unsigned long vaddr, unsigned long npages)
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return;
 
-	pvalidate_pages(vaddr, npages, false);
-
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_SHARED);
 }
 
@@ -927,8 +964,6 @@ void snp_set_memory_private(unsigned long vaddr, unsigned long npages)
 		return;
 
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
-
-	pvalidate_pages(vaddr, npages, true);
 }
 
 static int snp_set_vmsa(void *va, bool vmsa)
-- 
2.40.0

