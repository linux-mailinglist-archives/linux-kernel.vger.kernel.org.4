Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3D65EB98D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 07:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiI0FWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 01:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiI0FWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 01:22:22 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71A8A4B0A;
        Mon, 26 Sep 2022 22:22:21 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x1so8121299plv.5;
        Mon, 26 Sep 2022 22:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=3j4b92DwpvdfhyOymI2HB+rSceuQTEyqD3p3cMeax1o=;
        b=bKtEh9h966Ux12iNBMJD5poe0ZpPevjIxqJhSC/44cLliPzoE96Up+5TRcKnnbnCB3
         H7LlFH3yHXpDs5soKmw1B/VhePDT5i/MIZ05W+GjJBcsso3xBod06hB0ERmSUrXJaHM4
         jj/GhkQZak5Sr2scydVMSPNRbWvU75OUS1y/MuCpivhYLK6BhZHs+Pb5QlBJgUVfWsjm
         AlQhAIRQfF1DgLyauS/NOFB8IJ6MnO0ISEKYexvFpQwZJghXfIJ4WhwZ2xfKhipiwocB
         0DGydJQ9/rgSxH9QTUA8lrQfb5EZfDDKAfnDV6YdvUu+OrtmxTvG1E+4aNdbpm2M9Mwj
         8+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=3j4b92DwpvdfhyOymI2HB+rSceuQTEyqD3p3cMeax1o=;
        b=kzRYwq7uaw6wA5y0SQsP7BQ0QowudHfokCIl4ak2MwuSJ7jJ6/9ajWnkUy6e9+e6HD
         vlT0UrDooiGhX7c644kxE+8HkwwaXZUvOvJu5QNWIQKVArDzfi4flRyzu2to12ZNUUTQ
         38UwU6OF3BzX88Bp47XLftV1Jufz+SL1wKUmWRputZQuhzthEbA1XwwndM/j5LR0HNwb
         MijMFl8B8+2aWOxIhma+4D0yUl6kmRp2+8iprj4T9a63ycgDjOXP7Jh/xAYD1rSbP24r
         p7Y/Dw+SfRjgaKUOFQGCyUyMvxHrkRmgCRzNqiC315mF1NKjtZE/HRDXvizKAQYTM9Oj
         3SMg==
X-Gm-Message-State: ACrzQf2qLVxlAK2GNBq2wutvwlGVEcXKekzdPcmkHrD4W6RQJsGJuCxL
        8u45VkbaIKm1MFuq5gpRsQY=
X-Google-Smtp-Source: AMsMyM7KBmgBiY4SRNO72W9M6fcFVHhJVjzQgvc5o1f/Wn7uFyvKTa5IRBj/EIb2epK2dG2MG8jlLA==
X-Received: by 2002:a17:902:e848:b0:176:c746:1f69 with SMTP id t8-20020a170902e84800b00176c7461f69mr25640509plg.125.1664256140876;
        Mon, 26 Sep 2022 22:22:20 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:9739:ab49:3830:2cbb])
        by smtp.gmail.com with ESMTPSA id z187-20020a6265c4000000b005367c28fd32sm504811pfb.185.2022.09.26.22.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 22:22:20 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Input: twl4030-pwrbutton - add missing of.h include
Date:   Mon, 26 Sep 2022 22:22:13 -0700
Message-Id: <20220927052217.2784593-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
MIME-Version: 1.0
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

The driver is using of_match_ptr() and therefore needs to include
of.h header.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/twl4030-pwrbutton.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
index b307cca17022..e3ee0638ffba 100644
--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -26,6 +26,7 @@
 #include <linux/errno.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/twl.h>
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

