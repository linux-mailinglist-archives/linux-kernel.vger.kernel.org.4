Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1AA65EFA6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjAEPGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjAEPGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:06:16 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8534BD52
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:06:14 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 17F2075;
        Thu,  5 Jan 2023 16:06:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1672931172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EF2eIHMM0/bse1Ygy2mGPcB63S0svTOuyeNiDsJqQR0=;
        b=AAhTa/FbXoBbqEkuWdx/tWRUaIz+T9vcRrK97PSApy0xwAuL8DOMyhlP7HbHm+9+9Oq3BV
        kWMVPZAfP5a2lSuaLbjdmdGt/hbr7JdTfLtg1sIEqVx7uSfIPSHRlLTx0K7Qlm+lpiJnHA
        EW/G5eNezqV9FatmpYoQ+6Jcy9UdE9NUDvrleL2sesw809zskILi/I36Knc84BrNeYx0pl
        9TBdXLLMtP7re0uLzQ06Eh4R8OXXi0BHy7HIc7SSqWgsp8QZQmfvwK797IirshKZvDq+BY
        Jtd1QF9mJj0G4KLzd3JyCVfmFfuHLIwILRQKjlbJ6lmfoKWbBG1lydl2W46qUg==
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH RESEND] gpio: regmap: use new regmap_might_sleep()
Date:   Thu,  5 Jan 2023 16:06:03 +0100
Message-Id: <20230105150603.2810510-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the regmap can be queried whether it might sleep, we can get
rid of the conservative setting "can_sleep = true". New drivers which
want to use gpio-regmap and can access the registers memory-mapped won't
have the restriction that their consumers have to use the
gpiod_*cansleep() variants anymore.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/gpio/gpio-regmap.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index f907c9c19fce..fca17d478984 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -254,15 +254,7 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	chip->ngpio = config->ngpio;
 	chip->names = config->names;
 	chip->label = config->label ?: dev_name(config->parent);
-
-	/*
-	 * If our regmap is fast_io we should probably set can_sleep to false.
-	 * Right now, the regmap doesn't save this property, nor is there any
-	 * access function for it.
-	 * The only regmap type which uses fast_io is regmap-mmio. For now,
-	 * assume a safe default of true here.
-	 */
-	chip->can_sleep = true;
+	chip->can_sleep = regmap_might_sleep(config->regmap);
 
 	chip->get = gpio_regmap_get;
 	if (gpio->reg_set_base && gpio->reg_clr_base)
-- 
2.30.2

