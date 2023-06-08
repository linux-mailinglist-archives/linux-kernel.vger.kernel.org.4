Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5051A727A5F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbjFHIsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbjFHIro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:47:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2663273F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 01:47:40 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 90D486606F18;
        Thu,  8 Jun 2023 09:47:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686214059;
        bh=Kw2e/m/DW7+RkOYVIurLc9HONlxzUhzrCDaVnDSwbXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TNT6KiJAsUrDi/3k9KcOmGH5ZM5Uhfc30b149HprEzgpAJbGgaRnivt5RZXNd6d4t
         5l3r54Hc4AF6CjDDj5sYvWltAHeLBuOtZCO2qtqf/DWyOAxHwCsEuVh3CmyLvXeIi1
         T6W3g2fzVTjc0VJbxRng+yKIB08xpOf36Oiv5OSSXluYzD3kQfvV6X0QvkniGtBDgK
         mRiCl3wLhVvhSmR9SE9dpo9wt0gKkHqvjw/91v01SyP4zOMFw6vj8rBNGn06ANBB/c
         vRVY1jDJQbUUx1HAgBHUqRAqNT7/MpdlWcyf5zOeU6XECXyw1JbO5IAmn64rZzhV8J
         JpUaTJ4Idy22Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        trevor.wu@mediatek.com, amergnat@baylibre.com,
        dan.carpenter@linaro.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 3/5] ASoC: mediatek: mt8188-mt6359: Cleanup return 0 disguised as return ret
Date:   Thu,  8 Jun 2023 10:47:25 +0200
Message-Id: <20230608084727.74403-4-angelogioacchino.delregno@collabora.com>
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

Change all instances of `return ret` to `return 0` at the end of
functions where ret is always zero and also change functions
mt8188_{hdmi,dptx}_codec_init to be consistent with how other
functions are returning errors

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/mt8188/mt8188-mt6359.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
index b2735496d140..260cace408b9 100644
--- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
+++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
@@ -491,11 +491,13 @@ static int mt8188_hdmi_codec_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	ret = snd_soc_component_set_jack(component, &priv->hdmi_jack, NULL);
-	if (ret)
+	if (ret) {
 		dev_info(rtd->dev, "%s, set jack failed on %s (ret=%d)\n",
 			 __func__, component->name, ret);
+		return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 static int mt8188_dptx_codec_init(struct snd_soc_pcm_runtime *rtd)
@@ -513,11 +515,13 @@ static int mt8188_dptx_codec_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	ret = snd_soc_component_set_jack(component, &priv->dp_jack, NULL);
-	if (ret)
+	if (ret) {
 		dev_info(rtd->dev, "%s, set jack failed on %s (ret=%d)\n",
 			 __func__, component->name, ret);
+		return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 static int mt8188_dumb_amp_init(struct snd_soc_pcm_runtime *rtd)
@@ -539,7 +543,7 @@ static int mt8188_dumb_amp_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int mt8188_max98390_hw_params(struct snd_pcm_substream *substream,
@@ -612,7 +616,7 @@ static int mt8188_max98390_codec_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int mt8188_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
@@ -660,7 +664,7 @@ static int mt8188_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	return ret;
+	return 0;
 };
 
 static void mt8188_nau8825_codec_exit(struct snd_soc_pcm_runtime *rtd)
@@ -697,7 +701,7 @@ static int mt8188_nau8825_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	return ret;
+	return 0;
 }
 
 static const struct snd_soc_ops mt8188_nau8825_ops = {
-- 
2.40.1

