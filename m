Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090106FB959
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjEHVUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbjEHVUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:20:21 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFF146A1
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 14:20:18 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f14e499ffcso3893134e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 14:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683580817; x=1686172817;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IGmMY4cFYvub/clQpB9xxbh8ZPTyTBA5bKwsVjExFt8=;
        b=hnDIGupHnzHEc4dn/xiFRx2xgE0PKkJ2mto8ff+Kf8c6LDZ58V3IYyWjMNUwp2Hm+W
         DRKUFeRCHtdkcSruq4m7qJStKaSAlicxluxyTXJgvO9mLLCAkTlsnpgQZ4ftjzex5qJG
         cqCkuY7qP4Ifn+d6+p0uFdza2LUY5cHBUGFYC0gjgS6WUz1LlhbhFSkUfTSgZ/1aC27P
         +nJQrbzs0vXwF9HrYfTcolEb9FnMHclNWNauzeCYOSOa8+G9U8o5wXcWDxyxhIqcaBUP
         kl2g4S/o5B8f5w9oa/ijh2CbkxzP1JzPxwj7jAqkapA2qsqFFQt+8rczVzeguZILpoVY
         BjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683580817; x=1686172817;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGmMY4cFYvub/clQpB9xxbh8ZPTyTBA5bKwsVjExFt8=;
        b=VehHq8QhWO02Jpdz1Zd3N/Ut72udDsKHc85cBEQxFV3M5DSdOYFmLP1V9xrgdxQHxy
         jhKruBwFnsqwAR80hxffHZMyHu7TDWffUVdeYQpDw1wPjvvZJuksSb40/G3H8gycaim1
         pErqs22u6I32T/7lFND3brwf0BHDZ0BtaRVmx3LvRbKzbxdtGYT8C0W6mR+CAF4q1Qe8
         A7HH2I67nJwLLuEqyrDv7ELSGvDoESvUVpwPVmQDc3KihJo6DfQBLnVtE25RWcRRgtXT
         t07EIZuejF4uu+yo9t96IGIId8DNW2cZATBPddofkb5HsJkkqj8RBJ6BP9FDQ1Knkv8o
         hMxQ==
X-Gm-Message-State: AC+VfDyYRMbUVdTTQiadFBnpVhrDBx+mdY+dZbNoxbsD2PS9nIisqROP
        q+TQzfSd5TWjoplJ1CVtUifzUQ==
X-Google-Smtp-Source: ACHHUZ5hMWUD2Rfk872Q5ABdWR0891gFHqp5vXyAmMCR5GLf9FGIiM4VlXZjdQViiPMYCvUsZc100A==
X-Received: by 2002:ac2:442a:0:b0:4f1:4a22:b2c5 with SMTP id w10-20020ac2442a000000b004f14a22b2c5mr109178lfl.55.1683580816653;
        Mon, 08 May 2023 14:20:16 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 4-20020ac24844000000b004edc3bd7fa1sm102164lfy.201.2023.05.08.14.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 14:20:16 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v4 0/4] Fix up Nokia 770 regression
Date:   Mon, 08 May 2023 23:20:05 +0200
Message-Id: <20230430-nokia770-regression-v4-0-9b6dc5536b17@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIVnWWQC/42NQQ7CIBBFr2JYi0GgtrjyHsbF0E5booIZGqJpe
 nehO2NiXP4/89+bWURyGNlxMzPC5KILPge93bB2BD8gd13OTAqphFaC+3B1UNeCEw6EsfxzaSs
 QtTY1toblpYWI3BL4dizbO8QJqRwehL17rrrzJefRxSnQa7WnfWl/i9KeC25yqVEdrDD6dHMeK
 OwCDawAk/wDIguk0dipFiqtvyHqD4jKEDh0AhrT99DYD8iyLG9wrP+4WgEAAA==
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Helge Deller <deller@gmx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent change to use dynamic GPIO base allocation in the
OMAP GPIO driver caused a regression in some OMAP1 boards.
This series fixes up the Nokia 770 board from 2005:
https://en.wikipedia.org/wiki/Nokia_770_Internet_Tablet

I don't know how urgent the fix is, you decide. For me,
it is fair if fringe systems get fixed in due time, as
they are hardly anyones main development laptop.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v4:
- Fix up the polarity issues identified by Dmitry.
- Fix all erronous device trees as well.
- Link to v3: https://lore.kernel.org/r/20230430-nokia770-regression-v3-0-a6d0a89ffa8b@linaro.org

Changes in v3:
- Fix a compile error in the ADS7846 driver by dropping some
  leftover OF ifdeffery.
- Link to v2: https://lore.kernel.org/r/20230430-nokia770-regression-v2-0-984ed3ca5444@linaro.org

Changes in v2:
- Thoroughly rewrote the approach taken for the ADS7846 touchscreen
  following Dmitry's ambition to go a step further and take a swnode
  approach to this conversion: I'm fine with that, the patch just
  get a bit bigger.
- Picked up Ulf's ACK on the MMC patch.
- Link to v1: https://lore.kernel.org/r/20230430-nokia770-regression-v1-0-97704e36b094@linaro.org

---
Linus Walleij (4):
      Input: ads7846 - Convert to use software nodes
      ARM/mmc: Convert old mmci-omap to GPIO descriptors
      ARM: omap1: Fix up the Nokia 770 board device IRQs
      ARM: dts: Fix erroneous ADS touchscreen polarities

 arch/arm/boot/dts/am57xx-cl-som-am57x.dts          |   2 +-
 arch/arm/boot/dts/at91sam9261ek.dts                |   2 +-
 arch/arm/boot/dts/imx7d-pico-hobbit.dts            |   2 +-
 arch/arm/boot/dts/imx7d-sdb.dts                    |   2 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |   2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi |   2 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |   2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi    |   2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi    |   2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi        |   2 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                 |   2 +-
 arch/arm/mach-omap1/board-nokia770.c               | 198 +++++++++++++--------
 arch/arm/mach-omap1/board-sx1-mmc.c                |   1 -
 arch/arm/mach-omap2/board-n8x0.c                   |  85 +++------
 arch/arm/mach-pxa/spitz.c                          |  11 +-
 arch/mips/alchemy/devboards/db1000.c               |  11 +-
 drivers/input/touchscreen/ads7846.c                | 113 +++++-------
 drivers/mmc/host/omap.c                            |  46 ++++-
 drivers/video/fbdev/omap/lcd_mipid.c               |  10 ++
 include/linux/platform_data/lcd-mipid.h            |   2 -
 include/linux/platform_data/mmc-omap.h             |   2 -
 include/linux/spi/ads7846.h                        |   2 -
 22 files changed, 273 insertions(+), 230 deletions(-)
---
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230430-nokia770-regression-2b5a07497ec9

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

