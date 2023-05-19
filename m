Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6A1709C5E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjESQYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjESQYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:24:38 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374FE8F
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:24:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuTp3zJfzaOJGkj59dZAL+IWcFxua3nCG4r8EObB6zQBvCC5by95sebqFVPX8F/dR9wWU890fp+S+aH9EB8jdxG7rqBKPUWUyHlROwi6N73MWVr7SWPOpxdTE7t9W94PEm3vUi74hUYj1kdovhHFC6dzXr+RtuS/2LBkYPMtSyokHRh79C8/GzVIVCGLWSKNrZAWod0mMQ7k8pZrUdHstZyafskq9aDvWHVlZ6hIHsCw71z6BlU1XlavuxaKPt4lB+p2b1otX8DOpMrDvvj4W9Q9BcGmzhPMRHLtlXReKihoGjj9GzSh3CyBxcN14pIVdxxC0CEjby0Z5NTYLJzW0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrl1+aY9B4MUc/Htnd/dbIrwQO2Nvs4GfUL3eP6gJLY=;
 b=mXZOLe/1sWmPcnhxbuApAlRjYdJI74ndKBvZhnkgxb4+pknXAxM/Ovxzgylh6ptjbeCXOEcsnlhfUjfO3oEzCaZPKCbc+kvfoJlBhf+mMWNRB3PN5MAtd0HYO39JBQfuDCQ7BxZVPGsXf2u32xp4KMOdbqD6hx3ZjHAHy/eB1l3wWs8NlqIxErp8/uCXYOZqbs2Ahsik7hFswQHdyeB8dBakk75+EzwleycltYgw0M5rmUjJnIxAOXbcpga73Nv9/8Fd+qM4y3rXuJ4FXszONMesQFiaAiNkqwXMWvMt5FW2rRQ7nHtqgzZ9ZNqQ9LQQIZ0pJELPJ4nCGCxagN9huw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrl1+aY9B4MUc/Htnd/dbIrwQO2Nvs4GfUL3eP6gJLY=;
 b=H5/f1G0kGjI+y+3JEcKgBVWf4Tj/i02lyxBguYasNkpGXPzLPamINDZv9B9RALdIdfJ9OvyLQpJ0Vj962lvzWMoHQARRd6Hi6JwkBIg07/pnnaO3ii1E4kkKvGqhsdZd2lZvVpkYUA4U+kz/g014dqE8vbcYZ/oGACgTHbfWWIs=
Received: from MW4P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::32)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.21; Fri, 19 May 2023 16:24:31 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::b7) by MW4P220CA0027.outlook.office365.com
 (2603:10b6:303:115::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 16:24:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 16:24:31 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 19 May 2023 11:24:29 -0500
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
Subject: [PATCH 1/6] x86/sev: Fix calculation of end address based on number of pages
Date:   Fri, 19 May 2023 11:24:12 -0500
Message-ID: <b5671e1d6d7b1b9e6ed9f5bde15cdd06aca2671b.1684513457.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT049:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a3aafc-79d8-4200-afbd-08db58858681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZVPVb2q8WqseMXo1Nju0h6QG/nlkUSFo4imaYnawpaT9MZ0Y3D8kyIPqSeF395D02mL5G11E3H8saEjTzMjSqMv2G2Iy5JtalBc+jN83PIl3FHn8T7gMLElqcQlNBeLUZdwSEE2lOO0k5LezWCfANWiKpj+AK6szvQRFoR4dHtDzdnocC10E8gcoTjxk7LQvf5v9KxW+QBUSrHStwdqOvizXgIfwI2XjDolZvIKdvQxqUDMXCOAyA6hkkZyQry9lEKhBVMUa1xYFH25EErLJ8X+hwiw9rXtXVPjGC+mlnXqq2JQxG9bFbQ78BDCbViA2jPyuiDwLbww9IKGb/P567/++uW84EpqlMolMuzJHbNqLPEESE1Az/x+Jsvsh9oAz8ct8bEWiRbnQ46c7WH25SOYJGn35d6kmNfTzQzHLIiwSZrFrPJ3y1YdrJng7MxwsSldsbWjKy2iB1jhf2FgUI+NKf+XOTVSbef/LLc6PRve5LimxUldomzFS3skAOrTqOeDlqz0xjR1wN+nuebHOenxRXS7vVLvolKR/Q+fTL4e+uuHvOPELEnpG2/4+8KpKfeNjdgddtAQiO0mjU++eCIwabKdoj3ml/VpVyRil3n3FLUaz9DuhhmmubIKnyHb6g9ls/xecNvsWTs/OhXbAyw/x9iQK+3HcIWo5VVJE8oe7iN3zLGqX7CFj/AFQVeHg1yL6EIqC9uiy6nk4aqUu8B+kSyjHmiHg15XMbyfpJAZAWQcY4A7Na2YhivUbu0z86b0lw/6dgqyOl0W9rngIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(8936002)(8676002)(478600001)(40480700001)(336012)(426003)(54906003)(110136005)(41300700001)(5660300002)(7416002)(4326008)(70206006)(6666004)(316002)(70586007)(16526019)(2906002)(186003)(26005)(40460700003)(81166007)(356005)(82740400003)(36860700001)(2616005)(47076005)(83380400001)(36756003)(86362001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 16:24:31.2191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a3aafc-79d8-4200-afbd-08db58858681
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
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

