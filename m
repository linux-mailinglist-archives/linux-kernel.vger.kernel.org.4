Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429F15B6393
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 00:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiILWUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 18:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiILWTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 18:19:22 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F20E4DB67;
        Mon, 12 Sep 2022 15:18:25 -0700 (PDT)
X-UUID: a85cee9482254cd8b60315c3c5f9a0ba-20220913
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5UrAbHpgCgRr/BMzqMY6RYp/4bCIIPFyZ88HxW8C+Rk=;
        b=cJyX2SMDaRUTDVltTj3X0qZahvYks5D7jX8Po6Q9Zwu4dWnuVi5zYo8ZIEzMoQStb19QNk8qNIkZV36KqCLyNANhoXQJuIL9DP4QpJqoiOluaisnLmy7PyKbdvj3YaYjhwdFnfnC9QlnPVz9I7EcuNWAdwdVN8OVpayiIrJ+G6U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:0680100c-a2ff-4540-bda8-2ec949187d2b,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:95
X-CID-INFO: VERSION:1.1.10,REQID:0680100c-a2ff-4540-bda8-2ec949187d2b,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS98
        1B3D,ACTION:quarantine,TS:95
X-CID-META: VersionHash:84eae18,CLOUDID:6d2d635d-5ed4-4e28-8b00-66ed9f042fbd,C
        OID:d13f736b01cd,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: a85cee9482254cd8b60315c3c5f9a0ba-20220913
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1943655605; Tue, 13 Sep 2022 06:18:19 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 13 Sep 2022 06:18:17 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 13 Sep 2022 06:18:17 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <abhishekpandit@google.com>,
        <michaelfsun@google.com>, <abhishekpandit@chromium.org>,
        <mcchou@chromium.org>, <shawnku@google.com>,
        <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jing Cai <jing.cai@mediatek.com>
Subject: [PATCH 2/4] Bluetooth: btmtk: introduce btmtk reset work
Date:   Tue, 13 Sep 2022 06:18:11 +0800
Message-ID: <c27df820bfa97441c83a241f253a2c0e0643e888.1663020936.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <43b68b1f48c20b1dfcd7e6663c3dcb38e4e0648c.1663020936.git.objelf@gmail.com>
References: <43b68b1f48c20b1dfcd7e6663c3dcb38e4e0648c.1663020936.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Cai <jing.cai@mediatek.com>

Introduce btmtk_reset_work which can be called whenever the firmware abort,
HCI command timeout, other fatal error happen.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Jing Cai <jing.cai@mediatek.com>
---
 drivers/bluetooth/btmtk.c |  16 ++++++
 drivers/bluetooth/btmtk.h |  14 +++++
 drivers/bluetooth/btusb.c | 114 ++++++++++++++++++++------------------
 3 files changed, 90 insertions(+), 54 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 809762d64fc6..77df7b5c3ef3 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -53,6 +53,8 @@ struct btmtk_section_map {
 	};
 } __packed;
 
+static struct btmtk_reset_work reset_work;
+
 int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 			      wmt_cmd_sync_func_t wmt_cmd_sync)
 {
@@ -280,6 +282,20 @@ int btmtk_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(btmtk_set_bdaddr);
 
+void btmtk_init_reset_work(struct hci_dev *hdev, work_func_t func)
+{
+	reset_work.hdev = hdev;
+	INIT_WORK(&reset_work.work, func);
+}
+EXPORT_SYMBOL_GPL(btmtk_init_reset_work);
+
+void btmtk_reset_sync(struct hci_dev *hdev)
+{
+	schedule_work(&reset_work.work);
+	flush_work(&reset_work.work);
+}
+EXPORT_SYMBOL_GPL(btmtk_reset_sync);
+
 MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
 MODULE_AUTHOR("Mark Chen <mark-yw.chen@mediatek.com>");
 MODULE_DESCRIPTION("Bluetooth support for MediaTek devices ver " VERSION);
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index 2a88ea8e475e..22d39f637652 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -119,6 +119,11 @@ struct btmtk_hci_wmt_params {
 	u32 *status;
 };
 
+struct btmtk_reset_work {
+	struct hci_dev *hdev;
+	struct work_struct work;
+};
+
 typedef int (*wmt_cmd_sync_func_t)(struct hci_dev *,
 				   struct btmtk_hci_wmt_params *);
 
@@ -131,6 +136,8 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 
 int btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,
 			 wmt_cmd_sync_func_t wmt_cmd_sync);
+void btmtk_init_reset_work(struct hci_dev *hdev, work_func_t func);
+void btmtk_reset_sync(struct hci_dev *hdev);
 #else
 
 static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
@@ -151,4 +158,11 @@ static int btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,
 	return -EOPNOTSUPP;
 }
 
+static void btmtk_init_reset_work(struct hci_dev *hdev, work_func_t func)
+{
+}
+
+static void btmtk_reset_sync(struct hci_dev *hdev)
+{
+}
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4dc9cae3e937..653f57a98233 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2698,6 +2698,63 @@ static u32 btusb_mtk_reset_done(struct hci_dev *hdev)
 	return val;
 }
 
+static void btusb_mtk_reset_work(struct work_struct *work)
+{
+	struct btmtk_reset_work *info = container_of(work,
+						     struct btmtk_reset_work,
+						     work);
+	struct hci_dev *hdev = info->hdev;
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	u32 val;
+	int err;
+
+	/* It's MediaTek specific bluetooth reset mechanism via USB */
+	if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
+		bt_dev_err(hdev, "last reset failed? Not resetting again");
+		return;
+	}
+
+	err = usb_autopm_get_interface(data->intf);
+	if (err < 0)
+		return;
+
+	btusb_stop_traffic(data);
+	usb_kill_anchored_urbs(&data->tx_anchor);
+
+	/* It's Device EndPoint Reset Option Register */
+	bt_dev_dbg(hdev, "Initiating reset mechanism via uhw");
+	btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
+	btusb_mtk_uhw_reg_read(data, MTK_BT_WDT_STATUS, &val);
+
+	/* Reset the bluetooth chip via USB interface. */
+	btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 1);
+	btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
+	btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
+	btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000000FF);
+	btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
+	/* MT7921 need to delay 20ms between toggle reset bit */
+	msleep(20);
+	btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 0);
+	btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
+
+	err = readx_poll_timeout(btusb_mtk_reset_done, hdev, val,
+				 val & MTK_BT_RST_DONE,
+				 100000, 1000000);
+	if (err < 0)
+		bt_dev_err(hdev, "Reset timeout");
+
+	if (val & MTK_BT_RST_DONE)
+		bt_dev_err(hdev, "Bluetooth Reset Successfully");
+
+	btusb_mtk_id_get(data, 0x70010200, &val);
+	if (!val)
+		bt_dev_err(hdev, "Can't get device id, subsys reset fail.");
+
+	usb_queue_reset_device(data->intf);
+
+	clear_bit(BTUSB_HW_RESET_ACTIVE, &data->flags);
+}
+
 static int btusb_mtk_setup(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -2734,6 +2791,8 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 		}
 	}
 
+	btmtk_init_reset_work(hdev, btusb_mtk_reset_work);
+
 	switch (dev_id) {
 	case 0x7663:
 		fwname = FIRMWARE_MT7663;
@@ -2883,59 +2942,6 @@ static int btusb_mtk_shutdown(struct hci_dev *hdev)
 	return 0;
 }
 
-static void btusb_mtk_cmd_timeout(struct hci_dev *hdev)
-{
-	struct btusb_data *data = hci_get_drvdata(hdev);
-	u32 val;
-	int err;
-
-	/* It's MediaTek specific bluetooth reset mechanism via USB */
-	if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
-		bt_dev_err(hdev, "last reset failed? Not resetting again");
-		return;
-	}
-
-	err = usb_autopm_get_interface(data->intf);
-	if (err < 0)
-		return;
-
-	btusb_stop_traffic(data);
-	usb_kill_anchored_urbs(&data->tx_anchor);
-
-	/* It's Device EndPoint Reset Option Register */
-	bt_dev_dbg(hdev, "Initiating reset mechanism via uhw");
-	btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
-	btusb_mtk_uhw_reg_read(data, MTK_BT_WDT_STATUS, &val);
-
-	/* Reset the bluetooth chip via USB interface. */
-	btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 1);
-	btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
-	btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
-	btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000000FF);
-	btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
-	/* MT7921 need to delay 20ms between toggle reset bit */
-	msleep(20);
-	btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 0);
-	btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
-
-	err = readx_poll_timeout(btusb_mtk_reset_done, hdev, val,
-				 val & MTK_BT_RST_DONE,
-				 100000, 1000000);
-	if (err < 0)
-		bt_dev_err(hdev, "Reset timeout");
-
-	if (val & MTK_BT_RST_DONE)
-		bt_dev_dbg(hdev, "Bluetooth Reset Successfully");
-
-	btusb_mtk_id_get(data, 0x70010200, &val);
-	if (!val)
-		bt_dev_err(hdev, "Can't get device id, subsys reset fail.");
-
-	usb_queue_reset_device(data->intf);
-
-	clear_bit(BTUSB_HW_RESET_ACTIVE, &data->flags);
-}
-
 static int btusb_recv_acl_mtk(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -3859,7 +3865,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->setup = btusb_mtk_setup;
 		hdev->shutdown = btusb_mtk_shutdown;
 		hdev->manufacturer = 70;
-		hdev->cmd_timeout = btusb_mtk_cmd_timeout;
+		hdev->cmd_timeout = btmtk_reset_sync;
 		hdev->set_bdaddr = btmtk_set_bdaddr;
 		set_bit(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
-- 
2.25.1

