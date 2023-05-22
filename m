Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159EA70C375
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjEVQbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjEVQbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:31:45 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D67106
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:31:20 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30a992a9c3eso50838f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684773077; x=1687365077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xEgmNUrCbeG3nZlq74WNQ3yrX7mau9NSkmXEo6FUUAU=;
        b=k99GXKqq6ArbLO0akmS22DhTmqBRgpXKczmvvCUedCZXXMcpA9pKO41awPHjGf9bfV
         0RZ8xfApaLvY/dVBErVlqDdXnwkoeltP80DUNSiy2O4qQ7MzdjodQvEj6yNKWDzyVO6b
         rt0teRogHetUPjN3WTgFJXFg1DHGn7n/SoPaEsGGF3cI4w2RaRlTZVVr93AL5l4n2pcE
         CWD2mVU36edsbCN/W5yOymsFOTCsQpQTVJE5D2PdobThG0jaKh91oTuzHGAtxNP8YZuM
         gzKX1Wcxim0N+Mjoy/qUQ5URyi5nYPq732CcGUneNbXGjYhJz0UeTNNjvjJUUWfm0BXE
         mNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773077; x=1687365077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEgmNUrCbeG3nZlq74WNQ3yrX7mau9NSkmXEo6FUUAU=;
        b=kE0C/w/F8vhX9D2D+F+MIKmoloa1g17QU4yPG3FVhbO3TObH2I3tc1ZYvEaIm3dXxD
         edgUGAUeFXsqrXDw9iY0yeinFiudY8Q7tESuLzraalneG83m3qP2ht+HuFg4OLCwJY2J
         9ln1CpWhr9VRV/4AZuCb9xEJlC0YGL62Da0GGYaXKRWaCl+ruEFvVr8srXIGZ3nEIF85
         /UWl6cBrgX92M17oUVD+CI/5CpS/KO2rG8VlZgvCSSe3lukeAUeUJKhJhpnUEvQptDLo
         VbmNK89vDroZBEDj8l5Iazcxm5xNVzcAqw9grKQaMVMh4liPVrIezs+OkPyNTtDeMWcN
         KpVg==
X-Gm-Message-State: AC+VfDyOs2mTHPI+DbnK9w978sCXddJFhXO2n5PpG695T+Po5bqMlXvB
        RzBsojwzLkGkvVPlDiARRc5R0w==
X-Google-Smtp-Source: ACHHUZ5kPwgWlK+OxdMeEYOg+PItWvIcvwUOLDdDk0yt/yTA0g0xlvUWMyS8J+37lXLMzAzzya+MQA==
X-Received: by 2002:adf:fa01:0:b0:306:3163:2b76 with SMTP id m1-20020adffa01000000b0030631632b76mr7780474wrr.15.1684773076870;
        Mon, 22 May 2023 09:31:16 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:28d:66d0:72d:52cc:8221:fcda])
        by smtp.gmail.com with ESMTPSA id y10-20020adff6ca000000b002f103ca90cdsm8152677wrp.101.2023.05.22.09.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:31:16 -0700 (PDT)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com, eblanc@baylibre.com,
        u-kumar1@ti.com
Subject: [PATCH v5 0/3] TI TPS6594 PMIC support (RTC, pinctrl, regulators)
Date:   Mon, 22 May 2023 18:31:12 +0200
Message-Id: <20230522163115.2592883-1-eblanc@baylibre.com>
X-Mailer: git-send-email 2.39.2
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
  For core MFD driver

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
- Use devm_kmalloc_array(...) API instead of devm_kmalloc(...) wherever possible.
- return dev_err_probe(...) wherever possible.

Esteban Blanc (2):
  rtc: tps6594: Add driver for TPS6594 RTC
  pinctrl: tps6594: Add driver for TPS6594 pinctrl and GPIOs

Jerome Neanne (1):
  regulator: tps6594-regulator: Add driver for TI TPS6594 regulators

 drivers/pinctrl/Kconfig               |  13 +
 drivers/pinctrl/Makefile              |   1 +
 drivers/pinctrl/pinctrl-tps6594.c     | 367 +++++++++++++++
 drivers/regulator/Kconfig             |  13 +
 drivers/regulator/Makefile            |   1 +
 drivers/regulator/tps6594-regulator.c | 615 ++++++++++++++++++++++++++
 drivers/rtc/Kconfig                   |  12 +
 drivers/rtc/Makefile                  |   1 +
 drivers/rtc/rtc-tps6594.c             | 463 +++++++++++++++++++
 include/linux/mfd/tps6594.h           |   3 +-
 10 files changed, 1488 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pinctrl/pinctrl-tps6594.c
 create mode 100644 drivers/regulator/tps6594-regulator.c
 create mode 100644 drivers/rtc/rtc-tps6594.c

-- 
2.39.2

