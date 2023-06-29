Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906C5742269
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjF2Ima (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 04:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjF2IlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:41:13 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48BE3C3B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 01:37:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3094910b150so472779f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 01:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1688027857; x=1690619857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jBqOeBntw2+ThpWf4KE8BMuMRq2HYj3RR0u0oHiddc=;
        b=P2631v8dfVuMAiCd79tBEx+XlHMPVMM1s0utHNOk/OYNwwPZaMZEJixyVemwzZqFjF
         t4dHA97W45eek30hweiCwgGvewOewA8URInIRt9tABHEHIl/mM5LxhhdVucJG4bOBRqB
         T5XTqEN5BrRD/8nop9mB18fbbs7Ung9qxkWn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688027857; x=1690619857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jBqOeBntw2+ThpWf4KE8BMuMRq2HYj3RR0u0oHiddc=;
        b=KnoqwgPGrbCTVzKcGtrDw6JS1bkQlfOhpb248RU7RhYwd9dXQpYF2nwgxRtmitVPJc
         v9USp7fEL/zmo8WJQYDDtrpCxGz7KOpsLGEbscbVj6TbAvNSnEBvzz7uOjvk/jMamn4M
         Z59+UhIntT0jk+mx6ZudOwdgI+CJwiNgO5eboh7Febu2hfTWlhiZ1GuN41h0IXMRMKvo
         IiY0HqPwd5f4Y7y9W1LTC0lhoq1C8KOHeRTxc6+l+ExsYgkENmtJdCzlFTSmJ9cNIhv5
         L8f8UrEwymtMkGfs1kIbd6kuNI6tEc+QL3ILw3Udnkrz3g7jbVkdMYaR759icK3ae/f6
         ARAw==
X-Gm-Message-State: ABy/qLYZ8mwS4LCdlLAhW7Uu3XRPOSHT36pXSzyBsd53FC1P3F8SwhxD
        R09suich7n7eOF9GeYOSKPVw/tTgEhbB0knb7Lyi+g==
X-Google-Smtp-Source: APBJJlFNU32ts4pU3Y3+UfcDK8gH6yx9+i1081/a9sl3Gib8BPeKZ1Y66EZL7iLlvMTB6NA3u+d2+Q==
X-Received: by 2002:adf:cf0d:0:b0:314:1aed:8f5f with SMTP id o13-20020adfcf0d000000b003141aed8f5fmr527463wrj.34.1688027857170;
        Thu, 29 Jun 2023 01:37:37 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.praguecc.cz (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id cw13-20020a056000090d00b003112f836d4esm15266322wrb.85.2023.06.29.01.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 01:37:36 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v5 1/3] ARM: dts: stm32: add ltdc support on stm32f746 MCU
Date:   Thu, 29 Jun 2023 10:37:24 +0200
Message-Id: <20230629083726.84910-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230629083726.84910-1-dario.binacchi@amarulasolutions.com>
References: <20230629083726.84910-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

