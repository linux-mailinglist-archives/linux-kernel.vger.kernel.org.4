Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EC95E8B25
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 11:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbiIXJus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 05:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbiIXJui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 05:50:38 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AEEA894F
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 02:50:35 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so2381272pjh.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 02:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XvnLxeE0AO/sb9+4Q89V2vzbus4Cqug44xbFR5p3YOU=;
        b=ftJ39f4E1m8gmH8TmgOHpWD8mg832NoK+mK2tkeja4ah6OjfQBSygn3EIuISW/rbmY
         D8yd1R1FLeD2h4tRAt5Ts+BTzM9usF9kZsJmHxvdwL7jPzZftwRubtoceGwoHKnCYbMU
         npbhvwEB7oet7j3JsZX7b1YWjiGlGyAmSvHyPjnV6Z5lZ13Pacld1WJ9vPkNrZ9W/wKV
         CU6iw7blWe1IrvE9FP9HGkYq9uB7XciRNeN7pgl4IE1o4L+iMDobCnX4dLI/ERGyPKZu
         39y6VQw72DjXt1aavpBiOYSiDxy8lFysP+aJZvQvOCRYXldAmfy524PPjCGnKpc0wJvb
         Y1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XvnLxeE0AO/sb9+4Q89V2vzbus4Cqug44xbFR5p3YOU=;
        b=kRLwmHFqIKd5pgzL0JW8QD5Hy9xR7qJVM6HDHKvU48PWNXIlUZhz9gFGRc+HpFNj6P
         M0JXHimeJp+l2D3HGSDCmyYdI9owF6Dqc/0dYJ4T5oomJn6lZPdR0ON2gO8FaAfyumzp
         c9WDoMex1wBw9OjiXpMrAjDgy/YeMSUF6NdvnQAV0OZCAwY2KNQeuQfuR0TaumuTli29
         icuVRSSe3d2pfQ3d4+kz/P3dmPsmYsPirSjwhfgeToi75MOs8+iE2GqI/KJZbWVrNhAF
         J8IUDKjFl7blMYpnOogU2SATAXsbfvNPBCzMeE8FvU8lgSO4CyCrI4/EsD4ELtLcGnKG
         YAEg==
X-Gm-Message-State: ACrzQf1/GGZE6KJdSP3X7kiLVABFUZy6BZUqluxiD62wKUiy3SI4bYmg
        Uj3B2XnOWXc0eq7Fy3PVRD4=
X-Google-Smtp-Source: AMsMyM5nelo22CdgC7JmIDrjRFDB7bs738j3UegAaYnT3tFCz3RV59HX5wD7fY6qYXB0K58BqzGqTw==
X-Received: by 2002:a17:90b:1650:b0:205:65db:d6eb with SMTP id il16-20020a17090b165000b0020565dbd6ebmr13320796pjb.246.1664013034691;
        Sat, 24 Sep 2022 02:50:34 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id r11-20020a170902be0b00b00176c0e055f8sm7340223pls.64.2022.09.24.02.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 02:50:34 -0700 (PDT)
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Akihiko Odaki <akihiko.odaki@gmail.com>
Subject: [PATCH 2/2] ASoC: amd: acp3x-5682: Expose individual headset jack pins
Date:   Sat, 24 Sep 2022 18:50:25 +0900
Message-Id: <20220924095025.7778-2-akihiko.odaki@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220924095025.7778-1-akihiko.odaki@gmail.com>
References: <20220924095025.7778-1-akihiko.odaki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rt5682 codec is able to distinguish between two event types:
headphone insertion/removal and headset microphone insertion/removal.
However, currently, the acp3x-5682 driver exposes a single kcontrol
for the headset jack, so userspace isn't able to differentiate between
the two events.

Add a definition for the headset jack pins, so that a separate jack
kcontrol is created for each one, allowing userspace to track and handle
them individually.

This change is based on commit 194ff8db0378 ("ASoC: mediatek:
mt8192-mt6359: Expose individual headset jack pins").

Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
---
 sound/soc/amd/acp3x-rt5682-max9836.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index 0bdd9c26dd22..3679931a2285 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -39,6 +39,17 @@ enum {
 	EC,
 };
 
+static struct snd_soc_jack_pin acp3x_5682_jack_pins[] = {
+	{
+		.pin	= "Headphone Jack",
+		.mask	= SND_JACK_HEADPHONE,
+	},
+	{
+		.pin	= "Headset Mic",
+		.mask	= SND_JACK_MICROPHONE,
+	},
+};
+
 static int acp3x_5682_init(struct snd_soc_pcm_runtime *rtd)
 {
 	int ret;
@@ -86,11 +97,12 @@ static int acp3x_5682_init(struct snd_soc_pcm_runtime *rtd)
 	rt5682_dai_wclk = clk_get(component->dev, "rt5682-dai-wclk");
 	rt5682_dai_bclk = clk_get(component->dev, "rt5682-dai-bclk");
 
-	ret = snd_soc_card_jack_new(card, "Headset Jack",
+	ret = snd_soc_card_jack_new_pins(card, "Headset Jack",
 				SND_JACK_HEADSET |
 				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				&pco_jack);
+				&pco_jack, acp3x_5682_jack_pins,
+				ARRAY_SIZE(acp3x_5682_jack_pins));
 	if (ret) {
 		dev_err(card->dev, "HP jack creation failed %d\n", ret);
 		return ret;
-- 
2.37.3

