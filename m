Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B506E3C34
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 23:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjDPVny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 17:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDPVnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 17:43:52 -0400
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9767D1BF9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 14:43:50 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id oA9wpixEOfW5ioA9wp7C2p; Sun, 16 Apr 2023 23:43:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1681681428;
        bh=vF9mRhCUpfiJDniHjN1U8oMAgEUODJM62IemQiobv8s=;
        h=From:To:Cc:Subject:Date;
        b=gK7vGpkIcnWsmBbMq6CGRAW+XbhDDYYOymGG1wfwAs7vVyxn91J1Mx95f0U3Os9eQ
         guPsDh2gbxJS46QjmL+WgUsqXiTDztzb6vWYFLQVbYVvBl7hKfdaFiiUB3R90oS+hn
         1MCgcTADMkGMV83yWe2LvmQy8BRClnOHr2I2PyXiLLp0N5aTlZLTgb6MxjlTyQ27yC
         HyZhaGWX8phlPd9ARerhSwAwdFc620NA2qqSnEXXMQQiQBIdMKISxQ6GrJ3Ac3Keer
         mDquEVicZfPMpY3TFz+AzAbBVVy1bfu5s2hCn15QgA6rhxbDzpeTt5i0CHg5GKdmEt
         tX1e9sy1RpSQQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 16 Apr 2023 23:43:48 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-gpio@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pinctrl: bcm2835: Handle gpiochip_add_pin_range() errors
Date:   Sun, 16 Apr 2023 23:43:41 +0200
Message-Id: <98c3b5890bb72415145c9fe4e1d974711edae376.1681681402.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpiochip_add_pin_range() can fail, so better return its error code than
a hard coded '0'.

Fixes: d2b67744fd99 ("pinctrl: bcm2835: implement hook for missing gpio-ranges")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is speculative and compile tested only.

If it is wrong, maybe a comment explaining why 0 should be returned would
be welcomed.
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 8e2551a08c37..cb298fad354a 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -366,10 +366,8 @@ static int bcm2835_add_pin_ranges_fallback(struct gpio_chip *gc)
 	if (!pctldev)
 		return 0;
 
-	gpiochip_add_pin_range(gc, pinctrl_dev_get_devname(pctldev), 0, 0,
-			       gc->ngpio);
-
-	return 0;
+	return gpiochip_add_pin_range(gc, pinctrl_dev_get_devname(pctldev), 0, 0,
+				      gc->ngpio);
 }
 
 static const struct gpio_chip bcm2835_gpio_chip = {
-- 
2.34.1

