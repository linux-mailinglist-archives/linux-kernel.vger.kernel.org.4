Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC4A5E7066
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 02:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiIWAAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 20:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiIWAAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 20:00:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC627E029
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 17:00:06 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [71.190.76.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F21C96602238;
        Fri, 23 Sep 2022 01:00:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663891205;
        bh=ISOW3z3UoH6ajFB2isdB1bDkL2oaj2boZn5kSY9GOek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fXD++uf1S/DU/o3qgoQuzLEuPjsV/8hsGcGH6JPA8b0kISH6CZxN/3z2fpHs7EZSQ
         xxEF8xEIQdzaJAnQDGQ6YFRMteV0jGr+ITZ0pv0M5FSrDQz9mokez4g9pJnIlCe/fN
         f5x2amI/KWrPugmS0QoAP7NRckfVaWUfs4gKsWsXwbG0YOGbkwWOXB4IkmH5cpWtta
         ctaHvw2ONYX8+SjYLXxY876Ee5md+TzaxFAUb1A6JRblSvLusp/Ht7DBuuLsh9qi5P
         zrcosJqUwBx+2wdfVmmaJZ5m+wndV6Gsms+TmlclU4lZOzcbBbfznKezFNmxzbmFkI
         kxizSUPJb88dA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        "chunxu.li" <chunxu.li@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 4/6] ASoC: mediatek: mt8186-da7219: Expose individual headset jack pins
Date:   Thu, 22 Sep 2022 19:59:49 -0400
Message-Id: <20220922235951.252532-5-nfraprado@collabora.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922235951.252532-1-nfraprado@collabora.com>
References: <20220922235951.252532-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The da7219 codec is able to distinguish between two event types:
headphone insertion/removal and headset microphone insertion/removal.
However, currently, the mt8186-da7219 driver exposes a single kcontrol
for the headset jack, so userspace isn't able to differentiate between
the two events.

Add a definition for the headset jack pins, so that a separate jack
kcontrol is created for each one, allowing userspace to track and handle
them individually.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 .../mt8186/mt8186-mt6366-da7219-max98357.c      | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
index 8d428bc4a3b2..cfca6bdee834 100644
--- a/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
@@ -37,6 +37,18 @@ struct mt8186_mt6366_da7219_max98357_priv {
 	struct snd_soc_jack headset_jack, hdmi_jack;
 };
 
+/* Headset jack detection DAPM pins */
+static struct snd_soc_jack_pin mt8186_jack_pins[] = {
+	{
+		.pin = "Headphones",
+		.mask = SND_JACK_HEADPHONE,
+	},
+	{
+		.pin = "Headset Mic",
+		.mask = SND_JACK_MICROPHONE,
+	},
+};
+
 static struct snd_soc_codec_conf mt8186_mt6366_da7219_max98357_codec_conf[] = {
 	{
 		.dlc = COMP_CODEC_CONF("mt6358-sound"),
@@ -72,11 +84,12 @@ static int mt8186_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	/* Enable Headset and 4 Buttons Jack detection */
-	ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
+	ret = snd_soc_card_jack_new_pins(rtd->card, "Headset Jack",
 				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
 				    SND_JACK_BTN_1 | SND_JACK_BTN_2 |
 				    SND_JACK_BTN_3 | SND_JACK_LINEOUT,
-				    jack);
+				    jack, mt8186_jack_pins,
+				    ARRAY_SIZE(mt8186_jack_pins));
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack creation failed: %d\n", ret);
 		return ret;
-- 
2.37.3

