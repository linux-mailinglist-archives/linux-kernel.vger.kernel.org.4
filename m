Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2B173D231
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjFYQ2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjFYQ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:28:34 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037361A5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:28:32 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-98377c5d53eso293551466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687710510; x=1690302510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQQKSSUy+f0J5aGwdtUfDXCIC6e04ohCti7qa0/jnj4=;
        b=WqrjXLMk8MjPhCqBb7u4L85CzjKQP0v6bdDMWRRvVx4A4YiLvtd3udbtnWs5Kf2W1E
         syLob4whf20gprUtgDIS7uLzTwIl8Mc1jXaZoNti8nruVXk1U3wJLBTzZ2fanPbkAZ/1
         Uk/Df7kmPyc9gHwT0lcAWG/3GhnpMx8jqY4xaZDymdb/SOeCE/Q+pNTGn5CHaS392JLR
         xdWHcLbxeKJU3k4JdEuitQG576I8ycIx4LaIOhor9ggDtCV+oDoIigt/P8WAV/eyTv1Y
         j+pc2XZy6BEQbPhvjlqL/7Ry1vMOnlfA66OiA19iQTr3S/y917LO3kn7y9VnvUzEoKJ1
         VvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687710510; x=1690302510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQQKSSUy+f0J5aGwdtUfDXCIC6e04ohCti7qa0/jnj4=;
        b=TEDiCK62zv5euJA3aAXjgbZE/Vgberr82QeatJyyPAeL8EPyujXdGNAM6LmNaDI2A5
         EDRfBxM2rACNYJ40kWdknGhFfq0OluuJBhz0VTHFquVOeuBpmbSbK3OQS20uaF9yQ259
         Sz8oWgmfIEbOV+3Q2ZuaZ8sc6f3qLs9QuGGYb7JhsBMLMfRXH4xb2zr43sPZZboTV+iQ
         FxIFuGtzi2glN5HHICg6spgTKnwTqriZOp40mjFzB62Pb99jPyP2h1i/LzwNtLnVUW72
         r3aT6NfaccCkhOBcBAl2J/KkFuP0XmBvIIBBs8sdWKJFiloZS3UzsZtcyRU6y4BhsTkq
         0A9A==
X-Gm-Message-State: AC+VfDzhtviw1CMAiHefBTGSpeAV2XJO0jK0GLzYmPUVrAV+cCYoyTr2
        a1pa1l6OjXG0PsMIYQSmpY5vhg==
X-Google-Smtp-Source: ACHHUZ4O4f4IlWiTfpZyyi6+QcrZ0J1srVxIJXpTGVQL/Aw2ZhuSjaIcyXdXfaRZcWXzctLbgN7V2w==
X-Received: by 2002:a17:907:ea9:b0:98e:2c13:c44d with SMTP id ho41-20020a1709070ea900b0098e2c13c44dmr2466192ejc.68.1687710510279;
        Sun, 25 Jun 2023 09:28:30 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ec10-20020a170906b6ca00b00982be08a9besm2277731ejb.172.2023.06.25.09.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 09:28:29 -0700 (PDT)
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
Subject: [PATCH v4 04/24] Input: rotary_encoder - Simplify with dev_err_probe()
Date:   Sun, 25 Jun 2023 18:27:57 +0200
Message-Id: <20230625162817.100397-5-krzysztof.kozlowski@linaro.org>
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
 drivers/input/misc/rotary_encoder.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 22ec62083065..fb3a34f8eccd 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -236,12 +236,8 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 		device_property_read_bool(dev, "rotary-encoder,relative-axis");
 
 	encoder->gpios = devm_gpiod_get_array(dev, NULL, GPIOD_IN);
-	if (IS_ERR(encoder->gpios)) {
-		err = PTR_ERR(encoder->gpios);
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "unable to get gpios: %d\n", err);
-		return err;
-	}
+	if (IS_ERR(encoder->gpios))
+		return dev_err_probe(dev, PTR_ERR(encoder->gpios), "unable to get gpios\n");
 	if (encoder->gpios->ndescs < 2) {
 		dev_err(dev, "not enough gpios found\n");
 		return -EINVAL;
-- 
2.34.1

