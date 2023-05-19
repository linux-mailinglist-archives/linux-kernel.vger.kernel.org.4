Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63F9709C71
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjESQal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjESQai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:30:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587868F
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzR5c/BQWzZjKSkKHsX5bNwhFiMRVhF1b7AtA+iz1aaxEmlkmdRKou2HHWR3RJJdGcIUC/TaOoEWJkOBAOFg0hfjl/eedEzjVxR4g8JpuJUmPgBEhhSt1NgkNBbfu2WAP9TxtvGItT/ncSuPdtCNlPekzgj13coza72Y06P2PuxSYBJUPmIzA1d6WJqJyu47yvborLKF7UJcG611yA0mQbEyOmjapqr+4/N8RBeLGseLRC5IOY4cF9fze+Ed/k/DPZirXXKO6LQ2qs283pvX050iRWYg0993DyJ9IMKFfRj2gxpaFHZfr6Vs9pFUbiVmmSsqj3pzh33s9yJpCPKYjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrl1+aY9B4MUc/Htnd/dbIrwQO2Nvs4GfUL3eP6gJLY=;
 b=HxGNSBdQO3ROXZe7bezTQ9+G+SofqaxVQbANneeRx09uC2YrWIeeqeX9bk1txZ3NPWtgMMmyPCSAk/cy41dBPuEAuF8YeT5/leiPNoJHtutXrOxW+qxwlZp+HezRAB9P4TYyURP5U+Ge7QOH2ltzDRsmmDZBAMmj/MjmEq/C+sRrVYSywksuWGc6MI35/OZbPdeD0GMSIQaag7uXy1+twQJIl4UL3cx7xDdraZeK1iMloqI1rr5viMJ5bjIVbfMmbeWSVRA/B6WsTp/uDepE2UkHrSXVacKDZ0ckGaaLcZ0xtZIcg1x6YxJr8aTY6L7B+TfP7yGMG8BkENyGeKaeLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrl1+aY9B4MUc/Htnd/dbIrwQO2Nvs4GfUL3eP6gJLY=;
 b=GmELiOWmq7RC2wVOyVHG5NtpWoZ0YTJMdBAFeJuBTlyNSZ+CFLb+lNW3T8JUzRDUA2hpMranpacBk0lgaP7YHjP+c/fM0Bw2rPzzu0MMJ8AhHJxe5rwsNfmec24HaJLDYT7nP8q7OvwEqCCluO0Igilb3dXOE5da0rhJaf+B5qY=
Received: from DM6PR07CA0070.namprd07.prod.outlook.com (2603:10b6:5:74::47) by
 DS7PR12MB6336.namprd12.prod.outlook.com (2603:10b6:8:93::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.21; Fri, 19 May 2023 16:30:32 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::fc) by DM6PR07CA0070.outlook.office365.com
 (2603:10b6:5:74::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 16:30:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 16:30:32 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 19 May 2023 11:30:30 -0500
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
Subject: [RESEND PATCH v8 1/6] x86/sev: Fix calculation of end address based on number of pages
Date:   Fri, 19 May 2023 11:30:08 -0500
Message-ID: <b5671e1d6d7b1b9e6ed9f5bde15cdd06aca2671b.1684513813.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1684513813.git.thomas.lendacky@amd.com>
References: <20230518231434.26080-1-kirill.shutemov@linux.intel.com> <cover.1684513813.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT009:EE_|DS7PR12MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e49ce1-0f46-41b4-a936-08db58865dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3gIlnJH/5e5IWpVX+IdVz+30yZ/5K7FaAKfwoEkUTmPDtCL96xrvS3LoXyneR47VNhbA/w4JMYpi6Zojx99zjflqPbLUp6ovE1Brk9TSoVBhJeYJYaHsGAQzbIXwNBEvXno13XskykY8HBmhOTGUcgA5tDX8hWIdrAZh5F1wJ1Hlm+FO13lz8EzwGWBhaanQZtqvlxhSSSfSAb+FvWOfDRJ+evhmeDf22ydmSlu/g9Ttzxh/Z8lbIOyCb9yZZMSlaOkxz6rzu51mVXdFEKAuat0wEJ7j+e//NP4aaW89oHpVlRuN2wth/Akk7yA1HJCCSQ95+aPkSa7rFuUidD4mR6WtWzBkVdriG7DyB8IY/jH6AqQ7rgDj03knGwrAF4VqCsvS4rmMlStHwPOtRBFaFGAcwHBemrnOCVluVz1l60/QnCLfW8IAcexymd0dc2zeNQHX2J4OcP9YDpV40LpX6M4/jaTJ5Fi+SIoY7NaQauvIo4V37JUCSlXGJzbGuhw0RBzNg8TFrpTVbxvXeo3m7juJQoj73+Efs40eZTYPWHQd0RlYC/+hEPVBiZfVaYGvgkqjg+iBoxS21WhFTT2F3NIQ2a1NKM4VgNEew5fnmcllU30i2aBdsUx2xy+ZX9GxJYBgVmHSm00AT5Tffr5FePeINMZpJyK3ylAXc8Z5Wz7fqYs/xLhjY1Z0yuZgTE2lWhZmqj+Az/ceTzK+42mw5fHCK11Bcpovs4UUv23Q/R7PItLSxnc0U3BByOUsQ+rTOhxNZ2Zfi3fcsHLhYf1vxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(16526019)(70206006)(70586007)(4326008)(110136005)(54906003)(82740400003)(8936002)(8676002)(40480700001)(478600001)(316002)(6666004)(41300700001)(40460700003)(2906002)(86362001)(356005)(81166007)(26005)(82310400005)(47076005)(36756003)(186003)(336012)(426003)(7416002)(36860700001)(5660300002)(2616005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 16:30:32.4372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e49ce1-0f46-41b4-a936-08db58865dc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6336
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calculating an end address based on an unsigned int number of pages,
any value greater than or equal to 0x100000 that is shift PAGE_SHIFT bits
results in a 0 value, resulting in an invalid end address. Change the
number of pages variable in various routines from an unsigned int to an
unsigned long to calculate the end address correctly.

Fixes: 5e5ccff60a29 ("x86/sev: Add helper for validating pages in early enc attribute changes")
Fixes: dc3f3d2474b8 ("x86/mm: Validate memory when changing the C-bit")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/sev.h | 16 ++++++++--------
 arch/x86/kernel/sev.c      | 14 +++++++-------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 13dc2a9d23c1..7ca5c9ec8b52 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -192,12 +192,12 @@ struct snp_guest_request_ioctl;
 
 void setup_ghcb(void);
 void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
-					 unsigned int npages);
+					 unsigned long npages);
 void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
-					unsigned int npages);
+					unsigned long npages);
 void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op);
-void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
-void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
+void snp_set_memory_shared(unsigned long vaddr, unsigned long npages);
+void snp_set_memory_private(unsigned long vaddr, unsigned long npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
@@ -212,12 +212,12 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
 static inline void setup_ghcb(void) { }
 static inline void __init
-early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned int npages) { }
+early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned long npages) { }
 static inline void __init
-early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned int npages) { }
+early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned long npages) { }
 static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op) { }
-static inline void snp_set_memory_shared(unsigned long vaddr, unsigned int npages) { }
-static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npages) { }
+static inline void snp_set_memory_shared(unsigned long vaddr, unsigned long npages) { }
+static inline void snp_set_memory_private(unsigned long vaddr, unsigned long npages) { }
 static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
 static inline void snp_abort(void) { }
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index b031244d6d2d..108bbae59c35 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -645,7 +645,7 @@ static u64 __init get_jump_table_addr(void)
 	return ret;
 }
 
-static void pvalidate_pages(unsigned long vaddr, unsigned int npages, bool validate)
+static void pvalidate_pages(unsigned long vaddr, unsigned long npages, bool validate)
 {
 	unsigned long vaddr_end;
 	int rc;
@@ -662,7 +662,7 @@ static void pvalidate_pages(unsigned long vaddr, unsigned int npages, bool valid
 	}
 }
 
-static void __init early_set_pages_state(unsigned long paddr, unsigned int npages, enum psc_op op)
+static void __init early_set_pages_state(unsigned long paddr, unsigned long npages, enum psc_op op)
 {
 	unsigned long paddr_end;
 	u64 val;
@@ -701,7 +701,7 @@ static void __init early_set_pages_state(unsigned long paddr, unsigned int npage
 }
 
 void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
-					 unsigned int npages)
+					 unsigned long npages)
 {
 	/*
 	 * This can be invoked in early boot while running identity mapped, so
@@ -723,7 +723,7 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 }
 
 void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
-					unsigned int npages)
+					unsigned long npages)
 {
 	/*
 	 * This can be invoked in early boot while running identity mapped, so
@@ -879,7 +879,7 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
 }
 
-static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
+static void set_pages_state(unsigned long vaddr, unsigned long npages, int op)
 {
 	unsigned long vaddr_end, next_vaddr;
 	struct snp_psc_desc *desc;
@@ -904,7 +904,7 @@ static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
 	kfree(desc);
 }
 
-void snp_set_memory_shared(unsigned long vaddr, unsigned int npages)
+void snp_set_memory_shared(unsigned long vaddr, unsigned long npages)
 {
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return;
@@ -914,7 +914,7 @@ void snp_set_memory_shared(unsigned long vaddr, unsigned int npages)
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_SHARED);
 }
 
-void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
+void snp_set_memory_private(unsigned long vaddr, unsigned long npages)
 {
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return;
-- 
2.40.0

