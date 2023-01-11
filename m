Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D586656AB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbjAKJAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236493AbjAKJAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:00:25 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C764210B53
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:00:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1kyK0hp9kFgCNSq0B5y6we09sFupPSpA9ve5JBsAsLccJ8eUSZSD7Lb4PRdJHzAXgyN1kw0FPWa6v/MI7wI+8JNl6tNoRw/sdfp2t95Il7WwihzQu3zDBEMSsc5PaAfC/nsqWXxrjJPmxgF8i6lL0/WvWkgi9Zpi/xPTLhpn5JTaPzfp1RoXmwDhgCITnwwkzWMYW40Yg5ybk7SBUMNFU8yUBoUUCyBueRwQCespQy/t0FfcnYuVJnmQEvYq60GMHNyY+3S4kuu0kQpbmuFH+xq2GCaPfPt/21OAiZx+PRnFJyDI0vurMGnSFQ8zGroefUHifsP8fU1kl5QZVfN8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5WqWIReKKQeM15aIHhAhouNQALRj8AWEPnyoAnwPsw=;
 b=BM0vZOOGGMWP6rP9rCaXT6SJlljkZo754t0J6NkMHoHXCAmLFhj8iArCdJAfJiK5eoS/8FRFzpiFWB0lnyIuqC9yTX47GWppF8UPDGMtUgsPIWJDjuYuP19WTRPS3iKkCPwvjz4llMpk72TVyR9+z+tDqcW3RD9OsZxXQvA6NA9NFE/XsAVkq5tNNWlQ8dPgaQmvtEg49+mFEUlbp2fx2UoQEt9EaSENeQf7lhB6AbB2K3BhCuZlEySU0BvE+wIZTKj8ICP+Pc2ayf5wqeVgwSDSa9H/PUHk/XXfQHwfOFXaC2FjRdGSvAcM7CEcbxB/ddkmvEZAnicrk63gsoZVYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5WqWIReKKQeM15aIHhAhouNQALRj8AWEPnyoAnwPsw=;
 b=umUsyjehEKSEjhpnr4J76KfEFcwbF0OA003UxbLabBUjnQRDffiobrCyWU9olhE7k5OdwGJN0y5hwIk2TyyiYZZI14fkffvQ6YQndp2Kna/Q3QrUCbi7ipthrRm7tIdkxe1sgMv2qsHZkplDr+ttdS5eR3F5r09XajDEiClpcvM=
Received: from DM5PR07CA0100.namprd07.prod.outlook.com (2603:10b6:4:ae::29) by
 PH8PR12MB7134.namprd12.prod.outlook.com (2603:10b6:510:22d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 09:00:21 +0000
Received: from DS1PEPF0000B074.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::3c) by DM5PR07CA0100.outlook.office365.com
 (2603:10b6:4:ae::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12 via Frontend
 Transport; Wed, 11 Jan 2023 09:00:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B074.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Wed, 11 Jan 2023 09:00:20 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 03:00:20 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 01:00:10 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 11 Jan 2023 03:00:06 -0600
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
Subject: [PATCH 05/19] soundwire: amd: add soundwire interrupt handling
Date:   Wed, 11 Jan 2023 14:32:08 +0530
Message-ID: <20230111090222.2016499-6-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B074:EE_|PH8PR12MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: ab6ace1b-a6cc-41ac-5a57-08daf3b244b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vhFr4BGpvto0Ln5nhbU8estCdzrjd5DGhdSwa3aaWCr1/Hvwnhv6L45tb6AmgIOK6+mOHAeHTNq/N2A9PYSMv+J+IogV299t/w87lB0HvMbk353PjcanJolM30R+xp09Td99vj6+b6+UF4W8QZCCMliJ+qrXGKg8JJyXGlzJ39TAkR7hlGJcpUZGFsdojUPaLRQbL25cFOtDNo4d/ZjNOz5GKy0bu26yUrsuhHZRZzCvNKXu/do7W6dgnNDL1dIszgPA0OCr4J/zHTZBCtaY5umCKnourhYMCpVRRKfXCnL8wcNEQ+fjlopjyxhIfWznwXjBnw0wa30/HbYP1ITTdilVdqmXexGFPavVTFd3yJJUpWzBrzUwftXtCFRZsFAUggfo2bUNXbIjVO2+1S2Xfhc/ykkWtLar7sI7n/v29iGmNNqu/YfQ3lHT54a1pYe9ksyUm0BHrBeMijRrjtAdQl15NwjtXlPuYBNxRGhCBY0crxRRiICTc1KZODxjIczEMFyrPxHV/pwQs4mGKD/cY8OQgDdvTzH5l4/eXenHn1hgU+PYYqRiMTO1v2Sv/SGirve9pRrQ6Jq8RTJf/Ve70i69MjhoiNj0N8KfCTKOb6OKiHtoN7NDuuA9qinbiL8OOQefBzDVJYXBz8Mksf7hlyGhKte4zEjFbKEepD+fjWGy4ZrkxKXs7lj53gs3ji3vTOXYx4Iz++Y+9qFE6ayPbSjTsFYoT0AXp10WyjHZiVg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(478600001)(426003)(8676002)(36756003)(86362001)(47076005)(4326008)(110136005)(40460700003)(82740400003)(5660300002)(70586007)(70206006)(356005)(41300700001)(8936002)(81166007)(36860700001)(316002)(7696005)(83380400001)(2906002)(26005)(54906003)(186003)(40480700001)(1076003)(336012)(2616005)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 09:00:20.7701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6ace1b-a6cc-41ac-5a57-08daf3b244b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B074.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7134
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for handling soundwire controller interrupts.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
---
 drivers/soundwire/amd_master.c    | 156 ++++++++++++++++++++++++++++++
 drivers/soundwire/amd_master.h    |   1 +
 include/linux/soundwire/sdw_amd.h |   3 +
 3 files changed, 160 insertions(+)

diff --git a/drivers/soundwire/amd_master.c b/drivers/soundwire/amd_master.c
index 93bffe6ff9e2..c7063b8bdd7b 100644
--- a/drivers/soundwire/amd_master.c
+++ b/drivers/soundwire/amd_master.c
@@ -557,6 +557,47 @@ amd_reset_page_addr(struct sdw_bus *bus, unsigned int dev_num)
 	return amd_program_scp_addr(ctrl, &msg);
 }
 
+static void amd_sdwc_process_ping_status(u64 response, struct amd_sdwc_ctrl *ctrl)
+{
+	u64 slave_stat = 0;
+	u32 val = 0;
+	u16 dev_index;
+
+	/* slave status from ping response*/
+	slave_stat = FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_0_3, response);
+	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_4_11, response) << 8;
+
+	dev_dbg(ctrl->dev, "%s: slave_stat:0x%llx\n", __func__, slave_stat);
+	for (dev_index = 0; dev_index <= SDW_MAX_DEVICES; ++dev_index) {
+		val = (slave_stat >> (dev_index * 2)) & AMD_SDW_MCP_SLAVE_STATUS_MASK;
+		dev_dbg(ctrl->dev, "%s val:0x%x\n", __func__, val);
+		switch (val) {
+		case SDW_SLAVE_ATTACHED:
+			ctrl->status[dev_index] = SDW_SLAVE_ATTACHED;
+			break;
+		case SDW_SLAVE_UNATTACHED:
+			ctrl->status[dev_index] = SDW_SLAVE_UNATTACHED;
+			break;
+		case SDW_SLAVE_ALERT:
+			ctrl->status[dev_index] = SDW_SLAVE_ALERT;
+			break;
+		default:
+			ctrl->status[dev_index] = SDW_SLAVE_RESERVED;
+			break;
+		}
+	}
+}
+
+static void amd_sdwc_read_and_process_ping_status(struct amd_sdwc_ctrl *ctrl)
+{
+	u64 response = 0;
+
+	mutex_lock(&ctrl->bus.msg_lock);
+	response = amd_sdwc_send_cmd_get_resp(ctrl, 0, 0);
+	mutex_unlock(&ctrl->bus.msg_lock);
+	amd_sdwc_process_ping_status(response, ctrl);
+}
+
 static u32 amd_sdwc_read_ping_status(struct sdw_bus *bus)
 {
 	struct amd_sdwc_ctrl *ctrl = to_amd_sdw(bus);
@@ -1132,6 +1173,119 @@ static int amd_sdwc_register_dais(struct amd_sdwc_ctrl *ctrl)
 					       dais, num_dais);
 }
 
+static void amd_sdwc_update_slave_status_work(struct work_struct *work)
+{
+	struct amd_sdwc_ctrl *ctrl =
+		container_of(work, struct amd_sdwc_ctrl, amd_sdw_work);
+	u32 sw_status_change_mask_0to7_reg;
+	u32 sw_status_change_mask_8to11_reg;
+
+	switch (ctrl->instance) {
+	case ACP_SDW0:
+		sw_status_change_mask_0to7_reg = SW_STATE_CHANGE_STATUS_MASK_0TO7;
+		sw_status_change_mask_8to11_reg = SW_STATE_CHANGE_STATUS_MASK_8TO11;
+		break;
+	case ACP_SDW1:
+		sw_status_change_mask_0to7_reg = P1_SW_STATE_CHANGE_STATUS_MASK_0TO7;
+		sw_status_change_mask_8to11_reg = P1_SW_STATE_CHANGE_STATUS_MASK_8TO11;
+		break;
+	default:
+		dev_err(ctrl->dev, "Invalid Soundwire controller instance\n");
+		return;
+	}
+
+	if (ctrl->status[0] == SDW_SLAVE_ATTACHED) {
+		acp_reg_writel(0, ctrl->mmio + sw_status_change_mask_0to7_reg);
+		acp_reg_writel(0, ctrl->mmio + sw_status_change_mask_8to11_reg);
+	}
+
+update_status:
+	sdw_handle_slave_status(&ctrl->bus, ctrl->status);
+	if (ctrl->status[0] == SDW_SLAVE_ATTACHED) {
+		acp_reg_writel(AMD_SDW_IRQ_MASK_0TO7, ctrl->mmio + sw_status_change_mask_0to7_reg);
+		acp_reg_writel(AMD_SDW_IRQ_MASK_8TO11,
+			       ctrl->mmio + sw_status_change_mask_8to11_reg);
+		amd_sdwc_read_and_process_ping_status(ctrl);
+		goto update_status;
+	}
+}
+
+static void amd_sdwc_update_slave_status(u32 status_change_0to7, u32 status_change_8to11,
+					 struct amd_sdwc_ctrl *ctrl)
+{
+	u64 slave_stat = 0;
+	u32 val = 0;
+	int dev_index;
+
+	if (status_change_0to7 == AMD_SDW_SLAVE_0_ATTACHED)
+		memset(ctrl->status, 0, sizeof(ctrl->status));
+	slave_stat = status_change_0to7;
+	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STATUS_8TO_11, status_change_8to11) << 32;
+	dev_dbg(ctrl->dev, "%s: status_change_0to7:0x%x status_change_8to11:0x%x\n",
+		__func__, status_change_0to7, status_change_8to11);
+	if (slave_stat) {
+		for (dev_index = 0; dev_index <= SDW_MAX_DEVICES; ++dev_index) {
+			if (slave_stat & AMD_SDW_MCP_SLAVE_STATUS_VALID_MASK(dev_index)) {
+				val = (slave_stat >> AMD_SDW_MCP_SLAVE_STAT_SHIFT_MASK(dev_index)) &
+				      AMD_SDW_MCP_SLAVE_STATUS_MASK;
+				switch (val) {
+				case SDW_SLAVE_ATTACHED:
+					ctrl->status[dev_index] = SDW_SLAVE_ATTACHED;
+					break;
+				case SDW_SLAVE_UNATTACHED:
+					ctrl->status[dev_index] = SDW_SLAVE_UNATTACHED;
+					break;
+				case SDW_SLAVE_ALERT:
+					ctrl->status[dev_index] = SDW_SLAVE_ALERT;
+					break;
+				default:
+					ctrl->status[dev_index] = SDW_SLAVE_RESERVED;
+					break;
+				}
+			}
+		}
+	}
+}
+
+static void amd_sdwc_irq_thread(struct work_struct *work)
+{
+	struct amd_sdwc_ctrl *ctrl =
+			container_of(work, struct amd_sdwc_ctrl, amd_sdw_irq_thread);
+	u32 sw_status_change_0to7_reg;
+	u32 sw_status_change_8to11_reg;
+	u32 status_change_8to11;
+	u32 status_change_0to7;
+
+	switch (ctrl->instance) {
+	case ACP_SDW0:
+		sw_status_change_0to7_reg = SW_STATE_CHANGE_STATUS_0TO7;
+		sw_status_change_8to11_reg = SW_STATE_CHANGE_STATUS_8TO11;
+		break;
+	case ACP_SDW1:
+		sw_status_change_0to7_reg = P1_SW_STATE_CHANGE_STATUS_0TO7;
+		sw_status_change_8to11_reg = P1_SW_STATE_CHANGE_STATUS_8TO11;
+		break;
+	default:
+		dev_err(ctrl->dev, "Invalid Soundwire controller instance\n");
+		return;
+	}
+
+	status_change_8to11 = acp_reg_readl(ctrl->mmio + sw_status_change_8to11_reg);
+	status_change_0to7 = acp_reg_readl(ctrl->mmio + sw_status_change_0to7_reg);
+	dev_dbg(ctrl->dev, "%s [SDW%d] SDW INT: 0to7=0x%x, 8to11=0x%x\n",
+		__func__, ctrl->instance, status_change_0to7, status_change_8to11);
+	if (status_change_8to11 & AMD_SDW_PREQ_INTR_STAT) {
+		amd_sdwc_read_and_process_ping_status(ctrl);
+	} else {
+		/* Check for the updated status on Slave device */
+		amd_sdwc_update_slave_status(status_change_0to7, status_change_8to11, ctrl);
+	}
+	if (status_change_8to11 || status_change_0to7)
+		schedule_work(&ctrl->amd_sdw_work);
+	acp_reg_writel(0x00, ctrl->mmio + sw_status_change_8to11_reg);
+	acp_reg_writel(0x00, ctrl->mmio + sw_status_change_0to7_reg);
+}
+
 static void amd_sdwc_probe_work(struct work_struct *work)
 {
 	struct amd_sdwc_ctrl *ctrl  = container_of(work, struct amd_sdwc_ctrl, probe_work);
@@ -1229,6 +1383,8 @@ static int amd_sdwc_probe(struct platform_device *pdev)
 		sdw_bus_master_delete(&ctrl->bus);
 		return ret;
 	}
+	INIT_WORK(&ctrl->amd_sdw_irq_thread, amd_sdwc_irq_thread);
+	INIT_WORK(&ctrl->amd_sdw_work, amd_sdwc_update_slave_status_work);
 	INIT_WORK(&ctrl->probe_work, amd_sdwc_probe_work);
 	schedule_work(&ctrl->probe_work);
 	return 0;
diff --git a/drivers/soundwire/amd_master.h b/drivers/soundwire/amd_master.h
index 42f32ca0c7a8..b43a5d6496cb 100644
--- a/drivers/soundwire/amd_master.h
+++ b/drivers/soundwire/amd_master.h
@@ -236,6 +236,7 @@
 #define AMD_SDW1_PAD_KEEPER_EN_MASK	0x10
 #define AMD_SDW0_PAD_KEEPER_DISABLE_MASK        0x1E
 #define AMD_SDW1_PAD_KEEPER_DISABLE_MASK	0xF
+#define AMD_SDW_PREQ_INTR_STAT  BIT(19)
 
 enum amd_sdw_channel {
 	/* SDW0 */
diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
index 7a99d782969f..2db03b2f0c3b 100644
--- a/include/linux/soundwire/sdw_amd.h
+++ b/include/linux/soundwire/sdw_amd.h
@@ -24,9 +24,12 @@ struct amd_sdwc_ctrl {
 	struct sdw_bus bus;
 	struct device *dev;
 	void __iomem *mmio;
+	struct work_struct amd_sdw_irq_thread;
+	struct work_struct amd_sdw_work;
 	struct work_struct probe_work;
 	struct mutex *sdw_lock;
 	struct sdw_stream_runtime *sruntime[AMD_SDW_MAX_DAIS];
+	enum sdw_slave_status status[SDW_MAX_DEVICES + 1];
 	int num_din_ports;
 	int num_dout_ports;
 	int cols_index;
-- 
2.34.1

