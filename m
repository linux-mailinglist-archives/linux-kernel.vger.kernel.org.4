Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2186A89B8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjCBToV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCBToB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:44:01 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C6958B40;
        Thu,  2 Mar 2023 11:43:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiqkYOmJ7X2lhozGIH7LoVZUwP30u5/l3jzPQdJRk+v5V+9OzJqZZAR5VCRex1KE+bGT4kq+TgRn+pAKWc6EYXoJjsgtPCVXlMEzez6UydS6jkIlCejgdQ6iT5JcB2cDbm0jPOM7t5l/q2p7HmuIM7DJfWsiDmlB/QPcs2N0xrWZKlmyEj5UZRfLQJ2FDHBdsdanNK6uH0pJHRKjhp1mPcJ+rsNZTcK6jUBZp2eZ7BtRk9Fjotou1lTIZxGirmTHoc1glMKvA18+U84KJi1HkB0hAhIzmIUqaJZBFqObM0powfOG2SKvt89dzsFnT3lv0FJHB1E3VgUmm8aPjmLe+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJjl4U9f9M1PlF8eJitKvYrLFSvKtD6pA1f7j8WURyE=;
 b=ewHCg7oejd/zfEgddej0VvnWs4ZdRiSjPsEpX/rkI/PkFKQIUpuhbMbx3xPLtxy3NZrFe0iYoQgiLVg1wzKwtNy3x9clcsc5Ffv5s2FZNqWAWTcPeQ47Kj1p/8D5O73gWPGHn603Zhz5VmCOpsNqq2fYIG3pA8JK0PsMrOMoO1OgibFx6WDCrBev8r3UjawVMUpikHaoi5A1VBR4Jfj+9w+y4csy/H1doP2iActpNtOB583m4x1f/gRQ8T+bWq/cXreRvfP0G1n1qxgHtd4f3C4lmj1eqjGuZk0fUMapba6ixOztCixXEtvKHMvP+NHtqsKbn9CQCrIIFxu/5vNDhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=semihalf.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJjl4U9f9M1PlF8eJitKvYrLFSvKtD6pA1f7j8WURyE=;
 b=duTruEg2/6R+suRMBEClvM9BzQnuHyvhg82W/zRjb/vAjAAX+IvJjyuuL4oRGexDgN5+qdKz7OiNHkO+izRGe5A2IwuLDVsCG2vzd2jy+jIbcrQytpN8xN9vvaDMjIBZbsAmlNT99t8c2B/9q6kp32HEhyQqY05cvdWvJhL4nJM=
Received: from BN8PR04CA0014.namprd04.prod.outlook.com (2603:10b6:408:70::27)
 by SA0PR12MB7464.namprd12.prod.outlook.com (2603:10b6:806:24b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 19:43:25 +0000
Received: from BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::5c) by BN8PR04CA0014.outlook.office365.com
 (2603:10b6:408:70::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.20 via Frontend
 Transport; Thu, 2 Mar 2023 19:43:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT072.mail.protection.outlook.com (10.13.176.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.19 via Frontend Transport; Thu, 2 Mar 2023 19:43:24 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 13:43:23 -0600
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
Subject: [PATCH v2 9/9] crypto: ccp: Add doorbell register offset
Date:   Thu, 2 Mar 2023 13:42:32 -0600
Message-ID: <20230302194235.1724-10-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT072:EE_|SA0PR12MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: ad3a6095-9a37-444f-d578-08db1b566325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 194QTItssUZX4tv+aMk3Q7tp/R4wHYy16a4sy0kiHdHEVdwgaxeOFNNGaOzHZM+HH0YMMzzQ1BJGFj4q2VC/INGoAiF5accIEtt+2m8zWps7v8Oib3eyC9T0RdmBWB1pktsq1SnokS+Y9eCOy9MmPfJFcRxErlVVTxs3lMHyPMi52PsT0um+IygzfQvqAVeqsAowJUX+EvxUEDryTQG60OpN0ooVcgxqa16z9CegBPSxjcmzH0aC6bsqbI1kEGwA9KIhGKsuqGeGktHj14fsxIqZjDLo+EG+ieqv3uFtF1HOoLkSLNm+Nycv/msAAzfT6DBorwQYatAUtyY1TQ8Kc2j4CeFbgtZMSx4ctbYxbpxngQGVBTzGfmVVX9c9QMIqWT19fXKr03bEp1FQ0OHvDtH4DSQ4Q++5c+P9Cquzq14rx9tbF+HWc+/fVQz0lLWDIqJy3reLnzGSWcgt13Hl/xwZBXFBtF+No4+dQvyE2IrgxcUFi707rvsGWhur5N9TGrjFFia04Z92tHb9zZspHEtYZco+QEuiQbLv1Fve514/p38IEwfj6OiUynujprdCD+9dT1kRnuty9G05kI7OZcwEAWZvnZ3U2fSB9gjoFWqxr0HeMOYXG9m82rMwHDL9nNPwYOd1X2GU3zrdhkO66UkxdnI7rufbSznBEfiX29eejXmdyD5B6+Ubtl6FTlpsyCYwB0Dm63LA3XerlogT7s52yckokP585qdXXoL9yqE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199018)(36840700001)(40470700004)(46966006)(83380400001)(70206006)(36860700001)(47076005)(426003)(6666004)(40460700003)(36756003)(356005)(81166007)(8936002)(478600001)(5660300002)(82740400003)(86362001)(82310400005)(40480700001)(44832011)(2616005)(336012)(26005)(16526019)(186003)(966005)(1076003)(7696005)(4744005)(8676002)(70586007)(2906002)(41300700001)(316002)(110136005)(4326008)(6636002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 19:43:24.7149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3a6095-9a37-444f-d578-08db1b566325
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7464
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PSP in Skyrim uses i2c arbitration with a doorbell.
Add this offset so that the communication can work.

Link: Link: https://lore.kernel.org/linux-i2c/20220916131854.687371-3-jsd@semihalf.com/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * New patch
---
 drivers/crypto/ccp/sp-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index 18aa902eb5ce..a4efcaee43d8 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -365,6 +365,7 @@ static const struct platform_access_vdata pa_v1 = {
 	.cmdresp_reg		= 0x10570,	/* C2PMSG_28 */
 	.cmdbuff_addr_lo_reg	= 0x10574,	/* C2PMSG_29 */
 	.cmdbuff_addr_hi_reg	= 0x10578,	/* C2PMSG_30 */
+	.doorbell_reg		= 0x10a40,	/* C2PMSG_80 */
 };
 
 static const struct psp_vdata pspv1 = {
-- 
2.34.1

