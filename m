Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB9F70A89A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 16:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjETO4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 10:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjETO4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 10:56:07 -0400
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D00C115
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 07:56:05 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 0O00q7RjWHWsH0O01qRG48; Sat, 20 May 2023 16:56:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684594563;
        bh=bpLpYwHdElG8Zrz72XZdWqpkdWbasWrKHm81qJngWNM=;
        h=From:To:Cc:Subject:Date;
        b=esUdMWBLA/phoUXHm4JrlWfMI2UdxVyfevFMmMduOK0jOBFkLSDf3VzJpbi/iO2Rj
         9Jv1y74+6CMKzngQNBOl0ul5oJ2dlSxrYU/mJA3ZcNelQjj4wcZBpWrDDdNv/oP49q
         C2PTMQmDBu1OfRWeknabq78rfQE57kp8AWWXK1dXMuIzqIzn9OF34r5Hq76d+3oX3u
         BTa8VDKgyir2/HrIH5zN+xuhTQrmM/D6GyWdZn2lWHBaqblzqZHKY7jcCcRfebZ7il
         M/WvdvtmLtie2wXciOf/Ey6Xgi/3I3eV36zXk6ZfRr7WPx64IfaX+08f3glUi9AP1N
         1yvBcMnrcPc7Q==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 May 2023 16:56:03 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: rt5659: Use the devm_clk_get_optional() helper
Date:   Sat, 20 May 2023 16:56:00 +0200
Message-Id: <5b44b2fddd8973e949e4ae2132971b147cfd1ec1.1684594544.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_get_optional() instead of hand writing it.
This saves some LoC and improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/codecs/rt5659.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 22bb57029bc0..df6f0d769bbd 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -4141,13 +4141,9 @@ static int rt5659_i2c_probe(struct i2c_client *i2c)
 	regmap_write(rt5659->regmap, RT5659_RESET, 0);
 
 	/* Check if MCLK provided */
-	rt5659->mclk = devm_clk_get(&i2c->dev, "mclk");
-	if (IS_ERR(rt5659->mclk)) {
-		if (PTR_ERR(rt5659->mclk) != -ENOENT)
-			return PTR_ERR(rt5659->mclk);
-		/* Otherwise mark the mclk pointer to NULL */
-		rt5659->mclk = NULL;
-	}
+	rt5659->mclk = devm_clk_get_optional(&i2c->dev, "mclk");
+	if (IS_ERR(rt5659->mclk))
+		return PTR_ERR(rt5659->mclk);
 
 	rt5659_calibrate(rt5659);
 
-- 
2.34.1

