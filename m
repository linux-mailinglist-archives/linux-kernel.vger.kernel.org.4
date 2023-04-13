Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023F36E0995
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjDMJC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjDMJCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:02:34 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB44183F8;
        Thu, 13 Apr 2023 02:01:41 -0700 (PDT)
X-UUID: 18142d70a7ba4fa4979d7736f75fe837-20230413
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:ee4c8d52-2964-462a-b687-6d8ce734d4ec,IP:5,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-9
X-CID-INFO: VERSION:1.1.22,REQID:ee4c8d52-2964-462a-b687-6d8ce734d4ec,IP:5,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-9
X-CID-META: VersionHash:120426c,CLOUDID:cf28d6ea-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:230413170137RYK53AXK,BulkQuantity:0,Recheck:0,SF:19|42|38|24|17|102,
        TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 18142d70a7ba4fa4979d7736f75fe837-20230413
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <gehao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 513328953; Thu, 13 Apr 2023 17:01:35 +0800
From:   Hao Ge <gehao@kylinos.cn>
To:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com
Cc:     gehao@kylinos.cn, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] mediatek/clk-mt8173-apmixedsys: convert to devm_platform_ioremap_resource
Date:   Thu, 13 Apr 2023 17:01:28 +0800
Message-Id: <20230413090128.60119-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource to take the place of of_iomap for
avoid that we don't called iounmap when return some error or remove
device.

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
index a56c5845d07a..fe386bf8225d 100644
--- a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
@@ -90,7 +90,7 @@ static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
 	struct clk_hw *hw;
 	int r;
 
-	base = of_iomap(node, 0);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (!base)
 		return PTR_ERR(base);
 
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
