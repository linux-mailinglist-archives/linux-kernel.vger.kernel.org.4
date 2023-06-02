Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE96971FEEC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbjFBKVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbjFBKVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:21:38 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8BA194
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:21:36 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2afb2874e83so27138221fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 03:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1685701294; x=1688293294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jBqOeBntw2+ThpWf4KE8BMuMRq2HYj3RR0u0oHiddc=;
        b=kDwCkNaE67Q0xUnrv6y3DR8jLIIS8R9c9QKIj9k4/HDG9shGyNJc2foYrF04sUyYzi
         wFf2hmqJMxPT9qwyw3s7IFZI9Z/9Su/GFyHb06gOC0kKp63hsWwD4ADpHRkRWIGPcUng
         3IoJjsZ7X1XaHRY7eJBjBPRJRcW4sDECsPsC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701294; x=1688293294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jBqOeBntw2+ThpWf4KE8BMuMRq2HYj3RR0u0oHiddc=;
        b=jfGNcC3h/Fjw1AVv5QZNBIr2FaVLDfBFF4IRfXHdqO4oms1x0VX491jqo22TtoIdG1
         NSv1xdpQpyJEcJo7nqBq6AsoHZN5ABDJNfaeYCOkk0E/bqYa3mXiwrhI/JB5gIdqk5O8
         QCvgJQaOqoLOW/gNfxBSCZLESjZa1Uo1JDebBJm2oHX2pkyk7fXGIuycDGwF9rFLni/r
         IrcjhQJoUJSs6dVFQ7ZjPbXJKAMigzT+lCR8o2bl+aM+hQ1BuRg+hLQ+6eW6DcpjC4ml
         8EkSZuK+cCk2jbexeGvN7wXv/Tqj+FiJam4ZxRS9EWPfUlzxKRn0KbGhcolu7TG7w8FI
         XB2g==
X-Gm-Message-State: AC+VfDyOcsTpZHGPXkO2MnMoIvZwn+ABKsCC/bEqdGV5TVPkLzwOns0u
        QUNVaze8PX9hWVZGAg0mE4iB6pUaNv+7afWcNgAOuw==
X-Google-Smtp-Source: ACHHUZ7qNYOTd62VO/6IL66B8KwBoBWo35rkkPU2puqC/C52R5d2ygI24jDexCF3WiO0CEv1gBe8iw==
X-Received: by 2002:a2e:3a03:0:b0:2b1:abdb:8783 with SMTP id h3-20020a2e3a03000000b002b1abdb8783mr1002587lja.41.1685701294571;
        Fri, 02 Jun 2023 03:21:34 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-248-31-20.retail.telecomitalia.it. [95.248.31.20])
        by smtp.gmail.com with ESMTPSA id x24-20020aa7d398000000b0051499320435sm528887edq.14.2023.06.02.03.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:21:34 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 1/6] ARM: dts: stm32: add ltdc support on stm32f746 MCU
Date:   Fri,  2 Jun 2023 12:21:17 +0200
Message-Id: <20230602102123.3345587-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230602102123.3345587-1-dario.binacchi@amarulasolutions.com>
References: <20230602102123.3345587-1-dario.binacchi@amarulasolutions.com>
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

