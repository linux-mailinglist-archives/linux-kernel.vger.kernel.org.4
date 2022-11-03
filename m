Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F957617FDB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiKCOoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiKCOoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:44:22 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C27630E;
        Thu,  3 Nov 2022 07:44:20 -0700 (PDT)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id D516B10000E;
        Thu,  3 Nov 2022 14:44:06 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
To:     hadess@hadess.net, hdegoede@redhat.com, dmitry.torokhov@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org, heiko@sntech.de
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [RFC PATCH 0/7] fix reset line polarity for Goodix touchscreen controllers
Date:   Thu,  3 Nov 2022 15:43:45 +0100
Message-Id: <20221103-upstream-goodix-reset-v1-0-87b49ae589f1@theobroma-systems.com>
X-Mailer: git-send-email 2.38.1
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

The Goodix touchscreen controller has a reset line active low. It happens to
also be used to configure its i2c address at runtime. If the reset line is
incorrectly asserted, the address will be wrongly configured. This cost me a few
hours yesterday, trying to figure out why the touchscreen wouldn't work.

The driver is "asserting" this reset GPIO by setting its output to 0, probably
to reflect the physical state of the line. However, this relies on the fact that
the Device Tree node setting the reset line polarity to active high, which is
incorrect since the reset is active low in hardware.

To fix this inconsistency, the polarity is inverted to not confuse the user
about the reset line polarity.

This is marked as RFC because it breaks DT compatibility and also the Google
CoachZ device is the only one with an active low polarity for the reset GPIO
in DT, so not sure if it is a typo or its state is actually inverted (so GPIO
active high to drive the reset line low). Changing it anyways since the polarity
is changed in the driver so it needs to be changed in DT too.

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
Quentin Schulz (7):
      Input: goodix - fix reset polarity
      ARM: dts: imx: fix touchscreen reset GPIO polarity
      ARM: dts: sunxi: fix touchscreen reset GPIO polarity
      arm64: dts: allwinner: fix touchscreen reset GPIO polarity
      arm64: dts: imx: fix touchscreen reset GPIO polarity
      arm64: dts: qcom: fix touchscreen reset GPIO polarity
      arm64: dts: rockchip: fix touchscreen reset GPIO polarity

 arch/arm/boot/dts/imx6q-kp.dtsi                                  | 2 +-
 arch/arm/boot/dts/imx6ul-kontron-bl-43.dts                       | 2 +-
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts                   | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts       | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi          | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts             | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts                  | 2 +-
 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts          | 2 +-
 arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts                  | 2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi              | 2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi            | 2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland.dtsi             | 2 +-
 arch/arm64/boot/dts/rockchip/px30-evb.dts                        | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi               | 2 +-
 arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts                 | 2 +-
 drivers/input/touchscreen/goodix.c                               | 4 ++--
 17 files changed, 18 insertions(+), 18 deletions(-)
---
base-commit: 8e5423e991e8cd0988d0c4a3f4ac4ca1af7d148a
change-id: 20221103-upstream-goodix-reset-aa1c65994f57

Best regards,
-- 
Quentin Schulz <quentin.schulz@theobroma-systems.com>
