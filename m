Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C069632CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiKUTVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiKUTVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:21:07 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4C7101C6;
        Mon, 21 Nov 2022 11:20:59 -0800 (PST)
X-UUID: fd0cb0abc4a7492e9190068db12e509e-20221122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ZDtrqJqyAAB4TBCUonI2IN7i3sDJI2wzUGUaxKd9Kkc=;
        b=Cuu5Zz75NlI13PIAXDb4GDJvjiT9lwJUoJpZ5p2N+10D+uFkBj9hXXwVhUKFpvcxI4YQccuKZucq2NpywxNDrIQOGjAOLcnVsWM59QaSuv9ysbFrGuXLNv4MXGBsl9IUmVFClZq1Lsjd3tOizM4JMDC9xNxFfGLgwl6sXRkE4rI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:08f01a7a-424b-4c7e-a2ca-6a7f095eeda8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.12,REQID:08f01a7a-424b-4c7e-a2ca-6a7f095eeda8,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:62cd327,CLOUDID:494dd2db-6ad4-42ff-91f3-18e0272db660,B
        ulkID:221122032056BIPXAVL9,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: fd0cb0abc4a7492e9190068db12e509e-20221122
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1209132191; Tue, 22 Nov 2022 03:20:56 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 22 Nov 2022 03:20:54 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 22 Nov 2022 03:20:54 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <jenhao.yang@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>,
        <abhishekpandit@google.com>, <michaelfsun@google.com>,
        <abhishekpandit@chromium.org>, <mcchou@chromium.org>,
        <shawnku@google.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] Bluetooth: btusb: mediatek: use readx_poll_timeout instead of open coding
Date:   Tue, 22 Nov 2022 03:20:51 +0800
Message-ID: <caf41c6a33b1ceeb36ec7261b0cc894082352c46.1669057170.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Use readx_poll_timeout instead of open coding to poll the hardware reset
status until it is done.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
The patch is built and tested on the top of the patches
[v6,1/3] Bluetooth: Add support for hci devcoredump
[v6,2/3] Bluetooth: btusb: Add btusb devcoredump support
[v6,3/3] Bluetooth: btintel: Add Intel devcoredump support
which are contributed from Manish Mandlik

v2: use 20ms as the unit to poll according to the requirement of
    readx_poll_timeout

v3: refine btusb_mtk_reset_done and drop the necessary error check
    in btusb_mtk_cmd_timeout
---
 drivers/bluetooth/btusb.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8d076efdf6a8..791bd3f620fc 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2321,8 +2321,6 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 #define MTK_EP_RST_OPT		0x74011890
 #define MTK_EP_RST_IN_OUT_OPT	0x00010001
 #define MTK_BT_RST_DONE		0x00000100
-#define MTK_BT_RESET_WAIT_MS	100
-#define MTK_BT_RESET_NUM_TRIES	10
 
 static void btusb_mtk_wmt_recv(struct urb *urb)
 {
@@ -2679,6 +2677,16 @@ static int btusb_mtk_id_get(struct btusb_data *data, u32 reg, u32 *id)
 	return btusb_mtk_reg_read(data, reg, id);
 }
 
+static u32 btusb_mtk_reset_done(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	u32 val = 0;
+
+	btusb_mtk_uhw_reg_read(data, MTK_BT_MISC, &val);
+
+	return val & MTK_BT_RST_DONE;
+}
+
 static int btusb_mtk_setup(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -2868,7 +2876,7 @@ static void btusb_mtk_cmd_timeout(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	u32 val;
-	int err, retry = 0;
+	int err;
 
 	/* It's MediaTek specific bluetooth reset mechanism via USB */
 	if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
@@ -2899,18 +2907,10 @@ static void btusb_mtk_cmd_timeout(struct hci_dev *hdev)
 	btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 0);
 	btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
 
-	/* Poll the register until reset is completed */
-	do {
-		btusb_mtk_uhw_reg_read(data, MTK_BT_MISC, &val);
-		if (val & MTK_BT_RST_DONE) {
-			bt_dev_dbg(hdev, "Bluetooth Reset Successfully");
-			break;
-		}
-
-		bt_dev_dbg(hdev, "Polling Bluetooth Reset CR");
-		retry++;
-		msleep(MTK_BT_RESET_WAIT_MS);
-	} while (retry < MTK_BT_RESET_NUM_TRIES);
+	err = readx_poll_timeout(btusb_mtk_reset_done, hdev, val,
+				 val & MTK_BT_RST_DONE, 20000, 1000000);
+	if (err < 0)
+		bt_dev_err(hdev, "Reset timeout");
 
 	btusb_mtk_id_get(data, 0x70010200, &val);
 	if (!val)
-- 
2.25.1

