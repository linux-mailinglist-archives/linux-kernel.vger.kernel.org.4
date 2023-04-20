Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309676E9992
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbjDTQcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbjDTQcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:32:09 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B667B10F1;
        Thu, 20 Apr 2023 09:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCWw4LmYEwkJsX3iI2d7HjXLCJvlOq20hCdQ7isZwTyzHHTfrVaWWKztBjFLDZwkcg3x/ft1wPSdVAWRPJ1285kVTpw166EypGQGZyq4EvdvmK/mCbrLEUugon6EsnqWLJsl/DU2JpPiWzyGzo+Zrd/MkgmgSqgekmEG/L3HN23k3WUVLRAYYsG0llbybb82gCfWLxOIQYClrrXad+0AwEmsu4SkWS1bTRxHEz4+cRqfd104xq4Ba4hjtg6vTBiVTgOagZPuJ5An5oWWcmCKvtxV3V7sCtgdlw64juBYGVbNjWSv6zfZVq3sWNmu30mFk4mWRCKAfpUcgyOX5I+tsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U13fFXEM07lJGuyTMo7PvjJrJ/WZmstRJ6eJu+3aEtM=;
 b=FgCKTHbWGKZGhS8FmYH/J6mzs9x08hzI1RoNGPc/PNsIvE1I5hHwLQlSBMitjBXm7x3o5VfLcbmIVyGQ+lWwRbdttE6PoZGsfMvpG4EGFR0u1XGTFznZIqmdd1gvaWXyGQFLMYdLpMbq+esV1pnUwO5a5mZn2h44qsnFRaH4zXtsR2J1Ms4FZNVLZQAaCATB1QRZLGE0sLh9lsoSpW4oCu/6KzfoyypwXgOPcYxdOoM6OJFQqGvZnm3NO77QyzGD5NDjDZB1eEutf5BJYnzYRjgNguo0Isl9QtzM6OgkHpcD2bOmzyliglPdp/odekV8/W3GHh0OZ53T088LA9d/OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U13fFXEM07lJGuyTMo7PvjJrJ/WZmstRJ6eJu+3aEtM=;
 b=PIYhXMxUBfwsKa8vT5tEzrX0bRHT3AC82jPLxNuL4MB2f4u2OaV26xNBSt/6FlFGizuPPyDO10ULmYsyKJsenQ3R9Asj21vl1ExxkxQcc/cP/gKoAWeu3R0qZXp5RoXm2H58pt5IftvgTCzwklGkok97c8dpUWO57W01aUggFEw=
Received: from DS7PR03CA0352.namprd03.prod.outlook.com (2603:10b6:8:55::32) by
 MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 16:32:04 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::c2) by DS7PR03CA0352.outlook.office365.com
 (2603:10b6:8:55::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Thu, 20 Apr 2023 16:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.25 via Frontend Transport; Thu, 20 Apr 2023 16:32:04 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 11:32:00 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>
CC:     "David S . Miller" <davem@davemloft.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/10] crypto: ccp: Add bootloader and TEE version offsets
Date:   Thu, 20 Apr 2023 11:31:31 -0500
Message-ID: <20230420163140.14940-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230420163140.14940-1-mario.limonciello@amd.com>
References: <20230420163140.14940-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT113:EE_|MN2PR12MB4317:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eeceb28-acab-4aea-0a90-08db41bcc694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A1b2SOhOFPhiWaPPTqnkhZFM+b20jh8kyTRWr1erXbwEBHHsc4nYDoizSRUmxz1KeWgqVISyo9s9T2BnlZ/1B1Hd5yLn9nG4DihWYzVy4AGcr2bb3qIfFRnQdKncHBUvfOcGasFOGSuWRmAWOpIAO354G/8ww7X+YGIsa17kWHi1jupBJGL5/DNpTxpCT4Xe1VmQuzMwZOtAEt6I8e7ofilKaABqD0no4J3BAFMbpvyiAyTbGWiJfc/Mk2Pff73uCUlZ0917J+JHzbdVAqdCqih8Xy+hR2zE+zJl+0i2q/E4kBv/Wd5SFnVczyEMfhy8Gza5FdgLzWGSXBQoW+MY6llMLVkoJAfo2n4Dym5hk8a2Fz0CbPqjej3qgwk8Kb42dPbpKe31nr9iA0dABMjNKbeDIstb76Euh/d4PVd/c8QFSxzy63qcBymfh4aQIV5Ho41JnEm3jCorv6TvCLnmP99Sj/0liP34c393ZuFNDfqMwEKRFhIpmAPaVk0TwBjr/fhZQLTctcezwsWqNVkWv0B1522atnDmiU/FOyc+r9KYAgzT/n6bPifmE/JB7s1LxgcGRXYApoqZ1uG/bYkBB+KEhJvZvYhN+jIaKJgsEbgQ1jyAhikowDVF+TrW9Ir11LMYTq1VwhCKpvtKx8mHWdNx0fyzT/uYMEDug+2tVP3fstyzuowVE9H2RBB5Zsv1rgBQwSfar9W47hytxFLuY8ejS1KTbEnIFkv1O/qOP88=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(86362001)(186003)(16526019)(426003)(336012)(41300700001)(81166007)(356005)(1076003)(82740400003)(316002)(40480700001)(4326008)(26005)(6666004)(7696005)(83380400001)(47076005)(82310400005)(36860700001)(2616005)(478600001)(36756003)(40460700003)(110136005)(8676002)(8936002)(5660300002)(70586007)(70206006)(2906002)(6636002)(54906003)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 16:32:04.3523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eeceb28-acab-4aea-0a90-08db41bcc694
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/crypto/ccp/sp-pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index 4d729aa1b260..460f3ee12fb6 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -417,6 +417,7 @@ static const struct tee_vdata teev1 = {
 	.cmdbuff_addr_hi_reg	= 0x1054c,	/* C2PMSG_19 */
 	.ring_wptr_reg          = 0x10550,	/* C2PMSG_20 */
 	.ring_rptr_reg          = 0x10554,	/* C2PMSG_21 */
+	.info_reg		= 0x109e8,	/* C2PMSG_58 */
 };
 
 static const struct platform_access_vdata pa_v1 = {
@@ -429,6 +430,7 @@ static const struct platform_access_vdata pa_v1 = {
 
 static const struct psp_vdata pspv1 = {
 	.sev			= &sevv1,
+	.bootloader_info_reg	= 0x105ec,	/* C2PMSG_59 */
 	.feature_reg		= 0x105fc,	/* C2PMSG_63 */
 	.inten_reg		= 0x10610,	/* P2CMSG_INTEN */
 	.intsts_reg		= 0x10614,	/* P2CMSG_INTSTS */
@@ -436,6 +438,7 @@ static const struct psp_vdata pspv1 = {
 
 static const struct psp_vdata pspv2 = {
 	.sev			= &sevv2,
+	.bootloader_info_reg	= 0x109ec,	/* C2PMSG_59 */
 	.feature_reg		= 0x109fc,	/* C2PMSG_63 */
 	.inten_reg		= 0x10690,	/* P2CMSG_INTEN */
 	.intsts_reg		= 0x10694,	/* P2CMSG_INTSTS */
@@ -444,6 +447,7 @@ static const struct psp_vdata pspv2 = {
 static const struct psp_vdata pspv3 = {
 	.tee			= &teev1,
 	.platform_access	= &pa_v1,
+	.bootloader_info_reg	= 0x109ec,	/* C2PMSG_59 */
 	.feature_reg		= 0x109fc,	/* C2PMSG_63 */
 	.inten_reg		= 0x10690,	/* P2CMSG_INTEN */
 	.intsts_reg		= 0x10694,	/* P2CMSG_INTSTS */
@@ -452,6 +456,7 @@ static const struct psp_vdata pspv3 = {
 static const struct psp_vdata pspv4 = {
 	.sev			= &sevv2,
 	.tee			= &teev1,
+	.bootloader_info_reg	= 0x109ec,	/* C2PMSG_59 */
 	.feature_reg		= 0x109fc,	/* C2PMSG_63 */
 	.inten_reg		= 0x10690,	/* P2CMSG_INTEN */
 	.intsts_reg		= 0x10694,	/* P2CMSG_INTSTS */
-- 
2.34.1

