Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067ED5B6B53
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiIMKDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiIMKDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:03:07 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A7E936DF9;
        Tue, 13 Sep 2022 03:03:04 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28DA2VGM0014166, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28DA2VGM0014166
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 13 Sep 2022 18:02:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 18:02:51 +0800
Received: from localhost.localdomain (172.21.132.192) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 13 Sep 2022 18:02:50 +0800
From:   <hildawu@realtek.com>
To:     <marcel@holtmann.org>
CC:     <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <apusaka@chromium.org>, <yinghsu@chromium.org>,
        <max.chou@realtek.com>, <alex_lu@realsil.com.cn>,
        <kidman@realtek.com>
Subject: [PATCH v2 3/3] Bluetooth: btsub: Ignore zero length of USB packets on ALT 6 for the specific chip model of Realtek devices
Date:   Tue, 13 Sep 2022 18:02:44 +0800
Message-ID: <20220913100244.23660-4-hildawu@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220913100244.23660-1-hildawu@realtek.com>
References: <20220913100244.23660-1-hildawu@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/13/2022 08:01:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMTMgpFekyCAwNzozMzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hilda Wu <hildawu@realtek.com>

For USB ALT 6 settings some Realtek chips need to transmit mSBC data
continuously without the zero length of USB packets.
In this commit, create BTUSB_ALT6_CONTINUOUS_TX to manage the workaround.
Therefore, create REALTEK_ALT6_CONTINUOUS_TX_CHIP to manage the specific
chip model for the workaround.

Signed-off-by: Max Chou <max.chou@realtek.com>
Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
 drivers/bluetooth/btrtl.c |  7 +++++++
 drivers/bluetooth/btusb.c | 14 +++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 15223b3ed94d..6d74175cd25f 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -782,6 +782,13 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 		btrealtek_set_flag(hdev, REALTEK_WBS_FILTER);
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
index 8e595e03655a..50a21061350e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -626,6 +626,7 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
 #define BTUSB_TX_WAIT_VND_EVT	13
 #define BTUSB_WAKEUP_AUTOSUSPEND	14
 #define BTUSB_USE_ALT3_FOR_WBS	15
+#define BTUSB_ALT6_CONTINUOUS_TX	16
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -1284,11 +1285,18 @@ static void btusb_isoc_complete(struct urb *urb)
 static inline void __fill_isoc_descriptor_msbc(struct urb *urb, int len,
 					       int mtu, struct btusb_data *data)
 {
-	int i, offset = 0;
+	int i = 0, offset = 0;
 	unsigned int interval;
 
 	BT_DBG("len %d mtu %d", len, mtu);
 
+	/* For mSBC ALT 6 settings some Realtek chips need to transmit the data
+	 * continuously without the zero length of USB packets.
+	 */
+	if (test_bit(BTUSB_ALT6_CONTINUOUS_TX, &data->flags))
+		if (btrealtek_test_flag(data->hdev, REALTEK_ALT6_CONTINUOUS_TX_CHIP))
+			goto ignore_usb_alt6_packet_flow;
+
 	/* For mSBC ALT 6 setting the host will send the packet at continuous
 	 * flow. As per core spec 5, vol 4, part B, table 2.1. For ALT setting
 	 * 6 the HCI PACKET INTERVAL should be 7.5ms for every usb packets.
@@ -1308,6 +1316,7 @@ static inline void __fill_isoc_descriptor_msbc(struct urb *urb, int len,
 		urb->iso_frame_desc[i].length = offset;
 	}
 
+ignore_usb_alt6_packet_flow:
 	if (len && i < BTUSB_MAX_ISOC_FRAMES) {
 		urb->iso_frame_desc[i].offset = offset;
 		urb->iso_frame_desc[i].length = len;
@@ -3931,6 +3940,9 @@ static int btusb_probe(struct usb_interface *intf,
 		/* Realtek devices need to set remote wakeup on auto-suspend */
 		set_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags);
 		set_bit(BTUSB_USE_ALT3_FOR_WBS, &data->flags);
+
+		/* Some Realtek devices need to transmit mSBC data continuously */
+		set_bit(BTUSB_ALT6_CONTINUOUS_TX, &data->flags);
 	}
 
 	if (!reset)
-- 
2.17.1

