Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2206669C832
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjBTKCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjBTKCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:02:05 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A5D1816A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:01:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCdCGl/Rzm7ei5Q1QFocYLCc0KQhG3UHIjO2bONT/Ij3uYJY1WxqO9u+pqFXl10sWJrVGirGG1rUOttzQVXHNZNcPKs7hGFdtb9SjMgZolqbfEqO8blFimQg6ZOw3gyLX3LZKgOBjRcp2ke13ZMiUS5OP4R3ZFqpjJ/P5aPFlINQVLoe3vzU3dle72+OQY3Yf+kPqvAZliDobs45WjzFj7EGtqbTHhepIFnRfOyGIbo582CN0yKGtnFUnNJRDXO+2uxaqxK/LFbbFWQ/ZxIlHmgYQ8uTKqT6aYSlZUM8wPK3EiTN5ydv8aoln8ch68uKCeDmR56lCquFlCrsP+SXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8z+Y//YgishonFnnq1tj3py/fc2DrcCJvEzbixIOOvw=;
 b=PxnVkMuVR65zxJ3yQ8azmtzPaeAzIzOGEfX5xaHAQCOv4u1xp5ubc2vkHkOlVl4LAgwefbzr3QQ/xJyyqZc5uIAb5si/5tobOn4jNp8d0OiWCLNtNuVV9rEMlQ9v4SiovrGltCbvx2enBBP3tSS4XT0YYDWZbQzEsWPDhYJpVYzadjTOhiMGfNH14sDElJOIylHiSa+teLv85mwd02m/yJvPW6xotnr8lfNOqIn9rHGphJwBD7nfa+m8GwxDLpuAmPbaMpkZ04amPpcFXK0flA9+M8XT+aJNRH+06SBSZF4zIBQ/MT+YQsnAhfw5dnqL+0wq4CQmKyEI0f82mQD8eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8z+Y//YgishonFnnq1tj3py/fc2DrcCJvEzbixIOOvw=;
 b=nAfksXPhC2Ytr1T2P2N4BWrd1cDQO3c5icBCYRXEINjYUOmSE+75hLx1FfYapk050rlD42QFchuJ54Rw8Q7m6k4wBjiBUZXkyvn8Su0jxSXtIFB5t726fVjTdSdy/QKcYmxwzTy3mQ3Jd0jpegvTnpHESm2DYKk+2A4QIaeWNjE=
Received: from DM6PR02CA0054.namprd02.prod.outlook.com (2603:10b6:5:177::31)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 10:01:55 +0000
Received: from DS1PEPF0000E64F.namprd02.prod.outlook.com
 (2603:10b6:5:177:cafe::58) by DM6PR02CA0054.outlook.office365.com
 (2603:10b6:5:177::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20 via Frontend
 Transport; Mon, 20 Feb 2023 10:01:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E64F.mail.protection.outlook.com (10.167.18.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.14 via Frontend Transport; Mon, 20 Feb 2023 10:01:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Feb
 2023 04:01:55 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Feb
 2023 04:01:54 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 20 Feb 2023 04:01:51 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <vkoul@kernel.org>
CC:     <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>,
        <amadeuszx.slawinski@linux.intel.com>, <Mario.Limonciello@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 6/8] soundwire: amd: add runtime pm ops for AMD SoundWire manager driver
Date:   Mon, 20 Feb 2023 15:34:16 +0530
Message-ID: <20230220100418.76754-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220100418.76754-1-Vijendar.Mukunda@amd.com>
References: <20230220100418.76754-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E64F:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c687f3-a485-401e-a8a7-08db13297f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q4EYaXXH5p3688WHS51g9IVI9s7PBTyw/NJVgYMCy2+hznqoHondRmZQKk1SSH8tF1Ej3OjPwl5mFUxTiB3FTkyCW9uWvqw9tmD4fCL/ckWi6iR9f3M+9lOfx7FF4oEsuUKmxwuDqmgzVo7Pw2V6/WpLO5TV8Ltmp/tOR3lD3p/Re7S/fysqbMMAgiGfF25m4dohQSCXu4/cLEgiE2ocGqWG/PtLQ7wb9mXS90r16ekj/lRRhVVhwLfieA6jObZ5swyTN9oYLDzd2uB5cn3AiOgne2DFHFGiN4xVG98NDlLvHWbEowiRdRFOS47DCWVmacnPYq2liy1DrRYNi33xDYcjTdLxwo1LV0QIS9n1+UL3AiKKFN141MKKdS8ZHkb+LxWmKtXfgkm35iY0aklJ7UZ+1wL9v7xqxWy1nWq5j/Ya4rWAs2QIo230MkLhPi4djsHEi9MOnpRZmL/mAaDQ4Up2d5urQsyWvLW0Bj/1i2Ch2Utd99EcA+dAKU52ZEys7JAIzw91JvgTtofSnp52FRNHRo9+yE2Z/xZtPPWSbQU6HlG1uRCUVXBNR1euy9mP7tn0m4TRLj/RH9ypgIHkm/3aFIiPcibs8PWy77XHrZdRbF6SkrfA5zXr60G7ZAU+Uurj83j0JpfYTLqUzTg+Ncx8M+AaktVO3XotM0/uJRBbnRIccyvE2Bu6oSOgTYaIQjJRZIUd9sRYuoyF+vIMPajwx3YDonvu7ijmRrmJxrU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199018)(40470700004)(46966006)(36840700001)(2616005)(40480700001)(336012)(83380400001)(47076005)(82310400005)(2906002)(426003)(478600001)(186003)(26005)(6666004)(7696005)(1076003)(82740400003)(81166007)(36860700001)(40460700003)(86362001)(356005)(36756003)(41300700001)(4326008)(70586007)(8936002)(8676002)(5660300002)(54906003)(316002)(6916009)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 10:01:55.5732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c687f3-a485-401e-a8a7-08db13297f7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E64F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for runtime pm ops for AMD SoundWire manager driver.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
---
 drivers/soundwire/amd_manager.c   | 163 ++++++++++++++++++++++++++++++
 drivers/soundwire/amd_manager.h   |   3 +
 include/linux/soundwire/sdw_amd.h |  17 ++++
 3 files changed, 183 insertions(+)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 5d9f0a9b2dfd..3322adeca0d8 100644
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
@@ -964,6 +974,12 @@ static void amd_sdw_probe_work(struct work_struct *work)
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
@@ -1052,17 +1068,164 @@ static int amd_sdw_manager_remove(struct platform_device *pdev)
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
+	u32 val;
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
+		dev_dbg(bus->dev, "SoundWire manager %d is disabled,\n",
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
+	u32 val;
+	u32 retry_count = 0;
+
+	if (bus->prop.hw_disabled) {
+		dev_dbg(bus->dev, "SoundWire manager %d is disabled, ignoring\n",
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
index 6d1007e96a1e..fd9b1a443a4e 100644
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
 
@@ -56,6 +71,7 @@ struct sdw_amd_dai_runtime {
  * @instance: SoundWire manager instance
  * @quirks: SoundWire manager quirks
  * @wake_en_mask: wake enable mask per SoundWire manager
+ * @clk_stopped: flag set to true when clock is stopped
  * @power_mode_mask: flag interprets amd SoundWire manager power mode
  * @dai_runtime_array: dai runtime array
  */
@@ -85,6 +101,7 @@ struct amd_sdw_manager {
 	u32 quirks;
 	u32 wake_en_mask;
 	u32 power_mode_mask;
+	bool clk_stopped;
 
 	struct sdw_amd_dai_runtime **dai_runtime_array;
 };
-- 
2.34.1

