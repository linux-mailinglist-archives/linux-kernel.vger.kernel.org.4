Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE1174599B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjGCKFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjGCKFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:05:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A549D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 03:05:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21F8C60EA8
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 10:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85F2C433C8;
        Mon,  3 Jul 2023 10:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688378705;
        bh=N2XBTu9XZ+qxcHuAX+yWcbHqX+PC0a29sebTMpz+g0I=;
        h=Date:From:To:Cc:Subject:From;
        b=Xffxs3eZrQxOSuCfB8X6zsg/1wrTk5sZNbjfJ+PJdd0laFhPQUwaBjxGNQQMQqPeD
         NdmibNDOuuw77yM5wIygOg6qNeDMLcbJ75j3rlborCgRbiLm8dPsjESlefEHHluifK
         NklK+DZ8Mzr+veXp4Q/X1ELUiQ/bxKpbR/bKo+WCPeVYagBvibS1uE8rZKeen3qRpk
         JBHx8rmqKP9ZZBC0vJvWPCm0bQb8Y/4DGQBtZn3VlOYilD5prRMuFbWz663pGE63Bx
         m4FTm4drbu0v1A7hYJFTXj7Wok40UamOVUntrZWdw5ybOdEFwnsROC8Se+W25cCzjs
         AJL3vJ5gusN5A==
Date:   Mon, 3 Jul 2023 11:05:01 +0100
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD for v6.5
Message-ID: <20230703100501.GA10359@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

Good morning Linus,

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-6.5

for you to fetch changes up to b05740d71bd2f8b2261930944bfe95f529190b8b:

  dt-bindings: mfd: max77541: Add ADI MAX77541/MAX77540 (2023-06-28 15:18:36 +0100)

----------------------------------------------------------------
 - New Drivers
   - Add support for TI TPS6594/TPS6593/LP8764 PMICs
   - Add support for Samsung RT5033 Battery Charger
   - Add support for Analog Devices MAX77540 and MAX77541 PMICs

 - New Device Support
   - Add support for SPI to Rockchip RK808 (and friends)
   - Add support for AXP192 PMIC to X-Powers AXP20X
   - Add support for AXP313a PMIC to X-Powers AXP20X
   - Add support for RK806 to Rockchip RK8XX

 - Removed Device Support
   - Removed MFD support for Richtek RT5033 Battery

 - Fix-ups
   - Remove superfluous code
   - Switch I2C drivers from .probe_new() to .probe()
   - Convert over to managed resources (devm_*(), etc)
   - Use dev_err_probe() for returning errors from .probe()
   - Add lots of Device Tree bindings / support
   - Improve cache efficiency by switching to Maple
   - Use own exported namespaces (NS)
   - Include missing and remove superfluous headers
   - Start using / convert to the new shutdown sys-off API
   - Trivial: variable / define renaming
   - Make use of of_property_read_reg() when requesting DT 'reg's

 - Bug Fixes
   - Fix chip revision readout due to incorrect data masking
   - Amend incorrect register and mask values used for charger state
   - Hide unused functionality at compile time
   - Fix resource leaks following error handling routines
   - Return correct error values and fix error handling in general
   - Repair incorrect device names - used for device matching
   - Remedy broken module auto-loading

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: mfd: qcom,spmi-pmic: Add pattern property for phy

Aidan MacDonald (2):
      mfd: axp20x: Add support for AXP192
      dt-bindings: mfd: Add bindings for AXP192 MFD device

Amelie Delaunay (2):
      mfd: stmfx: Fix error path in stmfx_chip_init
      mfd: stmfx: Nullify stmfx->vdd in case of error

Arnd Bergmann (1):
      mfd: intel-lpss: Hide suspend/resume functions in #ifdef

Christophe JAILLET (5):
      mfd: rc5t583-irq: Remove the unneeded include <linux/i2c.h>
      mfd: dln2: Remove the unneeded include <linux/i2c.h>
      mfd: wcd934x: Fix an error handling path in wcd934x_slim_probe()
      mfd: wcd934x: Simplify with dev_err_probe()
      mfd: stmpe: Only disable the regulators if they are enabled

Dan Carpenter (1):
      mfd: tps6594: Fix an error code in probe()

Dario Binacchi (1):
      dt-bindings: mfd: stm32f7: Add binding definition for CAN3

Guiting Shen (1):
      mfd: Remove redundant dev_set_drvdata() from I2C drivers

Ilpo Järvinen (4):
      mfd: intel-m10-bmc: Move core symbols to own namespace
      mfd: intel-m10-bmc: Create m10bmc_sys_update_bits()
      mfd: intel-m10-bmc: Move m10bmc_sys_read() away from header
      mfd: intel-m10-bmc: Manage access to MAX 10 fw handshake registers

Jakob Hauser (8):
      mfd: rt5033: Fix chip revision readout
      mfd: rt5033: Fix STAT_MASK, HZ_MASK and AICR defines
      mfd: rt5033: Apply preparatory changes before adding rt5033-charger driver
      power: supply: rt5033_charger: Add RT5033 charger device driver
      power: supply: rt5033_battery: Move struct rt5033_battery to battery driver
      power: supply: rt5033_battery: Adopt status property from charger
      dt-bindings: power: supply: rt5033-battery: Apply unevaluatedProperties
      dt-bindings: Add rt5033 MFD, Regulator and Charger

Jerome Neanne (2):
      mfd: tps65219: Add GPIO cell instance
      mfd: tps65219: Add support for soft shutdown via sys-off API

Jiasheng Jiang (1):
      mfd: intel-lpss: Add missing check for platform_get_resource

Johan Hovold (2):
      mfd: pm8008: Fix module autoloading
      mfd: pm8008: Drop bogus i2c module alias

Julien Panis (2):
      mfd: tps6594: Add driver for TI TPS6594 PMIC
      dt-bindings: mfd: Add TI TPS6594 PMIC

Krzysztof Kozlowski (1):
      dt-bindings: mfd: samsung,s5m8767: Simplify excluding properties

Lee Jones (2):
      Merge branches 'tb-mfd-clk-input-pinctrl-power-rtc-sound-6.5', 'ib-mfd-tps6594-core-6.5', 'ib-mfd-regulator-max5970-6.5', 'ib-mfd-regulator-6.5' and 'ib-mfd-power-6.5' into ibs-for-mfd-merged
      mailmap: Add some mail mappings for Lee Jones

Mark Brown (2):
      mfd: twl6040: Use maple tree register cache
      mfd: wm831x: Use maple tree register cache

Martin Botka (1):
      mfd: axp20x: Add support for AXP313a PMIC

Naresh Solanki (1):
      mfd: max5970: Rename driver and remove wildcard

Okan Sahin (5):
      mfd: max77541: Add ADI MAX77541/MAX77540 PMIC Support
      dt-bindings: regulator: max77541: Add ADI MAX77541/MAX77540 Regulator
      regulator: max77541: Add ADI MAX77541/MAX77540 Regulator Support
      iio: adc: max77541: Add ADI MAX77541 ADC Support
      dt-bindings: mfd: max77541: Add ADI MAX77541/MAX77540

Pascal Paillet (1):
      dt-bindings: mfd: Add vref_ddr supply for STPMIC1

Rob Herring (1):
      mfd: core: Use of_property_read_reg() to parse "reg"

Sean Nyekjaer (2):
      mfd: stpmic1: Fixup main control register and bits naming
      mfd: stpmic1: Add PMIC poweroff via sys-off handler

Sebastian Reichel (9):
      clk: RK808: Reduce 'struct rk808' usage
      mfd: rk808: Convert to device managed resources
      mfd: rk808: Use dev_err_probe
      mfd: rk808: Replace 'struct i2c_client' with 'struct device'
      mfd: rk808: Split into core and i2c
      mfd: rk8xx-i2c: Use device_get_match_data
      dt-bindings: mfd: Add rk806 binding
      mfd: rk8xx: Add rk806 support
      pinctrl: rk805: Add rk806 pinctrl support

Stephan Gerhold (1):
      mfd: rt5033: Drop rt5033-battery sub-device

Tim Harvey (1):
      dt-bindings: mfd: gateworks-gsc: Remove unnecessary fan-controller nodes

Uwe Kleine-König (2):
      mfd: Switch i2c drivers back to use .probe()
      mfd: Switch two more drivers back to use struct i2c_driver::probe

Vignesh Viswanathan (1):
      dt-bindings: mfd: qcom,tcsr: Add the compatible for IPQ8074

 .mailmap                                           |    4 +
 .../devicetree/bindings/mfd/adi,max77541.yaml      |   68 ++
 .../devicetree/bindings/mfd/gateworks-gsc.yaml     |   10 -
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |    4 +
 .../devicetree/bindings/mfd/qcom,tcsr.yaml         |    1 +
 .../devicetree/bindings/mfd/richtek,rt5033.yaml    |  138 +++
 .../devicetree/bindings/mfd/rockchip,rk806.yaml    |  406 ++++++++
 .../devicetree/bindings/mfd/samsung,s5m8767.yaml   |   25 +-
 .../devicetree/bindings/mfd/st,stpmic1.yaml        |    2 +-
 .../devicetree/bindings/mfd/ti,tps6594.yaml        |  193 ++++
 .../devicetree/bindings/mfd/x-powers,axp152.yaml   |    1 +
 .../power/supply/richtek,rt5033-battery.yaml       |    2 +-
 .../power/supply/richtek,rt5033-charger.yaml       |   65 ++
 .../bindings/regulator/adi,max77541-regulator.yaml |   38 +
 drivers/clk/Kconfig                                |    2 +-
 drivers/clk/clk-rk808.c                            |   34 +-
 drivers/fpga/intel-m10-bmc-sec-update.c            |   47 +-
 drivers/hwmon/intel-m10-bmc-hwmon.c                |    1 +
 drivers/iio/adc/Kconfig                            |   11 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/max77541-adc.c                     |  194 ++++
 drivers/input/misc/Kconfig                         |    2 +-
 drivers/mfd/88pm800.c                              |    2 +-
 drivers/mfd/88pm805.c                              |    2 +-
 drivers/mfd/88pm80x.c                              |    1 -
 drivers/mfd/88pm860x-core.c                        |    3 +-
 drivers/mfd/Kconfig                                |   70 +-
 drivers/mfd/Makefile                               |    8 +-
 drivers/mfd/aat2870-core.c                         |    4 +-
 drivers/mfd/acer-ec-a500.c                         |    2 +-
 drivers/mfd/act8945a.c                             |    2 +-
 drivers/mfd/adp5520.c                              |    2 +-
 drivers/mfd/arizona-i2c.c                          |    2 +-
 drivers/mfd/as3711.c                               |    2 +-
 drivers/mfd/as3722.c                               |    2 +-
 drivers/mfd/atc260x-i2c.c                          |    2 +-
 drivers/mfd/axp20x-i2c.c                           |    6 +-
 drivers/mfd/axp20x.c                               |  219 ++++-
 drivers/mfd/bcm590xx.c                             |    2 +-
 drivers/mfd/bd9571mwv.c                            |    2 +-
 drivers/mfd/da903x.c                               |    2 +-
 drivers/mfd/da9052-i2c.c                           |    2 +-
 drivers/mfd/da9055-i2c.c                           |    2 +-
 drivers/mfd/da9062-core.c                          |    2 +-
 drivers/mfd/da9063-i2c.c                           |    2 +-
 drivers/mfd/da9150-core.c                          |    2 +-
 drivers/mfd/dln2.c                                 |    1 -
 drivers/mfd/ene-kb3930.c                           |    2 +-
 drivers/mfd/gateworks-gsc.c                        |    2 +-
 drivers/mfd/intel-lpss-acpi.c                      |    3 +
 drivers/mfd/intel-lpss.c                           |    2 +
 drivers/mfd/intel-m10-bmc-core.c                   |   90 +-
 drivers/mfd/intel-m10-bmc-pmci.c                   |    1 +
 drivers/mfd/intel-m10-bmc-spi.c                    |   15 +
 drivers/mfd/intel_soc_pmic_chtdc_ti.c              |    2 +-
 drivers/mfd/intel_soc_pmic_chtwc.c                 |    2 +-
 drivers/mfd/intel_soc_pmic_crc.c                   |    2 +-
 drivers/mfd/iqs62x.c                               |    2 +-
 drivers/mfd/khadas-mcu.c                           |    2 +-
 drivers/mfd/lm3533-core.c                          |    4 +-
 drivers/mfd/lochnagar-i2c.c                        |    2 +-
 drivers/mfd/lp3943.c                               |    2 +-
 drivers/mfd/lp873x.c                               |    2 +-
 drivers/mfd/lp87565.c                              |    2 +-
 drivers/mfd/lp8788.c                               |    2 +-
 drivers/mfd/madera-i2c.c                           |    2 +-
 drivers/mfd/max14577.c                             |    2 +-
 drivers/mfd/max77541.c                             |  224 +++++
 drivers/mfd/max77620.c                             |    2 +-
 drivers/mfd/max77650.c                             |    2 +-
 drivers/mfd/max77686.c                             |    2 +-
 drivers/mfd/max77693.c                             |    2 +-
 drivers/mfd/max77714.c                             |    2 +-
 drivers/mfd/max77843.c                             |    2 +-
 drivers/mfd/max8907.c                              |    4 +-
 drivers/mfd/max8925-i2c.c                          |    3 +-
 drivers/mfd/max8997.c                              |    2 +-
 drivers/mfd/max8998.c                              |    2 +-
 drivers/mfd/mc13xxx-i2c.c                          |    2 +-
 drivers/mfd/menelaus.c                             |    2 +-
 drivers/mfd/menf21bmc.c                            |    2 +-
 drivers/mfd/mfd-core.c                             |    6 +-
 drivers/mfd/mp2629.c                               |    2 +-
 drivers/mfd/mt6360-core.c                          |    2 +-
 drivers/mfd/mt6370.c                               |    2 +-
 drivers/mfd/ntxec.c                                |    2 +-
 drivers/mfd/palmas.c                               |    2 +-
 drivers/mfd/pcf50633-core.c                        |    2 +-
 drivers/mfd/qcom-pm8008.c                          |    4 +-
 drivers/mfd/rc5t583-irq.c                          |    2 +-
 drivers/mfd/rc5t583.c                              |    2 +-
 drivers/mfd/retu-mfd.c                             |    2 +-
 drivers/mfd/{rk808.c => rk8xx-core.c}              |  352 +++----
 drivers/mfd/rk8xx-i2c.c                            |  185 ++++
 drivers/mfd/rk8xx-spi.c                            |  124 +++
 drivers/mfd/rn5t618.c                              |    2 +-
 drivers/mfd/rohm-bd71828.c                         |    2 +-
 drivers/mfd/rohm-bd718x7.c                         |    2 +-
 drivers/mfd/rohm-bd9576.c                          |    2 +-
 drivers/mfd/rsmu_i2c.c                             |    2 +-
 drivers/mfd/rt4831.c                               |    2 +-
 drivers/mfd/rt5033.c                               |   10 +-
 drivers/mfd/rt5120.c                               |    2 +-
 drivers/mfd/sec-core.c                             |    2 +-
 drivers/mfd/si476x-i2c.c                           |    2 +-
 drivers/mfd/simple-mfd-i2c.c                       |   20 +-
 drivers/mfd/sky81452.c                             |    2 +-
 drivers/mfd/smpro-core.c                           |    2 +-
 drivers/mfd/stmfx.c                                |    9 +-
 drivers/mfd/stmpe-i2c.c                            |    2 +-
 drivers/mfd/stmpe.c                                |    4 +-
 drivers/mfd/stpmic1.c                              |   27 +-
 drivers/mfd/stw481x.c                              |    2 +-
 drivers/mfd/tc3589x.c                              |    2 +-
 drivers/mfd/ti-lmu.c                               |    2 +-
 drivers/mfd/tps6105x.c                             |    2 +-
 drivers/mfd/tps65010.c                             |    2 +-
 drivers/mfd/tps6507x.c                             |    2 +-
 drivers/mfd/tps65086.c                             |    2 +-
 drivers/mfd/tps65090.c                             |    2 +-
 drivers/mfd/tps65217.c                             |    2 +-
 drivers/mfd/tps65218.c                             |    2 +-
 drivers/mfd/tps65219.c                             |   42 +-
 drivers/mfd/tps6586x.c                             |    2 +-
 drivers/mfd/tps65910.c                             |    2 +-
 drivers/mfd/tps65912-i2c.c                         |    2 +-
 drivers/mfd/tps6594-core.c                         |  462 +++++++++
 drivers/mfd/tps6594-i2c.c                          |  244 +++++
 drivers/mfd/tps6594-spi.c                          |  129 +++
 drivers/mfd/twl-core.c                             |    2 +-
 drivers/mfd/twl6040.c                              |    4 +-
 drivers/mfd/wcd934x.c                              |   28 +-
 drivers/mfd/wl1273-core.c                          |    2 +-
 drivers/mfd/wm831x-core.c                          |    2 +-
 drivers/mfd/wm831x-i2c.c                           |    2 +-
 drivers/mfd/wm8350-i2c.c                           |    2 +-
 drivers/mfd/wm8400-core.c                          |    4 +-
 drivers/mfd/wm8994-core.c                          |    4 +-
 drivers/pinctrl/Kconfig                            |    2 +-
 drivers/pinctrl/pinctrl-rk805.c                    |  189 +++-
 drivers/power/supply/Kconfig                       |   10 +-
 drivers/power/supply/Makefile                      |    1 +
 drivers/power/supply/rt5033_battery.c              |   38 +-
 drivers/power/supply/rt5033_charger.c              |  472 +++++++++
 drivers/regulator/Kconfig                          |   13 +-
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/max77541-regulator.c             |  153 +++
 drivers/rtc/Kconfig                                |    2 +-
 include/dt-bindings/mfd/stm32f7-rcc.h              |    1 +
 include/linux/mfd/axp20x.h                         |  116 +++
 include/linux/mfd/intel-m10-bmc.h                  |   43 +-
 include/linux/mfd/{max597x.h => max5970.h}         |   16 +-
 include/linux/mfd/max77541.h                       |   91 ++
 include/linux/mfd/rk808.h                          |  417 +++++++-
 include/linux/mfd/rt5033-private.h                 |   64 +-
 include/linux/mfd/rt5033.h                         |   24 -
 include/linux/mfd/stpmic1.h                        |   12 +-
 include/linux/mfd/tps6594.h                        | 1020 ++++++++++++++++++++
 sound/soc/codecs/Kconfig                           |    2 +-
 159 files changed, 5835 insertions(+), 579 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/adi,max77541.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/adi,max77541-regulator.yaml
 create mode 100644 drivers/iio/adc/max77541-adc.c
 create mode 100644 drivers/mfd/max77541.c
 rename drivers/mfd/{rk808.c => rk8xx-core.c} (71%)
 create mode 100644 drivers/mfd/rk8xx-i2c.c
 create mode 100644 drivers/mfd/rk8xx-spi.c
 create mode 100644 drivers/mfd/tps6594-core.c
 create mode 100644 drivers/mfd/tps6594-i2c.c
 create mode 100644 drivers/mfd/tps6594-spi.c
 create mode 100644 drivers/power/supply/rt5033_charger.c
 create mode 100644 drivers/regulator/max77541-regulator.c
 rename include/linux/mfd/{max597x.h => max5970.h} (92%)
 create mode 100644 include/linux/mfd/max77541.h
 create mode 100644 include/linux/mfd/tps6594.h

-- 
Lee Jones [李琼斯]
