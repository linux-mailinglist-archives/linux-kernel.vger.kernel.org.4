Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2E55B8B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiINPMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiINPMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:12:05 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEFC79EE6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 08:11:53 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v185-20020a1cacc2000000b003b42e4f278cso12692338wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 08:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=FDqshHngJe4QAJMkSfGxP7nqWYe+6Ouvyb1oeASj3+A=;
        b=QkFnBx+i96ZfmpkSO/5wXZ8RQ0Ypwl33j1ceEc+0l8HBCXloWYm3nH/wCya6WJ+dZe
         WNep9Abuk+TjW5Fz5L59l/Wtelshxxs2hbCuzzjWfx+zNGl42xIlOEnzb9ZW6lbX/HHK
         tZSV9/M6vGIE6h7fdQYjzgYttkqPOX6pUqHDVR5V9OpfCOGkbf8GVi8jWM49m3okPTwL
         dCTB/0COTN8P9rejIB9IcFyEduC6yeep33ENYBSfFYh5oWpJptyGZT9iNC1WvMuSfP06
         xx5HHdquc9q78oxzMKvgDVTny3jWe488IPZnokjRc6tEGNI7Xl0OP9tdNO+C/mMzx6/5
         +dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=FDqshHngJe4QAJMkSfGxP7nqWYe+6Ouvyb1oeASj3+A=;
        b=GZfn6WOm0cbF+g0QOsgXZ2BYVr/2X/0X89fuSaUZuudNfgbXosir0QMPTh2043KK+Y
         z/UCWm3Lpus+0mcGmjkNAQjg1yoXTfuZMzzOxnX5xnL/AsVdwqrcYTW+R8VQICTdkOca
         1lWf3xJSsJbiAyte3OCHtFGrTV43R4QU6FMsSVVnLjxdYMu7ciSiN3Z2dacaPm9bPFoJ
         J/RxE4WxIA3jbKuOVvt4gjdu9lQhpZfgntSlyBerisI8gvcdojsxg1BUPAeXicYiygrx
         Mf5qPxBK0/Jkq87cPvxIds/1Oh7L7DwcNK/gD2mjVDEthBiuSqkt2shNvsuYZDoIlg5E
         ADUQ==
X-Gm-Message-State: ACgBeo3bWrB0ag9o0GCd33MdZfg4O4MJDeTJAssWR2iiMiE3BmOewYmR
        JrYaTRVEWgYP2d69JVTNXFMVzA==
X-Google-Smtp-Source: AA6agR7UT8Bi3IG8SZxhaWrxDN5WYVN21s7j01/HZd7wV0hHTFaNQwJzsiimN6as7moe9HCEDANLHQ==
X-Received: by 2002:a7b:cc85:0:b0:3b4:9fc7:cd4d with SMTP id p5-20020a7bcc85000000b003b49fc7cd4dmr2759413wma.68.1663168311739;
        Wed, 14 Sep 2022 08:11:51 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e580:6bb0:74a0:252b])
        by smtp.gmail.com with ESMTPSA id b11-20020a05600c4e0b00b003b492753826sm8818481wmq.43.2022.09.14.08.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:11:51 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Drew Fustini <dfustini@baylibre.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] gpiolib: TODO: add an item about GPIO safe-state
Date:   Wed, 14 Sep 2022 17:11:45 +0200
Message-Id: <20220914151145.73253-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.34.1
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

This adds a new TODO item for gpiolib and can also be used to start
a discussion about the need for it and implementation details.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/TODO | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpio/TODO b/drivers/gpio/TODO
index f87ff3fa8a53..6ab39c5cec9d 100644
--- a/drivers/gpio/TODO
+++ b/drivers/gpio/TODO
@@ -197,3 +197,25 @@ A small number of drivers have been converted (pl061, tegra186, msm,
 amd, apple), and can be used as examples of how to proceed with this
 conversion. Note that drivers using the generic irqchip framework
 cannot be converted yet, but watch this space!
+
+Safe-state of GPIOs
+
+During 2022 Linux Plumbers Conference's GPIO & pinctrl BOF it's been discussed
+that we don't have any middle ground between hogging GPIO lines and letting the
+user (either in-kernel or user-space) control them. Either the lines are forever
+reserved as hogs or their state is undefined unless requested.
+
+Currently the behavior of GPIOs that were not requested or were released is
+largely driver dependent (the provider driver decides whether the line's state
+is reverted to some predefined value or left as-is). This can be problematic
+as the output state of a line can damage physical hardware.
+
+This item is about proposing a solution, most likely in the form of a new device
+property called "safe-state" that would define the safe states of specific lines
+(e.g. output-high) but not block the line from being requested by users who 
+could then modify that default state. Once released the GPIO core would then
+put the line back into the "safe-state".
+
+While this could potentially be seen as defining policy in the device-tree, it's
+not anymore a policy than properties such as "regulator-always-on" or gpio-hogs
+themselves are.
-- 
2.34.1

