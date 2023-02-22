Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBE869F22E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjBVJug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjBVJuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:50:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B580F3608D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:48:03 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9D6D966021B8;
        Wed, 22 Feb 2023 09:43:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677058981;
        bh=rAHk+6D4DP7ZKavkjU3OoAIsoPs/edVh3yg1JAxrz8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g4g6Jf22hidJPXb/h9Wa8OCLtlftHXym9YpMsWyHjgCb/rbi6ZzmyzhoatYtDv+M/
         ihQFLLNEDnRriFk+ZSh0F7EwjqEwx9LXoFmd9Yxyy5gUPeYst0TAO0dkLwPT5eeLJT
         NfHzhiOR8BGZshr6QZkR6kRtEax+109UdlzzCbW1pkLCi0G4qxTghDNLoTotkBcspL
         aQ2WGmrWRozR4mXpxGchvduT7502ivAoW6+7JqSDwESi/EUJTxvjhKoeLKh6Qh7qbs
         BqClANiOO9XNowtXBLIiBHUenXd6W3zpbdP9YvuJMZuOGAYOkSdBUNG5UEzVHGiPsP
         ESxOlbKporAZQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     jason-jh.lin@mediatek.com, chunkuang.hu@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v2 2/9] soc: mediatek: mtk-mmsys: Use module_platform_driver() macro
Date:   Wed, 22 Feb 2023 10:42:46 +0100
Message-Id: <20230222094253.23678-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230222094253.23678-1-angelogioacchino.delregno@collabora.com>
References: <20230222094253.23678-1-angelogioacchino.delregno@collabora.com>
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

Instead of open-coding init/exit calls, switch to using the
module_platform_driver() macro instead, doing the exact same.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/soc/mediatek/mtk-mmsys.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index af22f3490034..1a574de9484d 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -447,19 +447,7 @@ static struct platform_driver mtk_mmsys_drv = {
 	.probe = mtk_mmsys_probe,
 	.remove = mtk_mmsys_remove,
 };
-
-static int __init mtk_mmsys_init(void)
-{
-	return platform_driver_register(&mtk_mmsys_drv);
-}
-
-static void __exit mtk_mmsys_exit(void)
-{
-	platform_driver_unregister(&mtk_mmsys_drv);
-}
-
-module_init(mtk_mmsys_init);
-module_exit(mtk_mmsys_exit);
+module_platform_driver(mtk_mmsys_drv);
 
 MODULE_AUTHOR("Yongqiang Niu <yongqiang.niu@mediatek.com>");
 MODULE_DESCRIPTION("MediaTek SoC MMSYS driver");
-- 
2.39.2

