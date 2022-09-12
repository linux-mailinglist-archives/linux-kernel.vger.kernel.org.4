Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9EB5B5825
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiILKWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiILKWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:22:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177B9C47;
        Mon, 12 Sep 2022 03:22:37 -0700 (PDT)
Received: from pan.home (unknown [IPv6:2a00:23c6:c311:3401:15b7:c21a:ebde:697f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BC04F6601FDA;
        Mon, 12 Sep 2022 11:22:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.co.uk;
        s=mail; t=1662978155;
        bh=TU6JM/HLEcHR93E8uXTEbS46UahmKIRFmCxlBOEK0EM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fFV0YP+0m+mDBtPz0KnOFNugF6p+kB61K6b/Yl/qZS6HelH4nKUNXRc/iThlbSs15
         hOYbMBI4i3koG+P4WkRSL48M7fRzJnLAa/ofTmWASg1FlBJODvFpli+nrlFtimlQnV
         Rvt2uRD58EltRvXSQfIC7IiRIZzpCJYYOoi03eeDqCeHzsp6Uj2IdWilf7YkNvAqTw
         W068A7KH6SGHq9mrmySxDt6kgK/rzKxMbruIJA5RD8JHmQXt9w9qPCxgJrtRIbbmNk
         kInp7CQEMJ/+OLCRa/HhItj4eYuNmHNvQ/Hj6eAtDJbZHjoWf84bTywh6wjqd4Ln/2
         Ncvj2mes51mIw==
From:   Martyn Welch <martyn.welch@collabora.co.uk>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Martyn Welch <martyn.welch@collabora.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] gpio: pca953x: Fix pca953x_gpio_set_pull_up_down()
Date:   Mon, 12 Sep 2022 11:22:20 +0100
Message-Id: <20220912102223.1050418-3-martyn.welch@collabora.co.uk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220912102223.1050418-1-martyn.welch@collabora.co.uk>
References: <20220912102223.1050418-1-martyn.welch@collabora.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martyn Welch <martyn.welch@collabora.com>

A previous fix, commit dc87f6dd058a ("gpio: pca953x: Fix
pca953x_gpio_set_config"), identified that pinconf_to_config_param() needed
to be used to isolate the config_param from the pinconf in
pca953x_gpio_set_config(). This fix however did not consider that this
would also be needed in pca953x_gpio_set_pull_up_down() to which it passes
this config.

Perform a similar call in pca953x_gpio_set_pull_up_down() to isolate the
configuration parameter there as well, rather than passing it from
pca953x_gpio_set_config() as the configuration argument may also be needed
in pca953x_gpio_set_pull_up_down() at a later date.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Changes in v2:
 - Re-order enum before u8

Changes in v3:
 - None

 drivers/gpio/gpio-pca953x.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index ecd7d169470b..62367c9d6e99 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -548,6 +548,8 @@ static int pca953x_gpio_set_pull_up_down(struct pca953x_chip *chip,
 					 unsigned int offset,
 					 unsigned long config)
 {
+	enum pin_config_param param = pinconf_to_config_param(config);
+
 	u8 pull_en_reg = pca953x_recalc_addr(chip, PCAL953X_PULL_EN, offset);
 	u8 pull_sel_reg = pca953x_recalc_addr(chip, PCAL953X_PULL_SEL, offset);
 	u8 bit = BIT(offset % BANK_SZ);
@@ -563,9 +565,9 @@ static int pca953x_gpio_set_pull_up_down(struct pca953x_chip *chip,
 	mutex_lock(&chip->i2c_lock);
 
 	/* Configure pull-up/pull-down */
-	if (config == PIN_CONFIG_BIAS_PULL_UP)
+	if (param == PIN_CONFIG_BIAS_PULL_UP)
 		ret = regmap_write_bits(chip->regmap, pull_sel_reg, bit, bit);
-	else if (config == PIN_CONFIG_BIAS_PULL_DOWN)
+	else if (param == PIN_CONFIG_BIAS_PULL_DOWN)
 		ret = regmap_write_bits(chip->regmap, pull_sel_reg, bit, 0);
 	else
 		ret = 0;
@@ -573,7 +575,7 @@ static int pca953x_gpio_set_pull_up_down(struct pca953x_chip *chip,
 		goto exit;
 
 	/* Disable/Enable pull-up/pull-down */
-	if (config == PIN_CONFIG_BIAS_DISABLE)
+	if (param == PIN_CONFIG_BIAS_DISABLE)
 		ret = regmap_write_bits(chip->regmap, pull_en_reg, bit, 0);
 	else
 		ret = regmap_write_bits(chip->regmap, pull_en_reg, bit, bit);
-- 
2.35.1

