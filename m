Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18E060F0D9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbiJ0G6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbiJ0G5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:57:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCD21633A3;
        Wed, 26 Oct 2022 23:55:59 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so646916pji.0;
        Wed, 26 Oct 2022 23:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jf24NLbsU8ask7SM9WbvKjapzt603tSoicBq9TM59p0=;
        b=j9TwfG7tRhD0JT9otRxnwA5Tb6uM8vQKwVRSDS/zeOrXoAkCjAe1YbjSmLBZ39V1p0
         BsD7khiVnQq3fOkT1vJfl6bwIfk3U888ldYxOhHvkuTtzWGzUZ0NBgI6ErTw0S5SlhH9
         Yk48LLK4rKMBsTWkxyPZfPuJKecacf3GJ52cf9sFQUfuTvLcxkv71zlKHx/XzGuy3ZVr
         4evoXXXRls0jdzdj5CX9cUy1Vp0zhorJDl6ThzDKbfWgRC4ny0qmCOJAq0pbV/u12WK4
         Fu+VlvyerziKPgIDMR/jYE5TICvIW3aC/Xyz0YxgL199XulbUDxtVDoCbhOXjeFh41Jc
         t05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jf24NLbsU8ask7SM9WbvKjapzt603tSoicBq9TM59p0=;
        b=gNABhg2KJrkeHdCyyBr6M6gfQZ4vGY7hm2Fo/KPQOjSMeIMXXckcnw+5DdECsbnDdw
         nteFcSXwysxXuj+Lfw4OEyvCBkbSaKt5cWEAdCfSfgutun5gILmMk3qnAUinB48OS2ol
         Q7UlXCGkvmsGPmreZPjUlMxi/53y5K0muuni6okNZztEOW4muJwnlnNZxMuzIiQrvCcT
         vVWoVN6Gr576+QDJOKE8ZxkQwE/49I70OzXCLZJp8wwdXuUHmBCRSZXCzSQOfFk4HsI6
         Zqs4OHXfTTANRyeWymx7XBfwfO1HQnPtH0B0Ozq4UqMq61JjsWdwQUn9472wdA+NUzGi
         fJ1g==
X-Gm-Message-State: ACrzQf0P3fE7ULfqwZaf8MgoQ29Br2E9bEl/E19ZZ3aGi/9T7A6ZbtN4
        YGcCGdQV+1GDEq1tWOtnflQ=
X-Google-Smtp-Source: AMsMyM6Z5BPeJFtq9ZQCWYDYdOcSXjcrbGtbV+lmUTu1wG1dCdjMfvbMKAiLzwkn2GkuDRC8Cm4Rhw==
X-Received: by 2002:a17:90a:d50e:b0:213:7a2e:8991 with SMTP id t14-20020a17090ad50e00b002137a2e8991mr394348pju.113.1666853759073;
        Wed, 26 Oct 2022 23:55:59 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:99d6:ae15:f9aa:1819])
        by smtp.gmail.com with ESMTPSA id h7-20020a17090a710700b00213202d77d9sm405482pjk.43.2022.10.26.23.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 23:55:58 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] gpiolib: of: add polarity quirk for Freescale PCIe controller
Date:   Wed, 26 Oct 2022 23:55:53 -0700
Message-Id: <20221027065553.801153-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221027065553.801153-1-dmitry.torokhov@gmail.com>
References: <20221027065553.801153-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings for Freescale PCIe controller use a separate property called
"reset-gpio-active-high" to control polarity of its reset line, add it
to the list of quirks in gpiolib so that gpiod API can be used in the
driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 331744c75faf..1d37172579d1 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -208,6 +208,15 @@ static void of_gpio_set_polarity_by_property(const struct device_node *np,
 		{ "fsl,imx8qm-fec",  "phy-reset-gpios", "phy-reset-active-high" },
 		{ "fsl,s32v234-fec", "phy-reset-gpios", "phy-reset-active-high" },
 #endif
+#if IS_ENABLED(CONFIG_PCI_IMX6)
+		{ "fsl,imx6q-pcie",  "reset-gpio", "reset-gpio-active-high" }
+		{ "fsl,imx6sx-pcie", "reset-gpio", "reset-gpio-active-high" }
+		{ "fsl,imx6qp-pcie", "reset-gpio", "reset-gpio-active-high" }
+		{ "fsl,imx7d-pcie",  "reset-gpio", "reset-gpio-active-high" }
+		{ "fsl,imx8mq-pcie", "reset-gpio", "reset-gpio-active-high" }
+		{ "fsl,imx8mm-pcie", "reset-gpio", "reset-gpio-active-high" }
+		{ "fsl,imx8mp-pcie", "reset-gpio", "reset-gpio-active-high" }
+#endif
 
 		/*
 		 * The regulator GPIO handles are specified such that the
-- 
2.38.0.135.g90850a2211-goog

