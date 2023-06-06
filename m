Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAEB723713
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjFFGCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjFFGCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:02:49 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE9E11B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIx/M7KtuuPAVDTYGQu7EefOr4v4UeOGMboQ8E8T3TF2aI2Fmt+P5AK8NmUyE0wOf+yZiXKVYhPQp1sDzCLRAgqAtjaN3hbG/SY9t8S1mcXUMdtOwkPZT0hJr+tSHrkFuDqIY/14AckdBq2rXQ0N1tpXE2siRKAotEWazuvhqcCAPiamZrprf/9lKmCJ9MvskGihJwXxfA2o0h2GXzdJSrecaWo8/1g9ELaRzICEdHIDW9KgFguoj3nTbDOSxkd+qbhiPoTaWAFSnfSf5kGXE13tx5LW/BeLDhrkpGvTxSWHe9rBpH5D3NPQ9f6g/LlU0e3ghKupaLmfa+WuElN9SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgthKiXxAUgPxC14rwaLbmN/KrQAgJl9IsBC6DCTynM=;
 b=G54EBkoZ0qm1xJcTIJ9i5Wb5G/k6RmvR3hoA2dHC6aVaph5jVtBjUQN0NifL8ZpKno2kAdYl/oeBraeGnrse4yka9VoWMszRfS/nI/3LSwD7NgjtWi4DBtfVTjLst6XsAdqiOnQn8HE49c5K4CNMCOftH+nAlCQzkHj6HY5noGrLDbcqVTIFuN28K1i4tu3SA995KSQ0xB5uD/C1NoNo4JPM6MlQSzUe76NAwlm4/VQrAKozJsqvP4K/2kkHx2tpyQDOqJVFUGkQv3DgM24d8JdQY/HtduYb0gdXxlhUi5cM4k/FovWnrHH5OVYDwdtXYIcceMSXGrnd4SqoMmoLrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgthKiXxAUgPxC14rwaLbmN/KrQAgJl9IsBC6DCTynM=;
 b=wAkniom8RUhfYBNE3x73bUYfol+YNo4rTCfFLmKRRJe/9AzAR9XNqFF+RFTI0joUKyDwePDn1blJzurwwhx+pY+aCSFNGcDpRU3kCXiziIR704pvK4V7CCJgQr4zdqrpkPDWsSIe+Cu1tnq5Zx94OA4TlcLvmlLhTpwyp1jcWIQ=
Received: from MW4PR04CA0280.namprd04.prod.outlook.com (2603:10b6:303:89::15)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Tue, 6 Jun
 2023 06:02:43 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::80) by MW4PR04CA0280.outlook.office365.com
 (2603:10b6:303:89::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 06:02:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 06:02:43 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 01:02:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Jun
 2023 23:02:42 -0700
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 6 Jun 2023 01:02:38 -0500
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
Subject: [PATCH V3 1/9] ASoC: amd: ps: create platform devices based on acp config
Date:   Tue, 6 Jun 2023 11:37:16 +0530
Message-ID: <20230606060724.2038680-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606060724.2038680-1-Vijendar.Mukunda@amd.com>
References: <20230606060724.2038680-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT034:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db24de6-c5a8-47a3-1d85-08db6653a4ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ALjGTvY6QwI4n6rGm3J5Ny7XkM17pZBpMWufKtS9/EAaI9WyMmT+6+qh7a8T4+GEC9RjwM+o1pvVPhLF4QWCzXdKjKv/nkPdFGHx9WbqtH6Xm27MVeTDKJQip2kBAuskG/I5oJMGvUSFSL/FBngmNk5WcqUsUv9ejuYwlULyXhZUBcomMwbmwbSq8YVs8u6rHVS/tHMLSibBGInLPWzpWff0v5vZ+HxE5sOCvsYcs0XIVDaEzgRfy+3zEmgLY3+iyYzbVmLV1VEuyyAVCJs1JCP/EO+97kQgNLE69JOcgF5OUUOUEQX6twOSR0yI9kKgyDNmAQ8/Elq7sdMFuSgie7Gfpz5aakgIfnT3sdLTtw8QvqDPoBQ32mbstwJUKk2hgHs/dkvDSPbHzkC0nQOCxxwcLeeaUK1aG9iTVLi/quyj8wSHO+ERwd5JCHD/T++z5ge/VUGW6nCUmQg/m8/doagtRBk8etLl8QgcoiipKbUwkP3JjE9jVbRue1SFteOCi461Boaedh3aV01vQEnVmFTh4UFK+mBNViRak+qhZ7DV71BWQSLkW0ey+pIbfl7Z2oWkGOzbLVDvzPbCFI77hf+Ax3Xl+xspOexiOKt+oZlGe8pOhyFjvpmJJb8AViTcjtYZ5nzXvgVBnOnKtqMGdJMwpJqRjDmCAnR/VwcXNl7OZ2bYpqgP7g5/wMTR+3FdfXbP7sXyV/EU4Q0K2WGvN2sH9YZHe+5nUJ4+iTlrTM+LmN0ekpQzXTo6YGOXBQ7XfIweAJAx+jiERix0z49gzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(47076005)(41300700001)(316002)(186003)(83380400001)(4326008)(30864003)(6916009)(426003)(336012)(2906002)(36860700001)(8936002)(5660300002)(8676002)(40460700003)(70206006)(70586007)(82740400003)(2616005)(356005)(81166007)(86362001)(1076003)(478600001)(36756003)(26005)(82310400005)(54906003)(40480700001)(7696005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:02:43.2491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db24de6-c5a8-47a3-1d85-08db6653a4ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819
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

Based on ACP pin configuration and scanning child devices
under ACP pci device ACPI scope, platform device mask(pdev_mask)
and platform device count(pdev_count) will be calculated.

Using pdev_mask and pdev_count values, ACP PCI driver will
create platform devices for Pink Sardine platform.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h  |  81 +++++++++++-
 sound/soc/amd/ps/pci-ps.c | 252 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 318 insertions(+), 15 deletions(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 2f94448102d0..95bb1cef900a 100644
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
@@ -53,11 +53,38 @@
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
 
@@ -80,6 +107,28 @@ enum acp_config {
 	ACP_CONFIG_15,
 };
 
+/**
+ * acp_pdev_mask corresponds to platform device mask based on audio endpoint combinations.
+ * acp_pdev_mask will be calculated based on ACPI Scan under ACP PCI device and
+ * ACP PIN Configuration.
+ * Based acp_pdev_mask, platform devices will be created.
+ * Below are possible platform device combinations.
+ * 1) ACP PDM Controller, dmic-codec, machine driver platform device node
+ * 2) ACP PDM Controller , dmic-codec, SW0 SoundWire manager instance, platform device for
+ *    SoundWire DMA driver
+ * 3) SW0, SW1 SoundWire manager instances, platform device for SoundWire DMA driver
+ * 4) ACP PDM Controller, dmic-codec, SDW0, SDW1 manager instances, platform device for
+ *    SoundWire DMA driver
+ * ACP63_PDM_DEV_MASK corresponds to platform device mask for ACP PDM controller.
+ * ACP63_SDW_DEV_MASK corresponds to platform device mask for SDW manager instances.
+ * ACP63_SDW_PDM_DEV_MASK corresponds to platform device mask for ACP PDM + SDW manager combination
+ */
+enum acp_pdev_mask {
+	ACP63_PDM_DEV_MASK = 1,
+	ACP63_SDW_DEV_MASK,
+	ACP63_SDW_PDM_DEV_MASK,
+};
+
 struct pdm_stream_instance {
 	u16 num_pages;
 	u16 channels;
@@ -95,14 +144,38 @@ struct pdm_dev_data {
 	struct snd_pcm_substream *capture_stream;
 };
 
+/**
+ * struct acp63_dev_data - acp pci driver context
+ * @acp63_base: acp mmio base
+ * @res: resource
+ * @pdev: array of child platform device node structures
+ * @acp_lock: used to protect acp common registers
+ * @sdw_fw_node: SoundWire controller fw node handle
+ * @pdev_mask: platform device mask
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
+	struct fwnode_handle *sdw_fw_node;
 	u16 pdev_mask;
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
index 54752d6040d6..816c22e7f1ab 100644
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
 
@@ -119,37 +121,162 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
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
@@ -173,6 +300,7 @@ static void acp63_fill_platform_dev_info(struct platform_device_info *pdevinfo,
 
 static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data *adata, u32 addr)
 {
+	struct acp_sdw_pdata *sdw_pdata;
 	struct platform_device_info pdevinfo[ACP63_DEVS];
 	struct device *parent;
 	int index;
@@ -204,8 +332,104 @@ static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data
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
 
@@ -289,12 +513,18 @@ static int snd_acp63_probe(struct pci_dev *pci,
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

