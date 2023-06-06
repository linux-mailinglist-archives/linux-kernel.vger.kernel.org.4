Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CDF7246D6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238418AbjFFOwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238419AbjFFOwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:52:01 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C131719
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:51:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihiab1lLw4hII/ZJdKmIeVa9XgS5/mKBx8znIgC0QY0xbbgoLQgz8+AzuC0LOF6CUekE0SjY7hA5onkEkoXqUCo6hNDCpa0V+0X7wo2i3cALvqFRtmRLNNjxdx2jL+5hS9pO3hDyVh/az1VvlRMFnAWzjUkLXzEbsWkVqwFOmAudYwJrft+LC2/jIVWR4egrTEOcOV9Jyqm172VGd7juYJvqi2HNCabKXVuWzUpVDtkWPO7ueOVwqE/QujW9ziStt+YA9TggT9eaYSXMDAfGznucShVqY4oTOGYmPStFFw0CE9szNDa6/+GMz7sOaNiTBSnrKYlLyFcRyvqX3ak3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3BWNRDBjL5IO3E4gbxcdh48HaLOHpW9frVn6bWGU9Q=;
 b=TNUvHldIGCRtvjbs6+sCL/EGVjujXMOjTT6PPCd5NpX36Jv3c1unnztvXEn1YQrUqEwox6JVjdeaQSOtJPyjahRItdqjX/Oh6c08wqQxc3IHCubzi3VM2nREYGZK9EhSYVspU3q66XHkx/GtSMFgUbJXBsn/Jp/Vn8ezo6su8ZWttEWRzTZsNSSjnRagscRb52cPJT96pbvXVIdeLANAW21VnvEmvMNv2nXAPG/FVs8MTpK9OtS1yFCp6fwCT1N7tb+TYnr7uwyLgfEuM5aUAdhHB4hGFUXGuQiavGYKjAud0oluXaJ2dOth8KHcAz9Ubqhdzkab70jKNtFBHvTlEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3BWNRDBjL5IO3E4gbxcdh48HaLOHpW9frVn6bWGU9Q=;
 b=bUz29HgwXfQvWmcaet+hlmNZniHTIaJ0xLuRm4pBmFM9x7Y1KfX/KO6fYJp8UroFWtPsI9hyXQI0h2ZQh3Rd7BNO2c7MbwARFI3BAjQeIfnMBWre9ad253Z4X/AO6JWoXgV6skWaZVUV+GD+F8vXUN7x0JaLT9PApn6ucwZmZm8=
Received: from SJ0PR03CA0175.namprd03.prod.outlook.com (2603:10b6:a03:338::30)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 14:51:49 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:338:cafe::72) by SJ0PR03CA0175.outlook.office365.com
 (2603:10b6:a03:338::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 14:51:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.36 via Frontend Transport; Tue, 6 Jun 2023 14:51:49 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 6 Jun 2023 09:51:47 -0500
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
Subject: [PATCH v9 1/6] x86/sev: Fix calculation of end address based on number of pages
Date:   Tue, 6 Jun 2023 09:51:22 -0500
Message-ID: <6a6e4eea0e1414402bac747744984fa4e9c01bb6.1686063086.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|MN2PR12MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: 06356530-4f1b-4b5b-966d-08db669d8ed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIk5ngNJGGn10KaQ+1nM/MChgT0khBXhJq+9YZ4KpByjIbsF4mblajx0mU1wYckIXh6HnsT2aBg7qanRVsZ6rc+Zrtk00xWaMN4p1M6YZRFzXxYAxyKQQFgRHAlhEMdiK5GO1aGGEJolTYb+uVlJMuwYVfvYM9lKIU7itvWqN32q/OARUpoR1l72xw4a+jXXQeep3gz+zaema1UTqHcDoy/jBYR3/QSKTpqxXOoMoa3jqBMp6tTb10LedUj8MdRVlm0Ze3ZnvMD9as4uQPT+2OOc455O5gOFCsE/zJpUNBdKMenfkegzrktUSxxSZ7WjOvhzJcQNWvPsmXvh/RqQ/RbC8qHeaQ5H1jQVuUJloSKtNXx6BmpYX3mf2TpLUTzHZ4WaQyGohQlsGqdz4r4GtjVwe05DJpeeb4BNqpmDqBdw7G3ftd+M/0UfSuyu+EYRN1nUX2iEyGCInXc7EONQAhL6ygNlF7wWfy7IGIuyYRrbzTHq9qIrhvBal4G+p9yAMiGeK6u6LiWNf/oqIffb+P1co8cDgnOdjbbuoG4lZRlRLn8Sh6XiizliLySi9pLhisTi5OmXV6snKeJNuZWhpea/layrXRW4pCDTWQw052iMf58gD6EcQtGeAuQA2GPPbH/zrt+NKjAI0tVZnznipitymBmFgIugXpabRV+PjaEs8uRo9R1i1LRZ4Z1hXWoQ3C1kR5BHG8bWf4YJbxQ18SlGqu0aluinwRJa44eqNnua1YiBmnBHwj9l2ROagIK7iW/E2Eh1ZdSrb2tQEaICLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(40480700001)(186003)(54906003)(70586007)(110136005)(81166007)(478600001)(82740400003)(356005)(8676002)(8936002)(4326008)(41300700001)(316002)(70206006)(2616005)(426003)(16526019)(336012)(36860700001)(83380400001)(47076005)(40460700003)(6666004)(26005)(86362001)(5660300002)(7416002)(2906002)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 14:51:49.3649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06356530-4f1b-4b5b-966d-08db669d8ed1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
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
2.40.1

