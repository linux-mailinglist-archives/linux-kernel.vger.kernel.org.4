Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D936C87A0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjCXVp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjCXVp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:45:57 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A941C323
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 14:45:56 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id z83so3970774ybb.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 14:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679694355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=El09xkgtkKqR4iy6jOYeiJHLaMRu3rjrufjkG4zx1iY=;
        b=JLHFHirbfmErefEQjjbNubiyO1NtdGKBGBuWoLMxok7tsqblUeVVLfrmnplkeWblcj
         DfQPFpguKRc5CHVKId1Qc0aEUH6V6SndOJptd/9Lm5KooS301i0+g4mdBeGWMSi/rl9v
         qlSEa+EdytnME/VbBRbM5RicpLepvlgA84+jNPfI2grBmF2ftVdEh+bHOEc4f8Uqlkik
         6BIO1P4Ui3fS0Sc7G1/Jfyi9Om0LCL1v3cgS+d1BC+9SMoJ5p6eIuZUCgo7LQRcX1/lC
         7kjvkMgZQzlk3HF4rUS+xc7NQ3I07E/Eb7NP+LyAcNSOVAada4YVw8GTojJMKp3EV7r4
         8ONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679694355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=El09xkgtkKqR4iy6jOYeiJHLaMRu3rjrufjkG4zx1iY=;
        b=1bti7PMWky/Nnpd9JOkwbGKiOnfPtP8K1mRHVPDljIOz3i3zYx2zZgf46HMuiGfKj+
         waOG/npqnDub4MgUxjlv/D8vPbDsIX5bpYn4HMcm6Tqx8rOtia/kFI12qMvoTUrYfAJV
         C+KrUdcy5BCIuQgmKg026YDrb/oWCJOw9tIsK+5Sup4DNd6JII2uFp4OAfmTgwuH/sRB
         eCVH4UYPvVBZitgLd/e8Vs9FZHFxBRr5kJ6mOWQwYCeIRHzzBln6ghDbe2qpUdAP8N/U
         sgCp3JtgeyPGPaNb+OGAIwcFLrLCpgUHSFpec6UI6loVF/vOp7ucOrjn3KmbhnM8ggE5
         9xEw==
X-Gm-Message-State: AAQBX9fE2tBCwnRv5F6jFIYZbfWR5TkTbseYNv25ZWI46AnmZKSAwvta
        3pjj8IEMd4vq2ncBrTeX9OHhqg==
X-Google-Smtp-Source: AKy350ah4ZynM+d816L4XlSFlFO2GRbNYhvkpi8XRM3j041UAYYE5Y4e342kMKqk+EJFv3kzNNG8Rw==
X-Received: by 2002:a25:fc1b:0:b0:b76:918a:57e1 with SMTP id v27-20020a25fc1b000000b00b76918a57e1mr3397827ybd.51.1679694355445;
        Fri, 24 Mar 2023 14:45:55 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id p8-20020a254208000000b00b7767ca7476sm705313yba.19.2023.03.24.14.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 14:45:55 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v3 0/4] Migrate IDIO-16 GPIO drivers to regmap API
Date:   Fri, 24 Mar 2023 17:45:40 -0400
Message-Id: <cover.1679693714.git.william.gray@linaro.org>
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

Changes in v3:
 - Refactor for map parameter removal from handle_mask_sync(); e.g.
   declare struct idio_16_data and utilize for irq_drv_data, inline
   data->map in idio_16_handle_mask_sync(), etc
 - Cleanups and line wrapping to 100 characters rather than 80
 - Change dev_err_probe() to dev_err(); devm_idio_16_regmap_register()
   is technically not a probe() callback
 - Remove volatile regmap configuration structures; the existing read
   regmap table can be used to configure the volatile regmap table

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver. The 104-idio-16 and pci-idio-16 modules depend
on the IDIO-16 library and are thus updated accordingly.

By leveraging the regmap API, the idio-16 library is reduced to simply a
devm_idio_16_regmap_register() function and a configuration structure
struct idio_16_regmap_config.

This patchset depends on the "Drop map from handle_mask_sync()
parameters" patchset [0].

[0] https://lore.kernel.org/all/cover.1679323449.git.william.gray@linaro.org/

William Breathitt Gray (4):
  gpio: idio-16: Migrate to the regmap API
  gpio: 104-idio-16: Migrate to the regmap API
  gpio: pci-idio-16: Migrate to the regmap API
  gpio: idio-16: Remove unused legacy interface

 drivers/gpio/Kconfig            |   7 +-
 drivers/gpio/gpio-104-idio-16.c | 286 +++++++------------------------
 drivers/gpio/gpio-idio-16.c     | 257 ++++++++++++++++------------
 drivers/gpio/gpio-idio-16.h     |  79 +++------
 drivers/gpio/gpio-pci-idio-16.c | 294 +++++++-------------------------
 5 files changed, 293 insertions(+), 630 deletions(-)


base-commit: 2093bcd872321a5301470978231b23cc121e3476
prerequisite-patch-id: cd19046150b7cff1be4ac7152198777aa960a3df
prerequisite-patch-id: bd3e3830d9ce4f3876a77483364d7190b7fdffa7
-- 
2.39.2

