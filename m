Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DBD72C518
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbjFLMxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbjFLMxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:08 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EB910E0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:52:52 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51480d3e161so6414943a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686574371; x=1689166371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tc9/BWqhD4AJmez8iqRZiPBvpGjiApBjbr87P5AWxy4=;
        b=bxI3s/ctCa9fA+NOsGl6fPNFFjn/s0XFl5dApYrF9/HpcQPLzILsTHc+IV/WSw1Jzk
         u0LS/6w4XKl9KF4MigcdKLcobCorBI8kYflktDTuVTDjO65tIE1HNz1R2Adbh/Qez2p3
         JO9jA3+3eaw8QpgI8btVQroISMWfhEtq9jDp4FBpjLH/YGLvu8a9V8dvi0qU4lb14PQk
         4U9nHiIuOJCTCWT7Ve+2fqvvewv8As8JpXubLWsQItMoUkvsMX+aUFFOr8fnAqSOBvsY
         JMerYUMV8BfSVf0kgNGcdreyfwMTV056zmiokVd+gpWvnZDKTq4mOrXgVBHCaGAzVjAr
         qRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574371; x=1689166371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tc9/BWqhD4AJmez8iqRZiPBvpGjiApBjbr87P5AWxy4=;
        b=efHtY0i9yiaeKcG/nAr9mt8m5nwqXIf7721AZQNtMSNhM9fGlC6aaM9rSvCwaj73yz
         dgz/pdgJqwmAnxjmtF1plVgTKZgmexAO2qmsWzJsS9Rqt1ONQCRupDGqa+9VVKxhcPWf
         vahWvUiq9y6Mq1M+SIDMC03KZFLGtQOxPLrxGdz3GN4nhRFNq9abZx134wTjrfVYHQ7Z
         Q04SPWCYpMGokOfChKPgCLQ7iGXBIAYxS+udt8LKEU0bvDgzOJwKmy8QEfHam8rCCATg
         BvWXILbG3N4eObmvF+Au5/U/UhefqlHk4AKXgT/ko/df6NYWpA8v1pn0T1ghgc+tlwWb
         9KMg==
X-Gm-Message-State: AC+VfDwhe314BxsA8+MUWbUpOQFEa37NyVM/xbfivItC/YFbO8fZtNAf
        8E5++twWMCjCbBCXjj/yzdEdSQ==
X-Google-Smtp-Source: ACHHUZ4VFaNG5tC1669O8IoVV7+32mGE7Ne1/E1fcGrbzLZBnpjey3TQqsAd5ihpB4tpw5NV8e2oXw==
X-Received: by 2002:a05:6402:88e:b0:516:81d3:2627 with SMTP id e14-20020a056402088e00b0051681d32627mr5864164edy.0.1686574370815;
        Mon, 12 Jun 2023 05:52:50 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id r19-20020aa7da13000000b00514aef7daacsm5037522eds.76.2023.06.12.05.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:52:50 -0700 (PDT)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     linus.walleij@linaro.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com, eblanc@baylibre.com,
        u-kumar1@ti.com
Subject: [PATCH v6 0/2] TI TPS6594 PMIC support (RTC, pinctrl, regulators)
Date:   Mon, 12 Jun 2023 14:52:46 +0200
Message-Id: <20230612125248.1235581-1-eblanc@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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


Esteban Blanc (2):
  rtc: tps6594: Add driver for TPS6594 RTC
  pinctrl: tps6594: Add driver for TPS6594 pinctrl and GPIOs

 drivers/pinctrl/Kconfig           |  15 +
 drivers/pinctrl/Makefile          |   1 +
 drivers/pinctrl/pinctrl-tps6594.c | 368 ++++++++++++++++++++++++
 drivers/rtc/Kconfig               |  12 +
 drivers/rtc/Makefile              |   1 +
 drivers/rtc/rtc-tps6594.c         | 452 ++++++++++++++++++++++++++++++
 include/linux/mfd/tps6594.h       |   1 +
 7 files changed, 850 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-tps6594.c
 create mode 100644 drivers/rtc/rtc-tps6594.c

-- 
2.40.1

