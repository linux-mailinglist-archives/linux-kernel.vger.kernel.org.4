Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674E25F7E60
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiJGT7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJGT7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:59:17 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9225112BBB7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 12:59:15 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n12so8713612wrp.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 12:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xLhn5O0s6mSFDFd2G8Z0EYT0Ydw1EQtGD2+/PxXPLis=;
        b=QAmNy9rf42OQPRWeyaysdE9sgBqnfT0EsiVmNqxUApUpcD3JoyNd7oY+okGu+mnnLM
         sp30NA+bhqg+RJe7YB10fP5yJK3O6UN+WCMjk74ABVldfWTk4bixkP7VlA9rC6A4pvrE
         44jHcH0NTct8Qenh18oHGNa9Hxc8g4d678HevrOY1R7eV8lV7yfztZcwP1vUQwnfRlnt
         qHRRTaA37jbrWv5dgmlziYpf8jBtgx/61PBB4uU5DNMgV16wj7CxiF63vjSdPxyZe+tU
         O9j/02HCOJdNI36FaWfIBiq0ZJG4L5QNYj4fb+Hn2/QEx3kGMyoJSxmMrKb82T59i4iR
         v+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xLhn5O0s6mSFDFd2G8Z0EYT0Ydw1EQtGD2+/PxXPLis=;
        b=7OnngZsody8Xlo7fb2yRR+Ni9WmnGSLpqcBGiX5Sy2kR4qF+hdpyZ/PqkSWGfwGFSc
         sLNGCldqfq4CCc04+EMu1wUJdVVQqKndM6NWF3SvDMjVi+oEJt/D4ZmcjX5dXBugZ9dx
         9zev2dEehVwrH1mB3gwwMr0Ed461m6o3Ykl6o5dA2zLb1fRuAM5/TCp4pfm9r8N+Lj1h
         fdwzW3vQ1etEh0wSxtj6dENUQcBkip0HeahkJ1KWLjA1uaSgFI1nZUS37nlwh0kThrCL
         HaqCBKtCqrKAtl8GoZYchjg+X1QEHstxEkx9HObsSxnNKKJoalQdFmydBhx1B/+DnAfF
         PgtA==
X-Gm-Message-State: ACrzQf1w2EsY55MuscaDPvvLNOWg9fELeHUW0Cd9Y6q6oYD6g6dvhc1n
        qTj8Eh9HC/YvWqqZAUPVVW2CbxIxojsq/w==
X-Google-Smtp-Source: AMsMyM7DROCnW8ScMO/J45oKbClHQqsXWFqyJIf/V5IJUedp9vgiyPVmWDXDPg/NuZQfWba29WTqcA==
X-Received: by 2002:adf:e309:0:b0:22c:c332:9af7 with SMTP id b9-20020adfe309000000b0022cc3329af7mr4411249wrj.217.1665172754033;
        Fri, 07 Oct 2022 12:59:14 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:5a9e:bab6:45e8:abe8])
        by smtp.gmail.com with ESMTPSA id u9-20020a5d4349000000b0022cdb687bf9sm3720822wrr.0.2022.10.07.12.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 12:59:13 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: updates for v6.1-rc1
Date:   Fri,  7 Oct 2022 21:59:06 +0200
Message-Id: <20221007195906.350225-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here's the main pull-request from the GPIO subsystem for this merge window.
We have a single new driver, support for a bunch of new models, improvements
in drivers and core gpiolib code as well device-tree bindings changes.

Details are in the signed tag.

Please pull.
Bartosz Golaszewski

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-updates-for-v6.1-rc1

for you to fetch changes up to 3c92506d86785967fd7e7933e04491b9276c2f00:

  gpio: tc3589x: Make irqchip immutable (2022-10-03 20:56:46 +0200)

----------------------------------------------------------------
gpio updates for v6.1-rc1

New drivers:
- add a new driver for the IMX System Controller Unit GPIOs

GPIO core:
- add fdinfo output for the GPIO character device file descriptors (allows
  user-space to determine which processes own which GPIO lines)
- improvements to OF GPIO code
- new quirk for Asus UM325UAZ in gpiolib-acpi
- new quirk for Freescale SPI in gpiolib-of

Driver improvements:
- add a new macro that reduces the amount of boilerplate code in ISA drivers
  and use it in relevant drivers
- support two new models in gpio-pca953x
- support new model in gpio-f7188x
- convert more drivers to use immutable irq chips
- other minor tweaks

Device-tree bindings:
- add DT bindings for gpio-imx-scu
- convert Xilinx GPIO bindings to YAML
- reference the properties from the SPI peripheral device-tree bindings
  instead of providing custom ones in the GPIO controller document
- add parsing of GPIO hog nodes to the DT bindings for gpio-mpfs-gpio
- relax the node name requirements in gpio-stmpe
- add new models for gpio-rcar and gpio-pxa95xx
- add a new vendor prefix: Diodes (for Diodes, Inc.)

Misc:
- pulled in the immutable branch from the x86 platform drivers tree including
  support for a new simatic board that depends on GPIO changes

----------------------------------------------------------------
Bartosz Golaszewski (3):
      Merge tag 'platform-drivers-x86-simatec-1' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86 into gpio/for-next
      Merge tag 'intel-gpio-v6.1-1' of gitolite.kernel.org:pub/scm/linux/kernel/git/andy/linux-gpio-intel into gpio/for-next
      gpiolib: cdev: add fdinfo output for line request file descriptors

Conor Dooley (1):
      dt-bindings: gpio: mpfs-gpio: allow parsing of hog child nodes.

Dmitry Torokhov (5):
      gpiolib: make fwnode_get_named_gpiod() static
      gpiolib: of: do not ignore requested index when applying quirks
      gpiolib: of: make Freescale SPI quirk similar to all others
      gpiolib: rework quirk handling in of_find_gpio()
      gpiolib: of: factor out conversion from OF flags

Francesco Dolcini (1):
      dt-bindings: gpio: stmpe: Remove node name requirement

Geert Uytterhoeven (1):
      dt-bindings: gpio: renesas,rcar-gpio: Add r8a779g0 support

Henning Schild (7):
      gpio-f7188x: switch over to using pr_fmt
      gpio-f7188x: add a prefix to macros to keep gpio namespace clean
      gpio-f7188x: Add GPIO support for Nuvoton NCT6116
      gpio-f7188x: use unique labels for banks/chips
      leds: simatic-ipc-leds-gpio: add new model 227G
      platform/x86: simatic-ipc: enable watchdog for 227G
      platform/x86: simatic-ipc: add new model 427G

Jeffy Chen (1):
      gpio/rockchip: Convert to generic_handle_domain_irq()

Krzysztof Kozlowski (1):
      dt-bindings: gpio: fairchild,74hc595: use spi-peripheral-props.yaml

Linus Walleij (2):
      gpio: ucb1400: Use proper header
      gpio: tc3589x: Make irqchip immutable

Mario Limonciello (2):
      gpiolib: acpi: Add support to ignore programming an interrupt
      gpiolib: acpi: Add a quirk for Asus UM325UAZ

Martyn Welch (5):
      dt-bindings: vendor-prefixes: add Diodes
      dt-bindings: gpio: pca95xx: add entry for pcal6534 and PI4IOE5V6534Q
      gpio: pca953x: Fix pca953x_gpio_set_pull_up_down()
      gpio: pca953x: Swap if statements to save later complexity
      gpio: pca953x: Add support for PCAL6534

Michael Walle (1):
      gpiolib: fix OOB access in quirk callbacks

Nate Drude (2):
      dt-bindings: gpio: pca95xx: add entry for pcal6408
      gpio: pca953x: introduce support for nxp,pcal6408

Qingtao Cao (1):
      gpio: exar: access MPIO registers on cascaded chips

Sergio Paracuellos (1):
      gpio: mt7621: Switch to use platform_get_irq() function

Shenwei Wang (3):
      dt-bindings: gpio: Add imx scu gpio driver bindings
      dt-bindings: firmware: imx: Add imx-scu gpio node
      gpio: imx-scu: add imx-scu GPIO driver

Srinivas Neeli (1):
      dt-bindings: gpio: gpio-xilinx: Convert Xilinx axi gpio binding to YAML

Uwe Kleine-König (1):
      gpio: twl4030: Reorder functions which allows to drop a forward declaraion

William Breathitt Gray (6):
      isa: Introduce the module_isa_driver_with_irq helper macro
      counter: 104-quad-8: Ensure number of irq matches number of base
      gpio: 104-dio-48e: Ensure number of irq matches number of base
      gpio: 104-idi-48: Ensure number of irq matches number of base
      gpio: 104-idio-16: Ensure number of irq matches number of base
      gpio: ws16c48: Ensure number of irq matches number of base

 .../devicetree/bindings/firmware/fsl,scu.yaml      |   5 +
 .../bindings/gpio/fairchild,74hc595.yaml           |   7 +-
 .../bindings/gpio/fsl,imx8qxp-sc-gpio.yaml         |  39 +++
 .../devicetree/bindings/gpio/gpio-pca95xx.yaml     |  99 ++++----
 .../devicetree/bindings/gpio/gpio-stmpe.txt        |   3 +-
 .../devicetree/bindings/gpio/gpio-xilinx.txt       |  48 ----
 .../bindings/gpio/microchip,mpfs-gpio.yaml         |  18 ++
 .../bindings/gpio/renesas,rcar-gpio.yaml           |   1 +
 .../devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml | 154 ++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 drivers/counter/104-quad-8.c                       |   5 +-
 drivers/gpio/Kconfig                               |   7 +-
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-104-dio-48e.c                    |   5 +-
 drivers/gpio/gpio-104-idi-48.c                     |   5 +-
 drivers/gpio/gpio-104-idio-16.c                    |   5 +-
 drivers/gpio/gpio-exar.c                           |  40 ++-
 drivers/gpio/gpio-f7188x.c                         | 275 ++++++++++++---------
 drivers/gpio/gpio-imx-scu.c                        | 139 +++++++++++
 drivers/gpio/gpio-mt7621.c                         |   7 +-
 drivers/gpio/gpio-pca953x.c                        | 177 ++++++++++---
 drivers/gpio/gpio-rockchip.c                       |  21 +-
 drivers/gpio/gpio-tc3589x.c                        |   8 +-
 drivers/gpio/gpio-twl4030.c                        |  26 +-
 drivers/gpio/gpio-ucb1400.c                        |   1 +
 drivers/gpio/gpio-ws16c48.c                        |   5 +-
 drivers/gpio/gpiolib-acpi.c                        |  38 ++-
 drivers/gpio/gpiolib-cdev.c                        |  18 ++
 drivers/gpio/gpiolib-of.c                          | 184 ++++++--------
 drivers/gpio/gpiolib.c                             | 132 +++++-----
 drivers/leds/simple/simatic-ipc-leds-gpio.c        |  42 +++-
 drivers/platform/x86/simatic-ipc.c                 |  10 +-
 include/linux/gpio/consumer.h                      |  13 -
 include/linux/isa.h                                |  52 +++-
 include/linux/platform_data/x86/simatic-ipc-base.h |   1 +
 include/linux/platform_data/x86/simatic-ipc.h      |   2 +
 include/linux/ucb1400.h                            |   2 +-
 37 files changed, 1089 insertions(+), 508 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/fsl,imx8qxp-sc-gpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-xilinx.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml
 create mode 100644 drivers/gpio/gpio-imx-scu.c
