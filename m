Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A467287CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbjFHTMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbjFHTMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:12:51 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF02130D3;
        Thu,  8 Jun 2023 12:12:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9zhdhZysRsyb2heTxjt9fJ8MXQcuCA03FGbgSmI0AncrjZ2g9YgcyvAW1jokbZcvEoCZrzobR5U720ZD6e1GEU66oMuKpY8UZyjweCGuIRB+EUuqY/smexgbVUtqJ/W6oPk1Aw1GpxwqotpERYrAFs6pUJQR10xzFqBeeFLuRDVgj7jTCOovLU5v1RUSfcV7deyQvMqrZOUExY6FBH2N5zncArcWO00pbrh2JaT3PPcrfaGuT2Ja7MYwtxVOxa+s+vOyVrV06Pws/5zlKzzapZdg4Dr99ugoaD6ycjaAyoms2VjKeNGwrdmQ6K+xxFDzkCABN8gpfjRxe6PEmhO9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W82qJd2urM+ggblv7C0vROXQELzMMDGeNbobmssEdeY=;
 b=Otz+ZRM/Jc7R+Ek7cDlVGNUtJ42/Ne9MslrHiYB+QfJoxJ2WG6mcMQNXUdZmdeqalijTKETRfA+KWxJPJDj12PlF4f5zHiCb7hciARd6lINIq5gp5eK2CUHyCcsYTji2rrfW3J7AtdYZRsAcACYwEnOGkh23rIgpdJ336Ha2vRIN35MclnUyXq2NuMS7LB+8KE0yw4eyhgRovLLSBz1hTGOrbx4kM7Fufx0SVkf39uwSoB7/3zrdXxaGbd8nAZz6NxlAiSf1axJ5oH3vYa02waou/7u9PLjkkzUbf4E3mxlfl5G5Nuu8p56fueyqAC8YEjh4WcjO6ARLZwlSnfMXKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W82qJd2urM+ggblv7C0vROXQELzMMDGeNbobmssEdeY=;
 b=iBaNpZCvMlE2lTehyTC7WfL8kTwIAm9hWjPR10WlrQbYiaOAsFE6kL+ZQX+QbSaDXC6BLT3BT4/tIkg5tjYkeB6TF4TNt3ZdjJxST58/hoPzR/NcZ/BuHvk0q1E5cTb2wyXSGPvo+OVoJSOiCfQWXU4LTqI4kWRfeEGtr7J09iU=
Received: from MW4PR04CA0260.namprd04.prod.outlook.com (2603:10b6:303:88::25)
 by CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Thu, 8 Jun
 2023 19:12:30 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:88:cafe::b) by MW4PR04CA0260.outlook.office365.com
 (2603:10b6:303:88::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.26 via Frontend
 Transport; Thu, 8 Jun 2023 19:12:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.0 via Frontend Transport; Thu, 8 Jun 2023 19:12:30 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 14:12:26 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 03/11] crypto: ccp: Add bootloader and TEE version offsets
Date:   Thu, 8 Jun 2023 06:17:49 -0500
Message-ID: <20230608111757.32054-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608111757.32054-1-mario.limonciello@amd.com>
References: <20230608111757.32054-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|CY5PR12MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a3810e-cd98-4785-6328-08db68544e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6am2KK8bTgrhtLPDrtwXp2NO+98vFc46p0K6ZvAdl65DDFr/rOlAC+p47Tot3E8LbzpB6ws85v6xeGI4RV49x7BkOfGR/2cWrDtJtIqmf9jDcedKf1jw6DBtcZyZIfj3TRzhHiMZMo/mzgTBemRPZYt1hLW8FxvQ2oRlxy9QlFMPe8k/vpivlFYbZiWpdqZ7Zp3uo8vY0hPZvqSmLYmZbe/ottbVCO2rzmXNCh9TuOPLjwfLNuEmz+rM5J4waxwbdJPEhWXhWodsh4/DBqeFhf9GyRQ8s26sznji/osTdj/4IQhci3Tzb22utguZwTxibirsE7cRV3AEwPhNL6wy9SVbQQ+pg4aE0J68ac8CWy/a8afiiYlTbDaHGQNgJJxWKCYcUr0EB1xziKv+6TjGOIkRP8uhbAxP9vappZ60sPR8LXnDBBfHtCCVrbO2LagGllSB8QqmXGKRF+ziFaD9dNDk9rZEHED8Gi0IDpN0SwNIIHQ9vU+eOtYJEjqh4aAKCQa7yxDvkhindv8zlWtNH1JyBufiI6a9AdIiFTXmczrWvGDxk4y/UKeqhA4cReLMj1MmlehupOVQ6gP9rFb5/gxJHzDgfKKQYAWl453MeVZaW5/B5ChBMcvM7LYgImdHVVlwJMeoEwONjrbI+JjYpRp5gSXEfuAwdPSgreZcN/exZQ4Mk1klDWYeZUzjuFg/O80kjtFyuSwjEvrYPzRZLZ3B/kZ5wYV5CtBbmwhqZIQJKYtEPZyZVfuVHrx027wr5AHPg8Bs532VcOWCEz+7mA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(478600001)(82740400003)(81166007)(4326008)(356005)(70586007)(70206006)(36756003)(110136005)(54906003)(8936002)(8676002)(44832011)(86362001)(5660300002)(2906002)(41300700001)(316002)(40480700001)(40460700003)(83380400001)(2616005)(336012)(47076005)(426003)(1076003)(26005)(16526019)(186003)(7696005)(6666004)(36860700001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 19:12:30.4508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a3810e-cd98-4785-6328-08db68544e75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6084
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index 6c93577950c7..205b93d229a9 100644
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

