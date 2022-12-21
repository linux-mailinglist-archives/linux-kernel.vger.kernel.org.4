Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D00565302A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 12:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiLULYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 06:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbiLULYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 06:24:03 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E283D2CD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 03:23:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrFJmvXMKs5k/GRPYpUZP6MKX902/SW1kAhleM56Ea3/yQ32U5IjpF9WzgSMno9W62TnipLebWBwRvluODEsUdNoFx53Jc+XSZPVmd1j3EwHZDHlx/bQATj896AN1/cKQTRt6N6ncQfx6puBXtEuIzOG341ozYX7whxe4lZrxXv8wwyc1QwVk7D2xqF4oHk4FbPda0lb4k+UBKqPfwctb92JZPJ9UdY+Ux6alPM9ldchNkpXFxw4U1waK/K4YCy7eNJ8d+ia8RjdUNB+/BrAP+YKkXhGqtC3fiikRIPYDQAM1IVLmmCLADK+gTMyRCIGF1yDhOxI2lcNBajP2B/CTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJhMraZG3QiDMzz8izQF4l8reSkpJsTuXfPMT1boYMQ=;
 b=fpnljTUE9uURjlJpHKxhzylWxOwwN9tOTcJqp28XI/SYfNyRcMKiR+KActftL0X05GWXO9FH4SyMGPOxbFGPfOPpuCpEauP75WFZC9lmpLShKVKfrv31H4a/UNCC4A+xhGPjV8Ukx6hUmb9isjyLg1noIQg0Qzp4emW12uocLFMGrnUPaBqmDo4u8OqBtRYp0vYL+gQHIL56mTQlYLdbo8dXy/scxyt8Ny/zGNxtJ1RiM1oIxNqoarTPeEbk8XvqeCkYWQ8lXgZo3HGclAOdsNpHhpnx1x4CO2+YahIcm5XSWWSkrzr3G9RbzrfzrO6m86WFQ6G/GNGHRZOusXCerQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJhMraZG3QiDMzz8izQF4l8reSkpJsTuXfPMT1boYMQ=;
 b=nxUUa307sA919AX0y06KAInqBPMgCMTwCrGYqPaotNGV7wiMkzIFQGbF4/Mq2+gSuk1lWebGSqVc8u1phIcvP/zBOqz95W1ZJe2p1XIsRafuz5n0NKKGOMmKEn3XtOC2fbub+1d7zWqczfp3KemjvyJYoU3rDX9QWUrKDqqed/o=
Received: from MW3PR06CA0012.namprd06.prod.outlook.com (2603:10b6:303:2a::17)
 by DS7PR12MB5934.namprd12.prod.outlook.com (2603:10b6:8:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 11:23:57 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::b3) by MW3PR06CA0012.outlook.office365.com
 (2603:10b6:303:2a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.17 via Frontend
 Transport; Wed, 21 Dec 2022 11:23:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.6 via Frontend Transport; Wed, 21 Dec 2022 11:23:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 21 Dec
 2022 05:23:55 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 21 Dec
 2022 05:23:54 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 21 Dec 2022 05:23:51 -0600
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
Subject: [PATCH v2 4/4] ASoC: amd: ps: move irq handler registration
Date:   Wed, 21 Dec 2022 16:56:06 +0530
Message-ID: <20221221112611.1373278-4-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221221112611.1373278-1-Vijendar.Mukunda@amd.com>
References: <20221221112611.1373278-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|DS7PR12MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d5eb0d-7f09-4e13-9712-08dae345d9e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V4Uy1ucvuwMLvydiDtXbmFmfvk9ShY7TKdl+nRogKU0kdjpQmcSJW9PDUxKVCefaLDBolxuHyrgei8UJ9f0J0R/BDavE1o4YDZi/kzi6n7v4W3xX1mCwHbNpJwxBU/8dPUmD2ggGTsJdSozTZO27T/27aNXnMlhDgqMc4vXQMP3mxBniafXV+yHQJultmIyKpN5V5FYMd/KPKbENMJztpBGAlUOhSO/AOo2UWKaXYcRJBNR8DKPgCUJodkI0DhiYYnA2hi7KoSYrfzUzV0tngSedClVG1xE2ZVMjAT14Jj809XPpJNoFEEduwniCeipB1Xt6rbYa1gXdXXcakIdYr5hOX2CLLYjPtH+coeCNU6a6+Q0Nd6/Bu+JPTDGnJAg1Vy63hycqKgGBM227o+lYVYTo6SXX5HX4Jvx9sDAuB7j9qgtnAi5fmWgUNiDhSErqArM7lAyMFSGlOaGpoomSJpLId1jzbid9TO2+yqGQ4xBsD7FKDoSEV6xkiTCgePDvDiC2rQc9JE/p8C2/Nj+vNjQtWSR84AXNgAEH0AycCWw8KmUka9ApDMWyarfzRO4tmuaFH3hW6XiNk6W9gygHdR4CvnlA9r0lOvlWMDvzLqovtQPovXLiUw7X4VNyq16th3rqSiB0gagPVwSv2aQLW2RejhjTKteAkCBMD/OkFJb+dgw2MPkXF9GYt5e42FEEQ66tbukLfe0Sn0ZSKH6PxwPrEFEBjn8vtFHPosm5QCg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199015)(46966006)(36840700001)(40470700004)(36756003)(82310400005)(70586007)(186003)(26005)(336012)(4326008)(41300700001)(2616005)(478600001)(1076003)(8676002)(2906002)(86362001)(54906003)(40480700001)(83380400001)(47076005)(8936002)(5660300002)(70206006)(7696005)(81166007)(6666004)(36860700001)(426003)(110136005)(316002)(40460700003)(82740400003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 11:23:57.2891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d5eb0d-7f09-4e13-9712-08dae345d9e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5934
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
index b3628fbfdafd..4ec03e576376 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -285,6 +285,12 @@ static int snd_acp63_probe(struct pci_dev *pci,
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
@@ -292,13 +298,6 @@ static int snd_acp63_probe(struct pci_dev *pci,
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

