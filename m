Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1846704AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjEPKcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjEPKca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:32:30 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB82A5B9D
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:31:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7NJ9YNwSIrLwE7IEjru649AsY9X9ZnoZ926/v7TJWRrxLrQH2bmirgfu70ea8GCvcb3r1NUUJb22zx7vmVJYqsfe8JFZymxfHl3SAM19STAwjF5DpUQ3Nzeo6EZo8tXEv1B+zcnsBOdCEYW0iLyfl5ESaNGaDZSQ2mwVMqIHCagCEaU8RQ4weqK3K1cvFSDAEq8l7o/j5b+wwCdNJlm1rHx/Psgb2HlUDN6R4lyA/ZNz95R2js7reZIzE3ryEHheT8QmmdeQxcdUusrY4N1jueTAfd0l+pMr6Xur+OVQLMuu0gyB8Rpaq7abpWCV4e4psZfwhGfQsE4eqhAr404gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLTIdZadOuQmZoq2TptErLnusIqCuh1Be7Q5Ux7zPZg=;
 b=DGeifQd0PgedWcnqhlv9HqEP6y4FfGKaJwORWY/62ciKYDaPS5gZ/r4lE4zOTgK0JOTK4MNuFf9NvpLCwVhsVV4NvEbFswSu9UVWvHClarqhFK0dwlpfBp6qvN56UAXtMio2Cj77dmV7yKL69V1HBtwUMcbIBJeWDlqM+IYBk5iLbadvDK7Y3FpD+Kt1BcprpmVNnKwmADACfkSSeV345gN9Qk3kFqNyzyQ3MBFgbJZhRT4djfqZ4QcEwFjV5nBZ+ViKcS/Fu8Htdruy5n1M+m3U7bnGq4Kvg3aHLGpd6T/DCBCovhpX5kQVqz6BEyhko/zxTt+hIyBIeyu5+X3XqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLTIdZadOuQmZoq2TptErLnusIqCuh1Be7Q5Ux7zPZg=;
 b=NHxZnxK1vIYRmEIMUcnZxLfjp5WiWysQTNetRHgoaVcYJu/04EEN1x0A0ElzrueADnZ6v1yldqVfRypGnu6lqA86kpiMroTf6snRzJthAqRdTnqzds7wUUacAWMUZZQEaiQGcmd9VTWcHb9TIC+pZGA1SjwLQTFEFOo/Krqeo8s=
Received: from DM6PR08CA0026.namprd08.prod.outlook.com (2603:10b6:5:80::39) by
 MW4PR12MB7031.namprd12.prod.outlook.com (2603:10b6:303:1ef::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.23; Tue, 16 May 2023 10:30:46 +0000
Received: from DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::e6) by DM6PR08CA0026.outlook.office365.com
 (2603:10b6:5:80::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 10:30:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT115.mail.protection.outlook.com (10.13.173.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 10:30:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 05:30:44 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 05:30:39 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 16 May 2023 05:30:35 -0500
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
        Mario Limonciello <mario.limonciello@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/9] ASoC: amd: ps: create platform devices based on acp config
Date:   Tue, 16 May 2023 16:05:35 +0530
Message-ID: <20230516103543.2515097-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516103543.2515097-1-Vijendar.Mukunda@amd.com>
References: <20230516103543.2515097-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT115:EE_|MW4PR12MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e8b9020-578f-4801-5f40-08db55f89b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XsFweQyupabOZTT8X67a1wiwC5D2b0qKMzDQljnEE7/Rr3UEu/zMaQzPEakcZFAKcVZh+Sxm9qKPaaJaqcjLDJLNzSYKLBwpZIO2xgSKt2xCMN6B3L86g2nknBCZEmmuiol3KcwELSLmUkCm34ISqVdwFu6c/0eibxWx2WhQl9wl4jiY+xwlNtNoEq9b0AlXrurOqS4lALbmcxDXRspb8azlfTHaXu9LFKEBXT3m7hcbBC/VBTUvC8EFmBXWdM3wbY1fDmMqGu+2U469wdclvp1Fwvs4TsudufR02/Avm99suJC8poy7Sz4RrMl6Y9AblDeVyuaYpYNUOLLBFswUx5vZKXb11n/Pren/ZkFVOmt0zmaUp3Slu9Gn5Wt+ikM/NDUwqA+/1iPIDquB1d56JIpLRwv068lo7bxPKLOiDSHpWt+l0e6YYj9N2GMnpKsuc+ImTwh/F5OrPklMmELmNt0CzEPS1Lp/pasWWpGjB4Du7Ew6/Z2xhi+SCNS6gk4sygAI63mMHWAdd4H5yGjA3GWH03pBzFVKBk5IWRQdBzFAvDyBYfEoAAYwuaeUNa48H6s/fTLx2XbXfzdhYj0qAcJGtcOV38p8BScQ2cBg2bXEk/FThTpb1cJbkcHX/wGIsPB8PQ306hM2GtZKf0nUaw7WqgWMAWJZ2Mk0Ade7o2Hlr5t1qmscpuJ0LlG0tYKprBHzsZ1vUEpjTJQtDXLrr96SClk6bNG63QlF/knizmoNU4SIflywsQ41yRmpmQ9VWhIfskf0bdCl4cjqZuOa0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(46966006)(40470700004)(36840700001)(2616005)(356005)(5660300002)(82740400003)(81166007)(336012)(40480700001)(26005)(8676002)(186003)(426003)(47076005)(2906002)(30864003)(36860700001)(1076003)(8936002)(478600001)(40460700003)(36756003)(7696005)(54906003)(41300700001)(316002)(70586007)(4326008)(83380400001)(86362001)(70206006)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 10:30:45.1251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8b9020-578f-4801-5f40-08db55f89b80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7031
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

Create platform devices for Soundwire Manager instances and
PDM controller based on ACP pin config selection
and ACPI fw handle for pink sardine platform.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h  |  43 ++++++-
 sound/soc/amd/ps/pci-ps.c | 250 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 280 insertions(+), 13 deletions(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 2f94448102d0..f27f71116598 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -10,7 +10,7 @@
 #define ACP_DEVICE_ID 0x15E2
 #define ACP63_REG_START		0x1240000
 #define ACP63_REG_END		0x1250200
-#define ACP63_DEVS		3
+#define ACP63_DEVS		5
 
 #define ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK	0x00010001
 #define ACP_PGFSM_CNTL_POWER_ON_MASK	1
@@ -55,8 +55,14 @@
 
 #define ACP63_DMIC_ADDR		2
 #define ACP63_PDM_MODE_DEVS		3
-#define ACP63_PDM_DEV_MASK		1
 #define ACP_DMIC_DEV	2
+#define ACP63_SDW0_MODE_DEVS		2
+#define ACP63_SDW0_SDW1_MODE_DEVS	3
+#define ACP63_SDW0_PDM_MODE_DEVS	4
+#define ACP63_SDW0_SDW1_PDM_MODE_DEVS   5
+#define ACP63_DMIC_ADDR			2
+#define ACP63_SDW_ADDR			5
+#define AMD_SDW_MAX_MANAGERS		2
 
 /* time in ms for acp timeout */
 #define ACP_TIMEOUT		500
@@ -80,6 +86,12 @@ enum acp_config {
 	ACP_CONFIG_15,
 };
 
+enum acp_pdev_mask {
+	ACP63_PDM_DEV_MASK = 1,
+	ACP63_SDW_DEV_MASK,
+	ACP63_SDW_PDM_DEV_MASK,
+};
+
 struct pdm_stream_instance {
 	u16 num_pages;
 	u16 channels;
@@ -95,14 +107,41 @@ struct pdm_dev_data {
 	struct snd_pcm_substream *capture_stream;
 };
 
+/**
+ * struct acp63_dev_data - acp pci driver context
+ * @acp63_base: acp mmio base
+ * @res: resource
+ * @pdev: child platform device node structures
+ * @acp_lock: used to protect acp common registers
+ * @sdw_fw_node: SoundWire controller fw node handle
+ * @pdev_mask: platform device mask
+ * @pdev_count: platform devices count
+ * @pdm_dev_index: pdm platform device index
+ * @sdw0_dev_index: Soundwire Manager-0 platform device index
+ * @sdw1_dev_index: Soundwire Manager-1 platform device index
+ * @sdw_dma_dev_index: Soundwire DMA controller platform device index
+ * @is_dmic_dev: flag set to true if DMIC device exists
+ * @is_sdw_dev: flag set to true if Soundwire manager devices exists
+ * @acp_reset: flag set to true when bus reset is applied across all
+ * the active soundwire manager instances
+ */
+
 struct acp63_dev_data {
 	void __iomem *acp63_base;
 	struct resource *res;
 	struct platform_device *pdev[ACP63_DEVS];
 	struct mutex acp_lock; /* protect shared registers */
+	struct fwnode_handle *sdw_fw_node;
 	u16 pdev_mask;
 	u16 pdev_count;
 	u16 pdm_dev_index;
+	u8 sdw_manager_count;
+	u16 sdw0_dev_index;
+	u16 sdw1_dev_index;
+	u16 sdw_dma_dev_index;
+	bool is_dmic_dev;
+	bool is_sdw_dev;
+	bool acp_reset;
 };
 
 int snd_amd_acp_find_config(struct pci_dev *pci);
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index c957718abefc..f3aa08dc05b2 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/pci.h>
+#include <linux/bitops.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/delay.h>
@@ -15,6 +16,7 @@
 #include <sound/pcm_params.h>
 #include <linux/pm_runtime.h>
 #include <linux/iopoll.h>
+#include <linux/soundwire/sdw_amd.h>
 
 #include "acp63.h"
 
@@ -119,12 +121,70 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static void get_acp63_device_config(u32 config, struct pci_dev *pci,
-				    struct acp63_dev_data *acp_data)
+static int sdw_amd_scan_controller(struct device *dev)
+{
+	struct acp63_dev_data *acp_data;
+	struct fwnode_handle *link;
+	char name[32];
+	u32 sdw_manager_bitmap;
+	u8 count = 0;
+	u32 acp_sdw_power_mode = 0;
+	int index;
+	int ret;
+
+	acp_data = dev_get_drvdata(dev);
+	acp_data->acp_reset = true;
+	/* Found controller, find links supported */
+	ret = fwnode_property_read_u32_array((acp_data->sdw_fw_node), "mipi-sdw-manager-list",
+					     &sdw_manager_bitmap, 1);
+
+	if (ret) {
+		dev_err(dev, "Failed to read mipi-sdw-manager-list: %d\n", ret);
+		return -EINVAL;
+	}
+	count = hweight32(sdw_manager_bitmap);
+	/* Check count is within bounds */
+	if (count > AMD_SDW_MAX_MANAGERS) {
+		dev_err(dev, "Manager count %d exceeds max %d\n", count, AMD_SDW_MAX_MANAGERS);
+		return -EINVAL;
+	}
+
+	if (!count) {
+		dev_dbg(dev, "No SoundWire Managers detected\n");
+		return -EINVAL;
+	}
+	dev_dbg(dev, "ACPI reports %d Soundwire Manager devices\n", count);
+	acp_data->sdw_manager_count = count;
+	for (index = 0; index < count; index++) {
+		snprintf(name, sizeof(name), "mipi-sdw-link-%d-subproperties", index);
+		link = fwnode_get_named_child_node(acp_data->sdw_fw_node, name);
+		if (!link) {
+			dev_err(dev, "Manager node %s not found\n", name);
+			return -EIO;
+		}
+
+		fwnode_property_read_u32(link, "amd-sdw-power-mode",
+					 &acp_sdw_power_mode);
+		/*
+		 * when soundwire configuration is selected from acp pin config,
+		 * based on manager instances count, acp init/de-init sequence should be
+		 * executed as part of PM ops only when Bus reset is applied for the active
+		 * soundwire manager instances.
+		 */
+		if (acp_sdw_power_mode != AMD_SDW_POWER_OFF_MODE)
+			acp_data->acp_reset = false;
+	}
+	return 0;
+}
+
+static int get_acp63_device_config(u32 config, struct pci_dev *pci, struct acp63_dev_data *acp_data)
 {
 	struct acpi_device *dmic_dev;
+	struct acpi_device *sdw_dev;
 	const union acpi_object *obj;
 	bool is_dmic_dev = false;
+	bool is_sdw_dev = false;
+	int ret;
 
 	dmic_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_DMIC_ADDR, 0);
 	if (dmic_dev) {
@@ -134,22 +194,83 @@ static void get_acp63_device_config(u32 config, struct pci_dev *pci,
 			is_dmic_dev = true;
 	}
 
+	sdw_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_SDW_ADDR, 0);
+	if (sdw_dev) {
+		acp_data->sdw_fw_node = acpi_fwnode_handle(sdw_dev);
+		ret = sdw_amd_scan_controller(&pci->dev);
+		if (!ret)
+			is_sdw_dev = true;
+	}
+
+	dev_dbg(&pci->dev, "Audio Mode %d\n", config);
 	switch (config) {
-	case ACP_CONFIG_0:
-	case ACP_CONFIG_1:
+	case ACP_CONFIG_4:
+	case ACP_CONFIG_5:
+	case ACP_CONFIG_10:
+	case ACP_CONFIG_11:
+		if (is_dmic_dev) {
+			acp_data->pdev_mask = ACP63_PDM_DEV_MASK;
+			acp_data->pdev_count = ACP63_PDM_MODE_DEVS;
+		}
+		break;
 	case ACP_CONFIG_2:
 	case ACP_CONFIG_3:
-	case ACP_CONFIG_9:
-	case ACP_CONFIG_15:
-		dev_dbg(&pci->dev, "Audio Mode %d\n", config);
+		if (is_sdw_dev) {
+			switch (acp_data->sdw_manager_count) {
+			case 1:
+				acp_data->pdev_mask = ACP63_SDW_DEV_MASK;
+				acp_data->pdev_count = ACP63_SDW0_MODE_DEVS;
+				break;
+			case 2:
+				acp_data->pdev_mask = ACP63_SDW_DEV_MASK;
+				acp_data->pdev_count = ACP63_SDW0_SDW1_MODE_DEVS;
+				break;
+			default:
+				return -EINVAL;
+			}
+		}
 		break;
-	default:
-		if (is_dmic_dev) {
+	case ACP_CONFIG_6:
+	case ACP_CONFIG_7:
+	case ACP_CONFIG_12:
+	case ACP_CONFIG_8:
+	case ACP_CONFIG_13:
+	case ACP_CONFIG_14:
+		if (is_dmic_dev && is_sdw_dev) {
+			switch (acp_data->sdw_manager_count) {
+			case 1:
+				acp_data->pdev_mask = ACP63_SDW_PDM_DEV_MASK;
+				acp_data->pdev_count = ACP63_SDW0_PDM_MODE_DEVS;
+				break;
+			case 2:
+				acp_data->pdev_mask = ACP63_SDW_PDM_DEV_MASK;
+				acp_data->pdev_count = ACP63_SDW0_SDW1_PDM_MODE_DEVS;
+				break;
+			default:
+				return -EINVAL;
+			}
+		} else if (is_dmic_dev) {
 			acp_data->pdev_mask = ACP63_PDM_DEV_MASK;
 			acp_data->pdev_count = ACP63_PDM_MODE_DEVS;
+		} else if (is_sdw_dev) {
+			switch (acp_data->sdw_manager_count) {
+			case 1:
+				acp_data->pdev_mask = ACP63_SDW_DEV_MASK;
+				acp_data->pdev_count = ACP63_SDW0_MODE_DEVS;
+				break;
+			case 2:
+				acp_data->pdev_mask = ACP63_SDW_DEV_MASK;
+				acp_data->pdev_count = ACP63_SDW0_SDW1_MODE_DEVS;
+				break;
+			default:
+				return -EINVAL;
+			}
 		}
 		break;
+	default:
+		break;
 	}
+	return 0;
 }
 
 static void acp63_fill_platform_dev_info(struct platform_device_info *pdevinfo,
@@ -173,6 +294,7 @@ static void acp63_fill_platform_dev_info(struct platform_device_info *pdevinfo,
 
 static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data *adata, u32 addr)
 {
+	struct acp_sdw_pdata *sdw_pdata;
 	struct platform_device_info pdevinfo[ACP63_DEVS];
 	struct device *parent;
 	int index;
@@ -205,8 +327,110 @@ static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data
 		acp63_fill_platform_dev_info(&pdevinfo[2], parent, NULL, "acp_ps_mach",
 					     0, NULL, 0, NULL, 0);
 		break;
+	case ACP63_SDW_DEV_MASK:
+		if (adata->pdev_count == ACP63_SDW0_MODE_DEVS) {
+			sdw_pdata = devm_kzalloc(&pci->dev, sizeof(struct acp_sdw_pdata),
+						 GFP_KERNEL);
+			if (!sdw_pdata) {
+				ret = -ENOMEM;
+				goto de_init;
+			}
+
+			sdw_pdata->instance = 0;
+			sdw_pdata->acp_sdw_lock = &adata->acp_lock;
+			adata->sdw0_dev_index = 0;
+			adata->sdw_dma_dev_index = 1;
+			acp63_fill_platform_dev_info(&pdevinfo[0], parent, adata->sdw_fw_node,
+						     "amd_sdw_manager", 0, adata->res, 1,
+						     sdw_pdata, sizeof(struct acp_sdw_pdata));
+			acp63_fill_platform_dev_info(&pdevinfo[1], parent, NULL, "amd_ps_sdw_dma",
+						     0, adata->res, 1, &adata->acp_lock,
+						     sizeof(adata->acp_lock));
+		} else if (adata->pdev_count == ACP63_SDW0_SDW1_MODE_DEVS) {
+			sdw_pdata = devm_kzalloc(&pci->dev, sizeof(struct acp_sdw_pdata) * 2,
+						 GFP_KERNEL);
+			if (!sdw_pdata) {
+				ret = -ENOMEM;
+				goto de_init;
+			}
+
+			sdw_pdata[0].instance = 0;
+			sdw_pdata[1].instance = 1;
+			sdw_pdata[0].acp_sdw_lock = &adata->acp_lock;
+			sdw_pdata[1].acp_sdw_lock = &adata->acp_lock;
+			sdw_pdata->acp_sdw_lock = &adata->acp_lock;
+			adata->sdw0_dev_index = 0;
+			adata->sdw1_dev_index = 1;
+			adata->sdw_dma_dev_index = 2;
+			acp63_fill_platform_dev_info(&pdevinfo[0], parent, adata->sdw_fw_node,
+						     "amd_sdw_manager", 0, adata->res, 1,
+						     &sdw_pdata[0], sizeof(struct acp_sdw_pdata));
+			acp63_fill_platform_dev_info(&pdevinfo[1], parent, adata->sdw_fw_node,
+						     "amd_sdw_manager", 1, adata->res, 1,
+						     &sdw_pdata[1], sizeof(struct acp_sdw_pdata));
+			acp63_fill_platform_dev_info(&pdevinfo[2], parent, NULL, "amd_ps_sdw_dma",
+						     0, adata->res, 1, &adata->acp_lock,
+						     sizeof(adata->acp_lock));
+		}
+		break;
+	case ACP63_SDW_PDM_DEV_MASK:
+		if (adata->pdev_count == ACP63_SDW0_PDM_MODE_DEVS) {
+			sdw_pdata = devm_kzalloc(&pci->dev, sizeof(struct acp_sdw_pdata),
+						 GFP_KERNEL);
+			if (!sdw_pdata) {
+				ret = -ENOMEM;
+				goto de_init;
+			}
+
+			sdw_pdata->instance = 0;
+			sdw_pdata->acp_sdw_lock = &adata->acp_lock;
+			adata->pdm_dev_index = 0;
+			adata->sdw0_dev_index = 1;
+			adata->sdw_dma_dev_index = 2;
+			acp63_fill_platform_dev_info(&pdevinfo[0], parent, NULL, "acp_ps_pdm_dma",
+						     0, adata->res, 1, &adata->acp_lock,
+						     sizeof(adata->acp_lock));
+			acp63_fill_platform_dev_info(&pdevinfo[1], parent, adata->sdw_fw_node,
+						     "amd_sdw_manager", 0, adata->res, 1,
+						     sdw_pdata, sizeof(struct acp_sdw_pdata));
+			acp63_fill_platform_dev_info(&pdevinfo[2], parent, NULL, "amd_ps_sdw_dma",
+						     0, adata->res, 1, &adata->acp_lock,
+						     sizeof(adata->acp_lock));
+			acp63_fill_platform_dev_info(&pdevinfo[3], parent, NULL, "dmic-codec",
+						     0, NULL, 0, NULL, 0);
+		} else if (adata->pdev_count == ACP63_SDW0_SDW1_PDM_MODE_DEVS) {
+			sdw_pdata = devm_kzalloc(&pci->dev, sizeof(struct acp_sdw_pdata) * 2,
+						 GFP_KERNEL);
+			if (!sdw_pdata) {
+				ret = -ENOMEM;
+				goto de_init;
+			}
+			sdw_pdata[0].instance = 0;
+			sdw_pdata[1].instance = 1;
+			sdw_pdata[0].acp_sdw_lock = &adata->acp_lock;
+			sdw_pdata[1].acp_sdw_lock = &adata->acp_lock;
+			adata->pdm_dev_index = 0;
+			adata->sdw0_dev_index = 1;
+			adata->sdw1_dev_index = 2;
+			adata->sdw_dma_dev_index = 3;
+			acp63_fill_platform_dev_info(&pdevinfo[0], parent, NULL, "acp_ps_pdm_dma",
+						     0, adata->res, 1, &adata->acp_lock,
+						     sizeof(adata->acp_lock));
+			acp63_fill_platform_dev_info(&pdevinfo[1], parent, adata->sdw_fw_node,
+						     "amd_sdw_manager", 0, adata->res, 1,
+						     &sdw_pdata[0], sizeof(struct acp_sdw_pdata));
+			acp63_fill_platform_dev_info(&pdevinfo[2], parent, adata->sdw_fw_node,
+						     "amd_sdw_manager", 1, adata->res, 1,
+						     &sdw_pdata[1], sizeof(struct acp_sdw_pdata));
+			acp63_fill_platform_dev_info(&pdevinfo[3], parent, NULL, "amd_ps_sdw_dma",
+						     0, adata->res, 1, &adata->acp_lock,
+						     sizeof(adata->acp_lock));
+			acp63_fill_platform_dev_info(&pdevinfo[4], parent, NULL, "dmic-codec",
+						     0, NULL, 0, NULL, 0);
+		}
+		break;
 	default:
-		dev_dbg(&pci->dev, "No PDM devices found\n");
+		dev_dbg(&pci->dev, "No PDM or Soundwire manager devices found\n");
 		return 0;
 	}
 
@@ -290,7 +514,11 @@ static int snd_acp63_probe(struct pci_dev *pci,
 		goto de_init;
 	}
 	val = readl(adata->acp63_base + ACP_PIN_CONFIG);
-	get_acp63_device_config(val, pci, adata);
+	ret = get_acp63_device_config(val, pci, adata);
+	if (ret) {
+		dev_err(&pci->dev, "get acp device config failed:%d\n", ret);
+		goto de_init;
+	}
 	ret = create_acp63_platform_devs(pci, adata, addr);
 	if (ret < 0) {
 		dev_err(&pci->dev, "ACP platform devices creation failed\n");
-- 
2.34.1

