Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EBD5F5116
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 10:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiJEIoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 04:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiJEInt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 04:43:49 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A90375496;
        Wed,  5 Oct 2022 01:43:47 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2958hAGe9023000, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2958hAGe9023000
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 5 Oct 2022 16:43:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 16:43:37 +0800
Received: from localhost.localdomain (172.21.132.192) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 5 Oct 2022 16:43:36 +0800
From:   <hildawu@realtek.com>
To:     <marcel@holtmann.org>
CC:     <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <apusaka@chromium.org>, <yinghsu@chromium.org>,
        <max.chou@realtek.com>, <alex_lu@realsil.com.cn>,
        <kidman@realtek.com>
Subject: [PATCH v4 2/2] Bluetooth: btusb: Ignore zero length of USB packets on ALT 6 for specific chip
Date:   Wed, 5 Oct 2022 16:43:31 +0800
Message-ID: <20221005084331.1001-3-hildawu@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221005084331.1001-1-hildawu@realtek.com>
References: <20221005084331.1001-1-hildawu@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.132.192]
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/05/2022 03:37:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzUgpFekyCAwMjo1OTowMA==?=
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
Changes in v4:
 - Since the original 0002 patch has no dependency with the 0001 patch.
   So let the 0002 patch submit another.

Changes in V3
 - For ignore_usb_alt6_packet_flow, manage the common flag by the vendor
   private flag.
---
---
 drivers/bluetooth/btrtl.c |  7 +++++++
 drivers/bluetooth/btusb.c | 25 +++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index fb52313a1d45..69c3fe649ca7 100644
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
index 4243936c0583..4d787a455c00 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -632,6 +632,7 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
 #define BTUSB_TX_WAIT_VND_EVT	13
 #define BTUSB_WAKEUP_AUTOSUSPEND	14
 #define BTUSB_USE_ALT3_FOR_WBS	15
+#define BTUSB_ALT6_CONTINUOUS_TX	16
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -1276,11 +1277,17 @@ static void btusb_isoc_complete(struct urb *urb)
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
@@ -1300,6 +1307,7 @@ static inline void __fill_isoc_descriptor_msbc(struct urb *urb, int len,
 		urb->iso_frame_desc[i].length = offset;
 	}
 
+ignore_usb_alt6_packet_flow:
 	if (len && i < BTUSB_MAX_ISOC_FRAMES) {
 		urb->iso_frame_desc[i].offset = offset;
 		urb->iso_frame_desc[i].length = len;
@@ -2315,6 +2323,19 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 	return -EILSEQ;
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
@@ -3916,7 +3937,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_RTL) &&
 	    (id->driver_info & BTUSB_REALTEK)) {
-		hdev->setup = btrtl_setup_realtek;
+		hdev->setup = btusb_setup_realtek;
 		hdev->shutdown = btrtl_shutdown_realtek;
 		hdev->cmd_timeout = btusb_rtl_cmd_timeout;
 
-- 
2.17.1

