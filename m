Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923836A7B4C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 07:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjCBGUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 01:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCBGU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 01:20:27 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8FE34020
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 22:19:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=is3YzR3nU5aGFxNv5hQLQ1cS1sdFlJ6aQj4YyIcWxvPVvTPTsNoBihwL4z/uzpJMoAXNjwq0+TQ0r3SU0f88xOQmAHTDSqoIEGlXPkWSyNVzHnSTVfFLbFuMBvad0PgQNyEUur+hs/mQuoxS7g3EwS0krujqZiV6f5y58Mj2etCLo5h1qVzuxQZE+8rR8XJcufAq74yqwkcBsvuJfQb2+c8+tVHMH+k7/hloPKYTkmIueFDcGFsA3ZBDPE9uHFfmzOizBxs8bXcJgVPw5dW+bhBGu3qNAxrOTdiTSS7Mjsu/uugOq44Mhf0dXuAbtYSihiPAGwDLc9rLQHND3tJWjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ylmuvE/Fzl6uSZ7yPE9Gu9rTU3SZqPH2oQ0xP9CALs=;
 b=C/ukCgqa8HHMMo7/ro6QP/kzQyOC/YpQTxTE9eMzRFhRLMW1xbe1mnJqvahfom3SKvplhvuKxSfB2sLW/dcnzbe/G58nJZAKt2LsELyfnLjiE6g6bOZUJlM0EDV3hTeQ0cbkTTA7cC9KBN6kUmM/9LaKBC+9JOKxs6n8hKmwi4Am4yY0kRReLb3QFVz+8HxqfYQJKCz3hfGDZBMn4AFdePVoPnp29+C+Tx1Eg4Eg1MJGs9qEBZke2xVGL9hos0r6uy5T6TW5jVMWg0RIvxymI1DiBZTr1cqrK4Oic48C7hcHy1FwE+QvlyNfs3wC85buOI/908xJOrunEfaegs6N+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ylmuvE/Fzl6uSZ7yPE9Gu9rTU3SZqPH2oQ0xP9CALs=;
 b=phP47sdFrXTh1tYqXIiRIEhOZSZFqbDsuDhkvDZajcWYVObuzEcJRsk/mi4UkqdWxci/DLFh1io7ynkeCwco9YZW5apshuv1Z0hSCEXyJrTdZ6uBiGt6pYlrCaPF+e1q2MpU6AectU0JXBNfvsrOVOBwmpMMG2N8F3tYBIAeNhc=
Received: from DM5PR07CA0113.namprd07.prod.outlook.com (2603:10b6:4:ae::42) by
 PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Thu, 2 Mar
 2023 06:19:40 +0000
Received: from DS1PEPF0000E655.namprd02.prod.outlook.com
 (2603:10b6:4:ae:cafe::b8) by DM5PR07CA0113.outlook.office365.com
 (2603:10b6:4:ae::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 06:19:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000E655.mail.protection.outlook.com (10.167.18.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Thu, 2 Mar 2023 06:19:40 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 00:19:39 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 22:19:39 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Thu, 2 Mar 2023 00:19:35 -0600
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
Subject: [PATCH V5 7/8] soundwire: amd: handle SoundWire wake enable interrupt
Date:   Thu, 2 Mar 2023 11:51:06 +0530
Message-ID: <20230302062107.207845-8-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230302062107.207845-1-Vijendar.Mukunda@amd.com>
References: <20230302062107.207845-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E655:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 0179331f-48c0-492f-6ed3-08db1ae61b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9rLBW8qh5UoD3M94Z1M7s0NibHQYyFangDxICAV8qZgjEZiqraBdVvkMZ2sDM7CZfmqHfwh0ZYMhAT8fn9bTU8bphSGIpRI5aanukuHoxWTQqVvbkUou3EIweFibhgEWhatuEm6Wv2CgfokjmOy6FbRRELwGwkRPpzccdYMEjL0cMamLoL3xsIGC1RdA/ezF9xDXwRNow7tX8bXmS/3CctUEn7dOXJ99oIrc4gSsBkYCmMyLhKE/FkNXz4NJY9uw5hCN1VYc8ps5HEKYGy8AZk84/DStJ2ihFw1n8sVMMldBHStZ+PRWnZlh8qTw3b2hXfuo46wRSh/vMR5ZNoWOd4yo8BzqyTNrr9+SUiQnn1T+m/hLfaBfAxA6sJdkO/yLxrEf4qqV39zJl1EmxetimCtTyNi3obLsXhtuSXk/nkIl6H0b6IiwawcroByf97Q60w/xE8B2vjcLtGG5WLIzQIO0Nq0pj4R//1aspjUun6S6OL/jNSbcRq/YZFhAk6liiXoOECKF/fTCRzEfpqcFhUh07UzP7KvzRpdd30G+2Iim1Kyo6oUheW+u/+ufGOmlrDprh9jiz/jrAw/ZPdMwZZDNj/TAu5MVDVnazsOx0GGUKxR94cjpWBRApnSOhRmVjIg+534HUun91MZtNq8gCRNq2lh42bJ6PFMKoR6Wcwyd8vX75hPn0Dx7HUkYraK4U8pqsDERXqgbtX9Xe6q/mn+n2Ap7qlHP+Cj3gf5HDtc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199018)(46966006)(40470700004)(36840700001)(86362001)(36756003)(8676002)(41300700001)(40480700001)(4326008)(5660300002)(8936002)(70206006)(36860700001)(81166007)(356005)(82740400003)(7696005)(966005)(54906003)(478600001)(6666004)(316002)(6916009)(82310400005)(70586007)(2906002)(47076005)(26005)(426003)(186003)(83380400001)(40460700003)(336012)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 06:19:40.1964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0179331f-48c0-492f-6ed3-08db1ae61b1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E655.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
index d074c11088be..1caad2ccdd20 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -927,6 +927,13 @@ static void amd_sdw_update_slave_status(u32 status_change_0to7, u32 status_chang
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
@@ -938,6 +945,9 @@ static void amd_sdw_irq_thread(struct work_struct *work)
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
index 93022a325598..2e9032784f34 100644
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

