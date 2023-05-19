Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90D7709E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjESR2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjESR2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:28:39 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CB118F;
        Fri, 19 May 2023 10:28:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7HWTrc07BPtghTwKVDGIiigES69NXF0jOZUDEpE/tiB5Hj9BoQTsENFCwkN9HiNT1/PAlzM29XDckBDd+XvLxK6amdQaVUEAA6kbQaigUabyNzqAEEfcxKsBsrXVPeyhyHyztri/TDc1J6aIKrKambOdLjm/7u6zdyIYhoH8ucZOhvtnuaymWgMD2XLK5YfBPQM+Q4gNak23moYmgIfevrZxmlFSCOcoHXRltIwXKkInB9QwTa71xujubCw2F6rSn/BmkHyp/WI90BwwjGGziakeTjsI02rZkHtQ/+xLAq4H+lSLvHO5R565ptrXSQLHfiaFK4FVWzZtW97thqbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33zng0V4+/r/isgoeEknAvCd27yu7Ztkc92N4txYOhY=;
 b=lqwouS/Q3CYQYvrHlxm1et2bDy0VfmtU1JJCCSD/f+FpQgYxG3my27QeirXznSskmjhZGrPG0oztxulaieoO5oiOTl2j2NG7vTudN7NdeFT3rmTvRdlJ+TSS++SM7RcUGk2i4kLgUPND3ZJYKDWBfg786sWCWgtPUdxuXOkJkdMj+BkV0jIopKn/tQkFN/Ph4OqXNsK3ZYLNV6Wo4mMi45WO/sdGQ2ksZ6KLTgjPKVTxClHF+f2uFa2b7qp2XxObeLBEMln16JpEYAnm8Ii4ChqhXk14sknJiRbSr6OjXt/AMjDiuzdqwQUx8Fj3TbCDmbh+sAKImn7YCYyWWXw88Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33zng0V4+/r/isgoeEknAvCd27yu7Ztkc92N4txYOhY=;
 b=wuOQ/IAAu345Ukx3OZkaiwEUiOB60KvznXIsVUW7hSyBx4/UmB+B4nslnPHlXrFnvZdoiK6X+JixP74G9tEMzsMxafo4d7Pmg8fUlPyCWM3hkqrlus4kt9TzE0B6ZOgC8UEy9XQtvX74kARwJi3Ia5c8to2w8ZAwXdEsqM2Y7xo=
Received: from DM6PR02CA0153.namprd02.prod.outlook.com (2603:10b6:5:332::20)
 by IA0PR12MB7673.namprd12.prod.outlook.com (2603:10b6:208:435::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 17:28:31 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::1e) by DM6PR02CA0153.outlook.office365.com
 (2603:10b6:5:332::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Fri, 19 May 2023 17:28:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 17:28:31 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 12:28:30 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     John Allen <john.allen@amd.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] crypto: ccp - Add support for PCI device 0x156E
Date:   Thu, 18 May 2023 22:24:14 -0500
Message-ID: <20230519032414.94247-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519032414.94247-1-mario.limonciello@amd.com>
References: <20230519032414.94247-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|IA0PR12MB7673:EE_
X-MS-Office365-Filtering-Correlation-Id: 485d5025-fe55-4fe2-f75a-08db588e7782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vhemVVw31y7/OC+JEDxwbx5D5rCxVtgcoiYPqHu33J9vJc0YH9D5ZVaJMXEOHDWvj7+XJf8ShSEHZyeIHYPIsMTTD5bsE8ZJ/4PQOFAyNOlPXYtzJpL91C1eCEdI0XJxC1lvM6kunZX+pVEtXu9StCqG4byiZZ/HZrCnCSbfHMlKmtS81LFlB5sM94J91yKRjjwIYWlUrVOQ6tB0reXewLPp14RumCuDpBAgJdwPL5hCj0Oi0nqwBF5FqY+sJeahJjCyO4VfsWqIni195/o7AC+Ug29nBznphInxRds8jVzhAPr3OOLIIPr1t0xdSUMcLkNDXKtKEyLpox9fPxEemraGj6aRsFip3GugXSd0bwDrTP3wTjpDzJ3vvFZ9qGegUo9pYeEgpdg6pNnwI2w1yj1jTTL+tN5BEvh+P3U/aAkMRF2eB2Cr+IePe90OsVI0RbLW/XdOvHyAxSQhwIiZ1EWKlxoIAVjJfyf+osZHuJBW6J1QtgGKFGgqf75xlLoDx/obfeNWWB1nDBiwdtATG5ChRl9ZL0jXRjJtyLJkPT4NmIELEODdA7iqW2TJiwhzHyQIcDY9DyVRBrgPZnkel130XZG21yeuGSvJbqNzP4m4TvBsCPZagWErKmySCaTGsFIwlW5/waZ21sSGdSWGt1VHvDsv8zIvVMuLpSlYrF/wtWPxcVRi/JJR+w8aINyKk+NQQffxXtKBdDnA5KbwD4Sxqs/LiW0OPrCuhDbIx01lTJ0JTrCpadxnN9EzbeURaEJIQZYy1p3m8ZV3xWgPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(16526019)(70206006)(70586007)(4326008)(110136005)(54906003)(82740400003)(8676002)(8936002)(40480700001)(478600001)(316002)(6666004)(41300700001)(7696005)(40460700003)(2906002)(86362001)(81166007)(356005)(26005)(44832011)(47076005)(2616005)(1076003)(36860700001)(186003)(426003)(336012)(36756003)(5660300002)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 17:28:31.5948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 485d5025-fe55-4fe2-f75a-08db588e7782
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7673
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Allen <john.allen@amd.com>

Add a new CCP/PSP PCI device ID and new PSP register offsets.

Signed-off-by: John Allen <john.allen@amd.com>
---
 drivers/crypto/ccp/sp-pci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index d0d70af0c4c0..b603ad9b8341 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -420,6 +420,14 @@ static const struct psp_vdata pspv5 = {
 	.intsts_reg		= 0x10514,	/* P2CMSG_INTSTS */
 };
 
+static const struct psp_vdata pspv6 = {
+	.sev                    = &sevv2,
+	.tee                    = &teev2,
+	.feature_reg            = 0x109fc,	/* C2PMSG_63 */
+	.inten_reg              = 0x10510,	/* P2CMSG_INTEN */
+	.intsts_reg             = 0x10514,	/* P2CMSG_INTSTS */
+};
+
 #endif
 
 static const struct sp_dev_vdata dev_vdata[] = {
@@ -478,6 +486,12 @@ static const struct sp_dev_vdata dev_vdata[] = {
 		.bar = 2,
 #ifdef CONFIG_CRYPTO_DEV_SP_PSP
 		.psp_vdata = &pspv5,
+#endif
+	},
+	{	/* 8 */
+		.bar = 2,
+#ifdef CONFIG_CRYPTO_DEV_SP_PSP
+		.psp_vdata = &pspv6,
 #endif
 	},
 };
@@ -491,6 +505,7 @@ static const struct pci_device_id sp_pci_table[] = {
 	{ PCI_VDEVICE(AMD, 0x15C7), (kernel_ulong_t)&dev_vdata[6] },
 	{ PCI_VDEVICE(AMD, 0x1649), (kernel_ulong_t)&dev_vdata[6] },
 	{ PCI_VDEVICE(AMD, 0x17E0), (kernel_ulong_t)&dev_vdata[7] },
+	{ PCI_VDEVICE(AMD, 0x156E), (kernel_ulong_t)&dev_vdata[8] },
 	/* Last entry must be zero */
 	{ 0, }
 };
-- 
2.34.1

