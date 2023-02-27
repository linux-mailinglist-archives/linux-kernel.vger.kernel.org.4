Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3676A4654
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjB0PpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjB0Pop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:44:45 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDEF16AED
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:44:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2iN8UaPnvJmmHMcc4vPF18fKEFK6rQ2gxIlP7fLhXomX4kABwCey0PujsbhMW3Uy1I5uNGzXOFxbRUjGlJHAnMtUEc8rhe1eg3vAjH6aMiShxfovWHUyerdK8fLdRs8oGaUPa6kSqhKs/DZRsAmIgx64KKTCGjtPzOslPM5DQTb+9VTwzxDAuQnucF7AmwBQkH8QGKRSH022dsHuBhePWbk8Jf5U/SCq2o5VxN9gtqEbFKc/YgLNXNJkjIcgV1/HyB6BTWWI/nJ+G+WleECyBIOcPY7xL7aKolKK/iBMzGNyfxMNucmCwBrH/muyMbI89Y8y0EQ9VDeh5l2LFhJkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGuK2A21PcQk/hePfSLS2V3o9jnU3+Pp+VAFZ49FMz4=;
 b=meSkpaI+MCoXYyQVIEkXE7i6rauAvdmvWh1FK1D/L6cPi381QjueagH5pMg40aKWkwlt98aUTr/PZM7x8BaTtjHJTs06MFINhduWVHLo5h8VHZp5baZXhf4GGCmjnuek3vSY81wFTbH2q+y+/tOG8FW5l1SMAfpr++lKFgIFn48XPL8oexZokrXVrmwI6PIaP6TDtG83JX+NERmuXYJHdM1AqO+3dOVzFEhkDqG/QqroxTPD5kWQMvDyPaEMD8VksmECM/qDhXmm570HJdnY5EA2VM7fvSLUbpVQCh3saP8G70ARN5Yb0NueqcyCuCShH6Pu1Vw/ofFHh1Uhvsp5dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGuK2A21PcQk/hePfSLS2V3o9jnU3+Pp+VAFZ49FMz4=;
 b=ku7X3Nkf8hvbPbHZ7yIOfh0JCKXrJfxJUsrHRc3SO5AMiP/DG3iR0XHFeyrlOIweRbUzz12g4MZdcgPkwKx9nP8DS9FcKcDSn4VRBV1/0b2N5EnI0SKZSK2bO35gQwN9Zr0knnA5TBqnSPI12Ks5BEx0GxdEfkxvaw9LFrQNvKE=
Received: from MW4PR03CA0340.namprd03.prod.outlook.com (2603:10b6:303:dc::15)
 by SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 15:44:26 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::2c) by MW4PR03CA0340.outlook.office365.com
 (2603:10b6:303:dc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Mon, 27 Feb 2023 15:44:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.14 via Frontend Transport; Mon, 27 Feb 2023 15:44:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 09:44:25 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 27 Feb 2023 09:44:21 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <vkoul@kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <pierre-louis.bossart@linux.intel.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>, <amadeuszx.slawinski@linux.intel.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V4 6/8] soundwire: amd: add runtime pm ops for AMD SoundWire manager driver
Date:   Mon, 27 Feb 2023 21:17:59 +0530
Message-ID: <20230227154801.50319-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230227154801.50319-1-Vijendar.Mukunda@amd.com>
References: <20230227154801.50319-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|SJ0PR12MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: 666b7522-7819-4d08-1879-08db18d98165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VXf6cjyr5wdpvXUjkhqMnQX21j14iWTR1clzpsxfF1pbdKoR0yhc2mL8SO5bE6tLrdomxgsyXBvKOZgUqYfY9eLEs8dGduWUjslmC0yN13QkBlqdvRgbcBn7pVRTvD06zfPZDrgX4puACD12q9/2mWisoj0aJ1f8+GrIpdCVybC4tdFLkvQbVuZ52kUzy69urVIXEJusfXykItjdiq45SZo9HdRl/ShbONlDARpLljeryjdBeXnxtDxcOKhIea/n/Ac2+IveQGiSrWKUpjCskpJitahInX1mMMwd3/nURXFQ/IGhQkNHA4xz0moqwq1q/7P7OJ+f9AJHW2JMFEU2POVxpTXSB/HT9ytPhcDZk9aBGrEsMPpA9pWh43FE09iG2WaLB4h82pmm24Dd6+vrkjN2ihs9jdxxUvBtivKKdgSAfvtZwilfy4224i1q+b9e+z7AKb8GFpWfZJ0hUyy3WQY7cumb9jczeTGwg84UKuOfQbPaRPnNK4LxdxfoRSxblAGldbDoIuA4XaPdqILc9ZiTlkz6gwTdKZY8u2m/4wGJvvF1LEYVDuw7ON7VDc7KUebaXblunQuCoXiBom+vsfm0wiN83Sf33LHPH+6Skuof90OgaG0U96HJTbAQ3qe3rR1dJl2eYnU4hGdtrlu/cddUJLw3JhNn0G+k29WTIkfp5IxMFQq+M+XwJW5sRDOlpJ5DlSm4yOnjWfTpZjebQaFpg61c2HdY2A1sIoyA/aE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(8936002)(2906002)(5660300002)(41300700001)(70586007)(70206006)(4326008)(6916009)(8676002)(316002)(54906003)(478600001)(7696005)(6666004)(36860700001)(426003)(47076005)(82310400005)(26005)(186003)(1076003)(336012)(2616005)(40480700001)(86362001)(81166007)(36756003)(356005)(83380400001)(40460700003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 15:44:25.9350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 666b7522-7819-4d08-1879-08db18d98165
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6760
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
 drivers/soundwire/amd_manager.c   | 161 ++++++++++++++++++++++++++++++
 drivers/soundwire/amd_manager.h   |   3 +
 include/linux/soundwire/sdw_amd.h |  17 ++++
 3 files changed, 181 insertions(+)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 7bb2300f16b3..12345077c395 100644
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
@@ -178,6 +179,12 @@ static void amd_disable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
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
@@ -957,6 +964,12 @@ static void amd_sdw_probe_work(struct work_struct *work)
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
@@ -1040,17 +1053,165 @@ static int amd_sdw_manager_remove(struct platform_device *pdev)
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
+		usleep_range(10, 20);
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
+			usleep_range(10, 20);
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
+				usleep_range(10, 20);
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
index 3920648fdc52..93022a325598 100644
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

