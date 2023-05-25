Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B9D7114C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242238AbjEYSlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242464AbjEYSke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:40:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F6819BA;
        Thu, 25 May 2023 11:38:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEE5464929;
        Thu, 25 May 2023 18:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DF9C433A0;
        Thu, 25 May 2023 18:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039881;
        bh=iN4nDzu6YDfIlpcxOzZqXOdjSyKufmN2AjJK/Sk5CJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qIoj/b94WiQWlIWPoAwXCLDcb5DZs7DRtlVQZIhQ1Bx7Ij2tB0wfLZra2hxCpHe/u
         ukAU+gD/vioAah0h+87ci6m1E1T3u2cO9p0Ckltbac+1d6BhiHnrI8qiakVdbetVC8
         uRmZjtYpZ/XTyxoaJNH6OmZk92UrboqrhgYpipXvYxVtzMyQ1pEqyFOXRtRLpdt7tK
         wbeUWX7cQaR4XqPs6X6WyTjw5KTEp7A6F+qGYHq4tHyWgzuUXWyMWyi7rLq4GobVq+
         2SvddxmTxypoIrwHS4pG4zAVh3YC5ELHnwwAyZobiV/UmtrCP8nEwNN07EoMz0tQIv
         oKqmyRWbJtXyA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 36/57] ARM: dts: stm32: add CAN support on stm32f746
Date:   Thu, 25 May 2023 14:35:46 -0400
Message-Id: <20230525183607.1793983-36-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183607.1793983-1-sashal@kernel.org>
References: <20230525183607.1793983-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dario Binacchi <dario.binacchi@amarulasolutions.com>

[ Upstream commit 0920ccdf41e3078a4dd2567eb905ea154bc826e6 ]

Add support for bxcan (Basic eXtended CAN controller) to STM32F746. The
chip contains three CAN peripherals, CAN1 and CAN2 in dual peripheral
configuration and CAN3 in single peripheral configuration:
- Dual CAN peripheral configuration:
  * CAN1: Primary bxCAN for managing the communication between a secondary
    bxCAN and the 512-byte SRAM memory.
  * CAN2: Secondary bxCAN with no direct access to the SRAM memory.
  This means that the two bxCAN cells share the 512-byte SRAM memory and
  CAN2 can't be used without enabling CAN1.
- Single CAN peripheral configuration:
  * CAN3: Primary bxCAN with dedicated Memory Access Controller unit and
    512-byte SRAM memory.

 -------------------------------------------------------------------------
| features | CAN1              | CAN2               | CAN 3               |
 -------------------------------------------------------------------------
| SRAM     | 512-byte shared between CAN1 & CAN2    | 512-byte            |
 -------------------------------------------------------------------------
| Filters  | 26 filters shared between CAN1 & CAN2  | 14 filters          |
 -------------------------------------------------------------------------

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/all/20230427204540.3126234-6-dario.binacchi@amarulasolutions.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/stm32f746.dtsi | 47 ++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index dc868e6da40e0..973698bc9ef4b 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -257,6 +257,23 @@ rtc: rtc@40002800 {
 			status = "disabled";
 		};
 
+		can3: can@40003400 {
+			compatible = "st,stm32f4-bxcan";
+			reg = <0x40003400 0x200>;
+			interrupts = <104>, <105>, <106>, <107>;
+			interrupt-names = "tx", "rx0", "rx1", "sce";
+			resets = <&rcc STM32F7_APB1_RESET(CAN3)>;
+			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN3)>;
+			st,gcan = <&gcan3>;
+			status = "disabled";
+		};
+
+		gcan3: gcan@40003600 {
+			compatible = "st,stm32f4-gcan", "syscon";
+			reg = <0x40003600 0x200>;
+			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN3)>;
+		};
+
 		usart2: serial@40004400 {
 			compatible = "st,stm32f7-uart";
 			reg = <0x40004400 0x400>;
@@ -337,6 +354,36 @@ i2c4: i2c@40006000 {
 			status = "disabled";
 		};
 
+		can1: can@40006400 {
+			compatible = "st,stm32f4-bxcan";
+			reg = <0x40006400 0x200>;
+			interrupts = <19>, <20>, <21>, <22>;
+			interrupt-names = "tx", "rx0", "rx1", "sce";
+			resets = <&rcc STM32F7_APB1_RESET(CAN1)>;
+			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN1)>;
+			st,can-primary;
+			st,gcan = <&gcan1>;
+			status = "disabled";
+		};
+
+		gcan1: gcan@40006600 {
+			compatible = "st,stm32f4-gcan", "syscon";
+			reg = <0x40006600 0x200>;
+			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN1)>;
+		};
+
+		can2: can@40006800 {
+			compatible = "st,stm32f4-bxcan";
+			reg = <0x40006800 0x200>;
+			interrupts = <63>, <64>, <65>, <66>;
+			interrupt-names = "tx", "rx0", "rx1", "sce";
+			resets = <&rcc STM32F7_APB1_RESET(CAN2)>;
+			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN2)>;
+			st,can-secondary;
+			st,gcan = <&gcan1>;
+			status = "disabled";
+		};
+
 		cec: cec@40006c00 {
 			compatible = "st,stm32-cec";
 			reg = <0x40006C00 0x400>;
-- 
2.39.2

