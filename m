Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C84973D235
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjFYQ27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjFYQ2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:28:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B94E7B
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:28:35 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-987accb4349so387417366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687710514; x=1690302514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6wgHXQvCt97a66kq5RQ8NaDVI2/Jj/XxJYdNlS5IWY=;
        b=wf5uthm31KWYncxa45wPIq2Uq+k7DyNTVrLFQslg19SdzcfP3IWLjNCXniDo6YeW61
         rSZBEBrhSFTpnD7iV5bycDTvOxDFhECWzBZJscYohglnyBO3jx6JWPA0vDkf39eSNQ1w
         fwyQ4veWBXLWvr1ltCdoifGDsKtOLpPM13OJtqNJuHqNCtNo3tnjtjoxg6Y7R0AB+oPz
         lgPGKjd8+Nl/pNKJgqa0maR7BPI3QTJLO8TfXKD8DvDeDA+X21jwRktFY9COYJHFS4fI
         fh15zOVXM2XpCIi3fd1xVoYpbIv56yV8SAGyCkIo+hmCbV8SHby1HMYrR3XtbMzSlmX+
         6xWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687710514; x=1690302514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6wgHXQvCt97a66kq5RQ8NaDVI2/Jj/XxJYdNlS5IWY=;
        b=TelWO7APD/vCWt4MVViOlUSgUnc9xjYKd0Ogz1QSEfqOlnj1wq9+SRYLCLrFWjT+Te
         lmuD63vdhydwlscfc7d1oi5kVr30UztDZGT2mBLVjCLxOBXRyO/57bEEO917A7bKPLAY
         lv86eO+hdQ3fGSra0T6rn6fmm5Sph/QtG3DzSHCNitxAJyE4jleyXzjcN9ifdAsavpi/
         WEJOYq2MGRb3fxMz6TD4sdhnDQNAXZUINk0xXBpIliEk+y98QwGBPaYbVMfNHzrnM3MY
         vcWxTXdkTovTxuyNGr7a+Z2GgguCRwrWAX1eWYtcGYpszGjUsuJu1eNFjg88GSB6eYKj
         GfLQ==
X-Gm-Message-State: AC+VfDzOwYaTJo9w+2j9TIibKD/bf0Vy5kwWv6YTWmzURSMlwjgidsZd
        F5m7QTEcvi3Bobp0QHbgMpz4Zw==
X-Google-Smtp-Source: ACHHUZ79BiNrh4irMMrCCyc6D6/cKxJ+ItXxRfOg69uAw9FWX5AKPeZFDAbqJ1zRHbTt1EnkpW6a4g==
X-Received: by 2002:a17:907:6d97:b0:988:9621:d85d with SMTP id sb23-20020a1709076d9700b009889621d85dmr20163181ejc.46.1687710513865;
        Sun, 25 Jun 2023 09:28:33 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ec10-20020a170906b6ca00b00982be08a9besm2277731ejb.172.2023.06.25.09.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 09:28:33 -0700 (PDT)
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
Subject: [PATCH v4 06/24] Input: bu21013_ts - Simplify with dev_err_probe()
Date:   Sun, 25 Jun 2023 18:27:59 +0200
Message-Id: <20230625162817.100397-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625162817.100397-1-krzysztof.kozlowski@linaro.org>
References: <20230625162817.100397-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Changes since v1:
1. Remove unneeded PTR_ERR_OR_ZERO, as pointed by Andy.
---
 drivers/input/touchscreen/bu21013_ts.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
index 85332cfaa29d..f811677a59f7 100644
--- a/drivers/input/touchscreen/bu21013_ts.c
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -495,12 +495,10 @@ static int bu21013_probe(struct i2c_client *client)
 
 	/* Named "CS" on the chip, DT binding is "reset" */
 	ts->cs_gpiod = devm_gpiod_get(&client->dev, "reset", GPIOD_OUT_HIGH);
-	error = PTR_ERR_OR_ZERO(ts->cs_gpiod);
-	if (error) {
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev, "failed to get CS GPIO\n");
-		return error;
-	}
+	if (IS_ERR(ts->cs_gpiod))
+		return dev_err_probe(&client->dev, PTR_ERR(ts->cs_gpiod),
+				     "failed to get CS GPIO\n");
+
 	gpiod_set_consumer_name(ts->cs_gpiod, "BU21013 CS");
 
 	error = devm_add_action_or_reset(&client->dev,
@@ -515,11 +513,8 @@ static int bu21013_probe(struct i2c_client *client)
 	ts->int_gpiod = devm_gpiod_get_optional(&client->dev,
 						"touch", GPIOD_IN);
 	error = PTR_ERR_OR_ZERO(ts->int_gpiod);
-	if (error) {
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev, "failed to get INT GPIO\n");
-		return error;
-	}
+	if (error)
+		return dev_err_probe(&client->dev, error, "failed to get INT GPIO\n");
 
 	if (ts->int_gpiod)
 		gpiod_set_consumer_name(ts->int_gpiod, "BU21013 INT");
-- 
2.34.1

