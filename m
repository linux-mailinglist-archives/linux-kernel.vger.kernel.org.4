Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA48D6A1CFE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjBXNbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBXNbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:31:35 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9868F48E2F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:31:32 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id c12so13930321wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1677245491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0XqYg5Ih2XOB+UkK6Z2brkA3laKu2T8wLWLgaXnwM1Q=;
        b=6oqHXBlu/N0/yThR76ViJSYXhaAX7ujx9DglLla4OUVxZzD3lg5tBlXKyhbOyQ9kC1
         CGCQcrIJ1fMeNRdUuje/tWrMRxhnDudqwME6xPGF/oHjVAwcAVYIqb2oebaE4WsDlol0
         xG0z3zHzRn6avg5KhKW2bndVtf7kqKhMMvo5ZytW3EH6SW4d3nGAf9R0Qu8TCnRFrYTg
         kpJQklE/6eC+PqWKQKf5SIKXwFLwCBeY7qS8yG+YtzH33o7nPOaH2d5WNgFYKWozOO3u
         i4yJPO82fnk1cmgCzP0g04OHCV9lxF1XH4Jk74JdfBaGW9O+nZbsjPtbFon+BD81Drtj
         ejXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677245491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XqYg5Ih2XOB+UkK6Z2brkA3laKu2T8wLWLgaXnwM1Q=;
        b=M33vTJsLJqzVRsGNsPPItbr7Xs/fmc76fESmuVex6vJ1FClh9xfvrU2vJLkf37CO3B
         YN19N/Ir5RaLlDVSsvbO8QNt3jjlP36xMSxYFGST2ziScqp93LZsHz5JeIL+nViloWHm
         bcIzzQ/9ojcCILGEr8+ZuCTWa2aZW8eV0vmkjvXxIk55slmfvnqUgO6G04s8YFMaadzb
         7W3CZ6NyN9DJa6mQKrsCVJ95PqFe4hXZd+hT3/PpmQ7+pIxwjbK9iF8LvnSMxvP0u+jP
         djHRK1Gl0h0FzVz2aGrtT7WciwAhnzd+sPCpFiksUzuX2r9ie6i2LsY9Stfrgc59vm+x
         GJHA==
X-Gm-Message-State: AO0yUKVXbhue/xEu1QuLAbtu3A1zYtlvCSgkNkUnSb2hP9qu/sjpnoQb
        F/qyePKoD5UpBnU0CSEFMHwqJg==
X-Google-Smtp-Source: AK7set/mKG+V73AaZM/iRyaTRZTbvTZo4lDTbvttqg2fK40sll1rwkx4ofKgzE/GK6SRyOxhdL/uDA==
X-Received: by 2002:adf:e412:0:b0:2c7:148c:b04f with SMTP id g18-20020adfe412000000b002c7148cb04fmr4635735wrm.37.1677245490960;
        Fri, 24 Feb 2023 05:31:30 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:28d:66d0:5e4:476:5145:2ad1])
        by smtp.gmail.com with ESMTPSA id o25-20020a05600c511900b003dfe549da4fsm3308735wms.18.2023.02.24.05.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 05:31:30 -0800 (PST)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com
Subject: [PATCH v1 0/3] TI TPS6594 PMIC support (RTC, pinctrl, regulators, device trees)
Date:   Fri, 24 Feb 2023 14:31:26 +0100
Message-Id: <20230224133129.887203-1-eblanc@baylibre.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPS6594 is a Power Management IC which provides regulators and others
features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
PFSM (Pre-configurable Finite State Machine). The SoC and the PMIC can
communicate through the I2C or SPI interfaces.
TPS6594 is the super-set device while TPS6593 and LP8764X are derivatives.

This series adds support to TI TPS6594 PMIC and its derivatives.

This should be applied on top of other patch series:
- https://lore.kernel.org/all/20230216114410.183489-1-jpanis@baylibre.com/
  For core MFD driver

The features implemented in this series are:
- RTC (child device)
- Pinmux/GPIO (child device)
- Regulator (child device)

RTC description:
The TPS6594 family has an RTC built-in, except for LP8764X.
It provides time and an alarm.

Pinmux/GPIO:
TPS6594 family has 11 GPIOs. Those GPIO can also serve different
functions such as I2C or SPI interface, watchdog disable functions.
The driver provides both pinmuxing for the functions and GPIO capability.

Regulator:
TPS6594/TPS6593: 5 BUCKs and 4LDOs
LP8764X: 4 BUCKs and no LDO
Bucks can be used in multipahse mode

Esteban Blanc (2):
  rtc: tps6594: add driver for TPS6594 PMIC RTC
  pinctrl: tps6594: add for TPS6594 PMIC

Jerome Neanne (1):
  regulator: tps6594-regulator: Add driver for TI TPS6594 regulators

 drivers/pinctrl/Kconfig               |   9 +
 drivers/pinctrl/Makefile              |   1 +
 drivers/pinctrl/pinctrl-tps6594.c     | 367 +++++++++++++++++
 drivers/regulator/Kconfig             |  12 +
 drivers/regulator/Makefile            |   1 +
 drivers/regulator/tps6594-regulator.c | 559 ++++++++++++++++++++++++++
 drivers/rtc/Kconfig                   |   8 +
 drivers/rtc/Makefile                  |   1 +
 drivers/rtc/rtc-tps6594.c             | 516 ++++++++++++++++++++++++
 9 files changed, 1474 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-tps6594.c
 create mode 100644 drivers/regulator/tps6594-regulator.c
 create mode 100644 drivers/rtc/rtc-tps6594.c

-- 
2.38.1

