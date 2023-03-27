Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F586CABEC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjC0Rg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjC0Rg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:36:56 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885701FD0;
        Mon, 27 Mar 2023 10:36:50 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Plg3d2hKyz9sQY;
        Mon, 27 Mar 2023 19:36:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1679938606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=erhiX1kWslYrQnsmeLq0Eijl2/NyUjXUqiUh7SiAOL4=;
        b=Z+NCmJiRBmaI4XZu26q+haVWgnaLtjwJk5782Ya5brwKjCkoB42NhqmmjRNoWgqglT7GEa
        C64Y5mBG9k8MZtgJXz6TjyuawegBFtwFbCGqCBHbHN4HWQXtwI98Ve7sXhymdqkjWV/B42
        2CklB4ntdahmFFaQvzroxdbnEsaXCyu1GxbHylA2p5ModoeqNaTEdsPsgL1mUDbOUJqtGx
        KtxriXyIPhxp9BUlMqhS1s2w4W/l7rfAdf0JiVPzycLmOqgvyQHeYqdTxuS+wUkhB67h3S
        9xGomaoDamqgfj6I8zTY/xDW11XitrRU2IwZae/KKyuX3Ik6rfm5LK+e93ZiJQ==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH v4] sound: soc: qcom: sdm845: expose ALSA control for jack
Date:   Mon, 27 Mar 2023 19:36:27 +0200
Message-Id: <20230327173627.361533-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Plg3d2hKyz9sQY
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm SDM845 features a headphone jack via a Qualcomm WCD9340
codec which has jack detection through the wcd-mbhc-v2 driver.
Jack detection is currently fully functional via the input
interface together with multimedia buttons, but is not exposed
as an ALSA control. Therefore, ALSA clients such as PulseAudio [1]
do not pick up the jack detection events as they only support
one of the possible interface (ALSA control or input interface,
but not both). Initialize the audio jack with snd_soc_card_jack_new_pins
instead of snd_soc_card_jack_new to make the jack also available as
an ALSA control.

[1] https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/1377

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
---

Changes in v4:

- Dropped cover letter because of a single patch.
- Reworked as a patch to the SDM845 Machine driver as suggested
  by Mark Brown.

Changes in v3:

- Improved cover letter
- Added Tested-by from
https://lore.kernel.org/alsa-devel/20221007155716.10594-1-me@dylanvanassche.be/
- Properly added maintainers for sending this patch

Kind regards,
Dylan Van Assche

 sound/soc/qcom/sdm845.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 02612af714a8..95888c5079a0 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -44,6 +44,14 @@ struct sdm845_snd_data {
 
 static unsigned int tdm_slot_offset[8] = {0, 4, 8, 12, 16, 20, 24, 28};
 
+static struct snd_soc_jack_pin sdm845_jack_pins[] = {
+	{
+		.pin = "Headphone Jack",
+		.mask = (SND_JACK_HEADPHONE | SND_JACK_MICROPHONE | SND_JACK_HEADSET |
+			 SND_JACK_MECHANICAL)
+	},
+};
+
 static int sdm845_slim_snd_hw_params(struct snd_pcm_substream *substream,
 				     struct snd_pcm_hw_params *params)
 {
@@ -242,12 +250,13 @@ static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
 
 
 	if (!pdata->jack_setup) {
-		rval = snd_soc_card_jack_new(card, "Headset Jack",
+		rval = snd_soc_card_jack_new_pins(card, "Headset Jack",
 				SND_JACK_HEADSET |
 				SND_JACK_HEADPHONE |
 				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				&pdata->jack);
+				&pdata->jack, sdm845_jack_pins,
+				ARRAY_SIZE(sdm845_jack_pins));
 
 		if (rval < 0) {
 			dev_err(card->dev, "Unable to add Headphone Jack\n");
-- 
2.39.2

