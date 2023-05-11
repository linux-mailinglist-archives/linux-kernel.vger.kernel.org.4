Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDF66FF14D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238105AbjEKMNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237701AbjEKMNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:13:10 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B01AD38;
        Thu, 11 May 2023 05:12:24 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-643bb9cdd6eso6152928b3a.1;
        Thu, 11 May 2023 05:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683807133; x=1686399133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kz2nBW8WdiIk4F8j/i6m8NjQZbdSdX7MIghawAp0rWw=;
        b=FkbkwpbPgSf5kZapM88YbrP7S64ke8Y6DuKf11L2l7UQiro7rKt2KiANbHbmHK95dW
         DeTNn3JgkW/5pJirwBiTY29UU0PH026LEserBmivl0iYxF8kyYa26d7jgbjRh35pHqHY
         HRf6tMwEwcNVUO5JzHqR6zS44WxSQrb/Kmd4uOL+763/aMR7xmzHuUwGsP7KFvGrJJXJ
         P24Ja7GXwF84rgLOmE7fvXvTK8P2Jr9iaONphXIlTXvy1lcMmR4l58BX+zI7G4o2ya4I
         9qh7xz3E6/88mYrUNPAwLzfHVFZ5UZBCtANvkRe9IlcNUG9109tZJJryM9awh98yrJoI
         UQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683807133; x=1686399133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kz2nBW8WdiIk4F8j/i6m8NjQZbdSdX7MIghawAp0rWw=;
        b=Qm8/8ho8kuVmUqVl+DxAILgM8TL8CkLHU9+NIBqaANm53IqCM6XpYACLuFNAgHwzKZ
         Oyei1+cCHHxHN42ms+ApaWfDrcSUscWDFcXPTXuoahyFXLZqtlSCDV1wUlNsrY3wHML1
         vhL/WmicE9f053TTVLMY5O7j8hvFOyNYipzzCI6HMbjZu8dcQlHzyTsGYVgOZ1G5XzT+
         7cfyx1fqa/JHRHQBM3kHbMx/Hk+VeJKkNAqfIoqRFuIfE5BoQBdTIvQ2jVOsAeDjGysp
         WLnSRnizkrrrZ2+lOROJ0XdGk1Yx55YRNsNbjiMOrHR2uUnUtE5RC713MIKe79UeFDz/
         fRLw==
X-Gm-Message-State: AC+VfDwMdQHbCi5LYVocV1E29rHT6OmrE9ZyG6AQg1g/XGnl+IYwvV0n
        5ARXwuSu/f6/pRBM4YQ1FT7/GQ8IpxNJev9n
X-Google-Smtp-Source: ACHHUZ5LCES57o7ITKxiLkwWKBQ1VUFFKq1mslja/Ps8Wg/UKmabaPXQawVElCz/JemuMAwwRd0HLA==
X-Received: by 2002:a05:6a00:24c1:b0:637:f1ae:d47 with SMTP id d1-20020a056a0024c100b00637f1ae0d47mr27023742pfv.17.1683807133072;
        Thu, 11 May 2023 05:12:13 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id j10-20020a62e90a000000b0063f16daf7dbsm5134562pfh.55.2023.05.11.05.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 05:12:12 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yang Ling <gnaygnil@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v2 2/2] watchdog: loongson1_wdt: Add DT support
Date:   Thu, 11 May 2023 20:11:59 +0800
Message-Id: <20230511121159.463645-3-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230511121159.463645-1-keguang.zhang@gmail.com>
References: <20230511121159.463645-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the of_match_table to enable DT support
of Loongson-1 watchdog driver.
And modify the parameter of devm_clk_get_enabled() accordingly.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V1 -> V2: Change the wildcard compatible string to specific ones
          Use of_match_ptr() to aviod the build error when CONFIG_OF=n
---
 drivers/watchdog/loongson1_wdt.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
index 3c651c50a98c..4ac7810a314d 100644
--- a/drivers/watchdog/loongson1_wdt.c
+++ b/drivers/watchdog/loongson1_wdt.c
@@ -5,6 +5,7 @@
 
 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 
@@ -112,7 +113,7 @@ static int ls1x_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(drvdata->base))
 		return PTR_ERR(drvdata->base);
 
-	drvdata->clk = devm_clk_get_enabled(dev, pdev->name);
+	drvdata->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(drvdata->clk))
 		return PTR_ERR(drvdata->clk);
 
@@ -144,10 +145,20 @@ static int ls1x_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id ls1x_wdt_dt_ids[] = {
+	{ .compatible = "loongson,ls1b-wdt", },
+	{ .compatible = "loongson,ls1c-wdt", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ls1x_wdt_dt_ids);
+#endif
+
 static struct platform_driver ls1x_wdt_driver = {
 	.probe = ls1x_wdt_probe,
 	.driver = {
 		.name = "ls1x-wdt",
+		.of_match_table = of_match_ptr(ls1x_wdt_dt_ids),
 	},
 };
 
-- 
2.39.2

