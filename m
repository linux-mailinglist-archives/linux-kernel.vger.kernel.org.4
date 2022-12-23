Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9479654DED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 09:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbiLWI6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 03:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLWI6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 03:58:04 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DEAD1C10E;
        Fri, 23 Dec 2022 00:58:00 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2BN8uuXB3028589, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2BN8uuXB3028589
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 23 Dec 2022 16:56:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 23 Dec 2022 16:57:49 +0800
Received: from localhost.localdomain (172.21.132.192) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 23 Dec 2022 16:57:47 +0800
From:   <hildawu@realtek.com>
To:     <marcel@holtmann.org>
CC:     <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <apusaka@chromium.org>, <yinghsu@chromium.org>,
        <max.chou@realtek.com>, <alex_lu@realsil.com.cn>,
        <kidman@realtek.com>
Subject: [PATCH v4] Bluetooth: btusb: Work around for spotty SCO quality
Date:   Fri, 23 Dec 2022 16:57:42 +0800
Message-ID: <20221223085742.2482-1-hildawu@realtek.com>
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
X-KSE-Antiphishing-Bases: 12/23/2022 08:41:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEyLzIzIKRXpMggMDQ6MjY6MDA=?=
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

When streaming HFP, every few minutes a brief pause in audio can be
heard on some platforms with Realtek Bluetooth. Linux based products
may be encountered, but because of the different implementation of
upper-level SCO services, the situation would not necessarily impact
customer experience. But when the issue occurs, the system will see
the SCO packet for unknown connection handle messages.

Note: This issue affects (e)SCO only, does not affect ACLs.
The duplicate data affected the invalid connection handle only
occurs in Realtek BT.
This is to filter out the duplicate packet for avoiding influence.

The btmon trace give a better idea of what we're filtering.
The following excerpts are part of SCO packets in the HCI log:

> SCO Data RX: Handle 11 flags 0x00 dlen 72      #23327 [hci0] 132.343418
        8c a3 55 4f 8a d5 56 e9 35 56 37 8d 55 87 53 55  ..UO..V.5V7.U.SU
        59 66 d5 57 1d b5 54 00 01 08 ad 00 00 e0 10 00  Yf.W..T.........
        00 00 85 c6 d5 60 e9 b5 52 94 6d 54 e4 9b 55 b1  .....`..R.mT..U.
        b6 d5 62 91 b5 57 84 6d 56 e4 5b 55 75 c6 d5 51  ..b..W.mV.[Uu..Q
        2d b5 53 9a 6d 54 a5 1b                          -.S.mT..
< SCO Data TX: Handle 11 flags 0x00 dlen 72      #23328 [hci0] 132.343600
        01 c8 ad 00 00 aa db ba aa a9 72 b4 d9 5d af 14  ..........r..]..
        53 0c 75 b0 a6 f3 8a 51 b3 54 17 b1 a6 d5 62 c5  S.u....Q.T....b.
        d5 6b 35 29 8d c5 1c 56 4c 24 96 9b 8d b5 d7 1a  .k5)...VL$......
        b2 8d bc da 3b 8c 46 ae 1d 4d a4 04 01 f8 ad 00  ....;.F..M......
        00 3d ec bb a9 98 8b 28                          .=.....(
> SCO Data RX: Handle 11 flags 0x00 dlen 72      #23329 [hci0] 132.353419
        55 55 c6 d5 62 29 b5 57 b2 6d 54 00 01 38 ad 00  UU..b).W.mT..8..
        00 e0 10 00 00 00 0b 00 d5 62 55 c6 57 b2 29 b5  .........bU.W.).
        00 01 6d 54 00 00 38 ad 00 00 e0 10 00 00 00 92  ..mT..8.........
        36 d5 5a ed b5 58 6c 6d 55 b3 1b 55 6b 26 d5 52  6.Z..XlmU..Uk&.R
        d1 b5 54 23 6d 56 82 db                          ..T#mV..
< SCO Data TX: Handle 11 flags 0x00 dlen 72      #23330 [hci0] 132.353581
        6d 5b be db 89 34 66 e9 fa 99 a6 6e e5 6d 9f 1a  m[...4f....n.m..
        1c 57 d2 66 92 63 98 99 a9 3b 8a 6c 3e 5b 5a 34  .W.f.c...;.l>[Z4
        a4 96 e2 21 21 8c f8 88 0f 3d e0 52 48 85 18 00  ...!!....=.RH...
        01 08 ad 00 00 0c eb ba a9 a8 28 ca 9a d0 3c 33  ..........(...<3
        45 4a f9 90 fb ca 4b 39                          EJ....K9
> SCO Data RX: Handle 2901 flags 0x0a dlen 54    #23331 [hci0] 132.373416
        d5 48 a9 b5 56 aa 6d 56 d2 db 55 75 36 d5 56 2d  .H..V.mV..Uu6.V-
        b5 57 5b 6d 54 00 0b 00 48 01 c8 ad 00 00 e0 10  .W[mT...H.......
        00 00 00 5e c6 d5 56 e1 b5 56 43 6d 55 ca db 55  ...^..V..VCmU..U
        7d c6 d5 5b 31 b5

We handle is HCI SCO Data RX packets.
The packet 23327 was a normal HCI SCO Data RX packet.
The packet 23329 was the abnormal HCI SCO Data RX packet.
The packet 23331 was the invalid connection handle affected by the
packet 23329 abnormal HCI SCO Data RX packet.

So we expect to filter is the packet 23329 SCO data RX packet case.
As you can see the packet 23329, packet's connection handle (0x0B 00/11)
and length (0x48/72) is normal.
This btmon trace is SCO packets in USB alternate setting 3, payload
length is 72 bytes that is consist of three SCO data packets.
After our investigation, we found that the anomaly is due to the
intermediate composition data.
There is duplicate data in the intermediate composition data, but it
affects packets combination. The system parses the next packet of the
connection handle mistake, so the system see unknown connection
handle messages.

This commit can estimate and find out its abnormal rule to filter the
duplicate packet out for avoiding influence.
Check franments and filtering out the abnormal packet and then it will
not affect the system parsing of the conenction handle subsequent.
This commit can filter out the invalid connection handle, avoid the
spotty SCO quality.

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
Changes in v4:
 - Fix typos and add more in commit description.
 - Modify comparison method.

Changes in v3:
 - Use the vendor function to replace btus_recv_isoc
 - Additional info: The comparison of btrtl_usb_recv_isoc here is
   for invalid handle, the invalid handle shouldn't appear.
   So we try to find out the rule and filter out this.

Changes in v2:
 - Seperate commits for functions
---
---
 drivers/bluetooth/btrtl.c | 33 ++++++++++++++++
 drivers/bluetooth/btrtl.h |  7 ++++
 drivers/bluetooth/btusb.c | 80 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 69c3fe649ca7..a0a33d2467ef 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -944,6 +944,39 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btrtl_get_uart_settings);
 
+int btrtl_usb_recv_isoc(u16 pos, u8 *data, u8 *p, u16 wMaxPacketSize)
+{
+	u8 *prev;
+	u8 tmp[8];
+	u8 zero[1] = {0};
+	u32 *prev_frag_a;
+	u32 *prev_frag_b;
+
+	/* Issue was found when alt was set to 3 or bigger */
+	if (wMaxPacketSize < 25)
+		return 0;
+
+	/* The first fragment is always correct. */
+	if (pos < wMaxPacketSize)
+		return 0;
+
+	if (memcmp(p, zero, sizeof(zero))) {
+		prev = data + (pos - wMaxPacketSize);
+		memcpy(tmp, prev + 4, 8);
+		prev_frag_a = (u32 *)(tmp);
+		prev_frag_b = (u32 *)(tmp + 4);
+		*prev_frag_a = swahw32(*prev_frag_a);
+		*prev_frag_b = swahw32(*prev_frag_b);
+
+		/* Check the current fragment with the previous one. */
+		if (!memcmp(p, prev, 2) && !memcmp(p + 2, tmp, 8))
+			return -1;
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
index ebf0101c959b..893f1eae57e2 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -83,6 +83,7 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 			    struct btrtl_device_info *btrtl_dev,
 			    unsigned int *controller_baudrate,
 			    u32 *device_baudrate, bool *flow_control);
+int btrtl_usb_recv_isoc(u16 pos, u8 *data, u8 *buffer, u16 wMaxPacketSize);
 
 #else
 
@@ -126,4 +127,10 @@ static inline int btrtl_get_uart_settings(struct hci_dev *hdev,
 	return -ENOENT;
 }
 
+static inline int btrtl_usb_recv_isoc(u16 pos, u8 *data, u8 *buffer,
+					u16 wMaxPacketSize)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index afd2f08ffe30..47e4dcaec948 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -792,6 +792,7 @@ struct btusb_data {
 	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
 	int (*recv_acl)(struct hci_dev *hdev, struct sk_buff *skb);
 	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
+	int (*recv_isoc)(struct btusb_data *data, void *buffer, int count);
 
 	int (*setup_on_usb)(struct hci_dev *hdev);
 
@@ -1394,7 +1395,7 @@ static void btusb_isoc_complete(struct urb *urb)
 
 			hdev->stat.byte_rx += length;
 
-			if (btusb_recv_isoc(data, urb->transfer_buffer + offset,
+			if (data->recv_isoc(data, urb->transfer_buffer + offset,
 					    length) < 0) {
 				bt_dev_err(hdev, "corrupted SCO packet");
 				hdev->stat.err_rx++;
@@ -2492,6 +2493,80 @@ static int btusb_setup_realtek(struct hci_dev *hdev)
 	return ret;
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
+						wMaxPacketSize);
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
+			struct hci_sco_hdr *hdr = hci_sco_hdr(skb);
+
+			hci_skb_expect(skb) = hdr->dlen;
+
+			if (skb_tailroom(skb) < hci_skb_expect(skb) ||
+			    !btusb_validate_sco_handle(data->hdev, hdr)) {
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
@@ -3924,6 +3999,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	data->recv_event = hci_recv_frame;
 	data->recv_bulk = btusb_recv_bulk;
+	data->recv_isoc = btusb_recv_isoc;
 
 	if (id->driver_info & BTUSB_INTEL_COMBINED) {
 		/* Allocate extra space for Intel device */
@@ -4097,6 +4173,8 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->shutdown = btrtl_shutdown_realtek;
 		hdev->cmd_timeout = btusb_rtl_cmd_timeout;
 
+		data->recv_isoc = btusb_recv_isoc_realtek;
+
 		/* Realtek devices need to set remote wakeup on auto-suspend */
 		set_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags);
 		set_bit(BTUSB_USE_ALT3_FOR_WBS, &data->flags);
-- 
2.17.1

