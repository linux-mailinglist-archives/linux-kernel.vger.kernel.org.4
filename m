Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D746C299A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjCUFHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjCUFGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:06:42 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038677EE6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 22:06:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iE7LUG90zsLItOxGvpMiC4kta2lbUDX/KhU+ydJgqkWwrgmXg9Y6TfPUAwR1sOqfszYmslrtwe5Av1ty93W/xn6i2W3lpYzcg1LoaejwBQbdXqn4d43wGZ4Phb4qnZG5CzscnQQQeUF/MsAKzevCPfuGc6fb2/VAxGdG4mB8WRUTFAuZiGUiMLjzGpsCX16ai9JuInvnq3yrTf0d2aG59QpNS+5J6+K3s/3IhOFbOgmPHQbkJbQgsXXCae81mHzrVFpcPvJV/UcUz9yCND/Zc1ddTVPEfZl0U0dUsRyNGQ8LeEL/9YOb9PkJmvPx8YdQrBJc/FquaLDsehoci+cJRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGjOnj3w81we7hvxzh6JbxOQKMWNFti4MNnbTK9lxk0=;
 b=B59E3KbyXSlAz4hquUSaCM3d6ivEg3hcS9iIK8kRuNY0Nw/ZgZCQFrpWV0TQ8yBg2861dKL+fmOXJh9N5gdU8bd8/R2oaMgZVPYjn2cdkGqAf8xKpPLTF3WBLrvJMvD9G5dCxUPkOwU9zhdphBNaoBCkTEhOWc2YkuN+j9whE1oPsLSSWdJ7A0OuChUae9Zrt1tah1WDC8fY5wWU7COxe9TwynFG0Rm+oofUNqLUsFm8o+5nFmYGT2UhtApL1AdI94P/bFsl979dzMYWOgWxeQSkG2A0mPbWAlqCFcP5BjtRBroh2hWeMD1zLXLZtJXmu55g1GvPzDaQUFoOQq2JfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGjOnj3w81we7hvxzh6JbxOQKMWNFti4MNnbTK9lxk0=;
 b=iurTpoHDhuhoWz2cMAflMprs5xNNL2ZKbi/oF75ylwrGSHmeNCYMnzzAjdcT8STjvFDsUSSzynLjIAtgNwvhqN8SDYuay9LhFU/77vD+U2/67j7Dx+Y15R1p+f0htAHVzENJIHB5pQ9STnGnXM28XpLmgcgM0+YmhbBokuFRRbk=
Received: from BN9PR03CA0444.namprd03.prod.outlook.com (2603:10b6:408:113::29)
 by SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 05:05:57 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::b8) by BN9PR03CA0444.outlook.office365.com
 (2603:10b6:408:113::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 05:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 05:05:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 00:05:56 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 21 Mar 2023 00:05:52 -0500
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
Subject: [PATCH V8 7/8] soundwire: amd: handle SoundWire wake enable interrupt
Date:   Tue, 21 Mar 2023 10:39:00 +0530
Message-ID: <20230321050901.115439-8-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321050901.115439-1-Vijendar.Mukunda@amd.com>
References: <20230321050901.115439-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT023:EE_|SA1PR12MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: dc6c1de3-c6a4-45ff-8a09-08db29c9f45c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IdFOygQ2tBx4mqsnbICqO4bm5tc2MbvkbPwpUTh0DUccio4RbvHdZ1fi+UlxJe+r+nOGgukeGK/Cr6kbs0yNG8OvUQ5gdApZAXiaYDgUlsj0CAKb4Tv+oqCQxvnYgygl2hyMkH+RnQmvJ35xRswiI7tvWhA1bsvTFYNJdjfkbCFwBDWg9C8IilESR+XWgG7msE14UJSQBWYotetDwrbKzn3deCvPhIVi3UpiKmmA6WEKRhbEcgZe0iCjF220uGU+eSaCudA13bMziRkb5YWPaHwAVnC2dZaZaIY/ygxCJJOUeT9Ze5sidcF0uZ0oiBOX2RxdSQ8jTHmEgVLHTbcXQcumIX8Bz6VizbECeZNwdgXcUNjX+mN7V7cgql3VG6nw6UMD4OEUSVFC70bTO3XLWmIDzBK0iiT5BuTFbOLJ7EBSykCHh7+HSweJ2HYLjKum9ncUTJDL5tONo4OiZv2ZkkmofWMd8P+BZwns3vr20FYrJ76rLP2lvKK9AG0Xcy1DgkQqoPCI2WWezGWoyVCh5q1QvIB7CSpaNZemhAzFXvfCoiHlMhniPeDdLFnnwkiYXrSr0OXUMj+XXZebUosLKNfHezAoHTXmr2v2kG2if94xZuvezJJdsp56q+cOASBsD5JdtUvxm+vra7mag95dm1D/iQjz8kBX+W/B5jLFOWwmwqmg/0iYWjUobxf0C4x7V8uEP9s8CsVCl6NtFkcRbS9sOE1xXF8r9bcBskM7WNY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199018)(40470700004)(46966006)(36840700001)(316002)(2616005)(82310400005)(70206006)(70586007)(8676002)(6666004)(6916009)(4326008)(40460700003)(86362001)(83380400001)(40480700001)(36756003)(47076005)(426003)(336012)(186003)(82740400003)(81166007)(7696005)(41300700001)(26005)(356005)(1076003)(36860700001)(54906003)(5660300002)(8936002)(966005)(2906002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 05:05:56.7459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6c1de3-c6a4-45ff-8a09-08db29c9f45c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797
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
index 6172b3cb84d4..d55706e87d83 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -831,6 +831,13 @@ static void amd_sdw_update_slave_status(u32 status_change_0to7, u32 status_chang
 	}
 }
 
+static void amd_sdw_process_wake_event(struct amd_sdw_manager *amd_manager)
+{
+	pm_request_resume(amd_manager->dev);
+	writel(0x00, amd_manager->acp_mmio + ACP_SW_WAKE_EN(amd_manager->instance));
+	writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_8TO11);
+}
+
 static void amd_sdw_irq_thread(struct work_struct *work)
 {
 	struct amd_sdw_manager *amd_manager =
@@ -842,6 +849,9 @@ static void amd_sdw_irq_thread(struct work_struct *work)
 	status_change_0to7 = readl(amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
 	dev_dbg(amd_manager->dev, "[SDW%d] SDW INT: 0to7=0x%x, 8to11=0x%x\n",
 		amd_manager->instance, status_change_0to7, status_change_8to11);
+	if (status_change_8to11 & AMD_SDW_WAKE_STAT_MASK)
+		return amd_sdw_process_wake_event(amd_manager);
+
 	if (status_change_8to11 & AMD_SDW_PREQ_INTR_STAT) {
 		amd_sdw_read_and_process_ping_status(amd_manager);
 	} else {
diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
index b101f4536230..5f040151a259 100644
--- a/drivers/soundwire/amd_manager.h
+++ b/drivers/soundwire/amd_manager.h
@@ -189,6 +189,7 @@
 #define AMD_SDW_CLK_STOP_DONE				1
 #define AMD_SDW_CLK_RESUME_REQ				2
 #define AMD_SDW_CLK_RESUME_DONE				3
+#define AMD_SDW_WAKE_STAT_MASK				BIT(16)
 
 static u32 amd_sdw_freq_tbl[AMD_SDW_MAX_FREQ_NUM] = {
 	AMD_SDW_DEFAULT_CLK_FREQ,
-- 
2.34.1

