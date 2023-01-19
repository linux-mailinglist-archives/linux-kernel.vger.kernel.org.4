Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FFD673071
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjASEiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjASEiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 23:38:24 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2820A70C71;
        Wed, 18 Jan 2023 20:35:11 -0800 (PST)
X-UUID: 07ad864897aa11ed945fc101203acc17-20230119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=nVBXFg+lOnDLmoTtrhjNFvx9l0GF1e2zXUq38b1bO0A=;
        b=F2y11Nlv/qGTvzpz0RsLiZVfrGSR3z3TpEjkVFz1f7rZoOPdkKPAAqC8GX78h9kd0XGHK8eiq9tXbZZLOBbCWHXaOoy0mLMtDeKMOK1RPJYX17/xWAlNjlmWJwDmm3Zc90o0lt5rJYM50lMOX5wg5H1nGHMU+A1Cp/fYMvDFEHU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:313d8063-2cb0-496c-8fa9-31454b9296c0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.18,REQID:313d8063-2cb0-496c-8fa9-31454b9296c0,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:3ca2d6b,CLOUDID:c2213cf6-ff42-4fb0-b929-626456a83c14,B
        ulkID:230119113324WXGJANT2,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-BVR: 0
X-UUID: 07ad864897aa11ed945fc101203acc17-20230119
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 87402584; Thu, 19 Jan 2023 11:33:24 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 19 Jan 2023 11:33:23 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 19 Jan 2023 11:33:23 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Min Guo <min.guo@mediatek.com>
Subject: [PATCH] usb: mtu3: fix the failure of qmu stop
Date:   Thu, 19 Jan 2023 11:33:22 +0800
Message-ID: <20230119033322.21426-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This happens when do stress test of uvc stream on/off which will
enable/disable endpoints. uvc has four tx requests, and may disable
endpoint between queue tx requests as following:
    enable ep --> start qmu
    queue tx request0
    queue tx request1
    queue tx request2 --> resume qmu
    disable ep --> stop qmu may fail [1]
    queue tx request3 --> will resume qmu, may cause qmu can't work
                          when enable ep next time [2]

[1]: when the tx fifo has some data to transmit, and
    try to stop qmu (stop ep) meanwhile resume qmu (queue tx request),
    it may cause stop qmu timeout, then can be fixed by flushing fifo
    when stop qmu.
[2]: it resumes qmu again, shall stop qmu again.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Reported-by: Min Guo <min.guo@mediatek.com>
---
 drivers/usb/mtu3/mtu3_gadget.c  | 3 +--
 drivers/usb/mtu3/mtu3_hw_regs.h | 1 +
 drivers/usb/mtu3/mtu3_qmu.c     | 7 +++++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index 80236e7b0895..c0264d5426bf 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -133,10 +133,9 @@ static int mtu3_ep_disable(struct mtu3_ep *mep)
 {
 	struct mtu3 *mtu = mep->mtu;
 
-	mtu3_qmu_stop(mep);
-
 	/* abort all pending requests */
 	nuke(mep, -ESHUTDOWN);
+	mtu3_qmu_stop(mep);
 	mtu3_deconfig_ep(mtu, mep);
 	mtu3_gpd_ring_free(mep);
 
diff --git a/drivers/usb/mtu3/mtu3_hw_regs.h b/drivers/usb/mtu3/mtu3_hw_regs.h
index 519a58301f45..ee30ae0a4b54 100644
--- a/drivers/usb/mtu3/mtu3_hw_regs.h
+++ b/drivers/usb/mtu3/mtu3_hw_regs.h
@@ -128,6 +128,7 @@
 #define TX_FIFOEMPTY		BIT(24)
 #define TX_SENTSTALL		BIT(22)
 #define TX_SENDSTALL		BIT(21)
+#define TX_FLUSHFIFO		BIT(20)
 #define TX_TXPKTRDY		BIT(16)
 #define TX_TXMAXPKTSZ_MSK	GENMASK(10, 0)
 #define TX_TXMAXPKTSZ(x)	((x) & TX_TXMAXPKTSZ_MSK)
diff --git a/drivers/usb/mtu3/mtu3_qmu.c b/drivers/usb/mtu3/mtu3_qmu.c
index 2ea3157ddb6e..a2fdab8b63b2 100644
--- a/drivers/usb/mtu3/mtu3_qmu.c
+++ b/drivers/usb/mtu3/mtu3_qmu.c
@@ -388,6 +388,9 @@ void mtu3_qmu_stop(struct mtu3_ep *mep)
 	}
 	mtu3_writel(mbase, qcsr, QMU_Q_STOP);
 
+	if (mep->is_in)
+		mtu3_setbits(mbase, MU3D_EP_TXCR0(epnum), TX_FLUSHFIFO);
+
 	ret = readl_poll_timeout_atomic(mbase + qcsr, value,
 			!(value & QMU_Q_ACTIVE), 1, 1000);
 	if (ret) {
@@ -395,6 +398,10 @@ void mtu3_qmu_stop(struct mtu3_ep *mep)
 		return;
 	}
 
+	/* flush fifo again to make sure the fifo is empty */
+	if (mep->is_in)
+		mtu3_setbits(mbase, MU3D_EP_TXCR0(epnum), TX_FLUSHFIFO);
+
 	dev_dbg(mtu->dev, "%s's qmu stop now!\n", mep->name);
 }
 
-- 
2.18.0

