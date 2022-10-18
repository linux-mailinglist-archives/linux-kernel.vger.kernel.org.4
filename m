Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EB26023EE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiJRFmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiJRFli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:41:38 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A019E2E8;
        Mon, 17 Oct 2022 22:41:30 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p3-20020a17090a284300b0020a85fa3ffcso16327042pjf.2;
        Mon, 17 Oct 2022 22:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wp1cBpWUY30jjN2J7CcGdlUhYOxMYiDZ9klcTi4agnU=;
        b=ee8rh4QG2mAL7Ri/3NtGm/AHCynx43fRJ5aRgRJR/rvsR5wTw4Tw04fE+heq/NH2gx
         /NCfeGqVp/p+aj2pS+E4ujKOQDA/DuV1KoEDSx48yWFOBP4lWUBkErwbCzXplrX/Fscq
         WLqvn0iEEYZRmuu1zbIs9qhbKBpA1xS6lu+PpOaNnOuwBQ7/GzH6Lb+xk0jPVWMZDiZ3
         iyZ9K+RNP185XOSck/dWYS+W7gQAdVcUXzK0PbXoNrQU9H7iuxQ0ulYD7NNfHkkaMeMI
         jF6tjXA6BCcJcasknRWtW5KPX6IPeyTYUerhW0kq9hSLwOfAPo+YqXXr/x5w79zKhVfV
         NURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wp1cBpWUY30jjN2J7CcGdlUhYOxMYiDZ9klcTi4agnU=;
        b=Dikrpf+wq46eozRfyRpeBjuKgp32NznnImEvP3I/HgS6lwi/rExR0EjY/UiemxGHXR
         s3cJ7ctGTc7okz6DFEkmk3YaqeCpdSKzYfjRCu2lkwL0ddYg2/S8kzS+ie8hbcwKyi8+
         yDCHLV1H7YcFf5dO7tLOIoNcXtxW4m8BERO4Q/kwyf2KnZ19DYC0vBt5u0nmW0m6887j
         cAeW0L2fEyY0+eYIx6sJefqD45Fx9BtLHlv2TxFV7zLbX0SueE+0V7dBN2ABJkfsjPUM
         l+UKuDzo9XE/NRlNYqwzqndod4HsAzfvuHNWsZSC71KolO7gxj2o0DHzMLkWcZLWbS8y
         mgrQ==
X-Gm-Message-State: ACrzQf3mVNtYO8wZ1gi6oJCae5OPhrjglD/xlnKTpOBAaeJwSsGM3s1N
        crtSdr6ymYHkvfwxT5H+RjY=
X-Google-Smtp-Source: AMsMyM72OZc8jyvkubedFterjeulwVvYQX/Vfc+Prm+hEtd0voYoAJr9Lpg4D227RLB7V7esYmNEag==
X-Received: by 2002:a17:90b:1e0b:b0:20d:7ddf:9b08 with SMTP id pg11-20020a17090b1e0b00b0020d7ddf9b08mr1665378pjb.187.1666071688833;
        Mon, 17 Oct 2022 22:41:28 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:f7bc:1bb5:e0b1:92cb])
        by smtp.gmail.com with ESMTPSA id z7-20020a1709027e8700b00172f4835f53sm7597435pla.192.2022.10.17.22.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 22:41:28 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v3 07/10] gpiolib: of: add a quirk for legacy names in MOXA ART RTC
Date:   Mon, 17 Oct 2022 22:41:08 -0700
Message-Id: <20221011-gpiolib-quirks-v3-7-eae9cc2ed0a1@gmail.com>
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

The driver is using non-standard "gpio-rtc-data", "gpio-rtc-sclk", and
"gpio-rtc-reset" names for properties describing its gpios. In
preparation to converting to the standard naming ("rtc-*-gpios") and
switching the driver to gpiod API add a quirk to gpiolib to keep
compatibility with existing DTSes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index ffdbac2eeaa6..d22498c72a67 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -390,6 +390,11 @@ static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
 #if IS_ENABLED(CONFIG_MFD_ARIZONA)
 		{ "wlf,reset",	NULL,		NULL },
 #endif
+#if IS_ENABLED(CONFIG_RTC_DRV_MOXART)
+		{ "rtc-data",	"gpio-rtc-data",	"moxa,moxart-rtc" },
+		{ "rtc-sclk",	"gpio-rtc-sclk",	"moxa,moxart-rtc" },
+		{ "rtc-reset",	"gpio-rtc-reset",	"moxa,moxart-rtc" },
+#endif
 #if IS_ENABLED(CONFIG_NFC_MRVL_I2C)
 		{ "reset",	"reset-n-io",	"marvell,nfc-i2c" },
 #endif

-- 
b4 0.11.0-dev-5166b
