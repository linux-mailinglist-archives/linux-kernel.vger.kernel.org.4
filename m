Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C536C2996
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjCUFG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjCUFGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:06:41 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B64B76A5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 22:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bmkcg513LcT8z6OwYZOSSb34V0s+DxazqXAlRmDFVHeGIPhrI+nFKB6oFjG+SyS+87ykVTe25k92H5Pxopjc0c7kg+9ZqA8daLo1jUzfmrhXPRKCuft3Xok+mKYIjbss9DBqOUI4NbhOdczueIl+D6ONeqpiMg7q1gF7qky9m38lIfDrYirqpzOuDgP6t+sv7NzlC4lyix2euUrsF11u25uiJAnanRjT4crkBhFaBgXnFmfqxqdTvKJJKrqN99B6cDuNh9IDF99xD7RINKwwRBCyi6KglCkGyObqhB4zk4HLEVaPRqWhB7aTLM9fsqc77pifGNiEvWOzXUtuaVqSlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dxgqav6RsLOzhn1anXycTvwnKGG9i3FZy91IMfltUl4=;
 b=Osp3BaSt0Pi0Yx7un3NRh0WJNAsuTnmkIXFFPbYN8M8oRCXe7tWr9jW/m9zSmytsml6QStLnHzcIxvyGUR0y+ZBlo203dPfhdyFAy39J4hrBe9fK8R/Rzt/ELG7va5ZFAs7Y2MdrlV+QSjfW5XZg7ywpTsywWR/MwzrbwUUT2QIIbkPBZxZCT2QiBrMql+7EbbPZAyY3pRQ3/bbztNjQTNyi1BhQNb8VfmyTiZTzQXFG0HhxD2slv1FRmpdT/GwZ0v9RstQJ2BRqbqMbw/bYuwj6YZcppm4bCTgd5BUdJFlnWG0vQmnXR4UFkVWc45wB04ByN+UtQNdOTzet2GHc4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dxgqav6RsLOzhn1anXycTvwnKGG9i3FZy91IMfltUl4=;
 b=zd9/W1sVfM13Zjvvuekv20uWPUaqbBfBc9HNuR3Trqhl4CzuGFii2wlJfEMDuaL8OwgbW9vjS9RB1KgwFcg2GS9p6JMIzQf6f1/Zwo/RdEERxhI7pd/pSqc/tnDMsxBg5lowcWj4jFQkvQgean8VcW30DDUnqYWxv0S/vYBVCcI=
Received: from MN2PR15CA0007.namprd15.prod.outlook.com (2603:10b6:208:1b4::20)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 05:05:48 +0000
Received: from BL02EPF00010207.namprd05.prod.outlook.com
 (2603:10b6:208:1b4:cafe::d3) by MN2PR15CA0007.outlook.office365.com
 (2603:10b6:208:1b4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 05:05:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00010207.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 21 Mar 2023 05:05:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 00:05:47 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 21 Mar 2023 00:05:43 -0500
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
Subject: [PATCH V8 5/8] soundwire: amd: add SoundWire manager interrupt handling
Date:   Tue, 21 Mar 2023 10:38:58 +0530
Message-ID: <20230321050901.115439-6-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321050901.115439-1-Vijendar.Mukunda@amd.com>
References: <20230321050901.115439-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010207:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef421c8-c7da-4ab3-b89a-08db29c9ef12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: quGk0OaYpt5+XLEoMUh63/JNyhsoJDZQs6ff6CD1ucHgaa4DHxBeudKt37HJEwIj6THsLA1C3k5rZ7jY2iuTH5i+7ic5yKWUNoGxTPloNoAAUCycLwcg3SdK232AXfR26+P91iM4BChmFfJ/W2LBS9YLhmgSsmJ6CawtNG4fMQI7QGYIw7Vje3UvUPaNUqho2rk+RH9wRGtNaFty6xyAuYqJ8Ut0I2uBb3zumx1ND8sUHYZEQlhoee0j2k+dkB5JAvAKjyCmxivc6rZMTnD3lGxRlLfcdKhehyw9jzrlyuAKaPaGhCBWGMFOMOnNcSQZ7iCjHXLNI1pvfc/mYAAw+efi2XLFkmMO++bJlB4/fJpxOEhgioJAixZxWBienMYJy4CPuxxVlCQs81R2xtUatZgTZVym9qoBozUUVsBqyex9mb/LSzZQ6vc2hxSOZX9+pRvbrGwKjXcGrG2AmXB0C/a4Z5fLAB29l70tQwJDWe6//gKbKepFW5iYJEKWolLahYCKGQ1CSoLsuuKUVUlpK3qlgT/PZ7NYHADnDvDD6ezpTNiz2NP99CBSEKUbORzOyDyuRv8ZWjV8isgZU0yGLw8t5kBJcP4PwBAgXi1e+aSkR+pFNLemkOOeJJtYBjZGSdNvUo2vxbOiUDH0djiUWhaRsYYQeZIfN8KtJQ0umLwcxxdd1vbYQPE+gws1BN0slZAvmKmjQd6IKnR2c8iHbz8dvqTy29kqO7/nRcjbAdc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199018)(40470700004)(46966006)(36840700001)(26005)(478600001)(2906002)(40480700001)(54906003)(83380400001)(316002)(336012)(47076005)(426003)(2616005)(356005)(82740400003)(36860700001)(86362001)(82310400005)(966005)(7696005)(40460700003)(81166007)(36756003)(6666004)(6916009)(186003)(4326008)(70586007)(70206006)(8676002)(5660300002)(41300700001)(8936002)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 05:05:47.8735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef421c8-c7da-4ab3-b89a-08db29c9ef12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/soundwire/amd_manager.c   | 126 ++++++++++++++++++++++++++++++
 drivers/soundwire/amd_manager.h   |   1 +
 include/linux/soundwire/sdw_amd.h |   7 ++
 3 files changed, 134 insertions(+)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index f12dad6c3226..49b7133cb41f 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -327,6 +327,47 @@ static enum sdw_command_response amd_sdw_xfer_msg(struct sdw_bus *bus, struct sd
 	return SDW_CMD_OK;
 }
 
+static void amd_sdw_fill_slave_status(struct amd_sdw_manager *amd_manager, u16 index, u32 status)
+{
+	switch (status) {
+	case SDW_SLAVE_ATTACHED:
+	case SDW_SLAVE_UNATTACHED:
+	case SDW_SLAVE_ALERT:
+		amd_manager->status[index] = status;
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
@@ -723,6 +764,89 @@ static int amd_sdw_register_dais(struct amd_sdw_manager *amd_manager)
 					       dais, num_dais);
 }
 
+static void amd_sdw_update_slave_status_work(struct work_struct *work)
+{
+	struct amd_sdw_manager *amd_manager =
+		container_of(work, struct amd_sdw_manager, amd_sdw_work);
+	int retry_count = 0;
+
+	if (amd_manager->status[0] == SDW_SLAVE_ATTACHED) {
+		writel(0, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
+		writel(0, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
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
+			writel(AMD_SDW_IRQ_MASK_0TO7, amd_manager->mmio +
+			       ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
+			writel(AMD_SDW_IRQ_MASK_8TO11, amd_manager->mmio +
+			       ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
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
+	status_change_8to11 = readl(amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_8TO11);
+	status_change_0to7 = readl(amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
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
+	writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_8TO11);
+	writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
+}
+
 static void amd_sdw_probe_work(struct work_struct *work)
 {
 	struct amd_sdw_manager *amd_manager = container_of(work, struct amd_sdw_manager,
@@ -815,6 +939,8 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
 		return ret;
 	}
 	dev_set_drvdata(dev, amd_manager);
+	INIT_WORK(&amd_manager->amd_sdw_irq_thread, amd_sdw_irq_thread);
+	INIT_WORK(&amd_manager->amd_sdw_work, amd_sdw_update_slave_status_work);
 	INIT_WORK(&amd_manager->probe_work, amd_sdw_probe_work);
 	/*
 	 * Instead of having lengthy probe sequence, use deferred probe.
diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
index c92e0dee2cb1..fca7d792bf5f 100644
--- a/drivers/soundwire/amd_manager.h
+++ b/drivers/soundwire/amd_manager.h
@@ -185,6 +185,7 @@
 #define AMD_SDW1_PAD_KEEPER_EN_MASK			0x10
 #define AMD_SDW0_PAD_KEEPER_DISABLE_MASK		0x1e
 #define AMD_SDW1_PAD_KEEPER_DISABLE_MASK		0xf
+#define AMD_SDW_PREQ_INTR_STAT				BIT(19)
 
 static u32 amd_sdw_freq_tbl[AMD_SDW_MAX_FREQ_NUM] = {
 	AMD_SDW_DEFAULT_CLK_FREQ,
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

