Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176926128E9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 09:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJ3IF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 04:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJ3IFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 04:05:25 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607E36408
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 01:05:23 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bs21so11917445wrb.4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 01:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ARXWl72zE64W9sxl9KtUP1FXDgSDHyODIedksNa9+0=;
        b=vrQx0dFI0q1qIYGQiNNtUT2dcuIUQT85jSTM8mpp81vgE6+RoxJs012tJCPK2ocSBQ
         FCOSgeb2tHVkq90yNV86O8VUZlyimoQ4nEkjQQ+md6G8FXyqmq9wzGkA4Ap4RxcFil13
         6o5wMzPC05XPmDaKOBv7QqQKZDKvQs3onq9v8Q6jXdaiL9jOvPZnQyoMwGo85V8dWg/T
         5p6dwikOwNlSYnqQT7BinSFD/DlH9MVs+uuSPyydTiU1aHWzqw9OROoSBS3PrtyQDOhW
         qciMWhvbMOpqVHPTy9hyDfzITWdrJvJ1EZQqwX1VwhfAxmJ5uMVJdSp/S9D2LmkO4arC
         rIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ARXWl72zE64W9sxl9KtUP1FXDgSDHyODIedksNa9+0=;
        b=F62NJzpBsTjXXV0uAxNoX3kJtuP6tiKeMQbZ94JocEJD20NyhmyBxqEatdrttXFoo5
         3q4t3SwiruYhSc2ywOr17J74GDb3A0/G2WCooA6OwDWxUy+V1Fux1MDMuIBUR4rzieWU
         0oZ79G4o8qCrOeCXE2quSVfy0KN1tThcJMZPNiri+U9ztReya73je1bf3rSjihX6ucDf
         W3OG0uaxVoVEQMnrltkNx1x7zlZ8yczDViya+hyUekyK0nW3Od4O5wdWPJdKIOZcFwsa
         3yDzaJms0YZ+34GkksLoPXuobLdV8IehpK9DYL3OOG0q8DcUCObUGaO+HjsyE35bnsJc
         JGTQ==
X-Gm-Message-State: ACrzQf0mZf+Ch+yw/3cF0Z+xRvHZRLXLFBdky3A+UjOL6wI+/Eind4cV
        MkjqeHkLYJ2TZooM7sGY127BEA==
X-Google-Smtp-Source: AMsMyM59bXcF2Xy5aurBDcM2CEEgt1J7miWZNJa2HwaL3mprd3DJF8kVBnw4FO1JmE/PYwlCvH11Vw==
X-Received: by 2002:a05:6000:18a5:b0:231:e0c5:1322 with SMTP id b5-20020a05600018a500b00231e0c51322mr4467314wri.376.1667117121790;
        Sun, 30 Oct 2022 01:05:21 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:41be:1aed:e53f:b9aa])
        by smtp.gmail.com with ESMTPSA id w4-20020a05600c098400b003cf6a55d8e8sm2191995wmp.7.2022.10.30.01.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 01:05:21 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: fixes for v6.1-rc3
Date:   Sun, 30 Oct 2022 09:05:19 +0100
Message-Id: <20221030080519.5467-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.34.1
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

Please pull the following fixes for the next rc. There's an update to the
MAINTAINERS file and another immutable irqchip conversion.

Bartosz

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.1-rc3

for you to fetch changes up to 9ed88fcfb1b08c41bde0381dece84d152d53774c:

  MAINTAINERS: Change myself to a maintainer (2022-10-28 16:50:14 +0200)

----------------------------------------------------------------
gpio: fixes for v6.1-rc3

- convert gpio-tegra to using an immutable irqchip
- MAINTAINERS update

----------------------------------------------------------------
Matti Vaittinen (1):
      MAINTAINERS: Change myself to a maintainer

Svyatoslav Ryhel (1):
      gpio: tegra: Convert to immutable irq chip

 MAINTAINERS               |  4 ++--
 drivers/gpio/gpio-tegra.c | 60 ++++++++++++++++++++++++++++++++++-------------
 2 files changed, 46 insertions(+), 18 deletions(-)
