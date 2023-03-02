Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F6A6A7B4E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 07:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjCBGUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 01:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjCBGUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 01:20:37 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB3A3BDA1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 22:19:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXf5Xqj42uj4B9Oi3SME1TY4rBqa7mWn0UfZ0yOscRnZmdpy+DaAbt9ZM08b4sM0k6ToFem8ox4lvQdbwxtYNKAUoBghucyQeQym+nuDA/6upMBw9kdXOsvEBpAsFLlr2GqsSEAAhb0Lb/ahVJCPJlWSCTYnWQ3HLyd3L+qefMH6xcve/FMAibSY9qOd3dJEmcaCqGpXwnQH2j3YWo/6o96bFPU3PbqdyMUl+Be9hxHw1XekkV5XQnCE61KwyPGj/AM4WCjAveHmBbOmb5tuyFdIp5ifYy7XinLBz5S4W9ppwP3aTVEZnrPXwQvzsp1P01aT8hn1HH9aTkMftU6fBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/ud2CpEJkWkFJKRJqKM3aubvYbJ6x4tVpmmBAi3HK0=;
 b=KrKA8Js/a8GreSCFQ7eg6dFdJJd+y6RUCMK4mlIOWqGWUaA7NXRO7LN8hfygHa1N+QAPFMjVrT1aJkaIT3wdgnpp1NBmZqjfLgLYRye1J+agRT6EisZFd1l0obhZc6oApbcG1FHdQ/r5gODbgd/jd8qfzR0NKIOvvNgrL6dvOavRAVh76hiyOdntBGGTxlaAkUim8FqA8Z6+UxgxIjbbcoifqXBCqeUamHui1NN93ioIcFhAbnwPRRFCA0sxkzcDalaqf9aCICrogv3FL79HdbYo8BzwLYnd6+wZdSHiAWc8VDiCbTiyXol1NAhR/uj8E2rs1vXEqNSeVOHoBfR4HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/ud2CpEJkWkFJKRJqKM3aubvYbJ6x4tVpmmBAi3HK0=;
 b=AfVgpSBNf9guT82Mt7i2sKuieUkLFsR3JyMJQNxoT8SGWdCpEMm3a2N2Ky/QLJgOkthgP4oWgH/hynH4kERlkiiI9uBdrt+N7R0r2fgBIA4HyegYYXC0is9dULjJVtsRod4iowyAeLsQqIDj6FNECOB3UQBsu7HkSsHyqyDJBv4=
Received: from DM6PR14CA0037.namprd14.prod.outlook.com (2603:10b6:5:18f::14)
 by CY8PR12MB8410.namprd12.prod.outlook.com (2603:10b6:930:6d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 06:19:38 +0000
Received: from DS1PEPF0000E650.namprd02.prod.outlook.com
 (2603:10b6:5:18f:cafe::a1) by DM6PR14CA0037.outlook.office365.com
 (2603:10b6:5:18f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 06:19:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000E650.mail.protection.outlook.com (10.167.18.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Thu, 2 Mar 2023 06:19:38 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 00:19:31 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 22:18:52 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Thu, 2 Mar 2023 00:18:48 -0600
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
Subject: [PATCH V5 5/8] soundwire: amd: add SoundWire manager interrupt handling
Date:   Thu, 2 Mar 2023 11:51:04 +0530
Message-ID: <20230302062107.207845-6-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230302062107.207845-1-Vijendar.Mukunda@amd.com>
References: <20230302062107.207845-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E650:EE_|CY8PR12MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: f92bd83d-4560-47ef-33ec-08db1ae61a28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: soDyF9fYbX1RPXujt08TGMBYURXslbcyKh3HwT0YjInV8E6m7Y3y38DXKh0lLWIjcAUQDMAa2P2eAU+2b269M1SZil06puL6WILzksNRJHi09dC09jcgHR4FmLBku1UAyNc0HYOorCsJkk5iM/506b5/HqM+XNxAbj3jqDNL86e4YAsQ32QofGzwSYgcAb9Y65TYGSa/yrfEGbHvbsiSgng4k4pueQXWYVxVvtfnz9DaB2cFI4eBr6EZcayYdZgwZkzWJbZgh2NlefQ5kKbvsVx+dWS2VFugPRhS5kMoSdqm2cB+AqyVjz/z/oXfTCYxQGz8ZR/HR0yt5EQmJFSousfANPuxZ0M8Ck+ou95nG8nRZImRG8+a7DbqdI/RHwQQjLkx6el5bVaKRUyivb6Ij1iXmf/Uhc+vChNavIUK3pVa6TCo3lIaeO0mIQPBXIg1MQsEVyshKZmGNZro5FJeh1ENjmG0hD4Gh0QhuvoZnvnuYv29OWBb0jU3/sqE9TvuXDn07+TKlH7ntydfWwBJB+fBatEI6WS80n24B9bvY1q1f/G6SP/CPiVmybg8XYUObBKzqyuwUEbz58G/0GLenPVOGWrnZCKzJLdfaFgdDHsA2s769/2eD/jAnftXO44ANRoEBzJJNYyilNer2WseaTkySZYC63Qhtc85xOBQ1oAwJYQyxb0LINXlMm8TQ1LbwkVxUQo+bAHME3qzYJEUnSLcC+2zOb0ODtI/YqylKrc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199018)(36840700001)(46966006)(40470700004)(86362001)(82310400005)(36756003)(40460700003)(40480700001)(70586007)(70206006)(186003)(4326008)(8676002)(336012)(6916009)(8936002)(41300700001)(2616005)(54906003)(966005)(478600001)(7696005)(6666004)(1076003)(26005)(5660300002)(316002)(81166007)(82740400003)(356005)(83380400001)(47076005)(426003)(36860700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 06:19:38.5918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f92bd83d-4560-47ef-33ec-08db1ae61a28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E650.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8410
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for handling SoundWire manager interrupts.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/lkml/20230227154801.50319-6-Vijendar.Mukunda@amd.com
---
 drivers/soundwire/amd_manager.c   | 130 ++++++++++++++++++++++++++++++
 drivers/soundwire/amd_manager.h   |   1 +
 include/linux/soundwire/sdw_amd.h |   7 ++
 3 files changed, 138 insertions(+)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 4b7b29a71f61..6e3533a3fae1 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -415,6 +415,51 @@ static enum sdw_command_response amd_sdw_xfer_msg(struct sdw_bus *bus, struct sd
 	return SDW_CMD_OK;
 }
 
+static void amd_sdw_fill_slave_status(struct amd_sdw_manager *amd_manager, u16 index, u32 status)
+{
+	switch (status) {
+	case SDW_SLAVE_ATTACHED:
+		amd_manager->status[index] = SDW_SLAVE_ATTACHED;
+		break;
+	case SDW_SLAVE_UNATTACHED:
+		amd_manager->status[index] = SDW_SLAVE_UNATTACHED;
+		break;
+	case SDW_SLAVE_ALERT:
+		amd_manager->status[index] = SDW_SLAVE_ALERT;
+		break;
+	default:
+		amd_manager->status[index] = SDW_SLAVE_RESERVED;
+		break;
+	}
+}
+
+static void amd_sdw_process_ping_status(u64 response, struct amd_sdw_manager *amd_manager)
+{
+	u64 slave_stat;
+	u32 val;
+	u16 dev_index;
+
+	/* slave status response */
+	slave_stat = FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_0_3, response);
+	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_4_11, response) << 8;
+	dev_dbg(amd_manager->dev, "slave_stat:0x%llx\n", slave_stat);
+	for (dev_index = 0; dev_index <= SDW_MAX_DEVICES; ++dev_index) {
+		val = (slave_stat >> (dev_index * 2)) & AMD_SDW_MCP_SLAVE_STATUS_MASK;
+		dev_dbg(amd_manager->dev, "val:0x%x\n", val);
+		amd_sdw_fill_slave_status(amd_manager, dev_index, val);
+	}
+}
+
+static void amd_sdw_read_and_process_ping_status(struct amd_sdw_manager *amd_manager)
+{
+	u64 response;
+
+	mutex_lock(&amd_manager->bus.msg_lock);
+	response = amd_sdw_send_cmd_get_resp(amd_manager, 0, 0);
+	mutex_unlock(&amd_manager->bus.msg_lock);
+	amd_sdw_process_ping_status(response, amd_manager);
+}
+
 static u32 amd_sdw_read_ping_status(struct sdw_bus *bus)
 {
 	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
@@ -815,6 +860,89 @@ static int amd_sdw_register_dais(struct amd_sdw_manager *amd_manager)
 					       dais, num_dais);
 }
 
+static void amd_sdw_update_slave_status_work(struct work_struct *work)
+{
+	struct amd_sdw_manager *amd_manager =
+		container_of(work, struct amd_sdw_manager, amd_sdw_work);
+	int retry_count = 0;
+
+	if (amd_manager->status[0] == SDW_SLAVE_ATTACHED) {
+		acp_reg_writel(0, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
+		acp_reg_writel(0, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
+	}
+
+update_status:
+	sdw_handle_slave_status(&amd_manager->bus, amd_manager->status);
+	/*
+	 * During the peripheral enumeration sequence, the SoundWire manager interrupts
+	 * are masked. Once the device number programming is done for all peripherals,
+	 * interrupts will be unmasked. Read the peripheral device status from ping command
+	 * and process the response. This sequence will ensure all peripheral devices enumerated
+	 * and initialized properly.
+	 */
+	if (amd_manager->status[0] == SDW_SLAVE_ATTACHED) {
+		if (retry_count++ < SDW_MAX_DEVICES) {
+			acp_reg_writel(AMD_SDW_IRQ_MASK_0TO7, amd_manager->mmio +
+				       ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
+			acp_reg_writel(AMD_SDW_IRQ_MASK_8TO11,
+				       amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
+			amd_sdw_read_and_process_ping_status(amd_manager);
+			goto update_status;
+		} else {
+			dev_err_ratelimited(amd_manager->dev,
+					    "Device0 detected after %d iterations\n",
+					    retry_count);
+		}
+	}
+}
+
+static void amd_sdw_update_slave_status(u32 status_change_0to7, u32 status_change_8to11,
+					struct amd_sdw_manager *amd_manager)
+{
+	u64 slave_stat;
+	u32 val;
+	int dev_index;
+
+	if (status_change_0to7 == AMD_SDW_SLAVE_0_ATTACHED)
+		memset(amd_manager->status, 0, sizeof(amd_manager->status));
+	slave_stat = status_change_0to7;
+	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STATUS_8TO_11, status_change_8to11) << 32;
+	dev_dbg(amd_manager->dev, "status_change_0to7:0x%x status_change_8to11:0x%x\n",
+		status_change_0to7, status_change_8to11);
+	if (slave_stat) {
+		for (dev_index = 0; dev_index <= SDW_MAX_DEVICES; ++dev_index) {
+			if (slave_stat & AMD_SDW_MCP_SLAVE_STATUS_VALID_MASK(dev_index)) {
+				val = (slave_stat >> AMD_SDW_MCP_SLAVE_STAT_SHIFT_MASK(dev_index)) &
+				      AMD_SDW_MCP_SLAVE_STATUS_MASK;
+				amd_sdw_fill_slave_status(amd_manager, dev_index, val);
+			}
+		}
+	}
+}
+
+static void amd_sdw_irq_thread(struct work_struct *work)
+{
+	struct amd_sdw_manager *amd_manager =
+			container_of(work, struct amd_sdw_manager, amd_sdw_irq_thread);
+	u32 status_change_8to11;
+	u32 status_change_0to7;
+
+	status_change_8to11 = acp_reg_readl(amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_8TO11);
+	status_change_0to7 = acp_reg_readl(amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
+	dev_dbg(amd_manager->dev, "[SDW%d] SDW INT: 0to7=0x%x, 8to11=0x%x\n",
+		amd_manager->instance, status_change_0to7, status_change_8to11);
+	if (status_change_8to11 & AMD_SDW_PREQ_INTR_STAT) {
+		amd_sdw_read_and_process_ping_status(amd_manager);
+	} else {
+		/* Check for the updated status on peripheral device */
+		amd_sdw_update_slave_status(status_change_0to7, status_change_8to11, amd_manager);
+	}
+	if (status_change_8to11 || status_change_0to7)
+		schedule_work(&amd_manager->amd_sdw_work);
+	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_8TO11);
+	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
+}
+
 static void amd_sdw_probe_work(struct work_struct *work)
 {
 	struct amd_sdw_manager *amd_manager = container_of(work, struct amd_sdw_manager,
@@ -905,6 +1033,8 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
 		return ret;
 	}
 	dev_set_drvdata(dev, amd_manager);
+	INIT_WORK(&amd_manager->amd_sdw_irq_thread, amd_sdw_irq_thread);
+	INIT_WORK(&amd_manager->amd_sdw_work, amd_sdw_update_slave_status_work);
 	INIT_WORK(&amd_manager->probe_work, amd_sdw_probe_work);
 	/*
 	 * Instead of having lengthy probe sequence, use deferred probe.
diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
index 78d7d5c911e4..3920648fdc52 100644
--- a/drivers/soundwire/amd_manager.h
+++ b/drivers/soundwire/amd_manager.h
@@ -186,6 +186,7 @@
 #define AMD_SDW1_PAD_KEEPER_EN_MASK			0x10
 #define AMD_SDW0_PAD_KEEPER_DISABLE_MASK		0x1E
 #define AMD_SDW1_PAD_KEEPER_DISABLE_MASK		0xF
+#define AMD_SDW_PREQ_INTR_STAT				BIT(19)
 
 enum amd_sdw_cmd_type {
 	AMD_SDW_CMD_PING = 0,
diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
index ac537419301d..df60bc0de6fc 100644
--- a/include/linux/soundwire/sdw_amd.h
+++ b/include/linux/soundwire/sdw_amd.h
@@ -45,8 +45,11 @@ struct sdw_amd_dai_runtime {
  * @mmio: SoundWire registers mmio base
  * @acp_mmio: acp registers mmio base
  * @reg_mask: register mask structure per manager instance
+ * @amd_sdw_irq_thread: SoundWire manager irq workqueue
+ * @amd_sdw_work: peripheral status work queue
  * @probe_work: SoundWire manager probe workqueue
  * @acp_sdw_lock: mutex to protect acp share register access
+ * @status: peripheral devices status array
  * @num_din_ports: number of input ports
  * @num_dout_ports: number of output ports
  * @cols_index: Column index in frame shape
@@ -65,10 +68,14 @@ struct amd_sdw_manager {
 	void __iomem *acp_mmio;
 
 	struct sdw_manager_reg_mask *reg_mask;
+	struct work_struct amd_sdw_irq_thread;
+	struct work_struct amd_sdw_work;
 	struct work_struct probe_work;
 	/* mutex to protect acp common register access */
 	struct mutex *acp_sdw_lock;
 
+	enum sdw_slave_status status[SDW_MAX_DEVICES + 1];
+
 	int num_din_ports;
 	int num_dout_ports;
 
-- 
2.34.1

