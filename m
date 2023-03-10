Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2996B4CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjCJQ0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjCJQ0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:26:13 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84FB13DC2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:22:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVx8ZDKyrprrt7C7JGwuo0psMq1d4G3J4nzuGHjkQ7LyS2L9ivWmONGvPllxtcaxg4DKfsICUygqSpOHjhRfe+Gf/zdo1wxlOT3u4wzmDi3Yku/QWJ4U+w9FgjRiRIxn6zZ4Vq0w1cLwcQIjmGVDXbED/D6gQt5xUWwxuDYq5tKTlkWx8wd+lOIguqhB4kOSPnghoh9STexHWL8C+s2ABBZWIhjnr/ipXk+DqgiF4yNm6HqANSM8J7BhcTGp3eg8t0taVA/M3vmNODnj9ft+KVY8OhbOTLERYajW+NsfooK7la3UFMrtSjrRNML4PGtfsYMCJM2xM6uhUMQFZdQXvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghcvbF3RTASixaB5pofqKIoeoHLOg3t0DAgOf/U8GtU=;
 b=AkBYLy972jyeBJA9WV5T6jxv0f2QVlJslRpJesPbKgrELYjqRGVCrcTMxbh1DKvbCV81VWK6b8jkHdZJJSut9IuViwHs+WNmgXNU6/YZF85gdd9t6hcVzASWXFFNn7No8Uqq0+wfUR9O/SHgyPwrQoPWFDSwKkG7fW550BrvQL4zRNqAYNzUW/1B5oFdRuYI3cl93NEfLD7dzIB+7IyBIKvntUuagzgfDXRwSoomlP/MzJ1Px8BCM99VdB4FYdzJ44leHIlG4017H6HZnHJXjnQE2JUJu6G/I9MwqE0NZFRdubdPpvWdeXhLmjZdnofg1ZkWxSvB5N+BzrmbvLOWVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghcvbF3RTASixaB5pofqKIoeoHLOg3t0DAgOf/U8GtU=;
 b=NXSggi0JU/fzzyTsAf1GD8atjoXBRgKCDa6YV/mJNQAUsZfe05F2Wzx8oddpGdj6UrfqByIv8tkXFtHHY4FmP+GnbboalvkLvkR2NaBTJehFfExE9GPfigMKdoemnIrZlyfwblzr5wjJQhv/98htrdCd8b/1dXqK+ZnIql/pWMg=
Received: from BN9P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::24)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 16:22:28 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::e6) by BN9P220CA0019.outlook.office365.com
 (2603:10b6:408:13e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 16:22:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.20 via Frontend Transport; Fri, 10 Mar 2023 16:22:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 10:22:26 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Fri, 10 Mar 2023 10:22:23 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <vkoul@kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <pierre-louis.bossart@linux.intel.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>, <amadeuszx.slawinski@linux.intel.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        <claudiu.beznea@microchip.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V7 6/8] soundwire: amd: add runtime pm ops for AMD SoundWire manager driver
Date:   Fri, 10 Mar 2023 21:55:52 +0530
Message-ID: <20230310162554.699766-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310162554.699766-1-Vijendar.Mukunda@amd.com>
References: <20230310162554.699766-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|IA0PR12MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: a8459d61-f5ea-433f-b372-08db2183a45b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1jyCWk5XH+xQuRaoVCojfJaxm593JmdYUT2t40csYGH8UOi1qY0PrDaTuDQ+KX+LIu5gxtRp6ll+pv5emAN6Y8d8zYhzdspxBM3SvlFZ2QIExK5t6p9jrdbUX5ODLn0t5BTiFOs+7RRlv8WXRObHJ0LenO7CqQM+xfqCb1q9zpU9ZD/WVb3sxIeE4d2NU6hX+b3Q+bA8zlZS/wPfIc2AsxtEDMXteNNl34r1Ix+6FYjCYbdJZY1hhz/7zhF72Q2pF4W66F3bxNdX0Y2G8xxVGyrxrIZMO7x8moOug2+ZA4YX9Pb/KYMa21B2jo2udwNCjuH2QTieedPPuqmNTJqPGhxrCz/bUkIZTXu9hFFqc3CxGIsgfp1CY7+5FzIXO0C5fXWSlga+KasIe8S2efK933ryfOXuN0gx+RmeqynDjBml9SK2EZDJGL+3DGMgpPfXGAlpyFdyX6awUyKL95eHRSAmIn+gXxtA3ECD3Rr5uKN4UbLYMBJ/HO+qBGq5xr6D2DDVmO8mohV4HxVVmjnuogJHdswYvov7UErBjClRSM8FXQuQ0WfHT3x7+QE7iY3/kpNiC1mXCmdU1jtTopa6OD6ikQYaxF0I3cAoql5h4S99E7QhU0gIGfmtaYb8K2Dk6ZFaOHKXBNSkaguvIfQviCQilFDcbgL4FMpSRamJDomgow5oK6cZLZlCACYWa1y2E6YfGRxMrWGqsNgTYId86Q/aXQgHdaWqH5vzyxNnns0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199018)(36840700001)(46966006)(40470700004)(426003)(82310400005)(2616005)(478600001)(83380400001)(336012)(36860700001)(47076005)(40460700003)(2906002)(86362001)(40480700001)(54906003)(356005)(82740400003)(316002)(70586007)(8676002)(81166007)(6916009)(4326008)(36756003)(70206006)(5660300002)(8936002)(41300700001)(1076003)(6666004)(26005)(186003)(966005)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 16:22:28.4493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8459d61-f5ea-433f-b372-08db2183a45b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for runtime pm ops for AMD SoundWire manager driver.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/lkml/20230227154801.50319-7-Vijendar.Mukunda@amd.com
---
 drivers/soundwire/amd_manager.c   | 140 ++++++++++++++++++++++++++++++
 drivers/soundwire/amd_manager.h   |   3 +
 include/linux/soundwire/sdw_amd.h |  17 ++++
 3 files changed, 160 insertions(+)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 603668953329..5811a408ef93 100644
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
@@ -133,6 +134,12 @@ static void amd_disable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
 	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
 }
 
+static int amd_deinit_sdw_manager(struct amd_sdw_manager *amd_manager)
+{
+	amd_disable_sdw_interrupts(amd_manager);
+	return amd_disable_sdw_manager(amd_manager);
+}
+
 static void amd_sdw_set_frameshape(struct amd_sdw_manager *amd_manager)
 {
 	u32 frame_size;
@@ -904,6 +911,12 @@ static void amd_sdw_probe_work(struct work_struct *work)
 			return;
 		amd_sdw_set_frameshape(amd_manager);
 	}
+	/* Enable runtime PM */
+	pm_runtime_set_autosuspend_delay(amd_manager->dev, AMD_SDW_MASTER_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(amd_manager->dev);
+	pm_runtime_mark_last_busy(amd_manager->dev);
+	pm_runtime_set_active(amd_manager->dev);
+	pm_runtime_enable(amd_manager->dev);
 }
 
 static int amd_sdw_manager_probe(struct platform_device *pdev)
@@ -989,17 +1002,144 @@ static int amd_sdw_manager_remove(struct platform_device *pdev)
 {
 	struct amd_sdw_manager *amd_manager = dev_get_drvdata(&pdev->dev);
 
+	pm_runtime_disable(&pdev->dev);
 	cancel_work_sync(&amd_manager->probe_work);
 	amd_disable_sdw_interrupts(amd_manager);
 	sdw_bus_master_delete(&amd_manager->bus);
 	return amd_disable_sdw_manager(amd_manager);
 }
 
+static int amd_sdw_clock_stop(struct amd_sdw_manager *amd_manager)
+{
+	u32 val;
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
+	ret = read_poll_timeout(acp_reg_readl, val, (val & AMD_SDW_CLK_STOP_DONE), ACP_DELAY_US,
+				AMD_SDW_TIMEOUT, false,	amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
+	if (ret) {
+		dev_err(amd_manager->dev, "SDW%x clock stop failed\n", amd_manager->instance);
+		return 0;
+	}
+
+	amd_manager->clk_stopped = true;
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
+	u32 val;
+
+	if (amd_manager->clk_stopped) {
+		val = acp_reg_readl(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
+		val |= AMD_SDW_CLK_RESUME_REQ;
+		acp_reg_writel(val, amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
+		ret = read_poll_timeout(acp_reg_readl, val, (val & AMD_SDW_CLK_RESUME_DONE),
+					ACP_DELAY_US, AMD_SDW_TIMEOUT, false,
+					amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
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
+		dev_dbg(bus->dev, "SoundWire manager %d is disabled,\n",
+			bus->link_id);
+		return 0;
+	}
+	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
+		return amd_sdw_clock_stop(amd_manager);
+	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
+		ret = amd_sdw_clock_stop(amd_manager);
+		if (ret)
+			return ret;
+		return amd_deinit_sdw_manager(amd_manager);
+	}
+	return 0;
+}
+
+static int __maybe_unused amd_resume_runtime(struct device *dev)
+{
+	struct amd_sdw_manager *amd_manager = dev_get_drvdata(dev);
+	struct sdw_bus *bus = &amd_manager->bus;
+	int ret;
+	u32 val;
+
+	if (bus->prop.hw_disabled) {
+		dev_dbg(bus->dev, "SoundWire manager %d is disabled, ignoring\n",
+			bus->link_id);
+		return 0;
+	}
+
+	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
+		return amd_sdw_clock_stop_exit(amd_manager);
+	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
+		val = acp_reg_readl(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
+		if (val) {
+			val |= AMD_SDW_CLK_RESUME_REQ;
+			acp_reg_writel(val, amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
+			ret = read_poll_timeout(acp_reg_readl, val, (val & AMD_SDW_CLK_RESUME_DONE),
+						ACP_DELAY_US, AMD_SDW_TIMEOUT, false,
+						amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
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
index 807bc5a314d8..65bc79d8f7c9 100644
--- a/drivers/soundwire/amd_manager.h
+++ b/drivers/soundwire/amd_manager.h
@@ -186,6 +186,9 @@
 #define AMD_SDW0_PAD_KEEPER_DISABLE_MASK		0x1E
 #define AMD_SDW1_PAD_KEEPER_DISABLE_MASK		0xF
 #define AMD_SDW_PREQ_INTR_STAT				BIT(19)
+#define AMD_SDW_CLK_STOP_DONE				1
+#define AMD_SDW_CLK_RESUME_REQ				2
+#define AMD_SDW_CLK_RESUME_DONE				3
 
 enum amd_sdw_cmd_type {
 	AMD_SDW_CMD_PING = 0,
diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
index df60bc0de6fc..ceecad74aef9 100644
--- a/include/linux/soundwire/sdw_amd.h
+++ b/include/linux/soundwire/sdw_amd.h
@@ -8,6 +8,21 @@
 
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
+ * be performed when the bus restarts. In-band wake interrupts are
+ * not supported in this mode.
+ */
+#define AMD_SDW_POWER_OFF_MODE		2
 #define ACP_SDW0	0
 #define ACP_SDW1	1
 
@@ -57,6 +72,7 @@ struct sdw_amd_dai_runtime {
  * @instance: SoundWire manager instance
  * @quirks: SoundWire manager quirks
  * @wake_en_mask: wake enable mask per SoundWire manager
+ * @clk_stopped: flag set to true when clock is stopped
  * @power_mode_mask: flag interprets amd SoundWire manager power mode
  * @dai_runtime_array: dai runtime array
  */
@@ -86,6 +102,7 @@ struct amd_sdw_manager {
 	u32 quirks;
 	u32 wake_en_mask;
 	u32 power_mode_mask;
+	bool clk_stopped;
 
 	struct sdw_amd_dai_runtime **dai_runtime_array;
 };
-- 
2.34.1

