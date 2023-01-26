Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEE767D7C2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjAZVcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjAZVcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:32:31 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B58074A7E;
        Thu, 26 Jan 2023 13:32:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQxoyaS4rgwvAjxdAESGqF9xUE2gt0t2Kr65qBpIUfnrT0RxKQNUGdhyO+7oJn/ruKRttIcx/oROb+rLSHIEfrOxMWaKGDcGgPLgQQc9zulGS9schkLyOi++UdJBqoEnj3JerO0wh2ebimmRRHV5+ZRoSvmF3VbFva7+UefLH6nOYHk2eoen/jpVW+58pBBIfjVvS+zQ0fJ0rw9J/C2TWKSlHXE/4k1sC2S1Ms4APdWVb/f6woyHxO2lyH3+1sgfIakGWBFDJTPkjWMMFBRjqxNv6B6+mKBzjEDyy7xhBjEUYSar9Yi5FvEWotBMueonADNePbWRt7Ehodra6OzZKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oudATgHc57WBKkjzWM/ofQ2OyG4ZhnT/qdZtLokYjM=;
 b=Kvp9JDMthnHNCN8jAJ9rhFn3rN2o+sZHp5hX2fyXaGN1ErQPDqHyZFrXXCO9xvewnQ7U3eFHNYnF/0xwS/hvl0NVcceNH0G6nDM5WYwoPQNXzauMfoEz8+8iz2gqEcsT8o3znYj4QSIDh/T8JLx8pXo4q9y8SZJcLMfFC2Lid0U7EWFagTI21hYIxrFyHzeB/ta7fS7p3/ZxuGyzfp3tJIWgnENRbTFosxpTU4LMsFfxJn/bJjbXG97MiEtQ2AGzVAsFCPxAVkfHqtX9EAtJROEUJXSfM9OJfQFeBrhrFlUqYD6sOHhOsXvzyUNwwalfc+QkOn7HmWxY5LEuWRJJ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oudATgHc57WBKkjzWM/ofQ2OyG4ZhnT/qdZtLokYjM=;
 b=rhuyXOwg2cW9qdGoJo+TUsgfGcvcn4NFiS1I2GgkBLLb76nbISvG5b1MCvU0X3e8Sqcsq1oFPnnVPjJb9hyJ/DvPAg/4vIsQBZTL/w4jXQVubSPFfZVil7xRi424z2vrEQnD28ghoT+X5CMC62QcrcQNff4sqB7Bd5SP8puM5iI=
Received: from DM6PR17CA0018.namprd17.prod.outlook.com (2603:10b6:5:1b3::31)
 by SN7PR12MB7275.namprd12.prod.outlook.com (2603:10b6:806:2ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 21:32:07 +0000
Received: from DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::cb) by DM6PR17CA0018.outlook.office365.com
 (2603:10b6:5:1b3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22 via Frontend
 Transport; Thu, 26 Jan 2023 21:32:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT094.mail.protection.outlook.com (10.13.172.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Thu, 26 Jan 2023 21:32:07 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 26 Jan
 2023 15:32:07 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 26 Jan
 2023 13:32:06 -0800
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 26 Jan 2023 15:32:06 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <mathieu.poirier@linaro.org>, <andersson@kernel.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v2] remoteproc: xilinx: add mailbox channels for rpmsg
Date:   Thu, 26 Jan 2023 13:31:54 -0800
Message-ID: <20230126213154.1707300-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT094:EE_|SN7PR12MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: eca81429-6391-4954-2104-08daffe4c6bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7U+zMUq9eDoFqnzGZbBR4jWR9Q4prmQLPE7rbIzUPDV6kCH8SEbp6tozSW1qi15AwokMef0fvF+3HJ2FMmX4iz2hTfuGUvrtSFxiWKJQe9BsBEiKglsqsIDNRGosOa5+8JZYUiU1ZjbJ4u0D5GaoPGWlApI2JSq8ROqufOyZwi++uXgDUpTYH/Ct2LgalVH/L/4qqnIG5lHqqnw7x2xdSEYNgwFf5EvfPFOPWObdH/tmpATzPCUaQ60HUETJ7cNTVBQX6sCIf2ZMJJ1pA6bkQA7jV1Puwv74X71Srom9gKE9XnpWY0WXzJMHMiqhKSoRnk6sO15c0j0swVhGp8V7uO41gTqBeH+SftOIPSZrbcG6Zvxej6vsV2tJyNn8mmqt1Ll9VKAD32b1nbCsm/pc8EAXGegKZNEhKdS2xXWRD3EXqBi5Xm7sxiFItKp+IuJ9HTKgZlWY0iYNo2lt8U+H9NM08ZkrxATW6Rl9q7YhZdr7d/R1IS4VgTNAinFWKKUCbVZ28I2yXjjzXccCvO/qJ4mxGznDM6REXYjImTyMb8Dkw4QymIu/t0brGSjTkBfNyBsUWSLDQl+u3zv7EndCWwmbti2IYrJXcW7oPuUyl1NzPVF+XLaizvgHhMd7nZRG0q9rXvhP2KNl+i6ZQQBJt4XcVd8K8JgublVsTFNk2U0JOPlYIO77Zps2MKlVP8zqsHmKh1CjDdSZdLF3X0K2xYI85GVLH4H73B/OK9ISRhB7R36PnGmz0srbTlX5L6HolU5f3Mv4f9GfM96Plb8G2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(186003)(54906003)(426003)(36756003)(316002)(86362001)(70206006)(6666004)(40480700001)(26005)(8676002)(36860700001)(83380400001)(110136005)(70586007)(4326008)(1076003)(478600001)(81166007)(356005)(336012)(5660300002)(44832011)(82740400003)(30864003)(40460700003)(8936002)(15650500001)(2906002)(2616005)(82310400005)(47076005)(41300700001)(17423001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 21:32:07.7318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eca81429-6391-4954-2104-08daffe4c6bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7275
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes each r5 core mailbox client and uses
tx and rx channels to send and receive data to/from
remote processor respectively. This is needed for rpmsg
communication to remote processor.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

Changes in v2:
  - fix vrings carveout names as expeceted by remoteproc framework

 drivers/remoteproc/xlnx_r5_remoteproc.c | 352 ++++++++++++++++++++----
 1 file changed, 292 insertions(+), 60 deletions(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index 2db57d394155..45ce7f2089bf 100644
--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -8,16 +8,23 @@
 #include <linux/dma-mapping.h>
 #include <linux/firmware/xlnx-zynqmp.h>
 #include <linux/kernel.h>
+#include <linux/mailbox_client.h>
+#include <linux/mailbox/zynqmp-ipi-message.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/remoteproc.h>
-#include <linux/slab.h>
 
 #include "remoteproc_internal.h"
 
+/* IPI buffer MAX length */
+#define IPI_BUF_LEN_MAX	32U
+
+/* RX mailbox client buffer max length */
+#define MBOX_CLIENT_BUF_MAX	(IPI_BUF_LEN_MAX + \
+				 sizeof(struct zynqmp_ipi_message))
 /*
  * settings for RPU cluster mode which
  * reflects possible values of xlnx,cluster-mode dt-property
@@ -65,6 +72,12 @@ static const struct mem_bank_data zynqmp_tcm_banks[] = {
  * @rmem: reserved memory region nodes from device tree
  * @rproc: rproc handle
  * @pm_domain_id: RPU CPU power domain id
+ * @rx_mc_buf: to copy data from mailbox rx channel
+ * @tx_mc_buf: to copy data to mailbox tx channel
+ * @mbox_work: schedule work after receiving data from mailbox
+ * @mbox_cl: mailbox client
+ * @tx_chan: mailbox tx channel
+ * @rx_chan: mailbox rx channel
  */
 struct zynqmp_r5_core {
 	struct device *dev;
@@ -75,6 +88,14 @@ struct zynqmp_r5_core {
 	struct reserved_mem **rmem;
 	struct rproc *rproc;
 	u32 pm_domain_id;
+
+	/* mailbox related data structures */
+	unsigned char rx_mc_buf[MBOX_CLIENT_BUF_MAX];
+	unsigned char tx_mc_buf[MBOX_CLIENT_BUF_MAX];
+	struct work_struct mbox_work;
+	struct mbox_client mbox_cl;
+	struct mbox_chan *tx_chan;
+	struct mbox_chan *rx_chan;
 };
 
 /**
@@ -92,6 +113,181 @@ struct zynqmp_r5_cluster {
 	struct zynqmp_r5_core **r5_cores;
 };
 
+/**
+ * event_notified_idr_cb() - callback for vq_interrupt per notifyid
+ * @id: rproc->notify id
+ * @ptr: pointer to idr private data
+ * @data: data passed to idr_for_each callback
+ *
+ * Pass notification to remoteproc virtio
+ *
+ * Return: 0. having return is to satisfy the idr_for_each() function
+ *          pointer input argument requirement.
+ **/
+static int event_notified_idr_cb(int id, void *ptr, void *data)
+{
+	struct rproc *rproc = data;
+
+	if (rproc_vq_interrupt(rproc, id) == IRQ_NONE)
+		dev_dbg(&rproc->dev, "data not found for vqid=%d\n", id);
+
+	return 0;
+}
+
+/**
+ * handle_event_notified() - remoteproc notification work function
+ * @work: pointer to the work structure
+ *
+ * It checks each registered remoteproc notify IDs.
+ */
+static void handle_event_notified(struct work_struct *work)
+{
+	struct zynqmp_r5_core *r5_core;
+	struct rproc *rproc;
+
+	r5_core = container_of(work, struct zynqmp_r5_core, mbox_work);
+	rproc = r5_core->rproc;
+
+	/*
+	 * We only use IPI for interrupt. The RPU firmware side may or may
+	 * not write the notifyid when it trigger IPI.
+	 * And thus, we scan through all the registered notifyids and
+	 * find which one is valid to get the message.
+	 * Even if message from firmware is NULL, we attempt to get vqid
+	 */
+	idr_for_each(&rproc->notifyids, event_notified_idr_cb, rproc);
+}
+
+/**
+ * zynqmp_r5_mb_rx_cb() - receive channel mailbox callback
+ * @cl: mailbox client
+ * @msg: message pointer
+ *
+ * Receive data from ipi buffer, ack interrupt and then
+ * it will schedule the R5 notification work.
+ */
+static void zynqmp_r5_mb_rx_cb(struct mbox_client *cl, void *msg)
+{
+	struct zynqmp_ipi_message *ipi_msg, *buf_msg;
+	struct zynqmp_r5_core *r5_core;
+	size_t len;
+
+	r5_core = container_of(cl, struct zynqmp_r5_core, mbox_cl);
+
+	/* copy data from ipi buffer to r5_core */
+	ipi_msg = (struct zynqmp_ipi_message *)msg;
+	buf_msg = (struct zynqmp_ipi_message *)r5_core->rx_mc_buf;
+	len = ipi_msg->len;
+	if (len > IPI_BUF_LEN_MAX) {
+		dev_warn(r5_core->dev, "msg size exceeded than %d\n",
+			 IPI_BUF_LEN_MAX);
+		len = IPI_BUF_LEN_MAX;
+	}
+	buf_msg->len = len;
+	memcpy(buf_msg->data, ipi_msg->data, len);
+
+	/* received and processed interrupt ack */
+	if (mbox_send_message(r5_core->rx_chan, NULL) < 0)
+		dev_err(r5_core->dev, "ack failed to mbox rx_chan\n");
+
+	schedule_work(&r5_core->mbox_work);
+}
+
+/**
+ * zynqmp_r5_setup_mbox() - Setup mailboxes related properties
+ *			    this is used for each individual R5 core
+ *
+ * @r5_core: pointer to the ZynqMP r5 core data
+ *
+ * Function to setup mailboxes related properties
+ *
+ */
+static void zynqmp_r5_setup_mbox(struct zynqmp_r5_core *r5_core)
+{
+	struct zynqmp_r5_cluster *cluster;
+	struct mbox_client *mbox_cl;
+
+	cluster = dev_get_drvdata(r5_core->dev->parent);
+
+	/**
+	 * ToDo: Use only one IPI channel for APU to communicate with both RPUs
+	 * in split mode. As of now, two IPI channels are expeceted for APU
+	 * to communicate with RPU. for example, APU(IPI0)<-> RPU0(IPI1) and
+	 * APU(IPI7)<->RPU1(IPI2). However, this is not the optimized use
+	 * of the hardware. As per hardware reference manual, each IPI channel
+	 * can receive interrupt from another IPI channel. So APU must be able
+	 * to communicate with both RPUs simultaneously using same IPI channel.
+	 * For example, this is valid case: APU(IPI0)<->RPU0(IPI1) and
+	 * APU(IPI0)<->RPU1(IPI2). However, with current available examples
+	 * and RPU firmware, this configuration in device-tree is causing system-crash.
+	 * And so, using extra IPI channel is required in device-tree. In split
+	 * mode explicitly inform user about this limitation and requirement.
+	 */
+	if (cluster->mode == SPLIT_MODE)
+		dev_warn(r5_core->dev, "split mode: APU should use two IPI channels\n");
+
+	mbox_cl = &r5_core->mbox_cl;
+	mbox_cl->rx_callback = zynqmp_r5_mb_rx_cb;
+	mbox_cl->tx_block = false;
+	mbox_cl->knows_txdone = false;
+	mbox_cl->tx_done = NULL;
+	mbox_cl->dev = r5_core->dev;
+
+	/* Request TX and RX channels */
+	r5_core->tx_chan = mbox_request_channel_byname(mbox_cl, "tx");
+	if (IS_ERR(r5_core->tx_chan)) {
+		r5_core->tx_chan = NULL;
+		return;
+	}
+
+	r5_core->rx_chan = mbox_request_channel_byname(mbox_cl, "rx");
+	if (IS_ERR(r5_core->rx_chan)) {
+		mbox_free_channel(r5_core->tx_chan);
+		r5_core->rx_chan = NULL;
+		r5_core->tx_chan = NULL;
+		return;
+	}
+
+	INIT_WORK(&r5_core->mbox_work, handle_event_notified);
+}
+
+static void zynqmp_r5_free_mbox(struct zynqmp_r5_core *r5_core)
+{
+	if (r5_core->tx_chan) {
+		mbox_free_channel(r5_core->tx_chan);
+		r5_core->tx_chan = NULL;
+	}
+
+	if (r5_core->rx_chan) {
+		mbox_free_channel(r5_core->rx_chan);
+		r5_core->rx_chan = NULL;
+	}
+}
+
+/*
+ * zynqmp_r5_core_kick() - kick a firmware if mbox is provided
+ * @rproc: r5 core's corresponding rproc structure
+ * @vqid: virtqueue ID
+ */
+static void zynqmp_r5_rproc_kick(struct rproc *rproc, int vqid)
+{
+	struct zynqmp_r5_core *r5_core = rproc->priv;
+	struct device *dev = r5_core->dev;
+	struct zynqmp_ipi_message *mb_msg;
+	int ret;
+
+	/* don't handle kick if mbox setup failed for this core */
+	if (!r5_core->tx_chan && !r5_core->rx_chan)
+		return;
+
+	mb_msg = (struct zynqmp_ipi_message *)r5_core->tx_mc_buf;
+	memcpy(mb_msg->data, &vqid, sizeof(vqid));
+	mb_msg->len = sizeof(vqid);
+	ret = mbox_send_message(r5_core->tx_chan, mb_msg);
+	if (ret < 0)
+		dev_warn(dev, "failed to send message\n");
+}
+
 /*
  * zynqmp_r5_set_mode()
  *
@@ -227,6 +423,63 @@ static int zynqmp_r5_mem_region_unmap(struct rproc *rproc,
 	return 0;
 }
 
+/**
+ * zynqmp_r5_get_mem_region_node()
+ * parse memory-region property and get reserved mem regions
+ *
+ * @r5_core: pointer to zynqmp_r5_core type object
+ *
+ * Return: 0 for success and error code for failure.
+ */
+static int zynqmp_r5_get_mem_region_node(struct zynqmp_r5_core *r5_core)
+{
+	struct device_node *np, *rmem_np;
+	struct reserved_mem **rmem;
+	int res_mem_count, i;
+	struct device *dev;
+
+	dev = r5_core->dev;
+	np = r5_core->np;
+
+	res_mem_count = of_property_count_elems_of_size(np, "memory-region",
+							sizeof(phandle));
+
+	if (res_mem_count <= 0) {
+		dev_warn(dev, "failed to get memory-region property %d\n",
+			 res_mem_count);
+		return 0;
+	}
+
+	if (!r5_core->tx_chan && !r5_core->rx_chan)
+		res_mem_count = 1;
+
+	rmem = devm_kcalloc(dev, res_mem_count,
+			    sizeof(struct reserved_mem *), GFP_KERNEL);
+	if (!rmem)
+		return -ENOMEM;
+
+	for (i = 0; i < res_mem_count; i++) {
+		rmem_np = of_parse_phandle(np, "memory-region", i);
+		if (!rmem_np)
+			goto release_rmem;
+
+		rmem[i] = of_reserved_mem_lookup(rmem_np);
+		if (!rmem[i]) {
+			of_node_put(rmem_np);
+			goto release_rmem;
+		}
+
+		of_node_put(rmem_np);
+	}
+
+	r5_core->rmem_count = res_mem_count;
+	r5_core->rmem = rmem;
+	return 0;
+
+release_rmem:
+	return -EINVAL;
+}
+
 /*
  * add_mem_regions_carveout()
  * @rproc: single R5 core's corresponding rproc instance
@@ -241,6 +494,7 @@ static int add_mem_regions_carveout(struct rproc *rproc)
 	struct zynqmp_r5_core *r5_core;
 	struct reserved_mem *rmem;
 	int i, num_mem_regions;
+	const char *name;
 
 	r5_core = (struct zynqmp_r5_core *)rproc->priv;
 	num_mem_regions = r5_core->rmem_count;
@@ -253,15 +507,33 @@ static int add_mem_regions_carveout(struct rproc *rproc)
 			rproc_mem = rproc_of_resm_mem_entry_init(&rproc->dev, i,
 								 rmem->size,
 								 rmem->base,
-								 rmem->name);
+								 "vdev0buffer");
 		} else {
+			/*
+			 * As per bindings 3rd entry in memory-region property
+			 * must contain vring0 and 4th entry must contain vring1
+			 * memory-regions. For remoteproc framework it is
+			 * required to have fixed names for these carveouts i.e.
+			 * in the form of "vdev%dvring%d" where first %d is ID
+			 * of vdev and second %d is ID of vring. Assign fix names
+			 * instead of node names, as node names may contain
+			 * @unit-address as well i.e. vdev0vring0@xxxxxxxx which
+			 * won't work.
+			 */
+			if (!strncmp(rmem->name, "vdev0vring0", strlen("vdev0vring0")))
+				name = "vdev0vring0";
+			else if (!strncmp(rmem->name, "vdev0vring1", strlen("vdev0vring1")))
+				name = "vdev0vring1";
+			else
+				name = rmem->name;
+
 			/* Register associated reserved memory regions */
 			rproc_mem = rproc_mem_entry_init(&rproc->dev, NULL,
 							 (dma_addr_t)rmem->base,
 							 rmem->size, rmem->base,
 							 zynqmp_r5_mem_region_map,
 							 zynqmp_r5_mem_region_unmap,
-							 rmem->name);
+							 name);
 		}
 
 		if (!rproc_mem)
@@ -572,6 +844,20 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
 		return ret;
 	}
 
+	/*
+	 * If mailbox nodes are disabled using "status" property then setting up
+	 * mailbox channels will be failed and in that case, we don't need vrings
+	 * and vdevbuffer for this core. So, setup mailbox before parsing
+	 * memory-region property. If "tx" and "rx" mailboxes are not setup, then
+	 * only parse and add first memory-region carveout. As per bindings, it
+	 * must be firmware load region
+	 */
+	zynqmp_r5_setup_mbox(rproc->priv);
+
+	ret = zynqmp_r5_get_mem_region_node(rproc->priv);
+	if (ret)
+		dev_warn(&rproc->dev, "memory-region prop failed %d\n", ret);
+
 	ret = add_mem_regions_carveout(rproc);
 	if (ret) {
 		dev_err(&rproc->dev, "failed to get reserve mem regions %d\n", ret);
@@ -597,6 +883,8 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
 
 	r5_core = (struct zynqmp_r5_core *)rproc->priv;
 
+	zynqmp_r5_free_mbox(r5_core);
+
 	for (i = 0; i < r5_core->tcm_bank_count; i++) {
 		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
 		if (zynqmp_pm_release_node(pm_domain_id))
@@ -617,6 +905,7 @@ static const struct rproc_ops zynqmp_r5_rproc_ops = {
 	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
 	.sanity_check	= rproc_elf_sanity_check,
 	.get_boot_addr	= rproc_elf_get_boot_addr,
+	.kick		= zynqmp_r5_rproc_kick,
 };
 
 /**
@@ -726,59 +1015,6 @@ static int zynqmp_r5_get_tcm_node(struct zynqmp_r5_cluster *cluster)
 	return 0;
 }
 
-/**
- * zynqmp_r5_get_mem_region_node()
- * parse memory-region property and get reserved mem regions
- *
- * @r5_core: pointer to zynqmp_r5_core type object
- *
- * Return: 0 for success and error code for failure.
- */
-static int zynqmp_r5_get_mem_region_node(struct zynqmp_r5_core *r5_core)
-{
-	struct device_node *np, *rmem_np;
-	struct reserved_mem **rmem;
-	int res_mem_count, i;
-	struct device *dev;
-
-	dev = r5_core->dev;
-	np = r5_core->np;
-
-	res_mem_count = of_property_count_elems_of_size(np, "memory-region",
-							sizeof(phandle));
-	if (res_mem_count <= 0) {
-		dev_warn(dev, "failed to get memory-region property %d\n",
-			 res_mem_count);
-		return 0;
-	}
-
-	rmem = devm_kcalloc(dev, res_mem_count,
-			    sizeof(struct reserved_mem *), GFP_KERNEL);
-	if (!rmem)
-		return -ENOMEM;
-
-	for (i = 0; i < res_mem_count; i++) {
-		rmem_np = of_parse_phandle(np, "memory-region", i);
-		if (!rmem_np)
-			goto release_rmem;
-
-		rmem[i] = of_reserved_mem_lookup(rmem_np);
-		if (!rmem[i]) {
-			of_node_put(rmem_np);
-			goto release_rmem;
-		}
-
-		of_node_put(rmem_np);
-	}
-
-	r5_core->rmem_count = res_mem_count;
-	r5_core->rmem = rmem;
-	return 0;
-
-release_rmem:
-	return -EINVAL;
-}
-
 /*
  * zynqmp_r5_core_init()
  * Create and initialize zynqmp_r5_core type object
@@ -806,10 +1042,6 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
 	for (i = 0; i < cluster->core_count; i++) {
 		r5_core = cluster->r5_cores[i];
 
-		ret = zynqmp_r5_get_mem_region_node(r5_core);
-		if (ret)
-			dev_warn(dev, "memory-region prop failed %d\n", ret);
-
 		/* Initialize r5 cores with power-domains parsed from dts */
 		ret = of_property_read_u32_index(r5_core->np, "power-domains",
 						 1, &r5_core->pm_domain_id);

base-commit: 10de8156ed71d3dbd7e9099aa76e67ea2c37d4ff
-- 
2.25.1

