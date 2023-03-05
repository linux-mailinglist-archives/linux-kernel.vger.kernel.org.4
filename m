Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A166AB17C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 18:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjCERBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 12:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCERBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 12:01:50 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD371423D
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 09:01:48 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id cf14so8261128qtb.10
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 09:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678035707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VD7JJ18qbpCxrbn9PGOqAjymCnI3P0wfCvSjqvqIeqM=;
        b=eEXjW8G+nV3xMb8Yq16SNLcbHkB54bf6uY8mfS6kWokKqMGRpIRq9Lna16N5OQZV/9
         I9dH0MIKs6mO+6njcGrlYVpQ5dLG2m9QXW299nY7e8b0ig3W3v55nCwWVjzrAOiR7HrJ
         ezWVW+yod3LB9sm3rDBMuoNGCynwUtY9cRnNjl6SPDeZV87uLpN+AXc2cCV6u86Fg9/2
         YktS+xSYx2cemGy0tlR9wm4iUEJz+whW/26n4Kpp1a++DIfxRTdLlI7N5g8rigoD45PP
         b8qnoCSq8WbigE9f+xN6pRNSHsNEFeTixU6c7Dlc5Omb9JoEPmSwpCeJGDqGQRTza+Sk
         JGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678035707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VD7JJ18qbpCxrbn9PGOqAjymCnI3P0wfCvSjqvqIeqM=;
        b=mxJfbCrRH6gr5r586DiIDJxnwbVT9WcyJh9SeJAIXsyYxK57usdFgvMLZivshx3pCB
         EOFZ5Xkdb0bPjNCXuwMFrItSTR9rrTYkdu+Rp+lWDvAfaw3FNZEYA0y8RpqEoD+1l2Di
         FLdQHVqgUWKkmgdeirrsmHEFmbCEDT0ebLw1E3iixtS2a2+5aGeIPVTElaGSxNXdbxHj
         fM8gnUL8pM3ak0l+c0uedzW/VcrOOxsZDAlAGabn9lw8vTdJNKlExUqblgL1sp0pR30i
         tPsHdpSteXPFe5nejxUAcAHXOJROfgO1SJP4UEJ7/oepgF+E7+rs0HVpGNvefzjWlo/j
         6r4w==
X-Gm-Message-State: AO0yUKUNuFTVHgc+94Vd6zOklPJoFdrtkL+DMnXSWuFhHeL6/KXpX/mm
        e5Ju05OEv79sWmF0hF2z2QrqUpNvQVE1TeZQmBw=
X-Google-Smtp-Source: AK7set8zLgDTip7qAPGC9c+Lz/VbeirSKDwP5NTYtUPVz2mt+9UnVj19xeKCr2LoQDjRA0SUYfdXjQ==
X-Received: by 2002:ac8:7f4f:0:b0:3bd:16cf:2f17 with SMTP id g15-20020ac87f4f000000b003bd16cf2f17mr13769137qtk.53.1678035707583;
        Sun, 05 Mar 2023 09:01:47 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id c6-20020ac81e86000000b003b9bb59543fsm5810423qtm.61.2023.03.05.09.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 09:01:46 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        techsupport@winsystems.com, pdemetrotion@winsystems.com,
        quarium@gmail.com, jhentges@accesio.com, jay.dolan@accesio.com
Subject: [PATCH v3 0/3] Migrate the PCIe-IDIO-24 and WS16C48 GPIO drivers to the regmap API
Date:   Sun,  5 Mar 2023 12:01:31 -0500
Message-Id: <cover.1678034378.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
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

Changes in v3:
 - Drop map from set_type_config() parameter list; regmap can be passed
   by irq_drv_data instead
 - Adjust ws16c48_set_type_config() for parameter list
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

A patch to migrate the WS16C48 GPIO driver to the regmap API is included
in this patchset due to its dependence on the struct regmap_irq_chip
set_type_config() change.

William Breathitt Gray (3):
  regmap: Pass irq_drv_data as a parameter for set_type_config()
  gpio: pcie-idio-24: Migrate to the regmap API
  gpio: ws16c48: Migrate to the regmap API

 drivers/base/regmap/regmap-irq.c |   8 +-
 drivers/gpio/Kconfig             |   6 +
 drivers/gpio/gpio-pcie-idio-24.c | 709 ++++++++++++-------------------
 drivers/gpio/gpio-ws16c48.c      | 566 +++++++++---------------
 include/linux/regmap.h           |   6 +-
 5 files changed, 496 insertions(+), 799 deletions(-)


base-commit: 4827aae061337251bb91801b316157a78b845ec7
-- 
2.39.2

