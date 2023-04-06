Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F5F6D8D99
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 04:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjDFCnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 22:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbjDFCnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 22:43:24 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5FD86B6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 19:43:23 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=ziqin_l@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 3362g2eK004176-3362g2eL004176
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 6 Apr 2023 10:42:09 +0800
From:   Ziqin Liu <ziqin_l@hust.edu.cn>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Ziqin Liu <ziqin_l@hust.edu.cn>, Dongliang Mu <dzm91@hust.edu.cn>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] soc: mediatek: mtk-svs: change the function IS_ERR_OR_NULL() to IS_ERR()
Date:   Thu,  6 Apr 2023 10:42:00 +0800
Message-Id: <20230406024200.3126080-1-ziqin_l@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: ziqin_l@hust.edu.cn
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvmem_cell_get() will return an ERR_PTR() on error or a valid pointer to a
struct nvmem_cell but won't return NULL, the check function should be
IS_ERR() instead of IS_ERR_OR_NULL()

Signed-off-by: Ziqin Liu <ziqin_l@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/soc/mediatek/mtk-svs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index a7eb019b5157..8127fb6d587b 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -1726,7 +1726,7 @@ static int svs_get_efuse_data(struct svs_platform *svsp,
 	struct nvmem_cell *cell;
 
 	cell = nvmem_cell_get(svsp->dev, nvmem_cell_name);
-	if (IS_ERR_OR_NULL(cell)) {
+	if (IS_ERR(cell)) {
 		dev_err(svsp->dev, "no \"%s\"? %ld\n",
 			nvmem_cell_name, PTR_ERR(cell));
 		return PTR_ERR(cell);
-- 
2.25.1

