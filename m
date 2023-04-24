Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A64F6ECCB5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjDXNKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjDXNKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:10:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67ADC4C21
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 06:10:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC9A3621CD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 13:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56A1C4339B;
        Mon, 24 Apr 2023 13:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682341836;
        bh=B87UNh7MwUc3DUkx0NtHjBcjASqmrjUUFzwVOqU9FUg=;
        h=From:To:Cc:Subject:Date:From;
        b=qF6lnFwBF0qlqf5/jqXCqGGyR8lGEEECwziq5XoKmwZGCEK5oWFaTiJP1h+h0jKpO
         MeQgqx972rMa3bXFratl8PURYv8sHoYZiuQkk6k3A3gYL2mH1218cnptH0mA3BgRY0
         Sa5O23VGet4pfZAs+/iWsK9jeG/igoqbD9GKHZer+Avz2uJFybNjf3YupBrWlYLtxK
         X6P6B5vfFcqdXcQJ1H/F9Na/FRU/7ZyhgifW/D/lI+uV8aT2pw84EMuvXqpqIm5BGm
         4kVdYKn8P75qO9FLXFxfYA17Hv3jGLkHT1BKriCH83S1Nq4K4OtcNoU+TbHBMMr1uH
         RjnQU+szMQ6BQ==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v6.4
Date:   Mon, 24 Apr 2023 14:10:23 +0100
Message-Id: <20230424131035.E56A1C4339B@smtp.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit c5d5b55b3c1a314137a251efc1001dfd435c6242:

  regulator: fan53555: Fix wrong TCS_SLEW_MASK (2023-04-06 21:11:24 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.4

for you to fetch changes up to ed479907ff79007548c3bd1aed387f8cf0a62065:

  regulator: dt-bindings: qcom,rpmh: Combine PM6150L and PM8150L if-then (2023-04-18 14:02:31 +0100)

----------------------------------------------------------------
regulator: Updates for v6.4

A fairly quiet release, there were some cleanup and a couple of new
devices but the biggest change was converting most of the drivers to use
asynchronous probe.  This allows us to ramp up multiple regulators in
parallel during boot which can have a noticable impact on modern
systems.

 - Update of drivers to PROBE_PREFER_ASYNCHRONOUS to mitigate issues
   with ramp times slowing down boots.
 - Convert to void remove callbacks.
 - Support for voltage monitoring on DA9063
 - Support for Qualcomm PMC8180 and PMM8654au, Richtek RT4803 and
   RT5739, Rockchip RK860x,

----------------------------------------------------------------
Bartosz Golaszewski (2):
      regulator: qcom-rpmh: add support for pmm8654au regulators
      regulator: qcom,rpmh: add compatible for pmm8654au RPMH

Benjamin Bara (3):
      regulator: da9063: add voltage monitoring registers
      regulator: da9063: implement setter for voltage monitoring
      dt-bindings: mfd: dlg,da9063: document voltage monitoring

Charles Keepax (2):
      regulator: arizona-ldo1: Use PROBE_FORCE_SYNCHRONOUS
      regulator: arizona-micsupp: Use PROBE_FORCE_SYNCHRONOUS

ChiYuan Huang (4):
      dt-bindings: regulator: Add Richtek RT5739
      regulator: Add support for Richtek RT5739 voltage regulator
      regulator: dt-bindings: Add Richtek RT4803
      regulator: Add Richtek RT4803 boost regulator

Cristian Ciocaltea (6):
      regulator: dt-bindings: fcs,fan53555: Add support for RK860X
      regulator: fan53555: Remove unused *_SLEW_SHIFT definitions
      regulator: fan53555: Make use of the bit macros
      regulator: fan53555: Improve vsel_mask computation
      regulator: fan53555: Use dev_err_probe
      regulator: fan53555: Add support for RK860X

Devi Priya (2):
      regulator: qcom_smd: Add s1 sub-node to mp5496 regulator
      regulator: qcom_smd: Add MP5496 S1 regulator

Douglas Anderson (12):
      regulator: core: Shorten off-on-delay-us for always-on/boot-on by time since booted
      regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in 4.14
      regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers between 4.14 and 4.19
      regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers between 4.19 and 5.4
      regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers between 5.4 and 5.10
      regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers between 5.10 and 5.15
      regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers between 5.15 and 6.1
      regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers that are newer than 6.1
      regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS"
      regulator: core: Consistently set mutex_owner when using ww_mutex_lock_slow()
      regulator: core: Avoid lockdep reports when resolving supplies
      regulator: core: Make regulator_lock_two() logic easier to follow

Geert Uytterhoeven (1):
      regulator: rt5739: Spelling s/Rcihtek/Richtek/

Krzysztof Kozlowski (6):
      regulator: lp872x: Mark OF related data as maybe unused
      regulator: max20086: Mark OF related data as maybe unused
      regulator: mp8859: Mark OF related data as maybe unused
      regulator: mt6397-regulator: Mark OF related data as maybe unused
      regulator: dt-bindings: qcom,rpmh: Correct PM8550 family supplies
      regulator: dt-bindings: qcom,rpmh: Combine PM6150L and PM8150L if-then

Marek Szyprowski (2):
      regulator: wm8994: Use PROBE_FORCE_SYNCHRONOUS
      regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS

Mark Brown (4):
      Merge tag 'v6.3-rc2' into regulator-6.4 to fix clock related boot issues
      regulator: Set PROBE_PREFER_ASYNCHRONOUS for
      Add support for Rockchip RK860X regulators
      regulator: da9063: disable unused voltage monitors

Peng Fan (1):
      dt-bindings: regulator: pf8x00: Remove restrictions for regulator-name

Rob Herring (3):
      regulator: Use of_property_present() for testing DT property presence
      regulator: Use of_property_read_bool() for boolean properties
      regulator: dt-bindings: Drop unneeded quotes

Vinod Koul (1):
      regulator: dt-bindings: qcom,rpmh: Add compatible for PMC8180

YAN SHI (1):
      regulator: stm32-pwr: fix of_iomap leak

 .../devicetree/bindings/mfd/dlg,da9063.yaml        |  17 +-
 .../bindings/regulator/anatop-regulator.yaml       |  22 +-
 .../devicetree/bindings/regulator/dlg,da9121.yaml  |   2 +-
 .../bindings/regulator/fcs,fan53555.yaml           |  21 +-
 .../bindings/regulator/fixed-regulator.yaml        |   2 +-
 .../regulator/google,cros-ec-regulator.yaml        |   2 +-
 .../bindings/regulator/gpio-regulator.yaml         |   2 +-
 .../bindings/regulator/max77650-regulator.yaml     |   2 +-
 .../devicetree/bindings/regulator/max8660.yaml     |   2 +-
 .../devicetree/bindings/regulator/max8893.yaml     |   2 +-
 .../regulator/mediatek,mt6331-regulator.yaml       |  12 +-
 .../regulator/mediatek,mt6332-regulator.yaml       |   4 +-
 .../devicetree/bindings/regulator/mps,mp5416.yaml  |   4 +-
 .../devicetree/bindings/regulator/mps,mp886x.yaml  |   2 +-
 .../devicetree/bindings/regulator/mps,mpq7920.yaml |   6 +-
 .../bindings/regulator/mt6315-regulator.yaml       |   2 +-
 .../bindings/regulator/mt6359-regulator.yaml       |  16 +-
 .../bindings/regulator/mt6360-regulator.yaml       |   4 +-
 .../bindings/regulator/nxp,pca9450-regulator.yaml  |   4 +-
 .../bindings/regulator/nxp,pf8x00-regulator.yaml   |  21 +-
 .../devicetree/bindings/regulator/pfuze100.yaml    |   8 +-
 .../bindings/regulator/qcom,rpmh-regulator.yaml    |  45 ++--
 .../bindings/regulator/qcom,smd-rpm-regulator.yaml |   2 +-
 ...pberrypi,7inch-touchscreen-panel-regulator.yaml |   2 +-
 .../devicetree/bindings/regulator/regulator.yaml   |  22 +-
 .../bindings/regulator/richtek,rt4803.yaml         |  68 +++++
 .../bindings/regulator/richtek,rt5739.yaml         |  72 +++++
 .../regulator/richtek,rt6245-regulator.yaml        |   8 +-
 .../regulator/richtek,rtmv20-regulator.yaml        |   2 +-
 .../bindings/regulator/rohm,bd71815-regulator.yaml |   8 +-
 .../bindings/regulator/rohm,bd71828-regulator.yaml |   8 +-
 .../bindings/regulator/rohm,bd71837-regulator.yaml |   6 +-
 .../bindings/regulator/rohm,bd71847-regulator.yaml |   6 +-
 .../bindings/regulator/rohm,bd9576-regulator.yaml  |   2 +-
 .../regulator/socionext,uniphier-regulator.yaml    |   2 +-
 .../bindings/regulator/st,stm32-booster.yaml       |   4 +-
 .../bindings/regulator/st,stm32-vrefbuf.yaml       |   2 +-
 .../bindings/regulator/st,stm32mp1-pwr-reg.yaml    |   2 +-
 .../devicetree/bindings/regulator/ti,tps62360.yaml |   2 +-
 .../regulator/vqmmc-ipq4019-regulator.yaml         |   2 +-
 .../devicetree/bindings/regulator/wlf,arizona.yaml |   6 +-
 drivers/regulator/88pg86x.c                        |   1 +
 drivers/regulator/88pm800-regulator.c              |   1 +
 drivers/regulator/88pm8607.c                       |   1 +
 drivers/regulator/Kconfig                          |  23 ++
 drivers/regulator/Makefile                         |   2 +
 drivers/regulator/aat2870-regulator.c              |   1 +
 drivers/regulator/ab8500-ext.c                     |   1 +
 drivers/regulator/ab8500.c                         |   1 +
 drivers/regulator/act8865-regulator.c              |   1 +
 drivers/regulator/act8945a-regulator.c             |   1 +
 drivers/regulator/ad5398.c                         |   1 +
 drivers/regulator/anatop-regulator.c               |   1 +
 drivers/regulator/arizona-ldo1.c                   |   2 +
 drivers/regulator/arizona-micsupp.c                |   2 +
 drivers/regulator/as3711-regulator.c               |   1 +
 drivers/regulator/as3722-regulator.c               |   1 +
 drivers/regulator/atc260x-regulator.c              |   1 +
 drivers/regulator/axp20x-regulator.c               |   1 +
 drivers/regulator/bcm590xx-regulator.c             |   1 +
 drivers/regulator/bd71815-regulator.c              |   9 +-
 drivers/regulator/bd71828-regulator.c              |   3 +-
 drivers/regulator/bd718x7-regulator.c              |   1 +
 drivers/regulator/bd9571mwv-regulator.c            |   1 +
 drivers/regulator/bd9576-regulator.c               |   1 +
 drivers/regulator/core.c                           |  93 ++++++-
 drivers/regulator/cpcap-regulator.c                |   1 +
 drivers/regulator/cros-ec-regulator.c              |   1 +
 drivers/regulator/da903x-regulator.c               |   1 +
 drivers/regulator/da9052-regulator.c               |   1 +
 drivers/regulator/da9055-regulator.c               |   1 +
 drivers/regulator/da9062-regulator.c               |   1 +
 drivers/regulator/da9063-regulator.c               | 148 +++++++++--
 drivers/regulator/da9121-regulator.c               |   1 +
 drivers/regulator/da9210-regulator.c               |   1 +
 drivers/regulator/da9211-regulator.c               |   1 +
 drivers/regulator/db8500-prcmu.c                   |   1 +
 drivers/regulator/dummy.c                          |   1 +
 drivers/regulator/fan53555.c                       | 193 +++++++++++---
 drivers/regulator/fan53880.c                       |   1 +
 drivers/regulator/fixed.c                          |   3 +-
 drivers/regulator/gpio-regulator.c                 |   3 +-
 drivers/regulator/hi6421-regulator.c               |   1 +
 drivers/regulator/hi6421v530-regulator.c           |   1 +
 drivers/regulator/hi6421v600-regulator.c           |   1 +
 drivers/regulator/hi655x-regulator.c               |   1 +
 drivers/regulator/isl6271a-regulator.c             |   1 +
 drivers/regulator/isl9305.c                        |   1 +
 drivers/regulator/lm363x-regulator.c               |   1 +
 drivers/regulator/lochnagar-regulator.c            |   1 +
 drivers/regulator/lp3971.c                         |   1 +
 drivers/regulator/lp3972.c                         |   1 +
 drivers/regulator/lp872x.c                         |   6 +-
 drivers/regulator/lp873x-regulator.c               |   1 +
 drivers/regulator/lp8755.c                         |   1 +
 drivers/regulator/lp87565-regulator.c              |   1 +
 drivers/regulator/lp8788-buck.c                    |   1 +
 drivers/regulator/lp8788-ldo.c                     |   2 +
 drivers/regulator/ltc3589.c                        |   1 +
 drivers/regulator/ltc3676.c                        |   1 +
 drivers/regulator/max14577-regulator.c             |   1 +
 drivers/regulator/max1586.c                        |   1 +
 drivers/regulator/max20086-regulator.c             |   3 +-
 drivers/regulator/max20411-regulator.c             |   1 +
 drivers/regulator/max597x-regulator.c              |   1 +
 drivers/regulator/max77620-regulator.c             |   1 +
 drivers/regulator/max77650-regulator.c             |   1 +
 drivers/regulator/max77686-regulator.c             |   1 +
 drivers/regulator/max77693-regulator.c             |   1 +
 drivers/regulator/max77802-regulator.c             |   1 +
 drivers/regulator/max77826-regulator.c             |   1 +
 drivers/regulator/max8649.c                        |   1 +
 drivers/regulator/max8660.c                        |   1 +
 drivers/regulator/max8893.c                        |   1 +
 drivers/regulator/max8907-regulator.c              |   1 +
 drivers/regulator/max8925-regulator.c              |   1 +
 drivers/regulator/max8952.c                        |   1 +
 drivers/regulator/max8973-regulator.c              |   1 +
 drivers/regulator/max8997-regulator.c              |  12 +-
 drivers/regulator/max8998.c                        |   4 +-
 drivers/regulator/mc13783-regulator.c              |   1 +
 drivers/regulator/mc13892-regulator.c              |   1 +
 drivers/regulator/mcp16502.c                       |   1 +
 drivers/regulator/mp5416.c                         |   1 +
 drivers/regulator/mp8859.c                         |   3 +-
 drivers/regulator/mp886x.c                         |   1 +
 drivers/regulator/mpq7920.c                        |   1 +
 drivers/regulator/mt6311-regulator.c               |   1 +
 drivers/regulator/mt6315-regulator.c               |   1 +
 drivers/regulator/mt6323-regulator.c               |   1 +
 drivers/regulator/mt6331-regulator.c               |   1 +
 drivers/regulator/mt6332-regulator.c               |   1 +
 drivers/regulator/mt6357-regulator.c               |   1 +
 drivers/regulator/mt6358-regulator.c               |   1 +
 drivers/regulator/mt6359-regulator.c               |   1 +
 drivers/regulator/mt6360-regulator.c               |   1 +
 drivers/regulator/mt6370-regulator.c               |   1 +
 drivers/regulator/mt6380-regulator.c               |   1 +
 drivers/regulator/mt6397-regulator.c               |   3 +-
 drivers/regulator/mtk-dvfsrc-regulator.c           |   1 +
 drivers/regulator/palmas-regulator.c               |   1 +
 drivers/regulator/pbias-regulator.c                |   1 +
 drivers/regulator/pca9450-regulator.c              |   1 +
 drivers/regulator/pcap-regulator.c                 |   1 +
 drivers/regulator/pcf50633-regulator.c             |   1 +
 drivers/regulator/pf8x00-regulator.c               |   1 +
 drivers/regulator/pfuze100-regulator.c             |   1 +
 drivers/regulator/pv88060-regulator.c              |   1 +
 drivers/regulator/pv88080-regulator.c              |   1 +
 drivers/regulator/pv88090-regulator.c              |   1 +
 drivers/regulator/pwm-regulator.c                  |   3 +-
 drivers/regulator/qcom-labibb-regulator.c          |   1 +
 drivers/regulator/qcom-rpmh-regulator.c            |  56 ++++
 drivers/regulator/qcom_rpm-regulator.c             |   1 +
 drivers/regulator/qcom_smd-regulator.c             |   6 +-
 drivers/regulator/qcom_spmi-regulator.c            |   1 +
 drivers/regulator/qcom_usb_vbus-regulator.c        |   1 +
 drivers/regulator/rc5t583-regulator.c              |   1 +
 drivers/regulator/rk808-regulator.c                |   3 +-
 drivers/regulator/rn5t618-regulator.c              |   1 +
 drivers/regulator/rpi-panel-attiny-regulator.c     |   1 +
 drivers/regulator/rt4801-regulator.c               |   1 +
 drivers/regulator/rt4803.c                         | 216 +++++++++++++++
 drivers/regulator/rt4831-regulator.c               |   1 +
 drivers/regulator/rt5033-regulator.c               |   1 +
 drivers/regulator/rt5120-regulator.c               |   1 +
 drivers/regulator/rt5190a-regulator.c              |   1 +
 drivers/regulator/rt5739.c                         | 291 +++++++++++++++++++++
 drivers/regulator/rt5759-regulator.c               |   1 +
 drivers/regulator/rt6160-regulator.c               |   1 +
 drivers/regulator/rt6190-regulator.c               |   1 +
 drivers/regulator/rt6245-regulator.c               |   1 +
 drivers/regulator/rtmv20-regulator.c               |   1 +
 drivers/regulator/rtq2134-regulator.c              |   1 +
 drivers/regulator/rtq6752-regulator.c              |   1 +
 drivers/regulator/s2mpa01.c                        |   1 +
 drivers/regulator/s2mps11.c                        |   1 +
 drivers/regulator/s5m8767.c                        |  18 +-
 drivers/regulator/sc2731-regulator.c               |   1 +
 drivers/regulator/sky81452-regulator.c             |   1 +
 drivers/regulator/slg51000-regulator.c             |   1 +
 drivers/regulator/sm5703-regulator.c               |   1 +
 drivers/regulator/stm32-booster.c                  |   1 +
 drivers/regulator/stm32-pwr.c                      |   8 +-
 drivers/regulator/stm32-vrefbuf.c                  |   1 +
 drivers/regulator/stpmic1_regulator.c              |   3 +-
 drivers/regulator/stw481x-vmmc.c                   |   1 +
 drivers/regulator/sy7636a-regulator.c              |   1 +
 drivers/regulator/sy8106a-regulator.c              |   1 +
 drivers/regulator/sy8824x.c                        |   1 +
 drivers/regulator/sy8827n.c                        |   1 +
 drivers/regulator/ti-abb-regulator.c               |   1 +
 drivers/regulator/tps51632-regulator.c             |   1 +
 drivers/regulator/tps6105x-regulator.c             |   1 +
 drivers/regulator/tps62360-regulator.c             |  16 +-
 drivers/regulator/tps6286x-regulator.c             |   1 +
 drivers/regulator/tps65023-regulator.c             |   1 +
 drivers/regulator/tps6507x-regulator.c             |   1 +
 drivers/regulator/tps65086-regulator.c             |   1 +
 drivers/regulator/tps65090-regulator.c             |   1 +
 drivers/regulator/tps65132-regulator.c             |   1 +
 drivers/regulator/tps65217-regulator.c             |   1 +
 drivers/regulator/tps65218-regulator.c             |   1 +
 drivers/regulator/tps65219-regulator.c             |   1 +
 drivers/regulator/tps6524x-regulator.c             |   1 +
 drivers/regulator/tps6586x-regulator.c             |   1 +
 drivers/regulator/tps65910-regulator.c             |   1 +
 drivers/regulator/tps65912-regulator.c             |   1 +
 drivers/regulator/tps68470-regulator.c             |   1 +
 drivers/regulator/twl-regulator.c                  |   1 +
 drivers/regulator/twl6030-regulator.c              |   3 +-
 drivers/regulator/uniphier-regulator.c             |   1 +
 drivers/regulator/userspace-consumer.c             |   1 +
 drivers/regulator/vctrl-regulator.c                |   1 +
 drivers/regulator/vexpress-regulator.c             |   1 +
 drivers/regulator/virtual.c                        |   1 +
 drivers/regulator/vqmmc-ipq4019-regulator.c        |   1 +
 drivers/regulator/wm831x-dcdc.c                    |   4 +
 drivers/regulator/wm831x-isink.c                   |   1 +
 drivers/regulator/wm831x-ldo.c                     |   3 +
 drivers/regulator/wm8350-regulator.c               |   1 +
 drivers/regulator/wm8400-regulator.c               |   1 +
 drivers/regulator/wm8994-regulator.c               |   1 +
 include/linux/mfd/da9063/registers.h               |  23 ++
 224 files changed, 1475 insertions(+), 271 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt4803.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml
 create mode 100644 drivers/regulator/rt4803.c
 create mode 100644 drivers/regulator/rt5739.c
