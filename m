Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0042C6656E9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbjAKJGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238432AbjAKJGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:06:13 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948B72BC4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:03:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fo/dk9+DvfmvnG6IO/mLF7xzteosFzP3ne9BRJqF7F+UKdcug074CpekDA0RwxEhYz7JITHZUU9IO8R8xzuEVLMblM62q2mAT+MpHJHQj6QixRlFV9PQPu0OLZDyAK/xYIvdL1+eMdoo+HQ0jQcWIXBDLSqEBt9uHqBwm956KkafgPCMjtYpzRUWTUhL1OW4Z25gquSCsnvg+FLqWYnrO7Dmr63tQ15FV/ZXBN47kQNCH75dFCvaG45hbs0AkQfjiWmEiNsDYxzDs9KS1d34s3ZPEp4DDNR1qD/ON3ZkMhsSycHbK2p6rVZPTyAj5vXtJgCnqJgXZkQ3mkF3SuHJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyqHaXctajZhEaCfsEif1gaJRUiHYT109ULn6xwZoWk=;
 b=Su25nZ8gwQa4yCtNEO9FKfQiCqhbhzKV9St20VsVhu7UvZ1GK/le03Zq7VpsWPBUG/dCx/rYXYBXm2xsA8N0R/He1gEfs2JBMVr38Uwa7ixspF9rS2Wspi8wB6uWeEpYDP+D+EvKECZFm4SNU+jUUa7JWuInD8TprPrAFB88swPcvnfzgcWBb1ba+s+qP/8RvYfakepuBx4pyj2HcWVaf0fZFKnAgPhuhhvQ0q27FGmhPZXC2dF2nGUwNNpsg8kYQ4jnB0TToAFInnoiOrg7Y1yFw80kTRxC2WYUuzpYFm2JNd10R+QTjwJv27MlpxLRGbaYaCKC8iE/j2aOuKwumQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyqHaXctajZhEaCfsEif1gaJRUiHYT109ULn6xwZoWk=;
 b=BzVW0xLvycRGdJ+VIQzgHyqY2MIyM7e3t2mE+Rv8OBbB41fdKoffFxvQf6rP19/ZjgNYFrnHAxnW42FPKd8P0NSfnwtP8v1Nvgi6jXoVs3Vu5an5T8MLtc1LZksffE5ORXNNGQH62+A8AMGNMtN7sozJCOxl8qsIShHFKFTPeqI=
Received: from DS7PR05CA0078.namprd05.prod.outlook.com (2603:10b6:8:57::24) by
 SN7PR12MB7420.namprd12.prod.outlook.com (2603:10b6:806:2a7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Wed, 11 Jan 2023 09:03:44 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::83) by DS7PR05CA0078.outlook.office365.com
 (2603:10b6:8:57::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Wed, 11 Jan 2023 09:03:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Wed, 11 Jan 2023 09:03:43 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 03:03:37 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 01:03:21 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 11 Jan 2023 03:03:18 -0600
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
Subject: [PATCH 17/19] soundwire: amd: add pm_prepare callback and pm ops support
Date:   Wed, 11 Jan 2023 14:32:20 +0530
Message-ID: <20230111090222.2016499-18-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT034:EE_|SN7PR12MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee6e24e-ba8e-43d9-edd9-08daf3b2bda6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y2gNylRxRWmo43D/HcN8S1IRRlrjwoy4IWQ+94PGvGwGsTCs7c1kg0LT3Z2yDfUQIHCSThadGDkNMDEmXbCvvvzbQFJtkq0zQ33phdiqepjTSDKjSziH5yhgq0nD+009tlweEadI+ZF5gOnf6C5pdFUOuaahXeBpQ+B1ywK00X7gkEOoEO0iPje3Idak4cg6dDnpkF816gareC6QO7X5umq+j6HwLCHcBEXIz8alaubIwdNAm2sPSYRUaCg+xkQDqWxzbT0KUckllWX6lB18/Z7tOrrxncVGB70ABiI2wfyawhFB10MYDi/svbed8Z061njxJQNKb9vlU/91NMnSrG7kAgq2FCy4wukTJ/1SvFEeKN2/XQYtraxtry2D/EM6WQUsn25Rx/AS1hYZky3lJ6YPOwIfbHnTGhe97AA/RIup5YfcXVK804Z4s84lKiG4DmB5wPNY8C2RzxUmYUpF7exSQUP7PQcQYGhk54YxzqFTib8oVl5bawCTS+5N32HXbf2DupebOFTr/+U9xnEfqGCmkJiaM6wqiVzVQgXbOtj1T7U/OjB7vrPDimmTgkd9PSLd1JnRl1y675BF3VofXOGGRbMeqJPg3L+pUOQOcHN6SBGpOKI2+Jo3DGv7bbOQmOIqd/aYqmUaLhf+cmPwiHJnb9v4asaBVG33FT+clDbecezGI36AFzkiCvowAliNKFraXZYdhX/YX27Vwhsz8Qh3C0tOYnEiOVlUzPkgKs4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199015)(40470700004)(46966006)(36840700001)(36756003)(86362001)(8936002)(5660300002)(40460700003)(70586007)(47076005)(426003)(336012)(7696005)(83380400001)(26005)(186003)(478600001)(6666004)(2616005)(1076003)(356005)(8676002)(4326008)(70206006)(41300700001)(316002)(82740400003)(82310400005)(36860700001)(40480700001)(81166007)(110136005)(2906002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 09:03:43.7127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee6e24e-ba8e-43d9-edd9-08daf3b2bda6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7420
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pm_prepare callback and System level pm ops support for
AMD master driver.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
---
 drivers/soundwire/amd_master.c | 76 ++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/soundwire/amd_master.c b/drivers/soundwire/amd_master.c
index 2fd77a673c22..f4478cc17aac 100644
--- a/drivers/soundwire/amd_master.c
+++ b/drivers/soundwire/amd_master.c
@@ -1552,6 +1552,80 @@ static int amd_sdwc_clock_stop_exit(struct amd_sdwc_ctrl *ctrl)
 	return 0;
 }
 
+static int amd_resume_child_device(struct device *dev, void *data)
+{
+	int ret;
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+
+	if (!slave->probed) {
+		dev_dbg(dev, "skipping device, no probed driver\n");
+		return 0;
+	}
+	if (!slave->dev_num_sticky) {
+		dev_dbg(dev, "skipping device, never detected on bus\n");
+		return 0;
+	}
+
+	if (!pm_runtime_suspended(dev))
+		return 0;
+	ret = pm_request_resume(dev);
+	if (ret < 0)
+		dev_err(dev, "%s: pm_request_resume failed: %d\n", __func__, ret);
+
+	return ret;
+}
+
+static int __maybe_unused amd_pm_prepare(struct device *dev)
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
+	ret = device_for_each_child(bus->dev, NULL, amd_resume_child_device);
+	if (ret < 0)
+		dev_err(dev, "%s: amd_resume_child_device failed: %d\n", __func__, ret);
+	if (pm_runtime_suspended(dev) && ctrl->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
+		ret = pm_request_resume(dev);
+		if (ret < 0) {
+			dev_err(bus->dev, "pm_request_resume failed: %d\n", ret);
+			return 0;
+		}
+	}
+	return 0;
+}
+
+static int __maybe_unused amd_suspend(struct device *dev)
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
+
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
 static int __maybe_unused amd_suspend_runtime(struct device *dev)
 {
 	struct amd_sdwc_ctrl *ctrl = dev_get_drvdata(dev);
@@ -1638,6 +1712,8 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 }
 
 static const struct dev_pm_ops amd_pm = {
+	.prepare = amd_pm_prepare,
+	SET_SYSTEM_SLEEP_PM_OPS(amd_suspend, amd_resume_runtime)
 	SET_RUNTIME_PM_OPS(amd_suspend_runtime, amd_resume_runtime, NULL)
 };
 
-- 
2.34.1

