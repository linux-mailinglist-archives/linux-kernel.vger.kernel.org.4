Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99F869950E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjBPNAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjBPNAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:00:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8553A3E0AA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:00:32 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EBB7C66021AF;
        Thu, 16 Feb 2023 13:00:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676552431;
        bh=yWsDegXzrt0NSHPWIjXZg1Uds3E0S8tY1ojJP+FXBNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XcvILqurET3s+UI5b49eLjsRGssUji2kiyzxl28cwUgZDmtNLneuWp1HMHhZazQyV
         9O2ubb1dYrZx+w240KedoGcfdC9lAlMtxvRum3Ev3Ud8Fw/AmSdr1naTxVijASinDn
         AZycf2BDwQeWG745RLcvbywluJ2V9wuaml45ciP6ecJkXxBn/xSk7x/WY7NYFXjaA4
         2h1sJpYUsf1TPIeXQ41Oz7rObI2qVi97sH7qg7qSn2BtkPskuV5+0M4ObErOaT7aH/
         Vy9O1Ud5m5gtA9pWfOsyihdqfqtPmXNfTofiI96wgsOJJdftJa3UiYUcjH0oxl1kVZ
         /510M6G/gBeJQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     jason-jh.lin@mediatek.com, chunkuang.hu@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v1 7/9] soc: mediatek: mtk-mutex: Use module_platform_driver() macro
Date:   Thu, 16 Feb 2023 14:00:19 +0100
Message-Id: <20230216130021.64875-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230216130021.64875-1-angelogioacchino.delregno@collabora.com>
References: <20230216130021.64875-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open-coded init/exit calls with the module_platform_driver()
macro being equivalent.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-mutex.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index fb6bd0838892..07eff509580a 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -947,19 +947,7 @@ static struct platform_driver mtk_mutex_driver = {
 		.of_match_table = mutex_driver_dt_match,
 	},
 };
-
-static int __init mtk_mutex_init(void)
-{
-	return platform_driver_register(&mtk_mutex_driver);
-}
-
-static void __exit mtk_mutex_exit(void)
-{
-	platform_driver_unregister(&mtk_mutex_driver);
-}
-
-module_init(mtk_mutex_init);
-module_exit(mtk_mutex_exit);
+module_platform_driver(mtk_mutex_driver);
 
 MODULE_AUTHOR("Yongqiang Niu <yongqiang.niu@mediatek.com>");
 MODULE_DESCRIPTION("MediaTek SoC MUTEX driver");
-- 
2.39.1

