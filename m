Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89D86F3CAA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 06:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjEBEXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 00:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEBEXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 00:23:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ADA2702;
        Mon,  1 May 2023 21:23:34 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3424Fxm1018799;
        Tue, 2 May 2023 04:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=+seufsEQ3Wmk+uAlzrZ+bZtXlZRjYpxMjHUrcgQ18cE=;
 b=fEWMzq7Z2figQfYeAPu0caCvNAvFRZi2+yCbR5eyPa/4YhqlIKefKdEMZbYiZRQNLkwA
 PZETQWC62hFE3MdUPGFpSdcFmmAg4LTosGZTNZrEmIfo8lHfaK0srTP+CvhzqJ1Zj2tA
 Bgy0N7xcHbPTsFFxcfjvaP1uiDBpvE5sTVI6/cAByR9fUQp4eNsybCtWoRJBG8bRATnV
 TiM6UqEVkBKyye9AzRGNgGkTtbmu3vsHJ29c8NUlI/DgCRyVjoArwz7voDhqdirZD9/i
 KVVNJjU6fO/8qVz7Li2UQO6oVyQEQ3tqk/beKrxHELjHhqF0d2nn1QViX20SaS+PgEGt oQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qan8ggmhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 04:23:29 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3424NQ2r008861;
        Tue, 2 May 2023 04:23:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3q8vaks3ex-1;
        Tue, 02 May 2023 04:23:26 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3424NPCk008855;
        Tue, 2 May 2023 04:23:25 GMT
Received: from hyd-lablnx377.qualcomm.com (hyd-lablnx377.qualcomm.com [10.204.178.226])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3424NPLt008854;
        Tue, 02 May 2023 04:23:25 +0000
Received: by hyd-lablnx377.qualcomm.com (Postfix, from userid 4035820)
        id CB3DC20B88; Tue,  2 May 2023 09:53:24 +0530 (IST)
From:   Sai Teja Aluvala <quic_saluvala@quicinc.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        quic_hemantg@quicinc.com, quic_bgodavar@quicinc.com,
        jiangzp@google.com, mmandlik@google.com,
        Sai Teja Aluvala <quic_saluvala@quicinc.com>
Subject: [PATCH v2 2/2] Bluetooth: hci_qca: Add qcomm devcoredump support
Date:   Tue,  2 May 2023 09:53:20 +0530
Message-Id: <1683001400-29905-1-git-send-email-quic_saluvala@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bZRZbuSjAWAJC9U8rpN_HyQm1Dtl3k1z
X-Proofpoint-ORIG-GUID: bZRZbuSjAWAJC9U8rpN_HyQm1Dtl3k1z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_01,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305020035
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intercept debug exception events from QCA controller and put them into
a devcoredump using hci devcoredump APIs of hci_core

Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
Reviewed-by: Manish Mandlik <mmandlik@google.com>

V2:
--
Updated to work with the updated HCI devcoredump API.

V1:
--
Initial Patch
---
 drivers/bluetooth/hci_qca.c | 190 ++++++++++++++++++++++++++++++++------------
 1 file changed, 138 insertions(+), 52 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index ca98f6d..c94a414 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -77,6 +77,7 @@ enum qca_flags {
 	QCA_MEMDUMP_COLLECTION,
 	QCA_HW_ERROR_EVENT,
 	QCA_SSR_TRIGGERED,
+	QCA_COREDUMP_TRIGGERED,
 	QCA_BT_OFF,
 	QCA_ROM_FW
 };
@@ -116,9 +117,7 @@ enum qca_memdump_states {
 	QCA_MEMDUMP_TIMEOUT,
 };
 
-struct qca_memdump_data {
-	char *memdump_buf_head;
-	char *memdump_buf_tail;
+struct qca_memdump_info {
 	u32 current_seq_no;
 	u32 received_dump;
 	u32 ram_dump_size;
@@ -159,13 +158,15 @@ struct qca_data {
 	struct work_struct ws_tx_vote_off;
 	struct work_struct ctrl_memdump_evt;
 	struct delayed_work ctrl_memdump_timeout;
-	struct qca_memdump_data *qca_memdump;
+	struct qca_memdump_info *qca_memdump;
 	unsigned long flags;
 	struct completion drop_ev_comp;
 	wait_queue_head_t suspend_wait_q;
 	enum qca_memdump_states memdump_state;
 	struct mutex hci_memdump_lock;
 
+	u16 fw_version;
+	u16 controller_id;
 	/* For debugging purpose */
 	u64 ibs_sent_wacks;
 	u64 ibs_sent_slps;
@@ -232,6 +233,7 @@ static void qca_regulator_disable(struct qca_serdev *qcadev);
 static void qca_power_shutdown(struct hci_uart *hu);
 static int qca_power_off(struct hci_dev *hdev);
 static void qca_controller_memdump(struct work_struct *work);
+static void qca_dmp_hdr(struct hci_dev *hdev, struct sk_buff *skb);
 
 static enum qca_btsoc_type qca_soc_type(struct hci_uart *hu)
 {
@@ -543,7 +545,8 @@ static void qca_controller_memdump_timeout(struct work_struct *work)
 	mutex_lock(&qca->hci_memdump_lock);
 	if (test_bit(QCA_MEMDUMP_COLLECTION, &qca->flags)) {
 		qca->memdump_state = QCA_MEMDUMP_TIMEOUT;
-		if (!test_bit(QCA_HW_ERROR_EVENT, &qca->flags)) {
+		if ((!test_bit(QCA_HW_ERROR_EVENT, &qca->flags)) ||
+			(!test_bit(QCA_COREDUMP_TRIGGERED, &qca->flags))) {
 			/* Inject hw error event to reset the device
 			 * and driver.
 			 */
@@ -976,6 +979,28 @@ static int qca_recv_acl_data(struct hci_dev *hdev, struct sk_buff *skb)
 	return hci_recv_frame(hdev, skb);
 }
 
+static void qca_dmp_hdr(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct qca_data *qca = hu->priv;
+	char buf[80];
+
+	snprintf(buf, sizeof(buf), "Controller Name: 0x%x\n",
+		qca->controller_id);
+	skb_put_data(skb, buf, strlen(buf));
+
+	snprintf(buf, sizeof(buf), "Firmware Version: 0x%x\n",
+		qca->fw_version);
+	skb_put_data(skb, buf, strlen(buf));
+
+	snprintf(buf, sizeof(buf), "Vendor:Qualcomm\n");
+	skb_put_data(skb, buf, strlen(buf));
+
+	snprintf(buf, sizeof(buf), "Driver: %s\n",
+		hu->serdev->dev.driver->name);
+	skb_put_data(skb, buf, strlen(buf));
+}
+
 static void qca_controller_memdump(struct work_struct *work)
 {
 	struct qca_data *qca = container_of(work, struct qca_data,
@@ -983,13 +1008,11 @@ static void qca_controller_memdump(struct work_struct *work)
 	struct hci_uart *hu = qca->hu;
 	struct sk_buff *skb;
 	struct qca_memdump_event_hdr *cmd_hdr;
-	struct qca_memdump_data *qca_memdump = qca->qca_memdump;
+	struct qca_memdump_info *qca_memdump = qca->qca_memdump;
 	struct qca_dump_size *dump;
-	char *memdump_buf;
-	char nullBuff[QCA_DUMP_PACKET_SIZE] = { 0 };
 	u16 seq_no;
-	u32 dump_size;
 	u32 rx_size;
+	int ret = 0;
 	enum qca_btsoc_type soc_type = qca_soc_type(hu);
 
 	while ((skb = skb_dequeue(&qca->rx_memdump_q))) {
@@ -1005,7 +1028,7 @@ static void qca_controller_memdump(struct work_struct *work)
 		}
 
 		if (!qca_memdump) {
-			qca_memdump = kzalloc(sizeof(struct qca_memdump_data),
+			qca_memdump = kzalloc(sizeof(struct qca_memdump_info),
 					      GFP_ATOMIC);
 			if (!qca_memdump) {
 				mutex_unlock(&qca->hci_memdump_lock);
@@ -1031,44 +1054,49 @@ static void qca_controller_memdump(struct work_struct *work)
 			set_bit(QCA_IBS_DISABLED, &qca->flags);
 			set_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
 			dump = (void *) skb->data;
-			dump_size = __le32_to_cpu(dump->dump_size);
-			if (!(dump_size)) {
+			qca_memdump->ram_dump_size = __le32_to_cpu(dump->dump_size);
+			if (!(qca_memdump->ram_dump_size)) {
 				bt_dev_err(hu->hdev, "Rx invalid memdump size");
 				kfree(qca_memdump);
 				kfree_skb(skb);
-				qca->qca_memdump = NULL;
 				mutex_unlock(&qca->hci_memdump_lock);
 				return;
 			}
 
-			bt_dev_info(hu->hdev, "QCA collecting dump of size:%u",
-				    dump_size);
 			queue_delayed_work(qca->workqueue,
 					   &qca->ctrl_memdump_timeout,
-					   msecs_to_jiffies(MEMDUMP_TIMEOUT_MS)
-					  );
-
-			skb_pull(skb, sizeof(dump_size));
-			memdump_buf = vmalloc(dump_size);
-			qca_memdump->ram_dump_size = dump_size;
-			qca_memdump->memdump_buf_head = memdump_buf;
-			qca_memdump->memdump_buf_tail = memdump_buf;
-		}
+					   msecs_to_jiffies(MEMDUMP_TIMEOUT_MS));
+			skb_pull(skb, sizeof(qca_memdump->ram_dump_size));
+			qca_memdump->current_seq_no = 0;
+			qca_memdump->received_dump = 0;
+			ret = hci_devcd_init(hu->hdev, qca_memdump->ram_dump_size);
+			bt_dev_info(hu->hdev, "hci_devcd_init Return:%d",
+				    ret);
+			if (ret < 0) {
+				kfree(qca->qca_memdump);
+				qca->qca_memdump = NULL;
+				qca->memdump_state = QCA_MEMDUMP_COLLECTED;
+				cancel_delayed_work(&qca->ctrl_memdump_timeout);
+				clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
+				mutex_unlock(&qca->hci_memdump_lock);
+				return;
+			}
 
-		memdump_buf = qca_memdump->memdump_buf_tail;
+			bt_dev_info(hu->hdev, "QCA collecting dump of size:%u",
+				    qca_memdump->ram_dump_size);
+
+		}
 
 		/* If sequence no 0 is missed then there is no point in
 		 * accepting the other sequences.
 		 */
-		if (!memdump_buf) {
+		if (!test_bit(QCA_MEMDUMP_COLLECTION, &qca->flags)) {
 			bt_dev_err(hu->hdev, "QCA: Discarding other packets");
 			kfree(qca_memdump);
 			kfree_skb(skb);
-			qca->qca_memdump = NULL;
 			mutex_unlock(&qca->hci_memdump_lock);
 			return;
 		}
-
 		/* There could be chance of missing some packets from
 		 * the controller. In such cases let us store the dummy
 		 * packets in the buffer.
@@ -1078,8 +1106,8 @@ static void qca_controller_memdump(struct work_struct *work)
 		 * bits, so skip this checking for missing packet.
 		 */
 		while ((seq_no > qca_memdump->current_seq_no + 1) &&
-		       (soc_type != QCA_QCA6390) &&
-		       seq_no != QCA_LAST_SEQUENCE_NUM) {
+			(soc_type != QCA_QCA6390) &&
+			seq_no != QCA_LAST_SEQUENCE_NUM) {
 			bt_dev_err(hu->hdev, "QCA controller missed packet:%d",
 				   qca_memdump->current_seq_no);
 			rx_size = qca_memdump->received_dump;
@@ -1090,43 +1118,38 @@ static void qca_controller_memdump(struct work_struct *work)
 					   qca_memdump->received_dump);
 				break;
 			}
-			memcpy(memdump_buf, nullBuff, QCA_DUMP_PACKET_SIZE);
-			memdump_buf = memdump_buf + QCA_DUMP_PACKET_SIZE;
+			hci_devcd_append_pattern(hu->hdev, 0x00,
+				QCA_DUMP_PACKET_SIZE);
 			qca_memdump->received_dump += QCA_DUMP_PACKET_SIZE;
 			qca_memdump->current_seq_no++;
 		}
 
-		rx_size = qca_memdump->received_dump + skb->len;
+		rx_size = qca_memdump->received_dump  + skb->len;
 		if (rx_size <= qca_memdump->ram_dump_size) {
 			if ((seq_no != QCA_LAST_SEQUENCE_NUM) &&
-			    (seq_no != qca_memdump->current_seq_no))
+			    (seq_no != qca_memdump->current_seq_no)) {
 				bt_dev_err(hu->hdev,
 					   "QCA memdump unexpected packet %d",
 					   seq_no);
+			}
 			bt_dev_dbg(hu->hdev,
 				   "QCA memdump packet %d with length %d",
 				   seq_no, skb->len);
-			memcpy(memdump_buf, (unsigned char *)skb->data,
-			       skb->len);
-			memdump_buf = memdump_buf + skb->len;
-			qca_memdump->memdump_buf_tail = memdump_buf;
-			qca_memdump->current_seq_no = seq_no + 1;
-			qca_memdump->received_dump += skb->len;
+			hci_devcd_append(hu->hdev, skb);
+			qca_memdump->current_seq_no += 1;
+			qca_memdump->received_dump = rx_size;
 		} else {
 			bt_dev_err(hu->hdev,
-				   "QCA memdump received %d, no space for packet %d",
-				   qca_memdump->received_dump, seq_no);
+				   "QCA memdump received no space for packet %d",
+				    qca_memdump->current_seq_no);
 		}
-		qca->qca_memdump = qca_memdump;
-		kfree_skb(skb);
+
 		if (seq_no == QCA_LAST_SEQUENCE_NUM) {
 			bt_dev_info(hu->hdev,
-				    "QCA memdump Done, received %d, total %d",
-				    qca_memdump->received_dump,
-				    qca_memdump->ram_dump_size);
-			memdump_buf = qca_memdump->memdump_buf_head;
-			dev_coredumpv(&hu->serdev->dev, memdump_buf,
-				      qca_memdump->received_dump, GFP_KERNEL);
+				"QCA memdump Done, received %d, total %d",
+				qca_memdump->received_dump,
+				qca_memdump->ram_dump_size);
+			hci_devcd_complete(hu->hdev);
 			cancel_delayed_work(&qca->ctrl_memdump_timeout);
 			kfree(qca->qca_memdump);
 			qca->qca_memdump = NULL;
@@ -1537,8 +1560,8 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
 	mutex_lock(&qca->hci_memdump_lock);
 	if (qca->memdump_state != QCA_MEMDUMP_COLLECTED) {
 		bt_dev_err(hu->hdev, "clearing allocated memory due to memdump timeout");
+		hci_devcd_abort(hu->hdev);
 		if (qca->qca_memdump) {
-			vfree(qca->qca_memdump->memdump_buf_head);
 			kfree(qca->qca_memdump);
 			qca->qca_memdump = NULL;
 		}
@@ -1577,7 +1600,8 @@ static void qca_cmd_timeout(struct hci_dev *hdev)
 	mutex_lock(&qca->hci_memdump_lock);
 	if (qca->memdump_state != QCA_MEMDUMP_COLLECTED) {
 		qca->memdump_state = QCA_MEMDUMP_TIMEOUT;
-		if (!test_bit(QCA_HW_ERROR_EVENT, &qca->flags)) {
+		if ((!test_bit(QCA_HW_ERROR_EVENT, &qca->flags)) ||
+			(!test_bit(QCA_COREDUMP_TRIGGERED, &qca->flags))) {
 			/* Inject hw error event to reset the device
 			 * and driver.
 			 */
@@ -1702,6 +1726,65 @@ static int qca_power_on(struct hci_dev *hdev)
 	return ret;
 }
 
+static void hci_coredump_qca(struct hci_dev *hdev)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct qca_data *qca = hu->priv;
+	struct sk_buff *skb;
+
+
+	set_bit(QCA_COREDUMP_TRIGGERED, &qca->flags);
+	bt_dev_info(hdev, "Enter mem_dump_status: %d", qca->memdump_state);
+
+	if (qca->memdump_state == QCA_MEMDUMP_IDLE) {
+		/* we need to crash the SOC
+		 * and wait here for 8 seconds to get the dump packets.
+		 * This will block main thread to be on hold until we
+		 * collect dump.
+		 */
+		set_bit(QCA_SSR_TRIGGERED, &qca->flags);
+		set_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
+
+		skb = bt_skb_alloc(QCA_CRASHBYTE_PACKET_LEN, GFP_KERNEL);
+		if (!skb) {
+			bt_dev_err(hu->hdev, "Failed to allocate memory for skb packet");
+			return;
+		}
+
+		/* We forcefully crash the controller, by sending 0xfb byte for
+		 * 1024 times. We also might have chance of losing data, To be
+		 * on safer side we send 1096 bytes to the SoC.
+		 */
+		memset(skb_put(skb, QCA_CRASHBYTE_PACKET_LEN), QCA_MEMDUMP_BYTE,
+			QCA_CRASHBYTE_PACKET_LEN);
+		hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
+		bt_dev_info(hu->hdev, "crash the soc to collect controller dump");
+
+		switch (qca->tx_ibs_state) {
+		case HCI_IBS_TX_WAKING:
+			/* Transient state; just keep packet for later */
+			skb_queue_tail(&qca->tx_wait_q, skb);
+			break;
+		case HCI_IBS_TX_AWAKE:
+			skb_queue_tail(&qca->txq, skb);
+			hci_uart_tx_wakeup(hu);
+			break;
+		case HCI_IBS_TX_ASLEEP:
+			skb_queue_tail(&qca->tx_wait_q, skb);
+			qca->tx_ibs_state = HCI_IBS_TX_WAKING;
+			/* Schedule a work queue to wake up device */
+			queue_work(qca->workqueue, &qca->ws_awake_device);
+			break;
+		}
+	} else if (qca->memdump_state == QCA_MEMDUMP_COLLECTING) {
+		/* Let us wait here until memory dump collected or
+		 * memory dump timer expired.
+		 */
+		bt_dev_info(hdev, "waiting for dump to complete");
+	}
+	clear_bit(QCA_COREDUMP_TRIGGERED, &qca->flags);
+}
+
 static int qca_setup(struct hci_uart *hu)
 {
 	struct hci_dev *hdev = hu->hdev;
@@ -1816,6 +1899,9 @@ static int qca_setup(struct hci_uart *hu)
 		hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
 	else
 		hu->hdev->set_bdaddr = qca_set_bdaddr;
+	qca->fw_version = le16_to_cpu(ver.patch_ver);
+	qca->controller_id = le16_to_cpu(ver.rom_ver);
+	hci_devcd_register(hdev, hci_coredump_qca, qca_dmp_hdr, NULL);
 
 	return ret;
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.

