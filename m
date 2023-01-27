Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA4267EEC9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjA0TvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjA0Tu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:50:58 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930ED88F35
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:48:30 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so6107991wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YTYaopmSCoO7wkFabU0XoJnQL72EQS08UD4h8OBJEFs=;
        b=mwXBj290UpZmfFedVVSw/EL8M1kwVsEYqBlkiGu2RyrW2g3fjb7qloK6iRjrS9mXL6
         txT1Wx/z0bO4w2CHl112vOvMjXUKNgrSNMCDolfNnM0P6N9mG9oPTy3fjgF7Sue81q8H
         Nq1vfT9hqHOkBj4zkGccnFP3oAljrN4/GGa5087i4mlHBE3O1CSHIbkKSPNzd5wcHZTs
         +wyq1Nt7CLlwTJhXWYYJnBYuOn4dVU4O0ABheBMzp+r0zqOgHK2fqcBTK0185epoRqzI
         ynmJb46K3D63IO9g0wGh29tti+Ej67TIwAkgUWvbYLDi17c4hJQshlHIs1gNWQUx5aZ1
         USzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTYaopmSCoO7wkFabU0XoJnQL72EQS08UD4h8OBJEFs=;
        b=c8Cj0SfeNFGp7ZxpmtQwAduNK7MkeTBnmXc83pKw6VIrKqtvqdftL/CXNWMnG3BOtj
         VTAVatv34oFOKhQmr2DD7sq3ZQSM3XRDyyzxYFgKksZZb9Gd45cpGnVUOgfsm9sDXM5T
         cash2iBjRa1gmDIJpl3EE8x5KWG5PTlEACzMm8EWu0AxuCqobuDM866WT41nkIitXIlL
         x+acLQcjA4Vgiog1X9aAEwXvDiOV1yByTuzO2zq/JdBzHwhUGJzvj5Qz0WEaJEXsU6ms
         vHJpNB7PryGShaoJh8L/Rhnqd3iZii40Fwk104i8QUv2KOQvNNifQoKDtg58ezVLRAK1
         /agQ==
X-Gm-Message-State: AFqh2koTOQTS5S+U7CE7TXTWkdllJ1aedpM0fVMT9pnAqqiKgHVKjLy1
        ce9n3pjC+FClTx0/OuAwa1g29Q==
X-Google-Smtp-Source: AMrXdXs0btc20so7Ur4cWanYz56d0n77oqnKmBtU20pjhSB9RjJgFo8WuZfPtKl1LKQOjD+hNy3FqA==
X-Received: by 2002:a05:600c:5116:b0:3db:1a8:c041 with SMTP id o22-20020a05600c511600b003db01a8c041mr40789885wms.17.1674848830637;
        Fri, 27 Jan 2023 11:47:10 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:624:f1a4:edb9:78d5])
        by smtp.gmail.com with ESMTPSA id j38-20020a05600c1c2600b003daff80f16esm12127922wms.27.2023.01.27.11.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 11:47:10 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: fixes for v6.2-rc6
Date:   Fri, 27 Jan 2023 20:47:07 +0100
Message-Id: <20230127194707.311571-1-brgl@bgdev.pl>
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

Please pull the following set of fixes from the GPIO subsystem for the next
release candidate. Details are in the signed tag.

Best Regards,
Bartosz Golaszewski

The following changes since commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65:

  Linux 6.2-rc5 (2023-01-21 16:27:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.2-rc6

for you to fetch changes up to 677d85e1a1ee69fa05ccea83847309484be3781c:

  tools: gpio: fix -c option of gpio-event-mon (2023-01-27 14:05:46 +0100)

----------------------------------------------------------------
gpio fixes for v6.2-rc6

- fix the -c option in the gpio-event-mode user-space example program
- fix the irq number translation in gpio-ep93xx and make its irqchip immutable
- add a missing spin_unlock in error path in gpio-mxc
- fix a suspend breakage on System76 and Lenovo Gen2a introduced in GPIO ACPI

----------------------------------------------------------------
Arnd Bergmann (1):
      gpio: ep93xx: remove unused variable

Dan Carpenter (1):
      gpio: mxc: Unlock on error path in mxc_flip_edge()

Ivo Borisov Shopov (1):
      tools: gpio: fix -c option of gpio-event-mon

Mario Limonciello (1):
      gpiolib-acpi: Don't set GPIOs for wakeup in S3 mode

Nikita Shubin (2):
      gpio: ep93xx: Fix port F hwirq numbers in handler
      gpio: ep93xx: Make irqchip immutable

 drivers/gpio/gpio-ep93xx.c  | 38 ++++++++++++++++++++++----------------
 drivers/gpio/gpio-mxc.c     |  3 ++-
 drivers/gpio/gpiolib-acpi.c |  3 ++-
 tools/gpio/gpio-event-mon.c |  1 +
 4 files changed, 27 insertions(+), 18 deletions(-)
