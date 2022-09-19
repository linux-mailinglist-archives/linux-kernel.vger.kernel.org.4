Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82025BD3D3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiISRf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiISRfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:35:18 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297E337F9D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:35:02 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1663608899; bh=d7mgKUnVCfrgkyGqmQzUJTvvGo3IZOIgUBZZ0DNTb8Q=;
        h=From:To:Cc:Subject:Date;
        b=Xg+liSKcnXx0197eHUxd/Uj9XdbE8M9EHtbSry38u4R02iAoyBeA5XNucQRba4liV
         /aV6rfGgdN7z8d5XnKEeYFYpihTrHzybfRvEWGDt/7QjtLFfp5QY2ZLZpw8y7T5BJB
         iS/9Urv3RPVoBaPfM4Z4IMotfYuLqGvFKt0mqDNo=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     navada@ti.com, Charles Keepax <ckeepax@opensource.cirrus.com>,
        Stephen Kitt <steve@sk2.org>, Dan Murphy <dmurphy@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH] ASoC: tas2770: Reinit regcache on reset
Date:   Mon, 19 Sep 2022 19:34:53 +0200
Message-Id: <20220919173453.84292-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On probe of the ASoC component, the device is reset but the regcache is
retained. This means the regcache gets out of sync if the codec is
rebound to a sound card for a second time. Fix it by reinitializing the
regcache to defaults after the device is reset.

Fixes: b0bcbe615756 ("ASoC: tas2770: Fix calling reset in probe")
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/codecs/tas2770.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index bb653b664146..b6765235a4b3 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -495,6 +495,8 @@ static struct snd_soc_dai_driver tas2770_dai_driver[] = {
 	},
 };
 
+static const struct regmap_config tas2770_i2c_regmap;
+
 static int tas2770_codec_probe(struct snd_soc_component *component)
 {
 	struct tas2770_priv *tas2770 =
@@ -508,6 +510,7 @@ static int tas2770_codec_probe(struct snd_soc_component *component)
 	}
 
 	tas2770_reset(tas2770);
+	regmap_reinit_cache(tas2770->regmap, &tas2770_i2c_regmap);
 
 	return 0;
 }
-- 
2.33.0

