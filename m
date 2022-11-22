Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3F36361A5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbiKWO0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbiKWO0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:26:07 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C875C6EB71
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:25:13 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id w9so11261915qtv.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ri0mZ2K/fUhEx8zLPRzENIukosBulaHGjs8vpkuOJm0=;
        b=EC4hFSm0jb5iWEd86vmGEvAc/8Ma+ky2jLRXJJTIFVvRrKxuX8aBHV4o6KA+QRFiEg
         G4T9GTPHN5atxmaHJZpR9FNDfxVSSUUczqERka4epqICjB2nniRkfnnoUZdrMNcW8hs5
         woLCpqW0jXHrKmIRmLo3Py3s6Sjd1OdonrwVLu37QUkkO+H+8+6+68PV/07+8wFIRs1j
         BZuyvSBi7noGBsmRG8Rx5rcGJIi7d53Lp7lB/1jMjseMe0eYrjVxxiix4Zp8XyODUDsR
         AbaSChID7GoAOdO50ZAi16FCWTuqTbA0xBRBVL5Xe8OCAt0nvVfJ47lkn24dnYbsqQi3
         WJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ri0mZ2K/fUhEx8zLPRzENIukosBulaHGjs8vpkuOJm0=;
        b=omBP3B9aZtJl/ipkWztHheH4tjZPP+KN6u73/aKcYAv9L1d4O5JQsLSDz/teDBm89t
         750OZCvMb9cdXFeFNCIgIEC/N9dQXgpDtoWUeygTGMcapm6m4QjwqAwyu1ASceIxcpa8
         kQcyMnvrNblz2BtF5bZUDOKyNw1FZNn1s1LC3eYXwuJ7zrQskIm6NTonsIjsZ6uEa3m/
         p2wQB2bAsEr6wUd4cgC662fFCn11cACTFDfwJuib2T+qwOhzJVJCV4cBxWBITi4/Rke3
         3BJR/ZIYEGU5OzSD5aAfJIOk12RvbsLOqbCxU1tU2UB6c+AjYpzlLEXmAwDn3o0fZR8C
         sZSw==
X-Gm-Message-State: ANoB5plP7BiKhzOcDJ1DPJ7HeWcxCl0wPb5trccg6QJq4xyMKj0roQjf
        V33DekOPh56AspLJza487UOhEA==
X-Google-Smtp-Source: AA0mqf6KhyiL9QLvsO2N1rrDnCRwyBYcd5DcYIM7vR3/HTGcruAKwCoAz1gRVgV9Pj2/miU5OQzqsQ==
X-Received: by 2002:ac8:4b55:0:b0:3a4:fcde:734b with SMTP id e21-20020ac84b55000000b003a4fcde734bmr27038149qts.238.1669213512483;
        Wed, 23 Nov 2022 06:25:12 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id b28-20020a05620a127c00b006f9c2be0b4bsm11718802qkl.135.2022.11.23.06.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:25:11 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc, broonie@kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v3 1/9] gpio: regmap: Always set gpio_chip get_direction
Date:   Tue, 22 Nov 2022 02:10:58 -0500
Message-Id: <4a7661f01803c100a9322dc15c8df17d61c2ed72.1669100542.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1669100542.git.william.gray@linaro.org>
References: <cover.1669100542.git.william.gray@linaro.org>
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Michael Walle <michael@walle.cc>
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

