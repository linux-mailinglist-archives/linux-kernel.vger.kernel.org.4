Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00485602B84
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJRMRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJRMRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:17:47 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F61DA3463;
        Tue, 18 Oct 2022 05:17:46 -0700 (PDT)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 6BA7740003;
        Tue, 18 Oct 2022 12:17:42 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
To:     linus.walleij@linaro.org, heiko@sntech.de, david.wu@rock-chips.com
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        foss+kernel@0leil.net,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH] pinctrl: rockchip: list all pins in a possible mux route for PX30
Date:   Tue, 18 Oct 2022 14:17:23 +0200
Message-Id: <20221017-upstream-px30-cif-clkoutm1-v1-0-4ea1389237f7@theobroma-systems.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

The mux routes are incomplete for the PX30. This was discovered because
we had a HW design using cif-clkoutm1 with the correct pinmux in the
Device Tree but the clock would still not work.

There are actually two muxing required: the pin muxing (performed by the
usual Device Tree pinctrl nodes) and the "function" muxing (m0 vs m1;
performed by the mux routing inside the driver). The pin muxing was
correct but the function muxing was not.

This adds the missing pins and their configuration for the mux routes
that are already specified in the driver.

Note that there are some "conflicts": it is possible *in Device Tree* to
(attempt to) mux the pins for e.g. clkoutm1 and clkinm0 at the same time
but this is actually not possible in hardware (because both share the
same bit for the function muxing). Since it is an impossible hardware
design, it is not deemed necessary to prevent the user from attempting
to "misconfigure" the pins/functions.

Fixes: 87065ca9b8e5 ("pinctrl: rockchip: Add pinctrl support for PX30")
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
rockchip: px30: fix missing m0/m1 function muxes m0/m1

The mux routes are incomplete for the PX30. This was discovered because
we had a HW design using cif-clkoutm1 with the correct pinmux in the
Device Tree but the clock would still not work.

There are actually two muxing required: the pin muxing (performed by the
usual Device Tree pinctrl nodes) and the "function" muxing (m0 vs m1;
performed by the mux routing inside the driver). The pin muxing was
correct but the function muxing was not.

This adds the missing pins and their configuration for the mux routes
that are already specified in the driver.

Note that there are some "conflicts": it is possible *in Device Tree* to
(attempt to) mux the pins for e.g. clkoutm1 and clkinm0 at the same time
but this is actually not possible in hardware (because both share the
same bit for the function muxing). Since it is an impossible hardware
design, it is not deemed necessary to prevent the user from attempting
to "misconfigure" the pins/functions.

Note that only cif-clkoutm1 feature was tested out of the dozens of added pins.

Cheers,
Quentin

To: Linus Walleij <linus.walleij@linaro.org>
To: Heiko Stuebner <heiko@sntech.de>
To: David Wu <david.wu@rock-chips.com>
Cc: linux-gpio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pinctrl/pinctrl-rockchip.c | 40 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 53bdfc40f0558..da974ff2d75d0 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -679,14 +679,54 @@ static void rockchip_get_recalced_mux(struct rockchip_pin_bank *bank, int pin,
 }
 
 static struct rockchip_mux_route_data px30_mux_route_data[] = {
+	RK_MUXROUTE_SAME(2, RK_PB4, 1, 0x184, BIT(16 + 7)), /* cif-d0m0 */
+	RK_MUXROUTE_SAME(3, RK_PA1, 3, 0x184, BIT(16 + 7) | BIT(7)), /* cif-d0m1 */
+	RK_MUXROUTE_SAME(2, RK_PB6, 1, 0x184, BIT(16 + 7)), /* cif-d1m0 */
+	RK_MUXROUTE_SAME(3, RK_PA2, 3, 0x184, BIT(16 + 7) | BIT(7)), /* cif-d1m1 */
 	RK_MUXROUTE_SAME(2, RK_PA0, 1, 0x184, BIT(16 + 7)), /* cif-d2m0 */
 	RK_MUXROUTE_SAME(3, RK_PA3, 3, 0x184, BIT(16 + 7) | BIT(7)), /* cif-d2m1 */
+	RK_MUXROUTE_SAME(2, RK_PA1, 1, 0x184, BIT(16 + 7)), /* cif-d3m0 */
+	RK_MUXROUTE_SAME(3, RK_PA5, 3, 0x184, BIT(16 + 7) | BIT(7)), /* cif-d3m1 */
+	RK_MUXROUTE_SAME(2, RK_PA2, 1, 0x184, BIT(16 + 7)), /* cif-d4m0 */
+	RK_MUXROUTE_SAME(3, RK_PA7, 3, 0x184, BIT(16 + 7) | BIT(7)), /* cif-d4m1 */
+	RK_MUXROUTE_SAME(2, RK_PA3, 1, 0x184, BIT(16 + 7)), /* cif-d5m0 */
+	RK_MUXROUTE_SAME(3, RK_PB0, 3, 0x184, BIT(16 + 7) | BIT(7)), /* cif-d5m1 */
+	RK_MUXROUTE_SAME(2, RK_PA4, 1, 0x184, BIT(16 + 7)), /* cif-d6m0 */
+	RK_MUXROUTE_SAME(3, RK_PB1, 3, 0x184, BIT(16 + 7) | BIT(7)), /* cif-d6m1 */
+	RK_MUXROUTE_SAME(2, RK_PA5, 1, 0x184, BIT(16 + 7)), /* cif-d7m0 */
+	RK_MUXROUTE_SAME(3, RK_PB4, 3, 0x184, BIT(16 + 7) | BIT(7)), /* cif-d7m1 */
+	RK_MUXROUTE_SAME(2, RK_PA6, 1, 0x184, BIT(16 + 7)), /* cif-d8m0 */
+	RK_MUXROUTE_SAME(3, RK_PB6, 3, 0x184, BIT(16 + 7) | BIT(7)), /* cif-d8m1 */
+	RK_MUXROUTE_SAME(2, RK_PA7, 1, 0x184, BIT(16 + 7)), /* cif-d9m0 */
+	RK_MUXROUTE_SAME(3, RK_PB7, 3, 0x184, BIT(16 + 7) | BIT(7)), /* cif-d9m1 */
+	RK_MUXROUTE_SAME(2, RK_PB7, 1, 0x184, BIT(16 + 7)), /* cif-d10m0 */
+	RK_MUXROUTE_SAME(3, RK_PC6, 3, 0x184, BIT(16 + 7) | BIT(7)), /* cif-d10m1 */
+	RK_MUXROUTE_SAME(2, RK_PC0, 1, 0x184, BIT(16 + 7)), /* cif-d11m0 */
+	RK_MUXROUTE_SAME(3, RK_PC7, 3, 0x184, BIT(16 + 7) | BIT(7)), /* cif-d11m1 */
+	RK_MUXROUTE_SAME(2, RK_PB0, 1, 0x184, BIT(16 + 7)), /* cif-vsyncm0 */
+	RK_MUXROUTE_SAME(3, RK_PD1, 3, 0x184, BIT(16 + 7) | BIT(7)), /* cif-vsyncm1 */
+	RK_MUXROUTE_SAME(2, RK_PB1, 1, 0x184, BIT(16 + 7)), /* cif-hrefm0 */
+	RK_MUXROUTE_SAME(3, RK_PD2, 3, 0x184, BIT(16 + 7) | BIT(7)), /* cif-hrefm1 */
+	RK_MUXROUTE_SAME(2, RK_PB2, 1, 0x184, BIT(16 + 7)), /* cif-clkinm0 */
+	RK_MUXROUTE_SAME(3, RK_PD3, 3, 0x184, BIT(16 + 7) | BIT(7)), /* cif-clkinm1 */
+	RK_MUXROUTE_SAME(2, RK_PB3, 1, 0x184, BIT(16 + 7)), /* cif-clkoutm0 */
+	RK_MUXROUTE_SAME(3, RK_PD0, 3, 0x184, BIT(16 + 7) | BIT(7)), /* cif-clkoutm1 */
 	RK_MUXROUTE_SAME(3, RK_PC6, 2, 0x184, BIT(16 + 8)), /* pdm-m0 */
 	RK_MUXROUTE_SAME(2, RK_PC6, 1, 0x184, BIT(16 + 8) | BIT(8)), /* pdm-m1 */
+	RK_MUXROUTE_SAME(3, RK_PD3, 2, 0x184, BIT(16 + 8)), /* pdm-sdi0m0 */
+	RK_MUXROUTE_SAME(2, RK_PC5, 2, 0x184, BIT(16 + 8) | BIT(8)), /* pdm-sdi0m1 */
 	RK_MUXROUTE_SAME(1, RK_PD3, 2, 0x184, BIT(16 + 10)), /* uart2-rxm0 */
 	RK_MUXROUTE_SAME(2, RK_PB6, 2, 0x184, BIT(16 + 10) | BIT(10)), /* uart2-rxm1 */
+	RK_MUXROUTE_SAME(1, RK_PD2, 2, 0x184, BIT(16 + 10)), /* uart2-txm0 */
+	RK_MUXROUTE_SAME(2, RK_PB4, 2, 0x184, BIT(16 + 10) | BIT(10)), /* uart2-txm1 */
 	RK_MUXROUTE_SAME(0, RK_PC1, 2, 0x184, BIT(16 + 9)), /* uart3-rxm0 */
 	RK_MUXROUTE_SAME(1, RK_PB7, 2, 0x184, BIT(16 + 9) | BIT(9)), /* uart3-rxm1 */
+	RK_MUXROUTE_SAME(0, RK_PC0, 2, 0x184, BIT(16 + 9)), /* uart3-txm0 */
+	RK_MUXROUTE_SAME(1, RK_PB6, 2, 0x184, BIT(16 + 9) | BIT(9)), /* uart3-txm1 */
+	RK_MUXROUTE_SAME(0, RK_PC2, 2, 0x184, BIT(16 + 9)), /* uart3-ctsm0 */
+	RK_MUXROUTE_SAME(1, RK_PB4, 2, 0x184, BIT(16 + 9) | BIT(9)), /* uart3-ctsm1 */
+	RK_MUXROUTE_SAME(0, RK_PC3, 2, 0x184, BIT(16 + 9)), /* uart3-rtsm0 */
+	RK_MUXROUTE_SAME(1, RK_PB5, 2, 0x184, BIT(16 + 9) | BIT(9)), /* uart3-rtsm1 */
 };
 
 static struct rockchip_mux_route_data rv1126_mux_route_data[] = {

---
base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
change-id: 20221017-upstream-px30-cif-clkoutm1-a74d42654367

Best regards,
-- 
Quentin Schulz <quentin.schulz@theobroma-systems.com>
