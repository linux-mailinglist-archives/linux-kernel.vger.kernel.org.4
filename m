Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80BE663B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjAJIdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjAJIc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:32:59 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DD94914B;
        Tue, 10 Jan 2023 00:32:58 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id e10so7708009pgc.9;
        Tue, 10 Jan 2023 00:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9fhCnX2gnr8/sZl8KpSTepVKdqMVPv6vqBDtH8CyPJo=;
        b=lL1hZzqMfPOOwjovjKw5yOvbON6QEFggCGPT7Yf8MIcqf3lLUvXnU55iL+kBhnGZj3
         37XdmTEFW/JPRDYsxrS16npSC3Ae2YCj4XIb94MfJlE2e9p7dYaWpvQCdi/eEDUbRSZ7
         rCtgiYXGGduBEIfylO4nHQYeFIkfvU6/3bF1HGy3IzusmS8UXP9b78UwiMWPtQtfawKk
         Me816T5hVLj/TzKdh6p1AcKhf3/KyOSJW9gV7EqLpR/LF6HoCGs7JAINeYF44BabL/Ie
         z33lec9oUx5K/Zbs3kjg/mhO6mK/Lw91xZ09YqPxTritRIdsicug8+vldtljO4gE4WwI
         mppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9fhCnX2gnr8/sZl8KpSTepVKdqMVPv6vqBDtH8CyPJo=;
        b=A+sA30sK9PqY6zhyouKPn4kTFczc19vmf54U+8aVtgdYcPVv4bqo4QH37x8j1AjMPH
         orD66A2lUk/TjidD4snLEKIsSyCWOZukjqHqcl6cjbWVavJjzw9iwFugTKTZu1CZOoe0
         LV/wXktKEWMS5daRsE1rZH2sy+hWoTi47gj9gcY/sDc3crabCiWtKrRbpDyOQbJx72Gp
         9uULTju8lY5d63R13mZsC2yIdpLQIbDxQ4pb4u+4Gf/tM9ZHL8opVNvvUTOsHkvZhw2I
         Kdj0ViGpi9Qcj8IySCf+T5OxLwDJ1TLpcVj+ZX/Z2dKbvefRqpF5v3iU/sntmOOCmDd6
         yjCA==
X-Gm-Message-State: AFqh2kr8wiovU5tGGdc/5YEkwCh8zP7w1uXzSu2q0TivJfsbdLfGJrmY
        TOpayx95wJVLb0gY6wDDf7Y=
X-Google-Smtp-Source: AMrXdXt+1+KsiOyg8eXk6O2KdeaAVCpXoraY7fOygQlCKeLI78oms2NSLFtyNAa3d1lGyooUSCeS4A==
X-Received: by 2002:a62:5f03:0:b0:58a:fdc8:92bf with SMTP id t3-20020a625f03000000b0058afdc892bfmr259967pfb.2.1673339578027;
        Tue, 10 Jan 2023 00:32:58 -0800 (PST)
Received: from localhost.localdomain ([180.217.149.10])
        by smtp.gmail.com with ESMTPSA id z3-20020a626503000000b005871b73e27dsm5064950pfb.33.2023.01.10.00.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 00:32:57 -0800 (PST)
From:   Jim Liu <jim.t90615@gmail.com>
To:     JJLIU0@nuvoton.com, KWLIU@nuvoton.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Jim Liu <jim.t90615@gmail.com>
Subject: [PATCH v4 2/3] arm: dts: nuvoton: npcm: Add sgpio feature
Date:   Tue, 10 Jan 2023 16:32:37 +0800
Message-Id: <20230110083238.19230-3-jim.t90615@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230110083238.19230-1-jim.t90615@gmail.com>
References: <20230110083238.19230-1-jim.t90615@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SGPIO controller to the NPCM7xx and NPCM8xx devicetree

Signed-off-by: Jim Liu <jim.t90615@gmail.com>
---
Changes for v4:
   - add npcm8xx gpio node
Changes for v3:
   - modify node name
   - modify in/out property name
Changes for v2:
   - modify dts node
---
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 30 +++++++++++++++++++
 .../dts/nuvoton/nuvoton-common-npcm8xx.dtsi   | 30 +++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
index c7b5ef15b716..7f53774a01ec 100644
--- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
@@ -330,6 +330,36 @@
 				status = "disabled";
 			};
 
+			gpio8: gpio@101000 {
+				compatible = "nuvoton,npcm750-sgpio";
+				reg = <0x101000 0x200>;
+				clocks = <&clk NPCM7XX_CLK_APB3>;
+				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+				bus-frequency = <8000000>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&iox1_pins>;
+				nuvoton,input-ngpios = <64>;
+				nuvoton,output-ngpios = <64>;
+				status = "disabled";
+			};
+
+			gpio9: gpio@102000 {
+				compatible = "nuvoton,npcm750-sgpio";
+				reg = <0x102000 0x200>;
+				clocks = <&clk NPCM7XX_CLK_APB3>;
+				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+				bus-frequency = <8000000>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&iox2_pins>;
+				nuvoton,input-ngpios = <64>;
+				nuvoton,output-ngpios = <64>;
+				status = "disabled";
+			};
+
 			pwm_fan: pwm-fan-controller@103000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
index aa7aac8c3774..27462894b90a 100644
--- a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
@@ -165,6 +165,36 @@
 				clocks = <&clk NPCM8XX_CLK_REFCLK>;
 				syscon = <&gcr>;
 			};
+
+			gpio8: gpio@101000 {
+				compatible = "nuvoton,npcm845-sgpio";
+				reg = <0x101000 0x200>;
+				clocks = <&clk NPCM8XX_CLK_APB3>;
+				bus-frequency = <8000000>;
+				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&iox1_pins>;
+				nuvoton,input-ngpios = <64>;
+				nuvoton,output-ngpios = <64>;
+				status = "disabled";
+			};
+
+			gpio9: gpio@102000 {
+				compatible = "nuvoton,npcm845-sgpio";
+				reg = <0x102000 0x200>;
+				clocks = <&clk NPCM8XX_CLK_APB3>;
+				bus-frequency = <8000000>;
+				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&iox2_pins>;
+				nuvoton,input-ngpios = <64>;
+				nuvoton,output-ngpios = <64>;
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
2.17.1

