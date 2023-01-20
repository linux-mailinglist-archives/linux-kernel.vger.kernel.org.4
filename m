Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839A4676033
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjATWeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjATWet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:34:49 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208E7613EE
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 14:34:48 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id g10so5131542wmo.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 14:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XASIKyoRs9MRwLtyA40pW+o2YtTsZtdMNQQh9Z2/JM0=;
        b=VnmvbGxSvmREa4jXIFdYkr5YGaK9YMRmjV6Viu5nJtipwu0mPe0uctZXA2Le5xjUag
         ectj4dBwsnHKnhKJ1tLvVhxj+dZqPFgm2NFACvb83KBM2bekf+B2B/btcrrz/iCBh6XI
         SiCNVwhhtEqzkpkHOyMQg8I/FTMfMbaVVW9fbdkD5gyurNUOL4g0nUBERJm3dJ25fECp
         G3v7ZtGgW1QMRcjuTW0YG+oLdFeGE4/hdsa57P2l9ut9Vj9gtgl6LbmclMpXh6hXVWGl
         M80djTimjt0+XoA+yZjwB14iMTXdAPLkM53r4njOfVCYXrDTaMT2gJDJrcJBWqnohqIx
         G67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XASIKyoRs9MRwLtyA40pW+o2YtTsZtdMNQQh9Z2/JM0=;
        b=jXiVnMVt6P+X6Iwoay9HbT4sHztdOLRhX4wv9G3SRXb35DMVTUrfebJMiTv8xw4ebg
         tzh7udGQEC8JZL3m2RAyqzQK34fw8O8stSYOtioQvcshXgwWjKvZaLnOgkmLceQgEH+2
         0wym5U4W3E4c1A4Lr7Oicr1+0zq3FAao/v2s0aQH1kgWXTOxMgcVUNPWWkKz7xGWeIeM
         NN28cuus1EMs00BJ7d1jrTuZY3tnp7NhiAtLU4zp7KLBn7Fo39u9mx8X1udue4037Myg
         XQZOvzLcYql6swYkLJCEg2XI/SvGxLODbcIgOH11hHgEFLRjFwwbyaqWAXmFoIhvX7y0
         F6nQ==
X-Gm-Message-State: AFqh2kqOQUbd5+qEKbFhjpGs3CoNUCt3n+OK9EmIvUlDaX1/n2SAj7S3
        npedSrMODtMsp3b87V5SUHCaSA==
X-Google-Smtp-Source: AMrXdXscdNGAqQBupphsoQbCzuWzC2y1SRXjTI7d18qpcG/YYZ+xA9tFgZNejxpBmwP1Ldy5nI2c5Q==
X-Received: by 2002:a05:600c:4f42:b0:3db:30c3:ed83 with SMTP id m2-20020a05600c4f4200b003db30c3ed83mr3904259wmq.28.1674254086719;
        Fri, 20 Jan 2023 14:34:46 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:580c:7b02:3ffd:b2e])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b003d9aa76dc6asm4943084wmq.0.2023.01.20.14.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 14:34:46 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: fixes for v6.2-rc5
Date:   Fri, 20 Jan 2023 23:34:41 +0100
Message-Id: <20230120223441.114683-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following fixes from the GPIO subsystem. Nothing controversial
in there, Details are in the signed tag.

Best Regards,
Bartosz Golaszewski

The following changes since commit 5dc4c995db9eb45f6373a956eb1f69460e69e6d4:

  Linux 6.2-rc4 (2023-01-15 09:22:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.2-rc5

for you to fetch changes up to 4cb786180dfb5258ff3111181b5e4ecb1d4a297b:

  gpiolib: acpi: Add a ignore wakeup quirk for Clevo NL5xRU (2023-01-18 15:29:16 +0100)

----------------------------------------------------------------
gpio fixes for v6.2-rc5

- fix a potential race condition and always set GPIOs used as interrupt
  source to input in gpio-mxc
- fix a GPIO ACPI-related issue with system suspend on Clevo NL5xRU

----------------------------------------------------------------
Marek Vasut (2):
      gpio: mxc: Protect GPIO irqchip RMW with bgpio spinlock
      gpio: mxc: Always set GPIOs used as interrupt source to INPUT mode

Mario Limonciello (2):
      gpiolib: acpi: Allow ignoring wake capability on pins that aren't in _AEI
      gpiolib: acpi: Add a ignore wakeup quirk for Clevo NL5xRU

 drivers/gpio/gpio-mxc.c     | 13 ++++++++++++-
 drivers/gpio/gpiolib-acpi.c | 17 +++++++++++++++--
 2 files changed, 27 insertions(+), 3 deletions(-)
