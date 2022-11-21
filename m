Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589E8632AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbiKURT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiKURTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:19:09 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B5A11A10;
        Mon, 21 Nov 2022 09:17:44 -0800 (PST)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id AE28E6000D;
        Mon, 21 Nov 2022 17:17:34 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
To:     Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Samuel Holland <samuel@sholland.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
Subject: [PATCH RFC v2 0/7] fix reset line polarity for Goodix touchscreen controllers
Date:   Mon, 21 Nov 2022 18:17:17 +0100
Message-Id: <20221103-upstream-goodix-reset-v2-0-2c38fb03a300@theobroma-systems.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

The Goodix touchscreen controller has a reset line active low. It happens to
also be used to configure its i2c address at runtime. If the reset line is
incorrectly asserted, the address will be wrongly configured. This cost me a few
hours, trying to figure out why the touchscreen wouldn't work.

The driver is "asserting" this reset GPIO by setting its output to 0, probably
to reflect the physical state of the line. However, this relies on the fact that
the Device Tree node setting the reset line polarity to active high, which is
incorrect since the reset is active low in hardware.

To fix this inconsistency, the polarity is inverted to not confuse the user
about the reset line polarity.

This is marked as RFC because it breaks DT compatibility and I cannot test ACPI
support. Do we also make this patch series only one patchset since the DT
patches depend on the driver patch and vice-versa? In which tree would this go?

I'm all ears if there's a better way to handle this. We could document this in
the DT binding but this kinda breaks the promise we make that the DT is not
bound to the driver implementation.

Thanks,
Quentin

To: Bastien Nocera <hadess@hadess.net>
To: Hans de Goede <hdegoede@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: NXP Linux Team <linux-imx@nxp.com>
To: Chen-Yu Tsai <wens@csie.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Samuel Holland <samuel@sholland.org>
To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
Changes in v2:
- implemented ACPI support as suggested by Hans,
- removed Qcom SC7180 Trogdor-based devices changes as they are not using this Goodix driver,
- added comment on how to read gpiod_request_output and the GPIO DT polarity,
- Link to v1: https://lore.kernel.org/r/20221103-upstream-goodix-reset-v1-0-87b49ae589f1@theobroma-systems.com

---
Quentin Schulz (7):
      Input: goodix - fix reset polarity
      ARM: dts: imx: fix touchscreen reset GPIO polarity
      ARM: dts: sunxi: fix touchscreen reset GPIO polarity
      arm64: dts: allwinner: fix touchscreen reset GPIO polarity
      arm64: dts: imx: fix touchscreen reset GPIO polarity
      arm64: dts: qcom: fix touchscreen reset GPIO polarity
      arm64: dts: rockchip: fix touchscreen reset GPIO polarity

 arch/arm/boot/dts/imx6q-kp.dtsi                    |  2 +-
 arch/arm/boot/dts/imx6ul-kontron-bl-43.dts         |  2 +-
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts     |  2 +-
 .../dts/allwinner/sun50i-a64-amarula-relic.dts     |  2 +-
 .../allwinner/sun50i-a64-oceanic-5205-5inmfd.dts   |  2 +-
 .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi   |  2 +-
 .../boot/dts/allwinner/sun50i-a64-pinetab.dts      |  2 +-
 arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts    |  2 +-
 .../boot/dts/freescale/imx8mq-librem5-devkit.dts   |  2 +-
 arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts    |  2 +-
 arch/arm64/boot/dts/rockchip/px30-evb.dts          |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi |  2 +-
 arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts   |  2 +-
 drivers/input/touchscreen/goodix.c                 | 45 +++++++++++++++++-----
 14 files changed, 48 insertions(+), 23 deletions(-)
---
base-commit: 84368d882b9688bfac77ce48d33b1e20a4e4a787
change-id: 20221103-upstream-goodix-reset-aa1c65994f57

Best regards,
-- 
Quentin Schulz <quentin.schulz@theobroma-systems.com>
