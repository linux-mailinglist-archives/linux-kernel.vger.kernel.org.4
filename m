Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E3970A89D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 16:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjETO6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 10:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjETO6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 10:58:31 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3AD116
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 07:58:30 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 0O2LqG7MhArAu0O2Mqmq31; Sat, 20 May 2023 16:58:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684594708;
        bh=an1jU7hzklQhAPlftBGuyvpE99sqJqwyCvQdIs09g5U=;
        h=From:To:Cc:Subject:Date;
        b=nww41qSiv8Xnw/kdeokRlCyp37wJMyyNKn/rHP5EU6NjljbHg+hmJ01LiuLbO0pKH
         /Iakel18zuGasaCdwlZu22ApMilwLlHdOsE0qBNq8FvjfNJpXGt+920OZabAu0JwyX
         OJlaC0BE7W0vuNoHk0iLmNDq8J3AWigVeHJfaQIDoWAk9RzWnOxOBMif75sLDgjDwy
         iseb/rFVaqYryiAmIkOr4J/tgkpAceavcc4j3xDZhVB2TLjsFvY6pbzA8HBfJ87DtY
         c0LMzQxzMoilvaNA2pwR3hJWgYUnValLS7L43uQzPiqIc5H1Au0Cm+Mzr20YjEjE/Z
         MW4RFEfSFQTJQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 May 2023 16:58:28 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: rt5682s: Use the devm_clk_get_optional() helper
Date:   Sat, 20 May 2023 16:58:24 +0200
Message-Id: <f538c24ad7b1926478347a03b5b7f0432e195e3b.1684594691.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_get_optional() instead of hand writing it.
This saves some LoC and improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/codecs/rt5682s.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
index 81163b026b9e..a01de405c22c 100644
--- a/sound/soc/codecs/rt5682s.c
+++ b/sound/soc/codecs/rt5682s.c
@@ -2848,14 +2848,9 @@ static int rt5682s_dai_probe_clks(struct snd_soc_component *component)
 	int ret;
 
 	/* Check if MCLK provided */
-	rt5682s->mclk = devm_clk_get(component->dev, "mclk");
-	if (IS_ERR(rt5682s->mclk)) {
-		if (PTR_ERR(rt5682s->mclk) != -ENOENT) {
-			ret = PTR_ERR(rt5682s->mclk);
-			return ret;
-		}
-		rt5682s->mclk = NULL;
-	}
+	rt5682s->mclk = devm_clk_get_optional(component->dev, "mclk");
+	if (IS_ERR(rt5682s->mclk))
+		return PTR_ERR(rt5682s->mclk);
 
 	/* Register CCF DAI clock control */
 	ret = rt5682s_register_dai_clks(component);
-- 
2.34.1

