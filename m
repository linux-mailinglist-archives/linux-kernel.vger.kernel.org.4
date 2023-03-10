Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1056B52BB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjCJVWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjCJVWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:22:34 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDC912B659;
        Fri, 10 Mar 2023 13:22:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6rE6s1XYqltTvHjnxxixoNvuIzejKF8I5FPy1e1hF5rKoMvHftsxJeh0IcoCWslMfruQVNEsG6CPHze4hI8Gc9Sc2OOAGRf7qioMV1lpWj6kf9EpeSHi+CyYOv1fvbjkTw/ipo01CZDgMl6iKIgl7/lQHXDvgOy+N/CQYufRYvKouyFhIdIgVWtbm/15DT2qGlAfQBcuRKrx2cQEglmB4sHG7jaKya9g0N4OrlQGoCSOb8kJcJqR1tDQQSNVYNAFpl1OnFQVBgi1LgCQ+RfxUweRZF74pA0FUWmlkCWv75yvXZfoGbFR5QJlrQMv86Zidijwsh2VpbjpbFySksLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2d1iDHkR6uDGO8Y32+hVteposkswmEBZZyOzIdyuj4=;
 b=QGW1bB8Y5Df/MsWfbmNDB7wM+7h6qbPc4NwmjWrEZJRS60GsZ1dFFUe8YXmDjf0+cmIQ2dFzQ/HkSYmeNhzU+HFTziApXMK/Pl4j2lxbt3FX66MDb9lglTEBCjTY+4kixACnZlcbitK2gbk7yAnblvIc7hE6XoeaMwtS70EIZPtxbTU0VVzjS94iZIH+lNTbAA47SH66ts8PLLbBXUDHCpl/6lyuSRBemTn33SeGxykRRD27kgWmTH9sL+rBdFOUXebHS51TUQuk+Z1OYHAh5yZSq+PG4CZq9W9C6z4DUVH7VrQS8gDuIPVwySRM3ggVs200Qh8KnZiIpOT6G+sueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=semihalf.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2d1iDHkR6uDGO8Y32+hVteposkswmEBZZyOzIdyuj4=;
 b=d+yKcQUyaLlXSAwCQf/BYvNnADP8moyHcOssgDa7GQ1Oc4hCO/i96VrqTlSErWfzDDiBAPto+qpMlDjqRdhlBRwZxM8MvxMsDSHDg41NKlykWS526WfvYxsH3nY4pjZjJqYeUPcYetYGkyXXyaSfSln48n90h08HU9+A9XxW6K8=
Received: from DM6PR13CA0045.namprd13.prod.outlook.com (2603:10b6:5:134::22)
 by BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 21:22:23 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::fc) by DM6PR13CA0045.outlook.office365.com
 (2603:10b6:5:134::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Fri, 10 Mar 2023 21:22:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.22 via Frontend Transport; Fri, 10 Mar 2023 21:22:23 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 15:22:22 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     =?UTF-8?q?Jan=20D=C4=85bro=C5=9B?= <jsd@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        <Rijo-john.Thomas@amd.com>, <Thomas.Lendacky@amd.com>,
        <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "John Allen" <john.allen@amd.com>
CC:     <Felix.Held@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/8] crypto: ccp: Drop TEE support for IRQ handler
Date:   Fri, 10 Mar 2023 15:19:44 -0600
Message-ID: <20230310211954.2490-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310211954.2490-1-mario.limonciello@amd.com>
References: <20230310211954.2490-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|BL1PR12MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: bd19742a-1fb3-48cc-91f7-08db21ad8a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8SK8dG54P30F/ZSMQ4hql+Qx/NKixfnflI6k45+CTkhhMXqX5xUoIftCG/TIW42GFM5UpJ815ExQld8h+IF3UmzaVe9NDY2i3JTJQ7VV241Hpxhpg6jBcLvx1sA4MlZx7OImoSbhYDBmrSvtZDaawszC5G88yBQLDgSnsSI8H9ZtEf6v97OXMyI1I6oZMZDskINO/iYmH38u5yey7O7KifilbBJD1jWYLxLVsjNO59gbwxb1xoc4b3NaTg+D4JZ652NEvj9AFs5CD6Y2ig8oj9dVrPa6cYYetjaqHXj2RoT37GFsDJdoAcdau4hiEZWCFfC3sGRlsUoVNaf/hvFYjLZ1engQaKWWtSamxqan3jXMFppVSCnvTXYxVU3H/9SnDNktKy7ynT/FE/0Mi8ovgc1RW7jYg78HCclidAASPBwLUZ8/VBSyJlGm5o2NEQUlXeqGS4SJ/4FM072VFsyxF+hLTyiOd5ybufkCeSDsd3KBsVf1RiPQHF8X9JV7KH6XKDS0aIrduxSvL/woME7o+C72Px6ONEt2AgJdVT44pNolpHMzyrxMxtoUbBm+o91Pz8P5DknFOUPXV3qlvbxek5PYTocGlYKxoRBvVvyQtdc/aSlXkPYGTLliheTNJQtJs0NmQN/zceYkmIm6bZK0gVS/96oSqHe7neaoHZ8Ix0Pfxv/Dk+9OwgZS9JvTHgjiVCFOa0Gk1HXTvgM9WjUBPYmxVBfdklQC2puibmb317IycAiN7+cZRiUerdPq3sMhvcRT9+GwtSV5/IYXjU66XQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199018)(40470700004)(46966006)(36840700001)(82310400005)(82740400003)(36860700001)(83380400001)(426003)(47076005)(36756003)(6636002)(54906003)(110136005)(40480700001)(478600001)(81166007)(316002)(356005)(336012)(8936002)(43170500006)(7696005)(41300700001)(2616005)(40460700003)(6666004)(26005)(186003)(1076003)(16526019)(5660300002)(44832011)(8676002)(70586007)(2906002)(4326008)(86362001)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 21:22:23.4035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd19742a-1fb3-48cc-91f7-08db21ad8a34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only PSP mailbox that currently supports interrupt on completion
is the SEV mailbox.  Drop the dead code for the TEE subdriver to
potentially call it.

Acked-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3->v4:
 * Pick up tags
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

