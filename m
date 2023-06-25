Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36DA73D266
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjFYQaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjFYQ3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:29:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15864171A
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:29:23 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98df69cacd1so73204166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687710538; x=1690302538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmS3pJ1SyrLevST8bGOOD7yXt2zH6zG2iD3vhDp7X08=;
        b=gTI8JU+ZA8Kr8RNGjDMmEGGx04B54DFxcjCoX05mV0tdcOiQ4/ZIBpJFZNDajO7s/5
         QL2aWBoD+OfKOt2tAoJ7uTt42SwAznxpokPO5sZnwMPs2KGSNPlM+S13UJkE5iHwC1FO
         NsdjUL8HRmHUvJmp3UsD0RwKEKlIsjvpHVJj8spyjxzzusT6BsJWFzYc8K1ZJXjnhAmZ
         jAvL39DCwkF16P784MtycdiOLNy4fKQUTdHxK950v0WaUa2L1nSZQGPWXYXi7Fh37mO0
         GAwHz0vxkoEDDxuoKGy52+dSO9bqSwf0SlyU0YVORQE29RC2sqfzZ/PclYPOPSpl5+qf
         IBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687710538; x=1690302538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmS3pJ1SyrLevST8bGOOD7yXt2zH6zG2iD3vhDp7X08=;
        b=mFyWElhVQvWZGUFMbrA4Nn/lcWp3qX3Vl3q9Gl2IguVhewK9oAmTjrL36nhYPMW71y
         Ftmfj5/qBkIJ3YPOpW49JhBsRzny6DMZ+lH6PHT0WLX7FNR5L3jdd/25Yfz0jRTWnjhC
         0ydtuc7abRSmPqseCcUer4HjqDyakREnw96p7vQywkxpcFNQL8WGuKTrur4lh2BJ1Yju
         q+42zqD947mH+iIV/hK/p68CGFnVFzYsJqCzah2G3OEaLQG/9SA3nE2tStJ3UcV1WmNF
         5ww1v3DL1ixmvztJc6RnOcPM1rPs6tSzbbbt5JCA47gWIckTFRGczko2FwRF9O42oF2t
         iSGg==
X-Gm-Message-State: AC+VfDxg2obNQWYhiPNaUYbAvHOoz5EfL7bLae3SrOEQNBqhSNxRREN5
        MJ0Y2wSLW++H3gHNVgDadjGbRw==
X-Google-Smtp-Source: ACHHUZ40Qb3W3LkY7oK41/MEkUCkEpBE4VxbC9OyUmcAy8rrCe5L4wQOsEbshuUjWAUUngr7rO15IQ==
X-Received: by 2002:a17:907:2be7:b0:98e:2b00:c509 with SMTP id gv39-20020a1709072be700b0098e2b00c509mr1551774ejc.30.1687710538039;
        Sun, 25 Jun 2023 09:28:58 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ec10-20020a170906b6ca00b00982be08a9besm2277731ejb.172.2023.06.25.09.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 09:28:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bastien Nocera <hadess@hadess.net>,
        Sangwon Jee <jeesw@melfas.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4 19/24] Input: sis_i2c - Simplify with dev_err_probe()
Date:   Sun, 25 Jun 2023 18:28:12 +0200
Message-Id: <20230625162817.100397-20-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625162817.100397-1-krzysztof.kozlowski@linaro.org>
References: <20230625162817.100397-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/input/touchscreen/sis_i2c.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/sis_i2c.c b/drivers/input/touchscreen/sis_i2c.c
index 426564d0fc39..ed56cb546f39 100644
--- a/drivers/input/touchscreen/sis_i2c.c
+++ b/drivers/input/touchscreen/sis_i2c.c
@@ -310,23 +310,15 @@ static int sis_ts_probe(struct i2c_client *client)
 
 	ts->attn_gpio = devm_gpiod_get_optional(&client->dev,
 						"attn", GPIOD_IN);
-	if (IS_ERR(ts->attn_gpio)) {
-		error = PTR_ERR(ts->attn_gpio);
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev,
-				"Failed to get attention GPIO: %d\n", error);
-		return error;
-	}
+	if (IS_ERR(ts->attn_gpio))
+		return dev_err_probe(&client->dev, PTR_ERR(ts->attn_gpio),
+				     "Failed to get attention GPIO\n");
 
 	ts->reset_gpio = devm_gpiod_get_optional(&client->dev,
 						 "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(ts->reset_gpio)) {
-		error = PTR_ERR(ts->reset_gpio);
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev,
-				"Failed to get reset GPIO: %d\n", error);
-		return error;
-	}
+	if (IS_ERR(ts->reset_gpio))
+		return dev_err_probe(&client->dev, PTR_ERR(ts->reset_gpio),
+				     "Failed to get reset GPIO\n");
 
 	sis_ts_reset(ts);
 
-- 
2.34.1

