Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25756DAA1C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 10:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240212AbjDGI34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 04:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjDGI3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 04:29:48 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0D27DBF;
        Fri,  7 Apr 2023 01:29:47 -0700 (PDT)
X-UUID: 5854ab10d51e11eda9a90f0bb45854f4-20230407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vWGHzunDbxWDLDtboxTw3mk43F8Ucc7eRgJDJnklAJo=;
        b=E3F5zcFTacg9f9AIgo3mbEkMFc4OAFd8wnp/VM4q6hWAzEUDdm6041eaMqx5aVB3lUPViXtyent63G1fDOnUhkGVVHPo6+O4Zoqkf69QjXXKzFZMjwe0Z2xf4eymhA1bqPD/5Hn88vwQ9JSTnm1q13KsL7/yeX0uuxnGkK7m0uE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:81da8e16-818f-4733-bca9-72ffae391b5f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.22,REQID:81da8e16-818f-4733-bca9-72ffae391b5f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:120426c,CLOUDID:7a6281b5-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:230407162943II8GT2WT,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 5854ab10d51e11eda9a90f0bb45854f4-20230407
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1891287872; Fri, 07 Apr 2023 16:29:42 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 7 Apr 2023 16:29:41 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 7 Apr 2023 16:29:40 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tianping Fang <tianping.fang@mediatek.com>
Subject: [PATCH v2 4/7] usb: mtu3: unlock @mtu->lock just before giving back request
Date:   Fri, 7 Apr 2023 16:29:34 +0800
Message-ID: <20230407082937.14558-4-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230407082937.14558-1-chunfeng.yun@mediatek.com>
References: <20230407082937.14558-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need unlock @mtu->lock when unmap request, unlock it just before
giving back request, due to we do not lock this spinlock when map
the request.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: add Reviewed-by AngeloGioacchino
---

 drivers/usb/mtu3/mtu3_gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index c0264d5426bf..ad0eeac4332d 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -23,7 +23,6 @@ __acquires(mep->mtu->lock)
 		req->status = status;
 
 	trace_mtu3_req_complete(mreq);
-	spin_unlock(&mtu->lock);
 
 	/* ep0 makes use of PIO, needn't unmap it */
 	if (mep->epnum)
@@ -32,6 +31,7 @@ __acquires(mep->mtu->lock)
 	dev_dbg(mtu->dev, "%s complete req: %p, sts %d, %d/%d\n",
 		mep->name, req, req->status, req->actual, req->length);
 
+	spin_unlock(&mtu->lock);
 	usb_gadget_giveback_request(&mep->ep, req);
 	spin_lock(&mtu->lock);
 }
-- 
2.18.0

