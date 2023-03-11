Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD03C6B5788
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 02:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjCKB0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 20:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjCKBZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 20:25:34 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E35483E2;
        Fri, 10 Mar 2023 17:25:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgE0piepel9qtazkrQ0HF4DJKL1oQGgfeMa8LexhViPRTdNA51FDxTuNrOoxWEDzdG16MHhxpAWwMQ1ONVGZ/AUPc3DGsfxsNlkaeKY2JWsz4f2GCnuZXu0/mYeLf25OgMN65ecWC0k2GQLmzwRvBg4TFL4J8VoGcahnCLLWRyjG6vRkktiKJGaeZ7q+VUplgRn1AHYjqLrVuV+wxaFqUoXir+1rVFwYGuHsYq2ZKkgRroj9cEVYvg57e+pm59upPSd0d614bkk7rXOkjUXHpgrA1mPnmxbpgflCLVD9y3K+3tdYVdV62AQcyAX5gmh+nlPnenOjV5W3kepmkv75LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nw6jj7FxmffKamQY4go1Zi0p1HsqKE1T1IRMz7CeEc=;
 b=c31xkpd5qHdOVY7Mp9JCnVNpSh8r0BhPDqEvQUiyP2UCuoNGCdjUOaIYwTZA0ocnoSdne1O0WJmNLz2RMbUse5PAc9s5OG254i74os6FlFWFbAFsKyqbGl9XnIiEpn9iTQK5mv2iX0rYdgIpGpw4U0Lt87PH6ApWqUHp/WzaAxb4PrLOG2nJHw7RBhwzvaooycaJhkEBThvR4OZpel9ZH+LQJ+QvTbun+hCU8FAGN4MXfw7PHfeS1lJWTLG/VWXJ1izFhgr+N402EgoZ/wzQFWj18YFDQD61oqnL8vte7mVED02IEYGqopBKJ+XqrWCLOcGvYzhx065mrsj4MaaicA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nw6jj7FxmffKamQY4go1Zi0p1HsqKE1T1IRMz7CeEc=;
 b=fQbyoDWoMXUHn1M1pgISucl29tndrGvpO7jp24uXLesPEwi8xZ78s+0NJ47VQ0Q9AmT2zOC5shhALMUIOymr7iSG5VkvRDQHKERGSq6fe4gXcc+/KT7bCNfrocRPabwakVMYOcuNlyGd3E7PA/xs+JYnln9irGdVT7v31iyBcUE=
Received: from DS7PR07CA0009.namprd07.prod.outlook.com (2603:10b6:5:3af::9) by
 DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.20; Sat, 11 Mar 2023 01:24:34 +0000
Received: from DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::c4) by DS7PR07CA0009.outlook.office365.com
 (2603:10b6:5:3af::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Sat, 11 Mar 2023 01:24:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT071.mail.protection.outlook.com (10.13.173.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.20 via Frontend Transport; Sat, 11 Mar 2023 01:24:34 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 19:24:31 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 17:24:31 -0800
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 10 Mar 2023 19:24:30 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <michal.simek@amd.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <jaswinder.singh@linaro.org>,
        <ben.levinsky@amd.com>, <shubhrajyoti.datta@amd.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v5 5/5] remoteproc: xilinx: add mailbox channels for rpmsg
Date:   Fri, 10 Mar 2023 17:24:08 -0800
Message-ID: <20230311012407.1292118-6-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230311012407.1292118-1-tanmay.shah@amd.com>
References: <20230311012407.1292118-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT071:EE_|DM6PR12MB4403:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e9a1138-34b7-4d80-608d-08db21cf5f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FrNePqIkXCpwpbGmAGc5wU/0h2ZgCCSOXRqxwPijT6J/IAbNIMTBZp2+LbV8mPQBEy4t+qQtzhtWNGxYdA6N0HoxAZOfBNUtnKei5ljradNKbsMRsUDsHDtxVlJ2PyvrRN6D0gelOEsRA0fTfdCrxqNErb3hAUiZK7RVzsgYqFi5qN8tTT4ncnkaq7YFcYquns/KvDUMB+VR85FRavZLI8vXXbdJb+BMfonRoXB3q8w0T306TYipG4/yLDRIXkkmk36o8hbmy2zwlyYQdLa6S1kGFprODqcwDVoKxB8LzTIfs5wZabwL61QUoFXJJwT6rA88otgpETtiDL+SyUDxst7TqMGU+Xp92fTeEplTVCB/OZGQjLIH6fxooBFsdpqv4c0wsGHhBaf+rrD1CRk4BBN7Hhdw9vaOMfC/D69NfCn6mfQEdPUk/gJc4qyQznq6SQhge3UwXfvMkYIT9XRLPnkgEYkGf7RIYyLmdQTzji9vbqK0ke36SwG2xpdywp7nUQD8reCddkfjUPR+Iyk9wxeXZB7JeDtRS4miqhVy/hstXnhK5g2lXTm2xG4AYYrqPtURaUmHnay4sLvlEh9nhgOoTwx1bdzm9ZAU8EuYqpDZQ3VlWmeDqGx054dT6lDF4z/1QWqWujva7IJOtBtCGOh+TMZQ/V6UAG2EdoQd15hRSuFCZNC3BGgDSuTCNrHpUwwKykNm/Tqhx1qn8pEX6NS9W98dFHU/5LYb/TLQiRfF8yBuqsIWXY6wrD3Se/AM
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199018)(40470700004)(46966006)(36840700001)(40480700001)(47076005)(426003)(36860700001)(336012)(82310400005)(86362001)(36756003)(356005)(40460700003)(82740400003)(83380400001)(81166007)(8936002)(478600001)(110136005)(15650500001)(5660300002)(2906002)(966005)(44832011)(8676002)(70206006)(70586007)(316002)(6636002)(54906003)(41300700001)(4326008)(186003)(2616005)(6666004)(26005)(1076003)(17423001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 01:24:34.3366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9a1138-34b7-4d80-608d-08db21cf5f53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v5:
  - Remove spurious change
  - Include kick op regardless status of mailbox nodes in dts

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

 drivers/remoteproc/xlnx_r5_remoteproc.c | 218 +++++++++++++++++++++++-
 1 file changed, 217 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index 5dd007622603..53e3e4bd0f38 100644
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
@@ -624,6 +826,7 @@ static const struct rproc_ops zynqmp_r5_rproc_ops = {
 	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
 	.sanity_check	= rproc_elf_sanity_check,
 	.get_boot_addr	= rproc_elf_get_boot_addr,
+	.kick		= zynqmp_r5_rproc_kick,
 };
 
 /**
@@ -799,6 +1002,7 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
 	struct device_node *child;
 	enum rpu_tcm_comb tcm_mode;
 	int core_count, ret, i;
+	struct mbox_info *ipi;
 
 	ret = of_property_read_u32(dev_node, "xlnx,cluster-mode", &cluster_mode);
 
@@ -878,6 +1082,16 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
 			goto release_r5_cores;
 		}
 
+		/*
+		 * If mailbox nodes are disabled using "status" property then
+		 * setting up mailbox channels will fail.
+		 */
+		ipi = zynqmp_r5_setup_mbox(&child_pdev->dev);
+		if (ipi) {
+			r5_cores[i]->ipi = ipi;
+			ipi->r5_core = r5_cores[i];
+		}
+
 		/*
 		 * If two child nodes are available in dts in lockstep mode,
 		 * then ignore second child node.
@@ -915,6 +1129,7 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
 	while (i >= 0) {
 		put_device(child_devs[i]);
 		if (r5_cores[i]) {
+			zynqmp_r5_free_mbox(r5_cores[i]->ipi);
 			of_reserved_mem_device_release(r5_cores[i]->dev);
 			rproc_del(r5_cores[i]->rproc);
 			rproc_free(r5_cores[i]->rproc);
@@ -939,6 +1154,7 @@ static void zynqmp_r5_cluster_exit(void *data)
 
 	for (i = 0; i < cluster->core_count; i++) {
 		r5_core = cluster->r5_cores[i];
+		zynqmp_r5_free_mbox(r5_core->ipi);
 		of_reserved_mem_device_release(r5_core->dev);
 		put_device(r5_core->dev);
 		rproc_del(r5_core->rproc);
-- 
2.25.1

