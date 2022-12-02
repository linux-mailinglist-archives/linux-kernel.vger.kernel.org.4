Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DCD640ABA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbiLBQ1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbiLBQ1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:27:24 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC5655A2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:27:24 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id h24so5813874qta.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 08:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ri0mZ2K/fUhEx8zLPRzENIukosBulaHGjs8vpkuOJm0=;
        b=u9/IyqiIL4+3wr3eFH2hBBO25RhLAtMp9B6DjxpaiYYJ42wVb1aUP2KMzEPlTr4ho3
         pCbWaiaZIVkvfR0KZTG4zicCMfiLAuqZFHQ0CEAyA6v731ac5oeKyOBrFQ5eF2R1EB2Q
         SLO0rqB4UwNrrYQDo/iUeczHNO2u9m9WgL4lMiR/lgP0UI6xZQs6u/io8FUGpPE1VmIn
         e9lnQeFyiZcChVgJTVFPdGeUysysNtSWhmt0WYxYwRxWSIrVJ9MoKDx0TDTOCTI2Agum
         MgUy3HtgMfs6ioE/Y03IjNgAEFwGs1FzJMT3454Di8hLRqYw0IQ2ZH3qWFzZtyGvPQmg
         uDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ri0mZ2K/fUhEx8zLPRzENIukosBulaHGjs8vpkuOJm0=;
        b=z0vkhPvcOyr6qI2b68urkzgOgdVSp9Go0jmFnqcXKqdc3qmiPnNXHekFQaf+jY3s2R
         AVMQBzZYAHQEFX2FLdcScz+TXp3B7M2Gin7OKnMMK7vw9T5B7+Ot2BrUWcQ2EKpSeRMP
         Hu0tNbk50PDblo0S2S6wzTmwCoq6gGem+cv2sIDNxhvTWRVlFIOHwikpEbqZNlp9bqsE
         GFrwCon6QM9fgllAWa7n/IE4Rd3sppuF2gH+PtfIvF8dBp+Z9Jxs8EBhvp2A6+VvjEAe
         7lkg5d3+1+eH6gkRVNtFwz//87VoK0BNu8oyRU56px0GH2FD5sPK2OnfSxvOL6Tpuw86
         uMoQ==
X-Gm-Message-State: ANoB5plUnsIy1pkvAJ5hTSl30EYLD1PY87wsy69OvwIKhSaCGt5yJHRg
        v9iLuK46d1xMmVjqTp/Jh51SLQ==
X-Google-Smtp-Source: AA0mqf75+ua2+xbTdtzxvzDbcyWX4xX7g6LJ3BGTqTcP5c6wP8WcuYJSKvQyI7Y8Vv9OtE+ftknEjw==
X-Received: by 2002:ae9:f111:0:b0:6fc:94f7:6cf6 with SMTP id k17-20020ae9f111000000b006fc94f76cf6mr14926054qkg.517.1669998443211;
        Fri, 02 Dec 2022 08:27:23 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id fp38-20020a05622a50a600b00343057845f7sm4391887qtb.20.2022.12.02.08.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 08:27:22 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc, broonie@kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v4 1/9] gpio: regmap: Always set gpio_chip get_direction
Date:   Fri,  2 Dec 2022 11:27:07 -0500
Message-Id: <2bb8b9e88b8713fcb415e9ac40ecf31e43daee71.1669996867.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1669996866.git.william.gray@linaro.org>
References: <cover.1669996866.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

