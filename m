Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530AC729D35
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240267AbjFIOqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjFIOqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:46:18 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A65269A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:46:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f6d7abe934so14409695e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686321976; x=1688913976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SKybWJA6J6xdDI7z3TOrYffOqQFqmrVYd0ZUpWFWByU=;
        b=C4exMc1ePl3tkLE8lxBsKwPmMFO2oYKAbFzDUmKPyIXBIGSM3IJPMR/mO94Rody0RG
         FRXzQB1ZfqVTvOlTKyo+6cjRHy4uZ6vPL6JNzmwlSZbgMWGOrNQL8E5HJMaaKzdKaNJw
         0HglCD8ilwfQcN4BbCQ7dA4QVspLU4G/v2Oq9iFkhH/457TcU8Rk0Cqg51WXxmUF9ao4
         bunBcP3WddsX9XOgMYP9NtedC+NkIAccGuDnNVeBf46aiK7nDQl0NGt9qCDo6NJ9O7k6
         PnD4+Ot8zj72zVque4nGjv/kbWnfttcG5lpkjsbNYCq8ggmd7INCfcy+rmRX+ElYHuGL
         w/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686321976; x=1688913976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKybWJA6J6xdDI7z3TOrYffOqQFqmrVYd0ZUpWFWByU=;
        b=CaTv4yEe+6EPGB1UAPRkfMA/f/crQ83OiYtnSW0q76VVK26DWMmRQ1Wlb9NNle0GlV
         2keCbCrkJz1uFf6Gi0Zoif3bGpba5CWM+kL2FVflQiMolY4/xAWh1cRC4AUfqQtvm/02
         4FwahIK1AOGVhuCKoKahc/pq+9tlQBsqdIKNw2Sx6gnTOD2TXZsoEvH+syFv3xx8t04W
         w2cOThp/zGem6LSPIEaWzYbl778QdyvCt9ZRpNhzPOktWUxxOz0MfZhoJMPYwQPf1n5H
         XekbZQ0t+2xQnTd8T6FcYeVsq1hwZKlv35/WLE6PeBwnl4eDxVHtxF7GU41jPe2303kD
         HD8Q==
X-Gm-Message-State: AC+VfDxa2PXXco0L+pczV/t8KFvkE9Xwpq+Kq53RDlNYwd88jSNqYHDD
        sIhA0pKfYZT2GehUkj6crNlc3gyd/SQ4QD5GRX0=
X-Google-Smtp-Source: ACHHUZ5FQm/TD6jlxpm7CHhY9BIQL21YfMNUqdUD9EsHzg+rHjJ77DIjhxQ65kvNEjZIslX7y5pPDA==
X-Received: by 2002:a1c:4b14:0:b0:3f7:f2d0:b8fc with SMTP id y20-20020a1c4b14000000b003f7f2d0b8fcmr1122791wma.34.1686321975895;
        Fri, 09 Jun 2023 07:46:15 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:5cfb:aa74:b923:261b])
        by smtp.gmail.com with ESMTPSA id v12-20020a05600c214c00b003f7ffbe5fd1sm2881825wml.40.2023.06.09.07.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:46:15 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: fixes for v6.4-rc6
Date:   Fri,  9 Jun 2023 16:46:13 +0200
Message-Id: <20230609144613.210272-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following fixes for the next RC. There are two fixes for
the GPIO testing module and one commit making Andy a reviewer for the
GPIO subsystem.

Thanks
Bartosz

The following changes since commit 9561de3a55bed6bdd44a12820ba81ec416e705a7:

  Linux 6.4-rc5 (2023-06-04 14:04:27 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.4-rc6

for you to fetch changes up to d1f11f41eb746a33816695f1b6b6719826cc532c:

  MAINTAINERS: add Andy Shevchenko as reviewer for the GPIO subsystem (2023-06-07 15:03:29 +0200)

----------------------------------------------------------------
gpio: fixes for v6.4-rc6

- fix a memory corruption bug in gpio-sim
- fix inconsistencies in user-space configuration of gpio-sim
- make Andy Shevchenko a reviewer for the GPIO subsystem

----------------------------------------------------------------
Bartosz Golaszewski (1):
      MAINTAINERS: add Andy Shevchenko as reviewer for the GPIO subsystem

Kent Gibson (2):
      gpio: sim: fix memory corruption when adding named lines and unnamed hogs
      gpio: sim: quietly ignore configured lines outside the bank

 MAINTAINERS             |  1 +
 drivers/gpio/gpio-sim.c | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)
