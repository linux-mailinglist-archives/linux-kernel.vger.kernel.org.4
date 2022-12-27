Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65394656BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 15:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbiL0Ocq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 09:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiL0Oco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 09:32:44 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A8EB1E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:32:43 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id r205so12540067oib.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8yl7tSpZqM1nYkQndNf9Bgez3en4RCjlOQ/FXT9ZblI=;
        b=Td2EhVNfRYDN5avfBp19l0818QxqaHnIjUxwlYgRPNqchGwNWj8Di+Z0JHRVin4Gn2
         FQ6DGrfCHBW1aiBX4yVlANWNjq3BlGwSQj9WpDM/RqriiSdhli6PltH+bceccwuP9RTX
         Pxpj3jdoW7UeDi+MlGUmYntxk0r2+5iJ6P8by1l48aDY+ROeml/cOhSQ2xOujxknYQqJ
         GKSQ+e5c2WdBTOIBBCUzI7neWn0Rdkhzf80o3cmOrrBSWcahOlFDl/FmxDuXiTWefqZv
         DC13U+Zj0yXXTHLEej4KiNyWcGnbDCH8jXqBUK6jib2xWcGRFYDH5e2pukj1SCIRKy86
         g7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yl7tSpZqM1nYkQndNf9Bgez3en4RCjlOQ/FXT9ZblI=;
        b=RonPMCYivXatPoq5h7NMUeXNpMNSkF2Wv0lPuzg8sQZ3XgeyV8GRsUvWycCHUahgBm
         eC3ROpY9BvhGuAD16nAl/VsThnmw/NrKWrDK9CTzE0IDNEP58+ZYCT2+jrNt+yEmw1TP
         iRZv7JUeZgU7UnF8bAhd9e7ZCdvP0GfJH589NX2+67mJ8QzeGtZ+Lth7F38/Bg8xIeYK
         A4pAAAnnwrltEiHEJnbdvIBz7EIYg8Jc5ytUCBB26K2KmHhu7lTGHJM4Qt+OVC2vJSC7
         afRN0mMTRBOPV4h+DHrLa0ecASN7z1rVExUS95PBUFh6fg4DzLfgECmy4oy2sI6y0Ldh
         852Q==
X-Gm-Message-State: AFqh2kowau9R6SZNNsdEzBKUqM/JYGKvnVfE1GfOmrBDKDR7FgDmNSZB
        DnvAFSGGJu6ikJ1Atx+Wkss1kg==
X-Google-Smtp-Source: AMrXdXuLS6lw2WdzYz0hXeBX2fcQVL+F40CW+M25v3jmdFgTUjRzTVL+PWpy/Txk/JEqTz5UAm+/EA==
X-Received: by 2002:a05:6808:1492:b0:35e:910d:10e6 with SMTP id e18-20020a056808149200b0035e910d10e6mr11908461oiw.9.1672151562694;
        Tue, 27 Dec 2022 06:32:42 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id q205-20020acac0d6000000b0035bce2a39c7sm5864969oif.21.2022.12.27.06.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 06:32:42 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v5 0/8] Migrate i8255 GPIO drivers to regmap API
Date:   Tue, 27 Dec 2022 09:09:38 -0500
Message-Id: <cover.1672149007.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v5:
 - Add REGMAP_MMIO Kconfig selection for GPIO_104_DIO_48E,
   GPIO_104_IDI_48, and GPIO_GPIO_MM
 - Replace magic number 0x3 with GENMASK(1, 0) to make intent clear in
   the dio48e_handle_mask_sync() function
 - Write (instead of read) to clear interrupts on unmask; although the
   datasheet lists the respective register as read/write, all other
   references state that this should be a write operation to clear

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
gpio_chip get_direction. This patch is mostly independent of the rest of
the patches in the series and can be picked up separately if desired.
I'm including it here because it allows the input-only 104-idi-48 driver
to continue reporting offset directions after migrating to gpio_regmap.

By leveraging the gpio_regmap API, the i8255 library is reduced to
simply a devm_i8255_regmap_register() function, a configuration
structure struct i8255_regmap_config, and a helper macro
i8255_volatile_regmap_range() provided to simplify volatile PPI register
hinting for the regmap.

The regmap_irq API is leveraged by the 104-idi-48 and 104-dio-48e
modules to support their IRQ functionality. Do their respective regmap
configurations need use_hwlock set to true in this case, or is adequate
locking already handled by the regmap_irq API?

William Breathitt Gray (8):
  gpio: regmap: Always set gpio_chip get_direction
  gpio: 104-dio-48e: Migrate to the regmap-irq API
  gpio: 104-idi-48: Migrate to the regmap-irq API
  gpio: 104-idi-48: Migrate to gpio-regmap API
  gpio: i8255: Migrate to gpio-regmap API
  gpio: 104-dio-48e: Migrate to regmap API
  gpio: gpio-mm: Migrate to regmap API
  gpio: i8255: Remove unused legacy interface

 drivers/gpio/Kconfig            |   8 +-
 drivers/gpio/gpio-104-dio-48e.c | 398 +++++++++++---------------------
 drivers/gpio/gpio-104-idi-48.c  | 336 +++++++++------------------
 drivers/gpio/gpio-gpio-mm.c     | 154 +++---------
 drivers/gpio/gpio-i8255.c       | 320 +++++++------------------
 drivers/gpio/gpio-i8255.h       |  54 ++---
 drivers/gpio/gpio-regmap.c      |   7 +-
 7 files changed, 390 insertions(+), 887 deletions(-)


base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
-- 
2.38.1

