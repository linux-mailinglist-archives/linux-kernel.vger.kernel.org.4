Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A614E740CBF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjF1J0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:26:48 -0400
Received: from mail-sh.amlogic.com ([58.32.228.43]:22191 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbjF1JSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:18:01 -0400
Received: from rd02-sz.amlogic.software (10.28.11.83) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Wed, 28 Jun 2023
 17:16:11 +0800
From:   Huqiang Qin <huqiang.qin@amlogic.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <hkallweit1@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        Huqiang Qin <huqiang.qin@amlogic.com>
Subject: [PATCH V2 2/2] irqchip: Add support for Amlogic-C3 SoCs
Date:   Wed, 28 Jun 2023 17:15:33 +0800
Message-ID: <20230628091533.3884385-3-huqiang.qin@amlogic.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230628091533.3884385-1-huqiang.qin@amlogic.com>
References: <20230628091533.3884385-1-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.11.83]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic-C3 SoCs support 12 GPIO IRQ lines compared with previous
serial chips and have something different, details are as below.

IRQ Number:
- 54     1 pins on bank TESTN
- 53:40 14 pins on bank X
- 39:33  7 pins on bank D
- 32:27  6 pins on bank A
- 26:22  5 pins on bank E
- 21:15  7 pins on bank C
- 14:0  15 pins on bank B

Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
---
 drivers/irqchip/irq-meson-gpio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 7da18ef95211..f88df39f4129 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -150,6 +150,10 @@ static const struct meson_gpio_irq_params s4_params = {
 	INIT_MESON_S4_COMMON_DATA(82)
 };
 
+static const struct meson_gpio_irq_params c3_params = {
+	INIT_MESON_S4_COMMON_DATA(55)
+};
+
 static const struct of_device_id meson_irq_gpio_matches[] __maybe_unused = {
 	{ .compatible = "amlogic,meson8-gpio-intc", .data = &meson8_params },
 	{ .compatible = "amlogic,meson8b-gpio-intc", .data = &meson8b_params },
@@ -160,6 +164,7 @@ static const struct of_device_id meson_irq_gpio_matches[] __maybe_unused = {
 	{ .compatible = "amlogic,meson-sm1-gpio-intc", .data = &sm1_params },
 	{ .compatible = "amlogic,meson-a1-gpio-intc", .data = &a1_params },
 	{ .compatible = "amlogic,meson-s4-gpio-intc", .data = &s4_params },
+	{ .compatible = "amlogic,c3-gpio-intc", .data = &c3_params },
 	{ }
 };
 
-- 
2.37.1

