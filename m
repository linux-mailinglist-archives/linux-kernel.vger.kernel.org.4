Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BBB6CB82E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjC1HeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjC1HeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:34:01 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2753C20
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:33:50 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y4so45878077edo.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1679988829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QV3iGa8KiUlr1LClhXl1D1BGw0maVF3hcUmABXx2qKM=;
        b=fInw/jj9PBtFRJxZSJU9mdDm8tBLrvz2djTwCMJCrmyHKb0pKW94UF4kdEPu6LAEUJ
         9GNtSNMWzDhBA7Cj8ZfWzJT0WLyRYME9zHcvyOiIQlDDe3s8IqQw80toZOXrIN/t9lyn
         XfHj88tV6ORsmV+l+2hfshDFuk48ix4B4eP2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679988829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QV3iGa8KiUlr1LClhXl1D1BGw0maVF3hcUmABXx2qKM=;
        b=AuVKTzR0zygT52wdDK+eGqCRT5jbf1oszEbCIqZm9Sk7GxT7vhu2gi9gor2MpAfXdL
         9EUQb4QpWjmETXGgao/FPX8jDmbbs1LNV0Ew87TYDf9gKnR8g/cBLu2PEeKyZVpCE5sj
         mAAeep0AOfJDnjI8T8IEJOBtgq4pQsBImNyMT65nk1pijqwmSIK0rAawJEj9Oy7qrhNK
         z9YKOlve6vw/Lkd5/n7QO652ejHRyZ7tOO+GybYe7N2re7G61Qnbc5tlB7/R+5kQDIlO
         1JGUAiwywwZaYOTuWysrefkYat2EASHoCYk471Cs//THWYBJxsQWUHdruPhiqyYYbbVv
         Ux+A==
X-Gm-Message-State: AAQBX9dgsyUZJI+jRZ4KNxsP2Q4KX0gwuhOCbz+2GPXNuOnP6iEoNwk+
        0sWEz9OkXs70ZTgLnIDcAWVdB1ssnW1eBQY2FKEyOQ==
X-Google-Smtp-Source: AKy350bPRa7yMhn4B3RnlA9oejY2elg4CBVWazqAGzvA671dK/BBGa7yIOWMOmYCz6kh3jroqWAtKQ==
X-Received: by 2002:aa7:db92:0:b0:4fd:2346:7225 with SMTP id u18-20020aa7db92000000b004fd23467225mr15202535edt.34.1679988829563;
        Tue, 28 Mar 2023 00:33:49 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-0-102-254.retail.telecomitalia.it. [87.0.102.254])
        by smtp.gmail.com with ESMTPSA id 15-20020a508e4f000000b004fa99a22c3bsm15478850edx.61.2023.03.28.00.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 00:33:49 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Rob Herring <robh@kernel.org>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v10 4/5] ARM: dts: stm32: add pin map for CAN controller on stm32f4
Date:   Tue, 28 Mar 2023 09:33:27 +0200
Message-Id: <20230328073328.3949796-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230328073328.3949796-1-dario.binacchi@amarulasolutions.com>
References: <20230328073328.3949796-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pin configurations for using CAN controller on stm32f469-disco
board. They are located on the Arduino compatible connector CN5 (CAN1)
and on the extension connector CN12 (CAN2).

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v3)

Changes in v3:
- Remove 'Dario Binacchi <dariobin@libero.it>' SOB.
- Remove a blank line.

Changes in v2:
- Remove a blank line.

 arch/arm/boot/dts/stm32f4-pinctrl.dtsi | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
index 4523c63475e4..3bb812d6399e 100644
--- a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
@@ -447,6 +447,36 @@ pins2 {
 					slew-rate = <2>;
 				};
 			};
+
+			can1_pins_a: can1-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 9, AF9)>; /* CAN1_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 8, AF9)>; /* CAN1_RX */
+					bias-pull-up;
+				};
+			};
+
+			can2_pins_a: can2-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 13, AF9)>; /* CAN2_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 5, AF9)>; /* CAN2_RX */
+					bias-pull-up;
+				};
+			};
+
+			can2_pins_b: can2-1 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 13, AF9)>; /* CAN2_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 12, AF9)>; /* CAN2_RX */
+					bias-pull-up;
+				};
+			};
 		};
 	};
 };
-- 
2.32.0

