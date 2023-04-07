Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB2F6DABE7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbjDGLBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbjDGLBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:01:01 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16F859D8;
        Fri,  7 Apr 2023 04:00:55 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so43035742pjz.1;
        Fri, 07 Apr 2023 04:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680865254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzVQzob6w+uGiqMm+prIjkfjAtxo6cGiHRkUXlkvJQE=;
        b=TX/X/r2mQwqCY10LHjcYSXqp/+x3G7pptxPF/QLR8hauClknYFW0K+kRtmlUVEkDdv
         MTAkK9WsuKZZGnrU9/P8a3AUyA9LH2nw9RjZ2Dc3mDVMQUVDaXXkppNOI4iL3iGDmhLN
         JV1nfbFR5RVfGPbUSBvIjJYiXpP9vggrmOnpKwMD9YxKZzQwIP5+NNobcmLgzfvO1TXo
         94vLS1Ks6kDqqMVEi9UWlfr56I/ERFgYj7egswrd9ffbcttBr3w15jN8tLVBDRVsOUdY
         XekU2Ow24gw2Vi9gqANXDwCXaeYRBaZZ3Pm7dhLJFBCWRf3cs7qQrU4yNdMuSXuVaH6/
         iROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680865254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzVQzob6w+uGiqMm+prIjkfjAtxo6cGiHRkUXlkvJQE=;
        b=1nP1xEPLodUhavr12Kh+/kMNRAjhq+fR63n472aqTOq2BNQukqHx+lrqA0SiNQIwvb
         Zn6iXsTZ+9w5K3DIzHAre80Yd8ngQfF/qWntVQT9MGdUdeBvQ0UshulRpuBmR1iAqyxW
         FmzLDteftDOWYJ5JDaFvKf8DEBCbM/glYI6JXXlNRMkVl4m0Qkna6OwtxM7Pv8zJe9M2
         l08xEJsCPsbEve3LGUNa6UhK10TgluZtujbgaXfsE49g9kn3060KUha+/5LZWRc1lozH
         3Rx2yT0l3WC0ebCxJBxE9WR9vtmlPWxIFwjJxuHr0MbY7ol4hNlCJ8iLjySTnuyrIcuU
         hbrQ==
X-Gm-Message-State: AAQBX9dLzs2W1zx62nedDF2cypyYAUh5PGtrpTOOlT95sZCM0Hsw5l8j
        BfzLFreJMYitQ0TjO08DyEf6LfBk6q5wCQ==
X-Google-Smtp-Source: AKy350b/DkHRgvHytEVipvniMLkEFq7pYID8W12uMSjXDNyXHlFxmG/zcmjPkV7my8RwqgGUidkhUg==
X-Received: by 2002:a17:902:f541:b0:1a1:d366:b085 with SMTP id h1-20020a170902f54100b001a1d366b085mr3069596plf.21.1680865254264;
        Fri, 07 Apr 2023 04:00:54 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.84.161.179])
        by smtp.gmail.com with ESMTPSA id jw1-20020a170903278100b0019ee042602bsm2732005plb.92.2023.04.07.04.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 04:00:53 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yang Ling <gnaygnil@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 2/2] watchdog: loongson1_wdt: Add DT support
Date:   Fri,  7 Apr 2023 19:00:25 +0800
Message-Id: <20230407110025.516405-3-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407110025.516405-1-keguang.zhang@gmail.com>
References: <20230407110025.516405-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the of_match_table to enable DT support
of Loongson-1 watchdog driver.
And modify the parameter of devm_clk_get() accordingly.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 drivers/watchdog/loongson1_wdt.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
index bb3d075c0633..c2694222ea86 100644
--- a/drivers/watchdog/loongson1_wdt.c
+++ b/drivers/watchdog/loongson1_wdt.c
@@ -5,6 +5,7 @@
 
 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 #include <loongson1.h>
@@ -100,7 +101,7 @@ static int ls1x_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(drvdata->base))
 		return PTR_ERR(drvdata->base);
 
-	drvdata->clk = devm_clk_get(dev, pdev->name);
+	drvdata->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(drvdata->clk))
 		return PTR_ERR(drvdata->clk);
 
@@ -142,10 +143,19 @@ static int ls1x_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id ls1x_wdt_dt_ids[] = {
+	{ .compatible = "loongson,ls1x-wdt", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ls1x_wdt_dt_ids);
+#endif
+
 static struct platform_driver ls1x_wdt_driver = {
 	.probe = ls1x_wdt_probe,
 	.driver = {
 		.name = "ls1x-wdt",
+		.of_match_table = ls1x_wdt_dt_ids,
 	},
 };
 
-- 
2.34.1

