Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A23C68D583
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjBGLa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjBGLaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:30:17 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2C6196A9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 03:29:59 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso11186968wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 03:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90w47meUN1AAVQio6KlRg3XgdW53vJW4u/H89twTllI=;
        b=F53MYSdQGFwuQHwkO5WV+1wcfNZhAYR0Mgx05MgQpZTFg4zELN8qqtKL/z+PCMIGZE
         oJ0+NQpmeY9MXS7hNiG6lQIpxHj+vO6TmMRr286fPuV70OfOjxaZ38XnZed6+EPoNY7o
         tRrb9ct+ekHsFiuITt6LmCbKxczlG+x55NPX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90w47meUN1AAVQio6KlRg3XgdW53vJW4u/H89twTllI=;
        b=ey5MYDZumngNehnprAlIVwyWI4c5xmH1W54QFxiJKRrukt6AT6zrdfKW7CcVkj41wo
         WZWz9RTyVpi+CTX+LdIqqVypHUB2D0zjteWdF1vk1s1NaT/eD+5xrJaAzYkKOr4f0AZc
         Q+vrmVVJ6ItKrkAc1zb4fz/Ucf69AbmdV9u2jjmv3Ao/Pks0KIKSrWjvmTs49B0A8naE
         RIPO4cv3cphAWY/0xOEsmPAyH7J4H8Z7ucCT5ENsq+vnT0q9uZz8x2whhk0bhqMowdPE
         s6d3YBSo71gAct2E7ILpt+WS5Goj5+MQGzFGOMtSpWoQE3fBiCcAlVxbzHb3dzrf66+r
         bIxw==
X-Gm-Message-State: AO0yUKVgo54MkMhyoU/zhniciC1mLb1zHJjRsgrkX3rGmES+00ZCp4DU
        Oxwo/BAnQaMBlU5kgIEBtkwKlSsaOVozNzWcrFg=
X-Google-Smtp-Source: AK7set8W+S+W9WBz8koXCUvnlAak6AtjkPEFa0ErbH6CZKxugwIdh+kkbeAnAb9UVXJyfgEV082lGw==
X-Received: by 2002:a05:600c:1887:b0:3dc:4318:d00d with SMTP id x7-20020a05600c188700b003dc4318d00dmr2720115wmp.11.1675769399083;
        Tue, 07 Feb 2023 03:29:59 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (mob-5-90-193-20.net.vodafone.it. [5.90.193.20])
        by smtp.gmail.com with ESMTPSA id bi5-20020a05600c3d8500b003db012d49b7sm2020827wmb.2.2023.02.07.03.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 03:29:58 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        michael@amarulasolutions.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Rob Herring <robh@kernel.org>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [RESEND PATCH v7 3/5] ARM: dts: stm32: add CAN support on stm32f429
Date:   Tue,  7 Feb 2023 12:29:24 +0100
Message-Id: <20230207112926.664773-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230207112926.664773-1-dario.binacchi@amarulasolutions.com>
References: <20230207112926.664773-1-dario.binacchi@amarulasolutions.com>
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

Add support for bxcan (Basic eXtended CAN controller) to STM32F429. The
chip contains two CAN peripherals, CAN1 the master and CAN2 the slave,
that share some of the required logic like clock and filters. This means
that the slave CAN can't be used without the master CAN.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v6)

Changes in v6:
- move can1 node before gcan to keep ordering by address.

Changes in v4:
- Replace the node can@40006400 (compatible "st,stm32f4-bxcan-core")
  with the gcan@40006600 node ("sysnode" compatible). The gcan node
  contains clocks and memory addresses shared by the two can nodes
  of which it's no longer the parent.
- Add to can nodes the "st,gcan" property (global can memory) which
  references the gcan@40006600 node ("sysnode compatibble).

Changes in v3:
- Remove 'Dario Binacchi <dariobin@libero.it>' SOB.
- Add "clocks" to can@0 node.

 arch/arm/boot/dts/stm32f429.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index c31ceb821231..809b2842ded9 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -362,6 +362,35 @@ i2c3: i2c@40005c00 {
 			status = "disabled";
 		};
 
+		can1: can@40006400 {
+			compatible = "st,stm32f4-bxcan";
+			reg = <0x40006400 0x200>;
+			interrupts = <19>, <20>, <21>, <22>;
+			interrupt-names = "tx", "rx0", "rx1", "sce";
+			resets = <&rcc STM32F4_APB1_RESET(CAN1)>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(CAN1)>;
+			st,can-master;
+			st,gcan = <&gcan>;
+			status = "disabled";
+		};
+
+		gcan: gcan@40006600 {
+			compatible = "st,stm32f4-gcan", "syscon";
+			reg = <0x40006600 0x200>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(CAN1)>;
+		};
+
+		can2: can@40006800 {
+			compatible = "st,stm32f4-bxcan";
+			reg = <0x40006800 0x200>;
+			interrupts = <63>, <64>, <65>, <66>;
+			interrupt-names = "tx", "rx0", "rx1", "sce";
+			resets = <&rcc STM32F4_APB1_RESET(CAN2)>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(CAN2)>;
+			st,gcan = <&gcan>;
+			status = "disabled";
+		};
+
 		dac: dac@40007400 {
 			compatible = "st,stm32f4-dac-core";
 			reg = <0x40007400 0x400>;
-- 
2.32.0

