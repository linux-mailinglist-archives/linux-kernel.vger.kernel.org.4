Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F986A4655
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjB0PpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjB0Po6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:44:58 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1E1F76E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:44:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPPvLYKT9JPiLD+coyIeqpyKIbECdoZXHORTNyqyGR/XW9rDqdnBmlTv/sDUzOuPDWvUxg5vwWrPwMHtrUyl06oomEqSEzm/NP6FYzBKy9v9FMzAGxEbmbxOV0wjs2GP+E8zMOXpL1gRk0OJ/umkhoXrKI2Dno8yBY4zLowpJeF6Bw/1ISwdi1yc2Nl3UVq23cqC3ekBgTru4FfDkMCM6xbBiocNAGVmfdg56C6kMEYQ7OYTwAW/xR6qn5YuSjqIFS9oB9IgNN6WsfMt+niNIWRRq3uea3KwsIgS2hEV1kuNNGdZlqUiPJgq3/7E15XENR66vBBQP/CnziJBUKuvgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CIh4p3x6qEsHkFDRxtCSWeM760MarUfBf+LGXFiOVc=;
 b=RM2xplrNjB7/AHTGt6PDv3BigES4PoXWjH4Al9xgyWAPGAGab5Pt3Yk84dwhLWvu5kayQnaqwlYko+0jdi2YBT5Wmsqbc+TxIVTSCPdyo/yz3g3lRoFtyFOGUr8HJR5OSOAQLbO4zqsVjsY9OLoF1pScxwPB6DjOPTZvTRZfvTCETDdspzGYKtI/ZylzlRDbVnGWy3I+n47l81csT6GP+Cfw1vAmiptoQkGTicaFSDSp4gqJZ2JyWGIaqFc1bjll5EOBk3Vr8qetYvQvDMC8GjHOTRdd59uLz3jzngIlI4w2TkzXl3CQtxP77XypAGpUEGzBn3mvCzgL9u4Xdq6YEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CIh4p3x6qEsHkFDRxtCSWeM760MarUfBf+LGXFiOVc=;
 b=5DLiZKJOVGkGw8ReZ1emh/T4T9LrTt7m67M5WQglWOXTkVu6sE8D7el8v6PsmEi99QFgRzm6mTWtIaSURZCWVEa+4pHyg7tMkJ357BCSYqZ6Dguu2Jfj3QA08pmw0JLxRT2z3iiXxn55sdDYEqhhSTyMcdxH958AsBKVDha5mAA=
Received: from BN7PR06CA0047.namprd06.prod.outlook.com (2603:10b6:408:34::24)
 by DS0PR12MB7606.namprd12.prod.outlook.com (2603:10b6:8:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.28; Mon, 27 Feb
 2023 15:44:34 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::ed) by BN7PR06CA0047.outlook.office365.com
 (2603:10b6:408:34::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Mon, 27 Feb 2023 15:44:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.16 via Frontend Transport; Mon, 27 Feb 2023 15:44:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 09:44:33 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 27 Feb 2023 09:44:29 -0600
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
Subject: [PATCH V4 8/8] soundwire: amd: add pm_prepare callback and pm ops support
Date:   Mon, 27 Feb 2023 21:18:01 +0530
Message-ID: <20230227154801.50319-9-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230227154801.50319-1-Vijendar.Mukunda@amd.com>
References: <20230227154801.50319-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|DS0PR12MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 0943e7c1-6301-46a7-55d3-08db18d98642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EOpRmoeN42hEW9yPPOMFpdJlVYVF87aCF4+QXhztbkvvG+jvObBemxlVyDZuXsAS5WSM0ylR+HvnO3OZ7IicTsGxbrfpRWlmgZXrq6HV3UGKqIiYAQU8jZEl3rrWlAwpmbbLCjzqLAmqueRHDUdfVzSQV1qObCLzYZUz1Zqo5VzEagKwk2kK7d7xa4IDcLWo0kBSDdStyiSqHjzdpkYOKByCy5ysoTY9AtpP1Q6Ojwu6lbV3kN6UW3lmbmFKl+ZvyXbsIRlU9tcCwKyfhMTsnpqLJ4y4Pg9kUcRw2tyJEsHvz/SGQ3NHSR5FHnTDdwcbqDYcMPW6/VBIQMu+QDI1n5B7mw0yB22dlDTffrtrqLgKT4Vpw7yPQlBD7wrctkX77KS9ZH+388Yl2vcU/WxBzoY4LxLU57qdahTBVI0kRR62DFSfdJqs0wfOOR5HMZ7fC9J1QHGprFM9mGrIdM48V0/oU5aV2o22fW3F8itLrsMyrIqFp6J+ZargR+B1hd1Q/9yPJPK+HORu5iFhKFa8fxUx0NxFcy9aiHZauT6b10NtWwb/TyxcSNQLcVVlVGmb2TnwHoOlHYL/Mxxv39N4T49oOutLbKugv2BTtJiHYQHSmvWcH0ucnyVfwPnIunSzNgjlgSQjiObBbre8Qm6+ME+VRKBgi40R8ma11Op2FBrbM7refs+V9JK7fQvG7OIscLTRU/ExMDGwvpR6ibkHhpX+i/Gxo9GyTiHU8UpcGF8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(336012)(426003)(47076005)(316002)(36756003)(40460700003)(54906003)(86362001)(40480700001)(356005)(36860700001)(82740400003)(1076003)(6666004)(83380400001)(82310400005)(2616005)(81166007)(186003)(26005)(2906002)(8936002)(5660300002)(7696005)(478600001)(4326008)(41300700001)(8676002)(6916009)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 15:44:34.2052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0943e7c1-6301-46a7-55d3-08db18d98642
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7606
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
 drivers/soundwire/amd_manager.c | 89 +++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 88f0ad7ea7ec..5337443d9aea 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -1141,6 +1141,93 @@ static int amd_sdw_clock_stop_exit(struct amd_sdw_manager *amd_manager)
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
+	if (pm_runtime_suspended(dev) && amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
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
+		ret = amd_sdw_clock_stop(amd_manager);
+		if (ret)
+			return ret;
+	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
+		/*
+		 * As per hardware programming sequence on AMD platforms,
+		 * clock stop should be invoked first before powering-off
+		 */
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
 static int __maybe_unused amd_suspend_runtime(struct device *dev)
 {
 	struct amd_sdw_manager *amd_manager = dev_get_drvdata(dev);
@@ -1213,6 +1300,8 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 }
 
 static const struct dev_pm_ops amd_pm = {
+	.prepare = amd_pm_prepare,
+	SET_SYSTEM_SLEEP_PM_OPS(amd_suspend, amd_resume_runtime)
 	SET_RUNTIME_PM_OPS(amd_suspend_runtime, amd_resume_runtime, NULL)
 };
 
-- 
2.34.1

