Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CE05FF33D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiJNRzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiJNRy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:54:59 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62EE2BB39;
        Fri, 14 Oct 2022 10:54:48 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 70so5563817pjo.4;
        Fri, 14 Oct 2022 10:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hifOoY9aqLLHbcQa2d9K53VxHn7l+VlC4N3fss0zE6o=;
        b=TrpvH1TyIPvuJXDWY1g6ts8rJV3gvM9Nm0JNTBhFYpx2VK44z8Rht7w/Ag7is45ey3
         5ezFxZHhpI1YuXCQLbvQ5ecv06+V+SpA8r3lf/wFqfbcgHg5EQdjS2WVhz1pQNfTH8mw
         66b2PU7ve2MOYaj8Nme0hrcf44ijbJ7sLBuHf9KH/FcrhkMupMn0xH7cQ80fAJa1R7uo
         AJ0nAeFYhJKaANAWnQj8t4Ny1oxgPj9ldWk8x9jBk/mz5+5Uh893cGshBAVNMPpVORGV
         Vnbw5tMxeBSEBR0PeLMJWfW7uuE7fsZLMNQrIgS7369saBkiEQeJV6Y5zPq0r3LNSy6l
         ahqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hifOoY9aqLLHbcQa2d9K53VxHn7l+VlC4N3fss0zE6o=;
        b=n3VmXRbRc5IAwuB7kl0ocbrIBe4y4GZv4fEade4EwsT4RT3/MxMnFsuSfChjg6e+fU
         XnoHfMQ6aCMTmRHhLeQFdDaEFmet6XYxWPBD6kI1SD0eSh59zWV3owUpjM76wYlDiQ4M
         obX6/a6R0iExgN0HPMxkgQog/ADYriDcNWqmwHjmRwN3z53JlM7wEQvVQKuKabqxAZZ/
         wnUUbf8cUe9hjCgD3l+9nRxN9Y4bCgNGTfHl39AEyHtZQgYrwyUPYSM/Ql+S5R/WKMlK
         ocpdni+3YRuzZ5yuiecH1T3Co/UsHjtOigAnI2tbWyLvTqgbQaFo2B40GR6I7ep703md
         0lYA==
X-Gm-Message-State: ACrzQf2C2Jf9qwE3JFLIryYjVMub5V6/88rddtGs9Xq93wQ403zDKoMl
        FaFUpMyZJol4f4/WCNRcA6Y=
X-Google-Smtp-Source: AMsMyM7wLkfeK7I1F9q2E31QSGa2I946SkJ4WKVNKK++Nlyyi1mDDFQDfViwRLKauuXRwbgorVoV9Q==
X-Received: by 2002:a17:90b:1804:b0:20d:a753:7d4c with SMTP id lw4-20020a17090b180400b0020da7537d4cmr11027033pjb.78.1665770087982;
        Fri, 14 Oct 2022 10:54:47 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:da06:5604:594f:f6af])
        by smtp.gmail.com with ESMTPSA id jj19-20020a170903049300b0017f7819732dsm2011780plb.77.2022.10.14.10.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 10:54:47 -0700 (PDT)
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
Subject: [PATCH v2 6/9] gpiolib: of: add a quirk for reset line for Cirrus CS42L56 codec
Date:   Fri, 14 Oct 2022 10:54:30 -0700
Message-Id: <20221011-gpiolib-quirks-v2-6-73cb7176fd94@gmail.com>
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

The controller is using non-standard "cirrus,gpio-nreset" name for its
reset gpio property, whereas gpiod API expects "<name>-gpios".
Add a quirk so that gpiod API will still work on unmodified DTSes.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 5c11ee7638d1..77cabcfb2da0 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -418,6 +418,9 @@ static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
 		{ "wlf,ldo2ena", NULL,		NULL }, /* WM8994 */
 #endif
 
+#if IS_ENABLED(CONFIG_SND_SOC_CS42L56)
+		{ "reset",	"cirrus,gpio-nreset",	"cirrus,cs42l56" },
+#endif
 #if IS_ENABLED(CONFIG_SND_SOC_TLV320AIC3X)
 		{ "reset",	"gpio-reset",	"ti,tlv320aic3x" },
 		{ "reset",	"gpio-reset",	"ti,tlv320aic33" },

-- 
b4 0.11.0-dev-5166b
