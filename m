Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573A35F54C0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 14:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiJEMt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 08:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiJEMtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 08:49:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 081EF20F78;
        Wed,  5 Oct 2022 05:49:51 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 295CnEVG1014994, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 295CnEVG1014994
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 5 Oct 2022 20:49:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 20:49:41 +0800
Received: from localhost.localdomain (172.21.132.192) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 5 Oct 2022 20:49:40 +0800
From:   <hildawu@realtek.com>
To:     <marcel@holtmann.org>
CC:     <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <apusaka@chromium.org>, <yinghsu@chromium.org>,
        <max.chou@realtek.com>, <alex_lu@realsil.com.cn>,
        <kidman@realtek.com>
Subject: [PATCH v3] Bluetooth: btusb: Workaround for spotty SCO quality
Date:   Wed, 5 Oct 2022 20:49:36 +0800
Message-ID: <20221005124936.2390-1-hildawu@realtek.com>
X-Mailer: git-send-email 2.17.1
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
X-KSE-Antiphishing-Bases: 10/05/2022 12:24:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzUgpFekyCAxMDoyMzowMA==?=
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

When streaming HFP, once a few minutes a brief pause in audio can be
heard on some platform with Realtek Bluetooth. When the issue occurs,
the system will see the SCO packet for unknown connection handle messages.

Note: This issue affects (e)SCO only, does not affect ACLs.
Because the duplicate packet causing the problem only occurs in Realtek BT.
This is to filter out duplicate packet for avoiding influence.

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
The btmon trace should give a better idea of what we're filtering.
The following excerpts are part of SCO packets in the HCI log:

Packet; Timestamp    ; Item             ; Payload;
23327    ;131.399466000; HCI SCO Data IN    ; 0B 00 48 8C A3 55 4F 8A D5 56 E9 35 56 37 8D 55 87 53 55 59 66 D5 57 1D B5 54 00 01 08 AD 00 00 E0 10 00 00 00 85 C6 D5 60 E9 B5 52 94 6D 54 E4 9B 55 B1 B6 D5 62 91 B5 57 84 6D 56 E4 5B 55 75 C6 D5 51 2D B5 53 9A 6D 54 A5 1B;
23328    ; 131.399648000; HCI SCO Data OUT  ; 0B 00 48 01 C8 AD 00 00 AA DB BA AA A9 72 B4 D9 5D AF 14 53 0C 75 B0 A6 F3 8A 51 B3 54 17 B1 A6 D5 62 C5 D5 6B 35 29 8D C5 1C 56 4C 24 96 9B 8D B5 D7 1A B2 8D BC DA 3B 8C 46 AE 1D 4D A4 04 01 F8 AD 00 00 3D EC BB A9 98 8B 28;
23329    ; 131.409467000; HCI SCO Data IN    ; 0B 00 48 55 55 C6 D5 62 29 B5 57 B2 6D 54 00 01 38 AD 00 00 E0 10 00 00 00 0B 00 D5 62 55 C6 57 B2 29 B5 00 01 6D 54 00 00 38 AD 00 00 E0 10 00 00 00 92 36 D5 5A ED B5 58 6C 6D 55 B3 1B 55 6B 26 D5 52 D1 B5 54 23 6D 56 82 DB;
23330    ; 131.409629000; HCI SCO Data OUT  ; 0B 00 48 6D 5B BE DB 89 34 66 E9 FA 99 A6 6E E5 6D 9F 1A 1C 57 D2 66 92 63 98 99 A9 3B 8A 6C 3E 5B 5A 34 A4 96 E2 21 21 8C F8 88 0F 3D E0 52 48 85 18 00 01 08 AD 00 00 0C EB BA A9 A8 28 CA 9A D0 3C 33 45 4A F9 90 FB CA 4B 39;
23331    ; 131.429464000; HCI SCO Data IN    ; 55 AB 36 D5 48 A9 B5 56 AA 6D 56 D2 DB 55 75 36 D5 56 2D B5 57 5B 6D 54 00 0B 00 48 01 C8 AD 00 00 E0 10 00 00 00 5E C6 D5 56 E1 B5 56 43 6D 55 CA DB 55 7D C6 D5 5B 31 B5;

We handle is HCI SCO Data IN packets.
The packet 23327 was a normal HCI SCO Data IN packet.
The packet 23329 was the abnormal HCI SCO Data IN packet.
The packet 23331 was the invalid connection handle affected by the
packet 23329 abnormal HCI SCO Data IN packet.

So we expect to filter is the packet 23329 SCO data IN packet case.
As you can see the packet 23329 packet's connection handle (0x0B 00)
and length (0x48) is normal.
This btmon trace is SCO packets in USB alternate setting 3, payload
length is 72 bytes, so it is consist of three data packets.
After our investigation, we found that the anomaly is due to the
intermediate composition data.
So we estimate and find out its abnormal rule to filter it.
Filtering out the abnormal packet and then it will not affect the
system parsing of the conenction handle subsequent.
Let the invalid connection handle not occur, avoid the spotty SCO
quality.

Changes in v3:
 - Use the vendor function to replace btus_recv_isoc
 - Additional info: The comparison of btrtl_usb_recv_isoc here is
   for invalid handle, the invalid handle shouldn't appear.
   So we try to find out the rule and filter out this.

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
index 2c441bda390a..1a23a99536a0 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -62,6 +62,8 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 			    struct btrtl_device_info *btrtl_dev,
 			    unsigned int *controller_baudrate,
 			    u32 *device_baudrate, bool *flow_control);
+int btrtl_usb_recv_isoc(u16 pos, u8 *data, u8 *buffer, int len,
+				u16 wMaxPacketSize);
 
 #else
 
@@ -105,4 +107,10 @@ static inline int btrtl_get_uart_settings(struct hci_dev *hdev,
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
index 271963805a38..704e38e6d7d1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -689,6 +689,7 @@ struct btusb_data {
 	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
 	int (*recv_acl)(struct hci_dev *hdev, struct sk_buff *skb);
 	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
+	int (*recv_isoc)(struct btusb_data *data, void *buffer, int count);
 
 	int (*setup_on_usb)(struct hci_dev *hdev);
 
@@ -1245,7 +1246,7 @@ static void btusb_isoc_complete(struct urb *urb)
 
 			hdev->stat.byte_rx += length;
 
-			if (btusb_recv_isoc(data, urb->transfer_buffer + offset,
+			if (data->recv_isoc(data, urb->transfer_buffer + offset,
 					    length) < 0) {
 				bt_dev_err(hdev, "corrupted SCO packet");
 				hdev->stat.err_rx++;
@@ -2315,6 +2316,77 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -3747,6 +3819,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	data->recv_event = hci_recv_frame;
 	data->recv_bulk = btusb_recv_bulk;
+	data->recv_isoc = btusb_recv_isoc;
 
 	if (id->driver_info & BTUSB_INTEL_COMBINED) {
 		/* Allocate extra space for Intel device */
@@ -3917,6 +3990,8 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->shutdown = btrtl_shutdown_realtek;
 		hdev->cmd_timeout = btusb_rtl_cmd_timeout;
 
+		data->recv_isoc = btusb_recv_isoc_realtek;
+
 		/* Realtek devices need to set remote wakeup on auto-suspend */
 		set_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags);
 		set_bit(BTUSB_USE_ALT3_FOR_WBS, &data->flags);
-- 
2.17.1

