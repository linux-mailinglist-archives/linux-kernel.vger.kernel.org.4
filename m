Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D9F6CBA42
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjC1JO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjC1JO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:14:57 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0656559C9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:14:52 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso8946339wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679994890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lfenbcvOkh+f1Uh0PDVq73BIzXomZhagarYISRp/zss=;
        b=1IanOJ0gc9CDQHoJordLFIfqit+1/OrhVhbTxlUcPddqeGmXmPqMwFn6wr379Oy8Co
         gQEpCzS2OyqPgGkpP8DXXxnPEgoWp6OtJ9KRCei0hfni2c1S+wMEL2HVU19y/ghrXgL+
         bLqKRciJC2ZBLppeSkcZtd5/DE/Jkgk4uO7NhrUHo1hUn40uXGCyG4Nj7Cy8GX7l6tCR
         vjXQyTxejypufTCr+MqsygI0eZbMgaG5jWSiPGk3wTWtkrTkAw4Ft2rGXNiemtVFAOO5
         inKPod3wIR/2NlC1v00SgYfOS/CbCvJkgVzktKdULKH4BuznVkkaEnzT+zpyoPkJwc7Y
         5n8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679994890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfenbcvOkh+f1Uh0PDVq73BIzXomZhagarYISRp/zss=;
        b=uXHoqfv7HO/dgKfaIxyaPYIQUA7COPkrPXgk9A88RI1IeEEJ0C5NQcBhxFcWkhELJf
         Aj99y3zq6ZSfZpP48TAdMAu1ZYK4A15b24/uqPeo48Vf1X4TOqIrC7PNH+fyVJHiuiTN
         jvSSP9berVEEOqdLGR8W5qSMrLhfx0hNEP66HaIAk10TLnbDWuzjGpXfY+OMEMMKo1jy
         BdmGt8Tqyiv9XCh7f0/nHu+084XbeDbPrexmYZdFSgvcvOaXbBoqZb7gX51kI05UAMNt
         /Fq8NWGpxcpUoc+LeU81Ny8mZ2XL+0xul1y1M31U63RPlz1eRWuoyU0rVoPT0MUY5KH1
         8Z8g==
X-Gm-Message-State: AO0yUKWc5PzdxIIR2VfeXH52JL5LPWVcr8fTKqluziSdSsHe+K5ZlAzw
        RxZCFxH9nICOL/bjBg9L3bMmfA==
X-Google-Smtp-Source: AK7set9BwIJH/4YmdTurO5uBMJGBtmNLkNwFEh/QvI2U6HGOx7utWxhxzMJjaxTbo4rOfhWltSo/tA==
X-Received: by 2002:a05:600c:20d:b0:3ed:6693:138d with SMTP id 13-20020a05600c020d00b003ed6693138dmr11483139wmi.4.1679994890417;
        Tue, 28 Mar 2023 02:14:50 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:28d:66d0:910e:c4d8:1565:354])
        by smtp.gmail.com with ESMTPSA id p20-20020a7bcc94000000b003edd1c44b57sm16381115wma.27.2023.03.28.02.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 02:14:50 -0700 (PDT)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, sterzik@ti.com, u-kumar1@ti.com
Subject: [PATCH v2 0/3] TI TPS6594 PMIC support (RTC, pinctrl, regulators, device trees)
Date:   Tue, 28 Mar 2023 11:14:45 +0200
Message-Id: <20230328091448.648452-1-eblanc@baylibre.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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
- https://lore.kernel.org/all/20230216114410.183489-1-jpanis@baylibre.com/
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
Bucks can be used in multipahse mode

Changes since v1:
Rtc:
- Removed struct tps6594_rtc
- Removed some dev_err messages
- Removed some comments
- Remove some whitespaces in comments and error messages
- Check if RTC is running before reading a timestamp in read_rtc
- Stop RTC at the end of probe to wait for a timestamp to be set
- Add default MFD_TPS6594 to Kconfig

Pinctrl:
- Removed #define DEBUG
- Add default MFD_TPS6594 to Kconfig
- Fix typo and reword help message of Kconfig

Regulators:
Further to Mark Brown review:
- File header whole block C++ style
- Configuring modes not supported: omit all mode operations
- Log the error before notifying
- Request the interrupts while registering the regulators (then remove
  the lookup function)
Further to Matti review:
- Postponed: devm_regulator_irq_helper() and 
  regulator_irq_map_event_simple() can probably be used but code
  refactoring is not so trivial. This can be done later as an enhancement
  after this patch list is merged. 
Buck Multi phase management:
- Multiphase property can take an array when 2 multi phase buck, buck12
  and buck34
- Configuration multi phase buck34 without multiphase buck12 is not
  supported (when only one multiphase, must be buck12). Not clear from the
  spec but confirmed by TI.
- Supported multiphase conficurations: buck12, buck123, buck1234, 
  buck12 + buck34
- All interrupts are attached to the multiphase buck (ie: for regulator
  buck12, buck1 & buck2 interrupts are registered)

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
 drivers/regulator/tps6594-regulator.c | 628 ++++++++++++++++++++++++++
 drivers/rtc/Kconfig                   |   9 +
 drivers/rtc/Makefile                  |   1 +
 drivers/rtc/rtc-tps6594.c             | 462 +++++++++++++++++++
 9 files changed, 1490 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-tps6594.c
 create mode 100644 drivers/regulator/tps6594-regulator.c
 create mode 100644 drivers/rtc/rtc-tps6594.c

-- 
2.39.2

