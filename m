Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6F95F0C54
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiI3NU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiI3NUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:20:54 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE71CC997E;
        Fri, 30 Sep 2022 06:20:52 -0700 (PDT)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id F29AB20007;
        Fri, 30 Sep 2022 13:20:45 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, heiko@sntech.de,
        jay.xu@rock-chips.com, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        foss+kernel@0leil.net,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH v2 0/2] fix gpio-sysfs/libgpiod for rockchip
Date:   Fri, 30 Sep 2022 15:20:31 +0200
Message-Id: <20220930132033.4003377-1-foss+kernel@0leil.net>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Since the split of gpio and pinctrl in their own driver, gpio-sysfs and
libgpiod userspace GPIO handling has been broken because the pins aren't
put into their GPIO function anymore since pinctrl subsystem is
"bypassed" when requesting GPIOs from userspace.

This fixes it by making the gpio driver actually request from the
pinctrl subsystem to put the pin in its GPIO function when the GPIO
direction is set in userspace.

I discovered the issue because we have a GPIO the user needs to control
from userspace to flash FW on an on-board STM32 that is actually on the
same pin as one used by the flash controller. Considering the storage
medium tried by the BOOTROM is emmc->nor->nand->sdmmc, booting from emmc
didn't show the issue because the default function for pins is GPIO and
the flash controller pins didn't need to be muxed by the BOOTROM.
However, if there's nothing on emmc, the BOOTROM does the pinmux for SPI
controller and puts the pins in their flash mode and therefore the
handling of that pin as a GPIO from userspace was not possible, but only
when booting on something else than eMMC.

This restores the behavior as seen in v5.14 and earlier.

v2:
 - fix missing header; reported by kernel test robot <lkp@intel.com>

Cheers,
Quentin

Quentin Schulz (2):
  pinctrl: rockchip: add pinmux_ops.gpio_set_direction callback
  gpio: rockchip: request GPIO mux to pinctrl when setting direction

 drivers/gpio/gpio-rockchip.c       |  7 +++++++
 drivers/pinctrl/pinctrl-rockchip.c | 13 +++++++++++++
 2 files changed, 20 insertions(+)

-- 
2.37.3

