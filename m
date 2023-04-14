Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B1C6E205F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjDNKMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjDNKMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:12:22 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C001FF3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:12:20 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v27so7733058wra.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681467138; x=1684059138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l9MrgycC+Ry3nL7aoyHl4KAfyHmCSmhMmAF9BWsea68=;
        b=K8HiVTkvSQxJYCI4yW3lnwUkh9jV5x6ObxprMR+WS4aQ7yszLnCibfeNPIks+jXQIa
         AvQflIkpQDrdhwcGpR8rP2td6lEtZ+sC/LIQ7xKqM8wWgx4hwZdDKcQk8snVi5bRjEdt
         ucskh0eU9/FGWk9/ynHWjE0EHomwaqa0ppzU1ERakIHGX566VPL1K2eucvuR+vqIPFIm
         r/iAaeJ49jj9IrlYpVooU2Am1veUjaaZ4X3gTzIn9y2fyn8dqyi/WbVzAZ3+mmtsszQo
         jR4qalxoQfXeRKHW7lrxxYSrpzwBecTVPPL7CrNrs4uRGfP0TjmrBxB+6Xf5xw2buTme
         yV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681467138; x=1684059138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9MrgycC+Ry3nL7aoyHl4KAfyHmCSmhMmAF9BWsea68=;
        b=fuUExjuif95ItCrzEdPp3Tsnk4gLDPpM661tv47PpjFU1PkJxL1pFAETQCEuNLAQJi
         Fx1RTjpSlsQzoIF9eR9XgVt0FAko874nuRqvbAFVRLyfU4iaJWPG4fCnRnMhQLljWl7X
         KbruGSMSsv3Vp/AaWtXmdg0cDTvUQiVZR4m9VB4JxuiIoVOkASX1JlGqE8piDLSfyn5e
         d/Lof3jAcmpU8fsfo2sP3WfgimHosrCzlZ75h9ecJaKIQrvGXUIyINruPZxEs0QGyqS0
         UEvhoRkpBRX1dJvkqOFiR8BUEbZKVywriN7QdvDZhsgl215fAJh/DfmY4cE8JG3qA2Nl
         dDnQ==
X-Gm-Message-State: AAQBX9cmxMdgCSrG5nKE9v8aiViDLfXmH4nOpPXaqf/zRn5CqzxKvWc7
        0W9X36UHi+1BFe3b6Ks/O/mR+Q==
X-Google-Smtp-Source: AKy350azRtIEGQUorp2nEiC2k00GEzI7nDxBLPnf6oFvBJz5UtGkzrT4KLPGPoJnElkkDU6h2Exbvg==
X-Received: by 2002:a05:6000:12c3:b0:2cb:2775:6e6 with SMTP id l3-20020a05600012c300b002cb277506e6mr3489731wrx.45.1681467138545;
        Fri, 14 Apr 2023 03:12:18 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:eca6:27f0:42a5:8f07:826a:465d])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c3b0a00b003ef5e5f93f5sm7612923wms.19.2023.04.14.03.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 03:12:17 -0700 (PDT)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com, sterzik@ti.com,
        u-kumar1@ti.com
Subject: [PATCH v3 0/3] TI TPS6594 PMIC support (RTC, pinctrl, regulators)
Date:   Fri, 14 Apr 2023 12:12:14 +0200
Message-Id: <20230414101217.1342891-1-eblanc@baylibre.com>
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
- https://lore.kernel.org/all/20230406075622.8990-1-jpanis@baylibre.com/
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

Esteban Blanc (2):
  rtc: tps6594: add driver for TPS6594 PMIC RTC
  pinctrl: tps6594: add for TPS6594 PMIC

Jerome Neanne (1):
  regulator: tps6594-regulator: Add driver for TI TPS6594 regulators

 drivers/pinctrl/Kconfig               |  10 +
 drivers/pinctrl/Makefile              |   1 +
 drivers/pinctrl/pinctrl-tps6594.c     | 365 +++++++++++++++
 drivers/regulator/Kconfig             |  13 +
 drivers/regulator/Makefile            |   1 +
 drivers/regulator/tps6594-regulator.c | 620 ++++++++++++++++++++++++++
 drivers/rtc/Kconfig                   |   9 +
 drivers/rtc/Makefile                  |   1 +
 drivers/rtc/rtc-tps6594.c             | 473 ++++++++++++++++++++
 9 files changed, 1493 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-tps6594.c
 create mode 100644 drivers/regulator/tps6594-regulator.c
 create mode 100644 drivers/rtc/rtc-tps6594.c

-- 
2.39.2

