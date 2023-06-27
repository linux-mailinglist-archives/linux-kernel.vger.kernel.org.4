Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC54740129
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjF0Q3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjF0Q2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:28:38 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6F43AA7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:28:07 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f86fbe5e4fso6369522e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687883254; x=1690475254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1ke3IzeKzYrQp9ZFZfhbjZDZizFxhyzfl3YrdNntaE=;
        b=wlhHq/ZNcMSD8C4exH8YtH7Qal7cBHDV8ff84hWgJu6EhGI0dyHV5p7MNt5C7vq+PL
         mOKG+BocjdnmgXa/5O6fB7Wucf0JJKmbzgd42OmUdCvqKGqUBTqmBbMXFhgtGqhVAL71
         kVOimay55ys7dEYSoKiOjw8skDnesrxZJsMVYBY0/6JJJ3BDs6zTedQU2AWRdFwsDVwQ
         xgyhQQq2EszaevpN7nFoqXgxrJgok03SREPk7/qMjaLV1X8nyeQPrKIE5ADJ6LrOyv+A
         +sB1FjebmDVLARaHYLIlINZcNKhl4GoLlzv1fLtTQJkMGlQgp+vO76dZJHa0V7eNbrk6
         WE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687883254; x=1690475254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1ke3IzeKzYrQp9ZFZfhbjZDZizFxhyzfl3YrdNntaE=;
        b=Q13H6osP5cZE9UzOXfBIvEnLwo9iPITPSHtLsA6+FCsaqTXY1xSjln3wKKHUh5u6C/
         fvcCbTOH8TlPq7mRQuif+2pOmtzktp3qrAz0mV93Zl+XNR3IGTSpC3pS6YhFxir9rDqB
         JhktOF+CO5oFcV0EgxR5mOtPC55ZoudA0Sq6Q+FIXfJ7J3RejOftwmULkCn+7W4ZP0O5
         9vDnRAJ94Gjn4CD66ZV9HldoWptWB3q0eBVkq7mhHitKoISUwcBNqceN7sgoSOYF9QzT
         G2OsqkPxyLtjjeLCyQ+eIM3awnotppZJOrnzVphERzqZ10p0PHZ5NmpQktMO6G1LSjaH
         PBXw==
X-Gm-Message-State: AC+VfDy69YUFVsD8itWGkFaK2rdwOUDdmnPSCpE+AcjnyIX6StsjpAOm
        fyuqUgiH2rcizFB7Z/kqQHycMw==
X-Google-Smtp-Source: ACHHUZ4xw7PTpoxQOURVafDGLA8kLna/l8k6uc/Q2DzDkVzhz2tRfIsufsw2/nfFu/b+oANKRDC+pA==
X-Received: by 2002:a19:6909:0:b0:4f8:6d54:72fb with SMTP id e9-20020a196909000000b004f86d5472fbmr14793079lfc.62.1687883254089;
        Tue, 27 Jun 2023 09:27:34 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:fb38:10d8:d00f:89c7])
        by smtp.gmail.com with ESMTPSA id a10-20020a05600c224a00b003faef96ee78sm5098123wmm.33.2023.06.27.09.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 09:27:33 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: updates for v6.5
Date:   Tue, 27 Jun 2023 18:27:30 +0200
Message-Id: <20230627162730.117824-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Here's the pull-request with updates for this merge window from the GPIO
subsystem. We have two new drivers, some improvements to the core code, lots
of different updates to existing GPIO drivers and some dt-bindings on top.

There's nothing controversial in here and almost everything has been in next
for more than a week (95% a lot longer than this). The only thing that has
spent less time in next is a new driver so no risk of regressions.

The single merge pulls in changes that remove all usage of global GPIO numbers
from arch/arm/mach-omap.

Please pull.

Best Regards,
Bartosz Golaszewski

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v6.5

for you to fetch changes up to 0ff9f5e57c5bb45b6b807a4d466228de39d8cd2f:

  of: unittest: drop assertions for GPIO hog messages (2023-06-23 12:12:49 +0200)

----------------------------------------------------------------
gpio updates for v6.5

Core GPIO library:
- remove unused symbols
- don't spam the kernel log with messages about hogs
- remove old sysfs API cruft
- improve handling of GPIO masks

New drivers
- add a driver for the BlueField-3 GPIO controller
- add GPIO support for the TPS65219 PMIC

Driver improvements:
- extend the gpio-aggregator driver to support ramp-up/ramp-down delay
- remove unnecessary CONFIG_OF guards from gpio-aggregator
- readability improvements in gpio-tangier
- switch i2c drivers back to using probe() now that it's been converted in
  the i2c subsystem to not taking the id parameter
- remove unused inclusions of of_gpio.h in several drivers
- make pm ops static in gpio-davinci and fix a comment
- use more devres in drivers to shrink and simplify the code
- add missing include in gpio-sa1100
- add HAS_IOPORT KConfig dependency where needed
- add permissions checks before accessing pins in gpio-tegra186
- convert the gpio-zynq driver to using immutable irqchips
- preserve output settings set by the bootloader in gpio-mpc8xxx

Selftests:
- tweak the variable naming in script tests

Device tree updates:
- convert gpio-mmio and gpio-stmpe to YAML
- add parsing of GPIO hogs to gpio-vf610
- add bindings for the Cirrus EP93xx GPIO controller
- add gpio-line-names property to the gpio-pca9570 bindings
- extend the binding for x-powers,axp209 with another block

----------------------------------------------------------------
Alexander Stein (4):
      dt-bindings: gpio: Add gpio-delay binding document
      gpio: Add gpio delay driver
      gpio: Fix dependency for gpio-delay
      dt-bindings: gpio: gpio-vf610: Add parsing of hogs

Andrew Davis (4):
      gpio: tpic2810: Use devm_gpiochip_add_data() to simplify remove path
      gpio: twl4030: Use devm_gpiochip_add_data() to simplify remove path
      gpio: tps65086: Use devm_gpiochip_add_data() to simplify remove path
      gpio: sch311x: Use devm_gpiochip_add_data() to simplify remove path

Andy Shevchenko (15):
      gpiolib: Kill unused GPIOF_EXPORT and Co
      gpiolib: Kill unused GPIOF_OPEN_*
      gpiolib: Consolidate the allocated mask freeing APIs
      gpiolib: Unify allocation and initialization of GPIO valid mask
      gpiolib: Do not unexport GPIO on freeing
      gpiolib: remove unused gpio_cansleep()
      gpio: aggregator: Remove CONFIG_OF and of_match_ptr() protections
      gpio: aggregator: Support delay for setting up individual GPIOs
      gpio: aggregator: Set up a parser of delay line parameters
      gpio: delay: Remove duplicative functionality
      selftests: gpio: gpio-sim: Use same variable name for sysfs pathname
      gpio: mpc8xxx: Remove unused of_gpio.h inclusion
      gpio: xra1403: Remove unused of_gpio.h inclusion
      gpio: lpc18xx: Remove unused of_gpio.h inclusion
      gpiolib: Drop unused domain_ops memeber of GPIO IRQ chip

Arnd Bergmann (2):
      gpio: sa1100: include <mach/generic.h>
      gpio: synq: remove unused zynq_gpio_irq_reqres/zynq_gpio_irq_relres

Asmaa Mnebhi (1):
      gpio: mlxbf3: Add gpio driver support

Bartosz Golaszewski (3):
      Merge tag 'gpio-omap-descriptors-v6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio into gpio/for-next
      gpiolib: demote the hogging log messages to debug
      of: unittest: drop assertions for GPIO hog messages

Geert Uytterhoeven (1):
      dt-bindings: gpio: gpio-delay: Spelling s/curcuit/circuit/

Jerome Neanne (1):
      gpio: tps65219: add GPIO support for TPS65219 PMIC

Jonathan McDowell (1):
      dt-bindings: gpio: Add GPIO3 for AXP209 GPIO binding schema

Krzysztof Kozlowski (1):
      gpio: davinci: correct non-kerneldoc comment

Leonard Göhrs (1):
      dt-bindings: gpio: pca9570: add gpio-line-names property

Linus Walleij (14):
      dt-bindings: gpio: Convert STMPE GPIO to YAML schema
      ARM/mfd/gpio: Fixup TPS65010 regression on OMAP1 OSK1
      ARM: omap1: Drop header on AMS Delta
      ARM: omap1: Remove reliance on GPIO numbers from PalmTE
      ARM: omap1: Remove reliance on GPIO numbers from SX1
      Input: ads7846 - Convert to use software nodes
      ARM/mmc: Convert old mmci-omap to GPIO descriptors
      ARM: omap1: Fix up the Nokia 770 board device IRQs
      ARM: omap1: Make serial wakeup GPIOs use descriptors
      ARM: omap1: Exorcise the legacy GPIO header
      ARM/gpio: Push OMAP2 quirk down into TWL4030 driver
      ARM: omap2: Get USB hub reset GPIO from descriptor
      ARM: omap2: Rewrite WLAN quirk to use GPIO descriptors
      ARM/musb: omap2: Remove global GPIO numbers from TUSB6010

Manikanta Guntupalli (1):
      gpio: zynq: fix zynqmp_gpio not an immutable chip warning

Michal Smulski (1):
      gpio: mpc8xxx: latch GPIOs state on module load when configured as output

Min-Hua Chen (1):
      gpio: davinci: make davinci_gpio_dev_pm_ops static

Nikita Shubin (1):
      dt-bindings: gpio: Add Cirrus EP93xx

Niklas Schnelle (1):
      gpio: add HAS_IOPORT dependencies

Prathamesh Shete (1):
      gpio: tegra186: Check GPIO pin permission before access.

Raag Jadav (1):
      gpio: tangier: calculate number of ctx using temporary variable

Sean Anderson (1):
      dt-bindings: Convert gpio-mmio to yaml

Uwe Kleine-König (1):
      gpio: Switch i2c drivers back to use .probe()

Yang Li (2):
      gpio: ixp4xx: Use devm_platform_ioremap_resource()
      gpio: brcmstb: Use devm_platform_get_and_ioremap_resource()

 ...cm,bcm6345-gpio.yaml => brcm,bcm63xx-gpio.yaml} |  18 +-
 .../devicetree/bindings/gpio/gpio-delay.yaml       |  79 +++++++
 .../devicetree/bindings/gpio/gpio-ep9301.yaml      | 154 +++++++++++++
 .../devicetree/bindings/gpio/gpio-mmio.yaml        | 117 ++++++++++
 .../devicetree/bindings/gpio/gpio-pca9570.yaml     |   4 +
 .../devicetree/bindings/gpio/gpio-stmpe.txt        |  17 --
 .../devicetree/bindings/gpio/gpio-vf610.yaml       |   7 +
 .../bindings/gpio/ni,169445-nand-gpio.txt          |  38 ----
 .../devicetree/bindings/gpio/st,stmpe-gpio.yaml    |  53 +++++
 .../devicetree/bindings/gpio/wd,mbl-gpio.txt       |  38 ----
 .../bindings/gpio/x-powers,axp209-gpio.yaml        |   1 +
 .../bindings/mfd/brcm,bcm6318-gpio-sysctl.yaml     |   4 +-
 .../bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml    |   4 +-
 .../bindings/mfd/brcm,bcm6328-gpio-sysctl.yaml     |   4 +-
 .../bindings/mfd/brcm,bcm6358-gpio-sysctl.yaml     |   4 +-
 .../bindings/mfd/brcm,bcm6362-gpio-sysctl.yaml     |   4 +-
 .../bindings/mfd/brcm,bcm6368-gpio-sysctl.yaml     |   4 +-
 Documentation/driver-api/gpio/legacy.rst           |  31 +--
 .../translations/zh_CN/driver-api/gpio/legacy.rst  |  31 +--
 Documentation/translations/zh_TW/gpio.txt          |  31 +--
 MAINTAINERS                                        |   1 +
 arch/arm/mach-omap1/board-ams-delta.c              |   1 -
 arch/arm/mach-omap1/board-nokia770.c               | 207 ++++++++++-------
 arch/arm/mach-omap1/board-osk.c                    | 146 ++++++++----
 arch/arm/mach-omap1/board-palmte.c                 |  51 +++--
 arch/arm/mach-omap1/board-sx1-mmc.c                |   1 -
 arch/arm/mach-omap1/board-sx1.c                    |  40 +++-
 arch/arm/mach-omap1/devices.c                      |   1 -
 arch/arm/mach-omap1/gpio15xx.c                     |   1 -
 arch/arm/mach-omap1/gpio16xx.c                     |   1 -
 arch/arm/mach-omap1/irq.c                          |   1 -
 arch/arm/mach-omap1/serial.c                       |  30 +--
 arch/arm/mach-omap2/board-n8x0.c                   | 156 ++++---------
 arch/arm/mach-omap2/omap_device.c                  |   1 -
 arch/arm/mach-omap2/pdata-quirks.c                 | 132 +++++------
 arch/arm/mach-omap2/usb-tusb6010.c                 |  20 +-
 arch/arm/mach-omap2/usb-tusb6010.h                 |  12 +
 arch/arm/mach-pxa/spitz.c                          |  11 +-
 arch/m68k/include/asm/mcfgpio.h                    |   8 -
 arch/mips/alchemy/devboards/db1000.c               |  11 +-
 arch/mips/include/asm/mach-au1x00/gpio-au1000.h    |   5 -
 arch/mips/include/asm/mach-au1x00/gpio-au1300.h    |   5 -
 drivers/gpio/Kconfig                               |  55 +++--
 drivers/gpio/Makefile                              |   2 +
 drivers/gpio/gpio-adnp.c                           |   2 +-
 drivers/gpio/gpio-aggregator.c                     | 110 ++++++++-
 drivers/gpio/gpio-brcmstb.c                        |   3 +-
 drivers/gpio/gpio-davinci.c                        |   4 +-
 drivers/gpio/gpio-fxl6408.c                        |   2 +-
 drivers/gpio/gpio-gw-pld.c                         |   2 +-
 drivers/gpio/gpio-ixp4xx.c                         |   4 +-
 drivers/gpio/gpio-lpc18xx.c                        |   1 -
 drivers/gpio/gpio-max7300.c                        |   2 +-
 drivers/gpio/gpio-max732x.c                        |   2 +-
 drivers/gpio/gpio-mlxbf3.c                         | 248 +++++++++++++++++++++
 drivers/gpio/gpio-mpc8xxx.c                        |   7 +-
 drivers/gpio/gpio-pca953x.c                        |   2 +-
 drivers/gpio/gpio-pca9570.c                        |   2 +-
 drivers/gpio/gpio-pcf857x.c                        |   2 +-
 drivers/gpio/gpio-sa1100.c                         |   1 +
 drivers/gpio/gpio-sch311x.c                        |  26 +--
 drivers/gpio/gpio-tangier.c                        |   4 +-
 drivers/gpio/gpio-tegra186.c                       |  78 +++++++
 drivers/gpio/gpio-tpic2810.c                       |  27 +--
 drivers/gpio/gpio-tps65086.c                       |  27 +--
 drivers/gpio/gpio-tps65219.c                       | 185 +++++++++++++++
 drivers/gpio/gpio-ts4900.c                         |   2 +-
 drivers/gpio/gpio-twl4030.c                        |  64 +++---
 drivers/gpio/gpio-xra1403.c                        |   1 -
 drivers/gpio/gpio-zynq.c                           |  46 ++--
 drivers/gpio/gpiolib-legacy.c                      |  12 -
 drivers/gpio/gpiolib.c                             |  44 ++--
 drivers/input/touchscreen/ads7846.c                | 113 ++++------
 drivers/mfd/tps65010.c                             |  14 +-
 drivers/mmc/host/omap.c                            |  46 +++-
 drivers/of/unittest.c                              |  28 ---
 drivers/usb/musb/musb_core.c                       |   1 -
 drivers/usb/musb/musb_core.h                       |   2 -
 drivers/usb/musb/tusb6010.c                        |  53 +++--
 drivers/video/fbdev/omap/lcd_mipid.c               |  10 +
 include/linux/gpio.h                               |  23 --
 include/linux/gpio/driver.h                        |   7 -
 include/linux/mfd/tps65010.h                       |  11 +-
 include/linux/mfd/twl.h                            |   3 -
 include/linux/platform_data/lcd-mipid.h            |   2 -
 include/linux/platform_data/mmc-omap.h             |   2 -
 include/linux/spi/ads7846.h                        |   2 -
 include/linux/usb/musb.h                           |  13 --
 tools/testing/selftests/gpio/gpio-sim.sh           |   4 +-
 89 files changed, 1798 insertions(+), 988 deletions(-)
 rename Documentation/devicetree/bindings/gpio/{brcm,bcm6345-gpio.yaml => brcm,bcm63xx-gpio.yaml} (75%)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-delay.yaml
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-ep9301.yaml
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mmio.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-stmpe.txt
 delete mode 100644 Documentation/devicetree/bindings/gpio/ni,169445-nand-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/st,stmpe-gpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
 create mode 100644 arch/arm/mach-omap2/usb-tusb6010.h
 create mode 100644 drivers/gpio/gpio-mlxbf3.c
 create mode 100644 drivers/gpio/gpio-tps65219.c
