Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5936A5F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjB1S7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjB1S7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:59:34 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1DF2364C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 10:59:33 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id cf14so11694937qtb.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 10:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677610772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1l1qg+H5Cw3LxrAEdYfHcnEmckF633lxPSK9vTgaOo=;
        b=uYezJH4ugTzCehGU9+LLTdr+M6JIPMKVLQWUNYxatamj0wPh6jCjzYzpiIWe/L/dSN
         9VYzbLiH15spQc0EjRC07Y/SlK5qGFLl/qIjUWmTa3BHwpmJiddscRhpjCPRUtnbEK+Q
         4P6sm/GOwzH2UNdkFjM2f3YSpYzmcTRyrU0zMISf5rLeqv+JP/+KTiGO9XQzlE1q8tG0
         F0/qKO6LFnjww0+RW2uFGnu5cfdwQXQKgTrezlTrGiQWiiHFZHv04TJKX5dXgtBipu3l
         wc2IVSGqsWB1NscyjVugb8YSq2Qz32VMOwga9uHaThmTpR4mQBc9NyBKvqnmZnO7AZ9u
         xI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677610772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1l1qg+H5Cw3LxrAEdYfHcnEmckF633lxPSK9vTgaOo=;
        b=5XUqDvvcUwFzwcaE0N7BQw5/jqNRxSphRGCRLBjEhPT/7fw142OhJgmJhI/qfkhe8J
         w30GVaRew8pcxA6Qcvlmhlm0hK0mU6q/nQwcCyCN2Jjo4yQvB6HlnUe3e7D1EI5Zj8Fh
         6q8W2ZdPymDpaAxE4+1Opy8lho3SbcrzoS2WE4WSIrEwrjE3a94XUMLSpwDBWz/mM7zr
         oleKwbHsBrvBAXtoFMpFxv4Afm6VZBHs1Ir8+aqwCXcyfoHGTgtkzzgWs6DqAZPOaP6o
         nDP26Oa0srWsIu5y2fU7yPfscKCFxpfR8YOpRZvPr0jLfAldv9DJvnyzO7uYhUnhRE3k
         gLgQ==
X-Gm-Message-State: AO0yUKVfMf79oxB1eAjxKnI17kIAn8Ok8HD18SFb+Ib+HZYieDCjkvci
        YVZrs0QYMMgCwIkNpGPsqKBTYe18PWLE0+kS
X-Google-Smtp-Source: AK7set9jsX/HlQyQM7Q3YSYM0gQKIo/egKde86buusKOOhFesehaelYHJ/oKKdmtQzIU/l03zz8JZA==
X-Received: by 2002:ac8:5b4e:0:b0:3a8:fdf:8ff8 with SMTP id n14-20020ac85b4e000000b003a80fdf8ff8mr6619317qtw.36.1677610772240;
        Tue, 28 Feb 2023 10:59:32 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id e22-20020ac84b56000000b003b646123691sm6905181qts.31.2023.02.28.10.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 10:59:31 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     broonie@kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc, quarium@gmail.com,
        jhentges@accesio.com, jay.dolan@accesio.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 0/3] Migrate PCIe-IDIO-24 GPIO driver to the regmap API
Date:   Mon, 27 Feb 2023 20:53:39 -0500
Message-Id: <cover.1677547393.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver.

A patch to pass the device regmap and irq_drv_data as a parameters for
the struct regmap_irq_chip set_type_config() is included. This is needed
by idio_24_set_type_config() in order to update the type configuration
on the device as well as irq_drv_data for idio_24_handle_mask_sync().

A patch moving the struct gpio_regmap declaration to linux/gpio/regmap.h
is also included. This is needed by idio_24_reg_mask_xlate() in order to
determine the current offset's direction by using gpio->regmap in
regmap_read(). One point to consider is whether an alternative solution
is better of passing regmap in the reg_mask_xlate() parameter list; this
would avoid the need to include <linux/gpio/driver.h> in order to
resolve an incomplete type warning for struct gpio_chip due to the move.

William Breathitt Gray (3):
  regmap: Pass regmap and irq_drv_data as parameters for
    set_type_config()
  gpio: gpio-regmap: Expose struct gpio_regmap in linux/gpio/regmap.h
  gpio: pcie-idio-24: Migrate to the regmap API

 drivers/base/regmap/regmap-irq.c |  13 +-
 drivers/gpio/Kconfig             |   3 +
 drivers/gpio/gpio-pcie-idio-24.c | 697 ++++++++++++-------------------
 drivers/gpio/gpio-regmap.c       |  20 -
 include/linux/gpio/regmap.h      |  23 +-
 include/linux/regmap.h           |  12 +-
 6 files changed, 303 insertions(+), 465 deletions(-)


base-commit: 4827aae061337251bb91801b316157a78b845ec7
-- 
2.39.2

