Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CD56B5AFD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjCKLRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjCKLQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:16:38 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF2B265AD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:15:29 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id i34so30689344eda.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ioe8ZckxjU6ZpVzZshacUS/R7WK/EtFfWhV8AADv5Wg=;
        b=Qv3harmSc0C7cxjkUe4JkVM0K/zqBD/g5+YAM2euRlrw8xX9TtFYm1YF4TxtMuZUkS
         KddiDQs4AxZ4oNSKk/hCwv/2HPLrXqTeYIHKxTpmLs3P0VxQQ2KBSkBvJndHyrn2cbPv
         Yq/Bw/XCnaq41hxusKGD2fSxsTGLVFjW4B7ePAXQwuYIRMRjao2jwTMuMNeLXqmul8ZQ
         HcNALQGblX05u6BQOZhavjAJaRdg16ZsoPlDFz/Q1rxBieqBFQQCmkqscDVJa9xSOEoE
         XmZ84y/i2Vgi0jpcgFp86RQtE4uvcAmfwRng1/zFlGATzAiWuIDmYztx8wsbEHidWywD
         wnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ioe8ZckxjU6ZpVzZshacUS/R7WK/EtFfWhV8AADv5Wg=;
        b=0Gc4rqbkaT422gL44njwt7FtFIIJvC1l1OOwg9xFTUkaJ1bjRkPv7fWjDfCBEdwtb7
         pez+i3Oxy/K1wp5LfRJa8Gh3h1THHK3Gpa7t1dm9PGmwr/3h8GiPH5NeYWi9QtfOBf6T
         y5qpaRr9cm7W0Beh8nZ6BE+yBJKNWglbMdpKU4rkYpyhDUlm5bJruNCc/aKnQPSCo6Sh
         xfr6RT39EJ3T4nDgHjn7hzrwypJRu0X4Rtf8FQAaTkQYLN5p2yU+RNN3wzgybSdOKIEF
         KvVHMmEXEQYc4w/z87r6KvFn7eBhyA+7RuNYJgQ+qq/JhLiwFSinCNW3TmJsD+RsEN3j
         cxlw==
X-Gm-Message-State: AO0yUKWlMfzMnXlcVGnz/0PPiHfUJVnmoOyOQcPikppFM28vrQXqqVIV
        yNbXv6s7pShQ8yQ8i0WSc9R7Dg==
X-Google-Smtp-Source: AK7set9KXK3WwLIZBF8yLLjllA+Ij/w+p8024nzo/7ze3PwqULG7UodI6iA2HWhh7v2qxVqVtuujPg==
X-Received: by 2002:aa7:d60b:0:b0:4c1:a7fa:99dd with SMTP id c11-20020aa7d60b000000b004c1a7fa99ddmr22806738edr.38.1678533303506;
        Sat, 11 Mar 2023 03:15:03 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id lc22-20020a170906dff600b00922b009fc79sm223427ejc.164.2023.03.11.03.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:15:03 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] iio: light: max44009: add missing OF device matching
Date:   Sat, 11 Mar 2023 12:14:56 +0100
Message-Id: <20230311111457.251475-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
References: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 drivers/iio/light/max44009.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/max44009.c b/drivers/iio/light/max44009.c
index 3dadace09fe2..274e0b679ca2 100644
--- a/drivers/iio/light/max44009.c
+++ b/drivers/iio/light/max44009.c
@@ -527,6 +527,12 @@ static int max44009_probe(struct i2c_client *client)
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
+static const struct of_device_id max44009_of_match[] __maybe_unused = {
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
+		.of_match_table = of_match_ptr(max44009_of_match),
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

