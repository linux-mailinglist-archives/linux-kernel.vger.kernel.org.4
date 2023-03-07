Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FCA6AE082
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjCGN2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjCGN21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:28:27 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2DE12054
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:28:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJUJO0pClBsDvUhbw+wkUYz/vym0E49EFyvd33RHyG0OchyC2bq0p2V68O0hL0Rq6l55QGjUTN0xP81kJsmG4kFiTilz5uX5SNlHavT9w/C6Zcj17cOWGsYyEkHY0M4cbMMd+46Xen9A8k02pSdmh/j6S+B2stP7tmFu72UvUrd+Y7QM3RaJrlU1d2YL/TdU2VTvPaP95fiXpqa7O/96pV03/Bbi7OODhN9LOJBrPuij42zmnMicMO5mQGCDxWqc3VB00cygZoIMtESIVVPR6tVgo9BKKa9EyWpse8rxXskEW6w9BdUt8fHet7XqVu/PMwfQZDsVSX9mlkzUo/tATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpuwsBwtuHyZdkiiT6g2c50kbLKYANs6OD6lVsqgj8Q=;
 b=Xd1BDfJHV1/XmWZl+mtPpuM5UmgbkCzRNNZEynaLl8WfV2CwaT6A7zrYbhVMezcp5cgiQoigUEEOpPh0NpqoSooaFdb6LHYETb8gsL9hVwFMki6eSH8QYaEBLyw3BJnoo6vgmy0ltAwc3tJvhzjklNGseIUzbX9UxquVO9hyYWOkl7JskiYzObYeRtm4jrHnXU5j0K/PoBlUhO8/TcWLQDk+WcEURWqClCc7Yl61ZfxE7QDONPi9BAwfJtJd8P4HkCD9d5LR2Tt1GjWofMAJaqR9cT6sky5fBxHs1nbm7mt5bix1J/tfnDIcEJbqui8n8gsSyC7QotR77jrBlUICmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpuwsBwtuHyZdkiiT6g2c50kbLKYANs6OD6lVsqgj8Q=;
 b=g2EFMbHeoOKlxLOQ0zq4OKEkHNDwMAJveIqSqRsyEoMrdIhJfFiU3HBonMKzm3mEPgaO+o+k+i1yJUBPX7Ej8AQwZ9r+S6mGF1XkF0nuP6SWGNhRbHstcArxLcoJ0iPJqc/7cndEJDLkv2ucIWMusfoChOoLapLnrtvHWmMapQo=
Received: from BL1P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::26)
 by SA3PR12MB7923.namprd12.prod.outlook.com (2603:10b6:806:317::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 13:28:00 +0000
Received: from BL02EPF0000EE3E.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::cb) by BL1P221CA0014.outlook.office365.com
 (2603:10b6:208:2c5::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Tue, 7 Mar 2023 13:28:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0000EE3E.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Tue, 7 Mar 2023 13:28:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 07:27:59 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 7 Mar 2023 07:27:56 -0600
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
Subject: [PATCH V6 6/8] soundwire: amd: add runtime pm ops for AMD SoundWire manager driver
Date:   Tue, 7 Mar 2023 19:01:33 +0530
Message-ID: <20230307133135.545952-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
References: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3E:EE_|SA3PR12MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e33b9d-0d12-49bd-d6e6-08db1f0fc580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dIFP5ProDYNH9mQmA91Z8W+LCmTpDqXr/akgWuYbM0aV93S1dh1YYUMe5cRd1yMUl0Sbivsl2pyKWQbS9kPiIMpc8/zbYyUuo0SukbKCLy3WicdJ8ipBTozz+D3LZvnTi8/iCwVem5aF/+UdxMlm0VguWQxyW0IqoQ15en9Y9xNzluppUd2eI3J51vqpIE2/gg1N6MiKOY7HzRFaJD6lRxcJlbn3k/BCfHRFzBX07PBF6T7uoCVsX6PEw/n8GSYv9uSeya4ruu08MEBqB8an9LGqw2ra9oNVwqSjOL12B1NiMTizyIh7I0NK97txGwD0l2lOHRkriyqTVOACBfJjLdgP+s8ywfXByFUit5clQJ2M4Y9/y+NYoakbZ4oiRrigfX6eANmuavnVkotFcOc9sRcV/E+1sUXbZ286tQiIUSaAUKL8qObTeac4gEE/5L9Y/WCDnl/xZH3lVg8YEfp1xCIHkgUvugON0u94vysnh6Yq1barRK8MpVPYL2zERPOBpRyvUIlpzd6Q/xgYpLNi20FyylTruEboZ43Vm3cNP+R0Pb+ERXZ4xDdckyDScREZa+CUrakdUi5cfuaGjIbjP1mOD0nZuiF32jmgf04TTm6sire7S9iHx3CxvHl3fWbaMwqwbkXh9QLbTYVo2URcDrB3iolq0lsZzl2bQ4yOtiXrY+xnwL8CADEfrfIGir0gPRHAJUNaCYK+tfYqBRsIkRtVVRLdk/q1JuEZayf68Ig=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(2906002)(8936002)(5660300002)(82310400005)(36756003)(40480700001)(81166007)(54906003)(4326008)(316002)(966005)(6916009)(41300700001)(8676002)(478600001)(7696005)(83380400001)(36860700001)(356005)(82740400003)(86362001)(40460700003)(26005)(426003)(70586007)(70206006)(336012)(47076005)(6666004)(186003)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 13:28:00.1113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e33b9d-0d12-49bd-d6e6-08db1f0fc580
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7923
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
index 165078beca2e..c3c0bee57bd1 100644
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

