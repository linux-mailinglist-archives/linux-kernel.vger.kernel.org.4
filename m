Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C9B6C2998
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjCUFGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjCUFGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:06:41 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5C813A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 22:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gi9wwpCu8Ekp8C/riDbAC/E+POCux9WQs24goNEY51p8mIZ5WmDpDSr5BSjo1ks3ZO5Y7Vglm1kqSYlUufn8ys9CIMyTEjEoKrw2zbuBsid58Stg8XCgV2dFvbs+qaa0hp+/7TzLsUwVAm/UBae9m2RidVPXsjuL83CDjUwHgnUiAsd2K9kEtNihIZHVEHGCrLTBcavI8t6eO2LvY6Rb//h4zVBxgJL5CpzLbRAsX5FlamfJuSo5GNEanuxIk70OHIEUC4nRJgl/RlB7GZKfPGW/PHCUoq4c5fhx3r+mytSXm/C8wiAAtd7G7Edfuq0mXdLLm5YvjWNXzoPlP15CMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSjKWgeJQ/8v18VG/Z6xoBqXanIgETiWSoY/XO9DhiQ=;
 b=PxnS1ppVRSH2qI6j9lTzW9gh4TjAO6U1B+RzyEIajv3q87dSL4l0Rn925ImkPybpZdBmSH+ITYHwdO5xUQnk/QtcbqMDp6iV8Ys61WYGQZ5IUc3YFJdTwCLG7SaTIRrHPtMurKfAKa9DxCwSatGtsATby2wo+Py7kYyvfCm11J0b53/rXf1SBBfr/lt0smE6G47QrL9OgQlrmNzY/ArF1FHeaBmGrWdbUNravN5VIkmk2F8JBvpYBfkbOc4V3WTPrlTDlwwxZeY6RMj2DlmeaN2M3K8NgmR6AOS0G6vcnHR3T3Hq2i4dOkstcVU2ZLOk5K1648R/UNDUZsY1MxK0xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSjKWgeJQ/8v18VG/Z6xoBqXanIgETiWSoY/XO9DhiQ=;
 b=Mdd57uUeyIw4Er1B+YYnaRVuTrwW+2qvwnHVOq/aMF1WCqIFJ3rpNY1425wW/4PqX+Q6PmFLc5Mf5Uc8rdwg3ig1Q/nUsGaegNuAOzrNVyNwWO1seBGQwjlD1UawDfeaD4SB6PX5lrOqc0FMpDBFMAU2cw/lKsgTMIDPkZAqN6Y=
Received: from BN0PR04CA0007.namprd04.prod.outlook.com (2603:10b6:408:ee::12)
 by BN9PR12MB5210.namprd12.prod.outlook.com (2603:10b6:408:11b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Tue, 21 Mar
 2023 05:05:52 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:408:ee:cafe::fd) by BN0PR04CA0007.outlook.office365.com
 (2603:10b6:408:ee::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 05:05:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00010208.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 21 Mar 2023 05:05:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 00:05:51 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 21 Mar 2023 00:05:48 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <vkoul@kernel.org>
CC:     <vinod.koul@linaro.org>, <alsa-devel@alsa-project.org>,
        <pierre-louis.bossart@linux.intel.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>, <amadeuszx.slawinski@linux.intel.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        <claudiu.beznea@microchip.com>,
        "Vijendar Mukunda" <Vijendar.Mukunda@amd.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V8 6/8] soundwire: amd: add runtime pm ops for AMD SoundWire manager driver
Date:   Tue, 21 Mar 2023 10:38:59 +0530
Message-ID: <20230321050901.115439-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321050901.115439-1-Vijendar.Mukunda@amd.com>
References: <20230321050901.115439-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|BN9PR12MB5210:EE_
X-MS-Office365-Filtering-Correlation-Id: de507249-82e8-4c3f-c2fb-08db29c9f1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l9d79fTulH/UmTrbWr8nvgzuUC9m8LQByx+tUa7wlploVERZwSi29Sqnl+Hvdkj6Xe+WO48x+LWwL/LbW7ZClmfWUVYtgAyrE1Jxkls5FoLZrIN7WAuPVNbVjpZcIoeDQkQM43TlBxO467lYwoTGREQCondg8TFAOzaTCduflwQDBHgZcZNQTAItU7lD/VcfnwcyCovqyAbnGWE68w00w9Kh61zk1vayXdVRFQsXxTXld+UHRVPqIO2MFESJvupG6EVmx87SaYtn4qbgWLLpy22Pvesvc7ecmx7fleXIN5LzdstKOpvKLLcjTi3yiOCkE12uDRQIdjT2tSc6awtT2P+8KD2NvVcrov2vdohzoTcLd9fbZyRz8fJpPB0hp89ojF7aMvF9wCqrMyxgidlg7xLtP+rir8Li9p0obvONoQm0d6lvm4QBQxMq3A/vAWmpxuPELttxzA6Idr9QwXSnDcRMU4i1wLbP4CXxECiXR7FH5+WwXSL5WLZ0r9+3IcWkcRragyt+lT9kEgfjoGm9P3aDYeXSWpW7ZFUfrhPu0etqd1CwS5I7EHXEHwhs3CYmxbhqVuZRjomuhwv3DUrv0O0fwwJsApRYgTr2BI8HOTxmkyQAxHnJXzoPlRF3kgU7/XJQD/gNkYomDXjzvW4aDUWhWn5hQJ8GnIsRI0tyjfQa7m+0jj/t1846TY4rEeVmn3cJuwjVRjE+ut43gZ2XCiFvrYX1paj1dyqSHjIxM7o=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199018)(40470700004)(46966006)(36840700001)(8936002)(356005)(5660300002)(41300700001)(6916009)(82310400005)(40480700001)(86362001)(36756003)(81166007)(40460700003)(4326008)(2906002)(82740400003)(36860700001)(2616005)(966005)(6666004)(336012)(26005)(186003)(478600001)(83380400001)(47076005)(7696005)(426003)(54906003)(70206006)(70586007)(1076003)(316002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 05:05:52.4088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de507249-82e8-4c3f-c2fb-08db29c9f1c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5210
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
index 49b7133cb41f..6172b3cb84d4 100644
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
 	writel(0x00, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
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
@@ -866,6 +873,12 @@ static void amd_sdw_probe_work(struct work_struct *work)
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
@@ -953,17 +966,144 @@ static int amd_sdw_manager_remove(struct platform_device *pdev)
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
+	ret = readl_poll_timeout(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL, val,
+				 (val & AMD_SDW_CLK_STOP_DONE), ACP_DELAY_US, AMD_SDW_TIMEOUT);
+	if (ret) {
+		dev_err(amd_manager->dev, "SDW%x clock stop failed\n", amd_manager->instance);
+		return 0;
+	}
+
+	amd_manager->clk_stopped = true;
+	if (amd_manager->wake_en_mask)
+		writel(0x01, amd_manager->acp_mmio + ACP_SW_WAKE_EN(amd_manager->instance));
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
+		val = readl(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
+		val |= AMD_SDW_CLK_RESUME_REQ;
+		writel(val, amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
+		ret = readl_poll_timeout(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL, val,
+					 (val & AMD_SDW_CLK_RESUME_DONE), ACP_DELAY_US,
+					 AMD_SDW_TIMEOUT);
+		if (val & AMD_SDW_CLK_RESUME_DONE) {
+			writel(0, amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
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
+		val = readl(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
+		if (val) {
+			val |= AMD_SDW_CLK_RESUME_REQ;
+			writel(val, amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
+			ret = readl_poll_timeout(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL, val,
+						 (val & AMD_SDW_CLK_RESUME_DONE), ACP_DELAY_US,
+						 AMD_SDW_TIMEOUT);
+			if (val & AMD_SDW_CLK_RESUME_DONE) {
+				writel(0, amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
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
index fca7d792bf5f..b101f4536230 100644
--- a/drivers/soundwire/amd_manager.h
+++ b/drivers/soundwire/amd_manager.h
@@ -186,6 +186,9 @@
 #define AMD_SDW0_PAD_KEEPER_DISABLE_MASK		0x1e
 #define AMD_SDW1_PAD_KEEPER_DISABLE_MASK		0xf
 #define AMD_SDW_PREQ_INTR_STAT				BIT(19)
+#define AMD_SDW_CLK_STOP_DONE				1
+#define AMD_SDW_CLK_RESUME_REQ				2
+#define AMD_SDW_CLK_RESUME_DONE				3
 
 static u32 amd_sdw_freq_tbl[AMD_SDW_MAX_FREQ_NUM] = {
 	AMD_SDW_DEFAULT_CLK_FREQ,
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

