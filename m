Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6495E5FFC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiIVKfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiIVKfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:35:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFCF83BF6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 03:35:09 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 67BC9660205E;
        Thu, 22 Sep 2022 11:35:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663842908;
        bh=hzZs/1aO3k2jUVZmRGLQHJ4A3hmjRyWqEEyzQ3TI83U=;
        h=From:To:Cc:Subject:Date:From;
        b=em+faPkZ7TtqBZu1q7U/Y6wsY99Kxt1vP2PmaRUyKax9hdplgIpEq7HJF3MmnmHvf
         p61YNHBnMc8tMvKcHsqcIGk9PjhQEVCzGXBUbQd5W6ZjywNpGFe6jSlVvIYc5YX993
         GnrCGFjoSlPwBzoLRhInnohevwMN1v297YziY6wJbv46usLjXgL6W4VRxJUvv/nuci
         FI0aisjls/vNE3Z8RIFnFLPbZCCbmnTglrseptlcFA+9pRytTAj4QM51H+8iiWKhoW
         Ap0cII5uj7HzmrKKH9PTg+OqQT6d0dm9WXVuAIOkCzDjISeUt22W3f89cpeBM/4mOr
         lwHZgqTqi3B5g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, trevor.wu@mediatek.com, tzungbi@google.com,
        angelogioacchino.delregno@collabora.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: mediatek: mt8195-mt6359: Use snd_soc_pm_ops instead of custom ops
Date:   Thu, 22 Sep 2022 12:35:02 +0200
Message-Id: <20220922103502.49981-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
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

It is possible to use the standard snd_soc_pm_ops for this card:
remove the custom mt8195_mt6359_pm_ops.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/mt8195/mt8195-mt6359.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359.c b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
index 961e769602d6..23bdde6acd1c 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
@@ -1532,16 +1532,11 @@ static const struct of_device_id mt8195_mt6359_dt_match[] = {
 	{},
 };
 
-static const struct dev_pm_ops mt8195_mt6359_pm_ops = {
-	.poweroff = snd_soc_poweroff,
-	.restore = snd_soc_resume,
-};
-
 static struct platform_driver mt8195_mt6359_driver = {
 	.driver = {
 		.name = "mt8195_mt6359",
 		.of_match_table = mt8195_mt6359_dt_match,
-		.pm = &mt8195_mt6359_pm_ops,
+		.pm = &snd_soc_pm_ops,
 	},
 	.probe = mt8195_mt6359_dev_probe,
 };
-- 
2.37.2

