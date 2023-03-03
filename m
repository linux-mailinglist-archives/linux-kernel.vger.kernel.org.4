Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CA36A9C3F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 17:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjCCQvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 11:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCCQvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 11:51:31 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6990C10433;
        Fri,  3 Mar 2023 08:51:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLxlF3uZz5ASC8dZRcCZLezYQVgcnzzlpC7OszizBzpGrIq08bmB+3wZXLZ/eWIFNAmSL5+ZkJG3rJvNJDD6yQqh+FjM3NHPXnZFextvmR9Z+QID9xd51OpXJa2n7xv2a8iYiJdZUlzw+UC6BAtl2c4NNwsJH6Fe+Yrf0gqH1Zsxibn6an+DlPI6r0d60vjwNiWoZ3dTiBi1PCInSSB6yCGOItxvX67ReBmsqgxoLZxS6VAMQF/W/sJBqoKNkXxW+ae6ap+3lq2/QUej5cRImR3X25P/vTgWcMCcwWNJUPgXCtw9J0FFUmX2W+b9UjSej1qJNqinJbVbskjBMTcbcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rzg1UESHyZNuBD/Mg1N44KOrrw+B8UBfsuBYGTaQwMQ=;
 b=ia9VRiLhJSHG0k8Xe+5wfXYFE/B+QjvL8ZfKBS8Ie+GiAiMKsf4kXON2S2DRLpebFBBATWmSC9NbJn+etpKxo07gdK0d3iGS9HISaHK8aC92UKvmL6PrRX0/0AaxK+vs7AxvGz37mvaOmDHllw7swCkeag4Zms9ynjk2z7fbsgVPl6RELNm49UDrSsancUkpP1+nwJvFVJ4jKFMNW01tMAwZX2a3BVxv7MArmaS+pBWNmthSec+VNipwyq3BMOivc8QQkfBKm7R/Cpbu/tBEF0kMo4R8GwDzxS/80LjsagoG3Vpg2q7hDAn8Tc47Z6ShEAFy+jWhOF0uFeB3QDaDIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=semihalf.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rzg1UESHyZNuBD/Mg1N44KOrrw+B8UBfsuBYGTaQwMQ=;
 b=mNFbRLY1WDmcrFD7BFfqhJyYYi9hV+chhn5eNa6/LhTmpWQ6mgblhZQIN06ttTkhlHHkUN+XPVfGaV2Y9zIgz7OyR0+yipsUCNHrHBhqPGFTlmYPxe0vW+m5OCUza5/rpjAhiC2i0YJYdsLVPXFv0gz8MFMXKeGNWy2HhSmEffY=
Received: from MW2PR16CA0065.namprd16.prod.outlook.com (2603:10b6:907:1::42)
 by BL3PR12MB6452.namprd12.prod.outlook.com (2603:10b6:208:3bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Fri, 3 Mar
 2023 16:51:06 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::e3) by MW2PR16CA0065.outlook.office365.com
 (2603:10b6:907:1::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 16:51:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.22 via Frontend Transport; Fri, 3 Mar 2023 16:51:06 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 10:51:04 -0600
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
Subject: [PATCH v3 1/9] crypto: ccp: Drop TEE support for IRQ handler
Date:   Fri, 3 Mar 2023 10:50:39 -0600
Message-ID: <20230303165050.2918-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230303165050.2918-1-mario.limonciello@amd.com>
References: <20230303165050.2918-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT038:EE_|BL3PR12MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: c61d58f4-48a2-46ba-3cbb-08db1c077b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PCjkbVYaeogqoOYjlzVKOdbhloJXBPaCrLAsbANEx4yyRasUvqwLqiBEuXm0jBjYbyx9LvmLB63mZKJPR9WITRADYVE0I0+2Y5LGWqVhKFPG39aNxxNfg3Go9+k/gXqNGRuYGXso+3+B0HktY4/2plhQi7+dnqXEmXGMn1OLwORwUtbc2wrd8lp5er/I82uX/UJj0TRW299v7NmuNHuNAMKKAkNMFJ5PYnH8LqUgW0yEhzI0i80bjrRLVysf+DMK+Exrf5giMwni8FH81kE8Z++xnLn4as9b8Zenz0mRLSYQgwPVMAw9NnE9G/4/LrUR7wO8x40cN/4u02x2ViQXAJKbxqzjDwpRpciOPm1wzyW0WkfM+GyEcZN14WeaMwj4hjJlrm8yIzbbPUEhCSTZa9h6B3d1S4L5eFbS17zFU9wo9lJ1ZgquTdvNhqmL8H8fFXvQd9lKsheYG3qw+XPngjnPe6T/ZQt1SNPZCN1T+5QFoq22my5WRH18WrTvOqQcF3e7mqcIE/KSb6Ojbwd0fyHi1yZ7SIifynAkF86xKNJ+O5mZHaDNXmgIVr8IUwCEjXEpQz6lBFdoucEPH0k9fhBH+pfoRv9WVdS9xV7Al9mCSgVM52GMUwsSXygFxguOGM7MXYH9OJ+rh+HhHLGqmk1M52pNN7wJRqK7Rq25SUe2MvAgDFxE9p1QtaE9/ceJH1JuRj8L5peS4Ta2yFIhdgqYYeIjubOK8zIuJtu4hj9gbMWFCi91yy2cF7vREWBjEahhQJyzHzZUJnSFBOXIVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199018)(36840700001)(46966006)(40470700004)(83380400001)(36860700001)(47076005)(426003)(1076003)(6666004)(36756003)(40460700003)(82310400005)(81166007)(5660300002)(82740400003)(8936002)(40480700001)(478600001)(356005)(86362001)(26005)(16526019)(43170500006)(2616005)(336012)(186003)(70206006)(70586007)(44832011)(2906002)(7696005)(8676002)(4326008)(41300700001)(316002)(54906003)(110136005)(6636002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 16:51:06.5377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c61d58f4-48a2-46ba-3cbb-08db1c077b95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6452
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

Acked-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Pick up tags
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

