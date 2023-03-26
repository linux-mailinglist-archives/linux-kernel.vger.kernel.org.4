Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDBA6C9453
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 14:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjCZMnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 08:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCZMnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 08:43:45 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A0D7D9A
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:43:44 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id gPimpclLpV6zQgPimpzJp6; Sun, 26 Mar 2023 14:43:42 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 26 Mar 2023 14:43:42 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH] ASoC: meson: Use the devm_clk_get_optional() helper
Date:   Sun, 26 Mar 2023 14:43:38 +0200
Message-Id: <8dab942d6ce47657a9c038295959be80bb2ee09e.1679834598.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_get_optional() instead of hand writing it.
This saves some loC and improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/meson/axg-tdm-interface.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 7624aafe9009..5e5e4c56d505 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -496,7 +496,7 @@ static int axg_tdm_iface_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct snd_soc_dai_driver *dai_drv;
 	struct axg_tdm_iface *iface;
-	int ret, i;
+	int i;
 
 	iface = devm_kzalloc(dev, sizeof(*iface), GFP_KERNEL);
 	if (!iface)
@@ -533,14 +533,9 @@ static int axg_tdm_iface_probe(struct platform_device *pdev)
 	 * At this point, ignore the error if mclk is missing. We'll
 	 * throw an error if the cpu dai is master and mclk is missing
 	 */
-	iface->mclk = devm_clk_get(dev, "mclk");
-	if (IS_ERR(iface->mclk)) {
-		ret = PTR_ERR(iface->mclk);
-		if (ret == -ENOENT)
-			iface->mclk = NULL;
-		else
-			return dev_err_probe(dev, ret, "failed to get mclk\n");
-	}
+	iface->mclk = devm_clk_get_optional(dev, "mclk");
+	if (IS_ERR(iface->mclk))
+		return dev_err_probe(dev, PTR_ERR(iface->mclk), "failed to get mclk\n");
 
 	return devm_snd_soc_register_component(dev,
 					&axg_tdm_iface_component_drv, dai_drv,
-- 
2.34.1

