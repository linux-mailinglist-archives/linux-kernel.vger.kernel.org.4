Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A293F75092A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbjGLNDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbjGLND2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:03:28 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF461BFD;
        Wed, 12 Jul 2023 06:03:22 -0700 (PDT)
X-UUID: 7815dfbe20b411ee9cb5633481061a41-20230712
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=G1HHJBk/sQvVbiomYqcZlgk1NLXE+A6QfL373AvC8Vo=;
        b=VoYwL7RMiyz/1jncyQ4wWRS+Ueq3h/g5vL9ZdvrXIWaZlD9LU+Ruge2dcgShe2lWebCsmDgGbAjwJBwh95qM+5Hi2Ql+synKKs2EPfBqklREsncTIrmhxe7XMKWmZG1heF4jHUGjmMMCdt2zn3gtihgbXZqbHbTMYFaokjR+4E8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:98e51d2a-2e82-4c3c-86e0-b1f2dc874cc2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:5693270e-c22b-45ab-8a43-3004e9216b56,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7815dfbe20b411ee9cb5633481061a41-20230712
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <chris.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 401310188; Wed, 12 Jul 2023 21:03:17 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 12 Jul 2023 21:03:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 12 Jul 2023 21:03:16 +0800
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
Subject: [PATCH v4] Bluetooth: btmtk: Fix null pointer when processing coredump
Date:   Wed, 12 Jul 2023 21:02:19 +0800
Message-ID: <20230712130218.376-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There may be a potential null pointer risk if offset value is
less than 0 when doing memcmp in btmtk_process_coredump().
Check offset is valid before doing memcmp.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: fix typo
v3: fix bot checking error
v4: reduce variable 'offset' declaration in v3
---
 drivers/bluetooth/btmtk.c | 12 ++++++------
 drivers/bluetooth/btmtk.h |  1 +
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 786f775196ae..9cc789272ab7 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -395,12 +395,12 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
 
 		/* Mediatek coredump data would be more than MTK_COREDUMP_NUM */
 		if (data->cd_info.cnt > MTK_COREDUMP_NUM &&
-		    skb->len > sizeof(MTK_COREDUMP_END) &&
-		    !memcmp((char *)&skb->data[skb->len - sizeof(MTK_COREDUMP_END)],
-			    MTK_COREDUMP_END, sizeof(MTK_COREDUMP_END) - 1)) {
-			bt_dev_info(hdev, "Mediatek coredump end");
-			hci_devcd_complete(hdev);
-		}
+		    skb->len > MTK_COREDUMP_END_LEN)
+			if (!memcmp((char *)&skb->data[skb->len - MTK_COREDUMP_END_LEN],
+			    MTK_COREDUMP_END, MTK_COREDUMP_END_LEN - 1)) {
+				bt_dev_info(hdev, "Mediatek coredump end");
+				hci_devcd_complete(hdev);
+			}
 
 		break;
 	}
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index 68309dfe076a..56f5502baadf 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -24,6 +24,7 @@
 
 #define MTK_COREDUMP_SIZE		(1024 * 1000)
 #define MTK_COREDUMP_END		"coredump end"
+#define MTK_COREDUMP_END_LEN		(sizeof(MTK_COREDUMP_END))
 #define MTK_COREDUMP_NUM		255
 
 enum {
-- 
2.18.0

