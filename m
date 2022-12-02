Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106FC640AB3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbiLBQ11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbiLBQ1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:27:24 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412AECE05
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:27:23 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id cg5so5820609qtb.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 08:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gP/2RrbBINHs0AluywNvaZMiu07gERJD3ysXTDCWXck=;
        b=twtpopHQp0767kfvrjHHaajrLQU0rxdc8bCqpTfQWbnvgiS0g/ZDUt0fyZDlbZroIp
         86OVRoZkw1NX+wHchEgzib54lmZxyEo9fSDuB2MS7+UoRyK0t3RUNr69fN0EbLlO8Ujt
         3Jxk9fr9bDcfHxCRPUweUidhdxGdGcZ8Kck6M2ae13+8kMSpOdfEMmlHDA8vj2MQcFfL
         9M52M2PCAishs8Sp6tMG0lAvA4Mn1btLMQ7isJwk5u30C+ktct8L8RHDHjpKK+ebl039
         vphWVAu3nv7QmUYkHS58vzJZo3Xpdoza1E/iH8b0CeutedAplOT4fICrPofiKDOw3M28
         fQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gP/2RrbBINHs0AluywNvaZMiu07gERJD3ysXTDCWXck=;
        b=d28+iTbiS+Dpv60aAY/ZQdwSnkx91heNx+P9OPKMfaP9xP8bdube/KVTzvm5knfD8N
         7SgCKce5NF2kaclJF1a6zuRdzZdOetExdCqlzX7raHAnh3G+kEqj2fA1GNT8yh5utDSY
         fl8iA77Ndy4YojG1XVVq6NncA8lBNuALBEgFSfzL15qlNGGOVDJJ4deUJ3tqGsKLz0C2
         lA0REQTeRK7vaUl1wFpVnbhEc+0xb5v+Ru7CKBXHwCL4FRHcODVQAIAGWLFI++JWMNy9
         viNaQ8OTQN38IlyWCddqJYOF9PHL6+WpSm/4rclx/XZ2q57lEcNmVSV1ggLnRALcofWN
         gzsw==
X-Gm-Message-State: ANoB5pkpsepnqpmfWnUTevCnxgcKdfwiXSkucVJanqkGbw2wzjf+6Ka6
        17yndhQ7cdjoktUDqksaFUQ49ewed03lgeha
X-Google-Smtp-Source: AA0mqf6MR7ftSsfsq3Q9C1yEnOIwqAcQnSaFaSy8WPU63qQFCQPCJsHQSobZZlKPhxbbAHgz16oj7Q==
X-Received: by 2002:ae9:ed47:0:b0:6fa:15e3:3507 with SMTP id c68-20020ae9ed47000000b006fa15e33507mr47613881qkg.673.1669998442334;
        Fri, 02 Dec 2022 08:27:22 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id fp38-20020a05622a50a600b00343057845f7sm4391887qtb.20.2022.12.02.08.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 08:27:21 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc, broonie@kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v4 0/9] Migrate i8255 GPIO drivers to regmap API
Date:   Fri,  2 Dec 2022 11:27:06 -0500
Message-Id: <cover.1669996866.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4:
 - Align trailing '\' characters in macros to same column in 104-dio-48e
   and 104-idi-48
 - Remove superfluous trailing commas in macros in 104-dio-48e and
   104-idi-48
 - Simplify dio48e_handle_mask_sync() regmap_* calls error checks to
   return error codes directly
 - Refactor dio48e_irq_init_hw() for regmap and comment about spurious
   interrupts; in theory this should be enough to prevent spurious
   interrupts before the system is ready, but we can pass this function
   as a callback where needed in the future
 - Cleanup '{0}' as '{}' in probe() callbacks for 104-dio-48e,
   104-idi-48, and gpio-mm
 - Utilize dev_err_probe() in probe() callbacks for 104-dio-48e and
   104-idi-48
 - Provide convenience comments for idi48_regmap_irqs initialization
   list
 - Replace header includes with forward declarations in gpio-i8255.h

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
 drivers/gpio/gpio-104-dio-48e.c  | 391 ++++++++++---------------------
 drivers/gpio/gpio-104-idi-48.c   | 336 +++++++++-----------------
 drivers/gpio/gpio-gpio-mm.c      | 154 +++---------
 drivers/gpio/gpio-i8255.c        | 320 +++++++------------------
 drivers/gpio/gpio-i8255.h        |  54 ++---
 drivers/gpio/gpio-regmap.c       |   7 +-
 include/linux/regmap.h           |   5 +
 9 files changed, 416 insertions(+), 900 deletions(-)


base-commit: 3b7c7478eda00945987d45f902bc3942c89243d3
-- 
2.38.1

