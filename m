Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CF85FF343
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiJNRzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiJNRzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:55:04 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC2A2DA83;
        Fri, 14 Oct 2022 10:54:52 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso5419028pjk.1;
        Fri, 14 Oct 2022 10:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItwD3cs9eKU04Q3Z4ewr71YmDkGz4wd+DL/2Fjg5hWk=;
        b=qrN4P68onQDZsUtaXu/yhnboZR61v4aI0p4hv6B8PSm6Qxn0fOoSKoWHQxyw+tbOpf
         fmCFR20jX80FgTYk1BJSbrGyTxEoKkwt1SD/FyN2jTj1YWZqpLu6GW42zQjYb6xdcWe/
         tsNA2gGGmbJW+SsAdU3tq5p40BmHJZSxcgQObb6bQQothniQbLmsMn4ia0nvyZmVJRWK
         NHCQgAGBG+zOwUYxO9181oLcE0KCcM+si+09N8pLU5yrX+LkEcCY/8kMe4ymQdJcywIP
         eEZf8ToJR0AA0yLP6uz6Fz3vqlZVg4/xWhPK1mzsIqofcqFTn3cz/zYmjok2MhzEEx6F
         JHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItwD3cs9eKU04Q3Z4ewr71YmDkGz4wd+DL/2Fjg5hWk=;
        b=VIDa81dVaR8y4iVDftbTbDCgQ9WBpZLsQ+GeFw9DpY94zPwLxE+LQO8xC4Xlm/8Lqb
         zPpesD9F6g7UQPO8acvwwzX/S2WV9fojcELYkuQeVt4sKRenV0ChHZMIpMqEtY+b1lIC
         tdB/UxiTad0lBQOa57qyNKnpjKMpt5Els8SwiHq+ZN3ObYQck9DYNfzJVU0ESEBsOIQf
         XTnpq73VPWi7M68/yaMZtSdLNpk2Ryehvw77oBZCLsGkkeh66CQBbpUcZHVwomzsHXkh
         TWikHfRDPUhvw2gLn4PEG25IlaQI4uwMa0iFVFnNvFRTV0siHRXzzPYr8MUyGSpjsi3w
         9oYQ==
X-Gm-Message-State: ACrzQf2brTlxUhv9jn5oIkvAZoJKq7th+btN56FeBFN45arwpcHrTkan
        ZroKpyl197kf0l9Xrk0xb3A=
X-Google-Smtp-Source: AMsMyM7G6avsisY9dI9QyeETgZIog9Vw/1K3JMS6R5u6NAboiuA4lkzcXvuoyaM2vIsJndlNcEyA7Q==
X-Received: by 2002:a17:902:ced2:b0:17f:5eb2:cd72 with SMTP id d18-20020a170902ced200b0017f5eb2cd72mr6277520plg.162.1665770091373;
        Fri, 14 Oct 2022 10:54:51 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:da06:5604:594f:f6af])
        by smtp.gmail.com with ESMTPSA id jj19-20020a170903049300b0017f7819732dsm2011780plb.77.2022.10.14.10.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 10:54:50 -0700 (PDT)
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
Subject: [PATCH v2 8/9] gpiolib: of: add quirk for phy reset polarity for Freescale Ethernet
Date:   Fri, 14 Oct 2022 10:54:32 -0700
Message-Id: <20221011-gpiolib-quirks-v2-8-73cb7176fd94@gmail.com>
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

Bindings for Freescale Fast Ethernet Controller use a separate
property "phy-reset-active-high" to specify polarity of its phy
gpio line. To allow converting the driver to gpiod API we need
to add this quirk to gpiolib.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index da274d9adcdf..805222a2e6bc 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -231,6 +231,33 @@ static void of_gpio_flags_quirks(const struct device_node *np,
 	    !strcmp(propname, "snps,reset-gpio") &&
 	    of_property_read_bool(np, "snps,reset-active-low"))
 		*flags |= OF_GPIO_ACTIVE_LOW;
+
+	/*
+	 * Freescale Fast Ethernet Controller uses a separate property to
+	 * describe polarity of the phy reset line.
+	 */
+	if (IS_ENABLED(CONFIG_FEC)) {
+		static const char * const fec_devices[] = {
+			"fsl,imx25-fec",
+			"fsl,imx27-fec",
+			"fsl,imx28-fec",
+			"fsl,imx6q-fec",
+			"fsl,mvf600-fec",
+			"fsl,imx6sx-fec",
+			"fsl,imx6ul-fec",
+			"fsl,imx8mq-fec",
+			"fsl,imx8qm-fec",
+			"fsl,s32v234-fec",
+			NULL
+		};
+
+		if (!strcmp(propname, "phy-reset-gpios") &&
+		    of_device_compatible_match(np, fec_devices)) {
+			bool active_high = of_property_read_bool(np,
+						"phy-reset-active-high");
+			of_gpio_quirk_polarity(np, active_high, flags);
+		}
+	}
 }
 
 /**

-- 
b4 0.11.0-dev-5166b
