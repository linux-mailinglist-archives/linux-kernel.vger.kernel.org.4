Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9B7741C01
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 00:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjF1WzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 18:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjF1WzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 18:55:10 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E89610DA;
        Wed, 28 Jun 2023 15:55:06 -0700 (PDT)
X-UUID: cf9bd54e160611eeb20a276fd37b9834-20230629
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=4yrhuypULG2OCnly9KsqFwdywOUBkTDpjc5m2LAnCvU=;
        b=dPIERtCiLdJ78/Kz+xAp2oFARC+ReIK0lrnRWvK72y2JkpmQVlXq/dAEKTuqIm68S9G8CaG+oYieCaeLTXrsUHWIoYMcreQg8IUprOEhDJl5fEGDojtmR4vqZgv0AyecPgMfXcPkzYDjt1yDa/XUbJW8M8YPrfGbhcM88M48k7w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:fa938f2b-ff30-4e8c-ba3f-af9ee0f6a3ab,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:e40169da-b4fa-43c8-9c3e-0d3fabd03ec0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: cf9bd54e160611eeb20a276fd37b9834-20230629
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2072068970; Thu, 29 Jun 2023 06:55:00 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 29 Jun 2023 06:54:59 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 29 Jun 2023 06:54:59 +0800
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
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 1/3] Bluetooth: btusb: mediatek: readx_poll_timeout replaces open coding
Date:   Thu, 29 Jun 2023 06:54:55 +0800
Message-ID: <80efe66b16d933e3457bd38b1a60a5d51d4dee9e.1687991820.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
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

From: Sean Wang <sean.wang@mediatek.com>

Use readx_poll_timeout instead of open coding to poll the hardware reset
status until it is done.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: use 20ms as the unit to poll according to the requirement of
    readx_poll_timeout
v3: refine btusb_mtk_reset_done and drop the necessary error check
    in btusb_mtk_cmd_timeout
v4, v5, v6 and v7: rebase onto the latest codebase
v8: fixed GitLint failure
---
 drivers/bluetooth/btusb.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index cb58691b63ca..4c38d1c0f059 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2657,8 +2657,6 @@ static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *skb)
 #define MTK_EP_RST_OPT		0x74011890
 #define MTK_EP_RST_IN_OUT_OPT	0x00010001
 #define MTK_BT_RST_DONE		0x00000100
-#define MTK_BT_RESET_WAIT_MS	100
-#define MTK_BT_RESET_NUM_TRIES	10
 #define MTK_BT_RESET_REG_CONNV3	0x70028610
 #define MTK_BT_READ_DEV_ID	0x70010200
 
@@ -3032,6 +3030,16 @@ static int btusb_mtk_id_get(struct btusb_data *data, u32 reg, u32 *id)
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
@@ -3232,7 +3240,7 @@ static void btusb_mtk_cmd_timeout(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	u32 val;
-	int err, retry = 0;
+	int err;
 	struct btmediatek_data *mediatek;
 
 	/* It's MediaTek specific bluetooth reset mechanism via USB */
@@ -3284,18 +3292,10 @@ static void btusb_mtk_cmd_timeout(struct hci_dev *hdev)
 		btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
 	}
 
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

