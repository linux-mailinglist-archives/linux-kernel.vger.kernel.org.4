Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EDD700D40
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbjELQpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjELQpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:45:12 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B232D43
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:45:10 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bc070c557so19067565a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683909908; x=1686501908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pV4nPrNRb/e5WafM80+WTgCZOIxglttUA6kfvAksdOY=;
        b=rAtTDf0k3Ml8UgtR+tzFbgrEU1Frtzb2Uh5yFzcVNBb/uVQ92xlL8r07QQbagGU+kP
         whBZiC8/vuVd2sGvpxo77CUzrOp9nbqKwHRZQcvWPEKX1aM0R9hgRgf3ELyQTQkuN5dP
         O5gbnRRdv/mRrejSdKOYqv/d6BIBTelmIJO52Lm9jo5ZLQk7xybMVQ2zwp2gIDMJyGAA
         KLsVml0Pcj8oNqd4NWygtaU55VxCFHBbqUgYSbzmiE1agvIu3xtHBoxF/Z78JDhytKH0
         asCP/EEiqfZ8bAeybd7FTJJpn/ITH3m21OSDlq32A2m0ADSQrgOwxRsUlRhBRUbwhhMb
         YXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683909908; x=1686501908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pV4nPrNRb/e5WafM80+WTgCZOIxglttUA6kfvAksdOY=;
        b=i9kOZuanHpLKSq8mKfSLvES8C5nvf7uaWBZjQzXmpMRvT+Y9Bcx5sB+R/av0QGyEBa
         1IIAjLXBnn148d8mPvf42rhDx1OtTUaZXMPWUxLSjUVkWuCOSPoTwDswf9JpHho9vBvB
         jhSDZMoBu2A7Zyy47hItJEwoBy6jfpayWjNsKVB+2pUa4TIxT8G/CaHntzRLpVDwbiOp
         s/AZKCn9ZeqpkWZ7EDpY5X9E2v4q7G1ep0dbutglAPxZlVJFNfs5JocQffXqAgYIJlx2
         uK4DpBWB36J8A7Y+8cmXOyMc1WgzsWUwYlkCQR3OjoK3xCRFOJo2FA+98KQ0MxB0qITs
         bODQ==
X-Gm-Message-State: AC+VfDyBm+JsKTA0h8P9C1b8WEv4fCz2qkoK5gOm1rWS4ykcLHVSsBio
        YRPCR8ZHtCGHK+lAKQYtnS8MNQ==
X-Google-Smtp-Source: ACHHUZ481Ipi6sYbr6dIvqXMErSYGSJqL1hlxcYBia7v3v1DAdaoZuNPdl6tTgMMuObGicpdgqysTA==
X-Received: by 2002:aa7:ca58:0:b0:50b:c1d6:8d60 with SMTP id j24-20020aa7ca58000000b0050bc1d68d60mr21692235edt.21.1683909908410;
        Fri, 12 May 2023 09:45:08 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id q17-20020a056402033100b00509dfb39b52sm4218311edw.37.2023.05.12.09.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 09:45:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH] irqchip: meson-gpio: mark OF related data as maybe unused
Date:   Fri, 12 May 2023 18:45:06 +0200
Message-Id: <20230512164506.212267-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/irqchip/irq-meson-gpio.c:153:34: error: ‘meson_irq_gpio_matches’ defined but not used [-Werror=unused-const-variable=]

Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/irqchip/irq-meson-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 2aaa9aad3e87..7da18ef95211 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -150,7 +150,7 @@ static const struct meson_gpio_irq_params s4_params = {
 	INIT_MESON_S4_COMMON_DATA(82)
 };
 
-static const struct of_device_id meson_irq_gpio_matches[] = {
+static const struct of_device_id meson_irq_gpio_matches[] __maybe_unused = {
 	{ .compatible = "amlogic,meson8-gpio-intc", .data = &meson8_params },
 	{ .compatible = "amlogic,meson8b-gpio-intc", .data = &meson8b_params },
 	{ .compatible = "amlogic,meson-gxbb-gpio-intc", .data = &gxbb_params },
-- 
2.34.1

