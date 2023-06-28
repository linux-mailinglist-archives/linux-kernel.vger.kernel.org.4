Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E8A74127A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjF1NbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjF1Na2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:30:28 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CED6210E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:30:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fafe87c6fbso5837980e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687959023; x=1690551023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BXYQ3UvRxgd/GOjXjwkmXpmmOQaoDxWZO5ds+5aOCbQ=;
        b=VXCNU3Ql55wNm5mKZKjQHVq64XCj73HgsVvJ+ebjBGS3Xk4k8nOVzo6ebkeCJdxwmO
         a7jOTZ40IGo3LWv1RkZGvxO7GOr1izFvcH9ig7xTn2GCQwyJU3ejuJRoUzjcOPWuTgV3
         AY+jtzXOTzXQWvBDqR+BhQQjWpoo43m1WPxhfpNyg9BxtRBovUAEO94OBossbR1uZy3u
         KJHW1OqxjyDyPiJtJtFGgBRwJ7UBaScQfpZQIpfjXOiETHZ7Jo7fzD59XOSpQIU89ceP
         2JJLCNWAoCa2d68DE4w+RVTBrHTw/v3TyHBXRtM1+HjefjPvxWeGUmB4mnpu2sRVV3Ju
         tinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687959023; x=1690551023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXYQ3UvRxgd/GOjXjwkmXpmmOQaoDxWZO5ds+5aOCbQ=;
        b=eqsPrbLMj2D9NPJPYpWIoWjr+anwQT6KsiWENp/Gcavyt7QMaceCZGCLDs/q0wh2/7
         5VGT5lEGUp+sCofe3oK+K1/BeG/FShMnB+g9StgiyH8DUOu/09YPAvhBxIm4ipdPvMSA
         GV/VSbNAxv0aI8XWpIC6a1E8OQRbEnP49TOCQ1yBjnjp28VtibN5W0MdAuLs9dZN8XJX
         YFq8I+n3VE+AjBnNpkUqzbkbrklPwneOyeQqPf9wEeLLsULboDThnrBoYduwuu8XBz3p
         4WQN73xOSpsmHryV079CtPAKQS/GgoW1+Dfd3KXgNya5I46cIn/Q5dKQcoFJzRKxJsjA
         7csw==
X-Gm-Message-State: AC+VfDxqqz6wd0iIIMRtyyIhdliesT/JZyjvj10Ibk/A3hk/Vpqt0buU
        CuVhBf8sQdttQcvb3E4ivq2d6w==
X-Google-Smtp-Source: ACHHUZ6k60XfBnhvzXKMM7ViB35mVDerfENg0F+/+gCPAI697ws7nV9ugBk+f/HD6Z5Xi9JepNsKmw==
X-Received: by 2002:a19:5e47:0:b0:4f3:b708:f554 with SMTP id z7-20020a195e47000000b004f3b708f554mr19235829lfi.47.1687959023108;
        Wed, 28 Jun 2023 06:30:23 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:28d:66d0:c6d7:ee89:d0ff:2f52])
        by smtp.gmail.com with ESMTPSA id z7-20020a05600c220700b003fa999cefc0sm8067994wml.36.2023.06.28.06.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 06:30:22 -0700 (PDT)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     linus.walleij@linaro.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com, eblanc@baylibre.com,
        u-kumar1@ti.com
Subject: [PATCH v7 0/2] TI TPS6594 PMIC support (RTC, pinctrl, regulators)
Date:   Wed, 28 Jun 2023 15:30:19 +0200
Message-ID: <20230628133021.500477-1-eblanc@baylibre.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPS6594 is a Power Management IC which provides regulators and others
features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
PFSM (Pre-configurable Finite State Machine). The SoC and the PMIC can
communicate through the I2C or SPI interfaces.
TPS6594 is the super-set device while TPS6593 and LP8764 are derivatives.

This series adds support to TI TPS6594 PMIC and its derivatives.

This should be applied on top of other patch series:
- https://lore.kernel.org/all/20230511095126.105104-1-jpanis@baylibre.com/
  For core MFD driver. The necessary part of this patch series is already
  applied in linux-next.

The features implemented in this series are:
- RTC (child device)
- Pinmux/GPIO (child device)
- Regulator (child device)

RTC description:
The TPS6594 family has an RTC built-in, except for LP8764.
It provides time and an alarm.

Pinmux/GPIO:
TPS6594 family has 11 GPIOs. Those GPIO can also serve different
functions such as I2C or SPI interface, watchdog disable functions.
The driver provides both pinmuxing for the functions and GPIO capability.

Regulator:
TPS6594/TPS6593: 5 BUCKs and 4LDOs
LP8764: 4 BUCKs and no LDO
Bucks can be used in multipahse mode.

Regulators were applied to linux-next by Mark Brown on 06/06/2023 so this
patch has been dropped from the patch series.
There were some pending comments from Andy Shevchenko so a follow up patch will
be sent later.

Changes since v1:
https://lore.kernel.org/all/20230224133129.887203-1-eblanc@baylibre.com/
Rtc:
- Removed struct tps6594_rtc.
- Removed some dev_err messages.
- Removed some comments.
- Remove some whitespaces in comments and error messages.
- Check if RTC is running before reading a timestamp in read_rtc.
- Stop RTC at the end of probe to wait for a timestamp to be set.
- Add default MFD_TPS6594 to Kconfig.

Pinctrl:
- Removed #define DEBUG.
- Add default MFD_TPS6594 to Kconfig.
- Fix typo and reword help message of Kconfig.

Regulators:
Further to Mark Brown review:
- File header whole block C++ style.
- Configuring modes not supported: omit all mode operations
- Log the error before notifying.
- Request the interrupts while registering the regulators (then remove
  the lookup function).
Further to Matti review:
- Postponed: devm_regulator_irq_helper() and
  regulator_irq_map_event_simple() can probably be used but code.
  refactoring is not so trivial. This can be done later as an enhancement
  after this patch list is merged.
Buck Multi phase management:
- Multiphase property can take an array when 2 multi phase buck, buck12
  and buck34.
- Configuration multi phase buck34 without multiphase buck12 is not
  supported (when only one multiphase, must be buck12). Not clear from the
  spec but confirmed by TI.
- Supported multiphase conficurations: buck12, buck123, buck1234,
  buck12 + buck34.
- All interrupts are attached to the multiphase buck (ie: for regulator
  buck12, buck1 & buck2 interrupts are registered).

Changes since v2:
https://lore.kernel.org/all/20230328091448.648452-1-eblanc@baylibre.com/
Rtc:
- Add logic to avoid reinitializing a working clock.
- Fix some multiline comments format.

Regulators:
Further to Mark Brown review:
- Log the error before notifying.
- Request the interrupts while registering the regulators.
Further to Krzysztof Kozlowski:
https://lore.kernel.org/all/75f0a18d-aed9-8610-2925-4e604b4b0241@baylibre.com/
- Remove ti, multi-phase-id property which is redundant with buck dts naming
  rules.

Changes since v3:
https://lore.kernel.org/lkml/20230414101217.1342891-1-eblanc@baylibre.com/
RTC:
- Add wakeup source

Pinctrl:
- Switch to GPIO_REGMAP framework

Change since v4:
https://lore.kernel.org/lkml/20230512141755.1712358-1-eblanc@baylibre.com/
Update Copyright notice date
Reorder includes

RTC:
- Rework some comments, fixing punctuation and style
- Use NANO macro from units.h for PPB_MULT
- Rework to use bitwise types
- Remove unnecessary casts
- Add SAFETY comments
- Use `dev_err_probe(...)` instead of print then return

Pinctrl:
- Reword help message and add module name in Kconfig
- Rework code to use struct pinfunction and PINCTRL_PINFUNCTION() macro
- Remove unnecessary casts
- Use `dev_err_probe(...)` instead of print then return
- Replace TPS6594_REG_GPIO1_CONF with a comment for TPS6594_REG_GPIOX_CONF

Regulators:
- nits: Add missing tabs, standard spaces, group "buck_multi".
- Use OF dedicated of_node_cmp API instead of standard strcmp.
- Use devm_kmalloc_array(...) API instead of devm_kmalloc(...) wherever
  possible.
- return dev_err_probe(...) wherever possible.

Changes since v5:
https://lore.kernel.org/lkml/20230522163115.2592883-1-eblanc@baylibre.com/

Pinctrl:
- Rework code for clarity
- Rework macro to fix checkpatch macro argument reuse
- Coding style fixes
- Reword some comments

Rtc:
- Grammar fixes
- Removed unused macros
- Use type MIN/MAX macro instead of magic numbers
- Fix return code in calibration
- Use cpu_to_le16 and le16_to_cpu APIs instead of casting.
- Reintroduce mdelay before reading BIT_RUN as otherwise both AM62 and J784S4
  will report a -ENODEV on a working RTC.

Changes since v6:
https://lore.kernel.org/all/20230612125248.1235581-1-eblanc@baylibre.com/

Pinctrl:
- Remove a comment

Esteban Blanc (2):
  rtc: tps6594: Add driver for TPS6594 RTC
  pinctrl: tps6594: Add driver for TPS6594 pinctrl and GPIOs

 drivers/pinctrl/Kconfig           |  15 +
 drivers/pinctrl/Makefile          |   1 +
 drivers/pinctrl/pinctrl-tps6594.c | 368 ++++++++++++++++++++++++
 drivers/rtc/Kconfig               |  12 +
 drivers/rtc/Makefile              |   1 +
 drivers/rtc/rtc-tps6594.c         | 452 ++++++++++++++++++++++++++++++
 6 files changed, 849 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-tps6594.c
 create mode 100644 drivers/rtc/rtc-tps6594.c

-- 
2.41.0

