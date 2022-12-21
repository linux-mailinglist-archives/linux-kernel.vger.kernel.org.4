Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A39653516
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiLUR0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbiLUR0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:26:43 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD3563FF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:26:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGBwRJcAW6EtVR4lWq5S4T11n2kKJGdsKwZl0evc48M0oMGlgyEXh1SPJjIl3llgdwcrpTWKd4881V4ym9L5uijL89e/YkWY/OGuZansvENlFfWsVDtLlBLmm86T8c3/DWY0kXEr9O1rnmOYtaBsnDVP+7ffAScIrRXCaI49jLRJ1Xki0TGDuaUb7gTu1N0z7IHOwd5Acai2yRDg2OxGhhLySAXyZjjPWMahzMvEUPIWvunLukJK9RB82U3axxqxvpvHZFbQohL6mCCxAca4AhTBPJzsFTjZq7JL9W2yZzpYE9T1K6Eodnwkg/PaxOWOT/Jkj1C34A8VWs8JRLRUNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5l4KBL+oE/e3tAtN6J6KA2TBGDjfJusjUQrFLnvb6rs=;
 b=hrMFAO9vHg5+PtieWgsiYwsKNuMtNmpQG1mVDkwJobeto0jO0htsusXnDlQsaaRT2I9rgW30oQEOudBZualW8akd+wwVbDL45xVOk/mOGo9/+p9xFWRqvqAJj+hvX0v17u6wSEYXOZbV6oHEmt1yoNfwSs6a2XLdUi2ueOvoibQHqwV2LTxRHOcDqA+cQyfCKagXkCys8hLlwt2KPg140/EZ+05e23qaOMO0akKEA4RbpTsxOUnFlqcFTwM+0ImN+1ETzp3eTNrl79kA+XGlGa3/H+KJs1xup9Lecinc+ZLO5qOfaPnfOp7UGaeWxJAIwOQ+DonlzguO9yJp3U9tfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5l4KBL+oE/e3tAtN6J6KA2TBGDjfJusjUQrFLnvb6rs=;
 b=4ctHqtsNzeFU5huuQ53x5IHvRVzjEHmZqPwCgUyU5nKjrhgAPCHzy6rNcS6n8NtarBVPmjTWPcs0v2TEQ4flssKj0D8n2T5M1y4yxLv8jL7IWl0B8ammB3BYJIgmiO7WQl4ypTTSL8ZmwRTf22oUEyqRwEXVya85KHTgGlo4fHQ=
Received: from BN9PR03CA0765.namprd03.prod.outlook.com (2603:10b6:408:13a::20)
 by SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 17:26:35 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::8b) by BN9PR03CA0765.outlook.office365.com
 (2603:10b6:408:13a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Wed, 21 Dec 2022 17:26:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.10 via Frontend Transport; Wed, 21 Dec 2022 17:26:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 21 Dec
 2022 11:26:34 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 21 Dec 2022 11:26:31 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 4/4] ASoC: amd: ps: move irq handler registration
Date:   Wed, 21 Dec 2022 22:58:51 +0530
Message-ID: <20221221172855.1618766-4-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221221172855.1618766-1-Vijendar.Mukunda@amd.com>
References: <20221221172855.1618766-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|SA3PR12MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d63ac8-4029-4171-89fd-08dae378825f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EXYKxy6BtTkriklTWoiNPRylLSu5OVjwBGGEPQmUzEKBqc/QXK9uY7RFh2ciRRMNEN01+ExAiho+RU0v4jdsot9K5vzNxc2eljG5IbuBj1qArL6P9Q1vVY/bY/6zoG1YQw6uLwfhwnGCJgxfXpdqziO74Jh6zQuf7MOrRRAqw4gPkhosWe/CJ1FUrA0cEoxkHTrwpRMSQNCD2ZQkzLHs87dJKMq+T5UVEbX5PFOSHmYCPVExN0B9FV19qEAQY9BW8QtFsXfCFToPhmpaMp+6AICqhamCwiR/8iQFXZI58ZsH7kMxiC3wjbYVj+b6/ZETwO52qpSlVqrC8fPO90E/3lfOA9aB5Q83Kx+ku3Ncu3wM5S6PfPuNvUE5FA1isWDXqCsibY1nIirxAQmrKHv+sngMqkmjSzWhJ6rLuJeCp8Vn4AWFBsrRGMLfmH4j7jlzC+gOf4ERmjQwvk9FHeNWl0qgPa5j+21cXq97q3vJF/YblGn1+P1/TxrKB932hQooTAs2AQSBVmOP31TryDnPsMRRE/CTKGaReN7UmX+dNO8YkpVMdyb/MsmgrYFkw+dXoIFbR6zy1vCpVnEHHJ6w5e1Bc1gIYNy0ID+6ASCtb21N8a2qieaK61bULnxQhfuUyCNxefI5DZ6VljanMR9tVqQUKRzFSKvMtJA/rfECvFRXYhOc85dW8jXoehmqW8yLWCQZeRa1NVnKwpYGmT99Sg3xWsCeoyViyDrp/YzijQc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(478600001)(7696005)(6666004)(2906002)(4326008)(186003)(47076005)(426003)(40460700003)(36756003)(2616005)(83380400001)(1076003)(8676002)(82310400005)(5660300002)(82740400003)(36860700001)(26005)(54906003)(8936002)(110136005)(336012)(316002)(70206006)(70586007)(356005)(86362001)(40480700001)(41300700001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 17:26:34.8757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d63ac8-4029-4171-89fd-08dae378825f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move irq handler registration prior to platform device creation logic.
This will avoid irq handling missing scenario when platform device
raise interrrupts during it's probe sequence.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/pci-ps.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 4553e81da164..401cfd0036be 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -286,6 +286,12 @@ static int snd_acp63_probe(struct pci_dev *pci,
 	ret = acp63_init(adata->acp63_base, &pci->dev);
 	if (ret)
 		goto release_regions;
+	ret = devm_request_irq(&pci->dev, pci->irq, acp63_irq_handler,
+			       irqflags, "ACP_PCI_IRQ", adata);
+	if (ret) {
+		dev_err(&pci->dev, "ACP PCI IRQ request failed\n");
+		goto de_init;
+	}
 	val = acp63_readl(adata->acp63_base + ACP_PIN_CONFIG);
 	get_acp63_device_config(val, pci, adata);
 	ret = create_acp63_platform_devs(pci, adata, addr);
@@ -293,13 +299,6 @@ static int snd_acp63_probe(struct pci_dev *pci,
 		dev_err(&pci->dev, "ACP platform devices creation failed\n");
 		goto de_init;
 	}
-	ret = devm_request_irq(&pci->dev, pci->irq, acp63_irq_handler,
-			       irqflags, "ACP_PCI_IRQ", adata);
-	if (ret) {
-		dev_err(&pci->dev, "ACP PCI IRQ request failed\n");
-		goto de_init;
-	}
-
 	pm_runtime_set_autosuspend_delay(&pci->dev, ACP_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(&pci->dev);
 	pm_runtime_put_noidle(&pci->dev);
-- 
2.34.1

