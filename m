Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7D872BE8B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjFLKO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjFLKN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:13:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CA44C10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:55:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuR+B/i7riQ1CAVkj6g/sf5MPWhG4Bwutg9mzBoRCmUkgC286VNahQDIvIMZ5NzcWbfl8Hm8RNwwwI7Gbh2iLls0F01YVoQ1NLVHWl0m60FKkNg8p4xwmjDMhVzYoVmOVesupH51o+7K4MN6kcBvokMws6KgwqmgIC2FEAuOdV1cXRk3+cDkZsIzr4jlNfMik3ShumkQwg8dmqBz99a1dfy94qPNQusAQyd2iVHoaqglirWgKYVqYEWxtE/HO8kZ9ekP0rOHL51pyAt6Vg9xdQwYTVDG1x7e65+jhrHoZF2vEXNw1BYCh+KVcipQs4Pvs/fjVhF1E7PQ7mW1DG3s8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYuZNrmu2dl3MRt8Nea5z3/LcRuYBAGKKpiTFRgonME=;
 b=i+dqybezNnX5oP30gg5CLTN7LCZTf8LJrHS/53qbRJqjeb8/XIhehnUdIP7LwX8oxH4h9SAdMVYED0sMoIBwLBPiAMFJweGhOQfxoFg1JfTGySWU/HfFsuCPofl1iffodQUt2bkV3x4Ob3qwjNQYdGxT+qE4pkahjMtdoDZSgNZ9gNru9wIjpY1oEp5RkN5LXoEV+LHuq4hgRdJ5YHTEmvR8y4zuAMAcsryZ3rrbvxNmMeBif2sDsuLL5U5R/WbSaXs2cYj4lePN6vE2zGrZuqcYIahUhFf0bPz8WMmI6D4lv4TYhPIYpsiAoIceQOwPHXJtI1L/Wu6K5urffkNlNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYuZNrmu2dl3MRt8Nea5z3/LcRuYBAGKKpiTFRgonME=;
 b=ceKJ/AQoLV/PM3GiKxp6DZ6NBbqvgMC0OCbpGUHo+JiMvUZrbK8GKieRRG+bOpQXf/Eny0D/RydrOwznEv5zKyIbzEX5jM+28ZRCHOC2recu8vS1lYSaPmOXWdA0a1s537GQvTVd5blhAiSyrMVMUu0fS/+6c/WzHjNfn4OFDKA=
Received: from DM6PR03CA0050.namprd03.prod.outlook.com (2603:10b6:5:100::27)
 by DM4PR12MB8498.namprd12.prod.outlook.com (2603:10b6:8:183::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 09:55:24 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:5:100:cafe::8c) by DM6PR03CA0050.outlook.office365.com
 (2603:10b6:5:100::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Mon, 12 Jun 2023 09:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Mon, 12 Jun 2023 09:55:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 04:54:27 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 04:54:27 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Mon, 12 Jun 2023 04:54:23 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <pierre-louis.bossart@linux.intel.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        <mario.limonciello@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V4 1/9] ASoC: amd: ps: create platform devices based on acp config
Date:   Mon, 12 Jun 2023 15:28:55 +0530
Message-ID: <20230612095903.2113464-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612095903.2113464-1-Vijendar.Mukunda@amd.com>
References: <20230612095903.2113464-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|DM4PR12MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: b68454cc-7efd-4f8b-8b0e-08db6b2b2424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ec0lhbdCv6K1R/b7/F55jx/o6i7jBU22zxzMQ49712gg2MSUesIelKV6Pad6dxo4C1y2Uyoz7BRY+QFYGaBwAcBSIkmBamFpxw603NYdb6USxKVs3SJVy0fiscH0WcbZzJDulbO6G+XyMvqh65qjnQ+59xqGJHr4WBSJHGEXqKAgSHwAVN3yHvd2zGX7nQ295VlVJISNshRIMLIPemv3FNEwyjx9Ispvkes6+gq7Rb7NQ5w+f1M0IBoV8+ZpmrCj2QQ79rI2Vkk1H7D7PADIu75T8QpkGC375xdCNMsqAr1VHzXcbRkEXalZuHgL6yFpNb6b5qTw/DkkY7NicsKYzPY5ezgiQ1oazE+CAjob+uLHHD/tCEONtOMRJUHo1nWKMvW22fyrcg4wR8AbGAr3FYmB6fdKQ4Zh/M2cdMMFnkf0HS7yJgYgo7dMJsSBfFH+LMz0uWUf1pGnn4nH9m6I6yFw1K9KyTPU5mhZH5YVNHy1Nxvpulj6eLeV2dwlaZZaJV1aZKoeFxoAlLC5DQ/dLkkiuoIvGPIg1GGzubU4x+/ddC9VNvP6ju0IxQUGKnSNQ1xdNHQskt701g9gPAGTuOJcGT/DlYgfp/MlzacraYhRkth7KWRrbO7nIQEv+G6O4IkveoiMFVTPfm2MgmsWi0WWOygOn5C2OG/J1gJmHm7twPciw5UAgze1TxesuK9jms2D6qauF9Tgzn6FLPhOh0fc1zY5dEghi0SpMtdyiiWIz6KAZs9fzG/XuQHHGAQvuwkvg12cvcXgzaiBEHRw5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(5660300002)(8936002)(8676002)(30864003)(2906002)(70206006)(70586007)(54906003)(6666004)(7696005)(4326008)(1076003)(26005)(316002)(6916009)(41300700001)(186003)(36860700001)(356005)(82740400003)(336012)(426003)(47076005)(83380400001)(2616005)(40460700003)(478600001)(40480700001)(36756003)(86362001)(82310400005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 09:55:20.5791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b68454cc-7efd-4f8b-8b0e-08db6b2b2424
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8498
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on ACP pin configuration and scanning child devices
under ACP pci device ACPI scope, platform device configuration
(pdev_config) and platform device count(pdev_count) will be
calculated.

Using pdev_config and pdev_count values, ACP PCI driver will
create platform devices for Pink Sardine platform.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h  |  73 +++++++++-
 sound/soc/amd/ps/pci-ps.c | 271 +++++++++++++++++++++++++++++++++++---
 2 files changed, 323 insertions(+), 21 deletions(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 2f94448102d0..80ab542529a7 100644
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
@@ -53,14 +53,53 @@
 /* time in ms for runtime suspend delay */
 #define ACP_SUSPEND_DELAY_MS	2000
 
-#define ACP63_DMIC_ADDR		2
-#define ACP63_PDM_MODE_DEVS		3
-#define ACP63_PDM_DEV_MASK		1
 #define ACP_DMIC_DEV	2
 
+/* ACP63_PDM_MODE_DEVS corresponds to platform devices count for ACP PDM configuration */
+#define ACP63_PDM_MODE_DEVS		3
+
+/*
+ * ACP63_SDW0_MODE_DEVS corresponds to platform devices count for
+ * SW0 SoundWire manager instance configuration
+ */
+#define ACP63_SDW0_MODE_DEVS		2
+
+/*
+ * ACP63_SDW0_SDW1_MODE_DEVS corresponds to platform devices count for SW0 + SW1 SoundWire manager
+ * instances configuration
+ */
+#define ACP63_SDW0_SDW1_MODE_DEVS	3
+
+/*
+ * ACP63_SDW0_PDM_MODE_DEVS corresponds to platform devices count for SW0 manager
+ * instance + ACP PDM controller configuration
+ */
+#define ACP63_SDW0_PDM_MODE_DEVS	4
+
+/*
+ * ACP63_SDW0_SDW1_PDM_MODE_DEVS corresponds to platform devices count for
+ * SW0 + SW1 SoundWire manager instances + ACP PDM controller configuration
+ */
+#define ACP63_SDW0_SDW1_PDM_MODE_DEVS   5
+#define ACP63_DMIC_ADDR			2
+#define ACP63_SDW_ADDR			5
+#define AMD_SDW_MAX_MANAGERS		2
+
 /* time in ms for acp timeout */
 #define ACP_TIMEOUT		500
 
+/* ACP63_PDM_DEV_CONFIG corresponds to platform device configuration for ACP PDM controller */
+#define ACP63_PDM_DEV_CONFIG		BIT(0)
+
+/* ACP63_SDW_DEV_CONFIG corresponds to platform device configuration for SDW manager instances */
+#define ACP63_SDW_DEV_CONFIG		BIT(1)
+
+/*
+ * ACP63_SDW_PDM_DEV_CONFIG corresponds to platform device configuration for ACP PDM + SoundWire
+ * manager instance combination.
+ */
+#define ACP63_SDW_PDM_DEV_CONFIG	GENMASK(1, 0)
+
 enum acp_config {
 	ACP_CONFIG_0 = 0,
 	ACP_CONFIG_1,
@@ -95,14 +134,38 @@ struct pdm_dev_data {
 	struct snd_pcm_substream *capture_stream;
 };
 
+/**
+ * struct acp63_dev_data - acp pci driver context
+ * @acp63_base: acp mmio base
+ * @res: resource
+ * @pdev: array of child platform device node structures
+ * @acp_lock: used to protect acp common registers
+ * @sdw_fw_node: SoundWire controller fw node handle
+ * @pdev_config: platform device configuration
+ * @pdev_count: platform devices count
+ * @pdm_dev_index: pdm platform device index
+ * @sdw_manager_count: SoundWire manager instance count
+ * @sdw0_dev_index: SoundWire Manager-0 platform device index
+ * @sdw1_dev_index: SoundWire Manager-1 platform device index
+ * @sdw_dma_dev_index: SoundWire DMA controller platform device index
+ * @acp_reset: flag set to true when bus reset is applied across all
+ * the active SoundWire manager instances
+ */
+
 struct acp63_dev_data {
 	void __iomem *acp63_base;
 	struct resource *res;
 	struct platform_device *pdev[ACP63_DEVS];
 	struct mutex acp_lock; /* protect shared registers */
-	u16 pdev_mask;
+	struct fwnode_handle *sdw_fw_node;
+	u16 pdev_config;
 	u16 pdev_count;
 	u16 pdm_dev_index;
+	u8 sdw_manager_count;
+	u16 sdw0_dev_index;
+	u16 sdw1_dev_index;
+	u16 sdw_dma_dev_index;
+	bool acp_reset;
 };
 
 int snd_amd_acp_find_config(struct pci_dev *pci);
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 54752d6040d6..cf57ad2d7ccc 100644
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
 
@@ -119,37 +121,164 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
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
+	/*
+	 * Current implementation is based on MIPI DisCo 2.0 spec.
+	 * Found controller, find links supported.
+	 */
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
+	dev_dbg(dev, "ACPI reports %d SoundWire Manager devices\n", count);
+	acp_data->sdw_manager_count = count;
+	for (index = 0; index < count; index++) {
+		snprintf(name, sizeof(name), "mipi-sdw-link-%d-subproperties", index);
+		link = fwnode_get_named_child_node(acp_data->sdw_fw_node, name);
+		if (!link) {
+			dev_err(dev, "Manager node %s not found\n", name);
+			return -EIO;
+		}
+
+		ret = fwnode_property_read_u32(link, "amd-sdw-power-mode", &acp_sdw_power_mode);
+		if (ret)
+			return ret;
+		/*
+		 * when SoundWire configuration is selected from acp pin config,
+		 * based on manager instances count, acp init/de-init sequence should be
+		 * executed as part of PM ops only when Bus reset is applied for the active
+		 * SoundWire manager instances.
+		 */
+		if (acp_sdw_power_mode != AMD_SDW_POWER_OFF_MODE) {
+			acp_data->acp_reset = false;
+			return 0;
+		}
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
+		/* is_dmic_dev flag will be set when ACP PDM controller device exists */
 		if (!acpi_dev_get_property(dmic_dev, "acp-audio-device-type",
 					   ACPI_TYPE_INTEGER, &obj) &&
 					   obj->integer.value == ACP_DMIC_DEV)
 			is_dmic_dev = true;
 	}
 
+	sdw_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_SDW_ADDR, 0);
+	if (sdw_dev) {
+		acp_data->sdw_fw_node = acpi_fwnode_handle(sdw_dev);
+		ret = sdw_amd_scan_controller(&pci->dev);
+		/* is_sdw_dev flag will be set when SoundWire Manager device exists */
+		if (!ret)
+			is_sdw_dev = true;
+	}
+	if (!is_dmic_dev && !is_sdw_dev)
+		return -ENODEV;
+	dev_dbg(&pci->dev, "Audio Mode %d\n", config);
 	switch (config) {
-	case ACP_CONFIG_0:
-	case ACP_CONFIG_1:
+	case ACP_CONFIG_4:
+	case ACP_CONFIG_5:
+	case ACP_CONFIG_10:
+	case ACP_CONFIG_11:
+		if (is_dmic_dev) {
+			acp_data->pdev_config = ACP63_PDM_DEV_CONFIG;
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
+				acp_data->pdev_config = ACP63_SDW_DEV_CONFIG;
+				acp_data->pdev_count = ACP63_SDW0_MODE_DEVS;
+				break;
+			case 2:
+				acp_data->pdev_config = ACP63_SDW_DEV_CONFIG;
+				acp_data->pdev_count = ACP63_SDW0_SDW1_MODE_DEVS;
+				break;
+			default:
+				return -EINVAL;
+			}
+		}
 		break;
-	default:
-		if (is_dmic_dev) {
-			acp_data->pdev_mask = ACP63_PDM_DEV_MASK;
+	case ACP_CONFIG_6:
+	case ACP_CONFIG_7:
+	case ACP_CONFIG_12:
+	case ACP_CONFIG_8:
+	case ACP_CONFIG_13:
+	case ACP_CONFIG_14:
+		if (is_dmic_dev && is_sdw_dev) {
+			switch (acp_data->sdw_manager_count) {
+			case 1:
+				acp_data->pdev_config = ACP63_SDW_PDM_DEV_CONFIG;
+				acp_data->pdev_count = ACP63_SDW0_PDM_MODE_DEVS;
+				break;
+			case 2:
+				acp_data->pdev_config = ACP63_SDW_PDM_DEV_CONFIG;
+				acp_data->pdev_count = ACP63_SDW0_SDW1_PDM_MODE_DEVS;
+				break;
+			default:
+				return -EINVAL;
+			}
+		} else if (is_dmic_dev) {
+			acp_data->pdev_config = ACP63_PDM_DEV_CONFIG;
 			acp_data->pdev_count = ACP63_PDM_MODE_DEVS;
+		} else if (is_sdw_dev) {
+			switch (acp_data->sdw_manager_count) {
+			case 1:
+				acp_data->pdev_config = ACP63_SDW_DEV_CONFIG;
+				acp_data->pdev_count = ACP63_SDW0_MODE_DEVS;
+				break;
+			case 2:
+				acp_data->pdev_config = ACP63_SDW_DEV_CONFIG;
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
@@ -173,6 +302,7 @@ static void acp63_fill_platform_dev_info(struct platform_device_info *pdevinfo,
 
 static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data *adata, u32 addr)
 {
+	struct acp_sdw_pdata *sdw_pdata;
 	struct platform_device_info pdevinfo[ACP63_DEVS];
 	struct device *parent;
 	int index;
@@ -180,9 +310,9 @@ static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data
 
 	parent = &pci->dev;
 	dev_dbg(&pci->dev,
-		"%s pdev_mask:0x%x pdev_count:0x%x\n", __func__, adata->pdev_mask,
+		"%s pdev_config:0x%x pdev_count:0x%x\n", __func__, adata->pdev_config,
 		adata->pdev_count);
-	if (adata->pdev_mask) {
+	if (adata->pdev_config) {
 		adata->res = devm_kzalloc(&pci->dev, sizeof(struct resource), GFP_KERNEL);
 		if (!adata->res) {
 			ret = -ENOMEM;
@@ -194,8 +324,8 @@ static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data
 		memset(&pdevinfo, 0, sizeof(pdevinfo));
 	}
 
-	switch (adata->pdev_mask) {
-	case ACP63_PDM_DEV_MASK:
+	switch (adata->pdev_config) {
+	case ACP63_PDM_DEV_CONFIG:
 		adata->pdm_dev_index  = 0;
 		acp63_fill_platform_dev_info(&pdevinfo[0], parent, NULL, "acp_ps_pdm_dma",
 					     0, adata->res, 1, NULL, 0);
@@ -204,8 +334,104 @@ static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data
 		acp63_fill_platform_dev_info(&pdevinfo[2], parent, NULL, "acp_ps_mach",
 					     0, NULL, 0, NULL, 0);
 		break;
+	case ACP63_SDW_DEV_CONFIG:
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
+						     0, adata->res, 1, NULL, 0);
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
+						     0, adata->res, 1, NULL, 0);
+		}
+		break;
+	case ACP63_SDW_PDM_DEV_CONFIG:
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
+						     0, adata->res, 1, NULL, 0);
+			acp63_fill_platform_dev_info(&pdevinfo[1], parent, adata->sdw_fw_node,
+						     "amd_sdw_manager", 0, adata->res, 1,
+						     sdw_pdata, sizeof(struct acp_sdw_pdata));
+			acp63_fill_platform_dev_info(&pdevinfo[2], parent, NULL, "amd_ps_sdw_dma",
+						     0, adata->res, 1, NULL, 0);
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
+						     0, adata->res, 1, NULL, 0);
+			acp63_fill_platform_dev_info(&pdevinfo[1], parent, adata->sdw_fw_node,
+						     "amd_sdw_manager", 0, adata->res, 1,
+						     &sdw_pdata[0], sizeof(struct acp_sdw_pdata));
+			acp63_fill_platform_dev_info(&pdevinfo[2], parent, adata->sdw_fw_node,
+						     "amd_sdw_manager", 1, adata->res, 1,
+						     &sdw_pdata[1], sizeof(struct acp_sdw_pdata));
+			acp63_fill_platform_dev_info(&pdevinfo[3], parent, NULL, "amd_ps_sdw_dma",
+						     0, adata->res, 1, NULL, 0);
+			acp63_fill_platform_dev_info(&pdevinfo[4], parent, NULL, "dmic-codec",
+						     0, NULL, 0, NULL, 0);
+		}
+		break;
 	default:
-		dev_dbg(&pci->dev, "No PDM devices found\n");
+		dev_dbg(&pci->dev, "No PDM or SoundWire manager devices found\n");
 		return 0;
 	}
 
@@ -276,6 +502,13 @@ static int snd_acp63_probe(struct pci_dev *pci,
 		ret = -ENOMEM;
 		goto release_regions;
 	}
+	/*
+	 * By default acp_reset flag is set to true. i.e acp_deinit() and acp_init()
+	 * will be invoked for all ACP configurations during suspend/resume callbacks.
+	 * This flag should be set to false only when SoundWire manager power mode
+	 * set to ClockStopMode.
+	 */
+	adata->acp_reset = true;
 	pci_set_master(pci);
 	pci_set_drvdata(pci, adata);
 	mutex_init(&adata->acp_lock);
@@ -289,12 +522,18 @@ static int snd_acp63_probe(struct pci_dev *pci,
 		goto de_init;
 	}
 	val = readl(adata->acp63_base + ACP_PIN_CONFIG);
-	get_acp63_device_config(val, pci, adata);
+	ret = get_acp63_device_config(val, pci, adata);
+	/* ACP PCI driver probe should be continued even PDM or SoundWire Devices are not found */
+	if (ret) {
+		dev_err(&pci->dev, "get acp device config failed:%d\n", ret);
+		goto skip_pdev_creation;
+	}
 	ret = create_acp63_platform_devs(pci, adata, addr);
 	if (ret < 0) {
 		dev_err(&pci->dev, "ACP platform devices creation failed\n");
 		goto de_init;
 	}
+skip_pdev_creation:
 	pm_runtime_set_autosuspend_delay(&pci->dev, ACP_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(&pci->dev);
 	pm_runtime_put_noidle(&pci->dev);
-- 
2.34.1

