Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3616E1F33
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 11:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjDNJXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 05:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjDNJXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:23:20 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9121FD0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 02:23:18 -0700 (PDT)
Received: from archlinux.localdomain ([10.12.190.56])
        (user=zkhuang@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33E9JuZ5016647-33E9JuZ6016647
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Apr 2023 17:19:59 +0800
From:   zhengkang huang <zkhuang@hust.edu.cn>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     zhengkang huang <zkhuang@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] soc: mdediatek: devapc: use devm_platform_ioremap_resource() instead of of_iomap()
Date:   Fri, 14 Apr 2023 17:21:13 +0800
Message-Id: <20230414092113.64514-1-zkhuang@hust.edu.cn>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: zkhuang@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mtk_devapc_probe(), if of_iomap succeeds and any following error occurs,
it needs to deallocate the resource.

Fix this by repalcing of_iomap with devm_platform_ioremap_resource, which
automatically self-manages the resource. This can avoid modifying error
handling code.

Signed-off-by: zhengkang huang <zkhuang@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/soc/mediatek/mtk-devapc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
index bad139cb117e..bea3ec8ab015 100644
--- a/drivers/soc/mediatek/mtk-devapc.c
+++ b/drivers/soc/mediatek/mtk-devapc.c
@@ -268,7 +268,7 @@ static int mtk_devapc_probe(struct platform_device *pdev)
 	ctx->data = of_device_get_match_data(&pdev->dev);
 	ctx->dev = &pdev->dev;
 
-	ctx->infra_base = of_iomap(node, 0);
+	ctx->infra_base = devm_platform_ioremap_resource(pdev, 0);
 	if (!ctx->infra_base)
 		return -EINVAL;
 
-- 
2.40.0

