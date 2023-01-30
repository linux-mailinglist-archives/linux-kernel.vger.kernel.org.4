Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707EB680CE4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbjA3MGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236615AbjA3MFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:05:33 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4AD1633B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:05:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYJN6fmEStB93YHlYHtvFqj3nbGntv8z0zpAzdOKFVrJhZS8Bo+M5pXNhPYmkX/vL62gActEo4xm/tXiFXmTIBqbhmRcq8DHOY0A6jthD0rI4KIevcO8rxNhZrbDW7mK8uiGhdN8pJEWHdDiKzi20hirKxaN+1q3VH8l0uM0873hrBc8jXcQWeRanz4pigVZYuC2Cqvb0uZ9+MQ+lNUZaHZAcg9I9N5Pqo0cBvYCqAxUFHaKu3DISBqHqb32qgzh0GzMuDgVZsc2w7/BGYfboh+85wlAxmgfqQYIPiDDbo/0Ne0kvDI0jka2T/LkszuM3p2CRWHcHYdCi6azRU9GoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5bvDC6pa6+s/PBlycOdJDT6yN6rHuNY3cKJOLCjafY=;
 b=OxFwaZUuIbsaNyc0N+1gFTxJ+h3MpqqCSiCovnsoAfkZQqZdhJbUFvz66+rI3PmvHqBdypa7k0V9Dm9drdzFjxBvkNTALALJPXTO1tNSJMpYP99iIVVo6YlsAmUf5z7HmBxw7LxGx6bDI/pJBtuzQUUJHBAjkq0vXWKQh2TdgTFIoSHuGkw7mUY9YFbFfaNGW0hKrCNcJaW30su8qzzxCy1gn9ScjRr7FHXVKl00saR9B3h2ZO2R/ep2KIKmKZ5Jp+cPu6fiL4ygpXgdv75h6mL2DE3g22TJ47Vu2qAoa90XFozqPyUW6oLbvaGjqnb9hjDivqO5W9HVEXUv8AT95Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5bvDC6pa6+s/PBlycOdJDT6yN6rHuNY3cKJOLCjafY=;
 b=RWIzGqJFsqA9beog/7nY/nRX6NzNKp1+QRnHFW1Cb10kukSutgOfsL4nzIiRmcxJNvxE9ZxLoov46r6VImM9MIxLIOQF7l7zrGwZJOa6jIyE0NBVTt4YyCfYBlkD3TaGwCmiFilS99f8d+vUbgGGAbJLZBl2VEy56f+5eluvGD8=
Received: from MW4PR03CA0101.namprd03.prod.outlook.com (2603:10b6:303:b7::16)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 12:05:02 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::b0) by MW4PR03CA0101.outlook.office365.com
 (2603:10b6:303:b7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 12:05:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.21 via Frontend Transport; Mon, 30 Jan 2023 12:05:01 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 06:04:56 -0600
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <jroedel@suse.de>,
        <mingo@redhat.com>, <tglx@linutronix.de>,
        <dave.hansen@linux.intel.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
        <ketanch@iitk.ac.in>
Subject: [RFC PATCH 11/11] x86/sev: Enable Secure TSC for SNP guests
Date:   Mon, 30 Jan 2023 17:33:27 +0530
Message-ID: <20230130120327.977460-12-nikunj@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230130120327.977460-1-nikunj@amd.com>
References: <20230130120327.977460-1-nikunj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT016:EE_|CH2PR12MB4056:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b9ff232-b32c-4a8e-fb52-08db02ba376b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D2z3AOhjZ9mYVTJPQ800Oa4Hbm8GHcS9A1DF5D2JhkUHWX6zwj/qiNdKKd1UFERtcLippqVVS75rWKKUXvpFwHxLEk1N0pMFwbAI8JAEGxXjhc9328XCk/iypZgSDpCj2DY0Qg4A+FA9ARrTSdPbSkvm9Qc2VlscpWWPU8v8KWQpx7FSWLOSIU15s+JbaHx9/oQnz1i+rJ44H+GBAfkDmDTXeURFusw7vAgGJQsbTddnE3gP6TfJP/prKY8Y1Wh1jdohGMN/iV1OzGWVHEOZXpiYkct205YaP4dxtkC31snlaRUPlySv3tvCi0M+bqSokrw7m4DEfDC/iUkuLAFmSA/PshZKr3q1b1OBZ+leYAnw9TuERBYpMbLK9HKDPMFWFAlQ05EATFfHW8qICcdwNr/ZS+cIvKipwdyFfWeZZk3HgzL70kP4XwagSpTKI3Trl4I8nZYYgc0WngMQF031dy8scs61zW0mNYHgoV23XgK0SodD9tgtk3l3lveoXnlWCTm8nuziTFVNealXCN36lO/5CF0Pyyt/OC6r4aOPANjcmJJBnc7syW6JqEOb/H8L0HNcjyTx/pLECIxl6xN+Q6qtRt3VLhio6YT0NPzAgsEpItUsln+4SiaS7V7ra3r5NkV1kSMS0cVFPl4112NZ0pu2/Be0VtwBoBGnW0iofs1yBRck09tUeruCTjne6RNbzt+zj0IWe4n0Dpqiy06Qtk80mYBQ4x5pMDMsZFTQ+G8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199018)(36840700001)(40470700004)(46966006)(82310400005)(2906002)(426003)(40480700001)(47076005)(83380400001)(36860700001)(5660300002)(41300700001)(8936002)(7416002)(26005)(1076003)(6666004)(16526019)(2616005)(186003)(336012)(82740400003)(356005)(40460700003)(81166007)(4326008)(70206006)(316002)(110136005)(478600001)(54906003)(8676002)(70586007)(36756003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 12:05:01.8490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9ff232-b32c-4a8e-fb52-08db02ba376b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
2.32.0

