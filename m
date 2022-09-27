Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24BF5ECA68
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiI0REy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiI0REr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:04:47 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2078.outbound.protection.outlook.com [40.107.212.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43181DA7B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:04:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXcgOZeL5E6VT4ajFwabrprDkmYCVhWX2qdAoGUVwYYYg5UF93nyA2chtXPesjaq2RPgBv+vzWx741wpy0YaMcSq1JNa8avhXKrjuj9S5V4J69GJxU8CApvkpwxItlxyzRRp7TEPIVab+PIGFS+6NZPe9iIT41lRu3Zay6I6baQs2mP2fwrCSaTLHR88xNUhn6k/ksfv/KwfdNpOfTxIZeOTEPaKyyZ8dRpUv+4/nugUnldu1Xd1PQSndtGvqujvNJfe/XqaO92YvIeW9kxK782jNAUu1CwmubbM+biE4gD+/mSbyDehrfm6XqjxgrWHG1cj2gBQ27kDttW124DWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXmJVj27j03Gu4p+Tr+s4+B0UVaE5fD3LhVxKqW0kZg=;
 b=PfYA/SMAlow6y47sIdvbv07ewYoAqKGE9T12FCHjVFts2TjRdrgiFL1W4ipDa+CyUsFvSD9b6ufF2a93eXa+KQpQaHVQ1ujXSAA7EHN2W9GqdxLHTajNjFfqNbF4CJt2MSRBRQrByDBK02pqAw5bFwzVsievk5fFNcvFq6JICepTFva8Fkmt1glNHDjDAhEeKmT8TDEQ/f5kbG1W6a8ZntUnChfi2X2gYctXPN8ncfIh1RFLkbXKGvSaJO5tor7FX61vebUMZFAs0dBxcSzYHALjr9/BF5EQS8rsEL3eCwDNXjLfEDTyu+dQqXYfhCuH3YhJhUuCDzospKYs8Lh+8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXmJVj27j03Gu4p+Tr+s4+B0UVaE5fD3LhVxKqW0kZg=;
 b=X8VZDZK2NvOGMltezNA001h2NYJe+a9D1+CCXl1t3G7WgxFLBNJDQQVIbmuHfxF0ulL/DpQrgq9B5JzGD44GyvA1qFp8Zy7ueFcby3KEdYUppMAOFJCd1CEAutA2+OV3NrtRXtNfdgC5IikDX6/3PNLcR5IJ60Ue6gDtBxEL9JM=
Received: from BN0PR04CA0074.namprd04.prod.outlook.com (2603:10b6:408:ea::19)
 by MW4PR12MB7312.namprd12.prod.outlook.com (2603:10b6:303:21a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Tue, 27 Sep
 2022 17:04:44 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::96) by BN0PR04CA0074.outlook.office365.com
 (2603:10b6:408:ea::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Tue, 27 Sep 2022 17:04:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 17:04:44 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 12:04:43 -0500
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
Subject: [PATCH v5 1/6] x86/sev: Fix calculation of end address based on number of pages
Date:   Tue, 27 Sep 2022 12:04:16 -0500
Message-ID: <afd222473c7b18ea942e754a6c4df26ed74eedee.1664298261.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664298261.git.thomas.lendacky@amd.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com> <cover.1664298261.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|MW4PR12MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c8fa3d-be89-4d00-41d7-08daa0aa6008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v9si/I8uqinqxKw4gYmrLi21v0AsnPAIEl5pJTIP+LVeFUDo8ZHErwvvBWMjbkI2K9i+KaMF6JlHWXfBK12R2Djb1ikCkgrRP+UdXqrXHELhxlhhlkjgs5UH1n1rD+qAR2vmDlQn3rMt2On7cm9T52PpmYnF8qWk3uEzYVufBhIMcXmXxnxyxDwnn4gjtSG15quAYIKV0B9vQ22I1ItpCmEUKj6/ooItpIQndiceKixTnBcxewnTAiRomh+S/Rh0M/6h/EB96j+AC3nwK2qKDdsEmsxnInX4vYP1ut8+Ufgc3XGhyMvlQbGiXXGKd+K4j4aIrKJke4gKHjvvHlSNtBG30SIA42iRH0s9tl/xxFHN07NFPwP11H9Fgutw5oXmbDmptF169QGGD6BgRRVodgt0B9SUiqjvA7UQMWD4gVlpsC1wpYjgN8zSsYNR9ktih+WLx2nh4QbopxWNP9NpN0KLc4xpSV6eHeblG4UzMX/R4GeNKDDkaj7PFQDZGdngx7vPXvQs0Ny++axeClh5DFhuxPMhWsdgGxGxSgHqwpslCZh9iWa3ZnoMDbsW6Dc8GQCvhXBUqhBC2R4RsEnRDBcGq7pmPazdh4NfRLd4f9a5upA15LronrgGVRxQqkkautBj86tQfWOyY8Phjw03PkjuvJN+zT8yan8SxFOdNdQ7/eeRYSnNg1n50fhNq1/2NumGe2SFNKa9Cxn+U1BKuH5Z1ngSBymauS04ooqXk8j1Xu+CzqxxIdzHcs2/hnCSiEArQm5UQHU5dVX9zra3sfAK9Oy1+oppDRLNsUVVOME=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199015)(40470700004)(36840700001)(46966006)(7416002)(47076005)(5660300002)(316002)(426003)(36860700001)(8676002)(336012)(4326008)(16526019)(70206006)(110136005)(70586007)(40480700001)(82310400005)(26005)(478600001)(40460700003)(54906003)(8936002)(82740400003)(6666004)(86362001)(356005)(2906002)(83380400001)(186003)(2616005)(81166007)(36756003)(7696005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 17:04:44.1759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c8fa3d-be89-4d00-41d7-08daa0aa6008
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7312
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calculating an end address based on an unsigned int number of pages,
the number of pages must be cast to an unsigned long so that any value
greater than or equal to 0x100000 does not result in zero after the shift.

Fixes: 5e5ccff60a29 ("x86/sev: Add helper for validating pages in early enc attribute changes")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/sev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c05f0124c410..cac56540929d 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -649,7 +649,7 @@ static void pvalidate_pages(unsigned long vaddr, unsigned int npages, bool valid
 	int rc;
 
 	vaddr = vaddr & PAGE_MASK;
-	vaddr_end = vaddr + (npages << PAGE_SHIFT);
+	vaddr_end = vaddr + ((unsigned long)npages << PAGE_SHIFT);
 
 	while (vaddr < vaddr_end) {
 		rc = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
@@ -666,7 +666,7 @@ static void __init early_set_pages_state(unsigned long paddr, unsigned int npage
 	u64 val;
 
 	paddr = paddr & PAGE_MASK;
-	paddr_end = paddr + (npages << PAGE_SHIFT);
+	paddr_end = paddr + ((unsigned long)npages << PAGE_SHIFT);
 
 	while (paddr < paddr_end) {
 		/*
-- 
2.37.3

