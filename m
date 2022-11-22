Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80B76361A4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238449AbiKWO02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238482AbiKWO0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:26:07 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A24A6EB69
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:25:11 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id s18so10617388qvo.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=39zTu8o/p3Qi58Cd06Tx/HTRDhN0acLffx+GPkCPcLw=;
        b=fNkr+DBrQCwW2gaIHncVcLZ/S0lRhEMRfbfzfnlXyirFUdhQdoDsMBLI5cRPuxYjuZ
         3vpvUNrsFrDi8zBNGA/ZhBnARHFdI6zKtwUUGXyeWjghbWwiC2TcMtmimSSKe3kMM8Jf
         LKLwcg/JrrB8JgmIkikSaKVtdPahmYXNhbF3ptty2u0NC3zkQua9QFnpHDDdJVISwshD
         Zl4QkVmEhhoFL5U/sVL6T4E4nmQ/9yQX4DYFkLSy9ORL86NmMMiG88LOXYWu0dxSEi7j
         6Ska4R9pyLhsOSJBiebJpCT3xCIfBaCWYFukOa2G5jk+535+iwSu/XnUYR7k0sj4p3pA
         XTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39zTu8o/p3Qi58Cd06Tx/HTRDhN0acLffx+GPkCPcLw=;
        b=LRiV3OSoiQEpu+ekQFy8XI/t8I8Mu250sww5P9xmNFsvc+ECVPf+VGhjTu9/5mTYBk
         YMgeo2qAGpkLgYqwExW/tEAYcbf0X3FDMfS7PJrtwpOoG/RoFaY9iw5XZVIn5Gb8RuGU
         Ro/3R7OIS2MBpWT5Wzuwe5KPYxnh8MB0qNmwJI89S8Zi5j6NHmZ1+jC4XtSVUaEEY3g4
         JnHZsRKZsfCy/uhfRIKwl8OkVCSC6F/a+e7dD7C70fJeOH7oirT3WxpVbVyBZShsL0co
         49ZJbFKnCvU+pBbAEMrJo/LbUaagm+eP6WNXRfHq527phE8m7chIaLmPKl+IsF0Mss3B
         04DQ==
X-Gm-Message-State: ANoB5pnDx6EzNBDN25XEGat7mkuM36x0jA/Yro04wHQf5dQTx3yBhHD3
        TEH9PmUHAe7DySBPYw4hhuDRTw==
X-Google-Smtp-Source: AA0mqf43oEzwmtThXOfPYgWsUoQFRaAz3JjEV3p3R0sBYk2jwUnkNsnsXdxqVZD8eQ2Ikubq5vZoGw==
X-Received: by 2002:a0c:ea41:0:b0:4bb:9feb:9204 with SMTP id u1-20020a0cea41000000b004bb9feb9204mr10093704qvp.74.1669213510090;
        Wed, 23 Nov 2022 06:25:10 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id b28-20020a05620a127c00b006f9c2be0b4bsm11718802qkl.135.2022.11.23.06.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:25:09 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc, broonie@kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v3 0/9] Migrate i8255 GPIO drivers to regmap API
Date:   Tue, 22 Nov 2022 02:10:57 -0500
Message-Id: <cover.1669100542.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
 - Changed handle_mask_sync description to show range using a more
   typical mathematical notation ('[' changed to ')')
 - Split addition of new i8255 library regmap interface and removal of
   old i8255 library interface to separate patches
 - Split migration of 104-dio-48e, 104-idi-48, and gpio-mm modules to
   regmap-irq, gpio-regmap, and new i8255 library interface to separate
   patches
 - Simplified logic in dio48e_handle_mask_sync(); the previous version
   separated the conditional evaluations from the if statements which
   made it more complicated than it needed to be
 - Removed initial interrupt clearing in dio48e_probe(); superfluous
   because clear_on_unmask is set to true so the interrupts will be
   cleared anyway later.
 - Replace IDI48_IRQ_REG with IDI48_IRQ_STATUS and IDI48_IRQ_ENABLE to
   make the intent of this register clear

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver. The 104-dio-48e and gpio-mm modules depend on
the i8255 library and are thus updated accordingly.

The 104-IDI-48 is hardwired as an input-only device. Because the i8255
control registers are not exposed on the 104-IDI-48, the i8255 library
doesn't provide much benefit here. In this case it's simpler to utilize
the gpio_regmap API directly, so this patch series does such and removes
the i8255 library dependency from the 104-idi-48 module.

The first patch in this series adjusts gpio_regmap to always set
gpio_chip get_direction. This patch is larger independent of the rest of
the patches in the series and can be picked up separately if desired.
I'm including it here because it allows the input-only 104-idi-48 driver
to continue reporting offset directions after migrating to gpio_regmap.

A handle_mask_sync() callback is introduced for the regmap_irq API. This
is used by the 104-dio-48e driver to handle its enable/disable interrupt
functionality. The 104-DIO-48E has a single register to handle
enabling/disabling interrupts: a write of any value to this register
enables interrupts, while any read disables interrupts.

By leveraging the gpio_regmap API, the i8255 library is reduced to
simply a devm_i8255_regmap_register() function, a configuration
structure struct i8255_regmap_config, and a helper macro
i8255_volatile_regmap_range() provided to simplify volatile PPI register
hinting for the regmap.

The regmap_irq API is leveraged by the 104-idi-48 and 104-dio-48e
modules to support their IRQ functionality. Do their respective regmap
configurations need use_hwlock set to true in this case, or is adequate
locking already handled by the regmap_irq API?

William Breathitt Gray (9):
  gpio: regmap: Always set gpio_chip get_direction
  regmap-irq: Add handle_mask_sync() callback
  gpio: 104-dio-48e: Migrate to the regmap-irq API
  gpio: 104-idi-48: Migrate to the regmap-irq API
  gpio: 104-idi-48: Migrate to gpio-regmap API
  gpio: i8255: Migrate to gpio-regmap API
  gpio: 104-dio-48e: Migrate to regmap API
  gpio: gpio-mm: Migrate to regmap API
  gpio: i8255: Remove unused legacy interface

 drivers/base/regmap/regmap-irq.c |  44 +++-
 drivers/gpio/Kconfig             |   5 +-
 drivers/gpio/gpio-104-dio-48e.c  | 395 ++++++++++---------------------
 drivers/gpio/gpio-104-idi-48.c   | 325 ++++++++-----------------
 drivers/gpio/gpio-gpio-mm.c      | 153 +++---------
 drivers/gpio/gpio-i8255.c        | 320 +++++++------------------
 drivers/gpio/gpio-i8255.h        |  54 ++---
 drivers/gpio/gpio-regmap.c       |   7 +-
 include/linux/regmap.h           |   5 +
 9 files changed, 412 insertions(+), 896 deletions(-)


base-commit: 3687a82b1db1c827cc4b367e3efde3235f68d9f6
-- 
2.38.1

