Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FC473D23A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjFYQ3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjFYQ2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:28:44 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB27410DB
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:28:37 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-987341238aeso290060566b.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687710516; x=1690302516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obNX6hJ41R1Oqa+mhu5/W/1j/nEz8J6V9vPhPBspkGg=;
        b=Ewt+VV2fIDbO03/ieoVJr0rxByU+q4lMkrvlPb1o1TzzLnTlQLY6nLA4F9SU5XUVDj
         VVqS5buRf4NFjaNz+co7Q729ikUX3gQwVn7mMCIYmfhtR5sxqOGnKwFzivMeLCGyUBAA
         AbH3AkQvL2EJFauv9N1+Cidzb7ijHsQ6jsHo3sCLIXXiFXsmy85hDlb5kKzCAcLRNsEG
         DixQjoUtRNXGF0izuc+OoP9Ipl6+w1Ic177T7I9KGbSimUsyqovk3KRkgPqdfC2Tsv7a
         LPNdMx6w3Loxss0lrHgD0q/qYwdjuU2Qr+u74ImAmU/MksWS1LB1BVI8I9c8qYI4sO7u
         Y7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687710516; x=1690302516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obNX6hJ41R1Oqa+mhu5/W/1j/nEz8J6V9vPhPBspkGg=;
        b=NnoOZDbHJEMay4tDGuFnzKTeCHqfmUeRNk8EYzUZZDyYLyyK+1KnUBPeofhjHK2LyO
         bN0n2ozPj55w3yr0JAzlDRV1KQfSs8RiVJPfVKHYMPqdBUK8GSMG/lY6JrQ9MYkt+LW2
         2IsZGTBzKJZDi4lWwWEVQqAeVlfcebLaYTZTfr0I2kJ2IpFYCFQjByPjdlUgMiZfVMFS
         rsYx7obQBWyWZ9BgC5al9UGcmOCrVe0M6h0007RIz4Q3LIS94vYaywQMQnOEs8eGOo1g
         rC8qBBnV7aa1vzCmN8oQxrhPk9HtzNdaxUUESt/yAOe/zviKPktCkxqPc+QhL7YuYjmJ
         xtcA==
X-Gm-Message-State: AC+VfDxydh7sWU/T6PFurd0d4/vBVb1gT2gt++0zXf1gxhwV3EZb6mnB
        QgxTxRVWRNCZoFTbZpAvcwdsjQ==
X-Google-Smtp-Source: ACHHUZ7PmhqUxPzPbI7CXSgr1jPOrf2CgBWLZcxDDLfmTpRvj1olZ97Tiy35gba7htFN2BbJwDK2vQ==
X-Received: by 2002:a17:907:c25:b0:988:aa45:827 with SMTP id ga37-20020a1709070c2500b00988aa450827mr18607461ejc.11.1687710515796;
        Sun, 25 Jun 2023 09:28:35 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ec10-20020a170906b6ca00b00982be08a9besm2277731ejb.172.2023.06.25.09.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 09:28:35 -0700 (PDT)
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
Subject: [PATCH v4 07/24] Input: bu21029_ts - Simplify with dev_err_probe()
Date:   Sun, 25 Jun 2023 18:28:00 +0200
Message-Id: <20230625162817.100397-8-krzysztof.kozlowski@linaro.org>
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
 drivers/input/touchscreen/bu21029_ts.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/bu21029_ts.c b/drivers/input/touchscreen/bu21029_ts.c
index c8126d2efe95..3d81ebe66b66 100644
--- a/drivers/input/touchscreen/bu21029_ts.c
+++ b/drivers/input/touchscreen/bu21029_ts.c
@@ -359,23 +359,15 @@ static int bu21029_probe(struct i2c_client *client)
 	}
 
 	bu21029->vdd = devm_regulator_get(&client->dev, "vdd");
-	if (IS_ERR(bu21029->vdd)) {
-		error = PTR_ERR(bu21029->vdd);
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev,
-				"failed to acquire 'vdd' supply: %d\n", error);
-		return error;
-	}
+	if (IS_ERR(bu21029->vdd))
+		return dev_err_probe(&client->dev, PTR_ERR(bu21029->vdd),
+				     "failed to acquire 'vdd' supply\n");
 
 	bu21029->reset_gpios = devm_gpiod_get_optional(&client->dev,
 						       "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(bu21029->reset_gpios)) {
-		error = PTR_ERR(bu21029->reset_gpios);
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev,
-				"failed to acquire 'reset' gpio: %d\n", error);
-		return error;
-	}
+	if (IS_ERR(bu21029->reset_gpios))
+		return dev_err_probe(&client->dev, PTR_ERR(bu21029->reset_gpios),
+				     "failed to acquire 'reset' gpio\n");
 
 	in_dev = devm_input_allocate_device(&client->dev);
 	if (!in_dev) {
-- 
2.34.1

