Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD015EF48F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbiI2Lo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbiI2Lor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:44:47 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D656E326E0;
        Thu, 29 Sep 2022 04:44:42 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28TBi7iQ5024875, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28TBi7iQ5024875
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 29 Sep 2022 19:44:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 19:44:33 +0800
Received: from localhost.localdomain (172.21.132.192) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 29 Sep 2022 19:44:32 +0800
From:   <hildawu@realtek.com>
To:     <marcel@holtmann.org>
CC:     <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <apusaka@chromium.org>, <yinghsu@chromium.org>,
        <max.chou@realtek.com>, <alex_lu@realsil.com.cn>,
        <kidman@realtek.com>
Subject: [PATCH v3 3/3] Bluetooth:btsub:Ignore zero length of USB packets on ALT 6 for specific chip
Date:   Thu, 29 Sep 2022 19:44:26 +0800
Message-ID: <20220929114426.4413-4-hildawu@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929114426.4413-1-hildawu@realtek.com>
References: <20220929114426.4413-1-hildawu@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.132.192]
X-ClientProxiedBy: RTEXH36504.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/29/2022 11:15:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMjkgpFekyCAwODo1NjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hilda Wu <hildawu@realtek.com>

For USB ALT 6 settings some Realtek chips need to transmit mSBC data
continuously without the zero length of USB packets.
In this commit, create BTUSB_ALT6_CONTINUOUS_TX to manage the behavior.
Therefore, create REALTEK_ALT6_CONTINUOUS_TX_CHIP to manage the specific
chip model for the behavior.

Signed-off-by: Max Chou <max.chou@realtek.com>
Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
Changes in V3
 - For ignore_usb_alt6_packet_flow, manage the common flag by the vendor private flag.
---
---
 drivers/bluetooth/btrtl.c |  7 +++++++
 drivers/bluetooth/btusb.c | 25 +++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 272f90621a10..7159427c530e 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -781,6 +781,13 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 	case CHIP_ID_8852C:
 		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
+
+		/* RTL8852C needs to transmit mSBC data continuously without
+		 * the zero length of USB packets for the ALT 6 supported chips
+		 */
+		if (btrtl_dev->project_id == CHIP_ID_8852C)
+			btrealtek_set_flag(hdev, REALTEK_ALT6_CONTINUOUS_TX_CHIP);
+
 		hci_set_aosp_capable(hdev);
 		break;
 	default:
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7583059e3b2c..076cfee1ad57 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -626,6 +626,7 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
 #define BTUSB_TX_WAIT_VND_EVT	13
 #define BTUSB_WAKEUP_AUTOSUSPEND	14
 #define BTUSB_USE_ALT3_FOR_WBS	15
+#define BTUSB_ALT6_CONTINUOUS_TX	16
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -1271,11 +1272,17 @@ static void btusb_isoc_complete(struct urb *urb)
 static inline void __fill_isoc_descriptor_msbc(struct urb *urb, int len,
 					       int mtu, struct btusb_data *data)
 {
-	int i, offset = 0;
+	int i = 0, offset = 0;
 	unsigned int interval;
 
 	BT_DBG("len %d mtu %d", len, mtu);
 
+	/* For mSBC ALT 6 settings some chips need to transmit the data
+	 * continuously without the zero length of USB packets.
+	 */
+	if (test_bit(BTUSB_ALT6_CONTINUOUS_TX, &data->flags))
+		goto ignore_usb_alt6_packet_flow;
+
 	/* For mSBC ALT 6 setting the host will send the packet at continuous
 	 * flow. As per core spec 5, vol 4, part B, table 2.1. For ALT setting
 	 * 6 the HCI PACKET INTERVAL should be 7.5ms for every usb packets.
@@ -1295,6 +1302,7 @@ static inline void __fill_isoc_descriptor_msbc(struct urb *urb, int len,
 		urb->iso_frame_desc[i].length = offset;
 	}
 
+ignore_usb_alt6_packet_flow:
 	if (len && i < BTUSB_MAX_ISOC_FRAMES) {
 		urb->iso_frame_desc[i].offset = offset;
 		urb->iso_frame_desc[i].length = len;
@@ -2381,6 +2389,19 @@ static int btusb_recv_isoc_realtek(struct btusb_data *data, void *buffer,
 	return err;
 }
 
+static int btusb_setup_realtek(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	int ret;
+
+	ret = btrtl_setup_realtek(hdev);
+
+	if (btrealtek_test_flag(data->hdev, REALTEK_ALT6_CONTINUOUS_TX_CHIP))
+		set_bit(BTUSB_ALT6_CONTINUOUS_TX, &data->flags);
+
+	return ret;
+}
+
 /* UHW CR mapping */
 #define MTK_BT_MISC		0x70002510
 #define MTK_BT_SUBSYS_RST	0x70002610
@@ -3983,7 +4004,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_RTL) &&
 	    (id->driver_info & BTUSB_REALTEK)) {
-		hdev->setup = btrtl_setup_realtek;
+		hdev->setup = btusb_setup_realtek;
 		hdev->shutdown = btrtl_shutdown_realtek;
 		hdev->cmd_timeout = btusb_rtl_cmd_timeout;
 
-- 
2.17.1

