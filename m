Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91CE70EFAD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240030AbjEXHmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240025AbjEXHmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:42:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8529D;
        Wed, 24 May 2023 00:42:07 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2EC2F66059A4;
        Wed, 24 May 2023 08:42:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684914126;
        bh=JWCo/GiQIjgEd33TLlVz5h/VBvQ/u8Y9VSES2Wef+Cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=guHh2BSYUS5UFvmOnh4vu8yu95UUSTNL+6Y80h+c0yZCnhsjVELoebtXgv1s+kNvU
         YoAz+N+yTIWAGBVBXWvngfo+VXZUc6meYNielFhHZxlueddOveDw8wI/YzLOpAMXtI
         z0tNjhsfuSwhGOmos0t5yD/wW5RnwtVfoQhlx5QyzXh0p704epqPb96bfl3nclpZ3m
         4fipHtiioj1Z5mR16Pn1+akbINwMUwdYoUWg61UPKftKOGV6Ussew+lpNEjgDe8ozs
         nqNRVN0Tr4Rzi0xt0XjGzcI62ml4VP/8hMp8makZZDi4uAgN0p/eVXP2pt531T7j6T
         IsnTEQ5tiQTbw==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Zhu Ning <zhuning0077@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, kernel@collabora.com
Subject: [PATCH 2/3] ASoC: es8316: Do not set rate constraints for unsupported MCLKs
Date:   Wed, 24 May 2023 10:41:55 +0300
Message-Id: <20230524074156.147387-3-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524074156.147387-1-cristian.ciocaltea@collabora.com>
References: <20230524074156.147387-1-cristian.ciocaltea@collabora.com>
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

When using the codec through the generic audio graph card, there are at
least two calls of es8316_set_dai_sysclk(), with the effect of limiting
the allowed sample rates according to the MCLK/LRCK ratios supported by
the codec:

1. During audio card setup, to set the initial MCLK - see
   asoc_simple_init_dai().

2. Before opening a stream, to update MCLK, according to the stream
   sample rate and the multiplication factor - see
   asoc_simple_hw_params().

In some cases the initial MCLK might be set to a frequency that doesn't
match any of the supported ratios, e.g. 12287999 instead of 12288000,
which is only 1 Hz below the supported clock, as that is what the
hardware reports. This creates an empty list of rate constraints, which
is further passed to snd_pcm_hw_constraint_list() via
es8316_pcm_startup(), and causes the following error on the very first
access of the sound card:

  $ speaker-test -D hw:Analog,0 -F S16_LE -c 2 -t wav
  Broken configuration for playback: no configurations available: Invalid argument
  Setting of hwparams failed: Invalid argument

Note that all subsequent retries succeed thanks to the updated MCLK set
at point 2 above, which uses a computed frequency value instead of a
reading from the hardware registers. Normally this would have mitigated
the issue, but es8316_pcm_startup() executes before the 2nd call to
es8316_set_dai_sysclk(), hence it cannot make use of the updated
constraints.

Since es8316_pcm_hw_params() performs anyway a final validation of MCLK
against the stream sample rate and the supported MCLK/LRCK ratios, fix
the issue by ensuring that sysclk_constraints list is only set when at
least one supported sample rate is autodetected by the codec.

Fixes: b8b88b70875a ("ASoC: add es8316 codec driver")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/codecs/es8316.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 773c94fd3547..a78c0049a30c 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -386,7 +386,7 @@ static int es8316_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 			es8316->allowed_rates[count++] = freq / ratio;
 	}
 
-	es8316->sysclk_constraints.list = es8316->allowed_rates;
+	es8316->sysclk_constraints.list = count ? es8316->allowed_rates : NULL;
 	es8316->sysclk_constraints.count = count;
 
 	return 0;
-- 
2.40.1

