Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2282E69416C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjBMJi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjBMJi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:38:29 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18C7EC7A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:37:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjRXQuLpIqjOIEMtXpnT2/MnTqrXxx5sxdYLSBkowIhtyEZbbWKZbLNWKAJviqJnrsqtz76EjyrkpAiwk+kQssyTIA69mJbK5k+ntQWoxhOw7ff5gbxku0f2iJy4FH4xw1jcvHV/HxqUNzYr2SkYuBk8O3GEBvnsJwXTBo9seZx54zz7V8qKDPd2ZXmQX3QhI5xlcMoB38xmhH5PWBN0Gdl/gdYAMfBK0eKESf3V2dSk13HlKS9Lx09EiuHFk+/hzHOULWpCOaHGHJV1hAA28goRshR90Tpl3EAHnm+Y7IDHFbeT6v0J1byRabe5N7npBpzG4NPvd6F/NtH+rbIuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiUIwZ8+iiA7zU5Dwk7Ygl963m5EXkZ7DGN/LbZrqpQ=;
 b=afObX2LoAfx1kpPMDr4gzY7tJw4ngAJZWnVdwF81EEfIb//Ic/RUw+ZPBe7vc8oKgi4xrMU7OpJHPq42j0bK3i0pxlcEkjIQn3hR/wVON7PDBAJBK11okSfMRuMNOing/rGBHuwh6E/2IJfDJ2oFpOJSlJvgj+aQZYd2ponsLjQBaydfhEw4GtFmPOoSF1/3Gfbd5y+CA4UKoHnkBNZiD0cJKT6vXTz9h3ExDwWr7WIwPEom+URLsrbjGq6FNLMq/EyLNSzwiLHn+3oBcqWfEIRxOLBxUioe+5ixZzvnDEDGnWjdYZKtn9LGEcQLXPz570FLWB5r7/D3IyCvLylidw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiUIwZ8+iiA7zU5Dwk7Ygl963m5EXkZ7DGN/LbZrqpQ=;
 b=h4uo2blMSMbIVXYU+81gsJJRX2nY6xDt0b108frUaLRT1Swz5fF1cP3uHElH/SjZkZYajgQcOU0kcXLOUbO95x0/jwHg2yr2kzp0xB3sIfuXTfq78iaYpA9rSeQbe5Sc5xOLDa06d90x/l0B/H7aEBXQa47VtnwNF3qWkXjb1TM=
Received: from BN9PR03CA0717.namprd03.prod.outlook.com (2603:10b6:408:ef::32)
 by CH0PR12MB5217.namprd12.prod.outlook.com (2603:10b6:610:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 09:37:54 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::69) by BN9PR03CA0717.outlook.office365.com
 (2603:10b6:408:ef::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Mon, 13 Feb 2023 09:37:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.24 via Frontend Transport; Mon, 13 Feb 2023 09:37:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Feb
 2023 03:37:53 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 13 Feb 2023 03:37:49 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <vkoul@kernel.org>
CC:     <amadeuszx.slawinski@linux.intel.com>, <Mario.Limonciello@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        "moderated list:SOUNDWIRE SUBSYSTEM" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 6/8] soundwire: amd: add runtime pm ops for AMD soundwire manager driver
Date:   Mon, 13 Feb 2023 15:10:29 +0530
Message-ID: <20230213094031.2231058-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230213094031.2231058-1-Vijendar.Mukunda@amd.com>
References: <20230213094031.2231058-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|CH0PR12MB5217:EE_
X-MS-Office365-Filtering-Correlation-Id: 858a9f1b-bc84-49cb-a6db-08db0da5fb48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ibqMqXUfgV5PyniEJqL94i9oKm3J2YOKLhRQoEcxbKs4E61OjBAgtLUsu4emKbDXAs7Em0cP93TadED8Gp2BUTBXqHYFdNiemv9q4PksrAdCIXQzjjgqwcn+vJilGdZWhvArMcXIzIFFIblcm+lPfuQLIFIDoN8141VB93M+SfSAl6hy6lEYKVEF3YhBlM9pziNcdmc9SB7CQ9qf/cXdHBEeOL229d0xesBb1dtnYcSgOKSGgiteqGtYcIBUs4VxnaCRb0s+1Cqs+J++0svlMTawI+sdWBTnx22ziI6uzBoQsjT3K0VDz+97jcIeUQDw1ubsfknMnFB+yMVtHgz7c5bSUjt9DdjpeeChwPhYKfpHM6+nbPPUhWhr7ayVCm0lK18EupKuGrdMRkOwKUGoinfu/et1Xhr9QXZ83tOHAvvd/OsVOwoZzc3MvjBvxiB0KYEqVxyN3WkFMiUcxRJrnmcvNtDcOQTYfKJ4DcORtNWPYSrZ38eDygVJM4SUvXi2lz+z/4USYb22gC+G7a1vLs6GpvcRWKlPKadQB/bRbhmhszcItDWwPz4Zn+eSXSwAmET+MrBCz7qDkcYGigJcuV6xcS/MUvUK0RIko7yP1EZuob8Xle7uZP9xHL9p8kvhULlqSF2wcpqBSee68N6aM125gGyM+k7WdV5WH2gYsB5frM2ohjK4sS0wcwynqaIPwD17GLWs2OhEW+g5+UcJ9z+5rjsoteIYtABXSLUu39Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199018)(46966006)(40470700004)(36840700001)(186003)(26005)(316002)(7696005)(54906003)(1076003)(2616005)(478600001)(70206006)(70586007)(8676002)(6916009)(4326008)(6666004)(336012)(8936002)(426003)(47076005)(41300700001)(5660300002)(83380400001)(356005)(40460700003)(2906002)(36860700001)(82740400003)(81166007)(36756003)(86362001)(40480700001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 09:37:53.9195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 858a9f1b-bc84-49cb-a6db-08db0da5fb48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5217
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for runtime pm ops for AMD soundwire manager driver.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
---
 drivers/soundwire/amd_manager.c   | 163 ++++++++++++++++++++++++++++++
 drivers/soundwire/amd_manager.h   |   3 +
 include/linux/soundwire/sdw_amd.h |  16 +++
 3 files changed, 182 insertions(+)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 87f9a987d93a..eced189ba6e0 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_registers.h>
+#include <linux/pm_runtime.h>
 #include <linux/wait.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -185,6 +186,15 @@ static void amd_disable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
 	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
 }
 
+static int amd_deinit_sdw_manager(struct amd_sdw_manager *amd_manager)
+{
+	int ret;
+
+	amd_disable_sdw_interrupts(amd_manager);
+	ret = amd_disable_sdw_manager(amd_manager);
+	return ret;
+}
+
 static void amd_sdw_set_frameshape(struct amd_sdw_manager *amd_manager)
 {
 	u32 frame_size;
@@ -1043,6 +1053,12 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
 	INIT_WORK(&amd_manager->amd_sdw_work, amd_sdw_update_slave_status_work);
 	INIT_WORK(&amd_manager->probe_work, amd_sdw_probe_work);
 	schedule_work(&amd_manager->probe_work);
+	/* Enable runtime PM */
+	pm_runtime_set_autosuspend_delay(dev, AMD_SDW_MASTER_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
 	return 0;
 }
 
@@ -1057,14 +1073,161 @@ static int amd_sdw_manager_remove(struct platform_device *pdev)
 	amd_disable_sdw_interrupts(amd_manager);
 	sdw_bus_master_delete(&amd_manager->bus);
 	ret = amd_disable_sdw_manager(amd_manager);
+	pm_runtime_disable(&pdev->dev);
 	return ret;
 }
 
+static int amd_sdw_clock_stop(struct amd_sdw_manager *amd_manager)
+{
+	u32 val;
+	u32 retry_count = 0;
+	int ret;
+
+	ret = sdw_bus_prep_clk_stop(&amd_manager->bus);
+	if (ret < 0 && ret != -ENODATA) {
+		dev_err(amd_manager->dev, "prepare clock stop failed %d", ret);
+		return 0;
+	}
+	ret = sdw_bus_clk_stop(&amd_manager->bus);
+	if (ret < 0 && ret != -ENODATA) {
+		dev_err(amd_manager->dev, "bus clock stop failed %d", ret);
+		return 0;
+	}
+
+	do {
+		val = acp_reg_readl(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
+		if (val & AMD_SDW_CLK_STOP_DONE) {
+			amd_manager->clk_stopped = true;
+			break;
+		}
+	} while (retry_count++ < AMD_SDW_CLK_STOP_MAX_RETRY_COUNT);
+
+	if (!amd_manager->clk_stopped) {
+		dev_err(amd_manager->dev, "SDW%x clock stop failed\n", amd_manager->instance);
+		return 0;
+	}
+
+	if (amd_manager->wake_en_mask)
+		acp_reg_writel(0x01, amd_manager->acp_mmio + ACP_SW_WAKE_EN(amd_manager->instance));
+
+	dev_dbg(amd_manager->dev, "SDW%x clock stop successful\n", amd_manager->instance);
+	return 0;
+}
+
+static int amd_sdw_clock_stop_exit(struct amd_sdw_manager *amd_manager)
+{
+	int ret;
+	u32 val = 0;
+	u32 retry_count = 0;
+
+	if (amd_manager->clk_stopped) {
+		val = acp_reg_readl(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
+		val |= AMD_SDW_CLK_RESUME_REQ;
+		acp_reg_writel(val, amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
+		do {
+			val = acp_reg_readl(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
+			if (val & AMD_SDW_CLK_RESUME_DONE)
+				break;
+			usleep_range(10, 100);
+		} while (retry_count++ < AMD_SDW_CLK_STOP_MAX_RETRY_COUNT);
+		if (val & AMD_SDW_CLK_RESUME_DONE) {
+			acp_reg_writel(0, amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
+			ret = sdw_bus_exit_clk_stop(&amd_manager->bus);
+			if (ret < 0)
+				dev_err(amd_manager->dev, "bus failed to exit clock stop %d\n",
+					ret);
+			amd_manager->clk_stopped = false;
+		}
+	}
+	if (amd_manager->clk_stopped) {
+		dev_err(amd_manager->dev, "SDW%x clock stop exit failed\n", amd_manager->instance);
+		return 0;
+	}
+	dev_dbg(amd_manager->dev, "SDW%x clock stop exit successful\n", amd_manager->instance);
+	return 0;
+}
+
+static int __maybe_unused amd_suspend_runtime(struct device *dev)
+{
+	struct amd_sdw_manager *amd_manager = dev_get_drvdata(dev);
+	struct sdw_bus *bus = &amd_manager->bus;
+	int ret;
+
+	if (bus->prop.hw_disabled) {
+		dev_dbg(bus->dev, "Soundwire manager %d is disabled,\n",
+			bus->link_id);
+		return 0;
+	}
+	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
+		ret = amd_sdw_clock_stop(amd_manager);
+		if (ret)
+			return ret;
+	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
+		ret = amd_sdw_clock_stop(amd_manager);
+		if (ret)
+			return ret;
+		ret = amd_deinit_sdw_manager(amd_manager);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static int __maybe_unused amd_resume_runtime(struct device *dev)
+{
+	struct amd_sdw_manager *amd_manager = dev_get_drvdata(dev);
+	struct sdw_bus *bus = &amd_manager->bus;
+	int ret;
+	u32 val = 0;
+	u32 retry_count = 0;
+
+	if (bus->prop.hw_disabled) {
+		dev_dbg(bus->dev, "Soundwire manager %d is disabled, ignoring\n",
+			bus->link_id);
+		return 0;
+	}
+
+	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
+		ret = amd_sdw_clock_stop_exit(amd_manager);
+		if (ret)
+			return ret;
+	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
+		val = acp_reg_readl(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
+		if (val) {
+			val |= AMD_SDW_CLK_RESUME_REQ;
+			acp_reg_writel(val, amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
+			do {
+				val = acp_reg_readl(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
+				if (val & AMD_SDW_CLK_RESUME_DONE)
+					break;
+				usleep_range(10, 100);
+			} while (retry_count++ < AMD_SDW_CLK_STOP_MAX_RETRY_COUNT);
+			if (val & AMD_SDW_CLK_RESUME_DONE) {
+				acp_reg_writel(0, amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
+				amd_manager->clk_stopped = false;
+			}
+		}
+		sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
+		amd_init_sdw_manager(amd_manager);
+		amd_enable_sdw_interrupts(amd_manager);
+		ret = amd_enable_sdw_manager(amd_manager);
+		if (ret)
+			return ret;
+		amd_sdw_set_frameshape(amd_manager);
+	}
+	return 0;
+}
+
+static const struct dev_pm_ops amd_pm = {
+	SET_RUNTIME_PM_OPS(amd_suspend_runtime, amd_resume_runtime, NULL)
+};
+
 static struct platform_driver amd_sdw_driver = {
 	.probe	= &amd_sdw_manager_probe,
 	.remove = &amd_sdw_manager_remove,
 	.driver = {
 		.name	= "amd_sdw_manager",
+		.pm = &amd_pm,
 	}
 };
 module_platform_driver(amd_sdw_driver);
diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
index 5bcaf7a763bb..6ec37612ae4e 100644
--- a/drivers/soundwire/amd_manager.h
+++ b/drivers/soundwire/amd_manager.h
@@ -187,6 +187,9 @@
 #define AMD_SDW0_PAD_KEEPER_DISABLE_MASK		0x1E
 #define AMD_SDW1_PAD_KEEPER_DISABLE_MASK		0xF
 #define AMD_SDW_PREQ_INTR_STAT				BIT(19)
+#define AMD_SDW_CLK_STOP_DONE				1
+#define AMD_SDW_CLK_RESUME_REQ				2
+#define AMD_SDW_CLK_RESUME_DONE				3
 
 enum amd_sdw_cmd_type {
 	AMD_SDW_CMD_PING = 0,
diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
index 003b8a197fc5..9074c7736ff7 100644
--- a/include/linux/soundwire/sdw_amd.h
+++ b/include/linux/soundwire/sdw_amd.h
@@ -8,6 +8,20 @@
 
 #include <linux/soundwire/sdw.h>
 
+/* AMD pm_runtime quirk definitions */
+
+/*
+ * Force the clock to stop(ClockStopMode0) when suspend callback
+ * is invoked.
+ */
+#define AMD_SDW_CLK_STOP_MODE		1
+
+/*
+ * Stop the bus when runtime suspend/system level suspend callback
+ * is invoked. If set, a complete bus reset and re-enumeration will
+ * be performed when the bus restarts.
+ */
+#define AMD_SDW_POWER_OFF_MODE		2
 #define ACP_SDW0	0
 #define ACP_SDW1	1
 
@@ -57,6 +71,7 @@ struct sdw_amd_dai_runtime {
  * @instance: soundwire manager instance
  * @quirks: soundwire manager quirks
  * @wake_en_mask: wake enable mask per soundwire manager
+ * @clk_stopped: flag set to true when clock is stopped
  * @power_mode_mask: flag interprets amd soundwire manager power mode
  * @dai_runtime_array: dai runtime array
  */
@@ -86,6 +101,7 @@ struct amd_sdw_manager {
 	u32 quirks;
 	u32 wake_en_mask;
 	u32 power_mode_mask;
+	bool clk_stopped;
 
 	struct sdw_amd_dai_runtime **dai_runtime_array;
 };
-- 
2.34.1

