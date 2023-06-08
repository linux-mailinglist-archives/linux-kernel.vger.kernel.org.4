Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343AD727A5E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbjFHIsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbjFHIro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:47:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A76273E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 01:47:39 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8072D6606F17;
        Thu,  8 Jun 2023 09:47:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686214058;
        bh=v2RbZsJIF8OTePPv81vl/VBbI91A/spCjRghtDBNM7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gf18HmSx3F3dEulzyCcItyoErGryylnFIIreRlee5hstTnWvpZqirZdfVHhz8G197
         kdkwZRySUDM8IkybCap5MZL0Tw6+iL3ERDCi0TIWFnPUkYszkTBXH09G8kFlBGr/Oh
         gnr8RWhiYZtZ48wF1iRKRzcE0wE6JVyiWWbqEBDOPpbT5Rf7+hQJucVaVXJwPKQwni
         hfPGvtjB3+QZkV0dTsL6I4bsAXw4kMonXZZbX4BSBPdvrPQBsTPOLE80/QfAPcM5uR
         L7vnSMA3Fh4ZH9Vok4qVDmVI2Iv2tIjabo/pBR7gEx5bhxnmPLfl7L6G4Hfxacfdz3
         +e+X/z2uFLSWA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        trevor.wu@mediatek.com, amergnat@baylibre.com,
        dan.carpenter@linaro.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 2/5] ASoC: mediatek: mt8188-mt6359: clean up a return in codec_init
Date:   Thu,  8 Jun 2023 10:47:24 +0200
Message-Id: <20230608084727.74403-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230608084727.74403-1-angelogioacchino.delregno@collabora.com>
References: <20230608084727.74403-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

This code triggers a Smatch static checker warning and does sort of
look like an error path.

sound/soc/mediatek/mt8188/mt8188-mt6359.c:597 mt8188_max98390_codec_init() warn: missing error code? 'ret'

However, returning 0 is intentional.  Make that explicit.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/mt8188/mt8188-mt6359.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
index 643a7a12a96b..b2735496d140 100644
--- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
+++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
@@ -594,7 +594,7 @@ static int mt8188_max98390_codec_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	if (rtd->dai_link->num_codecs <= 2)
-		return ret;
+		return 0;
 
 	/* add widgets/controls/dapm for rear speakers */
 	ret = snd_soc_dapm_new_controls(&card->dapm, mt8188_rear_spk_widgets,
-- 
2.40.1

