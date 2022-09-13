Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66F45B7CAD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 23:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiIMVXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 17:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiIMVXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 17:23:32 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CC06B65E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 14:23:07 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w8so22106896lft.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 14:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=s9fWB+KIpWEfG0ChDe1LcnxfLz16/kGFFSIfjNPpFqg=;
        b=PFSKJZ6gXwhxNTRmtTVhaeQp46N+lP4VFWn/lQvm2dv0lKJ+ah8FUS5waaRZoZ9RVs
         TJHS2AGrgxI29RRAmLT9EJZFTvbQSopCWNEjNpAUL2QijGQFQJECoAEAIAsTTC2ZskBg
         qIn79PNZHDQ8/Ae27hX0fyiU/UHXr9+jbNzxtHFAMCD4Ju/UQ++1zPEP9yaDLxTMEUVn
         r58L3YJxIdUuZVPZeU471yBBWlLnj1+li4hj1sKKKkwHWET7uWm3Mja8T5hG8M9oFAJO
         1w4d5oy3+pqBl3WbCafGgg6rWWnwSHXXt7fAA1z+rGzILMywDlcP1EEDGx19P37AfpbR
         x/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=s9fWB+KIpWEfG0ChDe1LcnxfLz16/kGFFSIfjNPpFqg=;
        b=33HN+eBBeFJIZ11GsKjzI0f4Awbm8FLFZiFgnv8334o7HmcU1kD/dBatbnhGqglQ+V
         SeeE3dkhj6toCROY6OxGy1q4vxO3IiOZ+w5Ks1Fj7f0GwJ+CSfVOTnRs34eBHiHaS85I
         V+akT3IPNmhE8NTHPdHqzxcRNBu/0yQZYjBo77NkZlQ/S8UXaMzSaobl4rOkteuPBc/U
         Kr4RVyGloShUD7VatfAmgyyebN6VBwIqDzKrkrcSM2I3ZLkJV4VeKqKr4MctvfQ969mh
         PzVb7XbaRBGIjK4LacMwpK/ZHuW6xkeUFYOEhdLHlJRIGoIlPQuG5/E1kVvoJW5pjVGW
         xz1g==
X-Gm-Message-State: ACgBeo1rBVl7WSEFrO2L5Ho9B+NNMTuv6XbEwbwb0CDdM0j7a8zIC9CY
        EW7jsPNvO9itKjydX/oaRp0=
X-Google-Smtp-Source: AA6agR7Omz0Ba3AN6qiv2ULvX39qzey9tyjPowF3y2cHjuujTfPT0e38hrLtPKHjw1JIch+djby9Zw==
X-Received: by 2002:a05:6512:4002:b0:499:280:9c5b with SMTP id br2-20020a056512400200b0049902809c5bmr7376695lfb.593.1663104185266;
        Tue, 13 Sep 2022 14:23:05 -0700 (PDT)
Received: from localhost (95-31-185-216.broadband.corbina.ru. [95.31.185.216])
        by smtp.gmail.com with ESMTPSA id 28-20020ac25f5c000000b004998d9ccb62sm1597517lfz.99.2022.09.13.14.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 14:23:04 -0700 (PDT)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Li Chen <lchen@ambarella.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ASoC: sunxi: sun4i-codec: set debugfs_prefix for CPU DAI component
Date:   Wed, 14 Sep 2022 00:22:55 +0300
Message-Id: <20220913212256.151799-2-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220913212256.151799-1-mike.rudenko@gmail.com>
References: <YyCqC2EypxnoJFk7@sirena.org.uk>
 <20220913212256.151799-1-mike.rudenko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present, succesfull probing of H3 Codec results in an error

    debugfs: Directory '1c22c00.codec' with parent 'H3 Audio Codec' already present!

This is caused by a directory name conflict between codec
components. Fix it by setting debugfs_prefix for the CPU DAI
component.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
changes in v2:
- rebase against current tree
- add #ifdef CONFIG_DEBUG_FS guard
- change prefix from "dai" to more specific "cpu"

 sound/soc/sunxi/sun4i-codec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 3a7075d03c23..835dc3404367 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1232,6 +1232,9 @@ static const struct snd_soc_component_driver sun8i_a23_codec_codec = {
 static const struct snd_soc_component_driver sun4i_codec_component = {
 	.name			= "sun4i-codec",
 	.legacy_dai_naming	= 1,
+#ifdef CONFIG_DEBUG_FS
+	.debugfs_prefix		= "cpu",
+#endif
 };

 #define SUN4I_CODEC_RATES	SNDRV_PCM_RATE_CONTINUOUS
--
2.37.3
