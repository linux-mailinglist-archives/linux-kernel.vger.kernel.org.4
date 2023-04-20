Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879266E8DB5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbjDTJMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbjDTJMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:12:30 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3AA1BD8;
        Thu, 20 Apr 2023 02:11:58 -0700 (PDT)
X-UUID: 496a3981a3724ed9863cfd24002f4a03-20230420
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:6a5a27f8-f086-46c8-ab10-ba7c001f65f5,IP:5,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-9
X-CID-INFO: VERSION:1.1.22,REQID:6a5a27f8-f086-46c8-ab10-ba7c001f65f5,IP:5,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-9
X-CID-META: VersionHash:120426c,CLOUDID:d90999eb-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:230420171125Q0UCYOKU,BulkQuantity:0,Recheck:0,SF:38|24|17|19|45|102,
        TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 496a3981a3724ed9863cfd24002f4a03-20230420
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <gehao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1812346153; Thu, 20 Apr 2023 17:11:23 +0800
From:   Hao Ge <gehao@kylinos.cn>
To:     sboyd@kernel.org, mturquette@baylibre.com, matthias.bgg@gmail.com
Cc:     gehao@kylinos.cn, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, gehao618@163.com
Subject: [PATCH V2] mediatek/clk-mt8173-apmixedsys: convert to devm_platform_ioremap_resource
Date:   Thu, 20 Apr 2023 17:11:21 +0800
Message-Id: <20230420091121.28642-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <7b162010-4fa3-4572-c834-7264eb937e4a@kylinos.cn>
References: <7b162010-4fa3-4572-c834-7264eb937e4a@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource to take the place of of_iomap for
avoid that we don't called iounmap when return some error or remove
device.

Signed-off-by: Hao Ge <gehao@kylinos.cn>
Suggested-by: Stephen Boyd <sboyd@kernel.org>
---

v2: fix error handle condition for devm_platform_ioremap_resource
---
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
index a56c5845d07a..73c29d1dccc6 100644
--- a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
@@ -90,8 +90,8 @@ static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
 	struct clk_hw *hw;
 	int r;
 
-	base = of_iomap(node, 0);
-	if (!base)
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
