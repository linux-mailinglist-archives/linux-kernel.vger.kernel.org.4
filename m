Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9876E6D6A8A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbjDDR0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236219AbjDDR0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:26:07 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0CD76B4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:24:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+j0+NPkjGlYX/cHTMVUUUCxIcZO11dwTzpNe2p2QMQlfefw+9AeeFcFdlEsnKnGZfj8tRvyGsZoKZ7DBaSeeo3OBiRAL2Dl1qyci6JnR23BQg8/JQcPeLevYlhO2rvz5fGv0YtAiuXmhsR9UcTGmyoAdtrMC5ad4jxat5ATGYVlW7w7s9AYoxnNQ95C0Ka6nsMNfmOX5WleBS6HvPJ39bSFBYlx9Jg1/w1lSX9UWkKTaMocWco0rJJkGt1uVsFASlUfjyUsVmuE/OicI5pUzwFPBPGKI6jRPQldyE2GVL7dtik1gZ5KEq+l2VJP5XLV1Lg6TYLyaTYD3IFbgy+Lpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXqpsRUcfiP69LtV94IcK09xDevFBvjDWYCNMYwyo1A=;
 b=kaV/Cn1lxa0ITWi1VIlL9F8LK8LYRvBGUox1TDecdTmQSfIJeNlX+UrsRWx7Xu3s/GkZcr+nTpR+s2ueheUqqyb7o02RadjSnO30O6/jLYfd3qkOZLXX4dmEq84Nm8LVR7DK0zvZKT/vsMi6Pl4Obqk9Nle6kQqjC/ud3FbMK5o9EtzFBj1Y4+awxh4zVKlbe0Fpgs/wej5tqy/y8e/QZIJc1AshIMI4eAPi/LE7BXCNugUvgWk+4AZFMI3zq0RULORxFvw0pu4Yrc6T/r07yV4WsFgDBulhXifU8l9ek/3nHn68+FJeIIAhsSuppX5UiuMHhgXkCbUk0KmYhuRwkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXqpsRUcfiP69LtV94IcK09xDevFBvjDWYCNMYwyo1A=;
 b=GBPBDfivo08bv9ALZPsZEFJDsli+B9XwtRYXzr4DCXvI0Dw1ytu4+PLMfboIBxDxsmVIgog7O722vKHbuGW0a+pQt3xHGOc3NQ2T6tJwnuceMRK/+QMjYo50Dc58YFieumsjw5mUvg4LyKGpWJlVmHbVbukK82ckXJNpUxphzQ4=
Received: from DM6PR06CA0052.namprd06.prod.outlook.com (2603:10b6:5:54::29) by
 MW6PR12MB9017.namprd12.prod.outlook.com (2603:10b6:303:23b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.35; Tue, 4 Apr 2023 17:23:28 +0000
Received: from DS1PEPF0000E642.namprd02.prod.outlook.com
 (2603:10b6:5:54:cafe::a1) by DM6PR06CA0052.outlook.office365.com
 (2603:10b6:5:54::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Tue, 4 Apr 2023 17:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E642.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 4 Apr 2023 17:23:28 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 4 Apr 2023 12:23:26 -0500
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
Subject: [PATCH v7 1/6] x86/sev: Fix calculation of end address based on number of pages
Date:   Tue, 4 Apr 2023 12:23:01 -0500
Message-ID: <09297dfcd621898aeb3901efadb835299c770a48.1680628986.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E642:EE_|MW6PR12MB9017:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6df53b-8d3e-43d3-8471-08db35314e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZS9UtQveil+NGCjttQaGLHBzOd/N3HHQmc9LioJbFx9F+V22qlmzh36XRA6RYlWALZB+KKXKuuivagKdsERXvvhQM2RlGgUKK2Cv8fRUvDPuj69i1pFn0K21Uz8JjVBI/Dv7IhEsUPwTIOZeLAUDRH9PsgdNlLAbMXxWQJ1P6Ryvyx7R7/DLzvH30C2CmBMxkrNxGWVS1fZLuItXeLmLsnWfhcjQ+qHAZRtuY0bLnIfJXoNRCxWvL9hFFoQLVtcuDgumwVpQdB9c5EvLYuBqQzRPJmFpKNwhTogept6evfEeGmbc7f0V949rXVIO2I0MiCs6LV8gg2GK3UcjFCOpgY+xat6BynBdB+9E4mJJ52sWzQc18cEtRXq2tbyWLVEcjq2JtECAutcIM0B86EE2fH+WXWerbbDIG3qhKRP9kt7hwisehSbfBbygPj7E4pzuMGNbsSCRFRCQdl7sY9g4kbx9FK+PdY5+C2qV7cNjHcDXoR4NbHgEe02gJZ2KbgfBH5iDukpV55DomgK1Pnw5sLsuvZ7VYKnJ9CDcPdRurkNn17G+XiEsxcqocQy0IG0KyuSWyhTfvG1ZDT+abxnUJtlIjJcD5P4iQCV5UtUWKh0rvdGqdjQLH74GeYjDxSjUL2BZOsA+OzzkoEo1xRa6C0uaUgHVrjdYLbWOXWnhVrzVN9gA3ZAHTEIWYkP9hWcVDGgmQ/Vsjd/zYMMgfphOPHnt5W3+nL5zW45ghlp830=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(40470700004)(36840700001)(46966006)(6666004)(47076005)(2616005)(83380400001)(426003)(336012)(40460700003)(186003)(26005)(16526019)(86362001)(4326008)(70586007)(8676002)(70206006)(2906002)(356005)(82740400003)(40480700001)(41300700001)(81166007)(54906003)(316002)(110136005)(478600001)(82310400005)(36860700001)(5660300002)(8936002)(7416002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 17:23:28.1061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6df53b-8d3e-43d3-8471-08db35314e07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E642.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9017
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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
index ebc271bb6d8e..a0a58c4122ec 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -187,12 +187,12 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 }
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
@@ -207,12 +207,12 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
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
index 679026a640ef..72ef1e1fef84 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -643,7 +643,7 @@ static u64 __init get_jump_table_addr(void)
 	return ret;
 }
 
-static void pvalidate_pages(unsigned long vaddr, unsigned int npages, bool validate)
+static void pvalidate_pages(unsigned long vaddr, unsigned long npages, bool validate)
 {
 	unsigned long vaddr_end;
 	int rc;
@@ -660,7 +660,7 @@ static void pvalidate_pages(unsigned long vaddr, unsigned int npages, bool valid
 	}
 }
 
-static void __init early_set_pages_state(unsigned long paddr, unsigned int npages, enum psc_op op)
+static void __init early_set_pages_state(unsigned long paddr, unsigned long npages, enum psc_op op)
 {
 	unsigned long paddr_end;
 	u64 val;
@@ -699,7 +699,7 @@ static void __init early_set_pages_state(unsigned long paddr, unsigned int npage
 }
 
 void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
-					 unsigned int npages)
+					 unsigned long npages)
 {
 	/*
 	 * This can be invoked in early boot while running identity mapped, so
@@ -721,7 +721,7 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 }
 
 void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
-					unsigned int npages)
+					unsigned long npages)
 {
 	/*
 	 * This can be invoked in early boot while running identity mapped, so
@@ -877,7 +877,7 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
 }
 
-static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
+static void set_pages_state(unsigned long vaddr, unsigned long npages, int op)
 {
 	unsigned long vaddr_end, next_vaddr;
 	struct snp_psc_desc *desc;
@@ -902,7 +902,7 @@ static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
 	kfree(desc);
 }
 
-void snp_set_memory_shared(unsigned long vaddr, unsigned int npages)
+void snp_set_memory_shared(unsigned long vaddr, unsigned long npages)
 {
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return;
@@ -912,7 +912,7 @@ void snp_set_memory_shared(unsigned long vaddr, unsigned int npages)
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_SHARED);
 }
 
-void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
+void snp_set_memory_private(unsigned long vaddr, unsigned long npages)
 {
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return;
-- 
2.40.0

