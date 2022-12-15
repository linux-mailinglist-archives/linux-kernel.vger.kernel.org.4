Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4D964DA4B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiLOLbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiLOLa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:30:56 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08007B862
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:30:54 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m19so13519073wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yqjjVV+AnSEqYMLa5nzrvWGa23UXYO67h3YNWYZSv0E=;
        b=cs/ZrGnsaWOPSYeFGTY+m/1PduDlUwKXE7/JChnU3Ax791lUJTLA94O25d2y577XVK
         23UuHuXwtaKlrvJj2K96v3mQDvhwr5uaWK/wy/UH6E4pTxaMz3KbfxHSHsxF6LkSssKS
         v9sLbT6DCf24IAnCN1Y1jZKi4m1nfvfYC3c4lLrkb5Y6Dl/zUrDVgXs6WW+9ntIpWxNd
         1vDxPxqV04LE+00Sp+aWJQOUPk26Ugy/4ckllzlgBv9Da4bFUi73OGR8udqi7ZaRRWUU
         9hTJ0KviUHcJwEdIrbPrNAkyxZCnLyqhBuoneuVv3UbYR05FmXCILZKZKzw1GujxAs2J
         z2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqjjVV+AnSEqYMLa5nzrvWGa23UXYO67h3YNWYZSv0E=;
        b=uVAvGgbWLMlXrgE9Ng7SK/X65swFkWDi6Daz34p/Twyo2FSbpZZU/kaVC8kwSV1/RJ
         4wJqLWYuKyuWIHjS8iuRv/k3vfxv9MDJSI+xO5X4YtE1kfjikoQQiLBVUzzpnwwdj+vh
         LyD9SExAA38yg5cfdI101QH+yGhcIZnxbIQC4D8YzlhO4uR9gVCa2PgRVJjQea3evmxZ
         VPXRbFRxrkgVsIbMOY/JjpB+KJqORK4YamNgYvIPtDJRpcYi01GoieCkMLvGSHZD3SDM
         dU4JkbaVqBfXQz528BLrFwepAchJz7UyJ3KoXEWwiAovI/LFU8p9SWiOQQ8HCcMPvxXo
         rlqg==
X-Gm-Message-State: ANoB5pnfVIrsbR296PyGBAswq4H9hncmrWzZ2piyS5h559CNz9f1g0Os
        tQvs46FZj8fXb6f/lXUrZ6XMzA==
X-Google-Smtp-Source: AA0mqf5ZUMvthOShKpNjfKJkmnBQkUKxHU38cUBmKELK1nSg1xbk8jbx+IIW4HafltdIp6gOuXuvTQ==
X-Received: by 2002:a05:600c:1685:b0:3d1:f687:1fd0 with SMTP id k5-20020a05600c168500b003d1f6871fd0mr21305490wmn.12.1671103852458;
        Thu, 15 Dec 2022 03:30:52 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6d31:7ccd:7de8:e28c])
        by smtp.gmail.com with ESMTPSA id l5-20020a1c7905000000b003d1e4120700sm6522815wme.41.2022.12.15.03.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 03:30:52 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: updates for v6.2
Date:   Thu, 15 Dec 2022 12:30:50 +0100
Message-Id: <20221215113050.34875-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Here's the pull-request with updates for the next release from the GPIO
subsystem.

We have a new GPIO multiplexer driver, bunch of driver updates and refactoring
in the core GPIO library. Details are in the signed tag.

There are two merges, one is the regular one from Andy with ACPI changes, the
second pulls in the code from i2c that introduces the i2c_client_get_device_id()
helper used in commits converting i2c driver to using .probe_new().

I've also included the uAPI fixes for the user-space induced NULL-pointer
dereferences with the changes you requested (don't use semaphore trylocks).

Please pull,
Bartosz Golaszewski

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v6.2

for you to fetch changes up to 11e47bbd700f31bd1ee9f8863381bc9e741c0e97:

  gpio: sim: set a limit on the number of GPIOs (2022-12-14 09:53:20 +0100)

----------------------------------------------------------------
gpio: updates for v6.2

GPIO core:
- teach gpiolib to work with software nodes for HW description
- remove ARCH_NR_GPIOS treewide as we no longer impose any limit on the number
  of GPIOS since the allocation became entirely dynamic
- add support for HW quirks for Cirrus CS42L56 codec, Marvell NFC controller,
  Freescale PCIe and Ethernet controller, Himax LCDs and Mediatek mt2701
- refactor OF quirk code
- some general refactoring of the OF and ACPI code, adding new helpers, minor
  tweaks and fixes, making fwnode usage consistent etc.

GPIO uAPI:
- fix an issue where the user-space can trigger a NULL-pointer dereference in
  the kernel by opening a device file, forcing a driver unbind and then calling
  one of the syscalls on the associated file descriptor

New drivers:
- add gpio-latch: a new GPIO multiplexer based on latches connected to other
  GPIOs

Driver updates:
- convert i2c GPIO expanders to using .probe_new()
- drop the gpio-sta2x11 driver
- factor out common code for the ACCES IDIO-16 family of controllers and use
  this new library wherever applicable in drivers
- add DT support to gpio-hisi
- allow building gpio-davinci as a module and increase its maxItems property
- add support for a new model to gpio-pca9570
- other minor changes to various drivers

----------------------------------------------------------------
Aidan MacDonald (1):
      gpio: sl28cpld: Replace irqchip mask_invert with unmask_base

Andy Shevchenko (11):
      gpio: merrifield: Use str_enable_disable() helper
      gpiolib: cdev: Fix typo in kernel doc for struct line
      gpio: exar: Allow IO port access
      gpiolib: of: Make use of device_match_of_node()
      gpio: Add Generic regmap GPIO conversion to the TODO list
      gpiolib: of: Prepare of_gpiochip_add() / of_gpiochip_remove() for fwnode
      gpiolib: of: Integrate of_gpiochip_init_valid_mask() into gpiochip_init_valid_mask()
      gpiolib: of: Prepare of_mm_gpiochip_add_data() for fwnode
      gpiolib: of: Drop redundant check in of_mm_gpiochip_remove()
      gpiolib: Unify access to the device properties
      gpiolib: Provide to_gpio_device() helper

Angel Iglesias (1):
      i2c: core: Introduce i2c_client_get_device_id helper function

Bartosz Golaszewski (5):
      Merge tag 'intel-gpio-v6.2-1' of git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel into gpio/for-next
      Merge branch 'i2c/client_device_id_helper-immutable' of https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux into gpio/for-next
      gpiolib: cdev: fix NULL-pointer dereferences
      gpiolib: protect the GPIO device against being dropped while in use by user-space
      gpio: sim: set a limit on the number of GPIOs

Brian Masney (1):
      gpiolib: ensure that fwnode is properly set

Christophe JAILLET (1):
      gpio: Do not include <linux/kernel.h> when not really needed.

Christophe Leroy (8):
      gpio: aggregator: Stop using ARCH_NR_GPIOS
      gpio: davinci: Stop using ARCH_NR_GPIOS
      gpiolib: Warn on drivers still using static gpiobase allocation
      gpiolib: Get rid of ARCH_NR_GPIOS
      Documentation: gpio: Remove text about ARCH_NR_GPIOS
      x86: Remove CONFIG_ARCH_NR_GPIO
      arm: Remove CONFIG_ARCH_NR_GPIO
      arm64: Remove CONFIG_ARCH_NR_GPIO

Davide Ciminaghi (1):
      gpio: Remove sta2x11 GPIO driver

Dmitry Torokhov (21):
      gpiolib: of: add a quirk for legacy names in Mediatek mt2701-cs42448
      gpiolib: of: consolidate simple renames into a single quirk
      gpiolib: of: tighten selection of gpio renaming quirks
      gpiolib: of: add quirk for locating reset lines with legacy bindings
      gpiolib: of: add a quirk for reset line for Marvell NFC controller
      gpiolib: of: add a quirk for reset line for Cirrus CS42L56 codec
      gpiolib: of: add a quirk for legacy names in MOXA ART RTC
      gpiolib: of: factor out code overriding gpio line polarity
      gpiolib: of: add quirk for phy reset polarity for Freescale Ethernet
      gpiolib: of: add a quirk for reset line polarity for Himax LCDs
      gpiolib: of: factor out quirk setting polarity via separate property
      gpiolib: of: add polarity quirk for Freescale PCIe controller
      leds: gpio: switch to using devm_fwnode_gpiod_get()
      leds: lgm-sso: switch to using devm_fwnode_gpiod_get()
      gpiolib: remove devm_fwnode_get_[index_]gpiod_from_child()
      gpiolib: of: change of_find_gpio() to accept device node
      gpiolib: acpi: change acpi_find_gpio() to accept firmware node
      gpiolib: acpi: teach acpi_find_gpio() to handle data-only nodes
      gpiolib: acpi: avoid leaking ACPI details into upper gpiolib layers
      gpiolib: consolidate GPIO lookups
      gpiolib: add support for software nodes

Guillaume La Roque (1):
      gpio: davinci: add support of module build

Jeremy Kerr (1):
      gpio: ftgpio010: use device name for gpiochip name & label

Nishanth Menon (1):
      dt-bindings: gpio: gpio-davinci: Increase maxItems in gpio-line-names

Sascha Hauer (2):
      dt-bindings: gpio: Add gpio-latch binding document
      gpio: Add gpio latch driver

Shubhrajyoti Datta (3):
      dt-bindings: gpio: pca9570: Add compatible for slg7xl45106
      gpio: pca9570: add a platform data structure
      gpio: pca9570: add slg7xl45106 support

Stephen Kitt (1):
      drivers/gpio: use simple i2c probe

Thierry Reding (1):
      gpiolib: of: Use correct fwnode for DT-probed chips

Uwe Kleine-König (3):
      gpio: max732x: Convert to i2c's .probe_new()
      gpio: pca953x: Convert to i2c's .probe_new()
      gpio: pcf857x: Convert to i2c's .probe_new()

Weilong Chen (2):
      dt-bindings: gpio: add entry for hisilicon,ascend910-gpio
      gpio: hisi: Add initial device tree support

William Breathitt Gray (3):
      gpio: idio-16: Introduce the ACCES IDIO-16 GPIO library module
      gpio: 104-idio-16: Utilize the idio-16 GPIO library
      gpio: pci-idio-16: Utilize the idio-16 GPIO library

Xiang Yang (1):
      gpiolib: acpi: Use METHOD_NAME__AEI macro for acpi_walk_resources

 .../devicetree/bindings/gpio/gpio-davinci.yaml     |   2 +-
 .../devicetree/bindings/gpio/gpio-latch.yaml       |  94 +++++
 .../devicetree/bindings/gpio/gpio-pca9570.yaml     |   1 +
 .../bindings/gpio/hisilicon,ascend910-gpio.yaml    |  56 +++
 Documentation/driver-api/gpio/legacy.rst           |   5 -
 MAINTAINERS                                        |   8 +
 arch/arm/Kconfig                                   |  21 -
 arch/arm/include/asm/gpio.h                        |   1 -
 arch/arm64/Kconfig                                 |  12 -
 arch/x86/Kconfig                                   |   5 -
 drivers/gpio/Kconfig                               |  29 +-
 drivers/gpio/Makefile                              |   4 +-
 drivers/gpio/TODO                                  |   7 +
 drivers/gpio/gpio-104-idio-16.c                    |  88 +---
 drivers/gpio/gpio-aggregator.c                     |   7 +-
 drivers/gpio/gpio-davinci.c                        |  14 +-
 drivers/gpio/gpio-exar.c                           |   1 +
 drivers/gpio/gpio-ftgpio010.c                      |   2 +-
 drivers/gpio/gpio-gw-pld.c                         |   5 +-
 drivers/gpio/gpio-hisi.c                           |   7 +
 drivers/gpio/gpio-idio-16.c                        | 146 +++++++
 drivers/gpio/gpio-idio-16.h                        |  71 ++++
 drivers/gpio/gpio-latch.c                          | 219 ++++++++++
 drivers/gpio/gpio-max7300.c                        |   5 +-
 drivers/gpio/gpio-max732x.c                        |   6 +-
 drivers/gpio/gpio-merrifield.c                     |   3 +-
 drivers/gpio/gpio-pca953x.c                        |   6 +-
 drivers/gpio/gpio-pca9570.c                        |  49 ++-
 drivers/gpio/gpio-pcf857x.c                        |   6 +-
 drivers/gpio/gpio-pci-idio-16.c                    | 119 +-----
 drivers/gpio/gpio-sim.c                            |   4 +
 drivers/gpio/gpio-sl28cpld.c                       |   3 +-
 drivers/gpio/gpio-sta2x11.c                        | 411 -------------------
 drivers/gpio/gpio-tpic2810.c                       |   5 +-
 drivers/gpio/gpio-ts4900.c                         |   5 +-
 drivers/gpio/gpiolib-acpi.c                        | 134 +++---
 drivers/gpio/gpiolib-acpi.h                        |  54 +--
 drivers/gpio/gpiolib-cdev.c                        | 206 ++++++++--
 drivers/gpio/gpiolib-of.c                          | 452 ++++++++++++---------
 drivers/gpio/gpiolib-of.h                          |   9 +-
 drivers/gpio/gpiolib-swnode.c                      | 123 ++++++
 drivers/gpio/gpiolib-swnode.h                      |  14 +
 drivers/gpio/gpiolib.c                             | 295 +++++++-------
 drivers/gpio/gpiolib.h                             |  14 +-
 drivers/i2c/i2c-core-base.c                        |  14 +
 drivers/leds/blink/leds-lgm-sso.c                  |   5 +-
 drivers/leds/leds-gpio.c                           |   5 +-
 include/asm-generic/gpio.h                         |  55 +--
 include/linux/gpio/consumer.h                      |  21 -
 include/linux/gpio/property.h                      |  11 +
 include/linux/i2c.h                                |   1 +
 include/linux/of_gpio.h                            |   2 +-
 52 files changed, 1629 insertions(+), 1213 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-latch.yaml
 create mode 100644 Documentation/devicetree/bindings/gpio/hisilicon,ascend910-gpio.yaml
 create mode 100644 drivers/gpio/gpio-idio-16.c
 create mode 100644 drivers/gpio/gpio-idio-16.h
 create mode 100644 drivers/gpio/gpio-latch.c
 delete mode 100644 drivers/gpio/gpio-sta2x11.c
 create mode 100644 drivers/gpio/gpiolib-swnode.c
 create mode 100644 drivers/gpio/gpiolib-swnode.h
 create mode 100644 include/linux/gpio/property.h
