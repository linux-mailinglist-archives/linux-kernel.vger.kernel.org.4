Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23BD6E356C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 08:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjDPG3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 02:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDPG3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 02:29:42 -0400
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03732F4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 23:29:39 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id nvtHpgynZXvOInvtIpyMwd; Sun, 16 Apr 2023 08:29:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1681626578;
        bh=4/y1p+J5P4sf9MxwjHggSXgJ0J0v9pbQqECTb6NgUf0=;
        h=From:To:Cc:Subject:Date;
        b=SEYoFLJ6cBxSp77oZjHGudkSCN1Wdu0QQVaXUXyD9Tc7lStPCIDuudzD3KLpRMLp+
         Pxw34MSPnY20YyCGeujLsredFK6iTizuhxu0H3P0Td9pvLCOZXzpigRMvq45ejxB3R
         1blo9xNCmMMkqV7eRL48PBVqbiQFOxyhbxZUZlsBS8RGwGD3vKAcB03EiwF6wycErv
         65wMuxCHWjOSFmughp/lS19wEEEXywu/G4DHvYkWAzVZebWM02j1cTkMlf1yHvLQeg
         oYG8rJABQnn3qBdK7bVNkUYGVfgR4ZJ/oJgLgkohRx0lhhNJDl81g9uTJRicEwoFsV
         17SKFihW4aQeA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 16 Apr 2023 08:29:38 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ASoC: fsl: Simplify an error message
Date:   Sun, 16 Apr 2023 08:29:34 +0200
Message-Id: <c167c16a535049d56f817bbede9c9f6f0a0f4c68.1681626553.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err_probe() already display the error code. There is no need to
duplicate it explicitly in the error message.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/fsl/fsl-asoc-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index bffa1048d31e..40870668ee24 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -858,7 +858,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 
 	ret = devm_snd_soc_register_card(&pdev->dev, &priv->card);
 	if (ret) {
-		dev_err_probe(&pdev->dev, ret, "snd_soc_register_card failed: %d\n", ret);
+		dev_err_probe(&pdev->dev, ret, "snd_soc_register_card failed\n");
 		goto asrc_fail;
 	}
 
-- 
2.34.1

