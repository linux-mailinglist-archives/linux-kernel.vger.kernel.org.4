Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F786F7114
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjEDRgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjEDRg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:36:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED83346B0;
        Thu,  4 May 2023 10:36:24 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-211-176.ewe-ip-backbone.de [91.248.211.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E636866056F7;
        Thu,  4 May 2023 18:36:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683221783;
        bh=K/qN9e0SrT6biOjiv9Avq9u7FE/XLkP4y3/pnSqAvYE=;
        h=From:To:Cc:Subject:Date:From;
        b=RLkVmqFvT5Pv5m+8Z8tFdrfxHkKBlRrWdXV/yfoBKv8i51RvyLlTzawWWogR6fuJW
         9PdaWtAfUJWBEJEGYQx9qRBPyOeOnnzH0sNQImSptSfQO/rotjsr57d+UGzM7Tjl6q
         /xH9nu/oT1csp8+4mo7Vds1IyjsrQUHL9U67UriXnDd6pOPaiP4ZLyEBhVLtq8DxW/
         30ozPlbCIQdLgruPBYnWMoVZ6SbWm2gNRMrA459swzzF/KQZDks+mZ91Ss/GucBUhW
         2LSkIYB8tQUF9/E20vMwB+K2Jbo0oS0Jp3c0Ls+/wyhjzZHALs7VX/kanngwD3HO4E
         iUp35UYLqdvTw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id D52D94805CC; Thu,  4 May 2023 19:36:20 +0200 (CEST)
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
Subject: [PATCH v8 00/14] mfd/pinctrl/regulator: Add RK806 Support
Date:   Thu,  4 May 2023 19:36:04 +0200
Message-Id: <20230504173618.142075-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

All existing boards using RK3588/RK3588s use RK806 PMICs. This series is now
the main blocker for full upstream support of those boards and it would be good
to have it merged for 6.5 :) The patches have been tested on multiple different
platforms and are mainly missing an Ack from Mark or Liam for the rk808-regulator
changes.

Merging must happen through a single tree, since the pinctrl and regulator
drivers rely on the register definitions from the include file added by the MFD
patch. My suggested merge strategy is that Lee creates an immutable branch for
the regulator/pinctrl tree once all Acks have been collected.

Changelog since PATCHv7:
 * https://lore.kernel.org/all/20230307153617.643260-1-sebastian.reichel@collabora.com/
 * rebased to 1a5304fecee5 (current master from 2023-05-04) - a bit
   before v6.4-rc1 (which has not yet been tagged), but all involved
   trees have been merged
 * added new patch to fix rk808 driver not probing correctly when a
   probe defer happens _after_ setting up the of_node.
 * added patch to cleanup usage of parent device in rk808 regulator
   driver
 * added a patch reverting async probing in rk808 driver
 * collected Stephen Boyd's Ack for the rk808 clk patch
 * collected Alexandre Belloni's Ack for the mfd split patch
 * collected Lee Jones' Ack for the rk806 MFD patch
 * collected Tested-by from Vincent Legoll for the v6 series patches
 * collected Tested-by from Diederik de Haas for the v6 series patches

Changelog since PATCHv6:
 * https://lore.kernel.org/all/20230127181244.160887-1-sebastian.reichel@collabora.com/
 * rebased to v6.3-rc1
 * add Lee Jones' Acked-by-for-MFD to patches 5 & 6
 * add Linus Walleij Acked-by to patch 9
 * fix review comments provided by Lee Jones
   - remove spaces around ## in RK806_CMD_WITH_SIZE
   - add spaces around - in RK806_CMD_WITH_SIZE
   - change regmap init error message
   - further improve readability of buffer handling in rk806_spi_bus_write
   - use define for maximum buffer size
 * add .max_register to regmap_config, so that they can be analyzed in debugfs
 * switch to 16 bit register addresses to further simplify the code
 * fix max. buffer size by using RK806_CMD_LEN_MSK,
   which is 4 bit (max. 16 bytes) instead of 7 bit (max. 128 bytes)
 * add RK806_CMD_CRC_DIS to RK806_CMD_WITH_SIZE define to explicitly
   initialize all bits of the command byte

Changelog since PATCHv5:
 * https://lore.kernel.org/all/20230109172723.60304-1-sebastian.reichel@collabora.com/
 * add Reviewed-by from Rob Herring to the rk806 DT binding patch
 * drop useless wrapper functions for rk8xx_i2c_suspend and rk8xx_i2c_resume
 * put .num_resources after .resources for rk806_pwrkey_resources
 * simplify dual_support logic by storing IRQF_SHARED or 0 instead of bool
 * add missing spaces around + and - in rk806
 * add new patch using device_get_match_data() in rk8xx-i2c and removing
   the pointless dev_info printing the chip version
 * call devm_mfd_add_devices() with id=0 and rely on mfd_cell to have the .id
   field configured to either PLATFORM_DEVID_AUTO or PLATFORM_DEVID_NONE
 * add check if more than 128 bytes are tried to be received/sent, which would
   overflow the command register
 * add RK806_CMD_WITH_SIZE() define

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

Sebastian Reichel (14):
  clk: RK808: reduce 'struct rk808' usage
  mfd: rk808: convert to device managed resources
  mfd: rk808: use dev_err_probe
  mfd: rk808: replace 'struct i2c_client' with 'struct device'
  mfd: rk808: split into core and i2c
  mfd: rk8xx-i2c: use device_get_match_data
  dt-bindings: mfd: add rk806 binding
  mfd: rk8xx: add rk806 support
  pinctrl: rk805: add rk806 pinctrl support
  regulator: expose regulator_find_closest_bigger
  regulator: rk808: fix asynchronous probing
  regulator: rk808: cleanup parent device usage
  regulator: rk808: revert to synchronous probing
  regulator: rk808: add rk806 support

 .../bindings/mfd/rockchip,rk806.yaml          | 406 +++++++++++++++++
 drivers/clk/Kconfig                           |   2 +-
 drivers/clk/clk-rk808.c                       |  34 +-
 drivers/input/misc/Kconfig                    |   2 +-
 drivers/mfd/Kconfig                           |  21 +-
 drivers/mfd/Makefile                          |   4 +-
 drivers/mfd/{rk808.c => rk8xx-core.c}         | 352 +++++----------
 drivers/mfd/rk8xx-i2c.c                       | 185 ++++++++
 drivers/mfd/rk8xx-spi.c                       | 124 ++++++
 drivers/pinctrl/Kconfig                       |   2 +-
 drivers/pinctrl/pinctrl-rk805.c               | 189 +++++++-
 drivers/power/supply/Kconfig                  |   2 +-
 drivers/regulator/Kconfig                     |   2 +-
 drivers/regulator/helpers.c                   |  22 +-
 drivers/regulator/rk808-regulator.c           | 399 ++++++++++++++++-
 drivers/rtc/Kconfig                           |   2 +-
 include/linux/mfd/rk808.h                     | 417 +++++++++++++++++-
 include/linux/regulator/driver.h              |   2 +
 sound/soc/codecs/Kconfig                      |   2 +-
 19 files changed, 1876 insertions(+), 293 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
 rename drivers/mfd/{rk808.c => rk8xx-core.c} (71%)
 create mode 100644 drivers/mfd/rk8xx-i2c.c
 create mode 100644 drivers/mfd/rk8xx-spi.c

-- 
2.39.2

