Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BD9733FFF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 11:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbjFQJ5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 05:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjFQJ5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 05:57:20 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530CB172C
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 02:57:18 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id ASgAqUsC7EYhqASgBqk5h0; Sat, 17 Jun 2023 11:57:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686995835;
        bh=haiC7wDeOkzD6Zrppzqp1H4WJr8jevDuZHEsdYQ8KDc=;
        h=From:To:Cc:Subject:Date;
        b=ali9cnV7fC8/R6pOrB1uVH0nh2XxHo70SOAnhlm3Zi+WfN/0mgK/mxUKsSbz8H65x
         oVetSEqsuZy9z1U6t4X0Rv4Xx/K1GnahMxK9pwQG90CfShmI9U8W3YXQzfdIMLU89B
         D0b1VTqRiYzTGjhdfGoz6i3NBoOmi41gNYFtlBNP6+onKSguXa3sFgmYo6c3W/Sd1x
         Vb/vh9QgiNU0ErO5qN6l1c0f98OdxRpRIO+TtJJSozVToRPG/JUzK32gfEmvpg4fIf
         sjvmvqn+hCZCviVbY+J6BHyi3G+jyFiwWv6JIDm2sZvfQK0VlmQUkvsQ0vte4cFyp6
         i065cPRc9jVLg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 17 Jun 2023 11:57:15 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Johan Hovold <johan@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] gnss: Use devm_regulator_get_enable_optional()
Date:   Sat, 17 Jun 2023 11:57:09 +0200
Message-Id: <62effa7aa1a2023a77709e6416c57d9cb79a5ccc.1686995765.git.christophe.jaillet@wanadoo.fr>
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

Use devm_regulator_get_enable_optional() instead of hand writing it. It
saves some line of code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Note that regulator_disable() is now called after gnss_serial_free() in
the error handling path of the probe and in the remove function, but it
looks harmless to me.
---
 drivers/gnss/mtk.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/gnss/mtk.c b/drivers/gnss/mtk.c
index c62b1211f4fe..d3d31295d4e0 100644
--- a/drivers/gnss/mtk.c
+++ b/drivers/gnss/mtk.c
@@ -17,7 +17,6 @@
 #include "serial.h"
 
 struct mtk_data {
-	struct regulator *vbackup;
 	struct regulator *vcc;
 };
 
@@ -87,30 +86,16 @@ static int mtk_probe(struct serdev_device *serdev)
 		goto err_free_gserial;
 	}
 
-	data->vbackup = devm_regulator_get_optional(&serdev->dev, "vbackup");
-	if (IS_ERR(data->vbackup)) {
-		ret = PTR_ERR(data->vbackup);
-		if (ret == -ENODEV)
-			data->vbackup = NULL;
-		else
-			goto err_free_gserial;
-	}
-
-	if (data->vbackup) {
-		ret = regulator_enable(data->vbackup);
-		if (ret)
-			goto err_free_gserial;
-	}
+	ret = devm_regulator_get_enable_optional(&serdev->dev, "vbackup");
+	if (ret)
+		goto err_free_gserial;
 
 	ret = gnss_serial_register(gserial);
 	if (ret)
-		goto err_disable_vbackup;
+		goto err_free_gserial;
 
 	return 0;
 
-err_disable_vbackup:
-	if (data->vbackup)
-		regulator_disable(data->vbackup);
 err_free_gserial:
 	gnss_serial_free(gserial);
 
@@ -120,11 +105,8 @@ static int mtk_probe(struct serdev_device *serdev)
 static void mtk_remove(struct serdev_device *serdev)
 {
 	struct gnss_serial *gserial = serdev_device_get_drvdata(serdev);
-	struct mtk_data *data = gnss_serial_get_drvdata(gserial);
 
 	gnss_serial_deregister(gserial);
-	if (data->vbackup)
-		regulator_disable(data->vbackup);
 	gnss_serial_free(gserial);
 }
 
-- 
2.34.1

