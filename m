Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A110709E25
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjESRay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjESR3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:29:51 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3764D10E7;
        Fri, 19 May 2023 10:29:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUXhncL4hRTJQSoYCPnpixnyLT2B66nZPHDQM0cDS4lAxRfo6INg3Ep55ecZkqQ3EF3mhRCzCOIEzQMTF/DfphihpLxsL9MQQz8ATGghd0TEyzSZQSAxYTX1kPSTz7nXr08V0Vyvo4+Lx7RJZ4qgljDqhTJzXBPxnATrcWUHN5wcYZXdl2dcP83alDQeV3xpOwqApGwrhERCRCF/u4b2RfXkS3Nx5/LDgLOxUzC8N3MdShBxVw6JdhDpDU1o/k09rRYSwnBRqhxxdJ07SGHS0VenEYMne20S0tnTB/laqK5v1vBJzojOZw2eTW1fBUC8ZB7xRWNWfR1C7ks36/u5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uksMuvkHaQ2TyTvo4yDqIpiAZyC6gKRoWCNv996UReE=;
 b=AjihvanmZC5NfhJ+eFyGxuW0U39u13mtwRp8H1E6NfFoM4sKLOjZx06ulcnwrgZ2MRZ/nWAHjh4w84OJC+bEfEDkVDnlXcSEqFueGpMohLpII5oGeixrQdiyhYiX4WBI2CXsZPtDs1w9f5qF1r8r/a5G+rOyxlN1nAuH8LY1FZQjoWfjMbaU3dUgm+Xw71uLEGTRLmyMKemCUts88X8feb+Ymr65QYEw+3/htkRMeIV/fG0vv9EvkVEuSVyVPgkCeBABHOS0dhAr4RqUm3bjamES2KKN1t8JCZMkLVAKTxqCmY6lkRrgGnyhjibXsF2RSfi8c4ha8FTgDncBgA0Tvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uksMuvkHaQ2TyTvo4yDqIpiAZyC6gKRoWCNv996UReE=;
 b=gpNCo4eVVYGXBerMysK3ufe2rEPIUP1/pqHaBph7/SEcVEEN1sZjIrCpTs3V7qcS+GNqmIl3dyPaBw4HdiQvu8J2dqvmYPYVw8EgXFfme7VkFIwqD7+ZH1zyo+bStrY3awwLcxgz9zoIrN8csj6Xj0KbMiJXOp4Y0/ptJsuGZrE=
Received: from DS7PR05CA0098.namprd05.prod.outlook.com (2603:10b6:8:56::8) by
 BY5PR12MB4886.namprd12.prod.outlook.com (2603:10b6:a03:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 17:29:05 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::9f) by DS7PR05CA0098.outlook.office365.com
 (2603:10b6:8:56::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.7 via Frontend
 Transport; Fri, 19 May 2023 17:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 17:29:03 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 12:29:02 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     John Allen <john.allen@amd.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 04/10] crypto: ccp: move setting PSP master to earlier in the init
Date:   Thu, 18 May 2023 22:24:42 -0500
Message-ID: <20230519032448.94279-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|BY5PR12MB4886:EE_
X-MS-Office365-Filtering-Correlation-Id: 45473252-e1f4-46bb-97c6-08db588e8ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YtpNz7pXpJO4qUsWbrBKjiVPDCmfx5vN+bOgU9/LGUP4o51qJhOqbp2Es3+oEEkUo+wpfxJEo4uY8ghKaAoFNJgpMA1fS7aNH/M2+cs2diwJRBoqP0R6wuY6DBfNGKSF6SQFaqxNNQT6psmStNhtkcY/ETTo/twtvmodCxqyx8erBJXElurtGCWY7ULVKDDHBmyrpCUVpaqAk8daKpP/BgL2ZQJlJGS1QkhD0kawAnP/JNnyoRSNN9psxJgrkl3oRBe6FKOSOv/zCt2k1xf7aoo5qNnpfq36Gd/DeSd486RQh9PIR4d6G90naxUaZQNTxCBQkwO6wutXEzNIGlqog8fCiOs6irMCAFYGec+/pVf63NgMnB0pOZwXcm6PDMFCTDzXxtWd5Juw1XvrbJoA5JHRsdiVQ4xxCoVeAK/XTBYwieAtVKSO9iMvkpIx7+R0lVQyLVVcsHIT6koKNfhFC3eTM90tQtOQmPFg9M+vxowbgbDp77ed3Xbnl+6XooaDUN9zj2BzvWdsCUMJdoY5xQj/2oK7uEmlC03UL/frJNrOGbXGGofRApQonKuWG8211rrOFdK+WuT9ysYHsoLPMEqCy7V74+p10KcRrf54RchezlrLT93yuEXjPEUAbAIxpQvSph4JOZLk000hRI6Dg5r2vWcY5xhe/7DDLkudjxR+hH87FNJ3mJbNFaQ4u6TF2Cqhf2Rzx3KwxgnNSkkm12eupAhF1c7t5d6W2sQRNnO3F45bW2DLfy2Sf+Pt92GpXHAlaQeyw+hyJjnZ5sYgpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(6666004)(7696005)(41300700001)(44832011)(36756003)(1076003)(5660300002)(82310400005)(47076005)(186003)(83380400001)(426003)(336012)(2616005)(16526019)(26005)(86362001)(36860700001)(2906002)(356005)(81166007)(8936002)(40480700001)(8676002)(82740400003)(70206006)(4326008)(54906003)(70586007)(110136005)(478600001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 17:29:03.8098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45473252-e1f4-46bb-97c6-08db588e8ab6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4886
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

Dynamic boost control needs to use platform access symbols
that look for the PSP master as part of initialization.

So move the PSP master before psp_init() so that dynamic boost
control can be initialized properly.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Clean up master device if psp_init() failed
---
 drivers/crypto/ccp/psp-dev.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index e3d6955d3265..3390f0bd6408 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -173,13 +173,14 @@ int psp_dev_init(struct sp_device *sp)
 		goto e_err;
 	}
 
+	/* master device must be set for platform access */
+	if (psp->sp->set_psp_master_device)
+		psp->sp->set_psp_master_device(psp->sp);
+
 	ret = psp_init(psp);
 	if (ret)
 		goto e_irq;
 
-	if (sp->set_psp_master_device)
-		sp->set_psp_master_device(sp);
-
 	/* Enable interrupt */
 	iowrite32(-1, psp->io_regs + psp->vdata->inten_reg);
 
@@ -188,6 +189,9 @@ int psp_dev_init(struct sp_device *sp)
 	return 0;
 
 e_irq:
+	if (sp->clear_psp_master_device)
+		sp->clear_psp_master_device(sp);
+
 	sp_free_psp_irq(psp->sp, psp);
 e_err:
 	sp->psp_data = NULL;
-- 
2.34.1

