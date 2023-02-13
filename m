Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5F46952EE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjBMVTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBMVTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:19:03 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7E420556;
        Mon, 13 Feb 2023 13:18:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROBo3pnakavDl3PTqjb3AGg4qXVDhm9InwKaLHWunr/daWaZnxdIIaVL6WCxCtXDoD7dE0ONnhVMjhHuea/4gF1pe1NC7tGprQ5Hs/KSPRtJGNVOEldCbPvssJAj3RZGk+94vMeeMtQof1AsboxrB+/EiYENngRRKpNqklvB3sp6EVukRF/y0lTxY38BaTvV50dWwoCCtTNasyhZlQmk+CVxEasnt6kZVGXWEAC4IBbflPIaM247lcYUyj4TuN+qmGilNoI3A5Cy/bodM5wosvUAE/HcRIhFBSbP7vAcIG1yi2sbmDfjreGzDSmj4uwpTN31vs0qCx7l6MZRbLfbTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pD8j9YyaX5C5gdbFg40Yh4JDGOjSNbvvgHoj+lI9g1Y=;
 b=ciacBcLaVQX70IK4oFtcIth5Hr6PIRTzEwrKOm2PlMfZtRW3Rv82T5NDiebQW1+dwO6INt7tx7MuaW7UtFfrK7hC58pULFCl2lDhkt60bAFI385Kn6uyf7NFahKt9Yh5C9EgOnnjkViLU0CrQvGZ8XAvYMbO1Q2NrJdnoG9tTKlMS1h1a+H2hv0rk0Rp3Ue7HFoiPlHKgzC61nSFMdkOF5slkmED/CghlxVXSSU96lYxIFaJ1S/IMzXSRpenwHSZ1upIfMcSSAJ9NHFMymzZAoKyUR9UbeBwSUB/hnH4S2RqTqgluUDnAFtGBy/T19cSXUd9biCxqbMPwqPNcIpbXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pD8j9YyaX5C5gdbFg40Yh4JDGOjSNbvvgHoj+lI9g1Y=;
 b=I252Y+yn4hVZEaDANrXtp85R7/OLIptZkl56QWbRxSvgCE/CBj+kwnKXCeVNAKtiFUICxzNB62oOIb5CR8hObrg4lp9yPv4LzKG8yofOWw+2o3deUJL4RgYq4mLXc+ZW6qovTTDnZyk1Jo8JCDXCCWrHSRT2+zGdjt4cXGJ5caU=
Received: from CY5PR13CA0017.namprd13.prod.outlook.com (2603:10b6:930::29) by
 DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Mon, 13 Feb 2023 21:18:55 +0000
Received: from CY4PEPF0000C985.namprd02.prod.outlook.com
 (2603:10b6:930:0:cafe::93) by CY5PR13CA0017.outlook.office365.com
 (2603:10b6:930::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.9 via Frontend
 Transport; Mon, 13 Feb 2023 21:18:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C985.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.8 via Frontend Transport; Mon, 13 Feb 2023 21:18:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Feb
 2023 15:18:53 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Feb
 2023 15:18:53 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 13 Feb 2023 15:18:52 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <michal.simek@amd.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <jaswinder.singh@linaro.org>,
        <ben.levinsky@amd.com>, <shubhrajyoti.datta@amd.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v3 3/3] remoteproc: xilinx: add mailbox channels for rpmsg
Date:   Mon, 13 Feb 2023 13:18:26 -0800
Message-ID: <20230213211825.3507034-4-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213211825.3507034-1-tanmay.shah@amd.com>
References: <20230213211825.3507034-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C985:EE_|DM4PR12MB5088:EE_
X-MS-Office365-Filtering-Correlation-Id: 16465cab-5cd6-4fb5-bc41-08db0e07e9da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gE+//FPpJlIfhKqnbH781/OPcYAbXsIn4CyZ1m9DlQ2GrC94XDBKMiSOGa45QDQP8BhAfTGCf83TnOFXO/EPHrAtENsou+dcHq9D/cHDlCCSLY8ntM8H4nA5X26EFXqR8fLlTukzz6kg+nuGhlq8/aEKRTJaj6f/EkT+vX7cnA9IuWpAMsyUEfh/DkuNHAnsdNBBOAMP5hNi0vAGTC1qcqAG1/WdIb18oCePGa8xNrusR+Aaow5S1f+Ue7YzsFE3QAGq6Gr8UU5XD1YMXUztwx358/pxKeFcIVIDGvp1eQyq9XD3MGoQflx/LKzed0mLoowVu10X2iJPgl4P0ft2NrPJ2pdFKucKT9/snZrL0Z+56A811Xmt4/HlWi/NRc1lrIDwgoyLCCtFnzQhObNfZusavN50Ba11yJWA5rTDF594B51ppXW8U99oVqTWABd2TU2C9GBRKC+mHzxIQm7f7/fgLje2uPVAaKWHsJFLqwu+yY+8SYAcMuhLsZl2jwoEU8Dms1kSm/+vTsQsWii3D3glJCHIh6DkfKT7E/0mMZ1vCnrClAAhgljVIZHstdBBcJpp7GIsyibVNr/Z02W3/Yg0wjLadeVYHKAsGyy6t1+KNSW6/qk3dqbsHMa0UW+tdkZPRDEHZXKQs/XKMGGZBz6kjLnhUP/kiHWNrTcLsPnjpXsA5CvXfD89ZwOez7f1Y7epLsInhUB4rfAHXgZMyhYJFaLW8dGZKJis4sbzX94RNMBcHEhLW1iPxtiGwSPcMtuLEtU0viuRDCN7f7CwWT0kWnad6IdEsAw2i18Vi9A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(83380400001)(4326008)(36860700001)(8676002)(81166007)(316002)(36756003)(41300700001)(54906003)(110136005)(6636002)(2616005)(82310400005)(82740400003)(70206006)(70586007)(336012)(426003)(47076005)(478600001)(40480700001)(2906002)(356005)(5660300002)(30864003)(8936002)(44832011)(40460700003)(1076003)(6666004)(15650500001)(186003)(966005)(86362001)(26005)(17423001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 21:18:55.3105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16465cab-5cd6-4fb5-bc41-08db0e07e9da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C985.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5088
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

Changes in v3:
  - fix multi-line comment format
  - do not mixup mailbox information with memory-regions
  - fix redundant dev_warn for split mode
  - setting up mailboxes should return an error code
  - redesign driver to move mailbox setup during driver probe
  - add .kick function only if mailbox setup is success

v2: https://lore.kernel.org/all/20230126213154.1707300-1-tanmay.shah@amd.com/

 drivers/remoteproc/xlnx_r5_remoteproc.c | 228 +++++++++++++++++++++++-
 1 file changed, 226 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index 81af2dea56c2..f7131fe8fe7e 100644
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
@@ -617,7 +819,7 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
 	return 0;
 }
 
-static const struct rproc_ops zynqmp_r5_rproc_ops = {
+static struct rproc_ops zynqmp_r5_rproc_ops = {
 	.prepare	= zynqmp_r5_rproc_prepare,
 	.unprepare	= zynqmp_r5_rproc_unprepare,
 	.start		= zynqmp_r5_rproc_start,
@@ -642,6 +844,7 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
 {
 	struct zynqmp_r5_core *r5_core;
 	struct rproc *r5_rproc;
+	struct mbox_info *ipi;
 	int ret;
 
 	/* Set up DMA mask */
@@ -649,12 +852,23 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
 	if (ret)
 		return ERR_PTR(ret);
 
+	/*
+	 * If mailbox nodes are disabled using "status" property then setting up
+	 * mailbox channels will be failed. In that case we don't really need
+	 * kick() operation. Include .kick() only if mbox channels are acquired
+	 * successfully.
+	 */
+	ipi = zynqmp_r5_setup_mbox(cdev);
+	if (ipi)
+		zynqmp_r5_rproc_ops.kick = zynqmp_r5_rproc_kick;
+
 	/* Allocate remoteproc instance */
 	r5_rproc = rproc_alloc(cdev, dev_name(cdev),
 			       &zynqmp_r5_rproc_ops,
 			       NULL, sizeof(struct zynqmp_r5_core));
 	if (!r5_rproc) {
 		dev_err(cdev, "failed to allocate memory for rproc instance\n");
+		zynqmp_r5_free_mbox(ipi);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -665,6 +879,7 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
 	if (!r5_core->np) {
 		dev_err(cdev, "can't get device node for r5 core\n");
 		ret = -EINVAL;
+		zynqmp_r5_free_mbox(ipi);
 		goto free_rproc;
 	}
 
@@ -672,10 +887,17 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
 	ret = rproc_add(r5_rproc);
 	if (ret) {
 		dev_err(cdev, "failed to add r5 remoteproc\n");
+		zynqmp_r5_free_mbox(ipi);
 		goto free_rproc;
 	}
 
+	if (ipi) {
+		r5_core->ipi = ipi;
+		ipi->r5_core = r5_core;
+	}
+
 	r5_core->rproc = r5_rproc;
+
 	return r5_core;
 
 free_rproc:
@@ -918,6 +1140,7 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
 	while (i >= 0) {
 		put_device(child_devs[i]);
 		if (r5_cores[i]) {
+			zynqmp_r5_free_mbox(r5_cores[i]->ipi);
 			of_reserved_mem_device_release(r5_cores[i]->dev);
 			rproc_del(r5_cores[i]->rproc);
 			rproc_free(r5_cores[i]->rproc);
@@ -942,6 +1165,7 @@ static void zynqmp_r5_cluster_exit(void *data)
 
 	for (i = 0; i < cluster->core_count; i++) {
 		r5_core = cluster->r5_cores[i];
+		zynqmp_r5_free_mbox(r5_core->ipi);
 		of_reserved_mem_device_release(r5_core->dev);
 		put_device(r5_core->dev);
 		rproc_del(r5_core->rproc);
-- 
2.25.1

