Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99F66F1E47
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 20:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346548AbjD1S4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 14:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346449AbjD1S4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:56:07 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13571704;
        Fri, 28 Apr 2023 11:56:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKNb2EbQUbqQgBhO9V8miHvlYz57UvIA+rmTb5B43ZatPQpX/PkSbXGfAuPb9MXKmKUvgoef4WpD5rxiMK7KWHv/6pjtVE+c22OK2Y2wAXnfcN2etfSKWzwQI3QgEt2Ydp0MPdWSLs+jPC6jTtXMvf6bXjy1ZQpbIta2779SbvOJ0P/J5FmkCXRcuzlpZRGkOqiBopUbj06tsREZMvQGsOlhKHhhTPSFZpMWwaCIXN5tEn9Y6glRdwOb7FW1PIRMfjQzy5MjKoSBdb3q1jC60EO+/7fWC5QtFWWihtV3Gvgk71KHqifbkL+B+pzuw3GEIpZHjWQP+NmC72XsFl8Nug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnAt8LX0A5dwt3U/7IhmLsAoxaT9jZuB0k+oCYO3hFg=;
 b=Z6DSlbn8n33+0jpHfAjaqZFkqFMtzNTULdmtO7+aHLZTeJ+wtKwNCWgeBkvZKBPTZzuKWVepwHqgVIBb3hX6++MxyOSv9JjRS221Yl3sVZKVC7Vnasl8mkTrj/gGk9AI+Zspd2MEQ3JmFq8ivfgAgp23BgR46f1lVM5dZcYGnSIJ3CxWABdpfZDmY7gmSKycbFkQImlFWh0CZRyHl2XZ8U4em+2HwhphWGfBxgGntuS8AOEXWi+M76/oBPqxQ5i3CLAjSTf6LwcwkaSW3IR+67fUSZS1WiK/wMSLzVHJ2Ie/kvnXQzYvyAOav0ECGY/3SeyvK9/cKMx0FUsLQeMS7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnAt8LX0A5dwt3U/7IhmLsAoxaT9jZuB0k+oCYO3hFg=;
 b=QlTo7dc2eWpApbFlqDmn5uMafaANLNN20PFHemkEdgtbhOLBALsnREX6ouX0tWVMh3t/x3FP5km+ePnufTBU7IrspzkigdpLdwmm3ATa1WWk2tqTh7oQAtNhtBjPLosiJFZLUfJslvNYofnn/KYcs913a2jhCdTwMUVgkg4sprw=
Received: from DS7PR07CA0005.namprd07.prod.outlook.com (2603:10b6:5:3af::15)
 by MN0PR12MB6152.namprd12.prod.outlook.com (2603:10b6:208:3c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Fri, 28 Apr
 2023 18:56:03 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::9a) by DS7PR07CA0005.outlook.office365.com
 (2603:10b6:5:3af::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24 via Frontend
 Transport; Fri, 28 Apr 2023 18:56:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.25 via Frontend Transport; Fri, 28 Apr 2023 18:56:03 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 28 Apr
 2023 13:56:01 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>
CC:     David S Miller <davem@davemloft.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 03/10] crypto: ccp: Add bootloader and TEE version offsets
Date:   Fri, 28 Apr 2023 13:55:33 -0500
Message-ID: <20230428185543.8381-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230428185543.8381-1-mario.limonciello@amd.com>
References: <20230428185543.8381-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT050:EE_|MN0PR12MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a767bf6-c1b6-4dbf-f825-08db481a3719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpVc9YFA2+0OoD8lIKcsKankisjF3OOl7/yRJN/LOhby/GN/J2paqk5f40zS74d4t/ZQEVhEPuK7Rq0S+lcYB5Jb0l2A33/kihFnSLtm43a7MRwLJMWLhTTD5woBH6lytUnAf6KyqLu8U/uhNwPo7+DSkNhiLdMVGzYFMDdt2ZEkLg8TEZSQ6bLANAvrEFJ3NDKv7V5m7a1prIH0ISSAEcK57DhK32PaCQONXaj4AdZLFnRIyuyq3kHeWRgAd/VqJgbccOTfB+CVDpJFUTMiz6OiaeBNYbRNfVZzf+MXeNq8p2y11j7YYwLuB22ZaQiYWHrTEukzNC2/MO8JZg2TsafFloClfrqUZVgsjq77TPYQ3Fzkkh0onIaMX20FiabApWUPKlFgs7QtwuoFNj3uzctlpGVYgIyNniJNSYQIRObBf6yac17p+Lg0OnQUB1T0EqQinY2INrnGSGCWbb4vmI+s14zXlO62XpTv0u85Lv1YaPlF3kBe7Far2uDkGADS2otg4zB2jC7HMJ5I6qyQpXAu0st7aIPt9FzDMqNz8iMzHhF/KkIRy1rOXtEWla2NpbPK9aNpMS9fJxfWQ4VLvJgeRub+Dm4Xko8c0Ud6a5U2jP16LbmZP5PbmP6DPAydYE93a7p6QqfWxs2dYjIvO2YZpQJlb6aGMa3hJ+v9ceioa5JmA1/VjFIyK98EayhZGEO2RHIFimPcE+EatYjj5PpFEL/KKd47xL9NvzSWFc4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(41300700001)(40480700001)(4326008)(82740400003)(356005)(81166007)(6636002)(2906002)(8676002)(40460700003)(36756003)(44832011)(8936002)(5660300002)(316002)(54906003)(70206006)(86362001)(70586007)(478600001)(110136005)(7696005)(336012)(47076005)(26005)(1076003)(6666004)(83380400001)(2616005)(186003)(16526019)(426003)(36860700001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 18:56:03.3074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a767bf6-c1b6-4dbf-f825-08db481a3719
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6152
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

The bootloader and TEE versions are stored in registers that can be
accessed from sysfs.  This exports the information for recent client
and datacenter parts.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/crypto/ccp/sp-pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index 7ef7c09b4a2f..46dd7a2ade18 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -423,6 +423,7 @@ static const struct tee_vdata teev1 = {
 	.cmdbuff_addr_hi_reg	= 0x1054c,	/* C2PMSG_19 */
 	.ring_wptr_reg          = 0x10550,	/* C2PMSG_20 */
 	.ring_rptr_reg          = 0x10554,	/* C2PMSG_21 */
+	.info_reg		= 0x109e8,	/* C2PMSG_58 */
 };
 
 static const struct platform_access_vdata pa_v1 = {
@@ -435,6 +436,7 @@ static const struct platform_access_vdata pa_v1 = {
 
 static const struct psp_vdata pspv1 = {
 	.sev			= &sevv1,
+	.bootloader_info_reg	= 0x105ec,	/* C2PMSG_59 */
 	.feature_reg		= 0x105fc,	/* C2PMSG_63 */
 	.inten_reg		= 0x10610,	/* P2CMSG_INTEN */
 	.intsts_reg		= 0x10614,	/* P2CMSG_INTSTS */
@@ -442,6 +444,7 @@ static const struct psp_vdata pspv1 = {
 
 static const struct psp_vdata pspv2 = {
 	.sev			= &sevv2,
+	.bootloader_info_reg	= 0x109ec,	/* C2PMSG_59 */
 	.feature_reg		= 0x109fc,	/* C2PMSG_63 */
 	.inten_reg		= 0x10690,	/* P2CMSG_INTEN */
 	.intsts_reg		= 0x10694,	/* P2CMSG_INTSTS */
@@ -450,6 +453,7 @@ static const struct psp_vdata pspv2 = {
 static const struct psp_vdata pspv3 = {
 	.tee			= &teev1,
 	.platform_access	= &pa_v1,
+	.bootloader_info_reg	= 0x109ec,	/* C2PMSG_59 */
 	.feature_reg		= 0x109fc,	/* C2PMSG_63 */
 	.inten_reg		= 0x10690,	/* P2CMSG_INTEN */
 	.intsts_reg		= 0x10694,	/* P2CMSG_INTSTS */
@@ -458,6 +462,7 @@ static const struct psp_vdata pspv3 = {
 static const struct psp_vdata pspv4 = {
 	.sev			= &sevv2,
 	.tee			= &teev1,
+	.bootloader_info_reg	= 0x109ec,	/* C2PMSG_59 */
 	.feature_reg		= 0x109fc,	/* C2PMSG_63 */
 	.inten_reg		= 0x10690,	/* P2CMSG_INTEN */
 	.intsts_reg		= 0x10694,	/* P2CMSG_INTSTS */
-- 
2.34.1

