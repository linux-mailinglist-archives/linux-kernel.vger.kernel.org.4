Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48885BBFAA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 21:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiIRTyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 15:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiIRTyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 15:54:12 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B081BE
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 12:54:11 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id v15so20507207qvi.11
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 12:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=NzrSgldK85xE6QmwEDPD5LgTrIFuIlHV7KhW9RAuNP0=;
        b=MDq97wGJRmYOuNIqd9hUGnm9om4ibEJ7TbpBvTnT4oDk/M7FpZC7uoCjTaLVXCYME7
         wFYyENE01cgfhL2bi/pgJ9WnYAvH48dlQmmJ6nj6vT4FeW0hLnrsZf5tYUW0S2925CBd
         jw3ccqFq9c2a63Q3kxORnje+PlhflhbIACp5muifFbc7D/qe5NdRexHDiRwsnMnQgM2b
         TtfdfqiuJyUEVgFkiuMmKZ1e+BY/trPZxhakjdZNkVcZLAtOH8Dx7MGBH0qtIsvKfkC+
         qPh0S5DsE+Y6Ph8qXiCthXJBLeTuKfvcWqcL/nD9vwcPjOTCV+efvzz03l1ZcqbfD5YY
         8Fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=NzrSgldK85xE6QmwEDPD5LgTrIFuIlHV7KhW9RAuNP0=;
        b=g2MfIVu0VVQc2o8stay3Jl6Vlv6fLwqo8saCBZehOw+pXtGYujAQV81rG3njOE9/Eq
         1PKgIDmWEp7UnO1nrgZcY6dOxNlj91COdCnvBOq6fuXds5a7+axvTwDO6/pP8XbAcat/
         85ANymezevLYa+u0OE+B/JPpZW71ZMFbjvEY48r51GcFXjkLxTLEx/uEiJf/BMnG+A3J
         EVpNKHJCSWXzoobXaZw5b0FvVrFZ+lWsySdVQSweVGP1ygU/+CIggLoUGazCcG+X535M
         BetrrSK67VT8lDq47uhr+cf5fpqEwjif/FfPxRGfUpAt7jqku1p0Yg3njHxajixXJPEy
         aEng==
X-Gm-Message-State: ACrzQf3A4YllmDCKtBJ0nln/oc12kPBncSS1GVVVDUeUXv3VKrKm2doY
        IfRS+bNo3IvRu8/kmjUmo2mcrg==
X-Google-Smtp-Source: AMsMyM4FmaRrd0cAifUoQHD59YrvW0qJmOHuRGOQ3sgmpvHoFLiJnzuiy1qUnhfsEDQ2Cs96HLYsKg==
X-Received: by 2002:ad4:5f47:0:b0:4ac:b8de:1484 with SMTP id p7-20020ad45f47000000b004acb8de1484mr12103624qvg.77.1663530850400;
        Sun, 18 Sep 2022 12:54:10 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id i67-20020a37b846000000b006ce7d9dea7asm10753310qkf.13.2022.09.18.12.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 12:54:09 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     brgl@bgdev.pl, linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        linux-gpio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 0/3] Introduce the ACCES IDIO-16 GPIO library module
Date:   Sun, 18 Sep 2022 12:50:42 -0400
Message-Id: <cover.1663519546.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
 - Added offset check for last byte of inputs in idio_16_get() for
   robustness
 - Replaced hardcoded '16' with IDIO_16_NOUT constant in idio_16_get*()
 - Renamed IDIO_16 namespace to GPIO_IDIO_16; adjusted 104-idio-16 and
   pci-idio-16 drivers accordingly
 - Utilized DEFAULT_SYMBOL_NAMESPACE to simplify namespace exports
 - Refactored callbacks to utilize cached output states; idio_16_get()
   callback now requires struct idio_16_state state; adjusted
   104-idio-16 and pci-idio-16 drivers accordingly
 - Moved bitmap_fill() to after idio_16_state_init() in idio_16_probe()
   to prevent clobbering out_state if the implementation of
   idio_16_state_init changes in the future
 - Adjusted offset checks in idio_16_set() and idio_16_get_direction()
   to ">= IDIO_16_NOUT" for consistency
 - Utilized __assign_bit() in idio_16_set()
 - Refactored idio_16_*_multiple() callbacks to utilize bitmap_replace()

In a similar vein as the Intel 8255 interface library module [0], the
ACCES IDIO-16 GPIO library module is introduced to consolidate much of
the shared code between the existing 104-IDIO-16 and PCI-IDIO-16 GPIO
drivers.

The idio-16 module exposes consumer library functions to facilitate
communication with devices within the ACCES IDIO-16 family such as the
104-IDIO-16 and the PCI-IDIO-16.

A CONFIG_GPIO_IDIO_16 Kconfig option is introduced by this patch.
Modules wanting access to these idio-16 library functions should select
this Kconfig option and import the GPIO_IDIO_16 symbol namespace.

[0] https://lore.kernel.org/all/d1a24895f2ea67f689c24c34a20ddb43cd7246af.1658324498.git.william.gray@linaro.org/

William Breathitt Gray (3):
  gpio: idio-16: Introduce the ACCES IDIO-16 GPIO library module
  gpio: 104-idio-16: Utilize the idio-16 GPIO library
  gpio: pci-idio-16: Utilize the idio-16 GPIO library

 MAINTAINERS                     |   7 ++
 drivers/gpio/Kconfig            |  11 +++
 drivers/gpio/Makefile           |   1 +
 drivers/gpio/gpio-104-idio-16.c |  88 ++++---------------
 drivers/gpio/gpio-idio-16.c     | 146 ++++++++++++++++++++++++++++++++
 drivers/gpio/gpio-idio-16.h     |  71 ++++++++++++++++
 drivers/gpio/gpio-pci-idio-16.c | 119 +++-----------------------
 7 files changed, 265 insertions(+), 178 deletions(-)
 create mode 100644 drivers/gpio/gpio-idio-16.c
 create mode 100644 drivers/gpio/gpio-idio-16.h


base-commit: d9e7f0e320516c660d6f33e6c16a3d99970eb14e
-- 
2.37.3

