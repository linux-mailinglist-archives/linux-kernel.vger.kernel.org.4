Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E7E70A894
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 16:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjETOyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 10:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjETOyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 10:54:12 -0400
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF38115
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 07:54:11 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 0NyCq5nVtRkO40NyCqQaRc; Sat, 20 May 2023 16:54:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684594450;
        bh=4Jkf7tHnTYvxjLJZ8lnVCybLulN7KeUyeXRkBsmgzrk=;
        h=From:To:Cc:Subject:Date;
        b=CQsi4hW5hW8Fi6yChUdbDdgH8S3NNSLxiKVNSkKVHPjl1VoDPJ3kAezwkUamXg7xr
         pkaR5tD7fPeTqTejMYZzMX/7m8DJVFCGqyaQCSqeYsgzI82E7SRHweAZ20iyS7w2dH
         nYO2sdq/e4yK91+N5su1cuC89GaajG3e/UWjY546vTZUA87XOsZyzuKD3fd9UgNNrR
         x5pGqWAH12CrIanHxxFo6dKPWxXeEUF14DEQfLngxmh3Sh0JzwQdjN+jIuqwQE7Wjq
         VlI5LLoNDS2sXTny/zYkgNBE6yxnY8ro3IQhCR43HUtxCpYSQ5w3gs4LPtEx7k4TfH
         8qQDCVAbS+96w==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 May 2023 16:54:10 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com
Subject: [PATCH] ASoC: cs53l30: Use the devm_clk_get_optional() helper
Date:   Sat, 20 May 2023 16:54:06 +0200
Message-Id: <3219effee5c7f190530bdb1ef8ec35cb142e3611.1684594433.git.christophe.jaillet@wanadoo.fr>
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
 sound/soc/codecs/cs53l30.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index 51ca66e7b3ea..21962b828ab1 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -990,14 +990,10 @@ static int cs53l30_i2c_probe(struct i2c_client *client)
 	}
 
 	/* Check if MCLK provided */
-	cs53l30->mclk = devm_clk_get(dev, "mclk");
+	cs53l30->mclk = devm_clk_get_optional(dev, "mclk");
 	if (IS_ERR(cs53l30->mclk)) {
-		if (PTR_ERR(cs53l30->mclk) != -ENOENT) {
-			ret = PTR_ERR(cs53l30->mclk);
-			goto error;
-		}
-		/* Otherwise mark the mclk pointer to NULL */
-		cs53l30->mclk = NULL;
+		ret = PTR_ERR(cs53l30->mclk);
+		goto error;
 	}
 
 	/* Fetch the MUTE control */
-- 
2.34.1

