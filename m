Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA186A60E2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjB1VCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjB1VCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:02:37 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EA534F70;
        Tue, 28 Feb 2023 13:02:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3Yamt/q99Sf7miQInruRvoRz7ICXizCeKpLTX1nKDeHkXJgXLcQovm64W5G4WdVcdMnDcbrS8vY59zShQLHF+oMTAjtah4OwSxxCEsR/jD4zlAT5Y8jO+yxI1u3C38sHI6n+heZGzEsm8Fp/HXApJKePGEQkqC1WJeNwwQs8TGYDGThT6a5Vk5v+EWObw/p8J89Q3L9qtbYZmTI065l1PyML9+7OGKbzOuh24AK7JnSrx93/yba+qpV5oAxXNs2/8YpyDguEaJikBEkQoOUnNGQX1hBa77Klk24HqeY3t5dWR172xSWDQwgub5fQ79bVoCykbp3fBQl6Pp8JCoBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLsKPhzEELL1Wu5N6l491bMrgzda/1+NSpLcQtRj+yk=;
 b=dsxxTWf95yma/5yF/w2tar7vK7YzY81C2oVSrbXTV2qWM3MNqk1RC3BH3MYGAyMHuBEEmA9Z9QLf1d/goCybiEPlcMGGEElTGoZlWhiOWtcssrnB/TFFKsbktcdnJsnTvZUS4u2wlW4i5ISSp41AGiwvciq/ako7eKP6ymrIqtNrqCcCGUJNPsS1KY6f6J2H1bLP/3heeAczHJGOZImPI4trN9Z++RdOPWWgSF6mNU1lm5YaXcs+3RVgdVHGUtusQBZKEd/3+9DPSIBs85rxmh3NgniDITfVm0JP00KFO9RmL6IfN9S2dw+NzUZ3L7+Qyc4wc1rZnrXCyuTputNw3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLsKPhzEELL1Wu5N6l491bMrgzda/1+NSpLcQtRj+yk=;
 b=J9cHbdAyTCIB+cPS4a3vtHXZEK3eQVZ8GcQdG+8IdPchAw7e1/PIevByC+FkVLDUu3CVBNMmWUN7U67K9rJArfcSLHxRHLGavALoBFiGUnYE50cj2V5yofX22yj03ZZqLqgpS02Q0CWGQQm1da2fCOpaauIq+AY8mM/z3jRQPKU=
Received: from DM5PR07CA0091.namprd07.prod.outlook.com (2603:10b6:4:ae::20) by
 PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 21:02:28 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::40) by DM5PR07CA0091.outlook.office365.com
 (2603:10b6:4:ae::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17 via Frontend
 Transport; Tue, 28 Feb 2023 21:02:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.17 via Frontend Transport; Tue, 28 Feb 2023 21:02:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Feb
 2023 15:02:25 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 28 Feb 2023 15:02:25 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <michal.simek@amd.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <jaswinder.singh@linaro.org>,
        <ben.levinsky@amd.com>, <shubhrajyoti.datta@amd.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v4 5/5] remoteproc: xilinx: add mailbox channels for rpmsg
Date:   Tue, 28 Feb 2023 13:02:16 -0800
Message-ID: <20230228210216.447373-6-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230228210216.447373-1-tanmay.shah@amd.com>
References: <20230228210216.447373-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|PH7PR12MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: 03be0935-823c-4976-75d9-08db19cf19b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0WyzWPgwUqixzFlcNazvv7NplHfEF/6ZqUUSbzoMqdYUa7t0rspRdl2VYfKxgVPIp42nHEFRGFSiLJKBM6+HEOvHWXnuuaKn5oqojKF0cCRzYyRLYJQUfaKS01gAxGEnlh+y7sFNxzgJrvjpTUHFGQesNpkuBiXkah4pDnV8irmZ92Kj4ktVxfTeNZN5Ju/JU6RH+c/z4Hqp01J2BvofYFWAiKiKBWKq4egW4YPTdf5k1C13ZHj6zW4kU1k843u4WN5ebFqTsSEm4UgtC5fOAewlQsB0Z4TTNcjvbm91VzP75q3Nz27IjQ/n1at6bVU3P5A8U3PP7ouZQMEOTtiqUzQPfA7lMSUQqCR0IJCLrHLsK9Enc0aRWpfI518K6I5WeoIcoV1wwRP5gHL2XlYmX7qdMPKxe/DuP+lPCWJ2HBjzoCCqbhzOvs1nCg50rIpHcBQMtkzcgfWN/EZV2aaXokdbiarUWLYWM9srVAk+n3YfSuzZKTRmFPJWpFsfcZ/AYPbL/SRlPMkpBqtkUCJgdkWHNbFuBxoa77XCnhrmjwKhNgG7nhG7d0rpxhalOQrdQhiLu7nuj8hdIdiKrzoKkFv8aP1LFhRIeARzmhWBGM5T5TcPJYBtoCYpidGF3aXgWdOI2a3zGY/26TjyNgBlsGCCeYSksaOji3cCBIYWkCszhBFj3s5PrISfx8ddS1FW0peweEBGoc6p7AHJoHktGBONooabKNG3jUIbt4sbhyK9GInHNr38DXgGAnYvsRl1
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(86362001)(8936002)(5660300002)(44832011)(26005)(1076003)(316002)(8676002)(15650500001)(70586007)(70206006)(41300700001)(186003)(4326008)(6636002)(2906002)(36756003)(54906003)(83380400001)(40460700003)(966005)(110136005)(478600001)(40480700001)(6666004)(426003)(336012)(47076005)(356005)(2616005)(82740400003)(81166007)(36860700001)(82310400005)(17423001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 21:02:28.1792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03be0935-823c-4976-75d9-08db19cf19b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880
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

Changes in v4:
  - move zynqmp_r5_setup_mbox from zynqmp_r5_add_rproc_core to
    zynqmp_r5_cluster_init

Changes in v3:
  - fix multi-line comment format
  - do not mixup mailbox information with memory-regions
  - fix redundant dev_warn for split mode
  - setting up mailboxes should return an error code
  - redesign driver to move mailbox setup during driver probe
  - add .kick function only if mailbox setup is success

v2: https://lore.kernel.org/all/20230126213154.1707300-1-tanmay.shah@amd.com/

 drivers/remoteproc/xlnx_r5_remoteproc.c | 227 +++++++++++++++++++++++-
 1 file changed, 225 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index 5dd007622603..78c1638ccef0 100644
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
@@ -43,6 +50,27 @@ struct mem_bank_data {
 	char *bank_name;
 };
 
+/**
+ * struct mbox_info
+ *
+ * @rx_mc_buf: to copy data from mailbox rx channel
+ * @tx_mc_buf: to copy data to mailbox tx channel
+ * @r5_core: this mailbox's corresponding r5_core pointer
+ * @mbox_work: schedule work after receiving data from mailbox
+ * @mbox_cl: mailbox client
+ * @tx_chan: mailbox tx channel
+ * @rx_chan: mailbox rx channel
+ */
+struct mbox_info {
+	unsigned char rx_mc_buf[MBOX_CLIENT_BUF_MAX];
+	unsigned char tx_mc_buf[MBOX_CLIENT_BUF_MAX];
+	struct zynqmp_r5_core *r5_core;
+	struct work_struct mbox_work;
+	struct mbox_client mbox_cl;
+	struct mbox_chan *tx_chan;
+	struct mbox_chan *rx_chan;
+};
+
 /*
  * Hardcoded TCM bank values. This will be removed once TCM bindings are
  * accepted for system-dt specifications and upstreamed in linux kernel
@@ -63,6 +91,7 @@ static const struct mem_bank_data zynqmp_tcm_banks[] = {
  * @tcm_banks: array of each TCM bank data
  * @rproc: rproc handle
  * @pm_domain_id: RPU CPU power domain id
+ * @ipi: pointer to mailbox information
  */
 struct zynqmp_r5_core {
 	struct device *dev;
@@ -71,6 +100,7 @@ struct zynqmp_r5_core {
 	struct mem_bank_data **tcm_banks;
 	struct rproc *rproc;
 	u32 pm_domain_id;
+	struct mbox_info *ipi;
 };
 
 /**
@@ -88,6 +118,178 @@ struct zynqmp_r5_cluster {
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
+	struct mbox_info *ipi;
+	struct rproc *rproc;
+
+	ipi = container_of(work, struct mbox_info, mbox_work);
+	rproc = ipi->r5_core->rproc;
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
+	struct mbox_info *ipi;
+	size_t len;
+
+	ipi = container_of(cl, struct mbox_info, mbox_cl);
+
+	/* copy data from ipi buffer to r5_core */
+	ipi_msg = (struct zynqmp_ipi_message *)msg;
+	buf_msg = (struct zynqmp_ipi_message *)ipi->rx_mc_buf;
+	len = ipi_msg->len;
+	if (len > IPI_BUF_LEN_MAX) {
+		dev_warn(cl->dev, "msg size exceeded than %d\n",
+			 IPI_BUF_LEN_MAX);
+		len = IPI_BUF_LEN_MAX;
+	}
+	buf_msg->len = len;
+	memcpy(buf_msg->data, ipi_msg->data, len);
+
+	/* received and processed interrupt ack */
+	if (mbox_send_message(ipi->rx_chan, NULL) < 0)
+		dev_err(cl->dev, "ack failed to mbox rx_chan\n");
+
+	schedule_work(&ipi->mbox_work);
+}
+
+/**
+ * zynqmp_r5_setup_mbox() - Setup mailboxes related properties
+ *			    this is used for each individual R5 core
+ *
+ * @cdev: child node device
+ *
+ * Function to setup mailboxes related properties
+ * return : NULL if failed else pointer to mbox_info
+ */
+static struct mbox_info *zynqmp_r5_setup_mbox(struct device *cdev)
+{
+	struct mbox_client *mbox_cl;
+	struct mbox_info *ipi;
+
+	ipi = kzalloc(sizeof(*ipi), GFP_KERNEL);
+	if (!ipi)
+		return NULL;
+
+	mbox_cl = &ipi->mbox_cl;
+	mbox_cl->rx_callback = zynqmp_r5_mb_rx_cb;
+	mbox_cl->tx_block = false;
+	mbox_cl->knows_txdone = false;
+	mbox_cl->tx_done = NULL;
+	mbox_cl->dev = cdev;
+
+	/* Request TX and RX channels */
+	ipi->tx_chan = mbox_request_channel_byname(mbox_cl, "tx");
+	if (IS_ERR(ipi->tx_chan)) {
+		ipi->tx_chan = NULL;
+		kfree(ipi);
+		dev_warn(cdev, "mbox tx channel request failed\n");
+		return NULL;
+	}
+
+	ipi->rx_chan = mbox_request_channel_byname(mbox_cl, "rx");
+	if (IS_ERR(ipi->rx_chan)) {
+		mbox_free_channel(ipi->tx_chan);
+		ipi->rx_chan = NULL;
+		ipi->tx_chan = NULL;
+		kfree(ipi);
+		dev_warn(cdev, "mbox rx channel request failed\n");
+		return NULL;
+	}
+
+	INIT_WORK(&ipi->mbox_work, handle_event_notified);
+
+	return ipi;
+}
+
+static void zynqmp_r5_free_mbox(struct mbox_info *ipi)
+{
+	if (!ipi)
+		return;
+
+	if (ipi->tx_chan) {
+		mbox_free_channel(ipi->tx_chan);
+		ipi->tx_chan = NULL;
+	}
+
+	if (ipi->rx_chan) {
+		mbox_free_channel(ipi->rx_chan);
+		ipi->rx_chan = NULL;
+	}
+
+	kfree(ipi);
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
+	struct mbox_info *ipi;
+	int ret;
+
+	ipi = r5_core->ipi;
+	if (!ipi)
+		return;
+
+	mb_msg = (struct zynqmp_ipi_message *)ipi->tx_mc_buf;
+	memcpy(mb_msg->data, &vqid, sizeof(vqid));
+	mb_msg->len = sizeof(vqid);
+	ret = mbox_send_message(ipi->tx_chan, mb_msg);
+	if (ret < 0)
+		dev_warn(dev, "failed to send message\n");
+}
+
 /*
  * zynqmp_r5_set_mode()
  *
@@ -614,7 +816,7 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
 	return 0;
 }
 
-static const struct rproc_ops zynqmp_r5_rproc_ops = {
+static struct rproc_ops zynqmp_r5_rproc_ops = {
 	.prepare	= zynqmp_r5_rproc_prepare,
 	.unprepare	= zynqmp_r5_rproc_unprepare,
 	.start		= zynqmp_r5_rproc_start,
@@ -673,6 +875,7 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
 	}
 
 	r5_core->rproc = r5_rproc;
+
 	return r5_core;
 
 free_rproc:
@@ -799,6 +1002,7 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
 	struct device_node *child;
 	enum rpu_tcm_comb tcm_mode;
 	int core_count, ret, i;
+	struct mbox_info *ipi;
 
 	ret = of_property_read_u32(dev_node, "xlnx,cluster-mode", &cluster_mode);
 
@@ -869,6 +1073,18 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
 
 		child_devs[i] = &child_pdev->dev;
 
+		/*
+		 * If mailbox nodes are disabled using "status" property then
+		 * setting up mailbox channels will be failed. In that case we
+		 * don't really need kick() operation. Include .kick() only if
+		 * mbox channels are acquired successfully.
+		 */
+		ipi = zynqmp_r5_setup_mbox(&child_pdev->dev);
+		if (ipi)
+			zynqmp_r5_rproc_ops.kick = zynqmp_r5_rproc_kick;
+		else
+			zynqmp_r5_rproc_ops.kick = NULL;
+
 		/* create and add remoteproc instance of type struct rproc */
 		r5_cores[i] = zynqmp_r5_add_rproc_core(&child_pdev->dev);
 		if (IS_ERR(r5_cores[i])) {
@@ -878,6 +1094,11 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
 			goto release_r5_cores;
 		}
 
+		if (ipi) {
+			r5_cores[i]->ipi = ipi;
+			ipi->r5_core = r5_cores[i];
+		}
+
 		/*
 		 * If two child nodes are available in dts in lockstep mode,
 		 * then ignore second child node.
@@ -915,6 +1136,7 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
 	while (i >= 0) {
 		put_device(child_devs[i]);
 		if (r5_cores[i]) {
+			zynqmp_r5_free_mbox(r5_cores[i]->ipi);
 			of_reserved_mem_device_release(r5_cores[i]->dev);
 			rproc_del(r5_cores[i]->rproc);
 			rproc_free(r5_cores[i]->rproc);
@@ -939,6 +1161,7 @@ static void zynqmp_r5_cluster_exit(void *data)
 
 	for (i = 0; i < cluster->core_count; i++) {
 		r5_core = cluster->r5_cores[i];
+		zynqmp_r5_free_mbox(r5_core->ipi);
 		of_reserved_mem_device_release(r5_core->dev);
 		put_device(r5_core->dev);
 		rproc_del(r5_core->rproc);
-- 
2.25.1

