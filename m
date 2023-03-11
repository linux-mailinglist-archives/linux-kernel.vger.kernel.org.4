Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEDB6B5AEC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjCKLQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjCKLQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:16:03 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B5614210
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:15:00 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r15so3542558edq.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jkK+aVv8SUTMjymiJecRC6TXCtVH+76+bDm9GC9UQrk=;
        b=K7edE7tWndltwpFGVSxRBYG2F8nb06dGAnNa/42uRFz/61/lMloiZvbGZ48mMltNk+
         fYGp3Zjuy1mju0x6UEkRiTjYDzfLGp8KttaySEGSJR1WYvx2MXonW1nXreJ+rbnrCTvt
         1ax2FXLUzKafaWjDC5dX9oRP78UpLJyH23DOtLG9fSMYzsZBNh5b6i3ug51FTnZ4sUA7
         DtPtyJUpb21XDXRbrvwfHDY4HKex1EyshLTXoo4r+K2gzIWmt9qJJCcu6kIBssbYsIku
         VQ8p49pce63gC0BeKCQKgQ1u6JbvEpeof+UZ10IRKkMKLNxbFMZ0G4NaIpZAVhY/DZi0
         LR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkK+aVv8SUTMjymiJecRC6TXCtVH+76+bDm9GC9UQrk=;
        b=kIqv+517ghiTU4WWrPvbTGsDuDHWJPxYHOLbp7tZLc3sB41YknVX/5MBQpOMZCfJlq
         LEZii482N3Dsv91BGSwB5hVHbSvWNPrdjwqbXfAy7DuguYLlHCQ9rAv7DWNd+JCEVCbM
         xY62zLr8QYIL8fj/N+yUceGFdd6SjrfNn/tfyrY1MhyJN6gIuNxsCxMihK4yCaDPMKBy
         Wj4bTH4cBfBoq8so0mNO5kvnsO+HYvbAnFAqGSGQANk31+x4y2kHo9nOsH5ScBAHZYpB
         YDN375ATcHqqi17rRpbAHpdUTn1UnCasBWI2h4eJoz3U2z7OQtY3VrJG+4Wp4QpAIV31
         oSdw==
X-Gm-Message-State: AO0yUKVdKqPqv3+rTMg9zATnvpZrKfe1Sd8iJXDTU7YMGLD5PRZmOkD1
        fiGVoZLR9TXLXv9Bf5cwlMdfrA==
X-Google-Smtp-Source: AK7set82nKL+Nh95hV4nsmijhkjFpC13c42M0w/eHSyxRRHrP5cTuoDkRJpqlc/pYCR8F52ArGxLhg==
X-Received: by 2002:a17:907:6eab:b0:7c0:efb9:bc0e with SMTP id sh43-20020a1709076eab00b007c0efb9bc0emr36972296ejc.62.1678533267663;
        Sat, 11 Mar 2023 03:14:27 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id w15-20020a50c44f000000b004bf28bfc9absm1063041edf.11.2023.03.11.03.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:14:27 -0800 (PST)
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
Subject: [PATCH] irqchip: meson-gpio: mark OF related data as maybe unused
Date:   Sat, 11 Mar 2023 12:14:23 +0100
Message-Id: <20230311111423.251383-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/irqchip/irq-meson-gpio.c:153:34: error: ‘meson_irq_gpio_matches’ defined but not used [-Werror=unused-const-variable=]

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

