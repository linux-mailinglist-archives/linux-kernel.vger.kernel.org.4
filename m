Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E403704AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjEPKdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjEPKcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:32:42 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50775FF1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:32:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YG1ul2EBNq74IryWeLvkczNc5lOSXN0uXX4GFagBQTuH4wzJyWmBlP64h2YqzzIwqznQ/7O/tjj4uum/synUFWSwlYjGD4oIYD4DrzyO8PFNJMghSQ1BP8lzM7CUNHs+i3jwGyKN24/SwFtlOjcsy9kdvZVUFaPdsQQPWOeHMR3eBeGMOK68O6hoZl1UsynFsmSGfcIYbETxtRoGDO6AoW+58uQwRdZygHqTq3uD+f9y26l5HRktzRm6k2rv2ZGHBh2/kudSVYH15+rnFULcrKVt67vqAfdHyF2obvVlFOK5sp62u3NROc6rYtAQNK4bR887pEgNXaiUm8x8Hu9adA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HivbUaM1Uo0KUDrQX+KQZ7hl13PDZNmdXUW6SAdFYo=;
 b=oD2KG2HGT7vm7lVX7PX0ZVeW+VPPkMebGYiFsKpFWVt0ps+5AGWik7yi0xvoHFWXym0dPC+Z/Vkp7xrQuBapCR0SOENt2fpYtKBm/ksxIjPVBejUGnHvvI6vOblTj0xauBoOxxGd4gxuE5pSsNiSrDGsgMP1B28c5XU39z7uPOElzyUtH0xideZe9FZqQwxdGadVq9gHRw4s8FnR3KPsip1lyKtqbSXOfocWFQl2YnlbZufKcIKumIf6sjEoHawl7C8rZeYqoIGIVRBGcBh4dmaoDOZNGuIm29mLuN5J6lEp705QUJ41+6iBH+0k2zOtjCo/iK0/yGZv2IPRzIEYeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HivbUaM1Uo0KUDrQX+KQZ7hl13PDZNmdXUW6SAdFYo=;
 b=dh/QNK8rINy2NVXETRVXdP5bYiW45kB5vOCe2Y2WplAZV3PxJcRA9yKnzsELIXergDGa5wnD4xYt/k4VMWqBuhGMEYxoW0pWc0OpY4pTKNZlaVdfFqShU5IVmjPpINTdUR4l16bJbwh7LhldcC6DiS+JVkWPfzO/KnP9AREdcKs=
Received: from DS7PR05CA0093.namprd05.prod.outlook.com (2603:10b6:8:56::17) by
 SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 10:32:13 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::15) by DS7PR05CA0093.outlook.office365.com
 (2603:10b6:8:56::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.16 via Frontend
 Transport; Tue, 16 May 2023 10:32:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 10:32:13 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 05:32:10 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 03:31:41 -0700
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 16 May 2023 05:31:38 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <--to=broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Mastan.Katragadda@amd.com>,
        <Arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Syed Saba Kareem" <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 9/9] ASoC: amd: ps: Add soundwire specific checks in pci driver in pm ops.
Date:   Tue, 16 May 2023 16:05:43 +0530
Message-ID: <20230516103543.2515097-10-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516103543.2515097-1-Vijendar.Mukunda@amd.com>
References: <20230516103543.2515097-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT040:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: a5dfcd07-c23c-4f51-0293-08db55f8d011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2pk2VsHOxmDPKEYp8gtPSa2aONIRXq3KuatvCGwcV+4BJ0j1fI4Fh1GBmKSbFrCp3S8QkjvyEd32BpVw0fsV794kvRBdPxBXfSfpxzwiK2GIRAppRxoI4HAUH3VIsrT+6+ZdQUC3YsBNKTKfEBO3TQKxEDuUCum3lM+RoX0I2mc/407PVIMNlbmjJVM34N279HiBsXV1Mo1VaAkn6fPZC3lhcW6Rp1M2b6S0zMKtVRn3RgfT3IUVKnEwtX5uQTZF6D31uz2YVRD3oN9aQN4b2hw1sbp7ucFBB09d3yp/l8MLre6kjDNt/XpgUhPTp45M/WaFFyP/J9+/sGlSEo/HwPPLGiQd7LGhZIkmk7u4E7BBIhc9blzuu8+7qJCzIrY7ntC0ATkeG3h1ogohvZeWM7QL/g8vpnkmFVQTiTXrjzjpIs3vCdLLUALUbFkilbftioLnd/As9qv+fIzfSVEGE4ZHsbpARI9pp9a/aCAdLORXh5XOEkh9AS5cz/tUduplfzWnCpYcqRIDqdeXOYIGeEBww5F62hxN3aXIvhzLvhi3gnefQr7qy20vWoH7BGatj+c5304DqVJz7WrtnXAk5gUEnMA/IodMG+BdG0CPE93L4UG2so29JQNDSkZ0d9GeTSwde915ZqiVIu9wth2Hu01jIyyUq5S2XziQ9Pf2J4vmfpveQrLN+Y/7RqDKffoqzZt5dXePaB6T70h4cX+ii5VUp9UiR3nv0oiPDjQhB+SPaKvvJMWLO8dyehIcSqSvwcI9Mv1MrGWNV8f3y8Dcog==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(70586007)(41300700001)(70206006)(4326008)(47076005)(82740400003)(8676002)(6666004)(7696005)(82310400005)(1076003)(26005)(356005)(336012)(426003)(81166007)(316002)(2616005)(5660300002)(83380400001)(8936002)(2906002)(54906003)(86362001)(478600001)(40460700003)(186003)(40480700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 10:32:13.3302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5dfcd07-c23c-4f51-0293-08db55f8d011
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Soundwire manager supports different power modes.
In case of Soundwire Power off Mode, ACP pci parent driver
should invoke acp de-init and init sequence during suspend/resume
callbacks.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/pci-ps.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index ba8ec8442a6e..6d688821b3c4 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -656,10 +656,15 @@ static int snd_acp63_probe(struct pci_dev *pci,
 static int __maybe_unused snd_acp63_suspend(struct device *dev)
 {
 	struct acp63_dev_data *adata;
-	int ret;
+	int ret = 0;
 
 	adata = dev_get_drvdata(dev);
-	ret = acp63_deinit(adata->acp63_base, dev);
+	if (adata->pdev_mask & ACP63_SDW_DEV_MASK) {
+		if (adata->acp_reset)
+			ret = acp63_deinit(adata->acp63_base, dev);
+	} else {
+		ret = acp63_deinit(adata->acp63_base, dev);
+	}
 	if (ret)
 		dev_err(dev, "ACP de-init failed\n");
 	return ret;
@@ -668,10 +673,15 @@ static int __maybe_unused snd_acp63_suspend(struct device *dev)
 static int __maybe_unused snd_acp63_resume(struct device *dev)
 {
 	struct acp63_dev_data *adata;
-	int ret;
+	int ret = 0;
 
 	adata = dev_get_drvdata(dev);
-	ret = acp63_init(adata->acp63_base, dev);
+	if (adata->pdev_mask & ACP63_SDW_DEV_MASK) {
+		if (adata->acp_reset)
+			ret = acp63_init(adata->acp63_base, dev);
+	} else {
+		ret = acp63_init(adata->acp63_base, dev);
+	}
 	if (ret)
 		dev_err(dev, "ACP init failed\n");
 	return ret;
-- 
2.34.1

