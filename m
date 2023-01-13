Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F9E668E53
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240652AbjAMGwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjAMGvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:51:35 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793337FEC1;
        Thu, 12 Jan 2023 22:35:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWaCXRivAWvzW/8Oea7A6GW55Ma/plzlgolmWpCh/KFxKi8ti97tz+/HeKyMtfzib+24JTSNqP8kvtNg0+HBs4C/1pTnh2OJkcvU/+/flxZ5Ufqcj7Y/N7PZU8o3ppir30eLBidXpQ7BLSzftkh/bw35e0zwspGQqf+psur9RL/6pfDCS9KwfvM24nqw0McZweSYZy6Mr0Dg8CzaOeAYkKKX0P8+SvmSC0IegFXKW4T8w0wjJ8D9U7tQeL+pDvtpZuAfjLb56SweuZrE5z5PiiKuLyi99yhq5CcXXWn2BUBesJbTKx4JyC5m8+ofyi5miGYIzZUk/ungOUD0tZoHNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMj0RhSDXChHj4XC5MhckVVBDv23nezErj264jUMfBA=;
 b=Py9OpOCPKni472YCtfYU+M2A/pxhy396oK+qYfSdY0sP9Snrxej0jxBikl3/aX45AYzrS1VHJBRCAQqiaxQa08TafXBX+XvXatfOsn2KzwkHZJVgsQs1sFvGwgiMScHV2hJIQqbZ05FpmwOE+zqPqsDna/atL7CK5QgSnSz1sKx5SrKqt8qEd/XjSb4etlG17DJvGmI4NG1pKPfgoAN0D+emcwwxFwNhZoNAFoZ3ixBUGOHdg1BzD7hOiHmmQhINTvg7iEogv2a4BIn7JCbPBvz6g6awkINBU64vd8UcNnKGqKpTeX37UsWaXK8NM1elKNGFsBLsupN+ZmSGRlchGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMj0RhSDXChHj4XC5MhckVVBDv23nezErj264jUMfBA=;
 b=fsMQYqCORBsvMgNr6tTi/n/7hsXbYiQj1Q/Ra2cORortAZN79KjqOAQ2ugpeC78selSeahZlTuONXlX1Dd2PXlfZdb/SoATPcq6w6vkWCvuvb2AksbyUT05vo2DVg3UcLXLubg0+carbREbJ9v/hJXE/Mp1qV+4453/ijtm204g=
Received: from DM6PR04CA0013.namprd04.prod.outlook.com (2603:10b6:5:334::18)
 by DS0PR12MB6461.namprd12.prod.outlook.com (2603:10b6:8:c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 06:32:44 +0000
Received: from DS1PEPF0000E648.namprd02.prod.outlook.com
 (2603:10b6:5:334:cafe::89) by DM6PR04CA0013.outlook.office365.com
 (2603:10b6:5:334::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Fri, 13 Jan 2023 06:32:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E648.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Fri, 13 Jan 2023 06:32:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 00:32:44 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 00:32:43 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 13 Jan 2023 00:32:43 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@amd.com>,
        <openamp-system-reference@lists.openampproject.org>,
        <tanmay.shah@amd.com>
Subject: [PATCH] remoteproc: xilinx: add mailbox channels for rpmsg
Date:   Thu, 12 Jan 2023 22:32:04 -0800
Message-ID: <20230113063203.3993235-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E648:EE_|DS0PR12MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: 115df53b-0494-4d08-daf6-08daf52ffac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wcf3o3k4eJVTGGR80NBZ2LkInXEpV+ZfKsczNtr6NdaAx+Hn7Lf+urYtyPHOj7GYzb2/7rgcuJkfjqhIKF9QlJFEJyyKSmbhjTZ8wnS+i1WfkPy8+tn+QD7YKNYdtlLquADQt+m7Nj+26J5Hq/rWCEdAQPSOhvMLdk+02vY2gOaY0nfcgLWZNduyDefdLND7O3u/eOB+Z59HpU4y1+d8MSHJMTagYJ1aGpy4qpkVLAz+oYaghgaJXFDug/syZBOcrOyqOoD4W1GUDA7CR2FNN3BMSMLx0f2cvVfUCV0zPfoiWjB+7EFBK1cyQMG3FPtXJR+E7WE7kVFptM/ZGPE6IrHm2fB6H7p3lgScKO1yNvWtpp6oedaEBzlFqCh8Gj7M4DrRRb6hACx+78T/3Eyl8RczJ/ilCLMWaulu87QVZtSR4uDmkztaCMCfAj+GuHWWvpvrjB7iMaUfzOrUPJfdBSfGd87Nc2Q8PIxxt9bzw2kz2mdDSMsZgCb74YH00KIegpb/mMorXGbRaHtoFmP5AhV0XBm8O5BDCh/v2vb8dmGQEn/pxRG7HDtxFbImbDAvTDxDsUforMb+Iw9fK0LYw2IOlsTvIILuUEcNtQo8A8SyctYPzi4g+5A36RheTDqfGOFgt3cIC0B8auI/ZmLGT4bQQbnOxeK3DXoxmzIxjSVvafFhOf52sb0RpHCtPK4EyHH0fVxLU1cjE0ne7zJ9ev21/2oWTm8i8gul2brUPMqUdoVDeqITIcyo4VZPf4DM
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199015)(46966006)(36840700001)(40470700004)(6666004)(26005)(2906002)(15650500001)(478600001)(47076005)(186003)(8676002)(336012)(83380400001)(426003)(40460700003)(8936002)(44832011)(82740400003)(1076003)(82310400005)(30864003)(110136005)(2616005)(36756003)(54906003)(86362001)(70586007)(316002)(70206006)(81166007)(36860700001)(356005)(41300700001)(40480700001)(4326008)(5660300002)(17423001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 06:32:44.5103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 115df53b-0494-4d08-daf6-08daf52ffac5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E648.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/remoteproc/xlnx_r5_remoteproc.c | 329 +++++++++++++++++++-----
 1 file changed, 271 insertions(+), 58 deletions(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index 2db57d394155..1e797c5ffc06 100644
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
@@ -572,6 +825,20 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
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
@@ -597,6 +864,8 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
 
 	r5_core = (struct zynqmp_r5_core *)rproc->priv;
 
+	zynqmp_r5_free_mbox(r5_core);
+
 	for (i = 0; i < r5_core->tcm_bank_count; i++) {
 		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
 		if (zynqmp_pm_release_node(pm_domain_id))
@@ -617,6 +886,7 @@ static const struct rproc_ops zynqmp_r5_rproc_ops = {
 	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
 	.sanity_check	= rproc_elf_sanity_check,
 	.get_boot_addr	= rproc_elf_get_boot_addr,
+	.kick		= zynqmp_r5_rproc_kick,
 };
 
 /**
@@ -726,59 +996,6 @@ static int zynqmp_r5_get_tcm_node(struct zynqmp_r5_cluster *cluster)
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
@@ -806,10 +1023,6 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
 	for (i = 0; i < cluster->core_count; i++) {
 		r5_core = cluster->r5_cores[i];
 
-		ret = zynqmp_r5_get_mem_region_node(r5_core);
-		if (ret)
-			dev_warn(dev, "memory-region prop failed %d\n", ret);
-
 		/* Initialize r5 cores with power-domains parsed from dts */
 		ret = of_property_read_u32_index(r5_core->np, "power-domains",
 						 1, &r5_core->pm_domain_id);

base-commit: 90d6db82626be5e5fe085f4f58c49a080c420fa6
-- 
2.25.1

