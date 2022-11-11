Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92F4626D42
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 02:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbiKMBJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 20:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbiKMBJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 20:09:45 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186CB13F1D
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 17:09:45 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id x18so5520256qki.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 17:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2DT+DwYAGhQmBgm02Hatyz4IgqEc7zsVJLAJJN9Ri0=;
        b=NazLy5nzQlgW+6kjijqavW5qe2KAD2TLi2xDnZLX97WjnB444i4AJ0eTOg+ljoaaiB
         4lhtqnfPwkdxNwPG+6gwN11mYQQCgoS1EgMxx1FgsvDq2wwQa4i+OeYxo0tA9baVeFIb
         f4M5v59OxUwG8cfhj//NxZOBqvFY4HxfnikrswndKvkqJr7KId7IeNcPnskg+Chffz3U
         CMTqI+decenIEgYGwLZ937ilUJbsSht0rkGXtHofnmatZ2NoYOAkO9lIOH/J6qNt0qE7
         B46c3vEK0IWR/CjPOZS3BHVs/XGcF1g2eBRqP/79G+89/L/jfrwDIdD/VuNWkh2vDnjt
         sFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2DT+DwYAGhQmBgm02Hatyz4IgqEc7zsVJLAJJN9Ri0=;
        b=n0CzMM7uUYEU09o/UOB58kTMZa6Nexoi13ZwIyCIIYronV6pr9awVH5sZjOwvnz7il
         wFjhwkSw00NfzPkkPJb7emD4DyuHOY//4L2IPdyVD2hxZ+tJenS/iSRpwgKjjGaRP5L3
         NvhJaMzv9IvorqOIRsCCR1tPJDQCN3J37zs69iFqYXzIiNj+9CBpcE/faeCa1hxxpvLj
         HqWtV6/84863cXHT2U2BNJ8ySQ4D/odLVHhtn6epFFfwFm7zta1S0PHs9QtLcV9mlo9I
         Vxl/HEKrMnyLFN/kQKyD3PHa4tUnew20WPIHKemtUAOYAFlDi18nIol3q7wXNBU6RUNb
         tVnA==
X-Gm-Message-State: ANoB5pkg4xxCFKJehRY9zuoBU25nJ9wJEkcGwIwCRPm9nEnBvjnlIGrd
        zRjDU4zEqYD65RXEwBUf43oa+A==
X-Google-Smtp-Source: AA0mqf7IA5aDaoCEdRUZ2yebIXAdRvQmta+yKT8B2aXpi2uSPcIGH/mEzkwCXJiHN6hQdEaZYCjHzQ==
X-Received: by 2002:a37:6c83:0:b0:6fa:19a4:ab6f with SMTP id h125-20020a376c83000000b006fa19a4ab6fmr6719620qkc.759.1668301784203;
        Sat, 12 Nov 2022 17:09:44 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id t6-20020a05622a180600b00343057845f7sm3552498qtc.20.2022.11.12.17.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 17:09:43 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc, broonie@kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 1/4] gpio: regmap: Always set gpio_chip get_direction
Date:   Thu, 10 Nov 2022 20:55:50 -0500
Message-Id: <1805d1ddb5bbce8e86164e66421ddde481cce4f9.1668129763.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1668129763.git.william.gray@linaro.org>
References: <cover.1668129763.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you only have reg_dat_base set, then it is input-only; if you only
have reg_set_base set, then it is output-only. Thus, we can always set
gpio_chip get_direction to gpio_regmap_get_direction and return
GPIO_LINE_DIRECTION_IN/GPIO_LINE_DIRECTION_OUT given the respective
register base addresses configuration.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-regmap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 6383136cbe59..f907c9c19fce 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -111,6 +111,11 @@ static int gpio_regmap_get_direction(struct gpio_chip *chip,
 	unsigned int base, val, reg, mask;
 	int invert, ret;
 
+	if (gpio->reg_dat_base && !gpio->reg_set_base)
+		return GPIO_LINE_DIRECTION_IN;
+	if (gpio->reg_set_base && !gpio->reg_dat_base)
+		return GPIO_LINE_DIRECTION_OUT;
+
 	if (gpio->reg_dir_out_base) {
 		base = gpio_regmap_addr(gpio->reg_dir_out_base);
 		invert = 0;
@@ -265,8 +270,8 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	else if (gpio->reg_set_base)
 		chip->set = gpio_regmap_set;
 
+	chip->get_direction = gpio_regmap_get_direction;
 	if (gpio->reg_dir_in_base || gpio->reg_dir_out_base) {
-		chip->get_direction = gpio_regmap_get_direction;
 		chip->direction_input = gpio_regmap_direction_input;
 		chip->direction_output = gpio_regmap_direction_output;
 	}
-- 
2.38.1

