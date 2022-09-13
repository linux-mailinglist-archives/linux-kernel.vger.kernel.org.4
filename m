Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF695B6CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbiIMMOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiIMMOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:14:31 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC33FE0E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 05:14:28 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso9360605wmr.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 05:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=B7iT+oQq30oC0oSLQJw888zIvH4fncBMdo2JDHB2lvA=;
        b=OUDJ6XTzz3nxOeEUmEuwfHwDK9Zwi5DJPsJuXpzMkKgf/XgsNXuseY5rphebORxivq
         6IeglrWFML4rT9BaHc+j9JgHDl7hirgxyRjJaFso+50lAjpxKiz1J/969oBRkMRHO5xP
         mujbY7f9XOuIJK9qGYrFk0uGHuAnkdmpSFy886nhRjv+8KRh4UZE5IxBvsPbrppssp7B
         O99jr2Ggd43kk5YbyTURuDXNMFqNefnYYMW0RuebruN9fXJ2xprzRXW34AiInsBjbWLY
         hm1NdFQMC9k94/NBdYtUT+HhdQhDNBZIPf5UE8zGsQi4vOJEhMrG6RqIOU3RVaQZlzUH
         a23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=B7iT+oQq30oC0oSLQJw888zIvH4fncBMdo2JDHB2lvA=;
        b=ZRfyaIWp/vjclv7MwUJT9Ogi0AnRI+GoO5AfL3fOVPq3LBXk7FdhodZVc2y/nVY22a
         vh3hENmnBAu8TuW2Weo1BYbGSsP/X5+hYBtk9ne7sRSUw0x7tK+UO0XrQwOth7qU1dSK
         pzO8gGcGQUPYnN4XpVjMu8apVPs+Sdc5BW6L5BENltFnpKk7h4lAVXsWxeBcDLEIRgyj
         MRi+iwnRYtmyrqE0qusSSFt2kO6eV346JxY5eKprHvK3COnSyzWZZ2eaA0FzeYiOjW/e
         2Y+rQ8B1rmBiumQPHqCN5yds6omVTr32cS4Pm2HFrpwzrG6dFHxEuL+yB/VsLPAHyses
         O7uw==
X-Gm-Message-State: ACgBeo2hdNp1c0AxuB6JEuCoICp08XIMUQ/vDY5K3izMU/BqbY4eSw7Y
        5O88skabaOLl3JNr8s9f2gzDig==
X-Google-Smtp-Source: AA6agR6jYsMQPv0E7C75YnpeWAaTVUlPh6qM5jvRT3/s2FgrrEMMciK7pORhVD/DwSiUUJNsM9cumA==
X-Received: by 2002:a1c:7315:0:b0:3a5:ff61:4080 with SMTP id d21-20020a1c7315000000b003a5ff614080mr2191186wmb.196.1663071267110;
        Tue, 13 Sep 2022 05:14:27 -0700 (PDT)
Received: from localhost.localdomain (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id p10-20020adf9d8a000000b00228634628f1sm10512230wre.110.2022.09.13.05.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 05:14:26 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, lee.jones@linaro.org, tony@atomide.com
Cc:     afd@ti.com, khilman@baylibre.com, narmstrong@baylibre.com,
        msp@baylibre.com, j-keerthy@ti.com, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v5 0/6] Add support for TI TPS65219 PMIC.
Date:   Tue, 13 Sep 2022 14:14:13 +0200
Message-Id: <20220913121419.15420-1-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

bindings and regulator are already there as it is based on the regulator tree branch for-6.1:
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git

Changes in v5:
- Remove pm_power_off functionality as it is unused in ARM64 systems
- Change mfd subject to prefixes matching subsystem

Validation:
regulator: tps65219: Fix .bypass_val_on setting
reported by Axel Lin has been validated on board. 

Regards,
Jerome

Previous versions:
v4 - https://lore.kernel.org/lkml/20220825150224.826258-1-msp@baylibre.com/
v3 - https://lore.kernel.org/lkml/20220805121852.21254-1-jneanne@baylibre.com/
v2 - https://lore.kernel.org/lkml/20220726103355.17684-1-jneanne@baylibre.com/
v1 - https://lore.kernel.org/lkml/20220719091742.3221-1-jneanne@baylibre.com/


Jerome Neanne (5):
  DONOTMERGE: arm64: dts: ti: Add TI TPS65219 PMIC support for AM642 SK
    board.
  DONOTMERGE: arm64: dts: ti: Add pinmux and irq mapping for TPS65219
    external interrupts
  DONOTMERGE: arm64: dts: ti: k3-am642-sk: Enable tps65219 power-button
  mfd: tps65219: Add driver for TI TPS65219 PMIC
  arm64: defconfig: Add tps65219 as modules

Markus Schneider-Pargmann (1):
  Input: Add tps65219 interrupt driven powerbutton

 MAINTAINERS                             |   1 +
 arch/arm64/boot/dts/ti/k3-am642-sk.dts  | 115 ++++++++
 arch/arm64/configs/defconfig            |   3 +
 drivers/input/misc/Kconfig              |  10 +
 drivers/input/misc/Makefile             |   1 +
 drivers/input/misc/tps65219-pwrbutton.c | 149 ++++++++++
 drivers/mfd/Kconfig                     |  14 +
 drivers/mfd/Makefile                    |   1 +
 drivers/mfd/tps65219.c                  | 320 ++++++++++++++++++++++
 include/linux/mfd/tps65219.h            | 345 ++++++++++++++++++++++++
 10 files changed, 959 insertions(+)
 create mode 100644 drivers/input/misc/tps65219-pwrbutton.c
 create mode 100644 drivers/mfd/tps65219.c
 create mode 100644 include/linux/mfd/tps65219.h

-- 
2.17.1

