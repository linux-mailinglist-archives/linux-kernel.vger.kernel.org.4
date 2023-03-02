Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53946A89B0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjCBTns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCBTnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:43:35 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A87A580C7;
        Thu,  2 Mar 2023 11:43:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDnzqkMllSTi2cvDvzvjn4EQxPLtqN8E3cKc7eeTLxB2ge3N53yXEtoONoLrhjQX+t9AiNE/cgspQeuT2dcstlwS2QJ5TQeepAvmG+tu3E8M4GN/rL/bVQAExMJ8ZZ4BjVG9TWOscbW/V6Z/nhFIYY7kSPbeIVMIT4oVnAGPgQL/ygXuQbWGcyRRnu/AQHn5E1/PjEjJ6VkcoaH+PG5ZC29OEmPee2C7p4LdAFqadYo3vGxPdLccGBSyFRpia7lhzsGy1S2+rM+TbFfXjFUbf50WA/QLBbZRNMRS5uBM+hGHKhvdR9TwtbtwePTmlVOdZFfeCE+SzJkwgyXFqOeeQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miIKd2uqEYODxld1Xk6KNcz1a3s+EFrV/93HLXFqcRk=;
 b=dPLOVjePcHjtLrhnm2/vE97YjG+fppJN+H01nSIlopuCzuta2cG0rVyr1d+azHFbT3jUiWpsIN4HXroFaKO4Q0BYH0igmSuPyVQFzQsJ/Qvl2gS5+Dn8726H5k4vJb0xcCo4WS4mQ7hy+B+VAagV2oVKtco3QPOJ6lpKFGKbzpwEgWO79P9bifR0bMG5kjJfP0bH6RxaZ1WX9VtyPRb0J9mdf03OcJHVaUa38LyJHeoQKfmzcbQAcHjuv1Ul2eS+26+7J683V6PToM79jffs30LJrG/tAtV63lDEVej1VQ76/L+qgJsL+Dbr9HMvsONOwQLUVq6Fz1AFP2QfAVhgmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=semihalf.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miIKd2uqEYODxld1Xk6KNcz1a3s+EFrV/93HLXFqcRk=;
 b=qhLzLBP3PRWcXfbsK7QlMFIb98jr4e1JUvjz/bG6+cb25gxuXv4Gw2c1xGzlGhOLejaMRPSlolwJhdRlQRzi8cG3w4NfzaPLgCd63EEyYhKDK7ngsJ/hELadFEqWH+D3cAPmKMVaBkIv4oiSJLt9Wynl930T8cqstkVideoQPcQ=
Received: from BN9PR03CA0901.namprd03.prod.outlook.com (2603:10b6:408:107::6)
 by SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Thu, 2 Mar
 2023 19:43:20 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::37) by BN9PR03CA0901.outlook.office365.com
 (2603:10b6:408:107::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 19:43:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.20 via Frontend Transport; Thu, 2 Mar 2023 19:43:19 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 13:43:18 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     =?UTF-8?q?Jan=20D=C4=85bro=C5=9B?= <jsd@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        <Rijo-john.Thomas@amd.com>, <Thomas.Lendacky@amd.com>,
        <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "John Allen" <john.allen@amd.com>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/9] crypto: ccp: Enable platform access interface on client PSP parts
Date:   Thu, 2 Mar 2023 13:42:28 -0600
Message-ID: <20230302194235.1724-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230302194235.1724-1-mario.limonciello@amd.com>
References: <20230302194235.1724-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT026:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: c08cbd6c-6de3-44b7-22c6-08db1b566037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A85P2OTEDYetw+EabG0JACNnuVwrIfKi4xePco2lc1T3/quDsQf0fGm5xq85Xt2LtoIC7+Or7DbiIBt6hIxNLT/Nvut2jLRSHymRS/AzBKf41jDj18ldTlPxQm+Bs6u7iOLIwtqjHUwCcTw7ecuHkGJ26D5Wvbv9c8/d/nlzXLvSLa0SH4FFd0csL01MVTbx5TFLIs025CKEZ4O49Qdq/v0iGIh7kVV8b9kUjAqUXvrStIlmYFlqBeoNkLMDcfo2VhxJxhE1rjbGfk+3kMphlmSq8Fbjs52lscO+9L+dQWTZuq36DNaXGK4Oa7jp3W3IzktUDMjU7PIR95MqT2zO7ccvotWdslLRjrfJGniYxGmi7bhtB0GiQP7dHiPb7pSzyuLRUM5eUYt9p8TTe3hiAFLt1maibJHhvCxIIRk/zGg65m7LfkTs623dP+V78fIxGSc7I5tMArYPevHAIOkBVLn1Kd/BE1bYREh30B1TYUdEn4LYwlr9omFeBEmYoTKnxAiuSCft4lAi/Hfm1N9Fpf2qFlJmT15Y5ChSkH77oO+K5C6FGNSxQJ4ri8xdx7OeP2QCGjdEUfdDrCOg9/e5AqR+Q4bwtl3YDcozOE8B9a/gRiPOPkP13oupqC/2GcXBcM986seDdF+5jh4u5+0THxCpQAJHuArUA792yBuXJ4pht7cl8r2M7cKI01k+0HiI3Gc939n5SvQj7V62U29vSkBSx5LqJ1gquTInY8mWiSw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199018)(40470700004)(36840700001)(46966006)(356005)(81166007)(36860700001)(82740400003)(41300700001)(8936002)(4326008)(86362001)(2906002)(40480700001)(70206006)(5660300002)(36756003)(44832011)(8676002)(82310400005)(70586007)(336012)(40460700003)(1076003)(26005)(2616005)(186003)(83380400001)(426003)(16526019)(47076005)(110136005)(6636002)(478600001)(316002)(54906003)(7696005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 19:43:19.7951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c08cbd6c-6de3-44b7-22c6-08db1b566037
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Client PSP parts support the platform access interface. Add
the register offsets so that client parts will initialize this
interface.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/crypto/ccp/sp-pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index cde33b2ac71b..18aa902eb5ce 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -361,6 +361,12 @@ static const struct tee_vdata teev1 = {
 	.ring_rptr_reg          = 0x10554,	/* C2PMSG_21 */
 };
 
+static const struct platform_access_vdata pa_v1 = {
+	.cmdresp_reg		= 0x10570,	/* C2PMSG_28 */
+	.cmdbuff_addr_lo_reg	= 0x10574,	/* C2PMSG_29 */
+	.cmdbuff_addr_hi_reg	= 0x10578,	/* C2PMSG_30 */
+};
+
 static const struct psp_vdata pspv1 = {
 	.sev			= &sevv1,
 	.feature_reg		= 0x105fc,	/* C2PMSG_63 */
@@ -377,6 +383,7 @@ static const struct psp_vdata pspv2 = {
 
 static const struct psp_vdata pspv3 = {
 	.tee			= &teev1,
+	.platform_access	= &pa_v1,
 	.feature_reg		= 0x109fc,	/* C2PMSG_63 */
 	.inten_reg		= 0x10690,	/* P2CMSG_INTEN */
 	.intsts_reg		= 0x10694,	/* P2CMSG_INTSTS */
-- 
2.34.1

