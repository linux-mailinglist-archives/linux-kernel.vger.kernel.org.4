Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E453A5E5FA2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiIVKQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiIVKQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:16:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ECEDC100
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 03:16:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id s14so12735568wro.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 03:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=jt29Zip5DTbXeadWc4WPMTHajH1BONuxncVgTB+OkRs=;
        b=znqW2ai4nrGMnmGPBeZNsLMrHuY1t1WIj1Fph3mFJSi7NId+KJFt8gMyuGxeyQuhNy
         xTItnlH1TcPRwXqQiCDHlG6O6qiUoER4PKoQQ+XN33Aa10zj9XhSoqz0sAKmK3FgAosX
         g7BFFlBXRrk2EoIHE05qL6wsUHEhfqYzonVtSvrZe5ioPyZ+UdRA58jI4dTMy9238P6l
         pT3s6JHQqNDXr3KtfuPcYi5+stgmjXRNL/gDIu/073fapBVk8PHKfatDW00mHJBxyjrz
         ghiaENdn2fDp9PN7OBS/wN2enkV9GtMXqXwt8Wspiva7A/HP7SPO8AfolaDmIWYqyCA0
         r5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=jt29Zip5DTbXeadWc4WPMTHajH1BONuxncVgTB+OkRs=;
        b=anOocg4RgwHbuzXLcDo0iLvIxfn1XIGKBiRX05d/MavFlI9YE/cDng4zZOEk4bm9X3
         OaFpgC8+RWR41cLp4oOmVqtyaK525kISQWRcjPGkNREpPuL3L+w5thm2j1f2AMHS4RaI
         yLPvga2Cl0PjOeo4zjo8YVeyjCE3LneB8/BEszmhfU60197hSOUjeoyAd/ANtsdBqKpr
         qOc19qryNnEvGDlRRM4KjlvnbTPZ9GtLsuKlB555h/k/dRsS0iiCa8/OpWy3Y+BX4/m7
         ezXsTlsrfNSGnjU9W+9FktVosOvmEWSjb6XheXqz3pDzg1zPaF9YN/LrCAGF3ukhu3DI
         ycSg==
X-Gm-Message-State: ACrzQf0AeUdCGE83ej7DiMBTI+UrBRkl/W/PRrtMTZqVDZE2Y7O4T/l0
        NYg6ZrYGV8z9er5qmTYmSoe/zqIorwkxLw==
X-Google-Smtp-Source: AMsMyM67ny1AS8JpNfuCerV6Yx9Otle44pFJud6eBytSl7YPl1ez3QiZ7StZRfLpbnMM9O6QVLri5w==
X-Received: by 2002:adf:fd09:0:b0:22a:f514:d7b7 with SMTP id e9-20020adffd09000000b0022af514d7b7mr1489929wrr.430.1663841776673;
        Thu, 22 Sep 2022 03:16:16 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8b36:6d:2c67:43fd])
        by smtp.gmail.com with ESMTPSA id z10-20020adfec8a000000b0022afe4fb459sm4688057wrn.51.2022.09.22.03.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 03:16:16 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: fixes for v6.0-rc7
Date:   Thu, 22 Sep 2022 12:16:14 +0200
Message-Id: <20220922101614.118590-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.34.1
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

Linus,

Please pull the following set of simple fixes for the next rc.

Thanks
Bartosz

The following changes since commit 521a547ced6477c54b4b0cc206000406c221b4d6:

  Linux 6.0-rc6 (2022-09-18 13:44:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.0-rc7

for you to fetch changes up to 69bef19d6b9700e96285f4b4e28691cda3dcd0d1:

  gpiolib: cdev: Set lineevent_state::irq after IRQ register successfully (2022-09-21 09:32:11 +0200)

----------------------------------------------------------------
gpio fixes for v6.0-rc7

- fix a NULL-pointer dereference at driver unbind and a potential
  resource leak in error path in gpio-mockup
- make the irqchip immutable in gpio-ftgpio010
- fix dereferencing a potentially uninitialized variable in gpio-tqmx86
- fix interrupt registering in gpiolib's character device code

----------------------------------------------------------------
Andy Shevchenko (1):
      gpio: mockup: Fix potential resource leakage when register a chip

Bartosz Golaszewski (1):
      gpio: mockup: fix NULL pointer dereference when removing debugfs

Dongliang Mu (1):
      gpio: tqmx86: fix uninitialized variable girq

Linus Walleij (1):
      gpio: ftgpio010: Make irqchip immutable

Meng Li (1):
      gpiolib: cdev: Set lineevent_state::irq after IRQ register successfully

 drivers/gpio/gpio-ftgpio010.c | 22 +++++++++++++---------
 drivers/gpio/gpio-mockup.c    |  6 ++++--
 drivers/gpio/gpio-tqmx86.c    |  4 ++--
 drivers/gpio/gpiolib-cdev.c   |  5 +++--
 4 files changed, 22 insertions(+), 15 deletions(-)
