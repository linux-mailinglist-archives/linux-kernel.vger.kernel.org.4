Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C6B5B6B56
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiIMKDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiIMKDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:03:22 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 457535E642;
        Tue, 13 Sep 2022 03:03:15 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28DA2UUB0014153, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28DA2UUB0014153
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 13 Sep 2022 18:02:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 13 Sep 2022 18:02:51 +0800
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
Subject: [PATCH v2 2/3] Bluetooth: btusb: Workaround for spotty SCO quality
Date:   Tue, 13 Sep 2022 18:02:43 +0800
Message-ID: <20220913100244.23660-3-hildawu@realtek.com>
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
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hilda Wu <hildawu@realtek.com>

When streaming HFP, once a few minutes a brief pause in audio can be
heard on some platform with Realtek Bluetooth. When the issue occurs,
the system will see the SCO packet for unknown connection handle messages.

Note: This issue affects (e)SCO only, does not affect ACLs.
Because the duplicate packet causing the problem only occurs in Realtek BT.
This is to filter out duplicate packet for avoiding influence.

Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
Changes in v2:
 - Seperate commits for functions
---
---
 drivers/bluetooth/btrtl.c | 28 ++++++++++++++++++++++++++++
 drivers/bluetooth/btrtl.h |  8 ++++++++
 drivers/bluetooth/btusb.c | 14 ++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index fb52313a1d45..15223b3ed94d 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -781,6 +781,7 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 	case CHIP_ID_8852C:
 		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
+		btrealtek_set_flag(hdev, REALTEK_WBS_FILTER);
 		hci_set_aosp_capable(hdev);
 		break;
 	default:
@@ -937,6 +938,33 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btrtl_get_uart_settings);
 
+int btrtl_usb_recv_isoc(u16 pos, u8 *data, u8 *p, int len,
+			u16 wMaxPacketSize)
+{
+	u8 *prev;
+
+	if (pos >= HCI_SCO_HDR_SIZE && pos >= wMaxPacketSize &&
+	    len == wMaxPacketSize && !(pos % wMaxPacketSize) &&
+	    wMaxPacketSize >= 10 && p[0] == data[0] && p[1] == data[1]) {
+		prev = data + (pos - wMaxPacketSize);
+
+		/* Detect the sco data of usb isoc pkt duplication. */
+		if (!memcmp(p + 2, prev + 2, 8))
+			return -EILSEQ;
+
+		if (wMaxPacketSize >= 12 &&
+		    p[2] == prev[6] && p[3] == prev[7] &&
+		    p[4] == prev[4] && p[5] == prev[5] &&
+		    p[6] == prev[10] && p[7] == prev[11] &&
+		    p[8] == prev[8] && p[9] == prev[9]) {
+			return -EILSEQ;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btrtl_usb_recv_isoc);
+
 MODULE_AUTHOR("Daniel Drake <drake@endlessm.com>");
 MODULE_DESCRIPTION("Bluetooth support for Realtek devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
index e2c99684799a..79e93a8b229f 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -84,6 +84,8 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 			    struct btrtl_device_info *btrtl_dev,
 			    unsigned int *controller_baudrate,
 			    u32 *device_baudrate, bool *flow_control);
+int btrtl_usb_recv_isoc(u16 pos, u8 *data, u8 *buffer, int len,
+				u16 wMaxPacketSize);
 
 #else
 
@@ -127,4 +129,10 @@ static inline int btrtl_get_uart_settings(struct hci_dev *hdev,
 	return -ENOENT;
 }
 
+static inline int btrtl_usb_recv_isoc(u16 pos, u8 *data, u8 *buffer, int len,
+				  u16 wMaxPacketSize)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4c3aed89ff05..8e595e03655a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -961,6 +961,7 @@ static int btusb_recv_isoc(struct btusb_data *data, void *buffer, int count)
 	struct sk_buff *skb;
 	unsigned long flags;
 	int err = 0;
+	u16 wMaxPacketSize = le16_to_cpu(data->isoc_rx_ep->wMaxPacketSize);
 
 	spin_lock_irqsave(&data->rxlock, flags);
 	skb = data->sco_skb;
@@ -980,6 +981,19 @@ static int btusb_recv_isoc(struct btusb_data *data, void *buffer, int count)
 		}
 
 		len = min_t(uint, hci_skb_expect(skb), count);
+
+		/* Gaps in audio could be heard while streaming WBS using USB
+		 * alt settings 3 on some platforms, since this is only used
+		 * with RTK chips so let vendor function detect it.
+		 */
+		if (test_bit(BTUSB_USE_ALT3_FOR_WBS, &data->flags) &&
+			btrealtek_test_flag(data->hdev, REALTEK_WBS_FILTER)) {
+			err = btrtl_usb_recv_isoc(skb->len, skb->data, buffer,
+							len, wMaxPacketSize);
+			if (err)
+				break;
+		}
+
 		skb_put_data(skb, buffer, len);
 
 		count -= len;
-- 
2.17.1

