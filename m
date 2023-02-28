Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A7F6A6CA5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 13:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCAM6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 07:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjCAM6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:58:48 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BEF1A647
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:58:47 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id e26-20020a9d6e1a000000b00694274b5d3aso1667916otr.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 04:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677675526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K39jV7/rdE+BjoF+nHpEJFPDrYnOAY+w/+g8Z+OkbeA=;
        b=U+eok6NnTmqvncg2t1LmfzVcFxCqTCpO9oXWZVWu42psER+FWauzpmqYACyzWG2gu3
         3NYNzWW9Ukdwfr/yV2l7I2McME2NkNinBgMmhy9sJbRcjuQf8KmzQd0rQlDHmSDD5MAK
         8bMOIw/ggHVygHeKw4fkBv0II87wnVps020pYxCbZdVuXMNFrG5f3HZtTlyXMYP/ITkZ
         gFRFtJ12LOy12fEhRPzBsEucvKC3NSqiNtDyU+F1NHmp7oeGbiyN0KLgemk7UIOEcZ72
         VvOfilTyr2r2RVoW1tZYdT0RNCLOD1MxRFYwcES7pj+LMSbhPlwyDmOWUKzMwRfx9G0x
         T+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677675526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K39jV7/rdE+BjoF+nHpEJFPDrYnOAY+w/+g8Z+OkbeA=;
        b=sHIgdWFuJUjc/sYds7BbZW86o5YFWE6O+mvJfV4ywFVmdHkIi/S0uJtQEw8O+stCZa
         mLOqWn8aJSjaLgXhePrSHa9Qn3S13MjOZx0/u8/wSiVGR5TDFOciJ2RaX/Xsdv0N1F02
         1lsLUsXaQKmqn0J66hMzhWfUAsNAmjDIaLYJlCTQDkKNqSuzR6Kh2yHo4klXajy30MEz
         Wt0arhzoP2/GUzMi7XMynfwJpc14e51ln65WWE2Q4mlQsX+RRqZo09nQWaIkLWye6AAd
         8G3BWRA/gJoeSL6W6sjsHtMUzDpMAPIqUAW10UltkGcpNRz/jh6vyeqLMmrfqCC+88f1
         JYcA==
X-Gm-Message-State: AO0yUKXlO6h/+jeNwVEH61tgtSk0HTnFtC+TF/mKP8myNxpF7505LZe/
        MX963n0M9mIHSPG1YNjFcGQMbQ==
X-Google-Smtp-Source: AK7set8ONkZnF4b3UApgDYFOP21xMxQOlZ8//HZe4y5Vf1SfGBfaHCdbwQCz2Or4+eGdHvfFI1/Ggg==
X-Received: by 2002:a05:6830:1f5d:b0:68d:7a7f:2939 with SMTP id u29-20020a0568301f5d00b0068d7a7f2939mr2681730oth.27.1677675526365;
        Wed, 01 Mar 2023 04:58:46 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id g21-20020a056830309500b0068bc48c61a5sm4865064ots.19.2023.03.01.04.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 04:58:45 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     broonie@kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, quarium@gmail.com,
        jhentges@accesio.com, jay.dolan@accesio.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 0/2] Migrate PCIe-IDIO-24 GPIO driver to the regmap API
Date:   Mon, 27 Feb 2023 22:56:26 -0500
Message-Id: <cover.1677555956.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
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
 - Simplify PCIe-IDIO-24 register offset defines to remove superfluous
   arithmetic
 - Check for NULL pointer after chip->irq_drv_data allocation
 - Set gpio_regmap drvdata and use gpio_regmap_get_drvdata() to get the
   regmap in idio_24_reg_map_xlate()

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver.

A patch to pass the device regmap and irq_drv_data as a parameters for
the struct regmap_irq_chip set_type_config() is included. This is needed
by idio_24_set_type_config() in order to update the type configuration
on the device as well as irq_drv_data for idio_24_handle_mask_sync().

William Breathitt Gray (2):
  regmap: Pass regmap and irq_drv_data as parameters for
    set_type_config()
  gpio: pcie-idio-24: Migrate to the regmap API

 drivers/base/regmap/regmap-irq.c |  13 +-
 drivers/gpio/Kconfig             |   3 +
 drivers/gpio/gpio-pcie-idio-24.c | 693 ++++++++++++-------------------
 include/linux/regmap.h           |  12 +-
 4 files changed, 279 insertions(+), 442 deletions(-)


base-commit: 4827aae061337251bb91801b316157a78b845ec7
-- 
2.39.2

