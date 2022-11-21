Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED4763279A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiKUPOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiKUPOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:14:09 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB49CFA75;
        Mon, 21 Nov 2022 07:08:56 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id B1D1B2457;
        Mon, 21 Nov 2022 16:08:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669043334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=leF0rqvNFin/1YVVB08bOiO69am1F2uIpeYktbX9kXM=;
        b=WLEMcralFkvdQ3X3BkLNbp2YryPL/4UP92IPZzQe63g5lsLkTDdVyB/PZDU6+iX1oYE4sf
        BW6BPDDIMDmnXiv94s+4eWiuQfrXndaAc4zw0bxEh09RSNEZ+mg4IbCYyxYVvBkO81iKQo
        CavkrLVfelp58iAhn94ypzgH2cAs+Im0ldc3f14zbrlx/Xt6PGTvjJDVqTuZkqLo+y2Dbr
        CXH4Q40/vrQL/qVT5GrAZfPiOh0VB2z5MBfJ4nEFLD7C84jD4zZhpgMrqGKnvX/qxKD0jE
        0EBkQclmUkxOczQS3T6OrQ2WxGOcG+7fYxasq30RgF52Vh3QZHUpHJq1yh+aTQ==
From:   Michael Walle <michael@walle.cc>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 2/2] gpio: regmap: use new regmap_might_sleep()
Date:   Mon, 21 Nov 2022 16:08:43 +0100
Message-Id: <20221121150843.1562603-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221121150843.1562603-1-michael@walle.cc>
References: <20221121150843.1562603-1-michael@walle.cc>
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
index 6383136cbe59..16404ca6ac38 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -249,15 +249,7 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
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

