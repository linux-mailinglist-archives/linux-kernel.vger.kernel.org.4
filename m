Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D62709E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjESR2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjESR2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:28:36 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7732C110;
        Fri, 19 May 2023 10:28:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwboxHf4y2AlvwJs6efXpgPrSEO0HblcElOl/B9x6hhGGOgjAFot5Z1Xcne0TlFLbp+oINc90rCn6f6SeB41N3xlXYyTXiJu1cyMwCLHpNUO4REEyQDjDV+GnKFQWa41iSSAEKv3k0ezfNOZ463kvfNLjucmuXTVlGaxgEq4JGKuzPXPQIoVcH6IzodEGZKQtsOxY65Tkbsze/9D5lWKvoatfuIWRFLsRbsFFbaNfow/F39IuF7RBr6DXTMbfCsRSez7B/X5ow/BBJ8uX48CUUatGa1yYA2uqroyJEsCTSJE0Tug5Fw12eOGIb7AKMeC9KFotatdKiWEtz7n70E+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qm5sJ8gAzIBeTYjQxKniEt/dido43KVBJOfMwpxCchk=;
 b=S7RJE+gs1zCJQOcCBmflbGshZM3bsRHV8wlpavdGk4SI6MRdlm4VcLT54nExM3sUsqV/xi/O19WAD/7stR1Fy187ld3NLQFH79A4eFkSKU8yDTTg1wmciOWfPgj9JFB1JXDxvtWLF8SJT3GZuVD36C+SpFkNrGvaFjg+lpEeeLjs52TdWSP3iViAQ9bcIDl/9Ia6UQYpx8TezqkKiO0AdRDBGhPP8wpWxV6jd2kRbG5cZ8jW6/sgVsHEoYVX4RDcJXTJrbPYiN1b/DFpsAFKpyIHsOk8Dl32mjHYTDugvukLRLRSsKi1Ltk9/2oXQiVnfYG3cGJv6hzCTFoL6ZBCpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qm5sJ8gAzIBeTYjQxKniEt/dido43KVBJOfMwpxCchk=;
 b=eKjliyg3S7cydheijgDU4neZgzFIQa/EYf+aoI8xy3VGWRUs9xV6PEX7CNsCzWm+rOYjjfJtbHXfwZiK4Z9JPK5eULOUH4wvxdlgqEMN6aWwpdGendv2ASJ74ysrBISt6wucKdgDWLDZA0A1dklnjTzjJ/VvG/me7U0GB3uFjWw=
Received: from DM6PR02CA0163.namprd02.prod.outlook.com (2603:10b6:5:332::30)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 17:28:31 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::3e) by DM6PR02CA0163.outlook.office365.com
 (2603:10b6:5:332::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 17:28:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 17:28:30 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 12:28:29 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     John Allen <john.allen@amd.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/3] crypto: ccp - Add support for PCI device 0x17E0
Date:   Thu, 18 May 2023 22:24:13 -0500
Message-ID: <20230519032414.94247-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d2113a-8ee5-4af1-3af5-08db588e7702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gFkYh3j/dnsDP0AUxYoouSveqenSUvm4hkM+Z5TTfdfGmDsgnVEQhHds43zZA+Nu1BTNY8M7qYiKqoH3HMgstY6CsYoybPoTHRn7huFRT/ogrgf0ALljXuyJj0DbAU7+JL9wfvMVJ3CfB6BG5nOw66tTzi89KpUl7paXC5tqbIc8aPn/2bBRzoG4dHSrGrdvCSS3vzyOKvUxVwZ971cdPQI1Ee7sd2few4qZ8n6+1y2GGJfwEO0yM8hsD+fC5NoMGllWPMU4q9LkpBEUsNx6Nd/58KO6GD0RMM/bWUtriZKujRdJhOTJ4QGs18KvdLVzYHH6aZ7wotjsbH0IuRUM96DMCdxhcwEJb3mJBUH0mToQjAjaWFgyYfVomhDzf7iHMGp4qmIIN9IS4D3yzPCgxew/6+LIXLcxLGbtliHcWvLxRv4ORr1O9GlBqYGr0HtkGBwY10TT6rZHtUEJISK2cHYvWNTErL3mPUyU+d1+9NOhN3dLzxsZmYVlBxdHMZkfuSvi5EVLHzmyFJGljynRAXurnVzQtiotubT/IEJXKhKYmDoRY3iI/aEkylI/1J7yPCsDBxMDv8S9iWjYrupNy1JQtq4yLC0iVddQjCMLZrZA/ZBcFhW1aOK6qVXP30SqdcftgsRD5lEMhuevR1o+6VhIENUW6biLpgemgjU1C+QwR6f22tNnY+sj3jt+3zUDgLlQ3PS+bP7e1sdLbcItt8VniR+lLSK70OrWaW8H+Cd7IIZ7w/QCBC+H1cQdEM7R7Of43JTPgNxQPAQ1MgIabA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(16526019)(70206006)(70586007)(4326008)(110136005)(54906003)(82740400003)(8676002)(8936002)(40480700001)(478600001)(316002)(6666004)(41300700001)(7696005)(40460700003)(2906002)(86362001)(81166007)(356005)(26005)(44832011)(47076005)(2616005)(83380400001)(1076003)(36860700001)(186003)(426003)(336012)(36756003)(5660300002)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 17:28:30.7511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d2113a-8ee5-4af1-3af5-08db588e7702
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI device 0x17E0 includes new TEE offsets, doesn't support a
platform mailbox, and does support platform doorbell
so introduce a new structure to represent it.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/crypto/ccp/sp-pci.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index aa15bc4cac2b..d0d70af0c4c0 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -361,6 +361,14 @@ static const struct tee_vdata teev1 = {
 	.ring_rptr_reg          = 0x10554,	/* C2PMSG_21 */
 };
 
+static const struct tee_vdata teev2 = {
+	.cmdresp_reg		= 0x10944,	/* C2PMSG_17 */
+	.cmdbuff_addr_lo_reg	= 0x10948,	/* C2PMSG_18 */
+	.cmdbuff_addr_hi_reg	= 0x1094c,	/* C2PMSG_19 */
+	.ring_wptr_reg		= 0x10950,	/* C2PMSG_20 */
+	.ring_rptr_reg		= 0x10954,	/* C2PMSG_21 */
+};
+
 static const struct platform_access_vdata pa_v1 = {
 	.cmdresp_reg		= 0x10570,	/* C2PMSG_28 */
 	.cmdbuff_addr_lo_reg	= 0x10574,	/* C2PMSG_29 */
@@ -369,6 +377,11 @@ static const struct platform_access_vdata pa_v1 = {
 	.doorbell_cmd_reg	= 0x10a40,	/* C2PMSG_80 */
 };
 
+static const struct platform_access_vdata pa_v2 = {
+	.doorbell_button_reg	= 0x10a24,	/* C2PMSG_73 */
+	.doorbell_cmd_reg	= 0x10a40,	/* C2PMSG_80 */
+};
+
 static const struct psp_vdata pspv1 = {
 	.sev			= &sevv1,
 	.feature_reg		= 0x105fc,	/* C2PMSG_63 */
@@ -399,6 +412,14 @@ static const struct psp_vdata pspv4 = {
 	.intsts_reg		= 0x10694,	/* P2CMSG_INTSTS */
 };
 
+static const struct psp_vdata pspv5 = {
+	.tee			= &teev2,
+	.platform_access	= &pa_v2,
+	.feature_reg		= 0x109fc,	/* C2PMSG_63 */
+	.inten_reg		= 0x10510,	/* P2CMSG_INTEN */
+	.intsts_reg		= 0x10514,	/* P2CMSG_INTSTS */
+};
+
 #endif
 
 static const struct sp_dev_vdata dev_vdata[] = {
@@ -451,6 +472,12 @@ static const struct sp_dev_vdata dev_vdata[] = {
 		.bar = 2,
 #ifdef CONFIG_CRYPTO_DEV_SP_PSP
 		.psp_vdata = &pspv3,
+#endif
+	},
+	{	/* 7 */
+		.bar = 2,
+#ifdef CONFIG_CRYPTO_DEV_SP_PSP
+		.psp_vdata = &pspv5,
 #endif
 	},
 };
@@ -463,6 +490,7 @@ static const struct pci_device_id sp_pci_table[] = {
 	{ PCI_VDEVICE(AMD, 0x14CA), (kernel_ulong_t)&dev_vdata[5] },
 	{ PCI_VDEVICE(AMD, 0x15C7), (kernel_ulong_t)&dev_vdata[6] },
 	{ PCI_VDEVICE(AMD, 0x1649), (kernel_ulong_t)&dev_vdata[6] },
+	{ PCI_VDEVICE(AMD, 0x17E0), (kernel_ulong_t)&dev_vdata[7] },
 	/* Last entry must be zero */
 	{ 0, }
 };
-- 
2.34.1

