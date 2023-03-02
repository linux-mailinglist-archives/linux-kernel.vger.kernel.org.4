Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604486A89A6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjCBTnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCBTnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:43:10 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9082FCE2;
        Thu,  2 Mar 2023 11:43:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrxhcDWZXrEDIvZ4/ZMZvE2xYtdl0xxCHrEQdZxYHNWNLaG5bbwkLQCzkzLVOpvgWQINZ77HHXFqKkpZqVJ3EvFRlh7eF/WsiZRMbpGf9alk6VpvryprgwDZaMrjV1+PI7X/KhT/0E3Vm4EcUWqiqAdjzWM4BalH0abwNjGS2N5a8tTBq6mg8fwF1TG7CORQl0Zkp6itth29MOB3rHDBRzR946ZN2rU10mFYaX4JFbAHkcd8PtjuU529HPAyv+XU+enCmj33n9+9DgAI3mPlUQi0vTajAmEpxkyaltfj1Ln3sJ92X/CXfSY5PqzQ7JGZ4G0zTMmvdP0H+ea8TfK+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJxFANk3/KMRohDtDcgqgAGdf4Q8l9vNmxOY4NSlCKQ=;
 b=KqVYgIIg3MuKgP3VMMH3rhUzUPIaybW1k/PWFl+zvwWTV1pxEMz8bgwZREMmRgm/tp45L4KAGwk/9utSd6IWPA9Go04h6Fh2YZ/vnGeVyrZcNpQH9/kOulWMMcrvhCB0Zz+meywqzfrMSkAG+Q3ZTR5i32WNtO4DsnbxRlCRglnFqnukLP1wDbk6GdXt021FJ0DWSrUb4jXLTZ0PxlqcHT/vm5V4x6XmxdeMnu5l6/PGzeFPdaOK243/YOO1u2vU89cGUKoMHoGI7cqEglcxd94WDdZLKf7PYxz2gDZgRGLDXTMDOI2askoK3REbQqKuf2Q4HCHeuF066Mvy7zct1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=semihalf.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJxFANk3/KMRohDtDcgqgAGdf4Q8l9vNmxOY4NSlCKQ=;
 b=UHozP6ij40kgjMS9jUDwSIWkSwFlm1K5Yqx9aQvZD7I4I96XS2dFXA5AAFchJaed0I+aTiAVzyb/DTPvGitcz1yatJCGUVq8KtpuXIe0GSwmrACd1OTX83wlf3mTFxwxQculUzhX/1oltWar9O7XBeOnmrI67oOKmiy403kHMGI=
Received: from BN9PR03CA0915.namprd03.prod.outlook.com (2603:10b6:408:107::20)
 by MN2PR12MB4405.namprd12.prod.outlook.com (2603:10b6:208:26d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 19:43:05 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::23) by BN9PR03CA0915.outlook.office365.com
 (2603:10b6:408:107::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 19:43:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.21 via Frontend Transport; Thu, 2 Mar 2023 19:43:05 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 13:42:55 -0600
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
Subject: [PATCH v2 1/9] crypto: ccp: Drop TEE support for IRQ handler
Date:   Thu, 2 Mar 2023 13:42:24 -0600
Message-ID: <20230302194235.1724-2-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|MN2PR12MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: 883f331b-c8d9-4ecd-3fa2-08db1b565773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lItEFqebjottIZCMaPoD384xSYlkZP0TlrHxfcLLL56KhrIbok3utBJXobWlen+V9i8hUN0UJ0xzKHmQL9EKqb9NcPVzjo1Rm9ynqdgamPIfrZs2AfvVotO1BCmogzHCc3Su9jMbyLiODDMr75COI/ofbHUEsA41RLoHiHhICTyKUbP1PBxx5IUtYi9A6l3Jq7BuAy9Qc4jQfVWmzP8pqR76t0Y1mW9Njjh85TVKiSIPufiKJeBGous/9Px2hhrM6+wNch9a4BbaXcquE1VmzJgFGzoLIw5j5lPjW357aSzE9T/xjIwwgmle4h3vK/+j7yPPRDwQUHQ52avNvuAmZFQmnFTJLZF4EfREUk6ABwm75Z9MthPB+p6XUgT8+oxm0Dy24KBNPUSqVDwmxihbr6JOXeZcPAf36PqEax6LHdMFAhYXWYvxTjHWhpfNo+jrGILWReWmGZD2YQOnqUMXyhviPVdWJOhOM14b3/U/vrLkPaey76Lsvw5O2vvz3oE1FDro8VLdtw8SwdYjKZ9ChhOeNJqVxNL6ISWHWOHAcy4PZ3hVKIU61pPtSw6i5fz9m5ic1eovFCtL3/jT/b0pDzcVIsuzi1UmN1A47MshFhYD2xJAWn59MiImNRnbtcEu6K5du0+zgdkdyn+8FiWgvKhtz3IKvdTEds5cuVwyg7oHNlAui+uemww0RvWG+5YWh+Fec4yBmiWcTLDYA35ujAiBUV1M3bRjRj2lKemC4//3jKsfdESLikhH2IwsUeRTrM/vL14iE/Usv95iIaW/mA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199018)(36840700001)(46966006)(40470700004)(36756003)(40460700003)(40480700001)(6666004)(336012)(43170500006)(2616005)(1076003)(16526019)(26005)(70586007)(316002)(4326008)(41300700001)(186003)(54906003)(6636002)(110136005)(7696005)(2906002)(8676002)(44832011)(70206006)(81166007)(82740400003)(478600001)(8936002)(5660300002)(82310400005)(356005)(86362001)(83380400001)(47076005)(36860700001)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 19:43:05.0896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 883f331b-c8d9-4ecd-3fa2-08db1b565773
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only PSP mailbox that currently supports interrupt on completion
is the SEV mailbox.  Drop the dead code for the TEE subdriver to
potentially call it.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/crypto/ccp/psp-dev.c | 15 ---------------
 drivers/crypto/ccp/psp-dev.h |  7 -------
 2 files changed, 22 deletions(-)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index c9c741ac8442..cd8d1974726a 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -46,9 +46,6 @@ static irqreturn_t psp_irq_handler(int irq, void *data)
 	if (status) {
 		if (psp->sev_irq_handler)
 			psp->sev_irq_handler(irq, psp->sev_irq_data, status);
-
-		if (psp->tee_irq_handler)
-			psp->tee_irq_handler(irq, psp->tee_irq_data, status);
 	}
 
 	/* Clear the interrupt status by writing the same value we read. */
@@ -219,18 +216,6 @@ void psp_clear_sev_irq_handler(struct psp_device *psp)
 	psp_set_sev_irq_handler(psp, NULL, NULL);
 }
 
-void psp_set_tee_irq_handler(struct psp_device *psp, psp_irq_handler_t handler,
-			     void *data)
-{
-	psp->tee_irq_data = data;
-	psp->tee_irq_handler = handler;
-}
-
-void psp_clear_tee_irq_handler(struct psp_device *psp)
-{
-	psp_set_tee_irq_handler(psp, NULL, NULL);
-}
-
 struct psp_device *psp_get_master_device(void)
 {
 	struct sp_device *sp = sp_get_psp_master_device();
diff --git a/drivers/crypto/ccp/psp-dev.h b/drivers/crypto/ccp/psp-dev.h
index d528eb04c3ef..06e1f317216d 100644
--- a/drivers/crypto/ccp/psp-dev.h
+++ b/drivers/crypto/ccp/psp-dev.h
@@ -40,9 +40,6 @@ struct psp_device {
 	psp_irq_handler_t sev_irq_handler;
 	void *sev_irq_data;
 
-	psp_irq_handler_t tee_irq_handler;
-	void *tee_irq_data;
-
 	void *sev_data;
 	void *tee_data;
 
@@ -53,10 +50,6 @@ void psp_set_sev_irq_handler(struct psp_device *psp, psp_irq_handler_t handler,
 			     void *data);
 void psp_clear_sev_irq_handler(struct psp_device *psp);
 
-void psp_set_tee_irq_handler(struct psp_device *psp, psp_irq_handler_t handler,
-			     void *data);
-void psp_clear_tee_irq_handler(struct psp_device *psp);
-
 struct psp_device *psp_get_master_device(void);
 
 #define PSP_CAPABILITY_SEV			BIT(0)
-- 
2.34.1

