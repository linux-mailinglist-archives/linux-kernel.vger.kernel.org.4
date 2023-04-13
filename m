Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB196E0733
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 08:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjDMGoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 02:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjDMGoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 02:44:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0B31705;
        Wed, 12 Apr 2023 23:44:01 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33D69pE2018452;
        Thu, 13 Apr 2023 06:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=yRB7cciyRzcz8nkDBjPpG/bkD/w2lbThPBq1TXUWcrM=;
 b=csoeyez8IvOy+pz4dKwQDaPEh4L3aHZSD2zUK1ia7fljLqLG0jrMbh8zX0CKGsOhuQj0
 RpiBWz/wobOgBm06OmjllXmpVB24NWMbXxZXo9/tjA9+0H3CG8hPJOWEs0GNibXrM/sI
 4h2+fE6xBb/S1MBhiZ7yAO1BtZ7sVX5vOw/wneoPKDdRWpeSVdbleLf6d2oq+y6eMHwk
 YxqWTeDDWkUTzwu4vZPLuIKtDJ3MqJF25O4pplqZetIwS3TPD08MKJtU7nrpMpdEmtzF
 PMeZEJxUqbNSIvFMtNtC10778iXYxRnE0zRckGvwgUysLAnyps98s1obgNAhwHFRzdNN wQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pxbx5r32k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 06:43:58 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33D6hvMp013393
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 06:43:57 GMT
Received: from tjiang-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 12 Apr 2023 23:43:54 -0700
From:   Tim Jiang <quic_tjiang@quicinc.com>
To:     <marcel@holtmann.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_tjiang@quicinc.com>,
        <quic_bgodavar@quicinc.com>, <quic_hemantg@quicinc.com>,
        <mka@chromium.org>
Subject: [PATCH v2] Bluetooth: btusb: Add WCN6855 devcoredump support
Date:   Thu, 13 Apr 2023 14:43:44 +0800
Message-ID: <20230413064344.18714-1-quic_tjiang@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2anweT7IPVBhV8oPkgZPqnlv6ETvqEwr
X-Proofpoint-GUID: 2anweT7IPVBhV8oPkgZPqnlv6ETvqEwr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_03,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130060
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WCN6855 will report memdump via ACL data or HCI event when
it get crashed, so we collect memdump to debug firmware.

Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
---
 drivers/bluetooth/btusb.c | 222 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 222 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2303b0a66323..f045bbb0ee09 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -733,6 +733,16 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
 	{}
 };
 
+struct qca_dump_info {
+	/* fields for dump collection */
+	u16 id_vendor;
+	u16 id_product;
+	u32 fw_version;
+	u32 controller_id;
+	u32 ram_dump_size;
+	u16 ram_dump_seqno;
+};
+
 #define BTUSB_MAX_ISOC_FRAMES	10
 
 #define BTUSB_INTR_RUNNING	0
@@ -752,6 +762,7 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
 #define BTUSB_WAKEUP_AUTOSUSPEND	14
 #define BTUSB_USE_ALT3_FOR_WBS	15
 #define BTUSB_ALT6_CONTINUOUS_TX	16
+#define BTUSB_HW_SSR_ACTIVE	17
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -814,6 +825,8 @@ struct btusb_data {
 
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
 	unsigned cmd_timeout_cnt;
+
+	struct qca_dump_info qca_dump;
 };
 
 static void btusb_reset(struct hci_dev *hdev)
@@ -904,6 +917,11 @@ static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct gpio_desc *reset_gpio = data->reset_gpio;
 
+	if (test_bit(BTUSB_HW_SSR_ACTIVE, &data->flags)) {
+		bt_dev_info(hdev, "Ramdump in progress, defer cmd_timeout");
+		return;
+	}
+
 	if (++data->cmd_timeout_cnt < 5)
 		return;
 
@@ -3294,6 +3312,202 @@ static int btusb_set_bdaddr_wcn6855(struct hci_dev *hdev,
 	return 0;
 }
 
+#define QCA_MEMDUMP_ACL_HANDLE 0x2EDD
+#define QCA_MEMDUMP_SIZE_MAX  0x100000
+#define QCA_MEMDUMP_VSE_CLASS 0x01
+#define QCA_MEMDUMP_MSG_TYPE 0x08
+#define QCA_MEMDUMP_PKT_SIZE 248
+#define QCA_LAST_SEQUENCE_NUM 0xffff
+
+struct qca_dump_hdr {
+	u8 vse_class;
+	u8 msg_type;
+	__le16 seqno;
+	u8 reserved;
+	union {
+		u8 data[0];
+		struct {
+			__le32 ram_dump_size;
+			u8 data0[0];
+		} __packed;
+	};
+} __packed;
+
+
+static void btusb_dump_hdr_qca(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	char buf[128];
+	struct btusb_data *btdata = hci_get_drvdata(hdev);
+
+	snprintf(buf, sizeof(buf), "Controller Name: 0x%x\n",
+			btdata->qca_dump.controller_id);
+	skb_put_data(skb, buf, strlen(buf));
+
+	snprintf(buf, sizeof(buf), "Firmware Version: 0x%x\n",
+			btdata->qca_dump.fw_version);
+	skb_put_data(skb, buf, strlen(buf));
+
+	snprintf(buf, sizeof(buf), "Driver: %s\nVendor: qca\n",
+			btusb_driver.name);
+	skb_put_data(skb, buf, strlen(buf));
+
+	snprintf(buf, sizeof(buf), "VID: 0x%x\nPID:0x%x\n",
+			btdata->qca_dump.id_vendor, btdata->qca_dump.id_product);
+	skb_put_data(skb, buf, strlen(buf));
+
+	snprintf(buf, sizeof(buf), "Lmp Subversion: 0x%x\n",
+			hdev->lmp_subver);
+	skb_put_data(skb, buf, strlen(buf));
+}
+
+static void btusb_coredump_qca(struct hci_dev *hdev)
+{
+	static const u8 param[] = { 0x26 };
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, 0xfc0c, 1, param, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb))
+		bt_dev_err(hdev, "%s: triggle crash failed (%ld)", __func__, PTR_ERR(skb));
+	kfree_skb(skb);
+}
+
+/*
+ * ==0: not a dump pkt.
+ * < 0: fails to handle a dump pkt
+ * > 0: otherwise.
+ */
+static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	int ret = 1;
+	u8 pkt_type;
+	u8 *sk_ptr;
+	unsigned int sk_len;
+	u16 seqno;
+	u32 dump_size;
+
+	struct hci_event_hdr *event_hdr;
+	struct hci_acl_hdr *acl_hdr;
+	struct qca_dump_hdr *dump_hdr;
+	struct btusb_data *btdata = hci_get_drvdata(hdev);
+	struct usb_device *udev = btdata->udev;
+
+	pkt_type = hci_skb_pkt_type(skb);
+	sk_ptr = skb->data;
+	sk_len = skb->len;
+
+	if (pkt_type == HCI_ACLDATA_PKT) {
+		acl_hdr = hci_acl_hdr(skb);
+		if (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE)
+			return 0;
+		sk_ptr += HCI_ACL_HDR_SIZE;
+		sk_len -= HCI_ACL_HDR_SIZE;
+		event_hdr = (struct hci_event_hdr *)sk_ptr;
+	} else {
+		event_hdr = hci_event_hdr(skb);
+	}
+
+	if ((event_hdr->evt != HCI_VENDOR_PKT)
+		|| (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
+		return 0;
+
+	sk_ptr += HCI_EVENT_HDR_SIZE;
+	sk_len -= HCI_EVENT_HDR_SIZE;
+
+	dump_hdr = (struct qca_dump_hdr *)sk_ptr;
+	if ((sk_len < offsetof(struct qca_dump_hdr, data))
+		|| (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS)
+	    || (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
+		return 0;
+
+	/*it is dump pkt now*/
+	seqno = le16_to_cpu(dump_hdr->seqno);
+	if (seqno == 0) {
+		set_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
+		dump_size = le32_to_cpu(dump_hdr->ram_dump_size);
+		if (!dump_size || (dump_size > QCA_MEMDUMP_SIZE_MAX)) {
+			ret = -EILSEQ;
+			bt_dev_err(hdev, "Invalid memdump size(%u)",
+				   dump_size);
+			goto out;
+		}
+
+		ret = hci_devcd_init(hdev, dump_size);
+		if (ret < 0) {
+			bt_dev_err(hdev, "memdump init error(%d)", ret);
+			goto out;
+		}
+
+		btdata->qca_dump.ram_dump_size = dump_size;
+		btdata->qca_dump.ram_dump_seqno = 0;
+		sk_ptr += offsetof(struct qca_dump_hdr, data0);
+		sk_len -= offsetof(struct qca_dump_hdr, data0);
+
+		usb_disable_autosuspend(udev);
+		bt_dev_info(hdev, "%s memdump size(%u)\n",
+			    (pkt_type == HCI_ACLDATA_PKT) ? "ACL" : "event",
+			    dump_size);
+	} else {
+		sk_ptr += offsetof(struct qca_dump_hdr, data);
+		sk_len -= offsetof(struct qca_dump_hdr, data);
+	}
+
+	if (!btdata->qca_dump.ram_dump_size) {
+		ret = -EINVAL;
+		bt_dev_err(hdev, "memdump is not active");
+		goto out;
+	}
+
+	if ((seqno > btdata->qca_dump.ram_dump_seqno + 1) && (seqno != QCA_LAST_SEQUENCE_NUM)) {
+		dump_size = QCA_MEMDUMP_PKT_SIZE * (seqno - btdata->qca_dump.ram_dump_seqno - 1);
+		hci_devcd_append_pattern(hdev, 0x0, dump_size);
+		bt_dev_err(hdev,
+			   "expected memdump seqno(%u) is not received(%u)\n",
+			   btdata->qca_dump.ram_dump_seqno, seqno);
+		btdata->qca_dump.ram_dump_seqno = seqno;
+		kfree_skb(skb);
+		return ret;
+	}
+
+	skb_pull(skb, skb->len - sk_len);
+	hci_devcd_append(hdev, skb);
+	btdata->qca_dump.ram_dump_seqno++;
+	if (seqno == QCA_LAST_SEQUENCE_NUM) {
+		bt_dev_info(hdev,
+				"memdump done: pkts(%u), total(%u)\n",
+				btdata->qca_dump.ram_dump_seqno, btdata->qca_dump.ram_dump_size);
+
+		hci_devcd_complete(hdev);
+		goto out;
+	}
+	return ret;
+
+out:
+	if (btdata->qca_dump.ram_dump_size)
+		usb_enable_autosuspend(udev);
+	btdata->qca_dump.ram_dump_size = 0;
+	btdata->qca_dump.ram_dump_seqno = 0;
+	clear_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
+
+	if (ret < 0)
+		kfree_skb(skb);
+	return ret;
+}
+
+static int btusb_recv_acl_qca(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	if (handle_dump_pkt_qca(hdev, skb))
+		return 0;
+	return hci_recv_frame(hdev, skb);
+}
+
+static int btusb_recv_evt_qca(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	if (handle_dump_pkt_qca(hdev, skb))
+		return 0;
+	return hci_recv_frame(hdev, skb);
+}
+
+
 #define QCA_DFU_PACKET_LEN	4096
 
 #define QCA_GET_TARGET_VERSION	0x09
@@ -3628,6 +3842,9 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 	if (err < 0)
 		return err;
 
+	btdata->qca_dump.fw_version = le32_to_cpu(ver.patch_version);
+	btdata->qca_dump.controller_id = le32_to_cpu(ver.rom_version);
+
 	if (!(status & QCA_SYSCFG_UPDATED)) {
 		err = btusb_setup_qca_load_nvm(hdev, &ver, info);
 		if (err < 0)
@@ -4117,6 +4334,11 @@ static int btusb_probe(struct usb_interface *intf,
 	}
 
 	if (id->driver_info & BTUSB_QCA_WCN6855) {
+		data->qca_dump.id_vendor = id->idVendor;
+		data->qca_dump.id_product = id->idProduct;
+		data->recv_event = btusb_recv_evt_qca;
+		data->recv_acl = btusb_recv_acl_qca;
+		hci_devcd_register(hdev, btusb_coredump_qca, btusb_dump_hdr_qca, NULL);
 		data->setup_on_usb = btusb_setup_qca;
 		hdev->shutdown = btusb_shutdown_qca;
 		hdev->set_bdaddr = btusb_set_bdaddr_wcn6855;
-- 
2.17.1

