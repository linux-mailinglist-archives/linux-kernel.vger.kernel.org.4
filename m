Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC55725429
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbjFGG3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbjFGG3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:29:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A44F1BC3;
        Tue,  6 Jun 2023 23:29:29 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3575jtUX013751;
        Wed, 7 Jun 2023 06:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=WOBANkS/yJyX2nh6dwdWmYUzm9+a8g1tU7f1ZDffvsw=;
 b=jzm+VukmJfTm4zHD1dVI7RHMiKlOFi8D1HpjMPZbKmxjItWH/qNJK/YUh+qtl0wsXmX6
 fk6BAaoZKpkAoI1y4LiyLwQ39dGskEMgp8zMI06tA9qR3lLtzzQjs1hSZNl+HcaGP7Xj
 JrtVwrQnpzS08dgBuPuI7Bd7RbzMO+/2xJNL0q+pUNXz5Ns5mPmrqdLEaAr6jFMGI2IQ
 WVTMDmDVoCxiJxmSMJb1iux/6ifYQyWI++1l5mhI/lZrTtXNeO9eXDgmA1jDzdrFVpX0
 DX/lbTQA3RC8IFAtin5u2EQa0LPQ18CNGf8CFzWy/r6wJ7pN/4t+kBvzgHi2ZOjMe8rn 2Q== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a6y941g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 06:29:23 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3576TJsm013460;
        Wed, 7 Jun 2023 06:29:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qyxkm0u5t-1;
        Wed, 07 Jun 2023 06:29:19 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3576TJrc013454;
        Wed, 7 Jun 2023 06:29:19 GMT
Received: from hyd-lablnx377.qualcomm.com (hyd-lablnx377.qualcomm.com [10.204.178.226])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3576TJ1K013453;
        Wed, 07 Jun 2023 06:29:19 +0000
Received: by hyd-lablnx377.qualcomm.com (Postfix, from userid 4035820)
        id A1C4320B89; Wed,  7 Jun 2023 11:59:18 +0530 (IST)
From:   Sai Teja Aluvala <quic_saluvala@quicinc.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        quic_hemantg@quicinc.com, quic_bgodavar@quicinc.com,
        jiangzp@google.com, mmandlik@google.com,
        Sai Teja Aluvala <quic_saluvala@quicinc.com>
Subject: [PATCH v3 2/2] Bluetooth: hci_qca: Add qcom devcoredump support
Date:   Wed,  7 Jun 2023 11:59:16 +0530
Message-Id: <1686119356-10907-1-git-send-email-quic_saluvala@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0J6RwO-LZQkENopLxCbaLSOrjBCLw-yj
X-Proofpoint-ORIG-GUID: 0J6RwO-LZQkENopLxCbaLSOrjBCLw-yj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_04,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070052
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intercept debug exception events from QCA controller and put them into
a devcoredump using hci devcoredump APIs of hci_core

Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>

V2 -> V3:
---------
changed hci_coredump_qca function

V1 -> V2:
---------
Updated to work with the updated HCI devcoredump API.
---
 drivers/bluetooth/hci_qca.c | 135 ++++++++++++++++++++++++++++----------------
 1 file changed, 85 insertions(+), 50 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 1ee5323..87a7325 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -117,9 +117,7 @@ enum qca_memdump_states {
 	QCA_MEMDUMP_TIMEOUT,
 };
 
-struct qca_memdump_data {
-	char *memdump_buf_head;
-	char *memdump_buf_tail;
+struct qca_memdump_info {
 	u32 current_seq_no;
 	u32 received_dump;
 	u32 ram_dump_size;
@@ -160,13 +158,15 @@ struct qca_data {
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
@@ -233,6 +233,7 @@ static void qca_regulator_disable(struct qca_serdev *qcadev);
 static void qca_power_shutdown(struct hci_uart *hu);
 static int qca_power_off(struct hci_dev *hdev);
 static void qca_controller_memdump(struct work_struct *work);
+static void qca_dmp_hdr(struct hci_dev *hdev, struct sk_buff *skb);
 
 static enum qca_btsoc_type qca_soc_type(struct hci_uart *hu)
 {
@@ -980,6 +981,28 @@ static int qca_recv_acl_data(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -987,13 +1010,11 @@ static void qca_controller_memdump(struct work_struct *work)
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
@@ -1009,7 +1030,7 @@ static void qca_controller_memdump(struct work_struct *work)
 		}
 
 		if (!qca_memdump) {
-			qca_memdump = kzalloc(sizeof(struct qca_memdump_data),
+			qca_memdump = kzalloc(sizeof(struct qca_memdump_info),
 					      GFP_ATOMIC);
 			if (!qca_memdump) {
 				mutex_unlock(&qca->hci_memdump_lock);
@@ -1035,44 +1056,49 @@ static void qca_controller_memdump(struct work_struct *work)
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
@@ -1082,8 +1108,8 @@ static void qca_controller_memdump(struct work_struct *work)
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
@@ -1094,43 +1120,38 @@ static void qca_controller_memdump(struct work_struct *work)
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
@@ -1541,8 +1562,8 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
 	mutex_lock(&qca->hci_memdump_lock);
 	if (qca->memdump_state != QCA_MEMDUMP_COLLECTED) {
 		bt_dev_err(hu->hdev, "clearing allocated memory due to memdump timeout");
+		hci_devcd_abort(hu->hdev);
 		if (qca->qca_memdump) {
-			vfree(qca->qca_memdump->memdump_buf_head);
 			kfree(qca->qca_memdump);
 			qca->qca_memdump = NULL;
 		}
@@ -1706,6 +1727,17 @@ static int qca_power_on(struct hci_dev *hdev)
 	return ret;
 }
 
+static void hci_coredump_qca(struct hci_dev *hdev)
+{
+	static const u8 param[] = { 0x26 };
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, 0xfc0c, 1, param, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb))
+		bt_dev_err(hdev, "%s: trigger crash failed (%ld)", __func__, PTR_ERR(skb));
+	kfree_skb(skb);
+}
+
 static int qca_setup(struct hci_uart *hu)
 {
 	struct hci_dev *hdev = hu->hdev;
@@ -1820,6 +1852,9 @@ static int qca_setup(struct hci_uart *hu)
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

