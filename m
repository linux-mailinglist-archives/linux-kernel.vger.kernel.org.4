Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93A76E30CD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjDOKos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjDOKoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:44:11 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643A0A5E1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:34 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94f0dd117dcso34985166b.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681555412; x=1684147412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GpG6BrvNSByzEWolZqrrfdu9R1OUjer6DD5hZw47Yw=;
        b=SR8ucM9B6N4/Wvn8RZz18nK/iv9LqIsfQMhAigP33Ivuy1+kbRYO27mZnKqAw9y32Q
         AtP7SHwTbB1Ta86j0WTR90Vr5Sv4sRTCESymR2jgG6C0T68joTKZMiC6q5TmJOYPhei+
         9RN7yF2WD6pzC4WY+6xBu7fetubohElOypwB8YtBL5mSoNSHZTJGg3P88X89GyGSsmF9
         o5I1QUHoJPRXy9MT2CQO0/15Bs4YSxLucV2pTlosuR444CvBnflp89KFthAvBD0t9ebD
         0X5W4zvgfcyREyr2E8jXdWxHCcJTVZfI5WvBMTEQNupFKwwkUInT1jOV7ZJt71X5S/Ah
         bpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681555412; x=1684147412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GpG6BrvNSByzEWolZqrrfdu9R1OUjer6DD5hZw47Yw=;
        b=Z7rZTKmI4IKEc5ekM/8tH0K5DGmz242j5YKYVUY3XMLNMkgreuk2ifwB/u6SI5F0sw
         0xoGkLgzttySDGvhlMx1Lv9vo7d2TPIvX13xiZeS3aiUx3mpTqMGVQiBdOhyVJvcCNF5
         QWrtZfQ0Llzv1y48vUetZGyXv3UPuN0tGklCHpEb79/WyQnmNzLSBqR786wiQ7jytI8P
         4b89D8tHtMDINzapOEAZ0Z1N7XEcbk+Pt1TURzrwB4VtBVn9o5xhVpZ6BpfU8yVINDV2
         XHWgA2wjT6+qHZIoLEtfqbL+CSykd71E3kesyeAerxIapBSuCfm0CY2phLHJGDFCQNuY
         LSEA==
X-Gm-Message-State: AAQBX9dPaMJ0pfZv8Ccn7U4MeVYGoDgd1pgMWgAV2iYx9Sod9LCvMjLW
        guZS8KBdE3De2xot+34dTgo+yw==
X-Google-Smtp-Source: AKy350bNSPXliC1HMcFk7yScGBMVjoz+38R0GHGZie0X0VdcqMt5F+DiXUR3dOCZbJKlmXnJFmQmCw==
X-Received: by 2002:aa7:dd59:0:b0:4fc:9c79:86bc with SMTP id o25-20020aa7dd59000000b004fc9c7986bcmr9142694edw.42.1681555412732;
        Sat, 15 Apr 2023 03:43:32 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a3bf:4ed:6c53:2a36])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7d48a000000b004fd1ee3f723sm3157481edr.67.2023.04.15.03.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:43:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 15/15] w1: gpio: remove unnecessary ENOMEM messages
Date:   Sat, 15 Apr 2023 12:43:04 +0200
Message-Id: <20230415104304.104134-16-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
References: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Core already prints detailed reports on out of memory:

  WARNING: Possible unnecessary 'out of memory' message

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/w1/masters/w1-gpio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/w1/masters/w1-gpio.c b/drivers/w1/masters/w1-gpio.c
index d4632aace402..ac7ad63f8f8d 100644
--- a/drivers/w1/masters/w1-gpio.c
+++ b/drivers/w1/masters/w1-gpio.c
@@ -101,10 +101,8 @@ static int w1_gpio_probe(struct platform_device *pdev)
 
 	master = devm_kzalloc(dev, sizeof(struct w1_bus_master),
 			GFP_KERNEL);
-	if (!master) {
-		dev_err(dev, "Out of memory\n");
+	if (!master)
 		return -ENOMEM;
-	}
 
 	pdata->gpiod = devm_gpiod_get_index(dev, NULL, 0, gflags);
 	if (IS_ERR(pdata->gpiod)) {
-- 
2.34.1

