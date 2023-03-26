Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667D36C95CE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 16:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjCZOtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 10:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjCZOsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 10:48:53 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368C0468E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 07:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hq0p9iEYBimKsK8xJ2T7D+LzOBIyVwWcAjE/liq1xewabc1Rp1k+rg4Ats9FPl8DDWcnX6LLu6OHmeQZYCtrzP/X7fFRsZ1lpRuV3TE89TmIfCBdzdRwRlJhPrMl9QIUr2iK8AzQfI0cCE6/xGym9guvnhIwyhEgzvAW8sywQgl//GFQxQe25v4Vtcw0g5DNvG4jlfKLItb8vl9OwirNadrS7P+opTx4FP/oS+tGku7zJM22MuuOhW5cSaTTyEnOM3rTIFJshmj3/GMmkykR7YXP0vX0tPc+5gEvyVuMjSe4oxrjPyFvExq78FGFAlpGhPFaimcYZzwgNenk0r6y5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hatQwVALEOXgXnuAEwDqSmbsKdsvwSWxgQtiCpU1jwo=;
 b=gmXjpAtEv9UHvxvqDDOUNNKK87wZkyy0MKUVTwpEGqkGYn4TrQ+3VKIpkD3NSIFNLowlQLSeN5cQ0Jr3WZ9Kxqb5n0QKqcEalMa+dZ+v5/jy6ZIMbHMfHx/bRYRlRh2wCi699q/IP1ozINXZC2cMpycC6rCTywTKRF4auzJO65cKVCqv6rroHcLT5zJDVYNQRkxm+u01XypgAcziY87IX6USitojm2pq8aVDqwR/TG8HoB6P6vqVMXFodqAW/e7aC6YvP+whCu2xlTTA1+V86Z35Z6TsqVAyHRfqIzBGK0nsHmHUs3Tkk2fr4xWCrlWcasdxIARYMurVEVt3w5U23w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hatQwVALEOXgXnuAEwDqSmbsKdsvwSWxgQtiCpU1jwo=;
 b=NS1q5hpHRIZaiPjjvzT2ewq77qAjWVY3l3f0D4egOU7RtfbSG6Pu/xab1cNT8LxcahW5KNB4iXVa5SrylpHAC+lk5cQlI0F6p80+MBPxNXkGUYnwF+AzycE+Vj6XRdYoN5Ty4rlo1IOn0iQbdMEIVldy6rZj9cs5jLu9FcKJ+/4=
Received: from BLAPR03CA0040.namprd03.prod.outlook.com (2603:10b6:208:32d::15)
 by CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Sun, 26 Mar
 2023 14:48:01 +0000
Received: from BL02EPF000100D1.namprd05.prod.outlook.com
 (2603:10b6:208:32d:cafe::5d) by BLAPR03CA0040.outlook.office365.com
 (2603:10b6:208:32d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Sun, 26 Mar 2023 14:48:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Sun, 26 Mar 2023 14:48:01 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 26 Mar
 2023 09:47:56 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
        <ketanch@iitk.ac.in>
Subject: [PATCH v2 11/11] x86/sev: Enable Secure TSC for SNP guests
Date:   Sun, 26 Mar 2023 20:17:01 +0530
Message-ID: <20230326144701.3039598-12-nikunj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230326144701.3039598-1-nikunj@amd.com>
References: <20230326144701.3039598-1-nikunj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D1:EE_|CH3PR12MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 2103e54a-175b-455f-7917-08db2e0918f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xEXiwU5XqHA70wIY1hqwWCmj6r0By/PJNSa6t1FqW+1UmaykJiZ7U0XO5kla+SUE1Fc095ikwLSDAC6+rngwyc+0mDUwU71MoPGN54dSu30+W0iubGPLjZ5DMjLxSoHkobQkT7n9zMRD0g0euMnzlblVj4UjBes6gNlPRjvwKkhnkJtpCcAfutVlDcast7YHHiE7xf/1m5FQYlX6B4XJmgwLqOad1qKRb3kY8dQIDkFJmLkg/lu7lQH/DYrTcWGx2XX/erKDQ6108VORzDkk4mWgSWpZ6yWQJ8+yLwAYW1cynQyZdAW3xhOHYuwQ87HsL34sRtIgvb0hhCHlpve3kmIfh3IXcWha4ivnfqPWpN7K9jzw4KE1VzYjZq5AVhwZv5TQE9o1D/NCYRU8GAKsLsGdZSv4ODX+en0gOVDLbO3oTssuNWo3drKKgapc3k6S10ePCO14b2QVWU5QWqUWn71Duf5Xpvqi5wVW/+1I+wyFxksJ2Iu7VhgZWeCnJstr+cHX/NmP0sSQ3TmTbaybW5GC5xi134WSVNHV0+McBA49W9YO7XI22Hi8WG8alRcVTZZqBg8+X9pGyNmnq+LKbtogvE/2Ely0CnXm+18sN0KuEuhzhoTji/0FoF1PXwYdWknRW6+I+HgFbZowEbjbJC4fuAwiGXAJGBCDKP10UpFTEJOvAI/8pc5kLcvnGYZZMidCz3fNM5BUbCIYcz4c7zwkW1CXmsvN1y++4KuNhnk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(47076005)(83380400001)(426003)(336012)(2616005)(4326008)(70206006)(70586007)(8676002)(54906003)(7696005)(478600001)(1076003)(26005)(16526019)(186003)(110136005)(316002)(6666004)(82310400005)(2906002)(40480700001)(36756003)(40460700003)(41300700001)(36860700001)(5660300002)(82740400003)(8936002)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2023 14:48:01.0912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2103e54a-175b-455f-7917-08db2e0918f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all the required plumbing is done for enabling SNP
Secure TSC feature, add Secure TSC to snp features present list.

The CC_ATTR_GUEST_SECURE_TSC can be used by the guest to query whether
the SNP guest has Secure TSC feature active.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/boot/compressed/sev.c |  2 +-
 arch/x86/coco/core.c           |  3 +++
 arch/x86/mm/mem_encrypt.c      | 10 ++++++++--
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index d63ad8f99f83..13b6ff192c3e 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -315,7 +315,7 @@ static void enforce_vmpl0(void)
  * by the guest kernel. As and when a new feature is implemented in the
  * guest kernel, a corresponding bit should be added to the mask.
  */
-#define SNP_FEATURES_PRESENT (0)
+#define SNP_FEATURES_PRESENT (MSR_AMD64_SNP_SECURE_TSC)
 
 void snp_check_features(void)
 {
diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 49b44f881484..a3d93ed722c9 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -68,6 +68,9 @@ static bool amd_cc_platform_has(enum cc_attr attr)
 	case CC_ATTR_GUEST_SEV_SNP:
 		return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
 
+	case CC_ATTR_GUEST_SECURE_TSC:
+		return sev_status & MSR_AMD64_SNP_SECURE_TSC;
+
 	default:
 		return false;
 	}
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 01abecc9a774..26608b9f2ca7 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -69,8 +69,14 @@ static void print_mem_encrypt_feature_info(void)
 		pr_cont(" SEV-ES");
 
 	/* Secure Nested Paging */
-	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
-		pr_cont(" SEV-SNP");
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
+		pr_cont(" SEV-SNP\n");
+		pr_cont("SNP Features active: ");
+
+		/* SNP Secure TSC */
+		if (cc_platform_has(CC_ATTR_GUEST_SECURE_TSC))
+			pr_cont(" SECURE-TSC");
+	}
 
 	pr_cont("\n");
 }
-- 
2.34.1

