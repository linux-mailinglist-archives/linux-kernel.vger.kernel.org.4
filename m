Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE834626D41
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 02:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbiKMBJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 20:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbiKMBJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 20:09:44 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A849013F1D
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 17:09:43 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id s4so5039950qtx.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 17:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B9moV2tcf0ddmvHVedu+MwgRdlsmBZvgLK4p0sh0Kag=;
        b=MzFHzbaKyQbKnOXzPTkgOjON2Qv8hd/hDviB3+TH1oCIWHE5zZB1hb6X2SalbSoV7n
         V5sNyfdL1KlMNpjXRnZdrU4NmFd/prZGDkhYi6oxUxR0OleT/VKDo8Eg4vlpuRfMHn3f
         dmPo/Hp/nAq9PJ5N/XhOR3u78yeKiQ8Vn0tEFOg12ve/jqHxkRBbxjDEPEJrIZ5/J8eF
         Bayx3llZjhdGZ+A6hZWoCz393OkeWaLocp8IMZV2cWGZp20ktSyCbINbxNO8EsuYvuiQ
         Mri4+5DeBd7Rt13PQyWm0nSZSM3GlfIHRs2aq1OjBy6zKtbpmUm9WjSbmd6qv/fRPPtj
         zc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B9moV2tcf0ddmvHVedu+MwgRdlsmBZvgLK4p0sh0Kag=;
        b=sV1CiYFpt2WCcU6lk6ALrTXPn9qsuiA+DPaRcJWsX45ID8KtjQan4z0uGtqFHoyzk0
         C/wUUHph+Q4YNKVbZsDyDJ6EOITfohS3JEA4waunX/Ku0lFP4LlBXQycr/21lBaFbtJu
         jKkRueMbXHpv/Ki8Gy6j5+wFGSUdDjNtXe1ypba9lHBDSvEMcC6RUWdUdVaDNcPSCwXY
         N9PeXqsin9jd5zLNBPrvswVNCA3qtara3gLejyLGg4RxvhgYLvJL0Hso/lhKmL9yhNxH
         GzGLsLzUoB9tr7ixINmRYfpF+5xSyFd9Ervh3S/ujQaM4PMpvJ8Kbbs3Ktgb5uVjV9m0
         d6Rw==
X-Gm-Message-State: ANoB5plL1FgnvM3m3ZV5vQtStcJGQwEOO/rfyVebtr1QDiFU5mHs/a6D
        razfm9JPd1N1vzmfF/vH7Wpovg==
X-Google-Smtp-Source: AA0mqf5URGT7sbCFH2vYimEDRG/lFdRX6MHpCn6u5MHHIKe24WuM15aIbbnviXD3/idYrmMXqpthGA==
X-Received: by 2002:ac8:6993:0:b0:3a5:81e1:7571 with SMTP id o19-20020ac86993000000b003a581e17571mr7252481qtq.290.1668301782781;
        Sat, 12 Nov 2022 17:09:42 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id t6-20020a05622a180600b00343057845f7sm3552498qtc.20.2022.11.12.17.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 17:09:41 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc, broonie@kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 0/4] Migrate i8255 GPIO drivers to regmap API
Date:   Thu, 10 Nov 2022 20:55:49 -0500
Message-Id: <cover.1668129763.git.william.gray@linaro.org>
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

Changes in v2:
 - Leveraged gpio_regmap to support GPIO functionality in 104-idi-48
   driver and i8255 library
 - Leveraged regmap_irq to support IRQ functionality in 104-idi-48 and
   104-dio-48e drivers
 - Removed i8255 dependency from 104-idi-48; simpler to just use
   gpio_regmap directly in this case
 - Adjust gpio_regmap to always set gpio_chip get_direction
 - Introduce handle_mask_sync() callback to regmap_irq API
 - i8255 library is simplified to a registration function, a
   configuration structure, and a helper macro

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

William Breathitt Gray (4):
  gpio: regmap: Always set gpio_chip get_direction
  regmap-irq: Add handle_mask_sync() callback
  gpio: 104-idi-48: Migrate to regmap API
  gpio: i8255: Migrate to regmap API

 drivers/base/regmap/regmap-irq.c |  44 +++-
 drivers/gpio/Kconfig             |   5 +-
 drivers/gpio/gpio-104-dio-48e.c  | 397 ++++++++++------------------
 drivers/gpio/gpio-104-idi-48.c   | 329 ++++++++----------------
 drivers/gpio/gpio-gpio-mm.c      | 151 ++---------
 drivers/gpio/gpio-i8255.c        | 429 ++++++++++---------------------
 drivers/gpio/gpio-i8255.h        |  80 +++---
 drivers/gpio/gpio-regmap.c       |   7 +-
 include/linux/regmap.h           |   5 +
 9 files changed, 483 insertions(+), 964 deletions(-)
 rewrite drivers/gpio/gpio-i8255.c (89%)
 rewrite drivers/gpio/gpio-i8255.h (89%)


base-commit: 8dab99c9eab3162bfb4326c35579a3388dbf68f2
-- 
2.38.1

