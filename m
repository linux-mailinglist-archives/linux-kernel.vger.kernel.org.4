Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F016273BE67
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjFWSbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjFWSbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:31:43 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2BE2705;
        Fri, 23 Jun 2023 11:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhrmSNMpSqOUn5labc0fDi27WPcQf/ywEfo3oprGOJKkrvky+Q3GLSIiy+ooU2DSBQjtxhlBrTGJFUOGZfEfkFncCaL++yUyLN8DEEOqLcIu/c1EWB0DmOpw9SMRl35kUEGnh6uCwGB1hu9X4O7U/c2DXxWfoZj4uqb5PvyBaPuj5MZc1YodLI4fx9aN6sFXY9ub8FF2mE2JZSVnugH26YGRxuXvOGG4T1lL8/xhPnTFNItxBJBMOB+2EQDPEvHkQb2K7mXEpcY/QnA8gEiZby+tXUYXnQHwYA5zEsyRkZH2AyiMbFBjJUqioLsx4IzQeakvqzbYcpqGxsmRnHLUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5S28VEecabCIVQuw9urlYWg3WqJCyLbOGbQs21YvZ8=;
 b=JhynO+elt7uswoTZLxRMzfj/T3EyiSpHifk1xpRmkgTPvp0IVdAnsXH74GO+MtbtGv4grOq6dhuRdK22SmaBrombcXyj98GYxyEemSnVXjCfrc1ZSDB/ZBbsVRDKETjzY+CxJgwiaLPn47CNxXKxPGTrUNoy2w3N/kyPXhf92Hu7Of2V3sdtqFEdouB60JntoKDiIkAXy++4dzujcS30gy9JE2Tj32eCZjkh2mA92bc5bJshQ7KxKkANLkUAVsA0mYsK3KMV8AQvTSB0qLdtaRpOyOOGVjfMYDXNfe91989h09+cEKgkILpis0lm2KEbwuAniy4rP+HL/fwChKQnFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5S28VEecabCIVQuw9urlYWg3WqJCyLbOGbQs21YvZ8=;
 b=pt8GxRnMxVsnIC5WJPL5JZph7yz6ASxmZX6ctV7pMnKZo5KzzlEtqKy3MQyEoA2gn8b05/Jmg5AqqqF4O8uv06i11eGzZx5QRQBmCmh7p8OMTUj9YVE3JmsKQUafArHtRctoqj/87Jzp53Oo6kQgAEOFVSBUFt4LloZ3iQWd7sw=
Received: from BL1P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::31)
 by PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 18:31:36 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::50) by BL1P221CA0024.outlook.office365.com
 (2603:10b6:208:2c5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Fri, 23 Jun 2023 18:31:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Fri, 23 Jun 2023 18:31:36 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 13:31:33 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 03/11] crypto: ccp: Add bootloader and TEE version offsets
Date:   Fri, 23 Jun 2023 08:49:53 -0500
Message-ID: <20230623135001.18672-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623135001.18672-1-mario.limonciello@amd.com>
References: <20230623135001.18672-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|PH7PR12MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: 520063cf-0e8e-45ba-bc2c-08db741813d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L+KMAOb1k30MVFDXcgEcB+gV60IOJxCQbIJS8qIszDR8oaXyVbhYni6t4HJ9pZRCfVGJ/bcszv/q4xSqVtk/P19PxgTsMC1UvTT4oYT+OHwXV7arFGMKcugn8SlEqTT25DtuBVVovX2mvaxnxvLClqB3HrgFD26ere5L2V5vkNNQKB7AWhHvB2/twuGbg+8CuFhEOBXoYGo/FCcXnW6vF0SxdMqm5+JmY2ud754Oi5Ye2TuMpTeVQ7ZdaTtx1lr/ymtdoABuL9DfBPLY+rLu46jwd+zgnB7JpQVx5FGVUymir78YDsjdbKs0RcSREo7IBeluEMV0vuJoilZH/vx4cDj999nv7x2by8Qor8qJt9q/GqClzKqUa8NjyRP/X81eIY//SDaXK0U5HDvvxU5/HhfqEJfEXXn2vazwG0k9t8D6mkP+Y+nYoopq6wazCe00a9OgCEs/1wyPEOeSBR+2yjY45IK1OYxaqYdw1cP2DdteW/XLqnN2gBAFj61qRA5QCKO9xGIZHPrPTfX45VZDDnFf1QF8HYWPQPIXTQU1xt7UYiBKnx8XLE+nq6azK86pCXrWiCx1vSKJNeyAY6SqyIsJqH+VJeIDWqGxVxjD+QwC3XocjloDv8lL4Ej7wCefd9Nyw+lb+fHGT5S8PK5lKYXpqc1sOT23LJV21kn/LZzoRjNlXXHMyqAtChbOuanb07gbXmjl0uJsLCQrPtWWzuns1WWFqM/vChBPYKeWcyKPE/KSB8RRswsmz9e7wPKPP9d9WT78HA+laJn2iiCrHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(16526019)(6666004)(7696005)(82310400005)(83380400001)(186003)(81166007)(356005)(40480700001)(1076003)(336012)(426003)(47076005)(40460700003)(36860700001)(2616005)(36756003)(316002)(4326008)(70206006)(70586007)(2906002)(8936002)(8676002)(26005)(44832011)(86362001)(41300700001)(5660300002)(54906003)(82740400003)(110136005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 18:31:36.3400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 520063cf-0e8e-45ba-bc2c-08db741813d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bootloader and TEE versions are stored in registers that can be
accessed from sysfs.  This exports the information for recent client
and datacenter parts.

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Pick up tag
---
 drivers/crypto/ccp/sp-pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index 6c93577950c7b..205b93d229a95 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -423,6 +423,7 @@ static const struct tee_vdata teev1 = {
 	.cmdbuff_addr_hi_reg	= 0x1054c,	/* C2PMSG_19 */
 	.ring_wptr_reg          = 0x10550,	/* C2PMSG_20 */
 	.ring_rptr_reg          = 0x10554,	/* C2PMSG_21 */
+	.info_reg		= 0x109e8,	/* C2PMSG_58 */
 };
 
 static const struct tee_vdata teev2 = {
@@ -448,6 +449,7 @@ static const struct platform_access_vdata pa_v2 = {
 
 static const struct psp_vdata pspv1 = {
 	.sev			= &sevv1,
+	.bootloader_info_reg	= 0x105ec,	/* C2PMSG_59 */
 	.feature_reg		= 0x105fc,	/* C2PMSG_63 */
 	.inten_reg		= 0x10610,	/* P2CMSG_INTEN */
 	.intsts_reg		= 0x10614,	/* P2CMSG_INTSTS */
@@ -455,6 +457,7 @@ static const struct psp_vdata pspv1 = {
 
 static const struct psp_vdata pspv2 = {
 	.sev			= &sevv2,
+	.bootloader_info_reg	= 0x109ec,	/* C2PMSG_59 */
 	.feature_reg		= 0x109fc,	/* C2PMSG_63 */
 	.inten_reg		= 0x10690,	/* P2CMSG_INTEN */
 	.intsts_reg		= 0x10694,	/* P2CMSG_INTSTS */
@@ -463,6 +466,7 @@ static const struct psp_vdata pspv2 = {
 static const struct psp_vdata pspv3 = {
 	.tee			= &teev1,
 	.platform_access	= &pa_v1,
+	.bootloader_info_reg	= 0x109ec,	/* C2PMSG_59 */
 	.feature_reg		= 0x109fc,	/* C2PMSG_63 */
 	.inten_reg		= 0x10690,	/* P2CMSG_INTEN */
 	.intsts_reg		= 0x10694,	/* P2CMSG_INTSTS */
@@ -471,6 +475,7 @@ static const struct psp_vdata pspv3 = {
 static const struct psp_vdata pspv4 = {
 	.sev			= &sevv2,
 	.tee			= &teev1,
+	.bootloader_info_reg	= 0x109ec,	/* C2PMSG_59 */
 	.feature_reg		= 0x109fc,	/* C2PMSG_63 */
 	.inten_reg		= 0x10690,	/* P2CMSG_INTEN */
 	.intsts_reg		= 0x10694,	/* P2CMSG_INTSTS */
-- 
2.34.1

