Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3EA608E7F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 18:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJVQ2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 12:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiJVQ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 12:27:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE85134AA9;
        Sat, 22 Oct 2022 09:27:56 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a14so6495321wru.5;
        Sat, 22 Oct 2022 09:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ktkNejLf5LU86KvYGlX282kufTNr47TRhHJaTddj0/Y=;
        b=kxWSvkr4ZOGssABhmV4JWeqGJPQM9aKQZQmbQYexW7JPTaBwh9ZYKPQuHAfWeFWPgD
         JIgXQ/SuMLfVpB+nn3zxnjNMro5vxhLmdGdZj3LaAJ17pHjaeatcLQ6PO8DZbrMjGADE
         nRcWXHS2LHxoXJnO838vP4dVTuBVz77hDE71zZKFRZD6llC3QR1cEdryfUXc0fEXayTH
         p4iH2QaBeiEPrcFU9FPPQHaPOj67bf4outShJbWtj6ICbMChTPjuqCNK1J+GUml2nv+s
         CDeYswtfxTLFQCi0QcpyIgsnCJvegj62wWoTa0SvYBOmjQjWVJmuyjjmX/OUGHWMWiWc
         YoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ktkNejLf5LU86KvYGlX282kufTNr47TRhHJaTddj0/Y=;
        b=q0RslBdOdvdiiaKa83X79W0EJsuD+ET1e8DUeMPP3M3UDnajRiJ4U6FGrXNwv9AGMh
         nc7NYX3X7pay3Mx6Xhb19NQDOYC1HkMtSjoyPSx+zH/RmQc5ZZJCsJtFTR1CsRHM0xCm
         87mgBc8Yu+kYmbhiKrzsNaxW59Hi5mgplcA/x7zSlp7/6BKYahW2u7/gUqo8YcygToyN
         kDwS8+70nOvO4Gy/ueZHUrVgVEEdKja7ovTjpnsUqoH48S54s73Dg2s23P0bR2rykPmB
         0UiS1KHypbQO5p43lWuWCW78IgxoE+tgB9MbtABBjBbgew25RGC+NZUz57u6RCCkF8gk
         Pc0g==
X-Gm-Message-State: ACrzQf00ISpYrVszqISOqngb5qEdWIWbIVx74ULjNIkB0+m+qFUvHLTk
        qTemXSIkb4bp+8aEtJNEL6A=
X-Google-Smtp-Source: AMsMyM5pJJuwPjRKj6P8P4nUqOnixt9lCmG0gQ7Zju6LnYGjzPLoWiCaVEzp4J6jVj/JRk3SKA7OBA==
X-Received: by 2002:a05:6000:1acb:b0:231:faaa:8976 with SMTP id i11-20020a0560001acb00b00231faaa8976mr15583292wry.426.1666456075308;
        Sat, 22 Oct 2022 09:27:55 -0700 (PDT)
Received: from localhost (94.197.3.61.threembb.co.uk. [94.197.3.61])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600c47c700b003b95ed78275sm5583279wmo.20.2022.10.22.09.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 09:27:54 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kuninori.morimoto.gx@renesas.com
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] ASoC: simple-card: Support custom DAI system clock IDs
Date:   Sat, 22 Oct 2022 17:27:41 +0100
Message-Id: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some DAIs have multiple system clock sources, which can be chosen
using the "clk_id" argument to snd_soc_dai_set_sysclk(). Currently
this is hardcoded to 0 when using simple cards, but that choice is
not always suitable.

Add the "system-clock-id" property to allow selecting a different
clock ID on a per-DAI basis.

To simplify the logic on DPCM cards, add a dummy "asoc_simple_dai"
instance and use that for the dummy components on DPCM links. This
ensures that when we're iterating over DAIs in the PCM runtime there
is always a matching "asoc_simple_dai" we can dereference.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 include/sound/simple_card_utils.h     |  2 ++
 sound/soc/generic/simple-card-utils.c | 26 ++++++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index a0b827f0c2f6..9f9a72299637 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -26,6 +26,7 @@ struct asoc_simple_dai {
 	const char *name;
 	unsigned int sysclk;
 	int clk_direction;
+	int sysclk_id;
 	int slots;
 	int slot_width;
 	unsigned int tx_slot_mask;
@@ -67,6 +68,7 @@ struct asoc_simple_priv {
 		struct prop_nums num;
 		unsigned int mclk_fs;
 	} *dai_props;
+	struct asoc_simple_dai dummy_dai;
 	struct asoc_simple_jack hp_jack;
 	struct asoc_simple_jack mic_jack;
 	struct snd_soc_dai_link *dai_link;
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index bef16833c487..d4d898e06e76 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -262,6 +262,9 @@ int asoc_simple_parse_clk(struct device *dev,
 	if (of_property_read_bool(node, "system-clock-direction-out"))
 		simple_dai->clk_direction = SND_SOC_CLOCK_OUT;
 
+	if (!of_property_read_u32(node, "system-clock-id", &val))
+		simple_dai->sysclk_id = val;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(asoc_simple_parse_clk);
@@ -355,7 +358,7 @@ void asoc_simple_shutdown(struct snd_pcm_substream *substream)
 
 		if (props->mclk_fs && !dai->clk_fixed && !snd_soc_dai_active(cpu_dai))
 			snd_soc_dai_set_sysclk(cpu_dai,
-					       0, 0, SND_SOC_CLOCK_OUT);
+					       dai->sysclk_id, 0, SND_SOC_CLOCK_OUT);
 
 		asoc_simple_clk_disable(dai);
 	}
@@ -364,7 +367,7 @@ void asoc_simple_shutdown(struct snd_pcm_substream *substream)
 
 		if (props->mclk_fs && !dai->clk_fixed && !snd_soc_dai_active(codec_dai))
 			snd_soc_dai_set_sysclk(codec_dai,
-					       0, 0, SND_SOC_CLOCK_IN);
+					       dai->sysclk_id, 0, SND_SOC_CLOCK_IN);
 
 		asoc_simple_clk_disable(dai);
 	}
@@ -439,7 +442,7 @@ int asoc_simple_hw_params(struct snd_pcm_substream *substream,
 	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct simple_dai_props *props = simple_priv_to_props(priv, rtd->num);
 	unsigned int mclk, mclk_fs = 0;
-	int i, ret;
+	int i, ret, sysclk_id;
 
 	if (props->mclk_fs)
 		mclk_fs = props->mclk_fs;
@@ -472,13 +475,21 @@ int asoc_simple_hw_params(struct snd_pcm_substream *substream,
 		}
 
 		for_each_rtd_codec_dais(rtd, i, sdai) {
-			ret = snd_soc_dai_set_sysclk(sdai, 0, mclk, SND_SOC_CLOCK_IN);
+			pdai = simple_props_to_dai_codec(props, i);
+			sysclk_id = pdai->sysclk_id;
+
+			ret = snd_soc_dai_set_sysclk(sdai, sysclk_id, mclk,
+						     SND_SOC_CLOCK_IN);
 			if (ret && ret != -ENOTSUPP)
 				return ret;
 		}
 
 		for_each_rtd_cpu_dais(rtd, i, sdai) {
-			ret = snd_soc_dai_set_sysclk(sdai, 0, mclk, SND_SOC_CLOCK_OUT);
+			pdai = simple_props_to_dai_cpu(props, i);
+			sysclk_id = pdai->sysclk_id;
+
+			ret = snd_soc_dai_set_sysclk(sdai, pdai->sysclk_id, mclk,
+						     SND_SOC_CLOCK_OUT);
 			if (ret && ret != -ENOTSUPP)
 				return ret;
 		}
@@ -523,7 +534,8 @@ static int asoc_simple_init_dai(struct snd_soc_dai *dai,
 		return 0;
 
 	if (simple_dai->sysclk) {
-		ret = snd_soc_dai_set_sysclk(dai, 0, simple_dai->sysclk,
+		ret = snd_soc_dai_set_sysclk(dai, simple_dai->sysclk_id,
+					     simple_dai->sysclk,
 					     simple_dai->clk_direction);
 		if (ret && ret != -ENOTSUPP) {
 			dev_err(dai->dev, "simple-card: set_sysclk error\n");
@@ -858,6 +870,7 @@ int asoc_simple_init_priv(struct asoc_simple_priv *priv,
 			dai_link[i].cpus	= &priv->dummy;
 			dai_props[i].num.cpus	=
 			dai_link[i].num_cpus	= 1;
+			dai_props[i].cpu_dai	= &priv->dummy_dai;
 		}
 
 		if (li->num[i].codecs) {
@@ -882,6 +895,7 @@ int asoc_simple_init_priv(struct asoc_simple_priv *priv,
 			dai_link[i].codecs	= &priv->dummy;
 			dai_props[i].num.codecs	=
 			dai_link[i].num_codecs	= 1;
+			dai_props[i].codec_dai	= &priv->dummy_dai;
 		}
 
 		if (li->num[i].platforms) {
-- 
2.38.1

