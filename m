Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6CE5BE8E5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiITO1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiITO1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:27:46 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28D7226;
        Tue, 20 Sep 2022 07:27:45 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id q21so4084906edc.9;
        Tue, 20 Sep 2022 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Liib93EzAVK4sIXWmleEPgo27rMYZRDPIdCFkLHuB5M=;
        b=dMG2QRyt14LehNiiB+J9RwfNaOh3XMRlofrRUiXp8eEerZ/Y/yxuZlzRufNhvJsiIP
         79tJAxppdISgWCmQUPj002Y1c1meWmKOfisjkkJ+LG5hzbQ25z6HR9rXB3z0HcpLxQAw
         +gJELaz3TPiaWSd1DRz3dn39Pt5ocYQkl9aQ9xpL7rXGI8rKQMzDsa2xl4EMlcFGOFzH
         wcY3BMLtXDBa6rWTP6Qv1rSXWLw8jCVg9cyGMueXO/XLJIPTdY/uigEm9bHlwW38NEXm
         YBtt/Wbx9bp3/NG7czzZQuhwGu3nklQFFfn9ixLnTHQ+aDQIPl9biEExxyYaon6aAkYz
         Aing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Liib93EzAVK4sIXWmleEPgo27rMYZRDPIdCFkLHuB5M=;
        b=7lRqj3pg4v1NtnM78s5Z0jOwJ5lUMWZtfMnMJy08ThEXosATRic0ybK+ZCKkH5bZj5
         PgMDcMzvdFyW0M8XEEvDAB7V0e+ynsFx5jine6ClgK6dErsSNE/fb+zjQYBUU+NOIG7d
         meb9Hiw+BqeYdnIJ0dq5eegPQGEsoPqDrhEe6XI8AKskaQ/QYib8y2lUqqmq4Zr5ofm8
         diaIxk/bL/7SHvEg8OskyqLFTWOjKjhPALS96brgkg2OiraRIvAvi0yvMW8tVGJGsbps
         +hWq0TNZKgPfwpSAqAgAvhZ30T0zYM2z0cSFyHbbgyjJPXPpbLPXuOYeEX9+lKpKnqyj
         CbwQ==
X-Gm-Message-State: ACrzQf3MbuLxcl4JUKs7/Y3GKQhrufQMWznQ887ONOhAIkB5YbhUTobL
        MnkNx2DQX54m0etj0hyXt8E=
X-Google-Smtp-Source: AMsMyM7coyvmIfxhR6pD9GxGAVD7jsOgaRM34Cdu4jxKnWEkpw364h10JilpoeF3EBQetit6MVb/bw==
X-Received: by 2002:a05:6402:298e:b0:451:129e:1b35 with SMTP id eq14-20020a056402298e00b00451129e1b35mr20165670edb.79.1663684064221;
        Tue, 20 Sep 2022 07:27:44 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709066c8400b0077fb63da010sm971442ejr.114.2022.09.20.07.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:27:43 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpiolib: Fix missing array end sentinel in quirks array
Date:   Tue, 20 Sep 2022 16:27:18 +0200
Message-Id: <20220920142718.633062-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Without the sentinel, the loop never actually terminates if there
are no quirks, and wreaks havoc across the kernel resulting in a
juicy panic.

Fix this by adding a NULL at the end.

Fixes: a2b5e207cade ("gpiolib: rework quirk handling in of_find_gpio()")
Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 95be5f0d2623..1b60cd04883f 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -498,6 +498,7 @@ static const of_find_gpio_quirk of_find_gpio_quirks[] = {
 	of_find_regulator_gpio,
 	of_find_arizona_gpio,
 	of_find_usb_gpio,
+	NULL,
 };
 
 struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
-- 
2.37.3

