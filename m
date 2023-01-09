Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6732662CA8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbjAIR1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237289AbjAIR1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:27:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A010765E;
        Mon,  9 Jan 2023 09:27:28 -0800 (PST)
Received: from jupiter.universe (dyndsl-037-138-188-006.ewe-ip-backbone.de [37.138.188.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 97D7B6602D06;
        Mon,  9 Jan 2023 17:27:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673285246;
        bh=nQsLEx8imfg6q30F8cNFRfohA+pDu3urKtovZZARPaM=;
        h=From:To:Cc:Subject:Date:From;
        b=DUW1xw4yxf/DBpw2qT1HlSqe3i/J7OgLTAdKIc6amt5qpLLLhqnk0wHgX9ivvQrYS
         rX47ux1kG46gEmJWMLU+fL9aXD0Lw9MptUoEcOhmgIZPVcCtiHplJ8Vyr108PJ1Q+H
         Wvq/a6Cg0pgrIbQy1QJxcopx/q3vjXY+h+E6dBfjB87fvdBePsdMGOg24s7bJQWsj8
         u1Lg82TziQll3zb+QQx7v9GlQrajdxxnPrqbCraRqR+sMlkdt6F4zLNAQ2y2TsteLB
         I3abOBDwTxLMg5LhROMiprLq0zrWkyXffuGBa7Mljo1+QcO2PE45zepb6nITJF9QR5
         8sDLWUK3gg23Q==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 52943480116; Mon,  9 Jan 2023 18:27:24 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv5 00/10] Introduce RK806 Support
Date:   Mon,  9 Jan 2023 18:27:13 +0100
Message-Id: <20230109172723.60304-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Rockchip RK3588 Evaluation Boards use SPI connected RK806
PMICs. Downstream this is handled by a new driver, but apart
from being SPI connected this chip is quite similar to the
ther Rockchip PMICs (also RK806 is promoted to also support
I2C). Thus this series instead updates the RK808 driver(s).

Changelog since PATCHv4:
 * https://lore.kernel.org/all/20221020204251.108565-1-sebastian.reichel@collabora.com/
 * rebase to v6.2-rc1
   - dropped 'regulator: rk808: reduce 'struct rk808' usage' (queued to 6.2-rc1)
   - dropped 'regulator: rk808: Use dev_err_probe' (queued to 6.2-rc1)
   - dropped 'rtc: rk808: reduce 'struct rk808' usage' (queued to 6.2-rc1)
 * use 'MFD_RK8XX' for the MFD driver supporting all the MFD8XX chips
 * added author tags to drivers/mfd/rk8xx-core.c. They were missing because
   I moved the original header over to the i2c specific file and wrote the
   new header from scratch. I suppose it's better to have the author tags
   in both files.
 * fix Rob's comments for the rk806 YAML binding
 * add defines for rk806 command indexes
 * modify rk806 code, so that it is capable of mult-write

Changelog since PATCHv3:
 * https://lore.kernel.org/all/20220909175522.179175-1-sebastian.reichel@collabora.com/
 * Dropped removing REGMAP_I2C dependency from RK817 ASoC driver (applied)
 * Rename MFD_RK808 to MFD_RK8XX to be consistent. It makes sense to do this now,
   since the patchset touches all the child drivers anyways.
 * rebase to v6.1-rc1
 * collected a couple of Acks
 * update rk806 DT binding according to DT maintainer feedback
 * add missing pinmux config to the rk806 DT binding
 * update rk806_spi_bus_write and rk806_spi_bus_read
 * replaced some constants with sizeof or defines
 * used capitalized comments
 * rename regmap_find_closest_bigger to regulator_find_closest_bigger, not sure
   why I prefixed it with regmap_ in the first place
 * use rk8xx_is_enabled_wmsk_regmap instead of regulator_is_enabled_regmap for
   the switching regulators to correctly report the state
 * reordered the first few patches grouping the MFD patches together

Changelog since PATCHv2:
 * https://lore.kernel.org/all/20220908003107.220143-1-sebastian.reichel@collabora.com/
 * Change DT binding to not allow nldo-reg6
 * Fix DT binding to check for [np]ldo-reg instead of [np]ldo_reg
 * remove rk806_get_voltage_sel_regmap in favour of regulator_get_voltage_sel_regmap
 * drop rk806_set_voltage in favour of regulator_set_voltage_sel_regmap
 * use regulator_set_ramp_delay_regmap
 * drop possibly incorrect printing of chip id register address in case of errors

Changelog since PATCHv1:
 * https://lore.kernel.org/all/20220831215437.117880-1-sebastian.reichel@collabora.com/
 * Collect Acked-by
 * Avoid if/else checks for regulator id in rk806 regulator driver
 * Fix indentation in DTS example section of the rk806 binding
 * Use absolute path for regulator.yaml referencing in the rk806 binding
 * Reduce pattern for DCDC regulators to only allow 1-10
 * replace uppercase name with lowercase ones in regulator names
 * replace _ with - in regulator names

-- Sebastian

Sebastian Reichel (10):
  clk: RK808: reduce 'struct rk808' usage
  mfd: rk808: convert to device managed resources
  mfd: rk808: use dev_err_probe
  mfd: rk808: replace 'struct i2c_client' with 'struct device'
  mfd: rk808: split into core and i2c
  dt-bindings: mfd: add rk806 binding
  mfd: rk8xx: add rk806 support
  pinctrl: rk805: add rk806 pinctrl support
  regulator: expose regulator_find_closest_bigger
  regulator: rk808: add rk806 support

 .../bindings/mfd/rockchip,rk806.yaml          | 406 +++++++++++++++++
 drivers/clk/Kconfig                           |   2 +-
 drivers/clk/clk-rk808.c                       |  34 +-
 drivers/input/misc/Kconfig                    |   2 +-
 drivers/mfd/Kconfig                           |  21 +-
 drivers/mfd/Makefile                          |   4 +-
 drivers/mfd/{rk808.c => rk8xx-core.c}         | 350 +++++----------
 drivers/mfd/rk8xx-i2c.c                       | 209 +++++++++
 drivers/mfd/rk8xx-spi.c                       | 122 +++++
 drivers/pinctrl/Kconfig                       |   2 +-
 drivers/pinctrl/pinctrl-rk805.c               | 189 +++++++-
 drivers/power/supply/Kconfig                  |   2 +-
 drivers/regulator/Kconfig                     |   2 +-
 drivers/regulator/helpers.c                   |  22 +-
 drivers/regulator/rk808-regulator.c           | 383 ++++++++++++++++
 drivers/rtc/Kconfig                           |   2 +-
 include/linux/mfd/rk808.h                     | 417 +++++++++++++++++-
 include/linux/regulator/driver.h              |   2 +
 sound/soc/codecs/Kconfig                      |   2 +-
 19 files changed, 1889 insertions(+), 284 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
 rename drivers/mfd/{rk808.c => rk8xx-core.c} (71%)
 create mode 100644 drivers/mfd/rk8xx-i2c.c
 create mode 100644 drivers/mfd/rk8xx-spi.c

-- 
2.39.0

