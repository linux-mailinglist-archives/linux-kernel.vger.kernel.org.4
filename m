Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB81670A891
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 16:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjETOvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 10:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjETOvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 10:51:00 -0400
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6771B9C
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 07:50:59 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 0Nv5qCAc8f2fi0Nv5qlWU3; Sat, 20 May 2023 16:50:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684594257;
        bh=Gs5jc+zEfJwVCuLHjEL/NLyniIuEyQrXlCdxCYb+hJA=;
        h=From:To:Cc:Subject:Date;
        b=e9DSYsnsS1ydxT+Dx6SGfc4dIS0EMtm5SjEC8HRqituPaP4K4jRRiAQMh8oO6N0rh
         1ea+gA1KhSIdWhmRCutIDkacVEJQkOBdN5GjkvZRP06EvdKjFudkN1K8rWu1v0r51M
         qeU86Dl2YIH5zmS042fE1gUVf752xCOc9TJD0ZuryOnjV0ZkOYJAz/3cdkg5MKc7wN
         C+u2ZWJnEv2wsQZgeam+kzkJbg6F55k/4Et0vTX+wC/areeSoKkiYLjL2vDAyZ4EHE
         N7nfFvnhjx6W095nnQPnbEl8A1j/GGQtOVX37tuhrITZq4ePm32WwdesNUStlTJFJD
         YUqKMEfu0yBbw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 May 2023 16:50:57 +0200
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
Subject: [PATCH] ASoC: cs42l51: Use the devm_clk_get_optional() helper
Date:   Sat, 20 May 2023 16:50:54 +0200
Message-Id: <3debf3bb7ea504ee9ca2d8eb0f948a426681cbdd.1684594240.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_get_optional() instead of hand writing it.
This saves some LoC and improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/codecs/cs42l51.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index e88d9ff95cdf..a67cd3ee84e0 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -724,12 +724,9 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 	dev_set_drvdata(dev, cs42l51);
 	cs42l51->regmap = regmap;
 
-	cs42l51->mclk_handle = devm_clk_get(dev, "MCLK");
-	if (IS_ERR(cs42l51->mclk_handle)) {
-		if (PTR_ERR(cs42l51->mclk_handle) != -ENOENT)
-			return PTR_ERR(cs42l51->mclk_handle);
-		cs42l51->mclk_handle = NULL;
-	}
+	cs42l51->mclk_handle = devm_clk_get_optional(dev, "MCLK");
+	if (IS_ERR(cs42l51->mclk_handle))
+		return PTR_ERR(cs42l51->mclk_handle);
 
 	for (i = 0; i < ARRAY_SIZE(cs42l51->supplies); i++)
 		cs42l51->supplies[i].supply = cs42l51_supply_names[i];
-- 
2.34.1

