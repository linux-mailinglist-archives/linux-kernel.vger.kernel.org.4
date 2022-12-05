Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAB4642996
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiLENlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiLENlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:41:06 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53912DF5C;
        Mon,  5 Dec 2022 05:41:02 -0800 (PST)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 0ED2BFF807;
        Mon,  5 Dec 2022 13:40:47 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
To:     Samuel Holland <samuel@sholland.org>,
        Bastien Nocera <hadess@hadess.net>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Angus Ainslie <angus@akkea.ca>,
        Ondrej Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Andy Gross <agross@kernel.org>,
        Aleksei Mamlin <mamlinav@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        David Jander <david@protonic.nl>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Lukasz Majewski <lukma@denx.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v3 0/9] fix reset line polarity for Goodix touchscreen controllers
Date:   Mon,  5 Dec 2022 14:40:29 +0100
Message-Id: <20221103-upstream-goodix-reset-v3-0-0975809eb183@theobroma-systems.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
about the reset line polarity. This obviously requires to fix the DT since most
users had the "incorrect" value in there, it needs to be inverted.
Note that the v2 highlighted that I was not the only one that got confused since
PRT8MM board has the "correct" HW representation for this line in DT (which does
not match what the driver was expecting).

This is marked as RFC because I can neither test ACPI support nor boards I don't
own. Please test on the boards you have that are impacted by this patchset and
give your Tested-By.
Do we also make this patch series only one patchset since the DT patches depend
on the driver patch and vice-versa? In which tree would this go?

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
To: David Jander <david@protonic.nl>
To: Angus Ainslie <angus@akkea.ca>
To: Peter Geis <pgwipeout@gmail.com>
To: Michael Riesch <michael.riesch@wolfvision.net>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
To: Guido Günther <agx@sigxcpu.org>
To: Jagan Teki <jagan@amarulasolutions.com>
To: Ondrej Jirman <megous@megous.com>
To: Icenowy Zheng <icenowy@aosc.io>
To: Aleksei Mamlin <mamlinav@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
Changes in v3:
- Cc'ing people who contributed to DTS of impacted boards,
- removed PRT8MM DTS change since it's been reported the polarity is actually
  correct (goes through an inverter), keeping the appropriate folks in Cc though
  since it'd be a good idea to check this patch series anyways,
- added ACPI_GPIO_QUIRK_NO_IO_RESTRICTION to acpi_gpio_mapping quirks to make
  gpiolib-acpi core respect GPIOD_ASIS flag in gpiod_get,
- checked schematics of:
  - pinephone: https://files.pine64.org/doc/PinePhone/PinePhone%20v1.2%20Released%20Schematic.pdf
  - pinetab: https://files.pine64.org/doc/PineTab/PineTab%20Schematic%20v1.2-20191125.pdf
  - px30 evb: https://opensource.rock-chips.com/images/d/db/Px30_mini_evb_v10_20180528.pdf
  - rockpro64: https://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf
  - librem5 devkit: https://source.puri.sm/Librem5/dvk-mx8m-bsb/blob/master/dvk-mx8m-bsb.pdf

  All seems to be directly connected to the GPIO on the SoC side, without an
  inverter on the line.
- Link to v2: https://lore.kernel.org/r/20221103-upstream-goodix-reset-v2-0-2c38fb03a300@theobroma-systems.com

Changes in v2:
- implemented ACPI support as suggested by Hans,
- removed Qcom SC7180 Trogdor-based devices changes as they are not using this Goodix driver,
- added comment on how to read gpiod_request_output and the GPIO DT polarity,
- Link to v1: https://lore.kernel.org/r/20221103-upstream-goodix-reset-v1-0-87b49ae589f1@theobroma-systems.com

---
Quentin Schulz (9):
      Input: goodix - add macro for gpio mapping
      Input: goodix - make gpiod_get honor GPIOD_ASIS
      Input: goodix - fix reset polarity
      ARM: dts: imx: fix touchscreen reset GPIO polarity
      ARM: dts: sunxi: fix touchscreen reset GPIO polarity on Wexler TAB7200 tablet
      arm64: dts: allwinner: fix touchscreen reset GPIO polarity
      arm64: dts: librem5: fix touchscreen reset GPIO polarity
      arm64: dts: qcom: msm8998-fxtec: fix touchscreen reset GPIO polarity
      arm64: dts: rockchip: fix touchscreen reset GPIO polarity

 arch/arm/boot/dts/imx6q-kp.dtsi                    |  2 +-
 arch/arm/boot/dts/imx6ul-kontron-bl-43.dts         |  2 +-
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts     |  2 +-
 .../dts/allwinner/sun50i-a64-amarula-relic.dts     |  2 +-
 .../allwinner/sun50i-a64-oceanic-5205-5inmfd.dts   |  2 +-
 .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi   |  2 +-
 .../boot/dts/allwinner/sun50i-a64-pinetab.dts      |  2 +-
 .../boot/dts/freescale/imx8mq-librem5-devkit.dts   |  2 +-
 arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts    |  2 +-
 arch/arm64/boot/dts/rockchip/px30-evb.dts          |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi |  2 +-
 arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts   |  2 +-
 drivers/input/touchscreen/goodix.c                 | 54 ++++++++++++++++++----
 13 files changed, 56 insertions(+), 22 deletions(-)
---
base-commit: 76dcd734eca23168cb008912c0f69ff408905235
change-id: 20221103-upstream-goodix-reset-aa1c65994f57

Best regards,
-- 
Quentin Schulz <quentin.schulz@theobroma-systems.com>
