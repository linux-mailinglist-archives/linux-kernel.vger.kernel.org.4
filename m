Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5216B6788
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 16:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjCLPei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 11:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjCLPef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 11:34:35 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E6C41B5F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 08:34:34 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id er25so11128059edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 08:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678635273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jo2NqS2zRnOmFXuAfigU28D6znKyOMxuJ/PtqM8xL/o=;
        b=mWDprQhsa9VdEHPAceKFNkoijx6mTG37ZiUg/JljzXlRXxx4JM8rWKVoJ4HbgFbtjv
         rxn5Ck7IOVo7IXIZg83E+GmK+SMgTlNWePAPn4ErAYdu9aLt/37x0jhal6wSFRFf35Ef
         2EkuVZpEjy7A2YNK5HGbdB3fjrbf5Nme5LjFGG63ie8Qx0aRgCtaqZCoTwB3VPygWR3i
         rww28efnI0bNJSVuRTObqeQ5p0q1JKGfJM7agGrgndPJrqb8T99UM7louhioa5K3He19
         jzbdSq8EvDyK6Td71EAjuVBsHNXzVNNYDfQf4tIjOgfD8GgSgsjtQLM4/Jci6BHGepXI
         pkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678635273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jo2NqS2zRnOmFXuAfigU28D6znKyOMxuJ/PtqM8xL/o=;
        b=DYXaHU3JpCdokol1hL3H9jX1HVDydjJmi8Wlm8RPM7t9pcZ40e9LW9HafRKqSAkMrp
         e8+6yFyroeZ3EJMcWjrmdKs8xwUy7qudu3pM40QagQYRGArxOutBnariAlFgD2GLON4D
         8arbfh4s7hMMHkuEemYZD5pUKzuMdmgyIMron1cSldC2gQhBroZl3dQKtnc8/7F6ZjHw
         k7WslfzR4XUAF2rJPJrfI+G7utNF4C9GcPmNOrvMy4xzbcmvDVxIX2ddfuDrONFPJyep
         J1cYQjm/jBu95N0yxnEto8qM9NmpdNEaqkruc6paKJDY+rzFKezp2rvxap5sK4MfkbOn
         49tw==
X-Gm-Message-State: AO0yUKV4A2kQIhNkGTkhZgxyQV1U5sD0IMvPW2o9T4XbfiHPFy9eI7dE
        ci882Q0KmrZLiMz7IcxPO8U2Sw==
X-Google-Smtp-Source: AK7set/x7hjFFTV34zMt+n3N7otnooyqSyY/mS3gp4dTaDO+jU7uplVrh/WCriEH0dOuzLl3B/OZbA==
X-Received: by 2002:a17:906:99d4:b0:8ed:5aac:6973 with SMTP id s20-20020a17090699d400b008ed5aac6973mr31069426ejn.35.1678635273004;
        Sun, 12 Mar 2023 08:34:33 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id z2-20020a170906668200b008e0bb004976sm2312723ejo.134.2023.03.12.08.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 08:34:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/3] iio: light: max44009: add missing OF device matching
Date:   Sun, 12 Mar 2023 16:34:28 +0100
Message-Id: <20230312153429.371702-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230312153429.371702-1-krzysztof.kozlowski@linaro.org>
References: <20230312153429.371702-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver currently matches only via i2c_device_id, but also has
of_device_id table:

  drivers/iio/light/max44009.c:545:34: error: ‘max44009_of_match’ defined but not used [-Werror=unused-const-variable=]

Fixes: 6aef699a7d7e ("iio: light: add driver for MAX44009")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Drop __maybe_unused/of_match_ptr
---
 drivers/iio/light/max44009.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/max44009.c b/drivers/iio/light/max44009.c
index 3dadace09fe2..176dcad6e8e8 100644
--- a/drivers/iio/light/max44009.c
+++ b/drivers/iio/light/max44009.c
@@ -527,6 +527,12 @@ static int max44009_probe(struct i2c_client *client)
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
+static const struct of_device_id max44009_of_match[] = {
+	{ .compatible = "maxim,max44009" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max44009_of_match);
+
 static const struct i2c_device_id max44009_id[] = {
 	{ "max44009", 0 },
 	{ }
@@ -536,18 +542,13 @@ MODULE_DEVICE_TABLE(i2c, max44009_id);
 static struct i2c_driver max44009_driver = {
 	.driver = {
 		.name = MAX44009_DRV_NAME,
+		.of_match_table = max44009_of_match,
 	},
 	.probe_new = max44009_probe,
 	.id_table = max44009_id,
 };
 module_i2c_driver(max44009_driver);
 
-static const struct of_device_id max44009_of_match[] = {
-	{ .compatible = "maxim,max44009" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, max44009_of_match);
-
 MODULE_AUTHOR("Robert Eshleman <bobbyeshleman@gmail.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("MAX44009 ambient light sensor driver");
-- 
2.34.1

