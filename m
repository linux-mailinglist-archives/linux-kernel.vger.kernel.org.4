Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139875E7D97
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiIWOwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIWOwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:52:11 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3FB12B4BF;
        Fri, 23 Sep 2022 07:52:09 -0700 (PDT)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 2271C60003;
        Fri, 23 Sep 2022 14:52:02 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, heiko@sntech.de,
        jay.xu@rock-chips.com, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        foss+kernel@0leil.net,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH 0/2] fix gpio-sysfs/libgpiod for rockchip
Date:   Fri, 23 Sep 2022 16:51:39 +0200
Message-Id: <20220923145141.3463754-1-foss+kernel@0leil.net>
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

Cheers,
Quentin

Quentin Schulz (2):
  pinctrl: rockchip: add pinmux_ops.gpio_set_direction callback
  gpio: rockchip: request GPIO mux to pinctrl when setting direction

 drivers/gpio/gpio-rockchip.c       |  6 ++++++
 drivers/pinctrl/pinctrl-rockchip.c | 13 +++++++++++++
 2 files changed, 19 insertions(+)

-- 
2.37.3

