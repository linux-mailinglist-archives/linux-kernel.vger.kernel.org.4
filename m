Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C250E6997FF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjBPOzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjBPOzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:55:46 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95429521F6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:55:43 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d4so2035924wrj.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GYcBJmwo22zXAEb41ec+7a2ghO3grcXFIW0zx/RN0Ao=;
        b=D6b8rwoeHE66moNlWxbd4At4ZlqXKYb+X+3F72Gt1qSuaRvXn1bkFru8o/ffp5idRb
         qniUVuR/SW6eowoiS9OXOsDIdAr5Xz4Tfix9o4makmnFFR2VSIfNc8PG5iccWLINT2q9
         gzWOMoWqMlFeCQEBgI0Q5aQcHocqdWEsMHAJeg7fQEQNwMZz8cMSqZfIPXFZB/j4IE9m
         Rnxb7b//1+sAeFIFLqXWq8sLw8EOlM2QEDMaa4r9EFlXhG8YPfzIw0T2c3rOHJYtVES2
         0OsoTZRYfViTjkS0wnFauGUeGzkVNnJSdb50jw3+jYP89CpcqD3PuWmxWiASLD2sBu+M
         sIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYcBJmwo22zXAEb41ec+7a2ghO3grcXFIW0zx/RN0Ao=;
        b=0qr2y5UosssmRbXYn7b5LWFaCIfRIWhzwxl9KWpPqVOh1uj012ZOpbfeoJL4Pj47Tm
         dDO80gxVurz4Che4nk5Fduzna2MuCHlGEMryPj+EFRQ2HmElWS1qTEp1TFaOQCAO2KAU
         30ZyD4A+vbjOjIV8nH7cLeWM/CjLWeJJwEsAVa9BzWFD3qM7bykFiwFtiMdgUanK6VDh
         sUkPA/8vj9SDFhlpt5RuKm8XeH4KZdByxxOXH0bXNGQDBMz4nGzeL+2od2Rban1CHXUI
         IChvbhKo9UHYbAmkZIyQqFdtW8njdn+i7kf8ZfDbg7EBgzQUSr9y+RvU9F9EccPmqzR3
         DOJw==
X-Gm-Message-State: AO0yUKXEu27hNBb58J7vxHyJID+qI85kmyRZ8f4Gr07RDW0IIR0Hoc4R
        bIumhuP8JsVpAXLbwZed7V1vMw==
X-Google-Smtp-Source: AK7set/gY8GYbV4sja3UZJe1bVwJ2rkyt+w0wuJeP9rAJ+KPlitdNZJkQiTO8K1DHIyF2Ft4tfPzhg==
X-Received: by 2002:a5d:6691:0:b0:2c5:7c26:c2cc with SMTP id l17-20020a5d6691000000b002c57c26c2ccmr2398908wru.29.1676559342079;
        Thu, 16 Feb 2023 06:55:42 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7c5b:1160:db5d:72da])
        by smtp.gmail.com with ESMTPSA id p9-20020adfce09000000b002c5493a17efsm1730012wrn.25.2023.02.16.06.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 06:55:41 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: fixes for v6.2
Date:   Thu, 16 Feb 2023 15:55:36 +0100
Message-Id: <20230216145536.121063-1-brgl@bgdev.pl>
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

Please pull the following set of late fixes for v6.2. Details are in the
signed tag as usual.

Bartosz

The following changes since commit ceaa837f96adb69c0df0397937cd74991d5d821a:

  Linux 6.2-rc8 (2023-02-12 14:10:17 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-fixes-for-v6.2

for you to fetch changes up to b8b3b0bfb742f0cbb006c66b10216b724ce42e25:

  Merge tag 'intel-gpio-v6.2-2' of git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel into gpio/for-current (2023-02-16 13:31:42 +0100)

----------------------------------------------------------------
gpio fixes for v6.2

- fix a potential Kconfig issue with gpio-mlxbf2 not selecting
  GPIOLIB_IRQCHIP
- another immutable irqchip conversion, this time for gpio-vf610
- fix a wakeup issue on Clevo NH5xAx

----------------------------------------------------------------
Alexander Stein (1):
      gpio: vf610: make irq_chip immutable

Bartosz Golaszewski (1):
      Merge tag 'intel-gpio-v6.2-2' of git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel into gpio/for-current

Linus Walleij (1):
      gpio: mlxbf2: select GPIOLIB_IRQCHIP

Raag Jadav (1):
      gpiolib: acpi: remove redundant declaration

Werner Sembach (1):
      gpiolib: acpi: Add a ignore wakeup quirk for Clevo NH5xAx

 drivers/gpio/Kconfig        |  1 +
 drivers/gpio/gpio-vf610.c   | 41 +++++++++++++++++++++++------------------
 drivers/gpio/gpiolib-acpi.c | 12 ++++++++++++
 drivers/gpio/gpiolib-acpi.h |  1 -
 4 files changed, 36 insertions(+), 19 deletions(-)
