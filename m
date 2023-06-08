Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6567287D3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbjFHTNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbjFHTMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:12:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A5A30D8;
        Thu,  8 Jun 2023 12:12:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJQDEceI/xSeIP8Kn52OWJ9PLqzY+kp38LFjqDLnzTXPi2xJ61t02+qapK5/h2oUPvh+o4mMM3jOgwjKt5LjO3EHJiRwSymXB64Bu6l9pHx6az3D5NXAgZFlzKFCQvkRud8Z9VW7BFndMlJVZaMiL5odSCaeo+BS7GBphaSVL/yBX6o9rDMPsaUyQq59rejAqnBm0/s1ay08wfUhEdXqHWwn+0HHKpbVlrhebkTcFodbFuSB49D4GRCXvfTMU4xeBvO/T0iUArHD2FJgmYZOZRNDFUV2APuRqq9qcUUWQ6ewQ55iaBpXKgMkr0fjU3INS6KRdR4nH+5vWR4dayDY2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILaifHIw6vbRQNlT/s6ir+20iU8kvoJBjKCJt9aeZRU=;
 b=n4wvfk0GgxFiBVcCxhD6WYaYDjxY7kC0ILLE05293Yl4OAwIzM4oPlBq/iOD4c4kcphU0NIZ874+BAP2WzIpjJbOoDZ7sBwhMO2OrutvW8nl4oR2AxnsbE21iu+Fqv9qEwB17HO+yjsUCKn0k80TIugX53/jHmNFF2TuX+yLXLUldCU6kLhMrcsb0GAmfqqh40vqwiDsC+mWrEveIhkaENhQIB7B52cVZ+Ft7XFmHQyv+MjQ/PqPc/unNrIRf2EHrdpZOGzCEiA6Aid2ZnSOK0pBFDkHPlDei7p5/8pKXi5uzuOQ3G8kczGbZKmT7z6qCyC1VGQTqSMy5AK+lmgpEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILaifHIw6vbRQNlT/s6ir+20iU8kvoJBjKCJt9aeZRU=;
 b=A47w3wUFn2odOWGx97TUOcvstRQl8ZwuEk5SbiCaiTaqF9GHM6IoJVsEViuuHMP3PDcf0UdGza/DRERI+j15olY6gYYiXAHipSLdt9MKwWJqHOwEWfZVg4yapMeA7oB3EBxqRpGEemi8yz7XJBX7fJuuIv5a3B3TItnWoNqdleQ=
Received: from MW4PR04CA0256.namprd04.prod.outlook.com (2603:10b6:303:88::21)
 by SJ2PR12MB7865.namprd12.prod.outlook.com (2603:10b6:a03:4cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Thu, 8 Jun
 2023 19:12:31 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:88:cafe::b3) by MW4PR04CA0256.outlook.office365.com
 (2603:10b6:303:88::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Thu, 8 Jun 2023 19:12:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.0 via Frontend Transport; Thu, 8 Jun 2023 19:12:31 +0000
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
Subject: [PATCH v4 04/11] crypto: ccp: move setting PSP master to earlier in the init
Date:   Thu, 8 Jun 2023 06:17:50 -0500
Message-ID: <20230608111757.32054-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|SJ2PR12MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: 4857d286-fb1c-43cd-2396-08db68544ed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: esk7JcwBq89+Dxg6BBamY0sXeWK/hbp9TdXvIFAIoVH3ptnbNK5QpTqSxFDxA+d8ROnWx6LJAOBzrfGEdZS6ByffnWSIFoMWp4inhYQdURl9U1/In/iuONNG5DtdgbRKCHW+gPk6N/f7eUDAaifRy6jaTSI2VuNtFITNutw+Qt8lgrGi6pJIUoVbaD549mPViTbqTsMCRsuNTXdi1tSLg2RXWF2S5T8d0BJvFp9ee6g7Jh38hMrWDdzXXQ10sQ73spWm7ihGLwsFIZ2EsTiqwuAtB4wWe7mLcH4sTK0TqaVdgl/2CuTwWBHZdMsy3aaIxFEYxZzw3RDkbvsnCdly27NBiWSIKuLum5aCMVic8zZLxmOnwmnm6QEET9NCwgo0KvAWZZzK+cS0NgVpIK3ZHzKbLe50ECeolShFTBMvQ4R/l0xN85lufL6JFQIcbyQetIvetg0NLc2zW+1iJSAOzbIm4bDvr28KBX211SGMN8+0Omw1RctkUBe8IcYR5F2pptnNC8Y/eZwcWkFo7Q2ws/TNT4F0KDm+Ssg+iHNPiFpIUzzc6JFwooCRw3s5TEWavYewlJaJJyWt4POVeo+lJEnYxgKB5CxyvLeu7net6D4pKkbjPgAQ7KmeCTXPP85jtavwv5AoS7TL6sSANUkJqiB9WRJN43AATbWk7x4YEgTlGqoKZN/vIAmhFyVbxcPhNob0erlDLKO3T0RdT5J1w6dLvQXtgUhlakhyh/kft7FUqT/sq/fl0R6odZVFUDakmk00iMbp+lR+RwkYzChcaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(1076003)(36756003)(26005)(40480700001)(83380400001)(82310400005)(16526019)(41300700001)(186003)(5660300002)(426003)(8676002)(336012)(110136005)(54906003)(478600001)(8936002)(6666004)(4326008)(70586007)(70206006)(316002)(81166007)(7696005)(356005)(82740400003)(2906002)(86362001)(44832011)(36860700001)(47076005)(2616005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 19:12:31.0445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4857d286-fb1c-43cd-2396-08db68544ed7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7865
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamic boost control needs to use platform access symbols
that look for the PSP master as part of initialization.

So move the PSP master before psp_init() so that dynamic boost
control can be initialized properly.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3->v4:
 * Pick up tag
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

