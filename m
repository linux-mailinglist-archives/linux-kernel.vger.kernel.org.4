Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3406465F4C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbjAEToZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbjAEToW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:44:22 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A0C2AC1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:44:20 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so2140705wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 11:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4xP6IZLtRfzLLTf9PLyMzo4VPs1WL/TdKeh5EXdYX0Y=;
        b=b1eJkiKKEuE0smAQVwgKTkrhm/UKykO8viG4/O4e4o9tmujDLtRnGJ1sGs2mVXRYHD
         b69ESfhTQBBPeWepKEdHYpSobsObC5ZFvsigmVmIVvPvDFVY6afYlKfRmzQut0AGyPc9
         Pld31XdtBK+1rR60BAHnzs7RaxTV0byyxcKNweHAQo5IaWp7WysNeUFHYSH9qj3cpPvz
         Y2skXdIR+lsUfZ1ObU+IffAY/EeAR1+w869kRTTY/U57uC+eu9RIzQxgHppNy2YxXGad
         TkGmEIxTPb850auPDODd9sKIVUnQT6tt3+zDFq/lSGcsxYgaYuDZrqk6jVdPP5dVaIkR
         74GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xP6IZLtRfzLLTf9PLyMzo4VPs1WL/TdKeh5EXdYX0Y=;
        b=HOFprk9Fv1xBwnugmIbGmvatI0KA3Y521SOI9bCB5NcPCgpvy0dMGBUFGk4FpVYm/q
         Jwll+ed+LkYsUXBkRMhgLQY5nmyyvaoy1Ao24kFUYosvMW8XzCLijcOytxJLAZO8+IKB
         SxWAm2m2IJlPqL52G2epruJhsqdWfdw338vi8JihjsXiQRHqCXw1fNVrfTMjZq2Su4V/
         p9lWPLuMLa3xKh9a+HUkk3LJ9cjNM1FdGct8vi0myiEpo8x0yZwxRXP2OdOX4JF++ZbF
         /ekgx0TSQv+5lLMBBEYsoial0ol6bXrIT145rzw31mLIgrBWdmKoWDHt23f+b/j1JW90
         kORw==
X-Gm-Message-State: AFqh2krUzxMBfnTkeDDJKHMdCZTS7b/fvYMFq49HoMSHYq+MsvIhQpSp
        2dBPzMeigSfBXr7cTO3Gbbx+Wg==
X-Google-Smtp-Source: AMrXdXsdvwnq+HU/o8SHbw1c1AdG+LYjfjLo6vx0iiOWVUdobYOXg1kpbw5iF2RQ5h1Z5AjVaeZzzQ==
X-Received: by 2002:a05:600c:3495:b0:3c6:e62e:2e74 with SMTP id a21-20020a05600c349500b003c6e62e2e74mr37808686wmq.15.1672947859515;
        Thu, 05 Jan 2023 11:44:19 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:101:3196:3a40:6416])
        by smtp.gmail.com with ESMTPSA id iv14-20020a05600c548e00b003b47b80cec3sm3981421wmb.42.2023.01.05.11.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 11:44:19 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: fixes for v6.2-rc3
Date:   Thu,  5 Jan 2023 20:44:15 +0100
Message-Id: <20230105194415.552286-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following set of fixes for the next rc. We have a reference
leak fix, two fixes for using uninitialized variables and more drivers
converted to using immutable irqchips.

Details are in the signed tag.

Best regards,
Bartosz Golaszewski

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.2-rc3

for you to fetch changes up to 694175cd8a1643cde3acb45c9294bca44a8e08e9:

  gpio: sifive: Fix refcount leak in sifive_gpio_probe (2023-01-02 13:01:14 +0100)

----------------------------------------------------------------
gpio fixes for v6.2-rc3

- fix a reference leak in gpio-sifive
- fix a potential use of an uninitialized variable in core gpiolib
- fix a potential use of an uninitialized variable in gpio-pca953x
- make GPIO irqchips immutable in gpio-pmic-eic-sprd, gpio-eic-sprd and
  gpio-sprd

----------------------------------------------------------------
Cixi Geng (3):
      gpio: eic-sprd: Make the irqchip immutable
      gpio: pmic-eic-sprd: Make the irqchip immutable
      gpio: sprd: Make the irqchip immutable

Haibo Chen (1):
      gpio: pca953x: avoid to use uninitialized value pinctrl

Hans de Goede (1):
      gpiolib: Fix using uninitialized lookup-flags on ACPI platforms

Miaoqian Lin (1):
      gpio: sifive: Fix refcount leak in sifive_gpio_probe

 drivers/gpio/gpio-eic-sprd.c      | 23 ++++++++++++++---------
 drivers/gpio/gpio-pca953x.c       |  3 +++
 drivers/gpio/gpio-pmic-eic-sprd.c | 29 ++++++++++++++++++-----------
 drivers/gpio/gpio-sifive.c        |  1 +
 drivers/gpio/gpio-sprd.c          |  9 ++++++---
 drivers/gpio/gpiolib.c            |  2 +-
 6 files changed, 43 insertions(+), 24 deletions(-)
