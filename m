Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA1F5FF336
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiJNRyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiJNRyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:54:41 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D917BF75;
        Fri, 14 Oct 2022 10:54:40 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so5446534pjl.0;
        Fri, 14 Oct 2022 10:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wmd4wvJqpqY60zoqrpnViqbsnHydL7TwQT2l6YcLmqI=;
        b=iB41m4KyiYjsuc0dggnZ35JbaHLv98PAwYo8Dm1EjKVq8/SmkHlFEq5GwQxCep3pyP
         /4w9dg8LhXRLtkK/0zUurv/wXpJ3m4Rl9xWVRpFHMnuQlrTzJKSa2GMOXDUKn0VJlqwZ
         SzEh3cAK2YSOQ60lUJ76mDVN99dTaYgD0YGfMuUS2/T3IMGByqtsM6gCKSuSjoXqKuye
         gzT18bhQSFBO6cOTYzBgCPyoi9oldutWo/xoD2XCrUXFKL0iYocMSLU1BKJfeHZAosPq
         Pg4HxTHPciq3P4bg2XUSoSxupEGZ7JvCr+mamCNfPPN7BvPLvhk4unO8uRKSL9n6iI4W
         ZhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wmd4wvJqpqY60zoqrpnViqbsnHydL7TwQT2l6YcLmqI=;
        b=pnkoXOgv/We8+nK7dWCayA+ongCjIX/WmFkBAnI+66PrTI92mHGJPQQ3GyBCN2eO6m
         vBi1IcKd+iHoGgnm/bvHdqYphOTMljb0v3Rk/gwL1vDpah2vnir5sa8yW1nkn74+jUyn
         nseqFF7LTVf9Uk6rdgub90jSOah5iIHjdWT+lF/Vrsi8VhhmFmpf+Ijx+TZrJmJ3vV8s
         UsbBZCz+URyyrSvGqFDQge0x4qaN6UfA/4a+p6hD1EiH9yHvG8nT30aQV/KhwBRs1M3K
         KkmOJu64qVhWn+ornWS8U34i1PWaCWa5ohNfvA16azhgSJ813CIkG+zIWgpqm+p2fR/U
         cWig==
X-Gm-Message-State: ACrzQf2G5oRgwOQ4ZtKkA0iXwb4WkNf46pyUowq/oawpCusq7xbpZa/i
        vFpo2zzJmRRN4d/dcRMxeFs=
X-Google-Smtp-Source: AMsMyM7+cfeaKStMmEYIJgtZWE7XxOm7MMWidoPBdz07y9AY5W+pmzz3i8S+tPtip9lhdmoNqWvQRQ==
X-Received: by 2002:a17:90b:180f:b0:20d:4e7f:5f52 with SMTP id lw15-20020a17090b180f00b0020d4e7f5f52mr18916920pjb.119.1665770079544;
        Fri, 14 Oct 2022 10:54:39 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:da06:5604:594f:f6af])
        by smtp.gmail.com with ESMTPSA id jj19-20020a170903049300b0017f7819732dsm2011780plb.77.2022.10.14.10.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 10:54:38 -0700 (PDT)
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
Subject: [PATCH v2 1/9] gpiolib: of: add a quirk for legacy names in Mediatek mt2701-cs42448
Date:   Fri, 14 Oct 2022 10:54:25 -0700
Message-Id: <20221011-gpiolib-quirks-v2-1-73cb7176fd94@gmail.com>
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

The driver is using non-standard "i2s1-in-sel-gpio1" and
"i2s1-in-sel-gpio2" names to describe its gpios. In preparation to
converting to the standard naming (i2s1-in-sel-gpios) and switching the
driver to gpiod API add a quirk to gpiolib to keep compatibility with
existing DTSes.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 0e4e1291604d..cef4f6634125 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -488,6 +488,38 @@ static struct gpio_desc *of_find_usb_gpio(struct device_node *np,
 	return of_get_named_gpiod_flags(np, con_id, idx, of_flags);
 }
 
+static struct gpio_desc *of_find_mt2701_gpio(struct device_node *np,
+					     const char *con_id,
+					     unsigned int idx,
+					     enum of_gpio_flags *of_flags)
+{
+	struct gpio_desc *desc;
+	const char *legacy_id;
+
+	if (!IS_ENABLED(CONFIG_SND_SOC_MT2701_CS42448))
+		return ERR_PTR(-ENOENT);
+
+	if (!of_device_is_compatible(np, "mediatek,mt2701-cs42448-machine"))
+		return ERR_PTR(-ENOENT);
+
+	if (!con_id || strcmp(con_id, "i2s1-in-sel"))
+		return ERR_PTR(-ENOENT);
+
+	if (idx == 0)
+		legacy_id = "i2s1-in-sel-gpio1";
+	else if (idx == 1)
+		legacy_id = "i2s1-in-sel-gpio2";
+	else
+		return ERR_PTR(-ENOENT);
+
+	desc = of_get_named_gpiod_flags(np, legacy_id, 0, of_flags);
+	if (!gpiod_not_found(desc))
+		pr_info("%s is using legacy gpio name '%s' instead of '%s-gpios'\n",
+			of_node_full_name(np), legacy_id, con_id);
+
+	return desc;
+}
+
 typedef struct gpio_desc *(*of_find_gpio_quirk)(struct device_node *np,
 						const char *con_id,
 						unsigned int idx,
@@ -498,6 +530,7 @@ static const of_find_gpio_quirk of_find_gpio_quirks[] = {
 	of_find_regulator_gpio,
 	of_find_arizona_gpio,
 	of_find_usb_gpio,
+	of_find_mt2701_gpio,
 	NULL
 };
 

-- 
b4 0.11.0-dev-5166b
