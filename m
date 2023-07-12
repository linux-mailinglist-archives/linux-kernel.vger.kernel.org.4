Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17D874FEA9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 07:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjGLFT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 01:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjGLFTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 01:19:22 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B31A6;
        Tue, 11 Jul 2023 22:19:17 -0700 (PDT)
X-UUID: a3a99a6c207311ee9cb5633481061a41-20230712
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=HFjVLrSlHIovITeC28nKCrvDmOrnc0uXGtIt3SR2nPc=;
        b=Yg1bBEQRniF8y4SsvuJtDogNbDaqCPswW9n2NCkH/waEuXzu84JOa75IZXbuy2FNNXlCbY9QoMZ7v7Ysr2J910+8wLVcVddfWCgB+dswkJuOZRYCB3nBUhDo1sMFZdyXsbVJpJTY1Rtdadh2JxGjwPuhHe7bkWkR3IXZkCx5few=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:fd91dbcc-ccc0-47c2-9abf-1c4e56ec9467,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:514a2268-314d-4083-81b6-6a74159151eb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: a3a99a6c207311ee9cb5633481061a41-20230712
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <chris.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1545327841; Wed, 12 Jul 2023 13:19:13 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 12 Jul 2023 13:19:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 12 Jul 2023 13:19:12 +0800
From:   Chris Lu <chris.lu@mediatek.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Von Dentz <luiz.dentz@gmail.com>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Aaron Hou <aaron.hou@mediatek.com>,
        Steve Lee <steve.lee@mediatek.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v3] Bluetooth: btmtk: Fix null pointer when processing coredump
Date:   Wed, 12 Jul 2023 13:18:58 +0800
Message-ID: <20230712051857.13812-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There may be a potential null pointer risk if offset value is
less than 0 when doing memcmp in btmtk_process_coredump().
Checking offset is valid before doing memcmp.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: fix typo
v3: fix bot checking error
---
 drivers/bluetooth/btmtk.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 786f775196ae..0f290430ae0e 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -370,7 +370,7 @@ EXPORT_SYMBOL_GPL(btmtk_register_coredump);
 int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btmediatek_data *data = hci_get_priv(hdev);
-	int err;
+	int err, offset;
 
 	if (!IS_ENABLED(CONFIG_DEV_COREDUMP))
 		return 0;
@@ -392,15 +392,15 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
 		if (err < 0)
 			break;
 		data->cd_info.cnt++;
+		offset = skb->len - sizeof(MTK_COREDUMP_END);
 
 		/* Mediatek coredump data would be more than MTK_COREDUMP_NUM */
-		if (data->cd_info.cnt > MTK_COREDUMP_NUM &&
-		    skb->len > sizeof(MTK_COREDUMP_END) &&
-		    !memcmp((char *)&skb->data[skb->len - sizeof(MTK_COREDUMP_END)],
-			    MTK_COREDUMP_END, sizeof(MTK_COREDUMP_END) - 1)) {
-			bt_dev_info(hdev, "Mediatek coredump end");
-			hci_devcd_complete(hdev);
-		}
+		if (data->cd_info.cnt > MTK_COREDUMP_NUM && offset > 0)
+			if (!memcmp((char *)&skb->data[offset], MTK_COREDUMP_END,
+				    sizeof(MTK_COREDUMP_END) - 1)) {
+				bt_dev_info(hdev, "Mediatek coredump end");
+				hci_devcd_complete(hdev);
+			}
 
 		break;
 	}
-- 
2.18.0

