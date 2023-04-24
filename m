Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D936ED019
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjDXOOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjDXOOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:14:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE53107
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 07:14:00 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-2f6401ce8f8so2706689f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 07:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1682345639; x=1684937639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cIrOvNnDK3YOPprEDWvUP7TH6l3ojujdYbZDLboXHeQ=;
        b=C5/BaNrVHKzKCv8bmvgsFkCjXVOVAkiYvvB/XpF1MJJ7J2h2p9mqJ/pPOfrpuYcTou
         EkZiMb9FW2tFZYnaNMN93UVNTra6XQkvA6XNdP2IucNvMEPiEPmPRgbad/cnjYVOzb69
         9djjCAyKsAj6w181zL/TczEMMH0PSOhkpBe7KHt5Dst1cvEy9A6kC+IQcZZffrZVDdWV
         6zGs6feDCoZ6mUrOKkdbOINehPk0PoCbKyu1O/3o4d2mRW6CGZDBpuBJc5xpw8Jss+er
         RDC0XVG8YjNfxP+h+oF7mOj2ZhxqalxWXsbkMsDYM0oQwPQkw6ZU6kHyAbQ4wnCTIMTj
         CdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682345639; x=1684937639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cIrOvNnDK3YOPprEDWvUP7TH6l3ojujdYbZDLboXHeQ=;
        b=EqBo+lUORINDbDGGE+/9e/x4cpraApMvLWDw1mucqO5hZzt6iwXI0ZFQ0kN9l0XPrA
         4NKoRDpDH6/v5p6cUh4QMMfriHRqOz3uIzNE9oFOEukOKZ6/isfvv6dkLlMI7GyCp7Bw
         J9vbV4VeXteijhKChbLtccFbTSnbOjGiCeBkUzkSt56TCQXr8dwStCpD8Nb3prDK3B+9
         0NN0bY39wFMuAA5xWiB5Xocp6ZcWa+ezb9w8may8AAKHANYenaJFgiAkTOSJofUjWQwr
         gsZCd853EE44u0pmQGuQB+CHZHPZtH9jwfruGZec9xkAH/empHwslQUGoA6X9l39rvGV
         8PsQ==
X-Gm-Message-State: AAQBX9flBetSMZahe0f/+OTEMYDqcS47huP5IPSw6Q8yxV83kfxgp6ai
        3S/ljKPDxbr0SwUCtkYalGlJjA==
X-Google-Smtp-Source: AKy350Y4T4ghVMKPBUr+c2Hr6CiBXhCbSw31hyyVujD8ZchcuP1MHmLR+HvQCSsmpyowr4FjxHTvWg==
X-Received: by 2002:a05:6000:14d:b0:2f9:46dd:d6fa with SMTP id r13-20020a056000014d00b002f946ddd6famr9425129wrx.37.1682345639176;
        Mon, 24 Apr 2023 07:13:59 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:c9b3:7cb4:1e81:ba4])
        by smtp.gmail.com with ESMTPSA id l11-20020a5d674b000000b0030276f42f08sm9586765wrw.88.2023.04.24.07.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 07:13:58 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: updates for v6.4
Date:   Mon, 24 Apr 2023 16:13:54 +0200
Message-Id: <20230424141354.7168-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

This is the main pull-request for this merge window from the GPIO subsystem.
We have some new drivers, significant refactoring of existing intel platforms,
lots of improvements all around, mass conversion to using immutable irqchips by
drivers that had not been converted individually yet and some changes in the
core library code.

Nothing is really controversial and everything has been in next for at least
two weeks.

There are usual merges from Andy for intel platforms and one merge from the
regmap subsystem pulling in changes required by GPIO commits.

Please pull,
Bartosz

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v6.4

for you to fetch changes up to 8a4adcf67a39b3f308bb8cf686e41c0e26aa12e8:

  gpio: gpiolib: Simplify gpiochip_add_data_with_key() fwnode (2023-04-11 21:13:34 +0200)

----------------------------------------------------------------
gpio updates for v6.4-rc1

New drivers:
- add a driver for the Loongson GPIO controller
- add a driver for the fxl6408 I2C GPIO expander
- add a GPIO module containing code common for Intel Elkhart Lake and
  Merrifield platforms
- add a driver for the Intel Elkhart Lake platform reusing the code from
  the intel tangier library

GPIOLIB core:
- GPIO ACPI improvements
- simplify gpiochip_add_data_with_keys() fwnode handling
- cleanup header inclusions (remove unneeded ones, order the rest
  alphabetically)
- remove duplicate code (reuse krealloc() instead of open-coding it, drop
  a duplicated check in gpiod_find_and_request())
- reshuffle the code to remove unnecessary forward declarations
- coding style cleanups and improvements
- add a helper for accessing device fwnodes
- small updates in docs

Driver improvements:
- convert all remaining GPIO irqchip drivers to using immutable irqchips
- drop unnecessary of_match_ptr() macro expansions
- shrink the code in gpio-merrifield significantly by reusing the code from
  gpio-tangier + minor tweaks to the driver code
- remove MODULE_LICENSE() from drivers that can only be built-in
- add device-tree support to gpio-loongson1
- use new regmap features in gpio-104-dio-48e and gpio-pcie-idio-24
- minor tweaks and fixes to gpio-xra1403, gpio-sim, gpio-tegra194, gpio-omap,
  gpio-aspeed, gpio-raspberrypi-exp
- shrink code in gpio-ich and gpio-pxa
- Kconfig tweak for gpio-pmic-eic-sprd

----------------------------------------------------------------
Andrew Davis (1):
      gpio: ich: Use devm_gpiochip_add_data() to simplify remove path

Andy Shevchenko (24):
      gpio: aggregator: Add missing header(s)
      gpio: reg: Add missing header(s)
      gpio: regmap: Add missing header(s)
      gpiolib: Drop unused forward declaration from driver.h
      gpiolib: Deduplicate forward declarations in consumer.h
      gpiolib: Group forward declarations in consumer.h
      gpiolib: Clean up headers
      gpio: merrifield: Use dev_err_probe()
      gpio: merrifield: Utilise temporary variable for struct device
      gpiolib: Access device's fwnode via dev_fwnode()
      gpiolib: Get rid of gpio_bus_match() forward declaration
      gpio: sim: Deactivate device in reversed order
      gpiolib: Get rid of devprop prefix in one function
      gpiolib: Move gpiodevice_*() to gpiodev namespace
      gpiolib: Remove duplicative check in gpiod_find_and_request()
      gpiolib: Use IRQ hardware number getter instead of direct access
      Documentation: gpio: Input mode is not true Hi-Z
      powerpc/40x: Add missing select OF_GPIO_MM_GPIOCHIP
      gpio: mm-lantiq: Fix typo in the newly added header filename
      gpiolib: acpi: Move ACPI device NULL check to acpi_get_driver_gpio_data()
      gpiolib: Replace open coded krealloc()
      gpiolib: Check array_info for NULL only once in gpiod_get_array()
      gpiolib: Move gpiochip_get_data() higher in the code
      gpiolib: Add gpiochip_set_data() helper

Arnd Bergmann (8):
      gpiolib: remove empty asm/gpio.h files
      gpiolib: coldfire: remove custom asm/gpio.h
      gpiolib: remove asm-generic/gpio.h
      gpiolib: remove gpio_set_debounce()
      gpiolib: remove legacy gpio_export()
      gpiolib: split linux/gpio/driver.h out of linux/gpio.h
      gpiolib: split of_mm_gpio_chip out of linux/of_gpio.h
      mips: ar7: include linux/gpio/driver.h

Bartosz Golaszewski (3):
      Merge tag 'intel-gpio-v6.4-1' of git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel into gpio/for-next
      Merge tag 'regmap-no-status' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap into gpio/for-next
      Merge tag 'intel-gpio-v6.4-2' of git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel into gpio/for-next

Benjamin Tissoires (1):
      gpiolib: acpi: use the fwnode in acpi_gpiochip_find()

Emanuele Ghidoli (2):
      dt-bindings: gpio: add fcs,fxl6408
      gpio: fxl6408: add I2C GPIO expander driver

Geert Uytterhoeven (1):
      sh: mach-x3proto: Add missing #include <linux/gpio/driver.h>

Jiapeng Chong (1):
      gpio: loongson: Remove unnecessary .owner

Joel Stanley (1):
      gpio: aspeed: Always register the irqchip

Keguang Zhang (4):
      gpio: loongson1: Convert to SPDX identifier
      gpio: loongson1: Introduce ls1x_gpio_chip struct
      dt-bindings: gpio: Add Loongson-1 GPIO
      gpio: loongson1: Add DT support

Krzysztof Kozlowski (9):
      MAINTAINERS: gpio: xra1403: drop Semi Malinen
      gpio: ftgpio010: drop of_match_ptr for ID table
      gpio: altera: drop of_match_ptr for ID table
      gpio: rcar: drop of_match_ptr for ID table
      gpio: visconti: drop of_match_ptr for ID table
      gpio: sifive: drop of_match_ptr for ID table
      gpio: sama5d2-piobu: drop of_match_ptr for ID table
      gpio: xra1403: mark OF related data as maybe unused
      gpio: raspberrypi-exp: mark OF related data as maybe unused

Linus Walleij (31):
      gpio: pmic-eic-sprd: Move Kconfig to MFD expanders
      ARM: orion/gpio: Use the right include
      ARM: s3c64xx: Use the right include
      hte: tegra-194: Use proper includes
      gpiolib: Make the legacy <linux/gpio.h> consumer-only
      gpio: altera: Convert to immutable irq_chip
      gpio: adnp: Convert to immutable irq_chip
      gpio: aspeed: Convert to immutable irq_chip
      gpio: aspeed-sgpio: Convert to immutable irq_chip
      gpio: ath79: Convert to immutable irq_chip
      gpio: cadence: Convert to immutable irq_chip
      gpio: hisi: Convert to immutable irq_chip
      gpio: hlwd: Convert to immutable irq_chip
      gpio: idt3243x: Convert to immutable irq_chip
      gpio: msc313: Convert to immutable irq_chip
      gpio: mlxbf2: Convert to immutable irq_chip
      gpio: max732x: Convert to immutable irq_chip
      gpio: omap: Drop irq_base
      gpio: omap: Convert to immutable irq_chip
      gpio: pci-idio-16: Convert to immutable irq_chip
      gpio: pcie-idio-24: Convert to immutable irq_chip
      gpio: rda: Convert to immutable irq_chip
      gpio: siox: Convert to immutable irq_chip
      gpio: stmpe: Convert to immutable irq_chip
      gpio: thunderx: Convert to immutable irq_chip
      gpio: tqmx86: Convert to immutable irq_chip
      gpio: visconti: Convert to immutable irq_chip
      gpio: xgs-iproc: Convert to immutable irq_chip
      gpio: xilinx: Convert to immutable irq_chip
      gpio: xlp: Convert to immutable irq_chip
      gpio: gpiolib: Simplify gpiochip_add_data_with_key() fwnode

Nick Alcock (3):
      gpio: remove MODULE_LICENSE in non-modules
      kbuild, gpio: remove MODULE_LICENSE in non-modules
      kbuild, gpio: gpio-aspeed-sgpio: remove MODULE_LICENSE in non-modules

Pandith N (3):
      gpio: tangier: Introduce Intel Tangier GPIO driver
      gpio: merrifield: Adapt to Intel Tangier GPIO driver
      gpio: elkhartlake: Introduce Intel Elkhart Lake PSE GPIO

Rob Herring (1):
      gpio: Use of_property_read_bool() for boolean properties

Tom Rix (1):
      gpio: pxa: remove unused gpio_is_pxa_type function

Trevor Woerner (1):
      dt-bindings: gpio.txt: expand gpio-line-names recommendations

Werner Sembach (1):
      gpiolib: acpi: Add a ignore wakeup quirk for Clevo NL5xNU

William Breathitt Gray (4):
      regmap-irq: Add no_status support
      gpio: 104-dio-48e: Utilize mask_buf_def in handle_mask_sync() callback
      gpio: pcie-idio-24: Prune superfluous license boilerplate
      gpio: 104-dio-48e: Utilize no_status regmap-irq flag

Yinbo Zhu (3):
      dt-bindings: gpio: add loongson gpio
      gpio: loongson: add gpio driver support
      gpio: loongson: fixup the warning about OF_GPIO direct dependencies

 Documentation/admin-guide/gpio/sysfs.rst           |   2 +-
 .../devicetree/bindings/gpio/fcs,fxl6408.yaml      |  58 +++
 Documentation/devicetree/bindings/gpio/gpio.txt    |  41 +-
 .../devicetree/bindings/gpio/loongson,ls-gpio.yaml | 126 +++++
 .../bindings/gpio/loongson,ls1x-gpio.yaml          |  49 ++
 Documentation/driver-api/gpio/driver.rst           |   8 +-
 Documentation/driver-api/gpio/legacy.rst           |  23 -
 .../translations/zh_CN/driver-api/gpio/legacy.rst  |  20 -
 Documentation/translations/zh_TW/gpio.txt          |  19 -
 MAINTAINERS                                        |  11 +-
 arch/arm/Kconfig                                   |   1 -
 arch/arm/include/asm/gpio.h                        |  21 -
 arch/arm/mach-omap1/irq.c                          |   1 +
 arch/arm/mach-omap2/pdata-quirks.c                 |   9 +-
 arch/arm/mach-orion5x/board-rd88f5182.c            |   1 +
 arch/arm/mach-s3c/s3c64xx.c                        |   2 +-
 arch/arm/mach-sa1100/assabet.c                     |   1 +
 arch/arm/plat-orion/gpio.c                         |   5 +-
 arch/m68k/Kconfig.cpu                              |   1 -
 arch/m68k/include/asm/gpio.h                       |  95 ----
 arch/m68k/include/asm/mcfgpio.h                    |   2 +-
 arch/mips/ar7/gpio.c                               |   2 +-
 arch/powerpc/platforms/40x/Kconfig                 |   1 +
 arch/powerpc/platforms/44x/Kconfig                 |   1 +
 arch/powerpc/platforms/4xx/gpio.c                  |   2 +-
 arch/powerpc/platforms/8xx/Kconfig                 |   1 +
 arch/powerpc/platforms/8xx/cpm1.c                  |   2 +-
 arch/powerpc/platforms/Kconfig                     |   2 +
 arch/powerpc/sysdev/cpm_common.c                   |   2 +-
 arch/sh/Kconfig                                    |   1 -
 arch/sh/boards/board-magicpanelr2.c                |   1 +
 arch/sh/boards/mach-ap325rxa/setup.c               |   7 +-
 arch/sh/boards/mach-x3proto/setup.c                |   2 +-
 arch/sh/include/asm/gpio.h                         |  45 --
 drivers/base/regmap/regmap-irq.c                   |  22 +-
 drivers/gpio/Kconfig                               |  81 +++-
 drivers/gpio/Makefile                              |   4 +
 drivers/gpio/TODO                                  |  15 +-
 drivers/gpio/gpio-104-dio-48e.c                    |  11 +-
 drivers/gpio/gpio-adnp.c                           |   9 +-
 drivers/gpio/gpio-aggregator.c                     |   9 +-
 drivers/gpio/gpio-altera.c                         |  29 +-
 drivers/gpio/gpio-aspeed-sgpio.c                   |  45 +-
 drivers/gpio/gpio-aspeed.c                         |  82 ++--
 drivers/gpio/gpio-ath79.c                          |   8 +-
 drivers/gpio/gpio-cadence.c                        |  10 +-
 drivers/gpio/gpio-davinci.c                        |   2 -
 drivers/gpio/gpio-elkhartlake.c                    |  90 ++++
 drivers/gpio/gpio-ftgpio010.c                      |   2 +-
 drivers/gpio/gpio-fxl6408.c                        | 158 ++++++
 drivers/gpio/gpio-hisi.c                           |  25 +-
 drivers/gpio/gpio-hlwd.c                           |  33 +-
 drivers/gpio/gpio-ich.c                            |  10 +-
 drivers/gpio/gpio-idt3243x.c                       |  11 +-
 drivers/gpio/gpio-imx-scu.c                        |   1 -
 drivers/gpio/gpio-loongson-64bit.c                 | 238 +++++++++
 drivers/gpio/gpio-loongson1.c                      |  71 +--
 drivers/gpio/gpio-max732x.c                        |   8 +-
 drivers/gpio/gpio-merrifield.c                     | 453 ++---------------
 drivers/gpio/gpio-mlxbf2.c                         |  32 +-
 drivers/gpio/gpio-mm-lantiq.c                      |   2 +-
 drivers/gpio/gpio-mpc5200.c                        |   2 +-
 drivers/gpio/gpio-msc313.c                         |  26 +-
 drivers/gpio/gpio-mxs.c                            |   1 -
 drivers/gpio/gpio-omap.c                           |  83 ++--
 drivers/gpio/gpio-pci-idio-16.c                    |  12 +-
 drivers/gpio/gpio-pcie-idio-24.c                   |  21 +-
 drivers/gpio/gpio-pxa.c                            |   5 -
 drivers/gpio/gpio-raspberrypi-exp.c                |   2 +-
 drivers/gpio/gpio-rcar.c                           |   2 +-
 drivers/gpio/gpio-rda.c                            |  23 +-
 drivers/gpio/gpio-reg.c                            |  12 +-
 drivers/gpio/gpio-regmap.c                         |  12 +-
 drivers/gpio/gpio-sama5d2-piobu.c                  |   2 +-
 drivers/gpio/gpio-sifive.c                         |   2 +-
 drivers/gpio/gpio-sim.c                            |   2 +-
 drivers/gpio/gpio-siox.c                           |  75 +--
 drivers/gpio/gpio-stmpe.c                          |   8 +-
 drivers/gpio/gpio-stp-xway.c                       |   2 +-
 drivers/gpio/gpio-tangier.c                        | 536 +++++++++++++++++++++
 drivers/gpio/gpio-tangier.h                        | 117 +++++
 drivers/gpio/gpio-tb10x.c                          |   2 +-
 drivers/gpio/gpio-thunderx.c                       |  26 +-
 drivers/gpio/gpio-tqmx86.c                         |  28 +-
 drivers/gpio/gpio-visconti.c                       |  52 +-
 drivers/gpio/gpio-xgs-iproc.c                      |  32 +-
 drivers/gpio/gpio-xilinx.c                         |  23 +-
 drivers/gpio/gpio-xlp.c                            |  14 +-
 drivers/gpio/gpio-xra1403.c                        |   2 +-
 drivers/gpio/gpiolib-acpi.c                        |  36 +-
 drivers/gpio/gpiolib-acpi.h                        |   1 -
 drivers/gpio/gpiolib-of.c                          |   9 +-
 drivers/gpio/gpiolib-of.h                          |   1 -
 drivers/gpio/gpiolib-swnode.c                      |   5 +-
 drivers/gpio/gpiolib-sysfs.c                       |  25 +-
 drivers/gpio/gpiolib.c                             | 173 ++++---
 drivers/hte/hte-tegra194-test.c                    |  10 +-
 drivers/input/touchscreen/ads7846.c                |   5 +-
 drivers/media/pci/sta2x11/sta2x11_vip.c            |  10 +-
 drivers/net/ieee802154/ca8210.c                    |   3 +-
 .../net/wireless/broadcom/brcm80211/brcmsmac/led.c |   1 +
 drivers/pinctrl/core.c                             |   1 -
 drivers/soc/fsl/qe/gpio.c                          |   2 +-
 include/asm-generic/gpio.h                         | 147 ------
 include/linux/gpio.h                               | 104 ++--
 include/linux/gpio/consumer.h                      |  24 +-
 include/linux/gpio/driver.h                        |  31 +-
 include/linux/gpio/legacy-of-mm-gpiochip.h         |  36 ++
 include/linux/mfd/ucb1x00.h                        |   1 +
 include/linux/of_gpio.h                            |  21 -
 include/linux/regmap.h                             |   2 +
 111 files changed, 2428 insertions(+), 1370 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/fcs,fxl6408.yaml
 create mode 100644 Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/gpio/loongson,ls1x-gpio.yaml
 delete mode 100644 arch/arm/include/asm/gpio.h
 delete mode 100644 arch/m68k/include/asm/gpio.h
 delete mode 100644 arch/sh/include/asm/gpio.h
 create mode 100644 drivers/gpio/gpio-elkhartlake.c
 create mode 100644 drivers/gpio/gpio-fxl6408.c
 create mode 100644 drivers/gpio/gpio-loongson-64bit.c
 create mode 100644 drivers/gpio/gpio-tangier.c
 create mode 100644 drivers/gpio/gpio-tangier.h
 delete mode 100644 include/asm-generic/gpio.h
 create mode 100644 include/linux/gpio/legacy-of-mm-gpiochip.h
