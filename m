Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC6B70A8A3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 17:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjETPA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 11:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjETPA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 11:00:56 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396D1118
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 08:00:55 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 0O4hqFQmweM6M0O4iqgCiP; Sat, 20 May 2023 17:00:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684594853;
        bh=5VvxviU32EnF0yUc09qoA4jqdLeStDT9+mAuA1G4mT8=;
        h=From:To:Cc:Subject:Date;
        b=QyT70HvV0e5RPfiuGIrnDb/2Rni0o2JNkfLH9Xnif4lQWNXymjTE4Pp8pXFvUuufv
         jAodpg9v2ARZslta04J0XOkseNB0plN7Gta57uvW+RwcGBsd7ANChzHaTYEYD67/A+
         t7RPE59bhX6x1mwoaaOB9xIzomKA+h3J9Mw4f5dlJAjBzp6AiAP6HfM/kYYjfUe2ag
         KFSdS66CHdYGz8ctvva/4/sAhcqImOmUZ59GMfyExKNsrSFaXWfWd6daxlaVOaP392
         1TdFD5Xk+Tz2/xAKb3gbZoPbaFloiA5dtXhg6vRLml1TapBPcqtUSMNUmu+as7ZIf6
         MOMw8Bb4h58YQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 May 2023 17:00:53 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alsa-devel@alsa-project.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ASoC: stm32: sai: Use the devm_clk_get_optional() helper
Date:   Sat, 20 May 2023 17:00:50 +0200
Message-Id: <f7987f18dadf77bfa09969fd4c82d5a0f4e4e3b7.1684594838.git.christophe.jaillet@wanadoo.fr>
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
 sound/soc/stm/stm32_sai_sub.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index f6695dee353b..271ec5b3378d 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1485,12 +1485,9 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 		if (ret < 0)
 			return ret;
 	} else {
-		sai->sai_mclk = devm_clk_get(&pdev->dev, "MCLK");
-		if (IS_ERR(sai->sai_mclk)) {
-			if (PTR_ERR(sai->sai_mclk) != -ENOENT)
-				return PTR_ERR(sai->sai_mclk);
-			sai->sai_mclk = NULL;
-		}
+		sai->sai_mclk = devm_clk_get_optional(&pdev->dev, "MCLK");
+		if (IS_ERR(sai->sai_mclk))
+			return PTR_ERR(sai->sai_mclk);
 	}
 
 	return 0;
-- 
2.34.1

