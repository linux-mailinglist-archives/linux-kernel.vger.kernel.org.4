Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5316C96D0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjCZQ0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjCZQ0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:26:17 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785BC49D5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:26:15 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id p203so7606099ybb.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679847974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/aSwabsPwKenX2EIQiffqTelCFpZkG6guB3IbGZDzCw=;
        b=Jv20f0nfl6z+enLV83431EyV+4MLpwh+3dEObo81fLYb+53x7Fl58w99DnIR8YrT4U
         tP+rv4A35S62ZM+PzdyUZWBZsAIKaZ8KaEwWOhDNFmoHt+HcONSVqH+h6oxKLD6uv/2O
         s+baaLsDI+q/U/1ohgM2Q6HqEKu6iEBniV5QmLjq3+kaQ/WENtRRqvNalGtykilsUq9e
         LNEfE26arEnrcg5I3yuetfRPfvS1j/IluezLNx1/Ok+O3U22cKQDhetb8MdptkIcXOPm
         Tf4MjUSBhav/NJoxEzVDTTjtqJSRC9Y/PoX5O3X5Y42vLsbY4NcbqfjJirt1srmAzyoc
         Vw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679847974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aSwabsPwKenX2EIQiffqTelCFpZkG6guB3IbGZDzCw=;
        b=rbo5+inAPg1ZU3BBQCeX+Gb26Y2Xiz3AyacQvMc3eXYh1F+hzsccO6LKvmQ6pjisGW
         dNHUV7MwpiId6T22JTN7UmScdomv3LfHdDu3z0exoTTh+EOBNBQhlKohcnYOtXH9zUZq
         RQRVn/ctQsALLuDA5CON6oqtYBR4o209PTKeJgYI53LRnlYvOOXPy1iA8pt6Gu9Zcr+g
         goQKOmGaP+DTQs8YuYlmQXXrZPqIAHKgMT6cIioAOtCQt/vL96/tMXO6j3AFrQhb393z
         9Iu67SKc5XsvLO0e0kpJLf1OWWl1CRiYcz6ERszIz2geUwXCB8iAo2r/o54w429vuI+H
         gmcw==
X-Gm-Message-State: AAQBX9d7tlSXiaCJUbYJb5eiOFmJt8J+3AnRycecB2cx+g8J2U8pIQWq
        4hXeNNZZV5mv1XdEKcLVbSfBhA==
X-Google-Smtp-Source: AKy350aslRJWoz11JE89I8pIFf+LRC3QSi0qUh99rxUB4eS5nkt+hAzl0nEUVz23D1HBwv2AxCh7DQ==
X-Received: by 2002:a25:f812:0:b0:b6a:db81:277f with SMTP id u18-20020a25f812000000b00b6adb81277fmr9517710ybd.24.1679847974633;
        Sun, 26 Mar 2023 09:26:14 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id ci9-20020a05690c0a8900b00545a08184e9sm1543168ywb.121.2023.03.26.09.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 09:26:14 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        techsupport@winsystems.com, pdemetrotion@winsystems.com,
        quarium@gmail.com, jhentges@accesio.com, jay.dolan@accesio.com
Subject: [PATCH v5 0/3] Migrate the PCIe-IDIO-24 and WS16C48 GPIO drivers to the regmap API
Date:   Sun, 26 Mar 2023 12:25:56 -0400
Message-Id: <cover.1679845842.git.william.gray@linaro.org>
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

 drivers/base/regmap/regmap-irq.c |   6 +-
 drivers/gpio/Kconfig             |   6 +
 drivers/gpio/gpio-pcie-idio-24.c | 677 +++++++++++--------------------
 drivers/gpio/gpio-ws16c48.c      | 552 +++++++++----------------
 include/linux/regmap.h           |   5 +-
 5 files changed, 445 insertions(+), 801 deletions(-)


base-commit: 2093bcd872321a5301470978231b23cc121e3476
prerequisite-patch-id: cd19046150b7cff1be4ac7152198777aa960a3df
prerequisite-patch-id: bd3e3830d9ce4f3876a77483364d7190b7fdffa7
-- 
2.39.2

