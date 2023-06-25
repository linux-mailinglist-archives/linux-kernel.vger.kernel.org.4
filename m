Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE62A73D269
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjFYQa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjFYQ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:29:46 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE79E4C
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:29:30 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-98e25fa6f5bso160146866b.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687710543; x=1690302543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrK9BhmeRbtcXzgi7rTTXpnSu/d5rWV1MCplOE4+PiY=;
        b=qr9LMO/Q+uU19l25OB/u4TWDpd9xHm9oJH3Foo76AbbHQctIYRf5ZUFkY8L9AiHLl4
         IOGoE/YwDvYjQ7Z/RoI8LAsyAb0Oou9jV/eNjnv0tRqSdclfwqq5uy94d6B0rnmCPUUR
         iSLOq5KkZanLgOR/nRBhyLxHONuPzS/nAZpnltsISPxUbmC0LUfNyXpYLU0YpLs1vWve
         AC96ifIl+9PInt0WomEwgqB0VL3ODDiMvq9dIQEL7Sq3bYrqAHuOVxVLoe7A0CTRvKCZ
         mcw9tPNo76ttBFw4192eFXvpbfamJYHlQPGZpjvPhBEBJagw7rmSeUJ7CKA6ktmCZMlI
         AgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687710543; x=1690302543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrK9BhmeRbtcXzgi7rTTXpnSu/d5rWV1MCplOE4+PiY=;
        b=QgV+3sNIqE98BeTK555xxL/Sh7tx6F1xtbQ/+eNLRSB1oGMHmg3fcpBmhMU6DAMinn
         ZlQshJI/9DjMEYDYOmsGN1w8YVcirwpsjYDOkiR+0p7PTWChNCavSUrISJV857av0MB1
         KG2a0gePzW1FyT9MHII2nuCwYhCtDX6LJMxrNTNNkB7SfQpfTYRVU7VJjbIfknOYzidl
         liXeSxvX5C8UAbU3rJK9UU71pceJZbSgbAPZnSKDfR4uOYVeAW7hxCUoQIKadPT/lLdP
         jelzd2KRNYLYjD5yhpHA69gcY6pQWwfx9FlFRgyEQ629FVCbpkRJfx9WjgHRBz0NSIi8
         MCEQ==
X-Gm-Message-State: AC+VfDwZckBC8t1MNbjXwaoxeWVucM5fLQtoAn3vxce/ICoPHC7FB13d
        3CWnBZoFf53KVB0hFsdJTxCvDw==
X-Google-Smtp-Source: ACHHUZ4pmUNrCMXBMGQAiWrlzAcQbXivm8kcH4HsBYA2BwE5vUWcO7yFRLSprd8nU0O23IiOEHcsJg==
X-Received: by 2002:a17:906:58c5:b0:988:891b:28c6 with SMTP id e5-20020a17090658c500b00988891b28c6mr20998191ejs.15.1687710543723;
        Sun, 25 Jun 2023 09:29:03 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ec10-20020a170906b6ca00b00982be08a9besm2277731ejb.172.2023.06.25.09.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 09:29:03 -0700 (PDT)
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
Subject: [PATCH v4 22/24] Input: bcm-keypad - Simplify with dev_err_probe()
Date:   Sun, 25 Jun 2023 18:28:15 +0200
Message-Id: <20230625162817.100397-23-krzysztof.kozlowski@linaro.org>
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
dev_err_probe() and devm_clk_get_optional().  Less code and the error
value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

---

Changes since v1:
1. Use also devm_clk_get_optional()
---
 drivers/input/keyboard/bcm-keypad.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/input/keyboard/bcm-keypad.c b/drivers/input/keyboard/bcm-keypad.c
index 56a919ec23b5..05b09066df84 100644
--- a/drivers/input/keyboard/bcm-keypad.c
+++ b/drivers/input/keyboard/bcm-keypad.c
@@ -365,17 +365,11 @@ static int bcm_kp_probe(struct platform_device *pdev)
 		return PTR_ERR(kp->base);
 
 	/* Enable clock */
-	kp->clk = devm_clk_get(&pdev->dev, "peri_clk");
+	kp->clk = devm_clk_get_optional(&pdev->dev, "peri_clk");
 	if (IS_ERR(kp->clk)) {
-		error = PTR_ERR(kp->clk);
-		if (error != -ENOENT) {
-			if (error != -EPROBE_DEFER)
-				dev_err(&pdev->dev, "Failed to get clock\n");
-			return error;
-		}
-		dev_dbg(&pdev->dev,
-			"No clock specified. Assuming it's enabled\n");
-		kp->clk = NULL;
+		return dev_err_probe(&pdev->dev, error, "Failed to get clock\n");
+	} else if (!kp->clk) {
+		dev_dbg(&pdev->dev, "No clock specified. Assuming it's enabled\n");
 	} else {
 		unsigned int desired_rate;
 		long actual_rate;
-- 
2.34.1

