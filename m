Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF6E6E066E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 07:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjDMF2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 01:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMF2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 01:28:41 -0400
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D69F4EDC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:28:39 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id mpVbpJJcvfW5impVbpzK6l; Thu, 13 Apr 2023 07:28:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1681363717;
        bh=HJ4uYohqhO5JqFEjEQUtiBcTsfOr+xM3+1DXKHvV6cY=;
        h=From:To:Cc:Subject:Date;
        b=nZEHyBk/1Xb/k7IkI84pd/6i44tpo4Ff3pgJ7RyPDu0zQ9KVAw6KdKGwes24HQdPI
         w6YlUxHyK6JkpqatV0INzjTy6N+YkMSMRMrqtWJHM2mCK1VYOrHq9z0p7I6ajndQHf
         /d1dOGA+w58EvmCp7euupSd7OKat3OelxhBa4+J9dqdpKdzsnHk51Q2nEmur/KaBZK
         qeC+nP7l60AUlsbqGWWenboze1Bqbtdt8fHbZrz1UisCFQQYn+GTjSRql1TDN1fFG1
         yWzXV6rBvtH+3CC8vta28nh9NoTwAMsQikBn8PaWEM9JAMDEThvxX2oHQULikFKlLp
         V69Ur+VhEifvA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 13 Apr 2023 07:28:37 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: da7218: Use devm_clk_get_optional()
Date:   Thu, 13 Apr 2023 07:28:33 +0200
Message-Id: <51976b2515d7007ba5c8aa7524892f147d7cdd51.1681363691.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_get_optional() instead of hand writing it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/codecs/da7218.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index 91372909d184..d9c28e701613 100644
--- a/sound/soc/codecs/da7218.c
+++ b/sound/soc/codecs/da7218.c
@@ -2893,14 +2893,10 @@ static int da7218_probe(struct snd_soc_component *component)
 	da7218_handle_pdata(component);
 
 	/* Check if MCLK provided, if not the clock is NULL */
-	da7218->mclk = devm_clk_get(component->dev, "mclk");
+	da7218->mclk = devm_clk_get_optional(component->dev, "mclk");
 	if (IS_ERR(da7218->mclk)) {
-		if (PTR_ERR(da7218->mclk) != -ENOENT) {
-			ret = PTR_ERR(da7218->mclk);
-			goto err_disable_reg;
-		} else {
-			da7218->mclk = NULL;
-		}
+		ret = PTR_ERR(da7218->mclk);
+		goto err_disable_reg;
 	}
 
 	/* Default PC to free-running */
-- 
2.34.1

