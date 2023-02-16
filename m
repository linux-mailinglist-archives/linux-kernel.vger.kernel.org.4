Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA59698FB0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjBPJXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjBPJW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:22:57 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FD5D52F;
        Thu, 16 Feb 2023 01:22:54 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31G8k0Sh025049;
        Thu, 16 Feb 2023 09:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Uw6y4Tiszdo9IA/xgxbWf35WsvJ/trEzxswrco1Bwss=;
 b=jPg5Z1zEDhGmC7E3MAvx4sOAjjdUH24xn6FLegNzEsu+vs9jaRE8gOg8tFZeLtJ8GW2w
 ZHokIy6W1Ejbd+tNDaaSF/pWr4XTNkWoQr6+Mo0zryHleRheG38hhlo2zqvLPPir6HmK
 c7oq8qElF6xootfqXnw62lu3Qk8n8paTJcq5PMfHsSvsOg76rQCk7M+fRPQ8Gz1vMShE
 6X2cKeZxiTwG1wXG/hWXKcYukdxSea0yNSe2YYg+isFUHE5MQpGt2n6FwrRDL1HQcZKQ
 1tyedqKnkMg+jRnBd4ijJYa0qFZ03v4dpU9KqW/jMpHDtkcxeJsVwql5w6Qlwx9al/2N Rg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nrtmukh3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 09:22:50 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31G9MnEt015708
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 09:22:49 GMT
Received: from tjiang-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 16 Feb 2023 01:22:46 -0800
From:   Tim Jiang <quic_tjiang@quicinc.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_tjiang@quicinc.com>,
        <quic_bgodavar@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_hemantg@quicinc.com>, <mka@chromium.org>
Subject: [PATCH v2] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
Date:   Thu, 16 Feb 2023 17:22:36 +0800
Message-ID: <20230216092236.26720-1-quic_tjiang@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hjq1mjaQ_ZeoUex4eB8chaOBdNoXXWZI
X-Proofpoint-GUID: hjq1mjaQ_ZeoUex4eB8chaOBdNoXXWZI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_06,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for QCA2066 firmware patch and nvm downloading.

Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
---
 drivers/bluetooth/btqca.c   | 78 +++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btqca.h   |  2 +
 drivers/bluetooth/hci_qca.c |  6 +++
 3 files changed, 86 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index c9064d34d830..e1127532c5a8 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -205,6 +205,50 @@ static int qca_send_reset(struct hci_dev *hdev)
 	return 0;
 }
 
+static int qca_read_fw_board_id(struct hci_dev *hdev, u16 *bid)
+{
+	u8 cmd;
+	struct sk_buff *skb;
+	struct edl_event_hdr *edl;
+	int err = 0;
+	int bid_len;
+
+	bt_dev_dbg(hdev, "QCA read board ID");
+
+	cmd = EDL_GET_BID_REQ_CMD;
+	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, EDL_PATCH_CMD_LEN,
+				&cmd, 0, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "Reading QCA board ID failed (%d)",
+			   err);
+		return err;
+	}
+
+	edl = skb_pull_data(skb, sizeof(*edl));
+	if (!edl) {
+		bt_dev_err(hdev, "QCA read board ID with no header");
+		err = -EILSEQ;
+		goto out;
+	}
+
+	if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
+	    edl->rtype != EDL_GET_BID_REQ_CMD) {
+		bt_dev_err(hdev, "QCA Wrong packet received %d %d", edl->cresp,
+			   edl->rtype);
+		err = -EIO;
+		goto out;
+	}
+
+	bid_len = edl->data[0];
+	*bid = (edl->data[1] << 8) + edl->data[2];
+	bt_dev_info(hdev, "%s: bid len = %x, bid = %x", __func__, bid_len, *bid);
+
+out:
+	kfree_skb(skb);
+	return err;
+}
+
 int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -574,6 +618,31 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
 
+static void qca_generate_nvm_name(struct hci_dev *hdev, char *fwname,
+		   size_t max_size, struct qca_btsoc_version ver, u16 bid)
+{
+	u8 rom_ver = 0;
+	u32 soc_ver;
+	const char *variant;
+
+	soc_ver = get_soc_ver(ver.soc_id, ver.rom_ver);
+	rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
+
+	if ((ver.soc_id & 0x0000ff00) == 0x1200) /*hsp gf chip*/
+		variant = "g";
+	else
+		variant = "";
+
+	if (bid == 0x0) {
+		snprintf(fwname, max_size, "qca/hpnv%02x%s.bin", rom_ver, variant);
+	} else {
+		snprintf(fwname, max_size, "qca/hpnv%02x%s.%x",
+			rom_ver, variant, bid);
+	}
+
+	bt_dev_info(hdev, "%s: nvm name is %s", __func__, fwname);
+}
+
 int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		   enum qca_btsoc_type soc_type, struct qca_btsoc_version ver,
 		   const char *firmware_name)
@@ -582,6 +651,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	int err;
 	u8 rom_ver = 0;
 	u32 soc_ver;
+	u16 bid = 0;
 
 	bt_dev_dbg(hdev, "QCA setup on UART");
 
@@ -607,6 +677,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	} else if (soc_type == QCA_QCA6390) {
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/htbtfw%02x.tlv", rom_ver);
+	} else if (soc_type == QCA_QCA2066) {
+		snprintf(config.fwname, sizeof(config.fwname),
+			 "qca/hpbtfw%02x.tlv", rom_ver);
 	} else if (soc_type == QCA_WCN6750) {
 		/* Choose mbn file by default.If mbn file is not found
 		 * then choose tlv file
@@ -628,6 +701,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	/* Give the controller some time to get ready to receive the NVM */
 	msleep(10);
 
+	if (soc_type == QCA_QCA2066)
+		qca_read_fw_board_id(hdev, &bid);
+
 	/* Download NVM configuration */
 	config.type = TLV_TYPE_NVM;
 	if (firmware_name)
@@ -645,6 +721,8 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	else if (soc_type == QCA_QCA6390)
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/htnv%02x.bin", rom_ver);
+	else if (soc_type == QCA_QCA2066)
+		qca_generate_nvm_name(hdev, config.fwname, sizeof(config.fwname), ver, bid);
 	else if (soc_type == QCA_WCN6750)
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/msnv%02x.bin", rom_ver);
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 61e9a50e66ae..e762c403284a 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -13,6 +13,7 @@
 #define EDL_PATCH_TLV_REQ_CMD		(0x1E)
 #define EDL_GET_BUILD_INFO_CMD		(0x20)
 #define EDL_NVM_ACCESS_SET_REQ_CMD	(0x01)
+#define EDL_GET_BID_REQ_CMD		(0x23)
 #define EDL_PATCH_CONFIG_CMD		(0x28)
 #define MAX_SIZE_PER_TLV_SEGMENT	(243)
 #define QCA_PRE_SHUTDOWN_CMD		(0xFC08)
@@ -147,6 +148,7 @@ enum qca_btsoc_type {
 	QCA_WCN3991,
 	QCA_QCA6390,
 	QCA_WCN6750,
+	QCA_QCA2066,
 };
 
 #if IS_ENABLED(CONFIG_BT_QCA)
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 3df8c3606e93..84769089ddff 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1866,6 +1866,11 @@ static const struct qca_device_data qca_soc_data_qca6390 = {
 	.num_vregs = 0,
 };
 
+static const struct qca_device_data qca_soc_data_qca2066 = {
+	.soc_type = QCA_QCA2066,
+	.num_vregs = 0,
+};
+
 static const struct qca_device_data qca_soc_data_wcn6750 = {
 	.soc_type = QCA_WCN6750,
 	.vregs = (struct qca_vreg []) {
@@ -2335,6 +2340,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
 	{ .compatible = "qcom,wcn3991-bt", .data = &qca_soc_data_wcn3991},
 	{ .compatible = "qcom,wcn3998-bt", .data = &qca_soc_data_wcn3998},
 	{ .compatible = "qcom,wcn6750-bt", .data = &qca_soc_data_wcn6750},
+	{ .compatible = "qcom,qca2066-bt", .data = &qca_soc_data_qca2066},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

