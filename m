Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0296656A7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjAKJAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbjAKI7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:59:49 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C341147D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:59:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgI7gqT0zopG0iP5SOs66U9E92v4oeZqs1SFk7hFB5OCI2FFYOw6RrAvN2VS2B3j2K21QgZL+wgcmhAPVOIKNrfRYiTYEsOUr4+W67fFmEqSAgzJKk999sLwKN5rQ+oaERs2pQGDglgZ7TW12nNk70Q4I7C6/qV9kwZyb4a1LMC4jIE2banxtUcLDhX2Qcd6r6mSyQnfBx06xDiPtgQ4wzhjkxLpbn+OlwzLeH9KeV6bovl6WkwiguLevuO5sN7M5Dgf1ru4ytY8JKTqzkMZAy+tgXp2GQI/2ed7oXnVEKZdeDFWgzEEgDon22R4XAsBVCDUy3qVsZaiBnDuT6mRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6IcGvT1XU3poCPoNix67Q5LWFB6cWRxV3vvrQ2T+Bc=;
 b=Lb1/NUm8mIRzFVcEpSMdXP/fgwow8cWGS4K7PvTMtQ+1YUBlvoHQ2A7+DU+E4yRaZhFiZmc9pjF1s9cJGr2rv3ivhsDJdZByx3mM5MmHVv3CKJMDJoNrc8sTx2/zwF+W/YjfSJ35MdnnSYwps0UjM+FBhG5JSSzNSH1/vtRnGmmBdnfxRUmE9dmWttIu/M37wzeD2QtXMRrLLKTU3d7wke6E8jTq0HtK7K01+fOYmJIThWfhjpZ9e0FAkX1KW4e3q5qvOjqYEsKYtS9pylSsfQoVrNRM+3306Mz006LmwxVPr8I/MCKg/M1HYGdjtQAEDLndvdMMbxi2V1fdnfLJQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6IcGvT1XU3poCPoNix67Q5LWFB6cWRxV3vvrQ2T+Bc=;
 b=oZV6AvKynDzD43oFdqnyORCGJzcN1r7HUlHyF8Wh7S22D8/F6PP0QuG3qVjP4gKmyubRZp99FS53FppMZrsiPJ5fxsrvOUce5uUYsJNSQVU0P4sYKo50gracPMpN4tPGl6xhflsmT+Fk5ZK9NoFzlSzir887bVw1auQvWtTIUhA=
Received: from DS7PR03CA0199.namprd03.prod.outlook.com (2603:10b6:5:3b6::24)
 by MW3PR12MB4569.namprd12.prod.outlook.com (2603:10b6:303:57::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 08:59:46 +0000
Received: from DS1PEPF0000B078.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::d4) by DS7PR03CA0199.outlook.office365.com
 (2603:10b6:5:3b6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Wed, 11 Jan 2023 08:59:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B078.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Wed, 11 Jan 2023 08:59:45 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 02:59:45 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 00:59:44 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 11 Jan 2023 02:59:39 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <vkoul@kernel.org>,
        <alsa-devel@alsa-project.org>
CC:     <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>, <Mastan.Katragadda@amd.com>,
        <arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/19] ASoC: amd: ps: create platform devices based on acp config
Date:   Wed, 11 Jan 2023 14:32:04 +0530
Message-ID: <20230111090222.2016499-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B078:EE_|MW3PR12MB4569:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cebad8d-3c06-4e8a-fcef-08daf3b22fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: agZsCNK6LeWvLr3WeYq7OTbTG1qsY03yJWx4AhKjJahZMjVkv2MgyOIfOFSh6h2exT+b2laNs15L5Au3dgiN/hgbPYLvH3BN+OIWsLN1aRGzJJFG/NhBCvx4IRVlX6WIS2fGV/wpXOFLZiypLy5OxOBy2rCsi5ETHJvGS/6Ud0ffgDkW1/XWBO18DFT3bMio7kMgSDDAfuIl9QRjuaSSAQu0A9CiDK7PlXlyXFzicc9BR0cdTZaA3zqMEMDP+oeMRl3b1u/evEPdiOqsGwAz6OKuhaPkrOYDGTt3j4WTmrY//HB6bqDe+ZJ8sq+a9EasPwrEQwAs0tHQzgMIY5WZ7QdehIz2Ip8Ic9b7vdwmdoO8RiA3GKZmfmHFn2rq2ZEtKxGdIqLUJXlknghmburuXhR8DRjf27tJYdIQ9QPW96SRA88qFXHdG6gzFWzsWCHwenYXi591OoHBmdnpBPUOtJBjKhHon0CMDTKVInNzJp6I6NzBnGEVf1ZLnCKPm//XWWtb5rK86xo6yccCMHNv8y8BjgSIQ7Yzn6k4x/0YW206bL7Ihh76L/tb/7gHvpPQNDuiP1H52rC4Zr5CvbENcQxbFErPY7MKwyL6CugnbmL78yFhOowYFPYp5K7fze5E2XGO6poNi+265t5RZfz7rlbOrI11BOsPzCE0gFjizFP9USILAAQmfH9w06IxT1CZcyS+olgf0uJA69YsPyw0oVJzK/B6bf+9kRIYXp+JYMA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(30864003)(1076003)(7416002)(40480700001)(316002)(5660300002)(186003)(7696005)(26005)(478600001)(2616005)(41300700001)(426003)(47076005)(70586007)(54906003)(70206006)(4326008)(8676002)(110136005)(336012)(82310400005)(8936002)(83380400001)(40460700003)(86362001)(36756003)(6666004)(36860700001)(82740400003)(2906002)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 08:59:45.6510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cebad8d-3c06-4e8a-fcef-08daf3b22fc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B078.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4569
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create platform devices for sdw controllers and PDM controller
based on ACP pin config selection and ACPI fw handle for
pink sardine platform.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
---
 include/linux/soundwire/sdw_amd.h |  18 +++
 sound/soc/amd/ps/acp63.h          |  24 ++-
 sound/soc/amd/ps/pci-ps.c         | 248 ++++++++++++++++++++++++++++--
 3 files changed, 277 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/soundwire/sdw_amd.h

diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
new file mode 100644
index 000000000000..f0123815af46
--- /dev/null
+++ b/include/linux/soundwire/sdw_amd.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2023 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#ifndef __SDW_AMD_H
+#define __SDW_AMD_H
+
+#include <linux/soundwire/sdw.h>
+
+#define AMD_SDW_CLK_STOP_MODE		1
+#define AMD_SDW_POWER_OFF_MODE		2
+
+struct acp_sdw_pdata {
+	u16 instance;
+	struct mutex *sdw_lock;
+};
+#endif
diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index b7535c7d093f..ed979e6d0c1d 100644
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
+#define AMD_SDW_MAX_CONTROLLERS		2
 
 enum acp_config {
 	ACP_CONFIG_0 = 0,
@@ -77,6 +83,12 @@ enum acp_config {
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
@@ -107,7 +119,15 @@ struct acp63_dev_data {
 	struct resource *res;
 	struct platform_device *pdev[ACP63_DEVS];
 	struct mutex acp_lock; /* protect shared registers */
+	struct fwnode_handle *sdw_fw_node;
 	u16 pdev_mask;
 	u16 pdev_count;
 	u16 pdm_dev_index;
+	u8 sdw_master_count;
+	u16 sdw0_dev_index;
+	u16 sdw1_dev_index;
+	u16 sdw_dma_dev_index;
+	bool is_dmic_dev;
+	bool is_sdw_dev;
+	bool acp_sdw_power_off;
 };
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index e86f23d97584..85154cf0b2a2 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <sound/pcm_params.h>
 #include <linux/pm_runtime.h>
+#include <linux/soundwire/sdw_amd.h>
 
 #include "acp63.h"
 
@@ -134,12 +135,68 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static void get_acp63_device_config(u32 config, struct pci_dev *pci,
-				    struct acp63_dev_data *acp_data)
+static int sdw_amd_scan_controller(struct device *dev)
+{
+	struct acp63_dev_data *acp_data;
+	struct fwnode_handle *link;
+	char name[32];
+	u8 count = 0;
+	u32 acp_sdw_power_mode = 0;
+	int index;
+	int ret;
+
+	acp_data = dev_get_drvdata(dev);
+	acp_data->acp_sdw_power_off = true;
+	/* Found controller, find links supported */
+	ret = fwnode_property_read_u8_array((acp_data->sdw_fw_node),
+					    "mipi-sdw-master-count", &count, 1);
+
+	if (ret) {
+		dev_err(dev,
+			"Failed to read mipi-sdw-master-count: %d\n", ret);
+		return -EINVAL;
+	}
+
+	/* Check count is within bounds */
+	if (count > AMD_SDW_MAX_CONTROLLERS) {
+		dev_err(dev, "Controller count %d exceeds max %d\n",
+			count, AMD_SDW_MAX_CONTROLLERS);
+		return -EINVAL;
+	}
+
+	if (!count) {
+		dev_warn(dev, "No SoundWire controllers detected\n");
+		return -EINVAL;
+	}
+	dev_dbg(dev, "ACPI reports %d Soundwire Controller devices\n", count);
+	acp_data->sdw_master_count  = count;
+	for (index = 0; index < count; index++) {
+		snprintf(name, sizeof(name), "mipi-sdw-link-%d-subproperties", index);
+		link = fwnode_get_named_child_node(acp_data->sdw_fw_node, name);
+		if (!link) {
+			dev_err(dev, "Master node %s not found\n", name);
+			return -EIO;
+		}
+
+		fwnode_property_read_u32(link, "amd-sdw-power-mode",
+					 &acp_sdw_power_mode);
+		if (acp_sdw_power_mode != AMD_SDW_POWER_OFF_MODE)
+			acp_data->acp_sdw_power_off = false;
+	}
+	return 0;
+}
+
+static int get_acp63_device_config(u32 config, struct pci_dev *pci, struct acp63_dev_data *acp_data)
 {
 	struct acpi_device *dmic_dev;
+	struct acpi_device *sdw_dev;
+	struct device *dev;
 	const union acpi_object *obj;
 	bool is_dmic_dev = false;
+	bool is_sdw_dev = false;
+	int ret;
+
+	dev = &pci->dev;
 
 	dmic_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_DMIC_ADDR, 0);
 	if (dmic_dev) {
@@ -149,22 +206,84 @@ static void get_acp63_device_config(u32 config, struct pci_dev *pci,
 			is_dmic_dev = true;
 	}
 
+	sdw_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_SDW_ADDR, 0);
+	if (sdw_dev) {
+		is_sdw_dev = true;
+		acp_data->sdw_fw_node = acpi_fwnode_handle(sdw_dev);
+		ret = sdw_amd_scan_controller(dev);
+		if (ret)
+			return ret;
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
+			switch (acp_data->sdw_master_count) {
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
+			switch (acp_data->sdw_master_count) {
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
+			switch (acp_data->sdw_master_count) {
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
@@ -188,6 +307,7 @@ static void acp63_fill_platform_dev_info(struct platform_device_info *pdevinfo,
 
 static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data *adata, u32 addr)
 {
+	struct acp_sdw_pdata *sdw_pdata;
 	struct platform_device_info pdevinfo[ACP63_DEVS];
 	struct device *parent;
 	int index;
@@ -220,8 +340,110 @@ static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data
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
+			sdw_pdata->sdw_lock = &adata->acp_lock;
+			adata->sdw0_dev_index = 0;
+			adata->sdw_dma_dev_index = 1;
+			acp63_fill_platform_dev_info(&pdevinfo[0], parent, adata->sdw_fw_node,
+						     "amd_sdw_controller", 0, adata->res, 1,
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
+			sdw_pdata[0].sdw_lock = &adata->acp_lock;
+			sdw_pdata[1].sdw_lock = &adata->acp_lock;
+			sdw_pdata->sdw_lock = &adata->acp_lock;
+			adata->sdw0_dev_index = 0;
+			adata->sdw1_dev_index = 1;
+			adata->sdw_dma_dev_index = 2;
+			acp63_fill_platform_dev_info(&pdevinfo[0], parent, adata->sdw_fw_node,
+						     "amd_sdw_controller", 0, adata->res, 1,
+						     &sdw_pdata[0], sizeof(struct acp_sdw_pdata));
+			acp63_fill_platform_dev_info(&pdevinfo[1], parent, adata->sdw_fw_node,
+						     "amd_sdw_controller", 1, adata->res, 1,
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
+			sdw_pdata->sdw_lock = &adata->acp_lock;
+			adata->pdm_dev_index  = 0;
+			adata->sdw0_dev_index = 1;
+			adata->sdw_dma_dev_index = 2;
+			acp63_fill_platform_dev_info(&pdevinfo[0], parent, NULL, "acp_ps_pdm_dma",
+						     0, adata->res, 1, &adata->acp_lock,
+						     sizeof(adata->acp_lock));
+			acp63_fill_platform_dev_info(&pdevinfo[1], parent, adata->sdw_fw_node,
+						     "amd_sdw_controller", 0, adata->res, 1,
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
+			sdw_pdata[0].sdw_lock = &adata->acp_lock;
+			sdw_pdata[1].sdw_lock = &adata->acp_lock;
+			adata->pdm_dev_index = 0;
+			adata->sdw0_dev_index = 1;
+			adata->sdw1_dev_index = 2;
+			adata->sdw_dma_dev_index = 3;
+			acp63_fill_platform_dev_info(&pdevinfo[0], parent, NULL, "acp_ps_pdm_dma",
+						     0, adata->res, 1, &adata->acp_lock,
+						     sizeof(adata->acp_lock));
+			acp63_fill_platform_dev_info(&pdevinfo[1], parent, adata->sdw_fw_node,
+						     "amd_sdw_controller", 0, adata->res, 1,
+						     &sdw_pdata[0], sizeof(struct acp_sdw_pdata));
+			acp63_fill_platform_dev_info(&pdevinfo[2], parent, adata->sdw_fw_node,
+						     "amd_sdw_controller", 1, adata->res, 1,
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
+		dev_dbg(&pci->dev, "No PDM or Soundwire controller devices found\n");
 		return 0;
 	}
 
@@ -299,7 +521,11 @@ static int snd_acp63_probe(struct pci_dev *pci,
 		goto de_init;
 	}
 	val = acp63_readl(adata->acp63_base + ACP_PIN_CONFIG);
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

