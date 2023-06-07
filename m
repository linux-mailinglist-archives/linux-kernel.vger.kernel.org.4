Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C1272543F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbjFGGb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjFGGbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:31:52 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291001BC0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 23:31:47 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f6dfc4e01fso69694715e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 23:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1686119505; x=1688711505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jBqOeBntw2+ThpWf4KE8BMuMRq2HYj3RR0u0oHiddc=;
        b=g2j6/JCVxK3TnZWkCdaosIWVIMAC/i6nhFtyu+Re5bfo/RS+chFBZPxNyozCfc90my
         23Oir7AD/urej/TP3IhFf5y8O5uP5ydLyWw1O9546HsHgPevZM/lEEMGM6pOckKnQ070
         c9O9Krxv0kQzUEMbJow7q/8nGkkAEmplFUkco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686119505; x=1688711505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jBqOeBntw2+ThpWf4KE8BMuMRq2HYj3RR0u0oHiddc=;
        b=E6vbx7gcpX1q1TgILz+kLjWQT9ZfCP5q7h/3Owxby78WrccZ0H3SK26PrMQaDJTIbQ
         UY/l2ahiaSoXcaPxTNbXpT9lMOXcQmcYQcR8eW2Nxby8KQwDV0waI82oBC0Z4GgrFDlD
         NtiIFcgMH0uAbpH3RuL4OM3w7xBc+iFUqgcSzc0BT2no+Jyb5AO/ppQE2/j556xvIZKY
         sbX4VJo+o0O8FjAFjx4/Dlx2freB2RMbir8Gje/UD4gHNl0Y2v2yYI9az/9i+3njc1HZ
         NJOh6ejBQH7voH/goAFyd0lI9vOOr7yibnShsq08KjyBdP0IHtOb0k8X6pnIJswh30lH
         ocDw==
X-Gm-Message-State: AC+VfDyrNyuuZqIBKBa21NuIHxjzdOEMSYL2I5Zw//iYeo+B35K8wOnd
        5QdH4vsqE4rSO9alNqH0zXtutRrUQSNljjNj48yxRA==
X-Google-Smtp-Source: ACHHUZ7swwk8nHZHRKO2QFZgoHwZJa+Z94Ki4ZMTiNvDjHj307W1KcYe3A0JolZaW1dRw+WElacJZQ==
X-Received: by 2002:a05:600c:2158:b0:3f7:2e57:d3af with SMTP id v24-20020a05600c215800b003f72e57d3afmr5795147wml.11.1686119505366;
        Tue, 06 Jun 2023 23:31:45 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([37.159.114.163])
        by smtp.gmail.com with ESMTPSA id m6-20020adff386000000b0030630120e56sm14385127wro.57.2023.06.06.23.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 23:31:44 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        michael@amarulasolutions.com,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [RESEND PATCH v2 1/6] ARM: dts: stm32: add ltdc support on stm32f746 MCU
Date:   Wed,  7 Jun 2023 08:31:34 +0200
Message-Id: <20230607063139.621351-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230607063139.621351-1-dario.binacchi@amarulasolutions.com>
References: <20230607063139.621351-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LTDC (Lcd-tft Display Controller) support.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 arch/arm/boot/dts/stm32f746.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index dc868e6da40e..9c4ba0b7f239 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -507,6 +507,16 @@ pwm {
 			};
 		};
 
+		ltdc: display-controller@40016800 {
+			compatible = "st,stm32-ltdc";
+			reg = <0x40016800 0x200>;
+			interrupts = <88>, <89>;
+			resets = <&rcc STM32F7_APB2_RESET(LTDC)>;
+			clocks = <&rcc 1 CLK_LCD>;
+			clock-names = "lcd";
+			status = "disabled";
+		};
+
 		pwrcfg: power-config@40007000 {
 			compatible = "st,stm32-power-config", "syscon";
 			reg = <0x40007000 0x400>;
-- 
2.32.0

