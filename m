Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CC35FF345
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiJNRzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiJNRzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:55:11 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AF42FFD1;
        Fri, 14 Oct 2022 10:54:53 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y8so5545233pfp.13;
        Fri, 14 Oct 2022 10:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDr9juWg3u7tqOqaJOOvY3u67HoyFj37SYo8BbenwWk=;
        b=K7/WyOZWPb1Rs6hBURYIqASCfJWT2Ypv8TwWdxwKsLl76h3ZM8LE9cDiE5sYUXXgED
         ypzOhURY5d09mWMjlYXc+SII8+wsHvMD0gUy/765T0ggM48TQeRCi2+CiNUwNMaSdFku
         noZF0GhcUdMc3nnH5TB3bLmnSRcg5QqRVQNtPJi2ZTTQhL0YHsV+H0wnGfopeE+nioAb
         UGmP8/p89sY7HGR6q8RjE92cv/+mU4BSXLJ2ODAfJG8ZlKLXp+F7ni24WTCFu3JqhHn8
         PKB83IW8xGp0+2jZiGDFfWo0PHN41mnnCau1ep5hAiJ0GbxMfviZTW0IF77tiTyxu4Ye
         U92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDr9juWg3u7tqOqaJOOvY3u67HoyFj37SYo8BbenwWk=;
        b=bOZndGjv47XomIkimGH8gTD5Pw9kyrc3tx1orQC2uo0ZTtkN+FuiZL/MB1BuxNOMO4
         N1dVQlc8a2MHbAB35KG1UG++rPk9+m50HOlHRDHR+tagTeWmp65WalgGu/GO4bjafSOn
         gy0W0ACokyjlxrWJvhveesWeVMZEKdCcyFP3KTQQi0oM7rk6sxAhwKLyvwdud+mUEPfm
         H4LzBXdM7XAhE2Rrm5p/EqjJsgt6hGFOhnjhARsLEs4TqxODOhg+6CzN4CRHgKWGyFcA
         PphgAkGtlfHG2JmsiTEMNJd/dZBxtm6HljaAOPot4c99YkgEBLOAE31PUbWcsnQSLSJ7
         evSQ==
X-Gm-Message-State: ACrzQf2H7U9so8F6asWw1kBhC3Wpx34NVn0nhVVkjUFy5G3rT8qqpYoR
        MCp+A2JxPggsy51TxoJWozA=
X-Google-Smtp-Source: AMsMyM66Ubh6jeHbtdegqbobjzrs9/DILurRSxW9pjZiIKKLcEoBNq3fQp7n84VpA3gI2fuXewHT1A==
X-Received: by 2002:a63:1d22:0:b0:439:3e7c:8af7 with SMTP id d34-20020a631d22000000b004393e7c8af7mr5605142pgd.78.1665770092947;
        Fri, 14 Oct 2022 10:54:52 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:da06:5604:594f:f6af])
        by smtp.gmail.com with ESMTPSA id jj19-20020a170903049300b0017f7819732dsm2011780plb.77.2022.10.14.10.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 10:54:52 -0700 (PDT)
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
Subject: [PATCH v2 9/9] gpiolib: of: add a quirk for reset line polarity for Himax LCDs
Date:   Fri, 14 Oct 2022 10:54:33 -0700
Message-Id: <20221011-gpiolib-quirks-v2-9-73cb7176fd94@gmail.com>
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

Existing DTS that use legacy (non-standard) property name for the reset
line "gpios-reset" also specify incorrect polarity (0 which maps to
"active high"). Add a quirk to force polarity to "active low" so that
once driver is converted to gpiod API that pays attention to line
polarity it will work properly.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 805222a2e6bc..26d57465fec9 100644
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
