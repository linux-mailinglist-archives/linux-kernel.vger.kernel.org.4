Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1946E3DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 04:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjDQCwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 22:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjDQCwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 22:52:20 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C282718;
        Sun, 16 Apr 2023 19:52:18 -0700 (PDT)
X-UUID: d9eba7ecdcca11edb6b9f13eb10bd0fe-20230417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=HFOJULAIHGPq12XJm5Jmua93Eyz9XsckyqBFWPq6Mto=;
        b=gfCiOOD+B9+kvoHzDrcYT4GH/TGTJ+8BqL6WjGsl3XivL0yrInRqb7rIVnlaGrCT66WUZm/b/HZPFNDCRM4m0N1XqVObh9r6uJ0NUd8TwOXqPUBVYbrvNaXb6EFVKGMdvKWjfUNarlQW7UdDtV2+dfIFfXDcPwE7mdtekV9LIQ0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:c1048cdd-4b14-4cd6-b560-eecc7f31c219,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:216486a1-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: d9eba7ecdcca11edb6b9f13eb10bd0fe-20230417
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1512352980; Mon, 17 Apr 2023 10:52:11 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 17 Apr 2023 10:52:10 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 17 Apr 2023 10:52:09 +0800
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
Subject: [PATCH v3 7/7] usb: mtu3: add optional clock xhci_ck and frmcnt_ck
Date:   Mon, 17 Apr 2023 10:52:03 +0800
Message-ID: <20230417025203.18097-7-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417025203.18097-1-chunfeng.yun@mediatek.com>
References: <20230417025203.18097-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional clock 'xhci_ck' which is usually the same as sys_ck, but
some SoC use two separated clocks when the controller supports dual
role mode;
Add optional clock 'frmcnt_ck' used on 4nm or advanced process SoC.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2~v3: no changes
---
 drivers/usb/mtu3/mtu3.h      | 2 +-
 drivers/usb/mtu3/mtu3_plat.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index 2d7b57e07eee..b4a7662dded5 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -90,7 +90,7 @@ struct mtu3_request;
  */
 #define EP0_RESPONSE_BUF  6
 
-#define BULK_CLKS_CNT	4
+#define BULK_CLKS_CNT	6
 
 /* device operated link and speed got from DEVICE_CONF register */
 enum mtu3_speed {
diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index d78ae52b4e26..6f264b129243 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -234,6 +234,8 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 	clks[1].id = "ref_ck";
 	clks[2].id = "mcu_ck";
 	clks[3].id = "dma_ck";
+	clks[4].id = "xhci_ck";
+	clks[5].id = "frmcnt_ck";
 	ret = devm_clk_bulk_get_optional(dev, BULK_CLKS_CNT, clks);
 	if (ret)
 		return ret;
-- 
2.18.0

