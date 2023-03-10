Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62856B473A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjCJOt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjCJOrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:47:51 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9581110D313;
        Fri, 10 Mar 2023 06:47:28 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id r23-20020a05683001d700b00690eb18529fso3053006ota.1;
        Fri, 10 Mar 2023 06:47:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWY2GX4eL6wZkhkiIWtA/liprN4JQfKjQKIiOmXpvZU=;
        b=bphTHhTm/oauiHy3BsT9wsb5CwBpI0O19Rsmxf8fWXS2te/7YTOW4R2f1fhpSFD88G
         QjpAn2eVSc5+NV6j43wkVqORCju2ysFWpGCVacKV0orVLSdfqj7D4Xn5IJar22gU3hmo
         V9JhGTjzyVhAdc1uLKFOb+fDltbn527skAKUvHFez7mTFdSjdxIPl+aOlDVqn0ZH0CLn
         xtKktdh0xW/8N4DhQ4jA2T6Nzep7cKw95htCEOSmZrR13BqT7JeUxWwFooNYSYavA7Mf
         MmdAgzp7MTEkT4JOmmO4lwN2jfM8Qrs4NwEZjeh0lmUYbxiAs2XWISEgkKLs+zGr+Qm/
         5zrg==
X-Gm-Message-State: AO0yUKUMnZegfT/PI9AeJAnZCfihiJK6PCiMkwln3YLU8+Xt/LihSbwH
        Cu1tHxG/+uioYAie3zI6P5YReZlYeQ==
X-Google-Smtp-Source: AK7set/g/J528yueiUEp7/Gtg/+1utQPchlRkg8KoGoFS8QmEvkXwzmHP6rgldWE4NWPenP1TeOFfQ==
X-Received: by 2002:a05:6830:1f4c:b0:68b:d7c1:d095 with SMTP id u12-20020a0568301f4c00b0068bd7c1d095mr13413767oth.25.1678459646783;
        Fri, 10 Mar 2023 06:47:26 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e1-20020a9d0181000000b00670461b8be4sm125104ote.33.2023.03.10.06.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:26 -0800 (PST)
Received: (nullmailer pid 1542164 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:04 -0600
Message-Id: <20230310144704.1542114-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/gpio/gpio-stp-xway.c | 2 +-
 drivers/gpio/gpio-tb10x.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-stp-xway.c b/drivers/gpio/gpio-stp-xway.c
index 0ce1543426a4..dd3bdc221b94 100644
--- a/drivers/gpio/gpio-stp-xway.c
+++ b/drivers/gpio/gpio-stp-xway.c
@@ -292,7 +292,7 @@ static int xway_stp_probe(struct platform_device *pdev)
 	}
 
 	/* check which edge trigger we should use, default to a falling edge */
-	if (!of_find_property(pdev->dev.of_node, "lantiq,rising", NULL))
+	if (!of_property_present(pdev->dev.of_node, "lantiq,rising"))
 		chip->edge = XWAY_STP_FALLING;
 
 	clk = devm_clk_get(&pdev->dev, NULL);
diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
index de6afa3f9716..0422637796cb 100644
--- a/drivers/gpio/gpio-tb10x.c
+++ b/drivers/gpio/gpio-tb10x.c
@@ -167,7 +167,7 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tb10x_gpio);
 
-	if (of_find_property(np, "interrupt-controller", NULL)) {
+	if (of_property_present(np, "interrupt-controller")) {
 		struct irq_chip_generic *gc;
 
 		ret = platform_get_irq(pdev, 0);
-- 
2.39.2

