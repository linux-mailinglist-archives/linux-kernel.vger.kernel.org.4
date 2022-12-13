Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E4D64B2F8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbiLMKGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbiLMKGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:06:34 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C601A811
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:06:33 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id s25so2804375lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jGJw/EOjMqDnh3BfLdeIG768fIWRdNcK55satWiXQuI=;
        b=AcxQR6AhJwEOauuVa2V+6jTIqKsFKkAaRHSz0pU+596zCl+8B7ccxjtqQ4k4Oe2rFL
         kE2I+Hp8z56W8lEiQvihibBErJDPSWsuH8gD53mDZULY4iSfRUE/pEUuUiIcShKxpvft
         yB/0SzgCZlooZGgSYRJwrXaJaXOh/9V7QECx8C2vOin2BQWG4SZFz28C25MhPvsQhP2n
         +mnmjLneM1HKC8OF/kEs3JZUW6746xP/91XOWTjAzVEbEcvlTSys/Vp5meASLwewjZm0
         SLsPYkvfnywicqCtxa6Ve7xK0oRbyfbTkt665Vchg7BCOyX4FdkL+petQYnrwaFA6ihX
         tC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGJw/EOjMqDnh3BfLdeIG768fIWRdNcK55satWiXQuI=;
        b=P6Hw53PRUMF+hTMKzRVGeQHmoKn1oePbYTCJbOwD2qA18LacCWwttw3XaOm+OmyJ56
         xLoexy+XQn09gYPCB87kKYFqxtm6MMYgOF/RnRhfLNZ9bBi+FIfyvgmprahGH0W1M3uF
         2XuaxLfAa3+C92IDHrkFDDxM/NcBhnOjVoCeswi9r3FpDpshLV3FPtTy4JNl2bT/7q1Z
         o5Y71EkjbUI04fC0XjqaNMpbBldvAy1ZUjlJV3ANciyptZNaqZR34Gwgc/jQShsjVnjK
         c5zcsqv7pOokABm8aJ0wGVuienK3MzOXIMo625HMNXLVfNBMgJf6/H5ZUQav1uQiSZV5
         k94w==
X-Gm-Message-State: ANoB5pmURNivfnNBF+Z76IPuRiR0AYLstX9acvBY4F1vuXIFDYL8BvLC
        TYWCkRlilmBy3HT9bME566t2Yw==
X-Google-Smtp-Source: AA0mqf74gsmhPLr5eD9lFE5n6EczP1cTlFkFgSWvDjeZOYyCmJx+cwI4H589ziNCZZ1JeRfYUtqxSw==
X-Received: by 2002:a05:651c:88c:b0:26f:db35:7e36 with SMTP id d12-20020a05651c088c00b0026fdb357e36mr4618263ljq.5.1670925991722;
        Tue, 13 Dec 2022 02:06:31 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id g14-20020a2eb5ce000000b00279ece03c45sm198627ljn.64.2022.12.13.02.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 02:06:31 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: hwmon: ntc-thermistor: drop Naveen Krishna Chatradhi from maintainers
Date:   Tue, 13 Dec 2022 11:06:26 +0100
Message-Id: <20221213100626.36150-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emails to Naveen Krishna Chatradhi bounce ("550 5.1.1 Recipient address
rejected: User unknown").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml b/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
index def693a60f55..3d0146e20d3e 100644
--- a/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
@@ -6,7 +6,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: NTC thermistor temperature sensors
 
 maintainers:
-  - Naveen Krishna Chatradhi <ch.naveen@samsung.com>
   - Linus Walleij <linus.walleij@linaro.org>
 
 description: |
-- 
2.34.1

