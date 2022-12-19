Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4AB6512CF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbiLSTWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbiLSTVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:21:47 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158511704D;
        Mon, 19 Dec 2022 11:20:23 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id a9so9981215pld.7;
        Mon, 19 Dec 2022 11:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTlUHMQAwjLi947gmhUW7QqFF5pDNu/GVVsBTdlEvDc=;
        b=Z0xpP8n27UOvhgOKqawE8G+NcZ4CkicUeK0lsXh7p3SzVNgwQsyPRfYQ4X61bpP4vO
         8XBuLnuBaZTmd+XL1fIymeJ8ad1SZvsdZN/syXaUhoo8zNE0xcqIBWT1XN+nZgwnb0IO
         Dn+HyrT23P7MoX+9aUkxY5gtiitPdN70VlHKEivWuB5oPYHUcRUSIdifDD73AmQLQFHL
         zXZk0R6SCyZSgK/fuMkcKeBv7Pky2VgCFxBDPkA3Pq2qDyjqnL1Hpd60BZi8RhbxltFZ
         yFMpfflLCCPy0LqVyPUQ7T0aCRk6iAeQLte2r4I3hD2GulFh8/vYplW0gcWiSfw+OWcs
         fe8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTlUHMQAwjLi947gmhUW7QqFF5pDNu/GVVsBTdlEvDc=;
        b=dgrvBiQJU2j0qp/SE0Mlwz8aLkY+y/4G2RV6rkPDeAr2z0rzlm8RWDvvK9qzL3pXOG
         V5RkqYvoOAaAiNhi/5J7cSQOTzUkTtGqrmb4kQjdG4bdMZweYeQbUKKiM0BDpMgda0fe
         TOGv/cq3a7/dkMhe+hfk1X/45/OgHn7T68sJLS1gmIQoaoYxEr4UIa3vffiS35ZzvMYb
         nC8uIOEAOwPqEofKKhBcVsJrPEPebHLS1P3ZMXxoUtqggibmwQNNcR4fx1cre7Za+fCW
         XaanWxx0qfRxFNGrmqCX/PdBonKZcoG0hbZ2JtgdYZFL2KbNnadWjh6f3jlU06y0Bu8i
         mKaA==
X-Gm-Message-State: ANoB5pnYWB+pD3nxkPBVwS9qxrmnGc4H8Jwp9bXDP6zo1kjCG87J+aQW
        vRBc8OKbHHXw7HmcPzQsS8I=
X-Google-Smtp-Source: AA0mqf6hyHoJs0tsdismLFc929oDySWvIPN25bhkjJVQPPialus8QOaE1vqfbWgN7myXtSMTcizJUg==
X-Received: by 2002:a17:902:bc89:b0:18f:8f1e:e69f with SMTP id bb9-20020a170902bc8900b0018f8f1ee69fmr33904903plb.19.1671477622441;
        Mon, 19 Dec 2022 11:20:22 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:4c62:79e:b4cd:2cbb])
        by smtp.gmail.com with ESMTPSA id b6-20020a1709027e0600b001869f2120absm7488342plm.294.2022.12.19.11.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 11:20:21 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/5] gpiolib: of: stop exporting of_gpio_named_count()
Date:   Mon, 19 Dec 2022 11:20:13 -0800
Message-Id: <20221219192016.1396950-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221219192016.1396950-1-dmitry.torokhov@gmail.com>
References: <20221219192016.1396950-1-dmitry.torokhov@gmail.com>
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

The only user of this function is gpiolib-of.c so move it there.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 26 ++++++++++++++++++++++++++
 include/linux/of_gpio.h   | 26 --------------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 4fff7258ee41..6724e375678d 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -23,6 +23,32 @@
 #include "gpiolib.h"
 #include "gpiolib-of.h"
 
+/**
+ * of_gpio_named_count() - Count GPIOs for a device
+ * @np:		device node to count GPIOs for
+ * @propname:	property name containing gpio specifier(s)
+ *
+ * The function returns the count of GPIOs specified for a node.
+ * Note that the empty GPIO specifiers count too. Returns either
+ *   Number of gpios defined in property,
+ *   -EINVAL for an incorrectly formed gpios property, or
+ *   -ENOENT for a missing gpios property
+ *
+ * Example:
+ * gpios = <0
+ *          &gpio1 1 2
+ *          0
+ *          &gpio2 3 4>;
+ *
+ * The above example defines four GPIOs, two of which are not specified.
+ * This function will return '4'
+ */
+static int of_gpio_named_count(const struct device_node *np,
+			       const char *propname)
+{
+	return of_count_phandle_with_args(np, propname, "#gpio-cells");
+}
+
 /**
  * of_gpio_spi_cs_get_count() - special GPIO counting for SPI
  * @dev:    Consuming device
diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index 39f16a960565..680025c1a55b 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -79,32 +79,6 @@ static inline int of_get_named_gpio_flags(const struct device_node *np,
 
 #endif /* CONFIG_OF_GPIO */
 
-/**
- * of_gpio_named_count() - Count GPIOs for a device
- * @np:		device node to count GPIOs for
- * @propname:	property name containing gpio specifier(s)
- *
- * The function returns the count of GPIOs specified for a node.
- * Note that the empty GPIO specifiers count too. Returns either
- *   Number of gpios defined in property,
- *   -EINVAL for an incorrectly formed gpios property, or
- *   -ENOENT for a missing gpios property
- *
- * Example:
- * gpios = <0
- *          &gpio1 1 2
- *          0
- *          &gpio2 3 4>;
- *
- * The above example defines four GPIOs, two of which are not specified.
- * This function will return '4'
- */
-static inline int of_gpio_named_count(const struct device_node *np,
-				      const char *propname)
-{
-	return of_count_phandle_with_args(np, propname, "#gpio-cells");
-}
-
 static inline int of_get_gpio_flags(const struct device_node *np, int index,
 		      enum of_gpio_flags *flags)
 {
-- 
2.39.0.314.g84b9a713c41-goog

