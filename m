Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6312768E28F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 22:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjBGVAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 16:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjBGVAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 16:00:39 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9FE196B5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 13:00:32 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bg26so11963346wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 13:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYbbEIH9Rlm/Ki1I90g8VqYzod78gEhCObYyTC8X/wU=;
        b=ezzVb+JWPbuS7p65A1FWBKs4yMzcSXfYVURpTBD4b742nEFZ9TpFtiELcnx62/0hBe
         OyBKHGRDyAS8YKnzK9z6O1+zvRjtKTXivrNabYqMMIHfdjZ+JObgwPOi7s6oLpawQpOr
         A4cpb2of2xr1WWHl8HTRVGs56tt5wYFOBL1qmSGJ3qxILGnWrWTwWz83CGWG+Fe59rWm
         dnN2Visr2j1Cqv+l3f9U1ZGQQQSKpA0vhfbxUUZ5Fcq+WjMFh9DB/Dv7xx8HzTeIYnem
         EB8RKP1l09zFz9bQFFV5LOU5/W/KsUBSLzWPgE9TFoWzBHt8kRk6VXmDVIMsHrwm7Tuy
         l8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYbbEIH9Rlm/Ki1I90g8VqYzod78gEhCObYyTC8X/wU=;
        b=IO6ZcaZdIEOfXQ9Al0XxFf65DVI//0Q+L5h58cNAPIfDaxhkomabaBqgv6X1iDYgAW
         ixD9VEmcxJqjGmnH2SSdEFQJEyJcBC+uKnsQ5eD6KlLygeU0V7NW7PkK8L7ZOrh+Y/Zo
         h92hAGKA9maKnFnFrKF7vGeLtQzqR6kFJt1+ueZWeqn6dogOH2Oqghw/+LmdE/MzhDRo
         /3xXaSLp0DHaV4XbNFITcT90/kR4xjGI8ZW0POQ6FGvbb2nyxJyO91lWEVEEWQIh58Wh
         8Ier3BxgoHm61SGZI/+sLzV/rVJ/JrtdIQnfFq3sw/a0Nl0pklhtuuBlSOGBduCoEAXh
         hC6g==
X-Gm-Message-State: AO0yUKWLbAyJhOFbnxNfwjWW/WmWuWQyJYHSYLKSc4WSKHllzlYFZL0n
        A59+mwYrqS9HNlUxi7k/OPheFA==
X-Google-Smtp-Source: AK7set/vufVbIPG/l2DZW1afRd0cS/O0W1oh/XbL63hASlY5UEt2CRZoWnA7rKEcpj85gpibLzr2tw==
X-Received: by 2002:a05:600c:35d0:b0:3d5:365b:773e with SMTP id r16-20020a05600c35d000b003d5365b773emr4535057wmq.39.1675803630748;
        Tue, 07 Feb 2023 13:00:30 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c44c900b003dc4fd6e624sm8041631wmo.19.2023.02.07.13.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 13:00:30 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/7] ARM: dts: exynos: drop default status from I2C10 on Arndale
Date:   Tue,  7 Feb 2023 22:00:18 +0100
Message-Id: <20230207210020.677007-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207210020.677007-1-krzysztof.kozlowski@linaro.org>
References: <20230207210020.677007-1-krzysztof.kozlowski@linaro.org>
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

status=okay is by default for new nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos5250-arndale.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 71c0e87d3a1d..e995cfee03f3 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -623,7 +623,6 @@ &soc {
 	i2c_ddc: i2c-10 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c2_gpio_bus>;
-		status = "okay";
 		compatible = "i2c-gpio";
 		sda-gpios = <&gpa0 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 		scl-gpios = <&gpa0 7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-- 
2.34.1

