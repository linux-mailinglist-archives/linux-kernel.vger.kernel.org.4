Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53226709E22
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbjESRam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjESR3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:29:50 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20615.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77C710C9;
        Fri, 19 May 2023 10:29:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K26lTHZwOAZK3NxyqzOMyU3b/lclWaFB+kPijXEGT3KfqQhJrVZC0mPde+irfOErWb2liJlaHKLM4tyiFe01OxbrBQPVfRY+TT7hQ9fEFq0r00NgJ4oLGUNoz6Phfd7SJh5uJo2AIRVjz7dF7/EqP2MH0NwG72Fevc7sd4U9K2O9V7DZqNRMFq8d2JRl6AZ95pmMCSTBrmkmviDsMI/3ESL/2Mo2j67KAuGFZmplApw9vhI3+78y9k6axQb8f33XrmXGfQHljrg0jIV4tcAAlHaZH3iIdv3lspJ+zFVqQf4mt5rUV442DnsIOSczeQsF7spibLc9SCl4MjG2qhVh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W82qJd2urM+ggblv7C0vROXQELzMMDGeNbobmssEdeY=;
 b=M7cn/ebLCWn0gtCxn/hzK3by4qcnCk2d9S6lSt71AkqHfNeVxBtizdDvSQZlxVosZf4uYcflfj1dSrcDmSYbVriQsk5l99kiMaDeyJAQzU/5JmC7PjH5BPzJLFQHdQHm29Mr68qZGwljsChtaTMWz93p7Uev6V1dkjBaPLSoV/oAVfsehbPZGVv8t/cTuk8Yg9cuaUdTLkoth+LBQMkk8CtKuTR0xAabUef5ePfEKsY7bci9NXzc1Ukj1jD6o9nMKKWXquzHwYjrqnobpa6Jwnaq1Loq1OE5rcSrBxSJG2zvYRvz7uI+cTVoRZODIvtYuDkzfmyoYi39pfSPx4wH0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W82qJd2urM+ggblv7C0vROXQELzMMDGeNbobmssEdeY=;
 b=tq5SV1Pk5OgREH/RsJ5etNoOkPmDfEB4uDCFMTyqbeC5bXguoG+15pwbIT8YK0eng7hrcV0FHBaDhYkNVxR+CeujyFqGr3FnEGBST8DuKXPJpfMtdeDq64YaiRMFq0QTsqiHh8cVJliKO9CfudPplrsx0YKTMIK7fK1NKVWVm4E=
Received: from DS7PR05CA0016.namprd05.prod.outlook.com (2603:10b6:5:3b9::21)
 by DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.21; Fri, 19 May 2023 17:29:02 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::20) by DS7PR05CA0016.outlook.office365.com
 (2603:10b6:5:3b9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.6 via Frontend
 Transport; Fri, 19 May 2023 17:29:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 17:29:02 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 12:29:01 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     John Allen <john.allen@amd.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 03/10] crypto: ccp: Add bootloader and TEE version offsets
Date:   Thu, 18 May 2023 22:24:41 -0500
Message-ID: <20230519032448.94279-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519032448.94279-1-mario.limonciello@amd.com>
References: <20230519032448.94279-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: 318f5943-bb26-4ca9-08ea-08db588e89e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YMyhXC9xrwAuE5ysFJUw4evH8Xyq5OG+EGin4KJxCQmY6xu3Pr3wfb+2vu/V+5ABv3rm+n6CL1nHrB4bDhP2BzsKnJUrloCzAara8oq/CgRIPqWzPey2KKqaSJ3NrLjuYw+dgp8hH0rO5kftTNYrCIGytvsnY3FY2lG/30ISGOt+tFE5tO7iS5SSZC6vFcHGSykMizngcDx6yLLK1agltSAEYJsQak4Cy5DwM3/jE/WM6pcN/0Uj3CGuTW+5QG1YgpYhPvbP297KH8DQcuFiZJsSz60rW3DOCvpINtCi57Cs4Glb3o+xq7wZw/1gwBo0Ec8aEn1N/0bdPXQrJXGJzYUb6Uk7LY6NQYkAOg3GzeM9MRkdQAY92RFj7VGa2Qp4giiGS9oKmqu++d5AhBOnY8aqd4za3dUUdM7x/BKhp4BqFKZcWvsNomdQRPnGPo7LunYcJQqKzu3eQl/KWtxfMwQzfqKiL27Y2PghYqhG4ZwZiVqQK84GgMwNh4n+B//JKMbm1HHraD5MI5gEHDLAe2lOzmR5oV5W2giXYtT/YoVDe3DXQxrCGqo/qfn/zJGM8czKUfhvNodrgflMAGKrrNBVpKv3QKL2tENv6sA2/YhIfyp4LBYropaxUtqRNdkY1CXP/MZA6AGysBCQoUFkBrM5P4xDVKeqiyjWQPCwk7HW3hh2IdmeR7z5CklfBf6QpQGl2V3+Cl8SvER/h8UQyExT5JePtR/G48FwU7yhxr+F+RMewQBwleu1q26IiAnS+3tYtkExa9cp8Hvv0/N3pQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(36840700001)(40470700004)(46966006)(2906002)(16526019)(86362001)(186003)(70206006)(70586007)(26005)(1076003)(110136005)(36756003)(40480700001)(54906003)(478600001)(40460700003)(6666004)(7696005)(356005)(81166007)(82310400005)(2616005)(47076005)(336012)(41300700001)(426003)(44832011)(36860700001)(5660300002)(83380400001)(8676002)(8936002)(82740400003)(4326008)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 17:29:02.4233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 318f5943-bb26-4ca9-08ea-08db588e89e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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

