Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D45B6A046A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbjBWJEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjBWJEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:04:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7DA469E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:04:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E92BB81979
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 09:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1724AC433D2;
        Thu, 23 Feb 2023 09:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677143069;
        bh=OmyIxDl7k5TcDTUUIklxel+Xf1YsIyjNyGQ2xiCJuN8=;
        h=Date:From:To:Cc:Subject:From;
        b=UoIL0m/QUngIqTk/VwNd5bH7xySDfMdw/e+brhLTmmrh+5VF7jcxgjrjOy3xttaKL
         3e6pRFgCWhTL4pwnSWneolKyilpHLdVFbD1MZKcsibgrhLHgxoHcR3PFjtvPjeFxq2
         BjVWkSZFySVaNgOPEzCJgscvNlAyAsTMKsqvMpOizxuQD8Sp4k1hERCaBrKaIzVhAa
         aflgtPi59q03KwZxeuIdI2mj4roQIao3c2yfnEfQQZix1fTQOqO2TA5syVR2sMITPe
         Mj2xky/nOVxLfpWnZLd70hYxTLgoB2mkfdjp5aTbgvbtq2/RZHf0gouWvNVoLCllpt
         Jgbe0CJM6BahA==
Date:   Thu, 23 Feb 2023 09:04:26 +0000
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] LEDs for v6.3
Message-ID: <Y/csGl2m6+e763Of@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Linus,

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-next-6.3

for you to fetch changes up to 056f65c3938bfa40141669b974d441348af3ee54:

  leds: Remove ide-disk trigger (2023-02-04 15:18:17 +0000)

----------------------------------------------------------------
 - Remove Drivers
   - HTC ASIC3 LED

 - New Functionality
   - Provide generic led_get() which can be used by both DT and !DT platforms

 - Fix-ups
   - Convert a bunch of I2C subsystem users to the new probing API
   - Explicitly provide missing include files
   - Make use of led_init_default_state_get() and rid the custom variants
   - Use simplified fwnode_device_is_compatible() API
   - Provide some Device Tree additions / adaptions
   - Fix some trivial spelling issues

 - Bug Fixes
   - Prevent device refcount leak during led_put() and of_led_get()
   - Clear previous data from temporary led_pwm structure before processing next child
   - Fix Clang's warning about incompatible function types when using devm_add_action*()

----------------------------------------------------------------
Andy Shevchenko (12):
      leds: is31fl319x: Wrap mutex_destroy() for devm_add_action_or_rest()
      leds: Add missing includes and forward declarations in leds.h
      leds: Move led_init_default_state_get() to the global header
      leds: an30259a: Get rid of custom led_init_default_state_get()
      leds: bcm6328: Get rid of custom led_init_default_state_get()
      leds: bcm6358: Get rid of custom led_init_default_state_get()
      leds: mt6323: Get rid of custom led_init_default_state_get()
      leds: mt6360: Get rid of custom led_init_default_state_get()
      leds: pca955x: Get rid of custom led_init_default_state_get()
      leds: pm8058: Get rid of custom led_init_default_state_get()
      leds: syscon: Get rid of custom led_init_default_state_get()
      leds: tca6507: Convert to use fwnode_device_is_compatible()

Arnd Bergmann (1):
      leds: Remove asic3 driver

Corentin Labbe (2):
      dt-bindings: leds: Add disk write/read and usb-host/usb-gadget
      leds: Remove ide-disk trigger

Geert Uytterhoeven (1):
      dt-bindings: leds: Document Bluetooth and WLAN triggers

Hans de Goede (4):
      leds: led-class: Add missing put_device() to led_put()
      leds: led-class: Add led_module_get() helper
      leds: led-class: Add __devm_led_get() helper
      leds: led-class: Add generic [devm_]led_get()

Henning Schild (1):
      leds: simatic-ipc-leds-gpio: Make sure we have the GPIO providing driver

Hui Wang (1):
      leds: pwm: Clear the led structure before parsing each child node

Miaoqian Lin (1):
      leds: led-core: Fix refcount leak in of_led_get()

Randy Dunlap (1):
      Documentation: leds: Correct spelling

Uwe Kleine-König (21):
      leds: bd2802: Convert to i2c's .probe_new()
      leds: blinkm: Convert to i2c's .probe_new()
      leds: is31fl32xx: Convert to i2c's .probe_new()
      leds: lm3530: Convert to i2c's .probe_new()
      leds: lm3532: Convert to i2c's .probe_new()
      leds: lm355x: Convert to i2c's .probe_new()
      leds: lm3642: Convert to i2c's .probe_new()
      leds: lm3692x: Convert to i2c's .probe_new()
      leds: lm3697: Convert to i2c's .probe_new()
      leds: lp3944: Convert to i2c's .probe_new()
      leds: lp3952: Convert to i2c's .probe_new()
      leds: lp5521: Convert to i2c's .probe_new()
      leds: lp5523: Convert to i2c's .probe_new()
      leds: lp5562: Convert to i2c's .probe_new()
      leds: lp8501: Convert to i2c's .probe_new()
      leds: lp8860: Convert to i2c's .probe_new()
      leds: pca9532: Convert to i2c's .probe_new()
      leds: pca963x: Convert to i2c's .probe_new()
      leds: tca6507: Convert to i2c's .probe_new()
      leds: tlc591xx: Convert to i2c's .probe_new()
      leds: turris-omnia: Convert to i2c's .probe_new()

 Documentation/devicetree/bindings/leds/common.yaml |  15 +-
 Documentation/leds/leds-qcom-lpg.rst               |   4 +-
 drivers/leds/Kconfig                               |  11 --
 drivers/leds/Makefile                              |   1 -
 drivers/leds/flash/leds-mt6360.c                   |  38 +----
 drivers/leds/led-class.c                           | 139 +++++++++++++---
 drivers/leds/leds-an30259a.c                       |  21 +--
 drivers/leds/leds-asic3.c                          | 177 ---------------------
 drivers/leds/leds-bcm6328.c                        |  49 +++---
 drivers/leds/leds-bcm6358.c                        |  32 ++--
 drivers/leds/leds-bd2802.c                         |   5 +-
 drivers/leds/leds-blinkm.c                         |   5 +-
 drivers/leds/leds-is31fl319x.c                     |   7 +-
 drivers/leds/leds-is31fl32xx.c                     |   5 +-
 drivers/leds/leds-lm3530.c                         |   5 +-
 drivers/leds/leds-lm3532.c                         |   5 +-
 drivers/leds/leds-lm355x.c                         |   6 +-
 drivers/leds/leds-lm3642.c                         |   5 +-
 drivers/leds/leds-lm3692x.c                        |   6 +-
 drivers/leds/leds-lm3697.c                         |   5 +-
 drivers/leds/leds-lp3944.c                         |   5 +-
 drivers/leds/leds-lp3952.c                         |   5 +-
 drivers/leds/leds-lp5521.c                         |   6 +-
 drivers/leds/leds-lp5523.c                         |   6 +-
 drivers/leds/leds-lp5562.c                         |   5 +-
 drivers/leds/leds-lp8501.c                         |   6 +-
 drivers/leds/leds-lp8860.c                         |   5 +-
 drivers/leds/leds-mt6323.c                         |  30 ++--
 drivers/leds/leds-pca9532.c                        |   9 +-
 drivers/leds/leds-pca955x.c                        |  26 +--
 drivers/leds/leds-pca963x.c                        |   6 +-
 drivers/leds/leds-pm8058.c                         |  29 ++--
 drivers/leds/leds-pwm.c                            |   4 +-
 drivers/leds/leds-syscon.c                         |  49 +++---
 drivers/leds/leds-tca6507.c                        |   8 +-
 drivers/leds/leds-tlc591xx.c                       |   5 +-
 drivers/leds/leds-turris-omnia.c                   |   5 +-
 drivers/leds/leds.h                                |   1 -
 drivers/leds/simple/simatic-ipc-leds-gpio.c        |   2 +
 drivers/leds/trigger/ledtrig-disk.c                |   4 -
 include/linux/leds.h                               |  36 ++++-
 41 files changed, 332 insertions(+), 461 deletions(-)
 delete mode 100644 drivers/leds/leds-asic3.c

-- 
Lee Jones [李琼斯]
