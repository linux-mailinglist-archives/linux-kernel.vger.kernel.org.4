Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E6A6023F5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiJRFmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiJRFl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:41:58 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C789E2E9;
        Mon, 17 Oct 2022 22:41:35 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 10so12876793pli.0;
        Mon, 17 Oct 2022 22:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4G7tl3tu203DyVK2JSTYCp8XTOzlUsDNSnxbzKDtrDc=;
        b=DY8rsTzt3XFTA3ilefLgkcsB8eFjSt+06weMni51hOasFmIa7Jotx4YgXvtmEAbbDx
         UPbF2b01JU/WPhhYVVgi7BdTUOk0oJ5LlzsyQb6967vDVgogm+zZwTUawXfemy0JCcSU
         2jplFegk3aDg4yURx0rzogEtqpYN2xZh/8kYwB297rEnsQzASNl19AuUJiDFQ9svKcub
         rAcoQ++Y1eKWirRU5LruBEIcYZLfwu6zso0C7oogfa/o/vGd4cr05NBVUL2Jsg8mOI9i
         MncnVg6O8Uj4+AqllFDOgKhdPwVIH09TmVo2O62iPN7KoLh4EGoQUb0hXT7aPtibgcCt
         CZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4G7tl3tu203DyVK2JSTYCp8XTOzlUsDNSnxbzKDtrDc=;
        b=7RbL3BNhbRZ1w/ZkmvSMaYlv1v8UqnNVR7k4mocmcpxwUubQDn5lsm4O7AP9sXTsqM
         TZ2VR1DOHmKWdtCOkQkLY7MyEjPyJWlnj7stqeiI6D6eqKD72ePScS3BkxGLIU2Gygh4
         TcYiAf68s66k0k4tE08Xy6XuRQlN3rx6AxqD/aOJQ7taNdaiwVfBoNoSgrC+2fPJIGvS
         Qa7DnEHj+9x2GxyOOyYZ+/kfTrDVs/x4M7npPsTGH4mJTisCkINpH3WaYfINtwxSJoJI
         Wvjjnz3QJH91qR2Zv3aKr877xDSrcRbTwH9ht2OPct9+XGXalmI/RM/7Lfjubnb478n6
         +ZPg==
X-Gm-Message-State: ACrzQf1+veoF0WCxQ4iCcbvaY9xPlRAMsFIvCuIbyFhKJM4NVnlTEA9n
        CQP/uvQxcqZBVdlcU1H4xp8=
X-Google-Smtp-Source: AMsMyM5aCgV2chNKlAxGvAIPaU6HYil84zewpav+AIFvUMP05smKopj/ebnWwPFQRHb0YwRVY+VLQw==
X-Received: by 2002:a17:90b:4f4e:b0:20d:9f5b:abbf with SMTP id pj14-20020a17090b4f4e00b0020d9f5babbfmr1748885pjb.148.1666071694222;
        Mon, 17 Oct 2022 22:41:34 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:f7bc:1bb5:e0b1:92cb])
        by smtp.gmail.com with ESMTPSA id z7-20020a1709027e8700b00172f4835f53sm7597435pla.192.2022.10.17.22.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 22:41:33 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v3 10/10] gpiolib: of: add a quirk for reset line polarity for Himax LCDs
Date:   Mon, 17 Oct 2022 22:41:11 -0700
Message-Id: <20221011-gpiolib-quirks-v3-10-eae9cc2ed0a1@gmail.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221011-gpiolib-quirks-v3-0-eae9cc2ed0a1@gmail.com>
References: <20221011-gpiolib-quirks-v3-0-eae9cc2ed0a1@gmail.com>
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

Existing DTS that use legacy (non-standard) property name for the reset
line "gpios-reset" also specify incorrect polarity (0 which maps to
"active high"). Add a quirk to force polarity to "active low" so that
once driver is converted to gpiod API that pays attention to line
polarity it will work properly.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index c2a55ffb2b20..52616848a37c 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -152,11 +152,47 @@ static void of_gpio_quirk_polarity(const struct device_node *np,
 	}
 }
 
+/*
+ * This quirk does static polarity overrides in cases where existing
+ * DTS specified incorrect polarity.
+ */
+static void of_gpio_try_fixup_polarity(const struct device_node *np,
+				       const char *propname,
+				       enum of_gpio_flags *flags)
+{
+	static const struct {
+		const char *compatible;
+		const char *propname;
+		bool active_high;
+	} gpios[] = {
+#if !IS_ENABLED(CONFIG_LCD_HX8357)
+		/*
+		 * Himax LCD controllers used incorrectly named
+		 * "gpios-reset" property and also specified wrong
+		 * polarity.
+		 */
+		{ "himax,hx8357",	"gpios-reset",	false },
+		{ "himax,hx8369",	"gpios-reset",	false },
+#endif
+	};
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(gpios); i++) {
+		if (of_device_is_compatible(np, gpios[i].compatible) &&
+		    !strcmp(propname, gpios[i].propname)) {
+			of_gpio_quirk_polarity(np, gpios[i].active_high, flags);
+			break;
+		}
+	}
+}
+
 static void of_gpio_flags_quirks(const struct device_node *np,
 				 const char *propname,
 				 enum of_gpio_flags *flags,
 				 int index)
 {
+	of_gpio_try_fixup_polarity(np, propname, flags);
+
 	/*
 	 * Some GPIO fixed regulator quirks.
 	 * Note that active low is the default.

-- 
b4 0.11.0-dev-5166b
