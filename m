Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC436CAFC4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjC0URZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjC0URP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:17:15 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EAF4481
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:17:02 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p17so4423898ioj.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1679948221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QV3iGa8KiUlr1LClhXl1D1BGw0maVF3hcUmABXx2qKM=;
        b=frMVCmupB0FHFKpyJU1n8GWHF7S/mmcD8SbntDNhdLvpLXdVvkU+eukIa0ls1L0X0W
         wLYN8A1kbmvq1MQP2phYVMnEd914VROkeQ0Hc1bSE7gC1cF6LCcKK3ISj2xUz+hVgjyC
         cRbX1fk1iNd5tidmkIQSv3bsqGIS451XJr64A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679948221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QV3iGa8KiUlr1LClhXl1D1BGw0maVF3hcUmABXx2qKM=;
        b=D0uqK8NFqDLJrRBRx8/QkMldmLg+Z3fspcxkji8L7dRlKFzPEGn2/Ts8I/ONj5Cef0
         n5lKarWl1SCJEZ1hupGAOtSAdSPKqWzAQT9XEzQKmxSjsnp3mZ5wFzwLV4uQYHTBE12y
         kIAt1OeZAKkC4FohWGkwGdvBPDjLatL80OqdCXjvXScNO1SmAnWWB5WwAAcEZPQpieWU
         9LpwCxZO1zG8/unDDA3xHcJQEpsE9SfrPmcVwp6LY64AomwU84aMdW8BS/AuAytqyz80
         1SrytzUfzZP5AkNFWAkC551b7qACEkmpS5ylOsokLmRfL9SLjLmIp/GmBN/oP/hIxpuV
         3RYg==
X-Gm-Message-State: AAQBX9dfwvf73YUqdpJBnai5IUtWEkkExP6tfLYYK25R5j7frUXYEwbR
        gdrPmFA1nFoL4jz540vidQgbJyG5HS+CdFcc7S+g3w==
X-Google-Smtp-Source: AKy350YJ8bkQ9g33O6WbkXo24i23Qsh/9clE8FLxMP+MDsv7aHOF/KaKoAsvEO/Fpuide3NpVJCCCA==
X-Received: by 2002:a6b:c90d:0:b0:75c:90f1:4622 with SMTP id z13-20020a6bc90d000000b0075c90f14622mr195013iof.0.1679948220980;
        Mon, 27 Mar 2023 13:17:00 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (host-87-0-102-254.retail.telecomitalia.it. [87.0.102.254])
        by smtp.gmail.com with ESMTPSA id u26-20020a02b1da000000b003a958f51423sm5594759jah.167.2023.03.27.13.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:17:00 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        michael@amarulasolutions.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v9 4/5] ARM: dts: stm32: add pin map for CAN controller on stm32f4
Date:   Mon, 27 Mar 2023 22:16:29 +0200
Message-Id: <20230327201630.3874028-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230327201630.3874028-1-dario.binacchi@amarulasolutions.com>
References: <20230327201630.3874028-1-dario.binacchi@amarulasolutions.com>
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

