Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5916EA7D5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 12:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjDUKHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 06:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjDUKHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:07:19 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393E5A5DD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 03:07:18 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-2f87c5b4635so1435140f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 03:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1682071636; x=1684663636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=38kDXtPapHIwOdWmZqY2hajsS5hH99I81TUWs2K/Ge4=;
        b=rrdoYkof7cTLE+N2yYeEEE9rYTLyqdRQtvZZaHys2RSUbMHOevJvZ+Ejj9AU+oWC/K
         8CkxBGzz7CCF8B7RsqcFJcSpzXTo7JVg0lsBrfKGynjcDEoUfRnyfxQoKKhJIdwCGLQ3
         MaohXZlnQyWobNThIcaC0Vt/Egd70IcY8eWV0HVhEaR1xPh6cqtpjVbQ1C23n1lRjNBe
         f+Pb+EpILZsKl0G0tBYsKLhUmvqnqmWqcvs5QKd4CIC13/+OMRaqNRMuHBm7szRXn6S1
         NYcwr936mbYBJ3xK7ZGfKBkpJ8S95SfDmxitBa6TPSR8vqp5kRDQoTYMvzi9oyJIHvIi
         YWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682071636; x=1684663636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38kDXtPapHIwOdWmZqY2hajsS5hH99I81TUWs2K/Ge4=;
        b=llec2ofXKbrf9xASOmU0C1fp9dzqTcx2HtzZ0I3CqFrnE0C2QGyMjAjqUrAmdKgcJk
         2Ebkl0SYx3VTuEfrQWhOZVTHv4ssBxwm5cwsOhqtbl5uLeDyyTPTeCiScnmsKilAQ2hM
         URCoxAM7mDHCrp9ods5mbgyWhToMF1Gdp6og/G4ki4AmU9VYpgddttP1HE7nOY9R8EQ7
         j5glrbdf1TwmV8+sjl56EF61UohBsZ8jI8HwZCoDWsSIYQj2LVK1fPwMizTqXJVVnAPw
         VIxnTC4/z3s9bBPR+4FShZ+B7cWdiOK7hsbDIgsBSexXkZ1bOJZSOoe6htZKgjXyOwnz
         XHkQ==
X-Gm-Message-State: AAQBX9fXC1Sd9xojYqj7bu9Qq0nYhb0ctx27MB+ejvLo3/oJSELQCz+a
        ygjHSpJ6/IkJsvWnr0kX4dssdg==
X-Google-Smtp-Source: AKy350YLh6w5Shjc8huwcoE96gwJYw4jhtiYzybPQVBN5nlIrsOVQwVUiYJF2aU3P+ibqwVitbPzoA==
X-Received: by 2002:a05:6000:1084:b0:2ff:613c:af5f with SMTP id y4-20020a056000108400b002ff613caf5fmr3307546wrw.30.1682071636654;
        Fri, 21 Apr 2023 03:07:16 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8b94:8cac:c190:b98e])
        by smtp.gmail.com with ESMTPSA id u6-20020adff886000000b002f28de9f73bsm4057377wrp.55.2023.04.21.03.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 03:07:16 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: fixes for v6.3
Date:   Fri, 21 Apr 2023 12:07:13 +0200
Message-Id: <20230421100713.39702-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
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

Please pull last two minor fixes from the GPIO subsystem for the upcoming
release. These are two fixes for potential deadlocks in GPIO drivers.

Bart

The following changes since commit 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d:

  Linux 6.3-rc6 (2023-04-09 11:15:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.3

for you to fetch changes up to 2ce987d7eeb168b749494694ae3666de87fc356e:

  gpio: 104-idi-48: Enable use_raw_spinlock for idi48_regmap_config (2023-04-11 21:08:31 +0200)

----------------------------------------------------------------
gpio fixes for v6.3

- use raw_spinlocks in regmaps that are used in interrupt context in
  gpio-104-idi-48 and gpio-104-dio-48e

----------------------------------------------------------------
William Breathitt Gray (2):
      gpio: 104-dio-48e: Enable use_raw_spinlock for dio48e_regmap_config
      gpio: 104-idi-48: Enable use_raw_spinlock for idi48_regmap_config

 drivers/gpio/gpio-104-dio-48e.c | 1 +
 drivers/gpio/gpio-104-idi-48.c  | 1 +
 2 files changed, 2 insertions(+)
