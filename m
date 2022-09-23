Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB835E7321
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 06:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiIWEzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 00:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIWEzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 00:55:45 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDE1115BF3;
        Thu, 22 Sep 2022 21:55:43 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id fs14so11815554pjb.5;
        Thu, 22 Sep 2022 21:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=DMY7HYkAo9zgeMOO5S3KtohOefOqFzrjWCOr/lBmUmU=;
        b=HTq8Kfigc42bUsKkoQPRKB8JYBvkBiE88zo19G4EA85XzbeTRBq+xHSBHSGwJREsn8
         6CDNEyOFfyU6NWdJlqLUHbcT6sfvy5AhiDtTJEcYw/ipshRw8ECAnRXZ+eGauVrcgisQ
         OUcmzKID4mqNMqiloAp5ysn895x3Zj84iIyZW2AIzsSY1YXaRazGJN4h/LJGJKSTI6QX
         UDUuO1nW4Wbs/pqUBNwoFcSXVIpSalMBKcIYA47YEb3pg6biJPB7ODsY3YTNHU6nHthk
         Ahw1O/nzJJHOKOod9hyLLlcaLnLE5Ir2GJuOavmLQF7QokYsoi66UZjd6icts82y7uFr
         cGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DMY7HYkAo9zgeMOO5S3KtohOefOqFzrjWCOr/lBmUmU=;
        b=ikKUXxeqr7W5IDhVvGhm+7N0/bjh3AsRzZolihnFtjnK/huPt4xivZnpUfju9G1Igs
         YIVoDpVSTdKJfrS6mteb34FXenVMmZxOjZkXEkXgM5B+/a/EdVuHNZbIV9w/KgMWoGlu
         blrNP+7PFr29kU5CL1x2QrEJWUB0WzObKHr3kUmAcFOhV3jRDong9wT21Xl+dXJ81GP/
         LO3begid4d32dwCYLaAcr/BTfDXM2yfrC2Gy9KX/pIFZtES7KloQFqQpZQ5jka2Ou9fV
         nF7VLRBWCoxF+dx4OmekqXRAeShO8N9fTwnceo2hInEuIpMMHMp53nI2MXp3Vrl7EyWr
         /gIQ==
X-Gm-Message-State: ACrzQf3Sb8SZsQTyyFtERZihwqHzz/yKbc74+mbVc+mAbOAhCmCEueDV
        ZFEZCTOyCuOCNTCtlGIFPXxYs6OsNvA=
X-Google-Smtp-Source: AMsMyM7tr+hwYpg333yQ9TaHzZEsD01IaKnhHAwBKRuWOfQMXeY0OkXW5nknMiPnNnXdBgrnxnrLNA==
X-Received: by 2002:a17:90b:4a50:b0:203:1204:5bc4 with SMTP id lb16-20020a17090b4a5000b0020312045bc4mr19228855pjb.79.1663908943293;
        Thu, 22 Sep 2022 21:55:43 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:8b46:be3c:2c54:68a5])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709027fca00b00178112ed1e5sm4988076plb.117.2022.09.22.21.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 21:55:42 -0700 (PDT)
Date:   Thu, 22 Sep 2022 21:55:40 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Lantiq: switch vmmc to use gpiod API
Message-ID: <Yy08TBymyuQb27NU@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This switches vmmc to use gpiod API instead of OF-specific legacy gpio
API that we want to stop exporting from gpiolib.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/mips/lantiq/xway/vmmc.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/mips/lantiq/xway/vmmc.c b/arch/mips/lantiq/xway/vmmc.c
index 7a14da8d9d15..a1947306ac18 100644
--- a/arch/mips/lantiq/xway/vmmc.c
+++ b/arch/mips/lantiq/xway/vmmc.c
@@ -4,9 +4,10 @@
  *  Copyright (C) 2012 John Crispin <john@phrozen.org>
  */
 
+#include <linux/err.h>
 #include <linux/export.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of_platform.h>
-#include <linux/of_gpio.h>
 #include <linux/dma-mapping.h>
 
 #include <lantiq_soc.h>
@@ -25,6 +26,7 @@ EXPORT_SYMBOL(ltq_get_cp1_base);
 static int vmmc_probe(struct platform_device *pdev)
 {
 #define CP1_SIZE       (1 << 20)
+	struct gpio_desc *gpio;
 	int gpio_count;
 	dma_addr_t dma;
 
@@ -32,16 +34,18 @@ static int vmmc_probe(struct platform_device *pdev)
 		(void *) CPHYSADDR(dma_alloc_coherent(&pdev->dev, CP1_SIZE,
 						    &dma, GFP_KERNEL));
 
-	gpio_count = of_gpio_count(pdev->dev.of_node);
+	gpio_count = gpiod_count(&pdev->dev, NULL);
 	while (gpio_count > 0) {
-		enum of_gpio_flags flags;
-		int gpio = of_get_gpio_flags(pdev->dev.of_node,
-					     --gpio_count, &flags);
-		if (gpio_request(gpio, "vmmc-relay"))
+		gpio = devm_gpiod_get_index(&pdev->dev,
+					    NULL, --gpio_count, GPIOD_OUT_HIGH);
+		if (IS_ERR(gpio)) {
+			dev_err(&pdev->dev,
+				"failed to request GPIO idx %d: %d\n",
+				gpio_count, PTR_ERR(gpio);
 			continue;
-		dev_info(&pdev->dev, "requested GPIO %d\n", gpio);
-		gpio_direction_output(gpio,
-				      (flags & OF_GPIO_ACTIVE_LOW) ? (0) : (1));
+		}
+
+		gpio_consumer_set_name(gpio, "vmmc-relay");
 	}
 
 	dev_info(&pdev->dev, "reserved %dMB at 0x%p", CP1_SIZE >> 20, cp1_base);
-- 
2.37.3.998.g577e59143f-goog


-- 
Dmitry
