Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8B76CAA29
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjC0QPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjC0QPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:15:12 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5367E5246;
        Mon, 27 Mar 2023 09:15:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5bqP+7Hp7qcQBOvqw/+bXSksavmWvD7OykdBWM6+fXeWSCFjS3VWHRhI4Yqobm93tKt53nuMnqedBQdfSya8ra5eFb9JDnw+hOv4Ywzwq3XMndZxVkdOF6GE4VD//Bo8Xx2pmMl1k0TElQgyH2ean6bnsebU1yA+6DF2vzD+qIeMhXQonSxV/Lx0y/9YUWEZj+sce/fwflDPKJMcRs9kqluoXx4iTAqQE8Ll0LbPtLzchHmVxzE1wbeqQRroMw00/y5WWP3Ubl9N/O7U89+BO0pq8SISzYuTcXr/eGTo5EHuzkOvy8+J6litIyC2FNLADaVOY1/Q1dmX5DDkftR6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLsLPKrGk0efVof63lORao+ddVgbM0BT5KK4O8/DcmA=;
 b=OtyjUDRZ7XbTB8I4shogpFx0YqLZHwx5pFADLrkTaey3jxIkFEx6TRtwBQk8ohpdpeyCGZXQ+HwFTEg5sLH59lK2App0jUTdmL0+2IUjiLNrVOBcozl/71RnYYn2qTafA3R8GJZsctzHAGyM+d210s+TGpPcKYlY8b5MoG7fNkuOc0m7nGDsFd/YLbl8pzGb5M+S4I5/U46xvMup0YQgJqez/Gs5xYfsQNIC5eMrS4/b9oxD3WRvhlAPXQ8h9Pb6rMTSYitMTLyeFl2qkF4zBTrJjFISLNOVGFhI0h9ERFHhjFS323RabFalY+iVTiBuUH1sPNdsNouLaClkgrLRNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLsLPKrGk0efVof63lORao+ddVgbM0BT5KK4O8/DcmA=;
 b=PfOBDuDSbCpIZqMVc834LPcnkf7dNx8dfXwznOYbxkWk1mv0VQgslSFsV3LwckJD+nQWJpJyBoitPwdgyrUws5uNwTMoASCbYxHZXTa2KRifsww5c6octuaLz2OrTSYlZLRZ+AQZGa1b03Qhs42VNrhLC8sbs1Yn7U6ZCK+8pY4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by DU2PR04MB8885.eurprd04.prod.outlook.com (2603:10a6:10:2e0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 16:14:57 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::45d2:ce51:a1c4:8762]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::45d2:ce51:a1c4:8762%5]) with mapi id 15.20.6222.028; Mon, 27 Mar 2023
 16:14:57 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
        neeraj.sanjaykale@nxp.com
Subject: [PATCH v1] Bluetooth: NXP: Add support to download helper FW file for w8997
Date:   Mon, 27 Mar 2023 21:44:24 +0530
Message-Id: <20230327161424.727785-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0059.eurprd03.prod.outlook.com (2603:10a6:208::36)
 To AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|DU2PR04MB8885:EE_
X-MS-Office365-Filtering-Correlation-Id: 95453c8d-4686-42f4-debc-08db2ede682b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QP9/w6nU+u1gat+o/CQJT/SVtwKTI7L5Wm2S1uuuziuRpKXpyx2sexCnMqfal8l/NAgi2fsnRJxNpWxP3RDYidh1PCIXh0pzoNkgc/t92AnkXtqz6betpIT0cR3A8dxzmY5eTvsnkhEaSyu0DEp8DotSoBFL4f4XIYpuXiIq+0CpU0S7l6JirGN8WkqMdWehZdzbQsRVAIoqo1SngiCs+gEtAJc2IFuf0S6lPrqb1+kpcz8LlngHne8hUcwV1bE5ybB+krCz52a3mIJa81urjCprlbQsaSUneD/Tk1OOLg+H1LWCeulrBuQquVAb13cUyuOBvWirgeb6ma+/sw+cez+KYQxPhS5DJnskBoWX3nbhunFOsI4mDYUNtWWoMQsW7lB3jntmp81LbZgQKQdlBiD3kkjGm533/fSATjC1NYf66SaeytV6EwRi5AsaWJwcp9Hkn/Dxn1ckU2IzpKqmeU2GuUgL/AB8kZP+DIAtmBamGyYDP6Oqk0qiD09QoHRhcEwLMGq4NhzndBqNYPIoH559ybbcRIu1xgoXfyTBWb9XfwqIICfqwWEMcKbkpVptbLpJFO6eiqR/qOf5EWHcpBNNABKqR9QN/lG09IJ93lccA4jpyMs4Hcu2lTluiA5u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199021)(478600001)(8676002)(66476007)(4326008)(66556008)(66946007)(316002)(41300700001)(8936002)(5660300002)(186003)(83380400001)(2616005)(1076003)(26005)(52116002)(6486002)(6666004)(6512007)(6506007)(86362001)(38100700002)(38350700002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RlaH1b3ymYPqYfQfEimDw/SiY7GV/RgB7Rl0F6X0V2J+JAr6TTGmNA0XB9/Z?=
 =?us-ascii?Q?fa7JQWrMKCCsCW8j1QtT2BGbVHy5DNAymBoWxwjxpr7sigUWuujuIsm9tYuT?=
 =?us-ascii?Q?0rsiAuJh54QAZEw1T7T9FFc5lhS3i1eWBx6Vpohm7sKswfD+102xh22gRvdI?=
 =?us-ascii?Q?RGWBmjIYpnq8rEytXU7+4yfZxjzaUNhZO5t4NeS5z12o9qTzuCv4HAD6d8GF?=
 =?us-ascii?Q?yW39zEVUxXK66Y63ZputFyCDlxWQ3mgvNa/VMdWwm/k0mwoWEqo9P8Uqo6ML?=
 =?us-ascii?Q?q8gMZu/knlMGoMv5M3b4pZgHw7NEmJQ8hz+XEV8V0L4yvA9znsD7MemRKeH3?=
 =?us-ascii?Q?8N8QhpnXDGexSi/IqVQWr+5BLSaCbqgkRVdfihTbH9/EHpHC4UqZBHt9GbHd?=
 =?us-ascii?Q?8seow9Nk/NNApKdaS1LlkWvaTGHvau8//7unlyDHsYAXIL/3AthShOxIRZHm?=
 =?us-ascii?Q?IwD+UbfYiklRFrnqSwuItv7EeVj6Cnz4sN00LRypNLDJwxZ1suHpVE0K7tOA?=
 =?us-ascii?Q?LsY3NMztIxa4Si05/U17p4pZXxwLfCfD0gRjLmwua9W6Et34gyytJNmGVtaz?=
 =?us-ascii?Q?FWkMHg2FmgxtXKAnKphPVOG9JytSqeMth+bNe8SUOzgLo2Ssx3Ei0BMTDLAd?=
 =?us-ascii?Q?OvvYU76IRI/noheHhAH0Xvo32EZ6I/gZ2yH2B9V7Hb5xLq847ZEejzbd1AP4?=
 =?us-ascii?Q?CRv00N5N8jYCj3XCZZVIvn9Hbjw6ya1BMsgPPBDMSfW0yY/gpqsjRkgdRBCJ?=
 =?us-ascii?Q?0KjnPbyLXiNQHkLB+eO0dJv0Q5HQHcdEA/LAhHKJ8RBP5ToNxaABdlhaPC3s?=
 =?us-ascii?Q?FG/xbkahiUDoj7lBzjIA/iED5Zn5eF2C62KJH0MitkzHxGKFGgIU1GBISCgH?=
 =?us-ascii?Q?n4gJ0kCDatYPX9BEMEQtl8OdrVWztC/Sw9pBj2JTfkcj4wzr/tvtbFKzpMU7?=
 =?us-ascii?Q?GfnJqVN3RS19ovlj296pOmVQmQ0gHZinpJxXYBQKyzHZAyJqYZvjj6Ea79e9?=
 =?us-ascii?Q?poVLoUFEqjhVMHLyN2cWuEsFUfRxmhuYI1zUVLNaVqedYEavWdCHnhNbR9tg?=
 =?us-ascii?Q?sZ9CCBMn4yd7X5/3vMLOYQCoVsQYerMEwgR2RpgQJoQJ62XXtvJ2JFYjK0oP?=
 =?us-ascii?Q?wQkER0qDjM1Z8ngxMoADiHVcfu/MHbtQeCoIE2e+vcch3hei9LRlohfi7vB4?=
 =?us-ascii?Q?/S7bIWbWuVJVGT2eDnKDvBhywaKYgqLns4flaE7hXu2aJl3PkfpyuLDl79/S?=
 =?us-ascii?Q?PLKzKMPhvAZk+tZSLhljURIJo3Wnw8BE88f0Ns9ad0zcN4fAb6Tz1cnRINfw?=
 =?us-ascii?Q?LuQYS+sZr5JZaBycumyjdw/sz98JC1WNPMt0dP7IS6qniL11kxFXBR8cVN3u?=
 =?us-ascii?Q?nKTKDDze4EoAGDUss/GYM4eq7FCYa9QARGBXlVrp2Leyk1VZ+QzJgOIfUNGz?=
 =?us-ascii?Q?wxa7g88CpBwyiAdxkiWtNX/7cNChA2ixMm+ELh5Q+c22Le8tsDGhu4nHG30t?=
 =?us-ascii?Q?f8JqupkSQ7KyoyDidn/usvpUD0W/vjMvKZy1WBzf+uXnHaIvIqct9weuzbOp?=
 =?us-ascii?Q?cE+8I+Xp8F4slF+Ov1cE77lKrM2P1/mL6k+NlUBNxWtLV4OXtdvUwe+YNVHL?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95453c8d-4686-42f4-debc-08db2ede682b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 16:14:57.2001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c6mZo4tysK4viyBpR/zjTAreGmS+BsDA2W5Dw91toLXw2rUlnpq7H3ClTAB/RIH4kcrBEfQtO2BUWu08xCo37UAoJCgs0XM1NjAagmIu1B0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8885
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support to download helper FW file for the legacy
NXP chipset 88w8997 for the btnxpuart driver.
This helper FW file is necessary to set the bootloader baudrate
to 3000000 after which the actual BT FW file can be downloaded.
This change helps bring the FW download time from around 10 sec
to less than 2 sec for 88w8997 chip.
For newer chipsets, both V1 and V3 bootloader, driver sends the
cmd5 and cmd7 to the chip bootloader, and does not need a helper
FW file.
This also adds a call to ps_wakeup() before closing the serdev
device, to de-assert UART break. On lpuart platforms if the UART
port is closed while break is asserted, tx_empty is never set, and
waits for 30 second timeout before lpuart32_shutdown is called.
This resulted in 'hciconfig hci0 down' command to take 30 seconds
to execute.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 69 +++++++++++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 5f641466d695..590c85f49dd7 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -34,6 +34,7 @@
 #define FIRMWARE_W9098	"nxp/uartuart9098_bt_v1.bin"
 #define FIRMWARE_IW416	"nxp/uartiw416_bt_v0.bin"
 #define FIRMWARE_IW612	"nxp/uartspi_n61x_v1.bin.se"
+#define FIRMWARE_HELPER	"nxp/helper_uart_3000000.bin"
 
 #define CHIP_ID_W9098		0x5c03
 #define CHIP_ID_IW416		0x7201
@@ -123,7 +124,7 @@ struct psmode_cmd_payload {
 } __packed;
 
 struct btnxpuart_data {
-	bool fw_download_3M_baudrate;
+	const char *helper_fw_name;
 	const char *fw_name;
 };
 
@@ -150,6 +151,7 @@ struct btnxpuart_dev {
 	u32 fw_init_baudrate;
 	bool timeout_changed;
 	bool baudrate_changed;
+	bool helper_downloaded;
 
 	struct ps_data psdata;
 	struct btnxpuart_data *nxp_data;
@@ -168,6 +170,13 @@ struct btnxpuart_dev {
 
 #define HDR_LEN			16
 
+#define NXP_RECV_CHIP_VER_V1 \
+	.type = NXP_V1_CHIP_VER_PKT, \
+	.hlen = 4, \
+	.loff = 0, \
+	.lsize = 0, \
+	.maxlen = 4
+
 #define NXP_RECV_FW_REQ_V1 \
 	.type = NXP_V1_FW_REQ_PKT, \
 	.hlen = 4, \
@@ -194,6 +203,11 @@ struct v1_data_req {
 	__le16 len_comp;
 } __packed;
 
+struct v1_start_ind {
+	__le16 chip_id;
+	__le16 chip_id_comp;
+} __packed;
+
 struct v3_data_req {
 	__le16 len;
 	__le32 offset;
@@ -518,6 +532,7 @@ static int nxp_download_firmware(struct hci_dev *hdev)
 	nxpdev->fw_v3_offset_correction = 0;
 	nxpdev->baudrate_changed = false;
 	nxpdev->timeout_changed = false;
+	nxpdev->helper_downloaded = false;
 
 	serdev_device_set_baudrate(nxpdev->serdev, HCI_NXP_PRI_BAUDRATE);
 	serdev_device_set_flow_control(nxpdev->serdev, 0);
@@ -664,6 +679,29 @@ static int nxp_request_firmware(struct hci_dev *hdev, const char *fw_name)
 }
 
 /* for legacy chipsets with V1 bootloader */
+static int nxp_recv_chip_ver_v1(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct v1_start_ind *req;
+
+	req = (struct v1_start_ind *)skb_pull_data(skb, sizeof(struct v1_start_ind));
+	if (!req)
+		goto free_skb;
+
+	if ((req->chip_id ^ req->chip_id_comp) == 0xffff) {
+		nxpdev->fw_dnld_v1_offset = 0;
+		nxpdev->fw_v1_sent_bytes = 0;
+		nxpdev->fw_v1_expected_len = HDR_LEN;
+		release_firmware(nxpdev->fw);
+		memset(nxpdev->fw_name, 0, sizeof(nxpdev->fw_name));
+		nxp_send_ack(NXP_ACK_V1, hdev);
+	}
+
+free_skb:
+	kfree_skb(skb);
+	return 0;
+}
+
 static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
@@ -685,7 +723,7 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 	nxp_send_ack(NXP_ACK_V1, hdev);
 
-	if (nxp_data->fw_download_3M_baudrate) {
+	if (!nxp_data->helper_fw_name) {
 		if (!nxpdev->timeout_changed) {
 			nxpdev->timeout_changed = nxp_fw_change_timeout(hdev, req->len);
 			goto free_skb;
@@ -702,14 +740,26 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 		}
 	}
 
-	if (nxp_request_firmware(hdev, nxp_data->fw_name))
-		goto free_skb;
+	if (!nxp_data->helper_fw_name || nxpdev->helper_downloaded) {
+		if (nxp_request_firmware(hdev, nxp_data->fw_name))
+			goto free_skb;
+	} else if (nxp_data->helper_fw_name && !nxpdev->helper_downloaded) {
+		if (nxp_request_firmware(hdev, nxp_data->helper_fw_name))
+			goto free_skb;
+	}
 
 	requested_len = req->len;
 	if (requested_len == 0) {
 		bt_dev_dbg(hdev, "FW Downloaded Successfully: %zu bytes", nxpdev->fw->size);
-		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
-		wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
+		if (nxp_data->helper_fw_name && !nxpdev->helper_downloaded) {
+			nxpdev->helper_downloaded = true;
+			serdev_device_wait_until_sent(nxpdev->serdev, 0);
+			serdev_device_set_baudrate(nxpdev->serdev, HCI_NXP_SEC_BAUDRATE);
+			serdev_device_set_flow_control(nxpdev->serdev, 1);
+		} else {
+			clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
+			wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
+		}
 		goto free_skb;
 	}
 	if (requested_len & 0x01) {
@@ -1117,6 +1167,7 @@ static int btnxpuart_close(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 
+	ps_wakeup(nxpdev);
 	serdev_device_close(nxpdev->serdev);
 	clear_bit(BTNXPUART_SERDEV_OPEN, &nxpdev->tx_state);
 	return 0;
@@ -1142,6 +1193,7 @@ static const struct h4_recv_pkt nxp_recv_pkts[] = {
 	{ H4_RECV_ACL,          .recv = hci_recv_frame },
 	{ H4_RECV_SCO,          .recv = hci_recv_frame },
 	{ H4_RECV_EVENT,        .recv = hci_recv_frame },
+	{ NXP_RECV_CHIP_VER_V1, .recv = nxp_recv_chip_ver_v1 },
 	{ NXP_RECV_FW_REQ_V1,   .recv = nxp_recv_fw_req_v1 },
 	{ NXP_RECV_CHIP_VER_V3, .recv = nxp_recv_chip_ver_v3 },
 	{ NXP_RECV_FW_REQ_V3,   .recv = nxp_recv_fw_req_v3 },
@@ -1150,6 +1202,7 @@ static const struct h4_recv_pkt nxp_recv_pkts[] = {
 static bool is_valid_bootloader_signature(const u8 *data, size_t count)
 {
 	if ((*data == NXP_V1_FW_REQ_PKT && count == sizeof(struct v1_data_req) + 1) ||
+	    (*data == NXP_V1_CHIP_VER_PKT && count == sizeof(struct v1_start_ind) + 1) ||
 	    (*data == NXP_V3_FW_REQ_PKT && count == sizeof(struct v3_data_req) + 1) ||
 	    (*data == NXP_V3_CHIP_VER_PKT && count == sizeof(struct v3_start_ind) + 1))
 		return true;
@@ -1265,12 +1318,12 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 }
 
 static struct btnxpuart_data w8987_data = {
-	.fw_download_3M_baudrate = true,
+	.helper_fw_name = NULL,
 	.fw_name = FIRMWARE_W8987,
 };
 
 static struct btnxpuart_data w8997_data = {
-	.fw_download_3M_baudrate = false,
+	.helper_fw_name = FIRMWARE_HELPER,
 	.fw_name = FIRMWARE_W8997,
 };
 
-- 
2.34.1

