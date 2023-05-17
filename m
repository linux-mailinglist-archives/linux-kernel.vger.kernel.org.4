Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7BC70658C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjEQKos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjEQKoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:44:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B7097;
        Wed, 17 May 2023 03:44:44 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34H96Cq4010037;
        Wed, 17 May 2023 10:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=bFnCwGczl3OS9F2aTvxsraVLaxiRaaqktdcvI5Dvz6k=;
 b=IaiQAFS5WVtG8L5SpXbnC8Wo/6e5vo7FHIYRlyY3Q7X8W20+thJwUAzdUrso5+GRUR3J
 g3sHywdbIctw1wU+zDcxCvm+6hdxpBTlek/yZazsQfvIANa0E+gbFNZg99e1ALLXIpyQ
 p9cTe/GuDka7Nl2JkHhypNlWUdq6DJrJWsGgDY495gJjgpJTbtZg4ypZhFDd5mgZUJP5
 SiAa5Xqxvj3pw81yDaSvh4d3Y9npc9B0dKJv0uT4dNpVyA9wkbQ+DR3cKo2UZz1Te+Lz
 MltSbsBCx/CvxrRuljeapwbS3zUg//mUwwxKtAuRizXXtHS73XiO3km7/9uQcFeJ6kLJ bg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qme0m9smd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 10:44:40 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34HAidNJ017404
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 10:44:39 GMT
Received: from tjiang-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 17 May 2023 03:44:37 -0700
From:   Tim Jiang <quic_tjiang@quicinc.com>
To:     <marcel@holtmann.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_tjiang@quicinc.com>,
        <quic_bgodavar@quicinc.com>, <quic_hemantg@quicinc.com>,
        <mka@chromium.org>
Subject: [PATCH v4] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
Date:   Wed, 17 May 2023 18:44:26 +0800
Message-ID: <20230517104426.14055-1-quic_tjiang@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BAI6Bd6tcv-bgQq4KRgoXT3dOAmqXYVZ
X-Proofpoint-ORIG-GUID: BAI6Bd6tcv-bgQq4KRgoXT3dOAmqXYVZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170087
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for QCA2066 firmware patch and nvm downloading.

Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
---
 drivers/bluetooth/btqca.c   | 76 ++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btqca.h   |  4 ++
 drivers/bluetooth/hci_qca.c |  8 +++-
 3 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index fd0941fe8608..9bb0ba6fe00d 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -205,6 +205,48 @@ static int qca_send_reset(struct hci_dev *hdev)
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
+		bt_dev_err(hdev, "Reading QCA board ID failed (%d)", err);
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
+		bt_dev_err(hdev, "QCA Wrong packet: %d %d", edl->cresp, edl->rtype);
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
@@ -574,6 +616,29 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
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
+	if ((ver.soc_id & 0x0000ff00) == QCA_HSP_GF_SOC_ID)  /* hsp gf chip */
+		variant = "g";
+	else
+		variant = "";
+
+	if (bid == 0x0)
+		snprintf(fwname, max_size, "qca/hpnv%02x%s.bin", rom_ver, variant);
+	else
+		snprintf(fwname, max_size, "qca/hpnv%02x%s.%x", rom_ver, variant, bid);
+
+	bt_dev_info(hdev, "%s: nvm name is %s", __func__, fwname);
+}
+
 int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		   enum qca_btsoc_type soc_type, struct qca_btsoc_version ver,
 		   const char *firmware_name)
@@ -582,6 +647,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	int err;
 	u8 rom_ver = 0;
 	u32 soc_ver;
+	u16 boardid = 0;
 
 	bt_dev_dbg(hdev, "QCA setup on UART");
 
@@ -604,6 +670,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	if (qca_is_wcn399x(soc_type)) {
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/crbtfw%02x.tlv", rom_ver);
+	} else if (soc_type == QCA_QCA2066) {
+		snprintf(config.fwname, sizeof(config.fwname),
+			 "qca/hpbtfw%02x.tlv", rom_ver);
 	} else if (soc_type == QCA_QCA6390) {
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/htbtfw%02x.tlv", rom_ver);
@@ -631,6 +700,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	/* Give the controller some time to get ready to receive the NVM */
 	msleep(10);
 
+	if (soc_type == QCA_QCA2066)
+		qca_read_fw_board_id(hdev, &boardid);
+
 	/* Download NVM configuration */
 	config.type = TLV_TYPE_NVM;
 	if (firmware_name)
@@ -644,7 +716,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/crnv%02x.bin", rom_ver);
 		}
-	}
+	} else if (soc_type == QCA_QCA2066)
+		qca_generate_nvm_name(hdev, config.fwname, sizeof(config.fwname),
+				ver, boardid);
 	else if (soc_type == QCA_QCA6390)
 		snprintf(config.fwname, sizeof(config.fwname),
 			 "qca/htnv%02x.bin", rom_ver);
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index b884095bcd9d..7c9b3464ae4a 100644
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
@@ -48,6 +49,8 @@
 
 #define QCA_FW_BUILD_VER_LEN		255
 
+#define QCA_HSP_GF_SOC_ID		0x1200
+
 
 enum qca_baudrate {
 	QCA_BAUDRATE_115200 	= 0,
@@ -145,6 +148,7 @@ enum qca_btsoc_type {
 	QCA_WCN3990,
 	QCA_WCN3998,
 	QCA_WCN3991,
+	QCA_QCA2066,
 	QCA_QCA6390,
 	QCA_WCN6750,
 	QCA_WCN6855,
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 1b064504b388..c7b8e1c630b4 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1729,7 +1729,7 @@ static int qca_setup(struct hci_uart *hu)
 	bt_dev_info(hdev, "setting up %s",
 		qca_is_wcn399x(soc_type) ? "wcn399x" :
 		(soc_type == QCA_WCN6750) ? "wcn6750" :
-		(soc_type == QCA_WCN6855) ? "wcn6855" : "ROME/QCA6390");
+		(soc_type == QCA_WCN6855) ? "wcn6855" : "ROME/QCA6390/QCA2066");
 
 	qca->memdump_state = QCA_MEMDUMP_IDLE;
 
@@ -1874,6 +1874,11 @@ static const struct qca_device_data qca_soc_data_qca6390 __maybe_unused = {
 	.num_vregs = 0,
 };
 
+static const struct qca_device_data qca_soc_data_qca2066 __maybe_unused = {
+	.soc_type = QCA_QCA2066,
+	.num_vregs = 0,
+};
+
 static const struct qca_device_data qca_soc_data_wcn6750 __maybe_unused = {
 	.soc_type = QCA_WCN6750,
 	.vregs = (struct qca_vreg []) {
@@ -2364,6 +2369,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
 	{ .compatible = "qcom,wcn3998-bt", .data = &qca_soc_data_wcn3998},
 	{ .compatible = "qcom,wcn6750-bt", .data = &qca_soc_data_wcn6750},
 	{ .compatible = "qcom,wcn6855-bt", .data = &qca_soc_data_wcn6855},
+	{ .compatible = "qcom,qca2066-bt", .data = &qca_soc_data_qca2066},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);
-- 
2.17.1

