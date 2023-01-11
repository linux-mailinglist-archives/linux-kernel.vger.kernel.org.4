Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24F46656E0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbjAKJFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237975AbjAKJEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:04:36 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E1211C05
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:02:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmNqueF33xNmOm9MCRDiBSEpNNB+yTLzhfEzIs1ycnPNYsOIrj3Z4Ot0hRubVLnQRCqx4cCA8KW51nDkD2B4QtR1wcGLVofaB/FIPjdEqqhuAOdikj2gNMKWcGt4EbPXJBxiA34DuFotPKaqYXr0C5vWaWnhP/QQJvvJLz6nSDfU6UTuGvXqmzmCOL5QKy6pmysxwOv0AJJozD7obzeInp1zKoBgLlPIOCGOeBvLwvaiuQhPPQcsVYHGRIupAQ2XHk72Ru624lEw1AZWADBvYMJ0arEXdQLjjgKoHLDGJ5gjFiDFN03omGngb3HZMHnR0h3T94uj+JztCLaRMUtW0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DV+zBcA69Ehh6cpMX+gJ7UMRUr9pdZBA7y2CTUgEiw=;
 b=Ej13p0y0vBEhPBcI9R5WkvkykltOIWD2v5SlzPDbfHNKHkZW6L8nJe8Jr081MLinLlhcU/O/kUNWoche+xQMuHAH/1U3roqim8XOEwwwKZLhyQfIRm6bEdwQQclgwB7Pk/gQMCQ4/uc15VsqmWJ/I+ik9fTpVXkQlf20brq87IqcsUwY5bBbUrG8zvPNSdT6B96lOlaYvpm+UOTB3PEjvrs6hEgLHhsaG1/QxafwQhraVBOeX3o2ddzkxFSOwKYPSHkdh3SVpKAmtAbcWb1u0M2sPd1ZKpbVPEIY59fQZX8MRwH1tmosyElOAACdFUjMgScciSfImJDnyd7x0Jnw0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DV+zBcA69Ehh6cpMX+gJ7UMRUr9pdZBA7y2CTUgEiw=;
 b=0TzkD9i2HZRvwqkIrurns04aqcrpiomThg1ll+ru5OMS/mXzwoBchJZ8Zn+QWAqKnjaR5a0cRmG7Dhod+DmtbKIW/8WLITwbhMD1zUUhqDI5rDOY5VUAoIryF+3Za+SLQkahQK64qQj1R8WpaTy+fiZ/d/LmLIsdp/GGnXo/pvA=
Received: from DM6PR06CA0063.namprd06.prod.outlook.com (2603:10b6:5:54::40) by
 CH0PR12MB5218.namprd12.prod.outlook.com (2603:10b6:610:d1::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Wed, 11 Jan 2023 09:02:43 +0000
Received: from DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::55) by DM6PR06CA0063.outlook.office365.com
 (2603:10b6:5:54::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Wed, 11 Jan 2023 09:02:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT104.mail.protection.outlook.com (10.13.173.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.12 via Frontend Transport; Wed, 11 Jan 2023 09:02:43 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 03:02:40 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 01:02:08 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 11 Jan 2023 03:02:05 -0600
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
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 14/19] soundwire: amd: add runtime pm ops for AMD master driver
Date:   Wed, 11 Jan 2023 14:32:17 +0530
Message-ID: <20230111090222.2016499-15-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT104:EE_|CH0PR12MB5218:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aeef880-60b6-4d70-47dc-08daf3b299b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CJywnbzqIcqkEKQguTEEbbwrWj0cBNnFkXmjKrMr2xCXXVJgaQZRk0mtM85F5UCZoBRwQamPWUAOc02csIi5rM/uph/kuuhHfU1VtUQoHmHZ/7G+hI6z0gYMZjUxAhX0kp6J1dbtU7Eub5tm1aOJDv+49ILPGtM3TQXjAH8BMuYjMjOoZMZtSMSrD2iMl1++HmufVWTxMwIP3cVj/ZQUoJvqOBX48tJgVtJVMig35gRRHphd7KJRMv/VnNKsrt9YtVC6EhT5Ilsh4qaNoM/fvAiDK2gjF6SlqqQpb3yG+7oClOa9YKzCKyyZFXu5LUiRJxYNMUyQnDjfqnl0DQNvs/+rSD1tPsi+sCN+5R078r/+CYGg84TjfL+kM6CGnr7qgHitxuJ48niHU/jkmhvk09FWJj3uMGoioibNLnvYs/7AOnFbgXS4NtiNwBIB3Jphug814lkT2JBa895cSy5FGFfJQabeZmwBUx1HTsaF9Eu/qjeqmFdpvtj7e6mkRMbgJ525/thZbuz1LKDtjqMdk1ivquE3+84eZQ3yscyLEnRv7dxZy6XC3yTf1CELoquMp7VLYgyd2mcAyUhh485MuBCQQrJR4NxjNL/dQ848w7fIwq9CGCtc1jPF907fD404KaIbMKzfKUSrHG3W0MPjWqd9/CNw0D72i640qGdT9Vzra1clHkifUE+ybHBKoeDs5JrCZNlnZOEKxOQBjoDbAImHeC704w3nfTs1/UcOD4k=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(36840700001)(46966006)(40470700004)(2906002)(82310400005)(47076005)(83380400001)(336012)(36860700001)(426003)(81166007)(7696005)(2616005)(1076003)(40480700001)(5660300002)(8936002)(6666004)(36756003)(186003)(26005)(478600001)(70586007)(70206006)(8676002)(54906003)(110136005)(41300700001)(86362001)(356005)(316002)(4326008)(40460700003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 09:02:43.3825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aeef880-60b6-4d70-47dc-08daf3b299b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5218
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for runtime pm ops for AMD master driver.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
---
 drivers/soundwire/amd_master.c    | 205 ++++++++++++++++++++++++++++++
 drivers/soundwire/amd_master.h    |   3 +
 include/linux/soundwire/sdw_amd.h |   1 +
 3 files changed, 209 insertions(+)

diff --git a/drivers/soundwire/amd_master.c b/drivers/soundwire/amd_master.c
index c7063b8bdd7b..d2d7f07de202 100644
--- a/drivers/soundwire/amd_master.c
+++ b/drivers/soundwire/amd_master.c
@@ -15,6 +15,7 @@
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_registers.h>
 #include <linux/soundwire/sdw_amd.h>
+#include <linux/pm_runtime.h>
 #include <linux/wait.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -290,6 +291,17 @@ static int amd_disable_sdw_interrupts(struct amd_sdwc_ctrl *ctrl)
 	return 0;
 }
 
+static int amd_deinit_sdw_controller(struct amd_sdwc_ctrl *ctrl)
+{
+	int ret;
+
+	ret = amd_disable_sdw_interrupts(ctrl);
+	if (ret)
+		return ret;
+	ret = amd_disable_sdw_controller(ctrl);
+	return ret;
+}
+
 static int amd_sdwc_set_frameshape(struct amd_sdwc_ctrl *ctrl, u32 rows, u32 cols)
 {
 	u32 sdw_rows, sdw_cols, frame_size;
@@ -1387,6 +1399,12 @@ static int amd_sdwc_probe(struct platform_device *pdev)
 	INIT_WORK(&ctrl->amd_sdw_work, amd_sdwc_update_slave_status_work);
 	INIT_WORK(&ctrl->probe_work, amd_sdwc_probe_work);
 	schedule_work(&ctrl->probe_work);
+	/* Enable runtime PM */
+	pm_runtime_set_autosuspend_delay(dev, AMD_SDW_MASTER_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
 	return 0;
 }
 
@@ -1398,14 +1416,201 @@ static int amd_sdwc_remove(struct platform_device *pdev)
 	amd_disable_sdw_interrupts(ctrl);
 	sdw_bus_master_delete(&ctrl->bus);
 	ret = amd_disable_sdw_controller(ctrl);
+	pm_runtime_disable(&pdev->dev);
 	return ret;
 }
 
+static int amd_sdwc_clock_stop(struct amd_sdwc_ctrl *ctrl)
+{
+	u32 clk_resume_ctrl_reg;
+	u32 wake_en_reg;
+	u32 val;
+	u32 retry_count = 0;
+	int ret;
+
+	ret = sdw_bus_prep_clk_stop(&ctrl->bus);
+	if (ret < 0 && ret != -ENODATA) {
+		dev_err(ctrl->dev, "prepare clock stop failed %d", ret);
+		return ret;
+	}
+	ret = sdw_bus_clk_stop(&ctrl->bus);
+	if (ret < 0 && ret != -ENODATA) {
+		dev_err(ctrl->dev, "bus clock stop failed %d", ret);
+		return ret;
+	}
+	switch (ctrl->instance) {
+	case ACP_SDW0:
+		clk_resume_ctrl_reg = ACP_SW_CLK_RESUME_CTRL;
+		wake_en_reg = ACP_SW_WAKE_EN;
+		break;
+	case ACP_SDW1:
+		clk_resume_ctrl_reg = ACP_P1_SW_CLK_RESUME_CTRL;
+		wake_en_reg = ACP_SW1_WAKE_EN;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	do {
+		val = acp_reg_readl(ctrl->mmio + clk_resume_ctrl_reg);
+		if (val & AMD_SDW_CLK_STOP_DONE) {
+			ctrl->clk_stopped = true;
+			break;
+		}
+	} while (retry_count++ < AMD_SDW_CLK_STOP_MAX_RETRY_COUNT);
+
+	if (!ctrl->clk_stopped) {
+		dev_err(ctrl->dev, "SDW%x clock stop failed\n", ctrl->instance);
+		return -ETIMEDOUT;
+	}
+
+	if (ctrl->wake_en_mask)
+		acp_reg_writel(0x01, ctrl->mmio + wake_en_reg);
+
+	dev_dbg(ctrl->dev, "SDW%x clock stop successful\n", ctrl->instance);
+	return 0;
+}
+
+static int amd_sdwc_clock_stop_exit(struct amd_sdwc_ctrl *ctrl)
+{
+	int ret;
+	u32 clk_resume_ctrl_reg;
+	u32 val = 0;
+	u32 retry_count = 0;
+
+	switch (ctrl->instance) {
+	case ACP_SDW0:
+		clk_resume_ctrl_reg = ACP_SW_CLK_RESUME_CTRL;
+		break;
+	case ACP_SDW1:
+		clk_resume_ctrl_reg = ACP_P1_SW_CLK_RESUME_CTRL;
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (ctrl->clk_stopped) {
+		val = acp_reg_readl(ctrl->mmio + clk_resume_ctrl_reg);
+		val |= AMD_SDW_CLK_RESUME_REQ;
+		acp_reg_writel(val, ctrl->mmio + clk_resume_ctrl_reg);
+		do {
+			val = acp_reg_readl(ctrl->mmio + clk_resume_ctrl_reg);
+			if (val & AMD_SDW_CLK_RESUME_DONE)
+				break;
+			usleep_range(10, 100);
+		} while (retry_count++ < AMD_SDW_CLK_STOP_MAX_RETRY_COUNT);
+		if (val & AMD_SDW_CLK_RESUME_DONE) {
+			acp_reg_writel(0, ctrl->mmio + clk_resume_ctrl_reg);
+			ret = sdw_bus_exit_clk_stop(&ctrl->bus);
+			if (ret < 0)
+				dev_err(ctrl->dev, "bus failed to exit clock stop %d\n", ret);
+			ctrl->clk_stopped = false;
+		}
+	}
+	if (ctrl->clk_stopped) {
+		dev_err(ctrl->dev, "SDW%x clock stop exit failed\n", ctrl->instance);
+		return -ETIMEDOUT;
+	}
+
+	dev_dbg(ctrl->dev, "SDW%x clock stop exit successful\n", ctrl->instance);
+
+	return 0;
+}
+
+static int __maybe_unused amd_suspend_runtime(struct device *dev)
+{
+	struct amd_sdwc_ctrl *ctrl = dev_get_drvdata(dev);
+	struct sdw_bus *bus = &ctrl->bus;
+	int ret;
+
+	if (bus->prop.hw_disabled || !ctrl->startup_done) {
+		dev_dbg(bus->dev, "SoundWire master %d is disabled or not-started, ignoring\n",
+			bus->link_id);
+		return 0;
+	}
+	if (ctrl->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
+		ret = amd_sdwc_clock_stop(ctrl);
+		if (ret)
+			return ret;
+	} else if (ctrl->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
+		ret = amd_sdwc_clock_stop(ctrl);
+		if (ret)
+			return ret;
+		ret = amd_deinit_sdw_controller(ctrl);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static int __maybe_unused amd_resume_runtime(struct device *dev)
+{
+	struct amd_sdwc_ctrl *ctrl = dev_get_drvdata(dev);
+	struct sdw_bus *bus = &ctrl->bus;
+	int ret;
+	u32 clk_resume_ctrl_reg;
+	u32 val = 0;
+	u32 retry_count = 0;
+
+	if (bus->prop.hw_disabled || !ctrl->startup_done) {
+		dev_dbg(bus->dev, "SoundWire master %d is disabled or not-started, ignoring\n",
+			bus->link_id);
+		return 0;
+	}
+
+	switch (ctrl->instance) {
+	case ACP_SDW0:
+		clk_resume_ctrl_reg = ACP_SW_CLK_RESUME_CTRL;
+		break;
+	case ACP_SDW1:
+		clk_resume_ctrl_reg = ACP_P1_SW_CLK_RESUME_CTRL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ctrl->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
+		ret = amd_sdwc_clock_stop_exit(ctrl);
+		if (ret)
+			return ret;
+	} else if (ctrl->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
+		val = acp_reg_readl(ctrl->mmio + clk_resume_ctrl_reg);
+		if (val) {
+			val |= AMD_SDW_CLK_RESUME_REQ;
+			acp_reg_writel(val, ctrl->mmio + clk_resume_ctrl_reg);
+			do {
+				val = acp_reg_readl(ctrl->mmio + clk_resume_ctrl_reg);
+				if (val & AMD_SDW_CLK_RESUME_DONE)
+					break;
+				usleep_range(10, 100);
+			} while (retry_count++ < AMD_SDW_CLK_STOP_MAX_RETRY_COUNT);
+			if (val & AMD_SDW_CLK_RESUME_DONE) {
+				acp_reg_writel(0, ctrl->mmio + clk_resume_ctrl_reg);
+				ctrl->clk_stopped = false;
+			}
+		}
+		sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
+		amd_init_sdw_controller(ctrl);
+		amd_enable_sdw_interrupts(ctrl);
+		ret = amd_enable_sdw_controller(ctrl);
+		if (ret)
+			return ret;
+		ret = amd_sdwc_set_frameshape(ctrl, 50, 10);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static const struct dev_pm_ops amd_pm = {
+	SET_RUNTIME_PM_OPS(amd_suspend_runtime, amd_resume_runtime, NULL)
+};
+
 static struct platform_driver amd_sdwc_driver = {
 	.probe	= &amd_sdwc_probe,
 	.remove = &amd_sdwc_remove,
 	.driver = {
 		.name	= "amd_sdw_controller",
+		.pm = &amd_pm,
 	}
 };
 module_platform_driver(amd_sdwc_driver);
diff --git a/drivers/soundwire/amd_master.h b/drivers/soundwire/amd_master.h
index b43a5d6496cb..cc254255512b 100644
--- a/drivers/soundwire/amd_master.h
+++ b/drivers/soundwire/amd_master.h
@@ -237,6 +237,9 @@
 #define AMD_SDW0_PAD_KEEPER_DISABLE_MASK        0x1E
 #define AMD_SDW1_PAD_KEEPER_DISABLE_MASK	0xF
 #define AMD_SDW_PREQ_INTR_STAT  BIT(19)
+#define AMD_SDW_CLK_STOP_DONE		1
+#define AMD_SDW_CLK_RESUME_REQ		2
+#define AMD_SDW_CLK_RESUME_DONE		3
 
 enum amd_sdw_channel {
 	/* SDW0 */
diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
index 2db03b2f0c3b..f362f195b887 100644
--- a/include/linux/soundwire/sdw_amd.h
+++ b/include/linux/soundwire/sdw_amd.h
@@ -38,6 +38,7 @@ struct amd_sdwc_ctrl {
 	u32 quirks;
 	u32 wake_en_mask;
 	int num_ports;
+	bool clk_stopped;
 	bool startup_done;
 	u32 power_mode_mask;
 };
-- 
2.34.1

