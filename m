Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54737744848
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 11:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjGAJsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 05:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGAJsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 05:48:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E981FE7;
        Sat,  1 Jul 2023 02:48:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8A9C60A57;
        Sat,  1 Jul 2023 09:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21377C433C7;
        Sat,  1 Jul 2023 09:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688204897;
        bh=NkKxEelQYImgUCH/jAULU1m4zxje/sLNSE+HtnnRpXY=;
        h=From:To:Cc:Subject:Date:From;
        b=arndB2iLmMRvRpc3Y5iGkNQUBEEp/2aZS8DrjgQZDBAhPD8GmBezKeXAw4RYSMmJ+
         L9v6h70XjzbT4GH0fTmi5zRAcvRpVQnCrdD3NcBJOPayzBwY+B2u4JPkg+NPlBKPJj
         V1AHyV25CERQ/pl8HU1oxRX+8xd49AtMsl+TDTq9leAUF0RibUj03Uv9cjlePemQCH
         jxfrh3gptWOi++lJ6//F6nkIkr5mcWGGtkVn5yIc+WLqGxCdEkeqBwQRqxOAAGl/rF
         XyBcYzcCUglWINtqWOTnrb3H0X7S0TYciVA/VhSLrU/opTtpb8xdqRf1TIH2fQSkRl
         J9wrW+fNXADiw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qFXDN-0007eM-Lo; Sat, 01 Jul 2023 11:48:25 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Steev Klimaszewski <steev@kali.org>
Subject: [PATCH] ASoC: codecs: wcd938x: fix soundwire initialisation race
Date:   Sat,  1 Jul 2023 11:47:23 +0200
Message-Id: <20230701094723.29379-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that the soundwire device used for register accesses has been
enumerated and initialised before trying to read the codec variant
during component probe.

This specifically avoids interpreting (a masked and shifted) -EBUSY
errno as the variant:

	wcd938x_codec audio-codec: ASoC: error at soc_component_read_no_lock on audio-codec for register: [0x000034b0] -16

in case the soundwire device has not yet been initialised, which in turn
prevents some headphone controls from being registered.

Fixes: 8d78602aa87a ("ASoC: codecs: wcd938x: add basic driver")
Cc: stable@vger.kernel.org	# 5.14
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reported-by: Steev Klimaszewski <steev@kali.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/wcd938x.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index e3ae4fb2c4db..4571588fad62 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3080,9 +3080,18 @@ static int wcd938x_irq_init(struct wcd938x_priv *wcd, struct device *dev)
 static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 {
 	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+	struct sdw_slave *tx_sdw_dev = wcd938x->tx_sdw_dev;
 	struct device *dev = component->dev;
+	unsigned long time_left;
 	int ret, i;
 
+	time_left = wait_for_completion_timeout(&tx_sdw_dev->initialization_complete,
+						msecs_to_jiffies(2000));
+	if (!time_left) {
+		dev_err(dev, "soundwire device init timeout\n");
+		return -ETIMEDOUT;
+	}
+
 	snd_soc_component_init_regmap(component, wcd938x->regmap);
 
 	ret = pm_runtime_resume_and_get(dev);
-- 
2.39.3

