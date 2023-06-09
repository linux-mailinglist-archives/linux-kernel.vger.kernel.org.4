Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1D7728FDE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237750AbjFIGVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237629AbjFIGVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:21:08 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0750F30D8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 23:21:07 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b203360d93so14954761fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 23:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1686291665; x=1688883665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+cZsaL4nqe4EkBv4C/rg83ziLwGA0zL1CPKVC/ZIpY=;
        b=Xh2ITA299ks+uNMVxghk9PCc8hpBoastqUA/GfrKAuG+XVfjPF986qVhj790OK7lBh
         tl5ddsLugXEw7re+iPYjfrm/tJchi43Fhm9ynnp726s9iKkhYz/FN6zt30vZGgn/gG3X
         LLSvsr/iSXp/NR0xGCf4l+QJJJ2WaZDEGTpBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686291665; x=1688883665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+cZsaL4nqe4EkBv4C/rg83ziLwGA0zL1CPKVC/ZIpY=;
        b=K3TWxMSJb4T+6QRDKFDQ6IVBZnAt1q8vMZgZqDp/zu7uWS93tWUTXIuC2Nwfz26u7x
         R2BZvjApSK0GIY1mOum81rSpTZ+NZaQCVrNKvwTas0FgDmlQnJTa31hAq5w8S3b9BvoI
         xL2UB2Ay5jI3jHlGAOxCg7R0ElK70LTzNvh8sunqnAXIkwjrxKhTMCxoPRxcJKZdaEOJ
         G4OPrIcTOkUmMdpMMifMcm/3s4pPa1v1aIG/jou8w106zltKWurcnKStCZ3X0H/1e7+o
         wAAkJGNsX5q6UJAK1n48oBVGdj8HcOFIIPyYEHmPJmcdpc6DeFymFg/dMSRRlWcghnI4
         ygtg==
X-Gm-Message-State: AC+VfDyYhdhQKSrUYUS+NaycpdOtLwKYERijJkDDMul+yJ16C7NZrI+i
        LVzPhBogqk9/gwn+50y9P75JRFQnq81N8FOJhgkD7Q==
X-Google-Smtp-Source: ACHHUZ5iaHPCBFL/CFyznNK8XH0UrXLqvcS9ooJKxpt4ywmkPY9MoIJv5N/4NU1OXT725VMpCpBLPA==
X-Received: by 2002:a2e:990c:0:b0:2b1:b9b9:20d4 with SMTP id v12-20020a2e990c000000b002b1b9b920d4mr362059lji.5.1686291664880;
        Thu, 08 Jun 2023 23:21:04 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-248-31-20.retail.telecomitalia.it. [95.248.31.20])
        by smtp.gmail.com with ESMTPSA id m7-20020aa7d347000000b005149461b1e0sm1380058edr.25.2023.06.08.23.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 23:21:04 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 2/4] ARM: dts: stm32: add pin map for LTDC on stm32f7
Date:   Fri,  9 Jun 2023 08:20:48 +0200
Message-Id: <20230609062050.2107143-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230609062050.2107143-1-dario.binacchi@amarulasolutions.com>
References: <20230609062050.2107143-1-dario.binacchi@amarulasolutions.com>
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

Add pin configurations for using LTDC (LCD-tft Display Controller) on
stm32f746-disco board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v3:
- rename ltdc-pins-a-0 to ltdc-0.

 arch/arm/boot/dts/stm32f7-pinctrl.dtsi | 35 ++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
index 9f65403295ca..36dad40dd0c7 100644
--- a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
@@ -365,6 +365,41 @@ pins2 {
 					bias-pull-up;
 				};
 			};
+
+
+			ltdc_pins_a: ltdc-0 {
+				pins {
+					pinmux = <STM32_PINMUX('E', 4, AF14)>, /* LCD_B0 */
+						 <STM32_PINMUX('G',12, AF9)>,  /* LCD_B4 */
+						 <STM32_PINMUX('I', 9, AF14)>, /* LCD_VSYNC */
+						 <STM32_PINMUX('I',10, AF14)>, /* LCD_HSYNC */
+						 <STM32_PINMUX('I',14, AF14)>, /* LCD_CLK */
+						 <STM32_PINMUX('I',15, AF14)>, /* LCD_R0 */
+						 <STM32_PINMUX('J', 0, AF14)>, /* LCD_R1 */
+						 <STM32_PINMUX('J', 1, AF14)>, /* LCD_R2 */
+						 <STM32_PINMUX('J', 2, AF14)>, /* LCD_R3 */
+						 <STM32_PINMUX('J', 3, AF14)>, /* LCD_R4 */
+						 <STM32_PINMUX('J', 4, AF14)>, /* LCD_R5 */
+						 <STM32_PINMUX('J', 5, AF14)>, /* LCD_R6 */
+						 <STM32_PINMUX('J', 6, AF14)>, /* LCD_R7 */
+						 <STM32_PINMUX('J', 7, AF14)>, /* LCD_G0 */
+						 <STM32_PINMUX('J', 8, AF14)>, /* LCD_G1 */
+						 <STM32_PINMUX('J', 9, AF14)>, /* LCD_G2 */
+						 <STM32_PINMUX('J',10, AF14)>, /* LCD_G3 */
+						 <STM32_PINMUX('J',11, AF14)>, /* LCD_G4 */
+						 <STM32_PINMUX('J',13, AF14)>, /* LCD_B1 */
+						 <STM32_PINMUX('J',14, AF14)>, /* LCD_B2 */
+						 <STM32_PINMUX('J',15, AF14)>, /* LCD_B3 */
+						 <STM32_PINMUX('K', 0, AF14)>, /* LCD_G5 */
+						 <STM32_PINMUX('K', 1, AF14)>, /* LCD_G6 */
+						 <STM32_PINMUX('K', 2, AF14)>, /* LCD_G7 */
+						 <STM32_PINMUX('K', 4, AF14)>, /* LCD_B5 */
+						 <STM32_PINMUX('K', 5, AF14)>, /* LCD_B6 */
+						 <STM32_PINMUX('K', 6, AF14)>, /* LCD_B7 */
+						 <STM32_PINMUX('K', 7, AF14)>; /* LCD_DE */
+					slew-rate = <2>;
+				};
+			};
 		};
 	};
 };
-- 
2.32.0

