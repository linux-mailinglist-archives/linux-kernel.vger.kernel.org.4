Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709626D8251
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238946AbjDEPqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238932AbjDEPp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:45:58 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199D135BE
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:45:52 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5445009c26bso684416697b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680709551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IRZgUzxXXe5reizGiPpfQ82G2ISODYD3EQyUvf9YKJo=;
        b=LZSk8/LSidfaecdczNx68z2OSJfLxKaVe9PX/F3KMFBXTQrOpjeuD2eOUymMhVwmmJ
         UyRZ26KcCsU0vGaLWc5nx0bzw2WP7mhI0P8NKUR0nN7MO8Hp1S3KdY7lz//RpkzvIDZp
         uGElklhYUlXgEgBr6mr1DPfFTu+bpxpVH1aXZ9VcEwxed1f1Ry2f1ckPGH0r8G2ADTv4
         XHkAh6ZINr60jYrOg9Z5dtVhX6JIBIgcm8KJsogSIzDWiawwYbOQ4v6skvXuUdI86c81
         UCDUoXOIaAyknrqfXceMqs4P2TUnX9nIbbuqcLReKXPJ33N0tX7ixb3V7VZXP5FnKTzv
         +BDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680709551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IRZgUzxXXe5reizGiPpfQ82G2ISODYD3EQyUvf9YKJo=;
        b=ZyG4hYJ60zBl7LXkuH9t4daDYhQ9HLAvp+8gsmqJDlLDfK+eAuhPXKKmJk/7EXqQOt
         pPGshTlihHDrNjtjTOkRTRUNCg9xV7vhqaTpMr9+DgKu/sQZUcd4Wdsz/0SNHPqouO/s
         KWvqvqyYYpCEmD/CfxPJHShDwTlDjdgycKz+BW95kKcF1TofbSp18BXI3qvl6Vgj6gk0
         C+24pqNxeoXyKT+vNSvfvalokWv39L6wOWezs9x21Xr6SzwmBvgSE1j0zVzkDx5uwSOY
         O0v6xxbqA6Qo31c3nEI+VXXO2hTMTRT1dLEcEqrzqJvxwXRShkoq8iwehPkr5lOtarQJ
         /oKQ==
X-Gm-Message-State: AAQBX9dVNXGc8UhZjFh/Q08BKv8ljXS/8BV1KEWaDOD/d22kOogSME7u
        EUqYQHUgKahE6tZfqFWJ4BxQzg==
X-Google-Smtp-Source: AKy350aepfVsUQ+NeAABi43BVDYLWEWQMyYGO9vDoqmQtj4Ha2huNAbZPY+HJoPQb5fZ7Nrs/FGonQ==
X-Received: by 2002:a81:7bc1:0:b0:541:64e4:2092 with SMTP id w184-20020a817bc1000000b0054164e42092mr6080524ywc.44.1680709551223;
        Wed, 05 Apr 2023 08:45:51 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id g80-20020a0ddd53000000b00545a08184b0sm3942619ywe.64.2023.04.05.08.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 08:45:50 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        techsupport@winsystems.com, pdemetrotion@winsystems.com,
        quarium@gmail.com, jhentges@accesio.com, jay.dolan@accesio.com
Subject: [PATCH v6 0/3] Migrate the PCIe-IDIO-24 and WS16C48 GPIO drivers to the regmap API
Date:   Wed,  5 Apr 2023 11:45:41 -0400
Message-Id: <cover.1680708357.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v6:
 - Wrap lines to 80 characters rather than 100 for set_type_config()
 - Remove regmap_config max_register lines as superfluous
 - Enable use_raw_spinlock to prevent deadlocks when running -rt kernels
 - Check regmap_update_bit() ret value before goto exit_unlock
 - Rename exit_early label to the more descriptive exit_unlock
 - Add sparse annotations for lock acquire/release in
   ws16c48_handle_pre_irq() and ws16c48_handle_post_irq()
 - Explicitly add 0 to WS16C48_ENAB in ws16c48_irq_init_hw() for sake of
   symmetry to match the other WS16C48_ENAB operations 
Changes in v5:
 - Refactor for map parameter removal from handle_mask_sync()
 - Cleanups and line wrappings to 100 characters rather than 80
 - Adjust to change mutex/spinlock_t type locks to raw_spin_lock_t type
 - Remove pex8311_intcsr table configurations as superfluous
 - Adjust to set pex8311_intcsr_regmap_config reg_base to
   PLX_PEX8311_PCI_LCS_INTCSR
 - Rename PAGE_FIELD_PAGE_* defines to POL_PAGE, ENAB_PAGE, and
   INT_ID_PAGE
Changes in v4:
 - Allocate idio24gpio before using it in idio_24_probe()
Changes in v3:
 - Drop map from set_type_config() parameter list; regmap can be passed
   by irq_drv_data instead
 - Adjust idio_24_set_type_config() for parameter list
 - Add mutex to prevent clobbering the COS_ENABLE register when masking
   IRQ and setting their type configuration
Changes in v2:
 - Simplify PCIe-IDIO-24 register offset defines to remove superfluous
   arithmetic
 - Check for NULL pointer after chip->irq_drv_data allocation
 - Set gpio_regmap drvdata and use gpio_regmap_get_drvdata() to get the
   regmap in idio_24_reg_map_xlate()

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver.

A patch to pass irq_drv_data as a parameter for struct regmap_irq_chip
set_type_config() is included. This is needed by the
idio_24_set_type_config() and ws16c48_set_type_config() callbacks in
order to update the type configuration on their respective devices.

This patchset depends on the "Drop map from handle_mask_sync()
parameters" patchset [0].

[0] https://lore.kernel.org/all/cover.1679323449.git.william.gray@linaro.org/

William Breathitt Gray (3):
  regmap: Pass irq_drv_data as a parameter for set_type_config()
  gpio: pcie-idio-24: Migrate to the regmap API
  gpio: ws16c48: Migrate to the regmap API

 drivers/base/regmap/regmap-irq.c |   8 +-
 drivers/gpio/Kconfig             |   6 +
 drivers/gpio/gpio-pcie-idio-24.c | 677 +++++++++++--------------------
 drivers/gpio/gpio-ws16c48.c      | 552 +++++++++----------------
 include/linux/regmap.h           |   6 +-
 5 files changed, 447 insertions(+), 802 deletions(-)


base-commit: 7b59bdbc3965ca8add53e084af394c13a2be22a8
prerequisite-patch-id: cd19046150b7cff1be4ac7152198777aa960a3df
prerequisite-patch-id: bd3e3830d9ce4f3876a77483364d7190b7fdffa7
-- 
2.39.2

