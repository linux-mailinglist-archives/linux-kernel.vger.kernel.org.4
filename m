Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975EA73D259
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjFYQaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFYQ3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:29:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCD1FB
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:29:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9786fc23505so193128066b.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687710532; x=1690302532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxreeCUsKJctxClqKw334DOez932+KTIErInSPtTaVw=;
        b=Pp8yU/zBVYnTMMwOHEiumkUJwl8bUqlFFz1uk6Dfxyx294USOCkvzgAQsJlReLPAc9
         99GkJWzMhJf4GX2WkoSLyeXcFg01SnkQkcc1XU/NZCS0wO6yvUSmDuCvKJiRM2e/1PxH
         1fVn/kVsNZPsEXyle6ijoWdOHPo3AAdUgTiWv/Qdlc/WsGOvNXzdpODp4SUxFjFThmb3
         m5wRSZZ8LVPW5R76tvysT/4nUeracMSQ3/aR4THtDfaO+1olvVMeDOgNGBORXEthJdU5
         7isF7QGeuO3ST1gp9lqFsyapaIS1UIoDIkoTCAja5ASrvQCjeUBamfYtXaLhVMdNEV3U
         gbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687710532; x=1690302532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxreeCUsKJctxClqKw334DOez932+KTIErInSPtTaVw=;
        b=AJgPjIsM7VAxKlM5dlOFODzl/e/paiHPceQgYLz+2yJGpC3bLcHuxZUjJBri9C4tAu
         M2V/vvyp9/xLjnOZOZa0S+si2nmufSEa/M6FxU0I+TU4A7aH9VIZJZJn6/h+AAkDQUtb
         cCpNq251MGDfIeetT1pkVBQ6cQ3XmAqho+YJe2cuPi6c0sDlgIcW5V+4U5ixebVQ9y8x
         EYuvPwBpy73EcSsm29iEChAgtpQICRcrPDd2gU0eGRYn0aQXnQnrogjmazWYHrW38PUh
         0ZDyce8HfJvpJ8oERpKMKNSQX8achsjVoD957AURK/sn6sIjanfv4tacLIVCaY0aznaQ
         xfBw==
X-Gm-Message-State: AC+VfDxdJYt6NiIx9cXykTxKiVNl99O0dYg2xLIj2GPFeoCWHs9u5GE/
        +qWs2AYdv9qzWAyprTL6jfuJhA==
X-Google-Smtp-Source: ACHHUZ54nGtBAMtD5A4/SW79a5y2ixsRKqYjqAOBnJSC2bwhdzniIMKmttm6MbTvAQykre2mPU6owg==
X-Received: by 2002:a17:907:5ca:b0:97b:6c24:8d2b with SMTP id wg10-20020a17090705ca00b0097b6c248d2bmr24694857ejb.55.1687710532198;
        Sun, 25 Jun 2023 09:28:52 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ec10-20020a170906b6ca00b00982be08a9besm2277731ejb.172.2023.06.25.09.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 09:28:51 -0700 (PDT)
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
Subject: [PATCH v4 16/24] Input: raydium_i2c_ts - Simplify with dev_err_probe()
Date:   Sun, 25 Jun 2023 18:28:09 +0200
Message-Id: <20230625162817.100397-17-krzysztof.kozlowski@linaro.org>
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/input/touchscreen/raydium_i2c_ts.c | 30 +++++++---------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index 76e7d62d5870..78dd3059d585 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -1087,32 +1087,20 @@ static int raydium_i2c_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, ts);
 
 	ts->avdd = devm_regulator_get(&client->dev, "avdd");
-	if (IS_ERR(ts->avdd)) {
-		error = PTR_ERR(ts->avdd);
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev,
-				"Failed to get 'avdd' regulator: %d\n", error);
-		return error;
-	}
+	if (IS_ERR(ts->avdd))
+		return dev_err_probe(&client->dev, PTR_ERR(ts->avdd),
+				     "Failed to get 'avdd' regulator\n");
 
 	ts->vccio = devm_regulator_get(&client->dev, "vccio");
-	if (IS_ERR(ts->vccio)) {
-		error = PTR_ERR(ts->vccio);
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev,
-				"Failed to get 'vccio' regulator: %d\n", error);
-		return error;
-	}
+	if (IS_ERR(ts->vccio))
+		return dev_err_probe(&client->dev, PTR_ERR(ts->vccio),
+				     "Failed to get 'vccio' regulator\n");
 
 	ts->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
 						 GPIOD_OUT_LOW);
-	if (IS_ERR(ts->reset_gpio)) {
-		error = PTR_ERR(ts->reset_gpio);
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev,
-				"failed to get reset gpio: %d\n", error);
-		return error;
-	}
+	if (IS_ERR(ts->reset_gpio))
+		return dev_err_probe(&client->dev, PTR_ERR(ts->reset_gpio),
+				     "Failed to get reset gpio\n");
 
 	error = raydium_i2c_power_on(ts);
 	if (error)
-- 
2.34.1

