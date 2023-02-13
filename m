Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCDD69416F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjBMJjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjBMJil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:38:41 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405CD1554C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:38:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iC9HbxcXhzg9xcyEaToiKtxN4qLMqWzWgnhXxeA0wYaF15eHRoSv/MJ1eapWv8o9+ZBmloe3MiqlzFQYuR7bpaXb0HZfaVSlHfpFw4O7tDt7SHbuuZCzM3CCme+bT6rx0OI/ip94uWbYapCZp3HQW16z8wPO1goAMD9I6FPlZ6z5XLmGOF1E5SHwz2B30xMsk+O36yPLxkBfd5c4bc9GAPnlAgGR3u0dxZI8I6CFCkZS+TRGiUJSrxjrv2jCh0e3Q0VdcvxYRIm9aK2QWmqxE3GaK+lkkns0uy16ukWqNk3PfyRb9SpQiXP3/EN+y+jxiOFAzaYFDfahQvkMLxhL1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeFQWZbbJxocXfFnm9nD3sCdlyiUB8IFqsL/kHrRRSQ=;
 b=HI39wz+J8PVojG+Pk7eNzv8jK1cOxaVPZbfuDhD0USJ9kCgj/kBZhBjazqjBLcrDGsy0u5YZ7EmIMloiXZi+lHRJTu/1jLTb+kfuZMpXay+SmrGV8SE+f9eg6l7QdC3fSX8DfxkUkjS+l5WJfCpra38TpiT0bJ8jWsDj8kzykj5V67u4Gh5Bkd8e6vLUAUaI2DXFTEQuwnLB9tueRy23TRdraOHt1YjEiER3ML5XwVNhOd1vA8Tgwoene6R0eJ56RUGhHU1KC3zjCh09HQOhlyVsS8wYvScanBQZbVWI9c5fdPl6fkpxKVrllJKjJoHuNdJrKRPNPqH7KyVJuY+KJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeFQWZbbJxocXfFnm9nD3sCdlyiUB8IFqsL/kHrRRSQ=;
 b=dDn4aZosLqtj1NU03oVRYwphsU7ojCUbHa/vUyGa4bxh6DXCt3IEZTnKlzKrIokwiQ799WyiR278QmMUsq5/y+1qyjTbe1I5ZXCjE0q7Pxkg2oVa2WKBY2aFY2PdNTznvx8XlWPm+gpM11LM19boCXDuiMO3/Sqrx8DlFFTw9yo=
Received: from MW4PR03CA0187.namprd03.prod.outlook.com (2603:10b6:303:b8::12)
 by PH8PR12MB7027.namprd12.prod.outlook.com (2603:10b6:510:1be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 09:37:58 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::17) by MW4PR03CA0187.outlook.office365.com
 (2603:10b6:303:b8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Mon, 13 Feb 2023 09:37:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.24 via Frontend Transport; Mon, 13 Feb 2023 09:37:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Feb
 2023 03:37:57 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Feb
 2023 03:37:57 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 13 Feb 2023 03:37:53 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <vkoul@kernel.org>
CC:     <amadeuszx.slawinski@linux.intel.com>, <Mario.Limonciello@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        "moderated list:SOUNDWIRE SUBSYSTEM" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 7/8] soundwire: amd: handle soundwire wake enable interrupt
Date:   Mon, 13 Feb 2023 15:10:30 +0530
Message-ID: <20230213094031.2231058-8-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230213094031.2231058-1-Vijendar.Mukunda@amd.com>
References: <20230213094031.2231058-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|PH8PR12MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: e4835142-14ff-423c-d98c-08db0da5fdda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nldk9MBDwFU63VPB/3+mXr1Ga0RUJKPAELeyhHLCPYSa6TSbLFVqoKpyBxNp8KmWpt2rf7f5Y2SIkeuNei9N1QjBh4jdJ4paQItzgoBx6aP5j3GrduCR5ht9aIq6Dohq7mkVekOTqqk+7ngat2b8UO4oHXFg80um0ytlSk9Kv4hmsk+d9HjT3RSkzHneXCI4T3KX8uP76APmeg5d/WnBpW6gK0AGhGTc9py/0M2e9kNbktNadPibkJZ7+3+2V1VuWlYk7PaMmZOXBA6sajHbXzPkPMJGNR1njIYUiq7NxygTlLMzZbRdpjYh/rU6jf1yHDIxSLd1eh2J3XKK9ef+Or+ULFDU30Knh10BCWjzWdH8AbSeAMk7cBYvSVwdDRgcHCg/XYFBbuhiXE9RWCUr0/Ssmmwlp+5RjTWUjgKvTyK57v2n8dd2//VETs9rHKx7pq4Lx641hqZpSMeOc/IuffUm9SHwEmWGyjNxbOpZBXLSx6Lg4+vQvGGv2dEhrhTGusur/bCyLNzkMaET+IwM15RrtwnB5hLqK1dESr2h0kEisc4Rgipr9cn6MjQ5UwQwDq2WHnX5RIHLXPTXBOYYummNyxTBvLANxJFHSuOUYW3e1Qy7rK06kiiR7o/zTOWGGeS1E93Lofjf6PeQaJOc3sM6Xa2Xq/+bUV+LqfB4zNrHzbDqO0VqtVKuw51wLcFgDO67/C6G6dM9iUvmgtFA2G1wDwWd9worO9+uvduyx4mvFS1RhciZTh21ho5VD3HZrr38Zf6O56ONC8Bi7WTcTkVYX79JlNZ40oYgZbFhh6Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199018)(46966006)(40470700004)(36840700001)(86362001)(40480700001)(36860700001)(81166007)(82740400003)(82310400005)(40460700003)(36756003)(4326008)(8676002)(70206006)(70586007)(54906003)(41300700001)(6916009)(316002)(356005)(8936002)(2906002)(2616005)(5660300002)(83380400001)(47076005)(426003)(336012)(478600001)(7696005)(186003)(26005)(6666004)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 09:37:58.1237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4835142-14ff-423c-d98c-08db0da5fdda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7027
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add wake enable interrupt support for both the soundwire manager
instances.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
---
 drivers/soundwire/amd_manager.c | 10 ++++++++++
 drivers/soundwire/amd_manager.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index eced189ba6e0..e53dc67f8529 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -934,6 +934,13 @@ static void amd_sdw_update_slave_status(u32 status_change_0to7, u32 status_chang
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
@@ -945,6 +952,9 @@ static void amd_sdw_irq_thread(struct work_struct *work)
 	status_change_0to7 = acp_reg_readl(amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
 	dev_dbg(amd_manager->dev, "%s [SDW%d] SDW INT: 0to7=0x%x, 8to11=0x%x\n",
 		__func__, amd_manager->instance, status_change_0to7, status_change_8to11);
+	if (status_change_8to11 & AMD_SDW_WAKE_STAT_MASK)
+		return amd_sdw_process_wake_event(amd_manager);
+
 	if (status_change_8to11 & AMD_SDW_PREQ_INTR_STAT) {
 		amd_sdw_read_and_process_ping_status(amd_manager);
 	} else {
diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
index 6ec37612ae4e..86bc6d4f48bf 100644
--- a/drivers/soundwire/amd_manager.h
+++ b/drivers/soundwire/amd_manager.h
@@ -190,6 +190,7 @@
 #define AMD_SDW_CLK_STOP_DONE				1
 #define AMD_SDW_CLK_RESUME_REQ				2
 #define AMD_SDW_CLK_RESUME_DONE				3
+#define AMD_SDW_WAKE_STAT_MASK				BIT(16)
 
 enum amd_sdw_cmd_type {
 	AMD_SDW_CMD_PING = 0,
-- 
2.34.1

