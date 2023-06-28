Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54CE741C04
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 00:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjF1Wzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 18:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjF1WzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 18:55:12 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF042728;
        Wed, 28 Jun 2023 15:55:09 -0700 (PDT)
X-UUID: d0adca64160611eeb20a276fd37b9834-20230629
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=G5uQCI2w3XuA8f8ZdbTyrJd+anMUIfjm0nhpI2CFW74=;
        b=OPRYKZizGayeAAi0XZKpesNqR+RZfX6OVhtwdbnSdz09T2crXZbJlKB7i5BoIppG9t6GsIQtLoYWnisDLvN8gtb65C4H81gebZTfAyuzEHdXwamXfJNmmF6HZzVcebRgPGVytn8N+9MLFKlnORFEDbfoVaSsLCDZpgb6LL8v1To=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:63e90dd4-721d-47c3-8d0e-5c9aad539ced,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.27,REQID:63e90dd4-721d-47c3-8d0e-5c9aad539ced,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:01c9525,CLOUDID:1ba7a50d-c22b-45ab-8a43-3004e9216b56,B
        ulkID:230629065504FU36365B,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,
        TF_CID_SPAM_SDM,TF_CID_SPAM_ASC
X-UUID: d0adca64160611eeb20a276fd37b9834-20230629
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 244536646; Thu, 29 Jun 2023 06:55:02 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 29 Jun 2023 06:55:00 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 29 Jun 2023 06:55:00 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>
CC:     <sean.wang@mediatek.com>, <chris.lu@mediatek.com>,
        <Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <jenhao.yang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <abhishekpandit@google.com>,
        <michaelfsun@google.com>, <mmandlik@google.com>,
        <abhishekpandit@chromium.org>, <mcchou@chromium.org>,
        <shawnku@google.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jing Cai <jing.cai@mediatek.com>
Subject: [PATCH v8 2/3] Bluetooth: btmtk: introduce btmtk reset work
Date:   Thu, 29 Jun 2023 06:54:56 +0800
Message-ID: <7ede62f5025c67097fae257eea3808bb5b66f473.1687991820.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <80efe66b16d933e3457bd38b1a60a5d51d4dee9e.1687991820.git.objelf@gmail.com>
References: <80efe66b16d933e3457bd38b1a60a5d51d4dee9e.1687991820.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Cai <jing.cai@mediatek.com>

Introduce btmtk_reset_work which can be called whenever the firmware abort,
HCI command timeout, other fatal error happen.

Co-developed-by: Chris Lu <chris.lu@mediatek.com>
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Jing Cai <jing.cai@mediatek.com>
---
v2, v3, v4: rebase onto the latest codebase
v5: reset the device on hdev basis and use hci_cmd_sync_queue to
    schedule reset work
v6 and v7: rebase onto the latest codebase
v8: drop _work suffix
---
 drivers/bluetooth/btmtk.c |  15 ++++
 drivers/bluetooth/btmtk.h |   8 +++
 drivers/bluetooth/btusb.c | 145 +++++++++++++++++++-------------------
 3 files changed, 97 insertions(+), 71 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 8490d59502a5..c83ea3fd524f 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -285,6 +285,21 @@ int btmtk_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(btmtk_set_bdaddr);
 
+void btmtk_reset_sync(struct hci_dev *hdev)
+{
+	struct btmediatek_data *reset_work = hci_get_priv(hdev);
+	int err;
+
+	hci_dev_lock(hdev);
+
+	err = hci_cmd_sync_queue(hdev, reset_work->reset_sync, NULL, NULL);
+	if (err)
+		bt_dev_err(hdev, "failed to reset (%d)", err);
+
+	hci_dev_unlock(hdev);
+}
+EXPORT_SYMBOL_GPL(btmtk_reset_sync);
+
 MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
 MODULE_AUTHOR("Mark Chen <mark-yw.chen@mediatek.com>");
 MODULE_DESCRIPTION("Bluetooth support for MediaTek devices ver " VERSION);
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index fadc1a520652..75d8e71efcd3 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -120,8 +120,11 @@ struct btmtk_hci_wmt_params {
 	u32 *status;
 };
 
+typedef int (*btmtk_reset_sync_func_t)(struct hci_dev *, void *);
+
 struct btmediatek_data {
 	u32 dev_id;
+	btmtk_reset_sync_func_t reset_sync;
 };
 
 typedef int (*wmt_cmd_sync_func_t)(struct hci_dev *,
@@ -136,6 +139,8 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 
 int btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,
 			 wmt_cmd_sync_func_t wmt_cmd_sync);
+
+void btmtk_reset_sync(struct hci_dev *hdev);
 #else
 
 static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
@@ -156,4 +161,7 @@ static int btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,
 	return -EOPNOTSUPP;
 }
 
+static void btmtk_reset_sync(struct hci_dev *hdev)
+{
+}
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4c38d1c0f059..983380c4e609 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3040,6 +3040,78 @@ static u32 btusb_mtk_reset_done(struct hci_dev *hdev)
 	return val & MTK_BT_RST_DONE;
 }
 
+static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct btmediatek_data *mediatek;
+	u32 val;
+	int err;
+
+	/* It's MediaTek specific bluetooth reset mechanism via USB */
+	if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
+		bt_dev_err(hdev, "last reset failed? Not resetting again");
+		return -EBUSY;
+	}
+
+	err = usb_autopm_get_interface(data->intf);
+	if (err < 0)
+		return err;
+
+	btusb_stop_traffic(data);
+	usb_kill_anchored_urbs(&data->tx_anchor);
+	mediatek = hci_get_priv(hdev);
+
+	if (mediatek->dev_id == 0x7925) {
+		btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
+		val |= (1 << 5);
+		btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
+		btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
+		val &= 0xFFFF00FF;
+		val |= (1 << 13);
+		btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
+		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x00010001);
+		btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
+		val |= (1 << 0);
+		btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
+		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
+		btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
+		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000000FF);
+		btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
+		msleep(100);
+	} else {
+		/* It's Device EndPoint Reset Option Register */
+		bt_dev_dbg(hdev, "Initiating reset mechanism via uhw");
+		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
+		btusb_mtk_uhw_reg_read(data, MTK_BT_WDT_STATUS, &val);
+
+		/* Reset the bluetooth chip via USB interface. */
+		btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 1);
+		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
+		btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
+		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000000FF);
+		btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
+		/* MT7921 need to delay 20ms between toggle reset bit */
+		msleep(20);
+		btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 0);
+		btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
+	}
+
+	err = readx_poll_timeout(btusb_mtk_reset_done, hdev, val,
+				 val & MTK_BT_RST_DONE, 20000, 1000000);
+	if (err < 0)
+		bt_dev_err(hdev, "Reset timeout");
+
+	btusb_mtk_id_get(data, 0x70010200, &val);
+	if (!val)
+		bt_dev_err(hdev, "Can't get device id, subsys reset fail.");
+
+	usb_queue_reset_device(data->intf);
+
+	clear_bit(BTUSB_HW_RESET_ACTIVE, &data->flags);
+
+	return err;
+}
+
 static int btusb_mtk_setup(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -3079,6 +3151,7 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 
 	mediatek = hci_get_priv(hdev);
 	mediatek->dev_id = dev_id;
+	mediatek->reset_sync = btusb_mtk_reset;
 
 	switch (dev_id) {
 	case 0x7663:
@@ -3236,76 +3309,6 @@ static int btusb_mtk_shutdown(struct hci_dev *hdev)
 	return 0;
 }
 
-static void btusb_mtk_cmd_timeout(struct hci_dev *hdev)
-{
-	struct btusb_data *data = hci_get_drvdata(hdev);
-	u32 val;
-	int err;
-	struct btmediatek_data *mediatek;
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
-	mediatek = hci_get_priv(hdev);
-
-	if (mediatek->dev_id == 0x7925) {
-		btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
-		val |= (1 << 5);
-		btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
-		btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
-		val &= 0xFFFF00FF;
-		val |= (1 << 13);
-		btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
-		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x00010001);
-		btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
-		val |= (1 << 0);
-		btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
-		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
-		btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
-		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000000FF);
-		btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
-		msleep(100);
-	} else {
-		/* It's Device EndPoint Reset Option Register */
-		bt_dev_dbg(hdev, "Initiating reset mechanism via uhw");
-		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
-		btusb_mtk_uhw_reg_read(data, MTK_BT_WDT_STATUS, &val);
-
-		/* Reset the bluetooth chip via USB interface. */
-		btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 1);
-		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
-		btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
-		btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000000FF);
-		btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
-		/* MT7921 need to delay 20ms between toggle reset bit */
-		msleep(20);
-		btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 0);
-		btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
-	}
-
-	err = readx_poll_timeout(btusb_mtk_reset_done, hdev, val,
-				 val & MTK_BT_RST_DONE, 20000, 1000000);
-	if (err < 0)
-		bt_dev_err(hdev, "Reset timeout");
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
@@ -4432,7 +4435,7 @@ static int btusb_probe(struct usb_interface *intf,
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

