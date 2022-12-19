Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1586512D0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbiLSTWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbiLSTVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:21:47 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16331704B;
        Mon, 19 Dec 2022 11:20:23 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id 4so10007176plj.3;
        Mon, 19 Dec 2022 11:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VR46xdGbsg8mOM7/UFZLhsN0WuKq4eAgjSK/29pLVdw=;
        b=aTfRBT+OcrFsAJU2Tq4Bcah4rMnw9eeLl7CBo9nh7WLnaxsF67mHOprqd2fATuQudf
         mLY2RoXIDjaAT1Hcb8oDn4xSuO/w8d6trTe+82kbnJuTtrF9a3yal4ZpHiIN/vzcTmjz
         ENzw6qeq9SDxRssTuytMOnAHbulRhF3C24FYzO/YNXhCyRCNDEJk38FNQJeu4rR+ND+x
         Z4nNDriroEI1nbsFJ146UYHUU/5XgjZOYlPpFxLRDUdAguuEzy4mV5uH/af1XcGfVv2H
         oYgyi8sMm1bkl+8fOrjMlVljLMxZ2BmTXTZni/NwbfISXhgmtZBW3dYT6XjitND9LOGJ
         sxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VR46xdGbsg8mOM7/UFZLhsN0WuKq4eAgjSK/29pLVdw=;
        b=OJNl8ZPcpirIVbjx9KhovCSGcu9NWaP3jTGdbPDKpmeqBUwQspgAnGiwHHclTBX7uS
         tgL66zyPTiwiO0ZLUDX28NIQEVLhqk/oFCnUs+hw6lQXVN3iitdXiK7a7u67yUZ9i1Ex
         ePzOQV8t3MgvgPZuN5YRTA7vKGQ3b54zWz4W//YV9+kYEoFqpPpgCCB3TynUIj2JMD1I
         lLRK+xxu0yghwQJlw+5SWdSo+7l8/fkg4/IblSB7P67Qdb4jpsFGJ5GGnYiRunWaD5zb
         0o49cm0sau6xie/ZFZdK3dGD9W1M2CZUpZgsHtVm4o7OQ7wVTnBqBaZA6SNJkP8ySoBw
         QwXA==
X-Gm-Message-State: AFqh2kp2AWYAe7tAJW02VnhqRDOt9+W5xxVBq3KRP/iijrkw6GiqBknx
        JsBpcXGjbgmtXhysY5KGmLhEPpmOdUU=
X-Google-Smtp-Source: AMrXdXt9lF1+KsoIgLbpyfUFVSrwW0MHO+N6HPx2iUWtmmib3ZexnjW06+ojln4Y94KOklO1VRO3sw==
X-Received: by 2002:a05:6a21:6d93:b0:9d:efbe:2052 with SMTP id wl19-20020a056a216d9300b0009defbe2052mr16503711pzb.8.1671477620884;
        Mon, 19 Dec 2022 11:20:20 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:4c62:79e:b4cd:2cbb])
        by smtp.gmail.com with ESMTPSA id b6-20020a1709027e0600b001869f2120absm7488342plm.294.2022.12.19.11.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 11:20:20 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/5] gpiolib: of: remove of_gpio_count()
Date:   Mon, 19 Dec 2022 11:20:12 -0800
Message-Id: <20221219192016.1396950-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
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

There are no more users of of_gpio_count() in the mainline kernel,
remove it.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

After 6.2-rc1 there should be no more users of the APIs mentioned in
this series.

 include/linux/of_gpio.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index 6db627257a7b..39f16a960565 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -105,17 +105,6 @@ static inline int of_gpio_named_count(const struct device_node *np,
 	return of_count_phandle_with_args(np, propname, "#gpio-cells");
 }
 
-/**
- * of_gpio_count() - Count GPIOs for a device
- * @np:		device node to count GPIOs for
- *
- * Same as of_gpio_named_count, but hard coded to use the 'gpios' property
- */
-static inline int of_gpio_count(const struct device_node *np)
-{
-	return of_gpio_named_count(np, "gpios");
-}
-
 static inline int of_get_gpio_flags(const struct device_node *np, int index,
 		      enum of_gpio_flags *flags)
 {
-- 
2.39.0.314.g84b9a713c41-goog

