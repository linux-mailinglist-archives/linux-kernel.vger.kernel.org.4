Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD5171282C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243472AbjEZOYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjEZOYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:24:16 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98608194
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 07:24:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f6da07ff00so8830995e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 07:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1685111052; x=1687703052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y7S62GocSLRRtyqgzGIn0AzmW6WJ4QYVH493qeVtDqs=;
        b=yMGW5IdjQ+134HvRu/YXXxZpF35Yu80wGdtkeJYIjNeq2B7XJ+4/DAnwhtJKRucF00
         hysX0dR0an/y/twKgOvWkrriKFIPJ/mWXYeDtC0gPR02Skqh18sbh32WGtwqslZBeHwN
         ATAcAknqGWWob9yORgVm0hNt79ERjbeFf+285RA/gHdWoD7WjaffBijazwdA3yRjmhrU
         3UUJYEKI8wSJ1ouUmY4w2HL9KPFW5suYxQXuRjW8ljv7CEAMvv0pVwlqtWcr0+RnvVzN
         5wNJvNkfy4c2MoXFbl+v9m9uEXtB+O8Kg/zONFWC2D1R8Ad1hkdsivkrhsGiJJAXdVP3
         CVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685111052; x=1687703052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7S62GocSLRRtyqgzGIn0AzmW6WJ4QYVH493qeVtDqs=;
        b=jIPQsC1W5PZzXxKh80nfNDEQgQFx42b5ODdtxdXfO+5s3yB+Q6U+RKnlLX79jIJR+e
         WJ5jp8PUprMbwNcELl1oE62KjPMNwyMJGIIK+tsaqMQpOkCL3exW5U23YHFp3Yex0IO4
         V/BPK/cXZxTCT1gocMoXvEKE1rILFElcBQ8J+tLM16AqHyNsockdbuQvC5kSbgkUgnCO
         zeTY6wFCMT5Y/ah+osZ3eSXuXiaw9cYxVK1lpzGLFtTjQYbjgoMItZhcY9u3PAfAjIZp
         176LF05rI04rfGqp8k/Nr0MLpadvlKWNzQkjr7FzjuMBCkS2Lr2sKNQJ49HO+7FagkLu
         m8Ng==
X-Gm-Message-State: AC+VfDyyX+oYVce8bz4EMGGZWdf2iJm/tlSSYL0dJx2Yol5+hgbs1fU7
        b3AWoBIglZ/WeARD84yN+R4ZEg==
X-Google-Smtp-Source: ACHHUZ79yY2OGpXf/LdoaT5u9sbMjRfE2L926GdHKf+zcYVSPKt0L6kvrnJh7My6C5pHsZeZCF+UBg==
X-Received: by 2002:a7b:cd15:0:b0:3f6:eff:279a with SMTP id f21-20020a7bcd15000000b003f60eff279amr1630510wmj.9.1685111052072;
        Fri, 26 May 2023 07:24:12 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6afe:9c96:4503:ff6b])
        by smtp.gmail.com with ESMTPSA id q21-20020a1ce915000000b003f421979398sm8929762wmc.26.2023.05.26.07.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 07:24:11 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: fixes for v6.4-rc4
Date:   Fri, 26 May 2023 16:24:07 +0200
Message-Id: <20230526142407.67019-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following set of GPIO fixes for the next RC.

Thanks,
Bartosz Golaszewski

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.4-rc4

for you to fetch changes up to 3002b8642f016d7fe3ff56240dacea1075f6b877:

  gpio-f7188x: fix chip name and pin count on Nuvoton chip (2023-05-23 10:47:41 +0200)

----------------------------------------------------------------
gpio fixes for v6.4-rc4

- fix incorrect output in in-tree gpio tools
- fix a shell coding issue in gpio-sim selftests
- correctly set the permissions for debugfs attributes exposed by gpio-mockup
- fix chip name and pin count in gpio-f7188x for one of the supported models
- fix numberspace pollution when using dynamically and statically allocated
  GPIOs together

----------------------------------------------------------------
Andreas Kemnade (1):
      gpiolib: fix allocation of mixed dynamic/static GPIOs

Henning Schild (1):
      gpio-f7188x: fix chip name and pin count on Nuvoton chip

Milo Spadacini (1):
      tools: gpio: fix debounce_period_us output of lsgpio

Mirsad Todorovac (1):
      selftests: gpio: gpio-sim: Fix BUG: test FAILED due to recent change

Zev Weiss (1):
      gpio: mockup: Fix mode of debugfs files

 drivers/gpio/Kconfig                     |  2 +-
 drivers/gpio/gpio-f7188x.c               | 28 ++++++++++++++--------------
 drivers/gpio/gpio-mockup.c               |  2 +-
 drivers/gpio/gpiolib.c                   |  2 ++
 tools/gpio/lsgpio.c                      |  2 +-
 tools/testing/selftests/gpio/gpio-sim.sh |  3 +++
 6 files changed, 22 insertions(+), 17 deletions(-)
