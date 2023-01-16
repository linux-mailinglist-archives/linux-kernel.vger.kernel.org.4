Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EA366CFD8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 21:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjAPUDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 15:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjAPUDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 15:03:42 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20A021A32;
        Mon, 16 Jan 2023 12:03:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+SRPnKfFipgaEBsuEztsuKH0Hsui+4yqzqrCDlJ0CXycUeMHs5LnaDKK5Ow9hIj/y2xUPA998JjsuGVxRjA7+lssQWcuF+kU6vL51lF5ma1lRK6H0dEyvCuTzJreLx5DUi7cXMk29iJ48q6k0lkAswD5CWUlgiN3P9Ulrj05EKV6s+eS2YaqMvWYkUWMsnLrq+vNuxH7bOyUNOY4It9FFfzmLDIfetJYl5XZncqqbDMemtf9lJiB1i/Nln5C8TYyw5EJhdmoPMH6/vfNsYQOmBeJ4ftvz7vyK418DPVLSilj70WrRCoq6aS3lkS84+49wLkjQhNoAAurJRNqv0dag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ogBOQgCXTGfT55qyW4Ib36ARO0SqWO8ycr0DcaWNA4=;
 b=BIS1WwFJySTbeBoDmqFSOYydjabw92tIpifuvPdtXajR9F8GvmCYls0xS3G6PVLzQmYSwPRXpA4arLWGcJaKoIvczQCfJpLaZUCVlfCrA8BVFhykNb45yW2HRctda7siDP1aLu/tCPuop6GSv184O4Srir31dLIg+4w2Ofo8Ng/FCDWrjdrLTnnz14guBEowKTpTFByto3+xzgBid2OO/OIJENHMVYmP11r6YP9Kbzaag9usFaJ7QxVKXaDJxywN0zvBEe8f8nZNdN7GUMfqi5x58ga+6G010lhCvY4pvKrvHRo1QLQCgCOR9VFfcRNSJckbsGya27ub838HnABAqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ogBOQgCXTGfT55qyW4Ib36ARO0SqWO8ycr0DcaWNA4=;
 b=Nh48gC8yrShqsD2leRTZjk8Tx3B9yHnNy1xJJlEySSbbfDXIa1JWGY1P5N5E/s07Rb4xevPhN2FmusbSF5BtpYZcRdberj5WMhKXA/8Y6AGl5skebpeTVpKKE38cwF6e7L6yAx2C/SERf07e4hRQ4aOF6NAvMZtANCO/OtbSP4o=
Received: from MW4PR03CA0232.namprd03.prod.outlook.com (2603:10b6:303:b9::27)
 by IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 20:03:38 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::be) by MW4PR03CA0232.outlook.office365.com
 (2603:10b6:303:b9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Mon, 16 Jan 2023 20:03:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Mon, 16 Jan 2023 20:03:37 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 16 Jan
 2023 14:03:36 -0600
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        John Allen <john.allen@amd.com>
Subject: [PATCH] crypto: ccp - Provide MMIO register naming for documenation
Date:   Mon, 16 Jan 2023 14:03:26 -0600
Message-ID: <f345e88d664a6d6bb112eaae0e1d74d96d2e132b.1673899406.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT052:EE_|IA1PR12MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b146f02-5250-40a6-da2c-08daf7fcc1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pe+a1r9JKNjn7NoMPDFfVuHbTCKYYCnoAMXL4BEPsqd2g1XxWcP5RK9iCyCWFkSRQjEIXj1nkt8+9rP8HO5tVQzEqUFpu10ODIiQNOPIQYxbxA7UVv7LJ5eeXTRxuO6F1tvrhGqjv1jk6bKJb/pvhlCHspqasrlgNe0X06qHEOlv8BSh0KcW1C9SXm9UtqJWSbZ6HcQ/VABRp3QfpommgzSEjSe1K7vFmW3ymYTmPC88bWbxRPJMQOFo1PWoTGkFz/yG7BfDS5FAsBjuv1v8LZwCT6FsuLjUYRteLvKnVc4NqExNjgMPUMRx/WHiTVbyFTA9PZkPj1C2Jvn0GuLQV5aas4lFObZMdWMXyORT0jFHqBFcnbxIxIyYlg0yQ1xba8vaX47Ee4qcgCSdVfPy9MqahrTSlseqGPEzVtlBCW5qV4TFPUQHbyhfEcHM/cmoW4u35DVn9OQtlFPLXL5ULNPM1mIkOpukX338VYsmIhPPeD6hhH+RQ0UL5lECF1vBFZ8cEQA1Fnx9Bp0vEN4dnIkgKJIlrgs2i3dlfAb1LO1MHrAGY9SS9UjIpivB5Il9gXMscXNME8b/PeSPh47I1wGYzR40NJZe/ygEXGEesoL9yJXd554LvNh8351H84MiSA7ROd5wMKAnSWVg5TySK7MVruWoktjAhFiGWVj2lOSn+TijCgiHSrojrlLZ0VBsx9PZGs2KWTW3tJORueiFIn4M6hW7SHQAXepc4OkSwqI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(82310400005)(86362001)(83380400001)(40480700001)(186003)(16526019)(26005)(8676002)(41300700001)(4326008)(70586007)(70206006)(426003)(47076005)(2616005)(316002)(6666004)(7696005)(2906002)(110136005)(54906003)(478600001)(40460700003)(81166007)(356005)(82740400003)(336012)(5660300002)(36860700001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 20:03:37.9794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b146f02-5250-40a6-da2c-08daf7fcc1c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6332
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add comments next to the version data MMIO register values to identify
the register name being used.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 drivers/crypto/ccp/sp-pci.c | 46 ++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index 084d052fddcc..cde33b2ac71b 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -342,52 +342,52 @@ static int __maybe_unused sp_pci_resume(struct device *dev)
 
 #ifdef CONFIG_CRYPTO_DEV_SP_PSP
 static const struct sev_vdata sevv1 = {
-	.cmdresp_reg		= 0x10580,
-	.cmdbuff_addr_lo_reg	= 0x105e0,
-	.cmdbuff_addr_hi_reg	= 0x105e4,
+	.cmdresp_reg		= 0x10580,	/* C2PMSG_32 */
+	.cmdbuff_addr_lo_reg	= 0x105e0,	/* C2PMSG_56 */
+	.cmdbuff_addr_hi_reg	= 0x105e4,	/* C2PMSG_57 */
 };
 
 static const struct sev_vdata sevv2 = {
-	.cmdresp_reg		= 0x10980,
-	.cmdbuff_addr_lo_reg	= 0x109e0,
-	.cmdbuff_addr_hi_reg	= 0x109e4,
+	.cmdresp_reg		= 0x10980,	/* C2PMSG_32 */
+	.cmdbuff_addr_lo_reg	= 0x109e0,	/* C2PMSG_56 */
+	.cmdbuff_addr_hi_reg	= 0x109e4,	/* C2PMSG_57 */
 };
 
 static const struct tee_vdata teev1 = {
-	.cmdresp_reg		= 0x10544,
-	.cmdbuff_addr_lo_reg	= 0x10548,
-	.cmdbuff_addr_hi_reg	= 0x1054c,
-	.ring_wptr_reg          = 0x10550,
-	.ring_rptr_reg          = 0x10554,
+	.cmdresp_reg		= 0x10544,	/* C2PMSG_17 */
+	.cmdbuff_addr_lo_reg	= 0x10548,	/* C2PMSG_18 */
+	.cmdbuff_addr_hi_reg	= 0x1054c,	/* C2PMSG_19 */
+	.ring_wptr_reg          = 0x10550,	/* C2PMSG_20 */
+	.ring_rptr_reg          = 0x10554,	/* C2PMSG_21 */
 };
 
 static const struct psp_vdata pspv1 = {
 	.sev			= &sevv1,
-	.feature_reg		= 0x105fc,
-	.inten_reg		= 0x10610,
-	.intsts_reg		= 0x10614,
+	.feature_reg		= 0x105fc,	/* C2PMSG_63 */
+	.inten_reg		= 0x10610,	/* P2CMSG_INTEN */
+	.intsts_reg		= 0x10614,	/* P2CMSG_INTSTS */
 };
 
 static const struct psp_vdata pspv2 = {
 	.sev			= &sevv2,
-	.feature_reg		= 0x109fc,
-	.inten_reg		= 0x10690,
-	.intsts_reg		= 0x10694,
+	.feature_reg		= 0x109fc,	/* C2PMSG_63 */
+	.inten_reg		= 0x10690,	/* P2CMSG_INTEN */
+	.intsts_reg		= 0x10694,	/* P2CMSG_INTSTS */
 };
 
 static const struct psp_vdata pspv3 = {
 	.tee			= &teev1,
-	.feature_reg		= 0x109fc,
-	.inten_reg		= 0x10690,
-	.intsts_reg		= 0x10694,
+	.feature_reg		= 0x109fc,	/* C2PMSG_63 */
+	.inten_reg		= 0x10690,	/* P2CMSG_INTEN */
+	.intsts_reg		= 0x10694,	/* P2CMSG_INTSTS */
 };
 
 static const struct psp_vdata pspv4 = {
 	.sev			= &sevv2,
 	.tee			= &teev1,
-	.feature_reg		= 0x109fc,
-	.inten_reg		= 0x10690,
-	.intsts_reg		= 0x10694,
+	.feature_reg		= 0x109fc,	/* C2PMSG_63 */
+	.inten_reg		= 0x10690,	/* P2CMSG_INTEN */
+	.intsts_reg		= 0x10694,	/* P2CMSG_INTSTS */
 };
 
 #endif
-- 
2.38.1

