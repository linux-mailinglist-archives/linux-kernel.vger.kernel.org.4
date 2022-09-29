Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961F85EF48C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbiI2Lox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbiI2Lor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:44:47 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9DE532DA6;
        Thu, 29 Sep 2022 04:44:42 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28TBi7Ek9024871, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28TBi7Ek9024871
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 29 Sep 2022 19:44:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 29 Sep 2022 19:44:33 +0800
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
Subject: [PATCH v3 2/3] Bluetooth: btusb: Workaround for spotty SCO quality
Date:   Thu, 29 Sep 2022 19:44:25 +0800
Message-ID: <20220929114426.4413-3-hildawu@realtek.com>
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
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
Changes in v3:
 - Use the vendor function to replace btus_recv_isoc
 - Additional info: The comparison of btrtl_usb_recv_isoc here is for invalid handle,
   the invalid handle shouldn't appear. So we try to find out the rule and filter out this.

Changes in v2:
 - Seperate commits for functions
---
---
 drivers/bluetooth/btrtl.c | 27 ++++++++++++++
 drivers/bluetooth/btrtl.h |  8 ++++
 drivers/bluetooth/btusb.c | 77 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index fb52313a1d45..272f90621a10 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -937,6 +937,33 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
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
index ebf0101c959b..c9783e8fe0aa 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -83,6 +83,8 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 			    struct btrtl_device_info *btrtl_dev,
 			    unsigned int *controller_baudrate,
 			    u32 *device_baudrate, bool *flow_control);
+int btrtl_usb_recv_isoc(u16 pos, u8 *data, u8 *buffer, int len,
+				u16 wMaxPacketSize);
 
 #else
 
@@ -126,4 +128,10 @@ static inline int btrtl_get_uart_settings(struct hci_dev *hdev,
 	return -ENOENT;
 }
 
+static inline int btrtl_usb_recv_isoc(u16 pos, u8 *data, u8 *buffer, int len,
+				u16 wMaxPacketSize)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4c3aed89ff05..7583059e3b2c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -683,6 +683,7 @@ struct btusb_data {
 	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
 	int (*recv_acl)(struct hci_dev *hdev, struct sk_buff *skb);
 	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
+	int (*recv_isoc)(struct btusb_data *data, void *buffer, int count);
 
 	int (*setup_on_usb)(struct hci_dev *hdev);
 
@@ -1239,7 +1240,7 @@ static void btusb_isoc_complete(struct urb *urb)
 
 			hdev->stat.byte_rx += length;
 
-			if (btusb_recv_isoc(data, urb->transfer_buffer + offset,
+			if (data->recv_isoc(data, urb->transfer_buffer + offset,
 					    length) < 0) {
 				bt_dev_err(hdev, "corrupted SCO packet");
 				hdev->stat.err_rx++;
@@ -2309,6 +2310,77 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 	return -EILSEQ;
 }
 
+static int btusb_recv_isoc_realtek(struct btusb_data *data, void *buffer,
+				   int count)
+{
+	struct sk_buff *skb;
+	unsigned long flags;
+	int err = 0;
+	u16 wMaxPacketSize = le16_to_cpu(data->isoc_rx_ep->wMaxPacketSize);
+
+	spin_lock_irqsave(&data->rxlock, flags);
+	skb = data->sco_skb;
+
+	while (count) {
+		int len;
+
+		if (!skb) {
+			skb = bt_skb_alloc(HCI_MAX_SCO_SIZE, GFP_ATOMIC);
+			if (!skb) {
+				err = -ENOMEM;
+				break;
+			}
+
+			hci_skb_pkt_type(skb) = HCI_SCODATA_PKT;
+			hci_skb_expect(skb) = HCI_SCO_HDR_SIZE;
+		}
+
+		len = min_t(uint, hci_skb_expect(skb), count);
+
+		/* Gaps in audio could be heard while streaming WBS using USB
+		 * alt settings 3 on some platforms, since this is only used
+		 * with RTK chips so let vendor function detect it.
+		 */
+		if (!btusb_find_altsetting(data, 6) &&
+			test_bit(BTUSB_USE_ALT3_FOR_WBS, &data->flags)) {
+			err = btrtl_usb_recv_isoc(skb->len, skb->data, buffer,
+							len, wMaxPacketSize);
+			if (err)
+				break;
+		}
+
+		skb_put_data(skb, buffer, len);
+
+		count -= len;
+		buffer += len;
+		hci_skb_expect(skb) -= len;
+
+		if (skb->len == HCI_SCO_HDR_SIZE) {
+			/* Complete SCO header */
+			hci_skb_expect(skb) = hci_sco_hdr(skb)->dlen;
+
+			if (skb_tailroom(skb) < hci_skb_expect(skb)) {
+				kfree_skb(skb);
+				skb = NULL;
+
+				err = -EILSEQ;
+				break;
+			}
+		}
+
+		if (!hci_skb_expect(skb)) {
+			/* Complete frame */
+			hci_recv_frame(data->hdev, skb);
+			skb = NULL;
+		}
+	}
+
+	data->sco_skb = skb;
+	spin_unlock_irqrestore(&data->rxlock, flags);
+
+	return err;
+}
+
 /* UHW CR mapping */
 #define MTK_BT_MISC		0x70002510
 #define MTK_BT_SUBSYS_RST	0x70002610
@@ -3741,6 +3813,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	data->recv_event = hci_recv_frame;
 	data->recv_bulk = btusb_recv_bulk;
+	data->recv_isoc = btusb_recv_isoc;
 
 	if (id->driver_info & BTUSB_INTEL_COMBINED) {
 		/* Allocate extra space for Intel device */
@@ -3914,6 +3987,8 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->shutdown = btrtl_shutdown_realtek;
 		hdev->cmd_timeout = btusb_rtl_cmd_timeout;
 
+		data->recv_isoc = btusb_recv_isoc_realtek;
+
 		/* Realtek devices need to set remote wakeup on auto-suspend */
 		set_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags);
 		set_bit(BTUSB_USE_ALT3_FOR_WBS, &data->flags);
-- 
2.17.1

