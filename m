Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C979C5B377C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiIIMSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiIIMR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:17:28 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7755B045
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:14:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bz13so2431428wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 05:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=bU+AQcsXemk1KKgCjaU3gvykVFjEj4Zm9kHKe+L3+Kw=;
        b=iQvtBX5HeVBZTuTdnbFs4s01K5RT+yZYm6ePr4u4EJ+AkSd5bnDWuyTEcnduTKl/Cc
         QqI4HK/OP7ub73phvUth6wA8baupqBKEN13e1dGepyahVa09iWbeKHrwoJ5TV2Jyh6Bg
         KTipzfmLLk6wLSvqeEb0DPAi8xWyOSKwVLlM1AvumslzQJ0DLXw4kAWnNojrms050jcq
         RyhogLD29Rc5Scrjca1VXI4C2Sp6oHtEYRNAQVw+6ahdysLqTKe3nHqm+EmK99FT1ZaB
         pstlvCeTu0ieogclGb6Oaylmnz6mVlNsbUXe5lF+yA5xfz4SKl1zRnShwXtp5eUQSx46
         B9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bU+AQcsXemk1KKgCjaU3gvykVFjEj4Zm9kHKe+L3+Kw=;
        b=8Jy2cPj/6pc+Crv/WQ3oGqsl28PGVyM9CzdpioEfdnF1ph750Pg8qG67fLQKdt3bGQ
         0stUvAQFxdO4x0fbnVbnM4fXdYH12dHQRNRUGQkg3qtlIIzRI49TtexUuhtk1cTpijsn
         DziDmu9K2rb/x+lX2m4CWYYbEtyjZMyNXaU1wBaozaqx0Ib/H1i0fQkVLLGJXecFzHzz
         CSrjL2jYBaTD3kxuGxKXzFYmPnTKSAOFMJQgfBzRY/FaGNhhty6eoeOdQRY8hlVdvi3+
         W7LpkaddaEwdd7etAlAmuOtqU8guSiYl/AmsTAj38ONEFSyv8+gA4cRUobwFItvzGtPv
         QbCw==
X-Gm-Message-State: ACgBeo1ywOunwZAe/i2qCkZ8zSrh+jHBE+peQLyGbdWtkBq9OhFcbc7D
        Y7GqkD3EVNuhvJaCEjLz16MQFg==
X-Google-Smtp-Source: AA6agR5ob+DApxRqNiEDoa+ZxnDvTCPp4w6FFXtlz8ogbbKZ7zdj1OifeBdTWLRBEHye6hGCV6yTQQ==
X-Received: by 2002:a05:6000:11d0:b0:228:8d5d:f2e9 with SMTP id i16-20020a05600011d000b002288d5df2e9mr7863995wrx.207.1662725615413;
        Fri, 09 Sep 2022 05:13:35 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a421:c10c:c626:3f52])
        by smtp.gmail.com with ESMTPSA id l10-20020adfe58a000000b0022863395912sm379005wrm.53.2022.09.09.05.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 05:13:35 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 1/2] gpiolib: un-inline gpiod_request_user()
Date:   Fri,  9 Sep 2022 14:13:28 +0200
Message-Id: <20220909121329.42004-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909121329.42004-1-brgl@bgdev.pl>
References: <20220909121329.42004-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pull this bit of code into gpiolib.c as we're soon be calling certain
symbols static in this compilation unit.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/gpiolib.c | 11 +++++++++++
 drivers/gpio/gpiolib.h | 12 +-----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index cc9c0a12259e..6768734b9e15 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2009,6 +2009,17 @@ int gpiod_request(struct gpio_desc *desc, const char *label)
 	return ret;
 }
 
+int gpiod_request_user(struct gpio_desc *desc, const char *label)
+{
+	int ret;
+
+	ret = gpiod_request(desc, label);
+	if (ret == -EPROBE_DEFER)
+		ret = -ENODEV;
+
+	return ret;
+}
+
 static bool gpiod_free_commit(struct gpio_desc *desc)
 {
 	bool			ret = false;
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index d900ecdbac46..b35deb08a7f5 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -179,19 +179,9 @@ struct gpio_desc {
 #define gpiod_not_found(desc)		(IS_ERR(desc) && PTR_ERR(desc) == -ENOENT)
 
 int gpiod_request(struct gpio_desc *desc, const char *label);
+int gpiod_request_user(struct gpio_desc *desc, const char *label);
 void gpiod_free(struct gpio_desc *desc);
 
-static inline int gpiod_request_user(struct gpio_desc *desc, const char *label)
-{
-	int ret;
-
-	ret = gpiod_request(desc, label);
-	if (ret == -EPROBE_DEFER)
-		ret = -ENODEV;
-
-	return ret;
-}
-
 int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 		unsigned long lflags, enum gpiod_flags dflags);
 int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce);
-- 
2.34.1

