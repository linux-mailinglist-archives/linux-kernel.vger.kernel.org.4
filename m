Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51916AE084
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjCGN2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjCGN2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:28:33 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44242886B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:28:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjnuHNqgs9lsOB3LyuU0HQOBkXO0EizDAMpdxFgLkeMpOuK/VWWQgWRrCEBkT6hXffQOQCUCujScZI/1GLpUT891dSIMelaa/x9LEAeZfkhyif28clL1oV5e2a2GWaWMQY7TSgs7S0N7xWXAwXak7KU+ht7/Vv3mPJ4Np8760tPOCPlzI5DgLWx8V1TBOVxB8EYMwCXM4afeWHVC/9SPrNvQ3qQcpHn9Blsvzd9qcEMvaHGPwt/bPZms2Gm3gNX9GsoIaFJwrSNtGFm5ncMxVQq84KFIwGMpY101DZ5Ryx+tdpG0EbggIXiinX7G7CyjRL70B44rjY2L06doj/NBcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaT7WnEY4OAsapnYCTtVxDU8w/HswC3W7E5cgAlasH0=;
 b=c85Uvhsv23UwXf7SU24e2v6hcxk+zk02Zs6Zbhzrpr0tYt+aOPl8wd0uIDW24cKRhUCvl7nZRFNkKdKY2Y3vttZFu2MdK1+exKlKhgN2BGQ5VlINJyEgtCAR8xpUE+wf9FMsVtt5ISYP4MRE4hVvVbT9BR//M1HpucwAHIuLr8c1Se3GgFmfgnIGo62B0+n93BUywt7DeBQKXb8TqprYBOYWID/wJxJdqTpmPbkHyTb9A5sRYQ4hVXrCtDltYPKNpYUgceLM/1WZIwYLEVk6k9c3/XCVijxcMCg5lkD/TNKiK2nyspuh6Ze3zGKHRke2XvEY4p10IHxzcTYtvA1ZXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaT7WnEY4OAsapnYCTtVxDU8w/HswC3W7E5cgAlasH0=;
 b=CO+duTf7aH+19qKj3U51kc5145OHHzYP3dq8J9R12S0G2KRWnbzeM6Lf6jOtqHuD9ivuH+NhCFiM3S5R9NVyPgHbl6mTSt/Gpb1GtYFYtNDMy/mhy447t217yZrVrW8G0Efj6KxbwoaElCj2FpffZ03AHEgMOHwBrC3B7fm6J+U=
Received: from BN8PR15CA0017.namprd15.prod.outlook.com (2603:10b6:408:c0::30)
 by CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 13:28:08 +0000
Received: from BL02EPF0000EE3C.namprd05.prod.outlook.com
 (2603:10b6:408:c0:cafe::3d) by BN8PR15CA0017.outlook.office365.com
 (2603:10b6:408:c0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Tue, 7 Mar 2023 13:28:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0000EE3C.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.12 via Frontend Transport; Tue, 7 Mar 2023 13:28:08 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 07:28:08 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 05:28:07 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 7 Mar 2023 07:28:04 -0600
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
Subject: [PATCH V6 8/8] soundwire: amd: add pm_prepare callback and pm ops support
Date:   Tue, 7 Mar 2023 19:01:35 +0530
Message-ID: <20230307133135.545952-9-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
References: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3C:EE_|CH2PR12MB5001:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c656d0f-d933-45ad-1088-08db1f0fca96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qLT0nHp0nPcVNbHqNSBVJ35Ep4zf5LOXK+X+FSYlCE3geSmMEE5+JtrtzqN/IAPkEzCM6GDw76kImhxP7CqBo3secQtIHDyHdkpeDRjDJqeoQ0BoMQwh7ftN4TEFzEFXOjZ/cStj5bJH3oknfKZTKLhbqGCBb5vx7NGZX2EIsukYXLMCHvBnasDirHOgAdJLL3l/55FwCQ5Yhj2nIS8JNHnZX5vpM00rPLiDJoIGfxGQvEs0HNDjeik6VtGBBO09uf5Efgb8Z17ElZxMbveKP1bFTTx9Grd9QX1eDRNpUtBxCzzmL7tVEdXczz2H8HgFUJeEQ8NOuYj/uJ2kwwAuVHTjNCNoHMtM/yZnSBMP8pN8KQ43Sy1SSxAkzD2Vpz6vsqrYVPZgsU4JhPMQJdg3zPNrtUTIEHooMT1ja/NajbbRXupEV5x1ZubP2IksQaleXIH1DjHTOsnkW6WFLciB4IiwNAmLkOc8rwL/9sMMaRIl5O5naa7zoLDw3ixPQr/cPm7npCpju2gNISLGBwiD54Bhtlkl7qfvZmKK6dXA05NBvbVqGSKnAgzbvRIiqxy8lpw6tn3FucEosv9Sw1bEyZHqwpuUvTMH+8nweoTw6EIB0UMyd7FHbcm2y0KY/uyNQt+N9KhqvQKLlT5J8eIbbbVyAD6UWRtjVD7s5rDUZJm7hfgfCwLfDvwewHhQP/8JTzi6b49p9jdVsu7Io8Bv4eleRgfTB8mooxSC7RItTcs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199018)(46966006)(40470700004)(36840700001)(36756003)(4326008)(70206006)(70586007)(8676002)(41300700001)(6916009)(8936002)(40480700001)(5660300002)(2906002)(81166007)(82740400003)(356005)(36860700001)(86362001)(6666004)(7696005)(26005)(1076003)(478600001)(54906003)(316002)(82310400005)(47076005)(83380400001)(336012)(426003)(40460700003)(186003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 13:28:08.6391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c656d0f-d933-45ad-1088-08db1f0fca96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pm_prepare callback and System level pm ops support for
AMD SoundWire manager driver.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
---
 drivers/soundwire/amd_manager.c | 85 +++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 70e4fcd7e1e0..8d4117f0dc3c 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -1079,6 +1079,89 @@ static int amd_sdw_clock_stop_exit(struct amd_sdw_manager *amd_manager)
 	return 0;
 }
 
+static int amd_resume_child_device(struct device *dev, void *data)
+{
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	int ret;
+
+	if (!slave->probed) {
+		dev_dbg(dev, "skipping device, no probed driver\n");
+		return 0;
+	}
+	if (!slave->dev_num_sticky) {
+		dev_dbg(dev, "skipping device, never detected on bus\n");
+		return 0;
+	}
+	if (!pm_runtime_suspended(dev))
+		return 0;
+	ret = pm_request_resume(dev);
+	if (ret < 0)
+		dev_err(dev, "pm_request_resume failed: %d\n", ret);
+
+	return ret;
+}
+
+static int __maybe_unused amd_pm_prepare(struct device *dev)
+{
+	struct amd_sdw_manager *amd_manager = dev_get_drvdata(dev);
+	struct sdw_bus *bus = &amd_manager->bus;
+	int ret;
+
+	if (bus->prop.hw_disabled) {
+		dev_dbg(bus->dev, "SoundWire manager %d is disabled, ignoring\n",
+			bus->link_id);
+		return 0;
+	}
+	/*
+	 * When multiple peripheral devices connected over the same link, if SoundWire manager
+	 * device is not in runtime suspend state, observed that device alerts are missing
+	 * without pm_prepare on AMD platforms in clockstop mode0.
+	 */
+	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
+		ret = pm_request_resume(dev);
+		if (ret < 0) {
+			dev_err(bus->dev, "pm_request_resume failed: %d\n", ret);
+			return 0;
+		}
+	}
+	/* To force peripheral devices to system level suspend state, resume the devices
+	 * from runtime suspend state first. Without that unable to dispatch the alert
+	 * status to peripheral driver during system level resume as they are in runtime
+	 * suspend state.
+	 */
+	ret = device_for_each_child(bus->dev, NULL, amd_resume_child_device);
+	if (ret < 0)
+		dev_err(dev, "amd_resume_child_device failed: %d\n", ret);
+	return 0;
+}
+
+static int __maybe_unused amd_suspend(struct device *dev)
+{
+	struct amd_sdw_manager *amd_manager = dev_get_drvdata(dev);
+	struct sdw_bus *bus = &amd_manager->bus;
+	int ret;
+
+	if (bus->prop.hw_disabled) {
+		dev_dbg(bus->dev, "SoundWire manager %d is disabled, ignoring\n",
+			bus->link_id);
+		return 0;
+	}
+
+	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
+		return amd_sdw_clock_stop(amd_manager);
+	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
+		/*
+		 * As per hardware programming sequence on AMD platforms,
+		 * clock stop should be invoked first before powering-off
+		 */
+		ret = amd_sdw_clock_stop(amd_manager);
+		if (ret)
+			return ret;
+		return amd_deinit_sdw_manager(amd_manager);
+	}
+	return 0;
+}
+
 static int __maybe_unused amd_suspend_runtime(struct device *dev)
 {
 	struct amd_sdw_manager *amd_manager = dev_get_drvdata(dev);
@@ -1141,6 +1224,8 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 }
 
 static const struct dev_pm_ops amd_pm = {
+	.prepare = amd_pm_prepare,
+	SET_SYSTEM_SLEEP_PM_OPS(amd_suspend, amd_resume_runtime)
 	SET_RUNTIME_PM_OPS(amd_suspend_runtime, amd_resume_runtime, NULL)
 };
 
-- 
2.34.1

