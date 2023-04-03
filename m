Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A1A6D4454
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjDCMZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDCMZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:25:20 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2055.outbound.protection.outlook.com [40.107.249.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA33D30CF;
        Mon,  3 Apr 2023 05:25:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bz5ZoitwuhqiADPQ7B7asny5vfxdW4pmIBkNP3xWQGBZsa2YJW24C37n4hB+es8tpl7SKCXbvOSxmH+1H9UxcSPw9xDG8T5T5N+c6jGol3lBuvwkAg6MMaOw6ub6ToCBYJesxs9cuU5ECswv3Ix9y4YwZkm5/w1lmgcpwm9hoo+Fay42ALMpnlmSPWsXnU0TO0I1nZPJnCBuxJ7SrtpociUsWxvF8KyJbkVCLLzOroVmyABM/RYkq7ywFqUD9HM856tJII9GyVDM3JLnBCTeZjANuiPWw+k2vVR/DZK+wZcst6N//iZzL7gT5tFJ0XwP0VQ2dZCocfeSL+0UnjStOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlKHR3B1mazWpCapi8kEX/Wwve2n+p4h9LL0XslDVks=;
 b=R56JMNX9Ma+3CWvk81iZlHsF6AixyGgeA3nUlT2qZB23OwGPKtNaIOuxMt7fpYP3gQxK6PHXP1EXWn3YG2AkQ5aSVGdDXtsovqruaG1Phz76ZesaVk7pN9QTvyHWxRwM6lYuXfb3T/6uDJX19o6ac4GLXosVm5jLGpMJ6/27K+3SpTvZvSBxkt1Si9fNqmPJ/NrwRESQv4dPr8sL2fodIriqdYoxdfJBOTu1mHr9XJT2v/3AqCeRymOoWBt4NZWIF0XPQv2YBA25W1qatP329D4Ev/hu8Cle9OfccFOdZ9Rt+HP54neNAwJaAGjyhjfv0QkwOOg4GrbAxdzcuLtr3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlKHR3B1mazWpCapi8kEX/Wwve2n+p4h9LL0XslDVks=;
 b=Z7d2+Tmb9Yc8ozyLphbHKR84j2U2+RY5iXV+Dp/dIsTLYkjIgy+31NCG6VXewjr/GtKzMA04YVTR+b7927kJ0jVyLb78l8hChzrJC+vPASMdNQPz1UuH4/nCmAPYmgexNl3vy4Xj0NX3GUOy9jB+sKFqkcv9frh1OVZx4GtVSG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by AS4PR04MB9690.eurprd04.prod.outlook.com (2603:10a6:20b:4fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 12:25:15 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::1013:5b17:fe68:d06b]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::1013:5b17:fe68:d06b%8]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 12:25:15 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
        neeraj.sanjaykale@nxp.com
Subject: [PATCH v1] Bluetooth: btnxpuart: Add support to download helper FW file for w8997
Date:   Mon,  3 Apr 2023 17:54:27 +0530
Message-Id: <20230403122430.1024235-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0015.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::20) To AM9PR04MB8603.eurprd04.prod.outlook.com
 (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|AS4PR04MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2dbd42-200e-40ba-57db-08db343e7a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WQvGlRYkC0Qphz6yqHN7Up2rSwayVwwfIZY7W5VlGpjarJOPa4edS4MqJ6fEM66hSUmaqyvPQAsiBDtkccNS6gln2Y2qAYlDbPNPHUaDxQuJonGeUMHlgqvOuYDp7xWSoCQrU4dztz86nVMkJ/dFPEcJC9NFQAoXScEEBgvLSOUX2VTZ3H4ACKWdjH9yYzrw1gCWDAdJ1QzIwguOB8fI4kYuH+ZK/CbNSqPzNBokBJKK7h+ciZgUDlJsLl3nNgxTWIg2RznRol5eD/aGVjU05fsktN/0TxFmCdfrEh0NkkPoKb+AfkVAxp/AQV2YYizMPLNPB+Nkzwm7oz+s6Q8Jw5qQ/9kAUWR4VyVN66/O4O492sWDvm5EQ5uabZR7QFHXO/aovS8jCgb9cva4q56Rrzv0eiqYnM/vroUVhTe6tbOdH1k34G11Vlbi8oJUmTo+A420hhFGxb603zPPGw9s9XtmFXrg7B4iz5g8nPVE49SfzmiT/JaHIH0tQhA0wSw1565pcCPiO8p/ZECeR20R48nXLx8nvQ27lJVldTUsj4ZsRpGr6BbYE21piUrzm/IicKbmHUdyCBQ8/V5x+29Nx+gAVh1/PFAPq5sLEO45nbmxEWNITlYQSu20xZ0pkgKz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(8676002)(66476007)(66556008)(478600001)(8936002)(66946007)(41300700001)(5660300002)(316002)(186003)(6512007)(6486002)(4326008)(26005)(1076003)(6506007)(2906002)(83380400001)(2616005)(38100700002)(38350700002)(86362001)(36756003)(52116002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D8ygd/w1U2HTQ3glWJezcXqem15d282uRdVN24kqI3F7W30oug3AoDutBJTr?=
 =?us-ascii?Q?AfBWZUt4CI6Mm5pAlTrlTEx4EA88YIubgQjJmv35MRKsBMq9pylqxwGyO2iZ?=
 =?us-ascii?Q?wy7l2Wy/7WVixT0LZIHAm6Gf9m31WyMleQ2f4PjK+fP+QUXzP+Wh7zZl89LE?=
 =?us-ascii?Q?roDsw5LpLfgcTdgjkOGwOLRrFcgvJHgCzfE0bCFX46boUGIdCKBfMGHT2kec?=
 =?us-ascii?Q?XbjNxCMXUMejUXsbvwdZ7smVFza8XpRBBAHkehYGCFx91QNDyZnXFKWxQqDt?=
 =?us-ascii?Q?rJ+kOME8xUFgFbES+SfDQXZc9dwPJzVheCzEbZWXiYJ+12V/zPi9mVzR7Pkx?=
 =?us-ascii?Q?AGl3KEQ/TbtkfUBSoedvag5TdLPrPdZGEM96L9gNVWgrRYa9AC7YJipGBljQ?=
 =?us-ascii?Q?V7kNAvV1JK1y4DtTpIaVqJA2XkbnqaVrKbja41Sln2ojviaraKNbH1Vif6dp?=
 =?us-ascii?Q?93ing4Rr73WXV4Ht2bhLjxSqGqDNhFD/J8uGSp/dkqsVUjhD/w9nFHD6ELW6?=
 =?us-ascii?Q?MVVZYCSepK7zhQR/TpGpt8GyJCMKg8rAa6yskBETUFXnPtUxQyJjUamoF6e3?=
 =?us-ascii?Q?b7ThSLebnKNKOaJfv4Q49U0I3mm+yrxEE/ZmM8knrh4DHXfaaTxjhGtVe9/f?=
 =?us-ascii?Q?WInWx9ab6Uv0hgn/huQ3Zpglnhe4vrnJtyIEtFU8sFUhYKkkBMCwa4sY5eID?=
 =?us-ascii?Q?hg6Zy9RxRz/CN+/fEMsyintxSNycL/2cjSWpJSo1C6VdfOw+RhNoZ7KmartS?=
 =?us-ascii?Q?hIq8sbyvDSpeyftaRFdXMrHxjle9+tgL8XfskUNnGkaZtZs45/cbLUt41pR/?=
 =?us-ascii?Q?GkWACtbirsyHv1yQw9r62YEtGcM9awxoFxg2BHLdO3m38/IIPIgjcss7YfFL?=
 =?us-ascii?Q?tMXQGojEk0inZ54UzjmXOpEJXc9oFpJMYzQNMxhEzNJsWJOa5HQH/jAT/ymw?=
 =?us-ascii?Q?jJNvfK2OJrq1J1ZiakCaZ9q0idOoBnhiAw78UvMFLg9dz/85B/2Z8cjEIPm0?=
 =?us-ascii?Q?0pK/w3GGWiVXPcytwrUg02lgsrMIEVbyZFIrXXWCAOtzHQG/VkfEgMetDan8?=
 =?us-ascii?Q?WlnuW/GO60No4tHsK5wAuoCSnbzB88cg396Uovnd2s+T20255APaEnhkaxDP?=
 =?us-ascii?Q?POHeifQ0CbEQm2/oAIEU/L/GVVzm/I3S9vuUAuK8RPWX6RV6S03vX7CNIu8O?=
 =?us-ascii?Q?7yk0YZ0Va0gTLsjMTu4Tu2cC/C7ydiOZL9cSRg9Px65WRARybbaWOH7a45DK?=
 =?us-ascii?Q?vWUns3oM00NxgwPVGSVn91vOQP/mh1AOCXYEEZVFHtyMPPtbrDh59z4Jpii2?=
 =?us-ascii?Q?1ZpXGNm75cLw9lCNvRWOG5JlVDrlO0ENYKILwBKBh3ptr3IVAimulrTSlj2x?=
 =?us-ascii?Q?8OOxLdhUfZ9YHkSmPc8S72FqYIAZC/XDOfPV50AmSPWiCG3Ui1maFb9dppHz?=
 =?us-ascii?Q?2Y5VdEOZ7eEuyIc6kw/X5VfiEplSxD9n3i3y/ae5F+qmtL9n9iY+s/nOhp2s?=
 =?us-ascii?Q?vPS9FFJ+ngsd1LCiP5iTDsttDD3utf9hIXsnTAG4SfEc1LVQVM23IGbSfqzn?=
 =?us-ascii?Q?sCNzJdA2KF1auDiqN3pSRwlPMmu8Q+SQBFKAHxVqikgC1Ob8gbqBtQtIcTzi?=
 =?us-ascii?Q?FQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2dbd42-200e-40ba-57db-08db343e7a7f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 12:25:15.3665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNSP7f1Avf/QVrI5OYFkiGHYKst8nL30AtlEfuJxq9eYhqOPfkNo5PD9gKDM+hwwcPNnQeYz0r33lUOlXlnsh1PD+mX+XspSsHIiCDgUO2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9690
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support to download helper FW file for the legacy NXP chipset
88w8997 for the btnxpuart driver. This helper FW file is necessary to
set the bootloader baudrate to 3000000 after which the actual BT FW file
can be downloaded. This change helps bring the FW download time from
around 10 sec to less than 2 sec for 88w8997 chip. For newer chipsets,
both V1 and V3 bootloader, driver sends the cmd5 and cmd7 to the chip
bootloader, and does not need a helper FW file.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 67 ++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 7c22c1ac087a..34f44da9ef4d 100644
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
@@ -1142,6 +1192,7 @@ static const struct h4_recv_pkt nxp_recv_pkts[] = {
 	{ H4_RECV_ACL,          .recv = hci_recv_frame },
 	{ H4_RECV_SCO,          .recv = hci_recv_frame },
 	{ H4_RECV_EVENT,        .recv = hci_recv_frame },
+	{ NXP_RECV_CHIP_VER_V1, .recv = nxp_recv_chip_ver_v1 },
 	{ NXP_RECV_FW_REQ_V1,   .recv = nxp_recv_fw_req_v1 },
 	{ NXP_RECV_CHIP_VER_V3, .recv = nxp_recv_chip_ver_v3 },
 	{ NXP_RECV_FW_REQ_V3,   .recv = nxp_recv_fw_req_v3 },
@@ -1252,12 +1303,12 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
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

