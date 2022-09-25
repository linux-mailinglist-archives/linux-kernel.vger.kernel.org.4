Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6909B5E9522
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbiIYRwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbiIYRwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:52:25 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C5B1F2F5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 10:52:24 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id nb11so9870323ejc.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 10:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=jfErmyZAWFClEhl0ayKENaiIcOOkglWFws7K0nbLI8s=;
        b=HnihT0YSNz6xIyoJu2aFjZSjBQ0FEbSxs59ATuv5Ra1/tL44+b8p5ztPFWXSqLXReZ
         NE8XVJ6hsvCY5AP8ZJEl5/kOeAnitpitF0bAh63bDRpabZAzfutAiyYKnt3d0ZVj0vAh
         jZO0QooNBqd11esq0FCm9sXbvEAuERve5hxcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jfErmyZAWFClEhl0ayKENaiIcOOkglWFws7K0nbLI8s=;
        b=ra0ZhWSFcKBypuzAYg/0g9sESvpeKMAkzCb5dTesbkyzOObxO2DPMbuc0HME/bK987
         vkM3z1XeppS78nxkmSzBibS7fcjTuXKyH+rhY51vLcoO5tHsak+l0/6cwfnYGX5so5Cq
         FmVXw9qlb66405RYfKQapTrthb+O7iGOfIDFJ2ah1GNOCKsXvLGnqMW8lzfFelsZDl9V
         jGkMObg+uFd/BEi8hGqqmKQfK0kJJ6KGh8u3GDV/FDG7cEIMa4McIPiG790Ge9wF4NJY
         70tEygD/MjPbLD1BURizdRWvfu+a3/vus7tKhZlxMuyq/pQb1FAiNtneZPKVo1lBDToX
         JKqQ==
X-Gm-Message-State: ACrzQf2pQHErCjvz5Wjl6gwaG7LHH50hnUs1WjOsEWIHImGnq9BLjMhm
        h84NzOfK+KNYx/P3CrIlvb/JS2Kb9FSKFw==
X-Google-Smtp-Source: AMsMyM5acRXX+ssw3njDDsVVdiOmCWOdz34aX9SwVevoL6aHYNwmlHMLUX4UDcyl1CRcECbsv/GM3w==
X-Received: by 2002:a17:907:2d09:b0:781:d793:f51e with SMTP id gs9-20020a1709072d0900b00781d793f51emr15050921ejc.628.1664128342518;
        Sun, 25 Sep 2022 10:52:22 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-232-92-192.retail.telecomitalia.it. [95.232.92.192])
        by smtp.gmail.com with ESMTPSA id f23-20020a056402161700b0045703d699b9sm3252594edv.78.2022.09.25.10.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 10:52:22 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [RFC PATCH v4 4/5] ARM: dts: stm32: add pin map for CAN controller on stm32f4
Date:   Sun, 25 Sep 2022 19:52:08 +0200
Message-Id: <20220925175209.1528960-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220925175209.1528960-1-dario.binacchi@amarulasolutions.com>
References: <20220925175209.1528960-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 500bcc302d42..8a4d51f97248 100644
--- a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
@@ -448,6 +448,36 @@ pins2 {
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

