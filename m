Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136775E7065
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 02:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiIWAAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 20:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiIWAAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 20:00:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ED87435D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 17:00:02 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [71.190.76.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2227C6602232;
        Fri, 23 Sep 2022 00:59:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663891199;
        bh=vvjVtvI3wHKKEr7/3vOsCQXLkdfJFdUPXRSTytaHoMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZThd4pFyNYKjwnLwGvDV46S8HUeVjZgaTEdZLNgI1Wg6hX7YO8BCGh8L/N3AqSZmk
         ioKwaeSmSYXwIu7PdNANhRB2V2/NPI+IwhNmtKHHmDlFCD4J0iDbTA/Nf/4fqe3ooc
         y2LHkSk8Ql0ohvzn2LSna2G6b5OC89p9w5PS9dlxv7CLx1cOJfT6ZBP+I3YEy2kkjc
         O3/MNfWOWGNdvnJQaskhRlf4AlwaMHgIAomOdDpLFIG6/obHgByMvTidnjQ9frdvnS
         QpL5QYUcuB4H3QiEynhyJpWWX63nKWXjK6uw+jTQOLLLNLD36kZP1KtMifo5l4pVQ5
         DB0MnGu8fJJAA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 1/6] ASoC: mediatek: mt8192-mt6359: Expose individual headset jack pins
Date:   Thu, 22 Sep 2022 19:59:46 -0400
Message-Id: <20220922235951.252532-2-nfraprado@collabora.com>
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

The rt5682 codec is able to distinguish between two event types:
headphone insertion/removal and headset microphone insertion/removal.
However, currently, the mt8192-mt6359 driver exposes a single kcontrol
for the headset jack, so userspace isn't able to differentiate between
the two events.

Add a definition for the headset jack pins, so that a separate jack
kcontrol is created for each one, allowing userspace to track and handle
them individually.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 .../mt8192/mt8192-mt6359-rt1015-rt5682.c        | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index 044d6ab71f0a..ff40ccd36f7e 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -41,6 +41,18 @@ struct mt8192_mt6359_priv {
 	struct snd_soc_jack hdmi_jack;
 };
 
+/* Headset jack detection DAPM pins */
+static struct snd_soc_jack_pin mt8192_jack_pins[] = {
+	{
+		.pin = "Headphone Jack",
+		.mask = SND_JACK_HEADPHONE,
+	},
+	{
+		.pin = "Headset Mic",
+		.mask = SND_JACK_MICROPHONE,
+	},
+};
+
 static int mt8192_rt1015_i2s_hw_params(struct snd_pcm_substream *substream,
 				       struct snd_pcm_hw_params *params)
 {
@@ -326,11 +338,12 @@ static int mt8192_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	ret = snd_soc_card_jack_new(rtd->card, "Headset Jack",
+	ret = snd_soc_card_jack_new_pins(rtd->card, "Headset Jack",
 				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
 				    SND_JACK_BTN_1 | SND_JACK_BTN_2 |
 				    SND_JACK_BTN_3,
-				    jack);
+				    jack, mt8192_jack_pins,
+				    ARRAY_SIZE(mt8192_jack_pins));
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack creation failed: %d\n", ret);
 		return ret;
-- 
2.37.3

