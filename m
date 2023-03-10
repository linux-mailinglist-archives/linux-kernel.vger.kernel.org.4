Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04846B4CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjCJQ1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjCJQ0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:26:16 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A785D74F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:22:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzjoNGCPaFBzF6F7dAecRm5q97REFZFTEdLjTzw2fR0ADt4i/00hhX53TJveTnEd5IOoEpc6MabBWdi1WYgDMtSRsSm6+rVz97dfAVMfCpO+SQMmmdf6d41sgK2mWN/zCVAR8QqZFBqCb6TFyuPfXwj6AezztlSkyw3LcfTPV0mG+17xCmT5dC1Jm99v+qhdrLJJTdqjjk8hTvMJH1KEye7XovFLXp5vz+yFrjoM0zxCwBQNtAFKhivPgbKEN95bciAMYFozwwQcl9j6fWvjE3vJ42YSKwX2BL8nQ9j8D2sGPoXZN06REnZ8IT9xQPeLwzRHjlSn7GiP0741FSXxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzpQjbhaLOBXjglmhoMhL9THO3EPsQ51brYeudnOifk=;
 b=Nyt2ABHmMcyLs052AJjW6FfggRaLdq356OOcl2sbBG095ybBanbNI5/y8EL4cPqigiTu9i8tz501+WTSyp2/qowJGh/LGLyoSVtKCKWtAYAGqa2XyQYpvpiDQJZoXPw9aHpiuC6iRmv/BPphkzf7obBG0JNKv/TwPOStx9nVzJsPaN/XOoqKpzhaxQ4O1yKMI2JobTHhTwGzKUtiO6n38Ghzka3pI9RvVaNevBR+3/l64pGcWDxfDE4H7vTYUr5F8i8pyBYolVnZCIMNIgEADUMy1gNosQc4/e+im105CL7k6Sk7KI1VBS2b7hCiRNV9nWMqziHOPDotTYAGUrqUBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzpQjbhaLOBXjglmhoMhL9THO3EPsQ51brYeudnOifk=;
 b=rAYXqeiKE8vvSI8FalsRLVm4xkN1Hd6aqopZ8rnzPCUxsO6YoaezextP/hfndy1XOHioW5hBBEz+A5HfN/bzHghWMT3g7T8uRj6ipfWaHV32T9sn7kRqPw4HLVEFIV4E1JKraL1b6KQX+bCDKOlMGLD1wYJcAS7bu++fjf2zklo=
Received: from BN9P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::12)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Fri, 10 Mar
 2023 16:22:37 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::95) by BN9P220CA0007.outlook.office365.com
 (2603:10b6:408:13e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Fri, 10 Mar 2023 16:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.20 via Frontend Transport; Fri, 10 Mar 2023 16:22:36 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 10:22:35 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 08:22:35 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Fri, 10 Mar 2023 10:22:31 -0600
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
Subject: [PATCH V7 8/8] soundwire: amd: add pm_prepare callback and pm ops support
Date:   Fri, 10 Mar 2023 21:55:54 +0530
Message-ID: <20230310162554.699766-9-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310162554.699766-1-Vijendar.Mukunda@amd.com>
References: <20230310162554.699766-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: 42bd39a8-474b-4f18-2bba-08db2183a8e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y8fMMXlmSU+jTIAKuBQ3VSpBiaR4aDNWG33jLS2+HNASDfgQMUhz4m4IHkU/+vLXAIoAJGpp7ZmY9M4p2Cl3IAJAUCYqTFAsJGtS2uwQHdB8U1ctAukaJZqFxi72gYPLtd2WutTika6FlJI3IwRsNSfBgSIkkstftCNO3Gbbivauw6/iqTKJ48ki6r4sRvPCLSiwok3D8JZVQUyMquh3Hb81XrUCtzWZADuNksbwgi6fyuW+vnAOjThWPWLvnRl+hFchXg94H3BMokPS+jsvAeNDFE5IHAK1lB+fm9N1UDVnQ5KbpGHIrBKQ9enTPL3wTgj5hA520upEWRi/+B/ro6P7hg6vX7sS2sQpCblmnKqk+L67ymBLgoBdcRz9E8ZhWy64BncE4v3a2qUC6Dhy0ZwTGkZsEuElEHv/cUwrA05rRFZOMb0GqtMwUgqCDd+C+BmjFwocti/Xdy9VIybCTHhYhbQOwJTzkd1iKbi8Kr4Y5SKRSU7yrh626ivyeejoysoF7RJZ6WHLnisF1UIAdKA8aTs7olzrpypXJym60PGD6Ujf0m0l4bwY/OAkqIw+MyAxx3QzpZVFsJcvd+WRxhKDwWl2Ntijh1skVjNx4XAXG16vg7eXS3hjuRzEJs2vdjM4gQi2JTXjNw81FUPB6o1aqhfcpXg+hyTpr6y5v2MyFuSrRoryAPVSPcHHa2uSOoomGAnpqQ2N4mE6PyQsRHHub2LzgHr1M5QM6J0gR6g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199018)(46966006)(40470700004)(36840700001)(36756003)(83380400001)(47076005)(426003)(82740400003)(6666004)(36860700001)(1076003)(26005)(7696005)(186003)(336012)(40460700003)(2616005)(8936002)(41300700001)(6916009)(70206006)(70586007)(8676002)(4326008)(86362001)(5660300002)(2906002)(40480700001)(356005)(81166007)(316002)(478600001)(54906003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 16:22:36.0743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bd39a8-474b-4f18-2bba-08db2183a8e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
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
 drivers/soundwire/amd_manager.c | 84 +++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index fe9f5ae84a23..3698bb8e00d4 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -1079,6 +1079,88 @@ static int amd_sdw_clock_stop_exit(struct amd_sdw_manager *amd_manager)
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
+	ret = pm_request_resume(dev);
+	if (ret < 0) {
+		dev_err(dev, "pm_request_resume failed: %d\n", ret);
+		return ret;
+	}
+	return 0;
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
@@ -1141,6 +1223,8 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 }
 
 static const struct dev_pm_ops amd_pm = {
+	.prepare = amd_pm_prepare,
+	SET_SYSTEM_SLEEP_PM_OPS(amd_suspend, amd_resume_runtime)
 	SET_RUNTIME_PM_OPS(amd_suspend_runtime, amd_resume_runtime, NULL)
 };
 
-- 
2.34.1

