Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3745D653515
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiLUR0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiLUR0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:26:30 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A633963FF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:26:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVelmiWlWoqOYEBXAGCaQQCQbFsUxlZ1AxPlwPJYvnJQbtZoQGuAF0+doNCc5lz8x5S7RB9DKX13SmKk/Z55g6J02w+yll7pC5lhxpronRjYq1yplXZ7FZpfhi1WI/jlHzEavJTCgYdv/gP02NJY+StB6385OPO+vWJA9Th8cyjV6WnuxYaeJee+2hO/+fNvGdTgVTVinzbdZCsv/VbWqlM98mxlzWvX33DZlgTbuDox5RP6x0cfXzXru/m034GS19DrVjjZvhjnDzV7mqVqd9jPMOCUPc/RxxsvEIjrXY45+zl4LsPQVcI1LOhCb2x6auAJw1FXQp3BbuL1+r8Row==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5z00SgJc1Cu9y8djs0JrTonvqMUDxTFxkvm0puBZ4R8=;
 b=T/hUV2YPk8XaDfAmIdDYXg69s6iRbmHAQc29DLtZZAnSLAQxacbdWIQfVazIiGuhY9OfOxGQnk+2Mxv7edzA6H28wlmcsicoCzUafBfku+/mVeGe3SpRgPdGwd9qgiWcsejQOoY5ymyp/0Zb7YbReD9RmhEpvHEgwU89SZhEKwAXmB1+iYBDu/rD0IseuUGs2jcwnNDaVx9qD/FzOlmR0GNxkozBvZ6TbPrGc6dZ/gZZkR2D0+/Lfkj5uDJmf3uanm9Fa1YgHFUre+19iSoiRmjjtnfKEhMRn7ix6Sz0ywFwB0ZIWDU+ZeWOpnTboxn0rGC9U5dzTrEEju23FkUt1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5z00SgJc1Cu9y8djs0JrTonvqMUDxTFxkvm0puBZ4R8=;
 b=a9h+m/I2pj4Z3/d75IChcFcRvzlhM5zAOACt6ajxaF6nEDe67kvPaxYlwHDUsQSBA3GEveioe+GvnWpyAQq1QdakBL2a4G1N2AspMHz4wqiDK7WsvUqP6Twr8r/f0lnGm0sWByAN8wPn1uariQwB220h66gPjfquoxh2v92XgpE=
Received: from MW4PR04CA0259.namprd04.prod.outlook.com (2603:10b6:303:88::24)
 by BL3PR12MB6474.namprd12.prod.outlook.com (2603:10b6:208:3ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 17:26:25 +0000
Received: from CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::91) by MW4PR04CA0259.outlook.office365.com
 (2603:10b6:303:88::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Wed, 21 Dec 2022 17:26:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT093.mail.protection.outlook.com (10.13.175.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.10 via Frontend Transport; Wed, 21 Dec 2022 17:26:25 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 21 Dec
 2022 11:26:24 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 21 Dec
 2022 09:26:24 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 21 Dec 2022 11:26:21 -0600
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
Subject: [PATCH V2 2/4] ASoC: amd: ps: refactor platform device creation logic
Date:   Wed, 21 Dec 2022 22:58:49 +0530
Message-ID: <20221221172855.1618766-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221221172855.1618766-1-Vijendar.Mukunda@amd.com>
References: <20221221172855.1618766-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT093:EE_|BL3PR12MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cce849b-6579-484a-a836-08dae3787c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5H2GQzCpLWuSfmw2aS0gs9RtJdmmY44jy9ONSlccilQ2QURlxqiIzMRhv7OxWe2b9OyTXaWdZlAVO/TDCxkAZzIgkZ9jV8/lFBliXxZ/grNyzKY+x9JZYKpzbJGMQdlgykH8u557d+siiSynVwKeqFNMorr15qdk4aatL/41QlZyLn3OQRhIe6wAqR5f3S7d1KhsY/tIzr6zieaDmxL3KVEgkFMxmj8XJUiAO6TAJSUAFZOALXHr3NpB19YUTfHPiGJJ+Y0ZHEV6Ax8KHsnVjT6+86Gv02A+fdK1f4rP/4RCBlAwuRY50OdLyUVvRJ02oM0jOI7sJD4UzKI3IeplVAghV36fxXF2v2PYZe97wbQvY/2bt0zSsFmxDIa62wyjDNd1wTt9qldZQ71bEX0cVygHtxWTSWM1a2s+DxN5B1LW5MPH+IsyMTU6bSQEOQpJalyNJm3UcgrfMNcOG484hwQzOnOoWbWOgkUDTpthNCoN/Vl7v0qGVFEgg4JsWTGWECk0K88+FwX0W3tQgPbQXLMIMyrCyo2GUVqM3w82ri3GMBMv+zaWIMwyWVEQK1MdYvTDaVD1aH4HOo6i8awXo9LRh2DQOy1Bkcl7f/SVi+/46ZMf4Rh2SOu96EPsMrPrmRdwF4gQcrwzi/7OKndtrLTwcSn0wbWPZS0f2ZzENnQWtFxUUZ+jsKrYEEn9k42KGJba6tfFF8zp6NxP13HH22ZV7wjq0IrQiH3oYpiDJ1U=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(478600001)(54906003)(41300700001)(8936002)(6666004)(110136005)(7696005)(36756003)(336012)(26005)(70206006)(70586007)(186003)(8676002)(4326008)(5660300002)(82740400003)(81166007)(47076005)(2906002)(82310400005)(2616005)(356005)(36860700001)(316002)(40480700001)(40460700003)(1076003)(426003)(83380400001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 17:26:25.1137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cce849b-6579-484a-a836-08dae3787c9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6474
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor platform device creation implementation.
Based on platform dev count and pdev mask create platform devices.
Use common API to fill platform dev information.
Use pdev count variable in remove callback for unregistering
platform devices.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h  |   2 +-
 sound/soc/amd/ps/pci-ps.c | 168 ++++++++++++++++++++------------------
 2 files changed, 89 insertions(+), 81 deletions(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index b015e845e5fa..8f024cb309c9 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -11,7 +11,6 @@
 #define ACP63_REG_START		0x1240000
 #define ACP63_REG_END		0x1250200
 #define ACP63_DEVS		3
-#define ACP63_PDM_MODE		1
 
 #define ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK	0x00010001
 #define ACP_PGFSM_CNTL_POWER_ON_MASK	1
@@ -109,4 +108,5 @@ struct acp63_dev_data {
 	struct platform_device *pdev[ACP63_DEVS];
 	u16 pdev_mask;
 	u16 pdev_count;
+	u16 pdm_dev_index;
 };
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 86af94f6f06e..8ae7bdfb0e8c 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -165,17 +165,86 @@ static void get_acp63_device_config(u32 config, struct pci_dev *pci,
 	}
 }
 
+void acp63_fill_platform_dev_info(struct platform_device_info *pdevinfo, struct device *parent,
+				  struct fwnode_handle *fw_node, char *name, unsigned int id,
+				  const struct resource *res, unsigned int num_res,
+				  const void *data, size_t size_data)
+{
+	pdevinfo->name = name;
+	pdevinfo->id = id;
+	pdevinfo->parent = parent;
+	pdevinfo->num_res = num_res;
+	pdevinfo->res = res;
+	pdevinfo->data = data;
+	pdevinfo->size_data = size_data;
+	pdevinfo->fwnode = fw_node;
+}
+
+static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data *adata, u32 addr)
+{
+	struct platform_device_info pdevinfo[ACP63_DEVS];
+	struct device *parent;
+	int index;
+	int ret;
+
+	parent = &pci->dev;
+	dev_dbg(&pci->dev,
+		"%s pdev_mask:0x%x pdev_count:0x%x\n", __func__, adata->pdev_mask,
+		adata->pdev_count);
+	if (adata->pdev_mask) {
+		adata->res = devm_kzalloc(&pci->dev, sizeof(struct resource), GFP_KERNEL);
+		if (!adata->res) {
+			ret = -ENOMEM;
+			goto de_init;
+		}
+		adata->res->flags = IORESOURCE_MEM;
+		adata->res->start = addr;
+		adata->res->end = addr + (ACP63_REG_END - ACP63_REG_START);
+		memset(&pdevinfo, 0, sizeof(pdevinfo));
+	}
+
+	switch (adata->pdev_mask) {
+	case ACP63_PDM_DEV_MASK:
+		adata->pdm_dev_index  = 0;
+		acp63_fill_platform_dev_info(&pdevinfo[0], parent, NULL, "acp_ps_pdm_dma",
+					     0, adata->res, 1, NULL, 0);
+		acp63_fill_platform_dev_info(&pdevinfo[1], parent, NULL, "dmic-codec",
+					     0, NULL, 0, NULL, 0);
+		acp63_fill_platform_dev_info(&pdevinfo[2], parent, NULL, "acp_ps_mach",
+					     0, NULL, 0, NULL, 0);
+		break;
+	default:
+		dev_dbg(&pci->dev, "No PDM devices found\n");
+		goto de_init;
+	}
+
+	for (index = 0; index < adata->pdev_count; index++) {
+		adata->pdev[index] = platform_device_register_full(&pdevinfo[index]);
+		if (IS_ERR(adata->pdev[index])) {
+			dev_err(&pci->dev,
+				"cannot register %s device\n", pdevinfo[index].name);
+			ret = PTR_ERR(adata->pdev[index]);
+			goto unregister_devs;
+		}
+	}
+	return 0;
+unregister_devs:
+	for (--index; index >= 0; index--)
+		platform_device_unregister(adata->pdev[index]);
+de_init:
+	if (acp63_deinit(adata->acp63_base, &pci->dev))
+		dev_err(&pci->dev, "ACP de-init failed\n");
+	return ret;
+}
+
 static int snd_acp63_probe(struct pci_dev *pci,
 			   const struct pci_device_id *pci_id)
 {
 	struct acp63_dev_data *adata;
-	struct platform_device_info pdevinfo[ACP63_DEVS];
-	int index, ret;
-	int val = 0x00;
-	struct acpi_device *adev;
-	const union acpi_object *obj;
 	u32 addr;
-	unsigned int irqflags;
+	u32 irqflags;
+	int val;
+	int ret;
 
 	irqflags = IRQF_SHARED;
 	/* Pink Sardine device check */
@@ -217,82 +286,23 @@ static int snd_acp63_probe(struct pci_dev *pci,
 		goto release_regions;
 	val = acp63_readl(adata->acp63_base + ACP_PIN_CONFIG);
 	get_acp63_device_config(val, pci, adata);
-	switch (val) {
-	case ACP_CONFIG_0:
-	case ACP_CONFIG_1:
-	case ACP_CONFIG_2:
-	case ACP_CONFIG_3:
-	case ACP_CONFIG_9:
-	case ACP_CONFIG_15:
-		dev_info(&pci->dev, "Audio Mode %d\n", val);
-		break;
-	default:
-
-		/* Checking DMIC hardware*/
-		adev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_DMIC_ADDR, 0);
-
-		if (!adev)
-			break;
-
-		if (!acpi_dev_get_property(adev, "acp-audio-device-type",
-					   ACPI_TYPE_INTEGER, &obj) &&
-					   obj->integer.value == ACP_DMIC_DEV) {
-			adata->res = devm_kzalloc(&pci->dev, sizeof(struct resource), GFP_KERNEL);
-			if (!adata->res) {
-				ret = -ENOMEM;
-				goto de_init;
-			}
-
-			adata->res->name = "acp_iomem";
-			adata->res->flags = IORESOURCE_MEM;
-			adata->res->start = addr;
-			adata->res->end = addr + (ACP63_REG_END - ACP63_REG_START);
-			adata->acp63_audio_mode = ACP63_PDM_MODE;
-
-			memset(&pdevinfo, 0, sizeof(pdevinfo));
-			pdevinfo[0].name = "acp_ps_pdm_dma";
-			pdevinfo[0].id = 0;
-			pdevinfo[0].parent = &pci->dev;
-			pdevinfo[0].num_res = 1;
-			pdevinfo[0].res = adata->res;
-
-			pdevinfo[1].name = "dmic-codec";
-			pdevinfo[1].id = 0;
-			pdevinfo[1].parent = &pci->dev;
-
-			pdevinfo[2].name = "acp_ps_mach";
-			pdevinfo[2].id = 0;
-			pdevinfo[2].parent = &pci->dev;
-
-			for (index = 0; index < ACP63_DEVS; index++) {
-				adata->pdev[index] =
-					platform_device_register_full(&pdevinfo[index]);
-
-				if (IS_ERR(adata->pdev[index])) {
-					dev_err(&pci->dev,
-						"cannot register %s device\n",
-						 pdevinfo[index].name);
-					ret = PTR_ERR(adata->pdev[index]);
-					goto unregister_devs;
-				}
-				ret = devm_request_irq(&pci->dev, pci->irq, acp63_irq_handler,
-						       irqflags, "ACP_PCI_IRQ", adata);
-				if (ret) {
-					dev_err(&pci->dev, "ACP PCI IRQ request failed\n");
-					goto unregister_devs;
-				}
-			}
-		}
-		break;
+	ret = create_acp63_platform_devs(pci, adata, addr);
+	if (ret < 0) {
+		dev_err(&pci->dev, "ACP platform devices creation failed\n");
+		goto de_init;
+	}
+	ret = devm_request_irq(&pci->dev, pci->irq, acp63_irq_handler,
+			       irqflags, "ACP_PCI_IRQ", adata);
+	if (ret) {
+		dev_err(&pci->dev, "ACP PCI IRQ request failed\n");
+		goto de_init;
 	}
+
 	pm_runtime_set_autosuspend_delay(&pci->dev, ACP_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(&pci->dev);
 	pm_runtime_put_noidle(&pci->dev);
 	pm_runtime_allow(&pci->dev);
 	return 0;
-unregister_devs:
-	for (--index; index >= 0; index--)
-		platform_device_unregister(adata->pdev[index]);
 de_init:
 	if (acp63_deinit(adata->acp63_base, &pci->dev))
 		dev_err(&pci->dev, "ACP de-init failed\n");
@@ -339,10 +349,8 @@ static void snd_acp63_remove(struct pci_dev *pci)
 	int ret, index;
 
 	adata = pci_get_drvdata(pci);
-	if (adata->acp63_audio_mode == ACP63_PDM_MODE) {
-		for (index = 0; index < ACP63_DEVS; index++)
-			platform_device_unregister(adata->pdev[index]);
-	}
+	for (index = 0; index < adata->pdev_count; index++)
+		platform_device_unregister(adata->pdev[index]);
 	ret = acp63_deinit(adata->acp63_base, &pci->dev);
 	if (ret)
 		dev_err(&pci->dev, "ACP de-init failed\n");
-- 
2.34.1

