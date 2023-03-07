Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764BC6AE083
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjCGN2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjCGN2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:28:31 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52B72384B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:28:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxWZuH4rvA5eXBMfMmB9FqsIc+JNBmdGM0+5zU1jnxDAc/zUmYA6bxEq8UPebQp/be9VhmjqM0fF/66KZFxiykz4FespAbEI53RfhItCU8FKay/gDI9UPhCM11G9uzkXNTDg4e1FeF3/3t/8QuDVDpzJUVekLfx2ZgfqJu87Zl2La4raXwRllkUNukcvFNbBUFkqN3eAVQua4Op2esRyxZzwZZV/QfIMeF0eBEU6RV/TH5ZaigAaJPanxvS/vbyjbEsMqwtlWPhVVkPuUxozmaamXYXEozgl2fTIqMo58fQYHd5BeFyMjZU6WthJiT8Yq5B2MY2Gjyu5MG6zTA2yTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/nidqTc+ifLXEmwv71kIvEHYLzPNr0tMT2XSQej2c8=;
 b=NL07KVSgCRN06P1e0i16/w9miPifzBfI4JAZacf3N8jUGcrXAmze5LOM4f0YHBxG49x/nucO4q6z64U04o8AwMjYDlkV90WtWK7n+jZ+QSjpb5hD/7AewPEw25HwUuEYX4nPsF2GUuSwZGgpYIV4WTaINc7FDv0nc3Mj65aC5QjTJQCRhEQp33oF51KT3f+xsOrQDAXoJIVunlmwOtPgpfxQit4rU3goqpRJKxAvsS2TVHZIPY+hzKfEjexF0WJS0xXTJEwMCprvDKTGY9P45j+317gjhitnhMABnjYVVpPnWrsoujjx6Y51HQjwddl9SS0RGjIh/rW4lVaw2WhrOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/nidqTc+ifLXEmwv71kIvEHYLzPNr0tMT2XSQej2c8=;
 b=zotZLHz3WcTTegG3JMZRrVltJ/AwrfusAPN+rx0b3N4FGl4dOyPYc5v3xZMVmlinimpbG72HyMHDtQVareugzNnSLdpizw6fDAiVdAZ0in3qygvOC2ZW7ddEmQS4btvGSbvQRlIEyPsh2UrtvjacimdLwsBAUoKqi9KMcySUsOM=
Received: from DM6PR02CA0054.namprd02.prod.outlook.com (2603:10b6:5:177::31)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 13:28:04 +0000
Received: from DM6NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::c) by DM6PR02CA0054.outlook.office365.com
 (2603:10b6:5:177::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Tue, 7 Mar 2023 13:28:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT075.mail.protection.outlook.com (10.13.173.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.16 via Frontend Transport; Tue, 7 Mar 2023 13:28:04 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 07:28:04 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 05:28:03 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 7 Mar 2023 07:28:00 -0600
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
Subject: [PATCH V6 7/8] soundwire: amd: handle SoundWire wake enable interrupt
Date:   Tue, 7 Mar 2023 19:01:34 +0530
Message-ID: <20230307133135.545952-8-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
References: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT075:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: f0847412-2c71-4500-88bd-08db1f0fc827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Em96nQFljapMzif/jOuXyZD/MCrq0WjJSnL8UuhPv6PivhSKfzWNHntT3UCutsYKxI0UqlKf3Kq3UaKDn/DJ/3/jufOyELNcuyEzRZ0A2zLhNGOOKY8SEwquI0T9cRwyPoDRhuYpsWXoss7ag3PwvW2g9P6jursOO4dNyE4vSrBHuvmctfE+bMdZJMaqDpPlDla+VXgb1yosng30KAv6N4ggMd1V9crV5uc4j/+Fgn5erkP7BjeRuE3Zs9gcTjzbUg/vyJVgdXFvHTBma5mWRVBrZOMNf74cVLSuZ2TTem/QoTI/2hbPbPcd4kKfUPIrHfjhKuQ1qLOiESJphFIVMM/VUnl93OWdn9HgZBGUXupzshsYTJJleIf5KqV8e6pkCyfHVvZokUDwWYqa538Mb5ame4qT4gn+NXq1sm1YKN7b+0nZi0CQT3z8sBBkfIQr+14XSO1sIS+eX6VrXyMmp5D5S0u6LSUYM67I/ltVBc+Plznw7Xe6qNzM//rP1kuouplqj2zeCYmXsP9rZp2fX+46JZJLO1Y98SOj48KVf5js0/6wr+6N6dgOetE1iM/FeEocm6WeDBkxFFBKUYJWj6egcnZFVt0dd8D9Mu8ywEHRc0nG9FK/Xk84i5qOLLgFHPyZcmFe8Q2LzcAHCrkxtUP9DBmw4vZbuXOMs08VonXxjYfW15sKcxxrlmus2C8b3MXnmGGsUuB5iwAn9BwBIQjaFvK4RPh/H0/SJj7TX4Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199018)(46966006)(40470700004)(36840700001)(40460700003)(6916009)(966005)(83380400001)(8936002)(41300700001)(336012)(2906002)(2616005)(478600001)(426003)(54906003)(5660300002)(47076005)(7696005)(6666004)(186003)(82740400003)(70206006)(86362001)(70586007)(356005)(316002)(26005)(8676002)(4326008)(36756003)(40480700001)(82310400005)(1076003)(36860700001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 13:28:04.5280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0847412-2c71-4500-88bd-08db1f0fc827
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594
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
index c3c0bee57bd1..70e4fcd7e1e0 100644
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

