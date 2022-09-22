Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341905E6BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiIVTpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiIVTpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:45:05 -0400
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085253334E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:45:04 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id bS84oQyft94embS84oAvYz; Thu, 22 Sep 2022 21:45:02 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 22 Sep 2022 21:45:02 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: da7219: Fix an error handling path in da7219_register_dai_clks()
Date:   Thu, 22 Sep 2022 21:44:57 +0200
Message-Id: <e4acceab57a0d9e477a8d5890a45c5309e553e7c.1663875789.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If clk_hw_register() fails, the corresponding clk should not be
unregistered.

To handle errors from loops, clean up partial iterations before doing the
goto.  So add a clk_hw_unregister().
Then use a while (--i >= 0) loop in the unwind section.

Fixes: 78013a1cf297 ("ASoC: da7219: Fix clock handling around codec level probe")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
See https://lore.kernel.org/all/4fdde55198294a07f04933f7cef937fcb654c901.1624425670.git.christophe.jaillet@wanadoo.fr/
for an incomplete patch sent last year and Dan's comment on it.
---
 sound/soc/codecs/da7219.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 50ecf30e6136..4746c8700451 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -2196,6 +2196,7 @@ static int da7219_register_dai_clks(struct snd_soc_component *component)
 			dai_clk_lookup = clkdev_hw_create(dai_clk_hw, init.name,
 							  "%s", dev_name(dev));
 			if (!dai_clk_lookup) {
+				clk_hw_unregister(dai_clk_hw);
 				ret = -ENOMEM;
 				goto err;
 			} else {
@@ -2217,12 +2218,12 @@ static int da7219_register_dai_clks(struct snd_soc_component *component)
 	return 0;
 
 err:
-	do {
+	while (--i >= 0) {
 		if (da7219->dai_clks_lookup[i])
 			clkdev_drop(da7219->dai_clks_lookup[i]);
 
 		clk_hw_unregister(&da7219->dai_clks_hw[i]);
-	} while (i-- > 0);
+	}
 
 	if (np)
 		kfree(da7219->clk_hw_data);
-- 
2.34.1

