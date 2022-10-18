Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC916023F4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiJRFmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiJRFlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:41:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F3AA344C;
        Mon, 17 Oct 2022 22:41:33 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 70so12977283pjo.4;
        Mon, 17 Oct 2022 22:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaKCpTaQOM7oy+irhSb/L7sMiah4MLH0I+sgYpZFdYA=;
        b=YZNP16yD09yoREPsWOruNPclr4jdwc2OvyEtL+Q/xMqzBvIrpr3WxzzAwOPLbp4e7L
         eefS9hRfZcfgMrZP47TIwnO/C0aOPslNe5DPDfWxS37bzccir2OFPHNwGgZUIubcIFnc
         nhjGKqgSpnJDGy8rKC8bpolKaHqfT6o71TCXMnmidh1JJCpdyTBhrsBENtuqWLh6Ud6g
         4u5D4nG/JVx003mINsDiyaBR1LH2OpOl35AeNOJ7Qismy8SixfjVhmeUxBOtTIwViKBE
         njHD2kw4FHEoWZwjYBCs7xmHJoF/5xkglS+/xto323zYrhBpzTYsQztXVDK3xasTeb/c
         t3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaKCpTaQOM7oy+irhSb/L7sMiah4MLH0I+sgYpZFdYA=;
        b=E5s+UfZVJ+cy8h36BLbxosIsT+GZBPfbrgluydgKJiXgmPemwQbWAAEzIwOWuCEMC2
         SvHDNsQH35IE9EMKsEtgBw5S8ClQlpPCPxZV/A2i30VlXmCv2Qkpx5q36xj2+QBNCgIZ
         BW6zNT5tif2goMEfC/K2/wwp0KhEM5nq7bI3gZ8CAR1z2tWfsKG27xAVs5BgvcQIKwT0
         /NSn7dTTkPbKxaARB3mG8id4YRCRQ2Txx5rvT7AFju6Sina9XKXLE9Oel9oEdj/O+SZh
         Q+CAxTWFWgwi5zcRJA1JFckXYfcgFRUaPpEXxyGGYee3+hyoc9uGznMw0Y8EOPrY6yUa
         smJw==
X-Gm-Message-State: ACrzQf3lB/UWd9OIpXc1NOoR3LSr/9SAOLgCXPregUZGUDV7Im0PvINn
        u92BS+VQPOfIKQTVt8kxNdheDhxm9xjX0Q==
X-Google-Smtp-Source: AMsMyM5fllnPD7r8O0aTtwSrfbMe9atjxB7xfGjnHWOFmMUSWnF5KjSvkJlnzTVHw09BY7+BGejjcw==
X-Received: by 2002:a17:903:200a:b0:184:1881:bfd1 with SMTP id s10-20020a170903200a00b001841881bfd1mr1545243pla.95.1666071692411;
        Mon, 17 Oct 2022 22:41:32 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:f7bc:1bb5:e0b1:92cb])
        by smtp.gmail.com with ESMTPSA id z7-20020a1709027e8700b00172f4835f53sm7597435pla.192.2022.10.17.22.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 22:41:31 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v3 09/10] gpiolib: of: add quirk for phy reset polarity for Freescale Ethernet
Date:   Mon, 17 Oct 2022 22:41:10 -0700
Message-Id: <20221011-gpiolib-quirks-v3-9-eae9cc2ed0a1@gmail.com>
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

Bindings for Freescale Fast Ethernet Controller use a separate
property "phy-reset-active-high" to specify polarity of its phy
gpio line. To allow converting the driver to gpiod API we need
to add this quirk to gpiolib.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 6faf0dc7bc31..c2a55ffb2b20 100644
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
