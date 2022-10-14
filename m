Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D965FF341
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiJNRzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiJNRzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:55:03 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2D22CC9D;
        Fri, 14 Oct 2022 10:54:50 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q9so4925984pgq.8;
        Fri, 14 Oct 2022 10:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovCPxMNt0i2khQD9ZbKAf0f91ILluT414D5KLsvMtco=;
        b=HFcFHjwS441SSkOj2EJ1i/jFRuzEakkG04P1ZVLhsWdMbttmks0f9yASxRbQ+IxNaE
         ggb3CdzaZiF/gVxcQBPV3QBVIKdyiCHTe/Nly27/svHyG7uLM/9OhOyd+HoZ15xDXlaD
         iBI2BGmq08sbu7um1fTyd/8xp0UtGkVbN0csB9w48mZqveth8tibXU/H5lgv2WUm50sA
         zPbnn5qnr1C6sIsWxG3Nw7728oBpZ6wF2vGQVylCqAou7OxRxyCIVnc7kxkDgW0//+by
         2oG9ckqMUXCWzlxA2cm/wq1N1z/l+MA5/iB6X3lTJj2JA7TU/QxRGA9+38YDJwMLsIJA
         tBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovCPxMNt0i2khQD9ZbKAf0f91ILluT414D5KLsvMtco=;
        b=oSuZbxgttMu7inzIYGmKapBuLfSsQsYt+LIi8gIqWUKqWOrX69z6syNCPmnJqUF8FL
         WV1+ijPt8CgD3wBfb+ZbwAZn4eehTCO3rmhoeIcaglmP1fBV259mGKwmAkESHZ4TVMsW
         yAbCDM7J2ZYSFlotd8JRCxf9RCJ++8PlsXBs0HLT+U6hE9bDwZaBowGHCXYg/wQLmyp+
         H81hAgolgtC6huxJQAg93A+3SYBuPehX9VyWwiHT8Yap0ZxKBwICF2uCBbacSX4Nti/I
         BIX7/0b09vkuKJh0fN6E4YE8fFzkf3hvZhZ/woPYxCBLxKeGK19W1Io2Fpojtq/yVLZz
         GdZg==
X-Gm-Message-State: ACrzQf3xeBvk9UuVPK6WHmGao/ZlGJvvDwiIZ97fHfqv6M4JTDzB95q/
        ND3O4LT3f0DlZnntkXbhpp4=
X-Google-Smtp-Source: AMsMyM6YUtWU5/7XIn6e546c/3iIZbpvRvrknueJ+/lzyJPczhtaZQfwcuNJEVFLnkVq/P2M3qeC8w==
X-Received: by 2002:a05:6a02:28b:b0:439:19d6:fad5 with SMTP id bk11-20020a056a02028b00b0043919d6fad5mr5672694pgb.591.1665770089619;
        Fri, 14 Oct 2022 10:54:49 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:da06:5604:594f:f6af])
        by smtp.gmail.com with ESMTPSA id jj19-20020a170903049300b0017f7819732dsm2011780plb.77.2022.10.14.10.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 10:54:49 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org
Subject: [PATCH v2 7/9] gpiolib: of: factor out code overriding gpio line polarity
Date:   Fri, 14 Oct 2022 10:54:31 -0700
Message-Id: <20221011-gpiolib-quirks-v2-7-73cb7176fd94@gmail.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221011-gpiolib-quirks-v2-0-73cb7176fd94@gmail.com>
References: <20221011-gpiolib-quirks-v2-0-73cb7176fd94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.0-dev-5166b
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

There are several instances where we use a separate property to
override polarity specified in gpio property. Factor it out into
a separate function.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 48 +++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 77cabcfb2da0..da274d9adcdf 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -130,6 +130,28 @@ bool of_gpio_need_valid_mask(const struct gpio_chip *gc)
 	return false;
 }
 
+/*
+ * Overrides stated polarity of a gpio line and warns when there is a
+ * discrepancy.
+ */
+static void of_gpio_quirk_polarity(const struct device_node *np,
+				   bool active_high,
+				   enum of_gpio_flags *flags)
+{
+	if (active_high) {
+		if (*flags & OF_GPIO_ACTIVE_LOW) {
+			pr_warn("%s GPIO handle specifies active low - ignored\n",
+				of_node_full_name(np));
+			*flags &= ~OF_GPIO_ACTIVE_LOW;
+		}
+	} else {
+		if (!(*flags & OF_GPIO_ACTIVE_LOW))
+			pr_info("%s enforce active low on GPIO handle\n",
+				of_node_full_name(np));
+		*flags |= OF_GPIO_ACTIVE_LOW;
+	}
+}
+
 static void of_gpio_flags_quirks(const struct device_node *np,
 				 const char *propname,
 				 enum of_gpio_flags *flags,
@@ -145,7 +167,7 @@ static void of_gpio_flags_quirks(const struct device_node *np,
 	     (!(strcmp(propname, "enable-gpio") &&
 		strcmp(propname, "enable-gpios")) &&
 	      of_device_is_compatible(np, "regulator-gpio")))) {
-		bool active_low = !of_property_read_bool(np,
+		bool active_high = of_property_read_bool(np,
 							 "enable-active-high");
 		/*
 		 * The regulator GPIO handles are specified such that the
@@ -153,13 +175,7 @@ static void of_gpio_flags_quirks(const struct device_node *np,
 		 * the polarity of the GPIO line. Any phandle flags must
 		 * be actively ignored.
 		 */
-		if ((*flags & OF_GPIO_ACTIVE_LOW) && !active_low) {
-			pr_warn("%s GPIO handle specifies active low - ignored\n",
-				of_node_full_name(np));
-			*flags &= ~OF_GPIO_ACTIVE_LOW;
-		}
-		if (active_low)
-			*flags |= OF_GPIO_ACTIVE_LOW;
+		of_gpio_quirk_polarity(np, active_high, flags);
 	}
 	/*
 	 * Legacy open drain handling for fixed voltage regulators.
@@ -200,18 +216,10 @@ static void of_gpio_flags_quirks(const struct device_node *np,
 				 * conflict and the "spi-cs-high" flag will
 				 * take precedence.
 				 */
-				if (of_property_read_bool(child, "spi-cs-high")) {
-					if (*flags & OF_GPIO_ACTIVE_LOW) {
-						pr_warn("%s GPIO handle specifies active low - ignored\n",
-							of_node_full_name(child));
-						*flags &= ~OF_GPIO_ACTIVE_LOW;
-					}
-				} else {
-					if (!(*flags & OF_GPIO_ACTIVE_LOW))
-						pr_info("%s enforce active low on chipselect handle\n",
-							of_node_full_name(child));
-					*flags |= OF_GPIO_ACTIVE_LOW;
-				}
+				bool active_high = of_property_read_bool(child,
+								"spi-cs-high");
+				of_gpio_quirk_polarity(child, active_high,
+						       flags);
 				of_node_put(child);
 				break;
 			}

-- 
b4 0.11.0-dev-5166b
