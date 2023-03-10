Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178826B4CE3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjCJQ1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjCJQ0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:26:15 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB35A130C3D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:22:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAEyJwe3aMPo0IM1/KbrkVi1Hf9vh7dmIOebat7F+QDXHqiCrB5BcGpaoSAn7zaytNdI6+6iiIr2FE6YW5uSofVMsusvL4y+kVPlEcxHidSGbrX2IzcPh7/Ow3quG4GdhHXT1GVoySAozMEM6POv1R+DrlQBshT5xXeOYjDw5IGISnpdHJ7VfPGePFdgNA/NQ+s5lIUWXsYugX+Hr86NQppjV7UAXNd39bm+FkE+LDaqim1bHzB/5chir/Qd+SeiO9PwD8CcAnRj7sZ5ep/3AI0sPVBXF1u9e5hNFQWtWLfThiUWzgIDzo7IZuW0SjvZvf4r03RqXAOCEaFA8wtEoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPve4r/RoXld4U11o2zIITAOjMR12mbifWEQHzsCt9Y=;
 b=Ila3Ukc7PhDo4pKXnpREcjZIY33suDvWiiruMZ4qr+HA2NOw63roxhk4oF+sUaAx+2FDag67RKBibx5G7bFzZYyD1utafAQpRldOyyThSq0yO53A+/mbmiy9uIysoK0A2dLAi4AYgmZGOm1S8UzW/WIoptiLApe5cfHHR5LMZHU0BI97mln+hAwriRZKut654DJLoDwr7KlkUINanh06rWT4/WZATima5am+xarTQqdTqTD8xClZsmZ0m2BO5iZQ4FZkrMXMVCkwH7G80Us7aEP/rYe9+VPRhFSx3d62y/b6Q2cYPkYmdumhkHsKlbaVilBQLXOQlDWjNiespRFuNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPve4r/RoXld4U11o2zIITAOjMR12mbifWEQHzsCt9Y=;
 b=mbsMwJjj/VZPh3TJx6MHMVe3xfx5HDOomWq79RrVTToBvGjBcUh1OujDcvzcJdy8+8MJiTo11NgRCUOhSSlaN2ZFapQG0bevVpNgodFOxHg7Y13NRxK2IYC4+a8ikrk+KT7cFsAxWuCphA/aBB/5esUHlLfp+iH1AbfZUPr1cOc=
Received: from DM6PR02CA0115.namprd02.prod.outlook.com (2603:10b6:5:1b4::17)
 by CH3PR12MB8331.namprd12.prod.outlook.com (2603:10b6:610:12f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 16:22:32 +0000
Received: from DS1PEPF0000E638.namprd02.prod.outlook.com
 (2603:10b6:5:1b4:cafe::17) by DM6PR02CA0115.outlook.office365.com
 (2603:10b6:5:1b4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 16:22:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000E638.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 16:22:32 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 10:22:31 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 08:22:30 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Fri, 10 Mar 2023 10:22:27 -0600
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
Subject: [PATCH V7 7/8] soundwire: amd: handle SoundWire wake enable interrupt
Date:   Fri, 10 Mar 2023 21:55:53 +0530
Message-ID: <20230310162554.699766-8-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310162554.699766-1-Vijendar.Mukunda@amd.com>
References: <20230310162554.699766-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E638:EE_|CH3PR12MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: 63e11f6c-0d96-469f-e3f0-08db2183a691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G94drUPrMGDBWraVBTmAQ8x0FaZgOLQ0Yr3tm4YkjT6Y2nZ9pFoMcqh/JOmGkcsZIbAOj3JKaeNEIWi0NgxIN9avNkBvseV0UT0L1BGYc4IZ1ulfa9LsY8mAgF2HUdO8LqgsHs1J4dbnphaS/z/CjRNRPRg2Ja3+P/r6v5klomRjkDrJ/ZZPUPkXfxTBR32VQgjKaWbx4b0iDrkWeFeUhZoTIhUOlDNk0dn/HQoe25f02tGJxrH9akieXqB3Skno/QbKm47t6Uv0W2xIFV0J/jo6OtXdJbW7wfNIeAMtcC99A9rmxZdVrDAo9X8vS35/ZohuB8iT144LvbbOlryDT84vWuy8CVQxhlvFnAi1DgJ8HlZQ05nRhCgmht+XcFb5ug5bMExbgSEM8YqXMTqLMvMTgVugXwfN/SyFa62/Ldp9/ElrD19EnobCFR7P5jVY3EEUnxkZrVqU3MikvqQ0Mz3/WthiloZJLJFtGvstGdTtyW9zxntijJ6/VNiGEQE+7LRMqt5aUq2Ma47AO8LA2gus/YM94kGt2fBqQ1LypNvl1F4ITsF2iii6p73b5YwaEIg4aDbMBaWjBrvDA/u3kE7lnT5oVNhHoXIFJDjWTCsYWBQOWGJYByLixNhOrju+c/oYjg7nz81blBjj86dbjo08Un+V9kcQGTSZ/IB9AW+2vlY0JtMvUaG/PrnYdlEf4S1aLNcVDa/XM1FamAq0axqcKf7R/G4XGoQFUc5EG9E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199018)(36840700001)(46966006)(40470700004)(2906002)(26005)(5660300002)(1076003)(8676002)(36756003)(70206006)(8936002)(356005)(4326008)(40460700003)(6916009)(316002)(40480700001)(54906003)(86362001)(7696005)(478600001)(966005)(6666004)(81166007)(82740400003)(47076005)(41300700001)(36860700001)(186003)(2616005)(336012)(82310400005)(426003)(70586007)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 16:22:32.1287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e11f6c-0d96-469f-e3f0-08db2183a691
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E638.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8331
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add wake enable interrupt support for both the SoundWire manager
instances.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/lkml/20230227154801.50319-8-Vijendar.Mukunda@amd.com
---
 drivers/soundwire/amd_manager.c | 10 ++++++++++
 drivers/soundwire/amd_manager.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 5811a408ef93..fe9f5ae84a23 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -869,6 +869,13 @@ static void amd_sdw_update_slave_status(u32 status_change_0to7, u32 status_chang
 	}
 }
 
+static void amd_sdw_process_wake_event(struct amd_sdw_manager *amd_manager)
+{
+	pm_request_resume(amd_manager->dev);
+	acp_reg_writel(0x00, amd_manager->acp_mmio + ACP_SW_WAKE_EN(amd_manager->instance));
+	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_8TO11);
+}
+
 static void amd_sdw_irq_thread(struct work_struct *work)
 {
 	struct amd_sdw_manager *amd_manager =
@@ -880,6 +887,9 @@ static void amd_sdw_irq_thread(struct work_struct *work)
 	status_change_0to7 = acp_reg_readl(amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
 	dev_dbg(amd_manager->dev, "[SDW%d] SDW INT: 0to7=0x%x, 8to11=0x%x\n",
 		amd_manager->instance, status_change_0to7, status_change_8to11);
+	if (status_change_8to11 & AMD_SDW_WAKE_STAT_MASK)
+		return amd_sdw_process_wake_event(amd_manager);
+
 	if (status_change_8to11 & AMD_SDW_PREQ_INTR_STAT) {
 		amd_sdw_read_and_process_ping_status(amd_manager);
 	} else {
diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
index 65bc79d8f7c9..cc1a14731fd4 100644
--- a/drivers/soundwire/amd_manager.h
+++ b/drivers/soundwire/amd_manager.h
@@ -189,6 +189,7 @@
 #define AMD_SDW_CLK_STOP_DONE				1
 #define AMD_SDW_CLK_RESUME_REQ				2
 #define AMD_SDW_CLK_RESUME_DONE				3
+#define AMD_SDW_WAKE_STAT_MASK				BIT(16)
 
 enum amd_sdw_cmd_type {
 	AMD_SDW_CMD_PING = 0,
-- 
2.34.1

