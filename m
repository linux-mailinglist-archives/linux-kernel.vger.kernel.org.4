Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBE76CFE21
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjC3IUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjC3IUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:20:19 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF99D6EB4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:20:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o32so10360936wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680164409; x=1682756409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=88rMzBbRlhYI6KPx7O+R7CtYmO6UoeLS/Yo2Sd7KQT4=;
        b=frsx0h/yO9f/vVrsghxVfoMxpVTPjPGuFcE/f/LGYsxRrFAMROA3dI9Nb5Gl9MRZbS
         45RxZYszNU0BMMqy3+NrZ/vynSowy5kOaJ1aogwajNg3AV1qAroXhwf/3geygSBe12ak
         DIbAXIPRlyt00P+oMrCQbXLzlEy4h89IyD/Z5DfI1z0XQssCikFhSvczVNunMA5c5+e1
         M84aPqqvDn/xEJMejxHh75c3T9tRyua37GO/yHvy98MydhCM6zn8oa9n4dmZFMaIWflh
         ZjWjZqIwcYHMD5Zw3sJYFvXpiJ0l/3uEul4yl2nNWttBihEZOB5bGKsOrRvZzQAyJH9g
         K0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680164409; x=1682756409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88rMzBbRlhYI6KPx7O+R7CtYmO6UoeLS/Yo2Sd7KQT4=;
        b=bSaIavTEEJ2vcn1mM+ImS7XGpj4+yXR4Y8nUzfiBaw8yml0v9emPX62OPfOjY0cDLr
         nopWx/MATI3zNL5SqYsEiAeVUv09asmsbFlgCFXRrfQsPVTHt0gxat+oUTm9iSGmziW6
         2L6W20Dh3SV0L711fYfJXy63EbQ79Q/K3LeAGguCmnD75GXwX14IcUsdvFefameOUmEu
         bPc0F0YtBUWFZn7BJQP3GxWvf/olifTNhl7+Jq4DjraU9rrbkGqHMq883B7u1J55/Vkl
         FsVV51PD+VbkNoZS/idnQZFu61TQhnDGyKVvjWIXxeaQvfR9pguqBsCkYFsTXZgrZHJH
         2gTg==
X-Gm-Message-State: AO0yUKWxhGj1+G1AUC83K++83zn0lsBA7U+h3OvkdB5kypj9kBcU2Qqj
        u66UVbVkniLlJrJWFesiCN8cwg==
X-Google-Smtp-Source: AK7set+8BV+ajlC3pkzfwaGF1+JMY0UETtvwLPzUGI1XTzWSocmN9pYfYgFzCGVtFngsiAI25At5mA==
X-Received: by 2002:a05:600c:cb:b0:3ed:66e0:b6de with SMTP id u11-20020a05600c00cb00b003ed66e0b6demr17920607wmm.22.1680164409316;
        Thu, 30 Mar 2023 01:20:09 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (151.31.102.84.rev.sfr.net. [84.102.31.151])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d4e8d000000b002ceacff44c7sm32286588wru.83.2023.03.30.01.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 01:20:09 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net, arnd@arndb.de,
        gregkh@linuxfoundation.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com
Cc:     yi.l.liu@intel.com, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, prabhakar.csengg@gmail.com,
        contact@emersion.fr, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        sterzik@ti.com, u-kumar1@ti.com, eblanc@baylibre.com,
        jneanne@baylibre.com
Subject: [PATCH v5 0/4] TI TPS6594 PMIC support (Core, ESM, PFSM)
Date:   Thu, 30 Mar 2023 10:20:02 +0200
Message-Id: <20230330082006.11216-1-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
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

The features implemented in this series are:
- Core (MFD I2C and SPI entry points)
- ESM (child device)
- PFSM (child device)

- Core description:
I2C and SPI interface protocols are implemented, with and without
the bit-integrity error detection feature (CRC mode).
In multi-PMIC configuration, all instances share a single GPIO of
the SoC to generate interrupt requests via their respective nINT
output pin.

- ESM description:
This device monitors the SoC error output signal at its nERR_SOC
input pin. In error condition, ESM toggles its nRSTOUT_SOC pin
to reset the SoC.
Basically, ESM driver starts ESM hardware.

- PFSM description:
Strictly speaking, PFSM is not hardware. It is a piece of code.
PMIC integrates a state machine which manages operational modes.
Depending on the current operational mode, some voltage domains
remain energized while others can be off.
PFSM driver can be used to trigger transitions between configured
states.

Changes since v4:
* [dt-bindings] Modify 'compatible' strings.
* [dt-bindings] Remove 'ti,multi-phase-id' property.
* [dt-bindings] Remove rtc/watchdog nodes.
* [MFD i2c/spi drivers] Modify 'compatible' strings.
* [All] Remove 'X' from 'LP8764X' string and enum value.

Link to v4:
https://lore.kernel.org/all/20230327154101.211732-1-jpanis@baylibre.com/

Others series will be submitted over the next few weeks, providing
drivers for others child devices like GPIOs (pinctrl), RTC, and
regulators. Board support will also be added (device trees).

Julien Panis (4):
  dt-bindings: mfd: Add TI TPS6594 PMIC
  mfd: tps6594: Add driver for TI TPS6594 PMIC
  misc: tps6594-esm: Add driver for TI TPS6594 ESM
  misc: tps6594-pfsm: Add driver for TI TPS6594 PFSM

 .../devicetree/bindings/mfd/ti,tps6594.yaml   |  193 ++++
 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 drivers/mfd/Kconfig                           |   32 +
 drivers/mfd/Makefile                          |    3 +
 drivers/mfd/tps6594-core.c                    |  462 ++++++++
 drivers/mfd/tps6594-i2c.c                     |  244 ++++
 drivers/mfd/tps6594-spi.c                     |  129 +++
 drivers/misc/Kconfig                          |   23 +
 drivers/misc/Makefile                         |    2 +
 drivers/misc/tps6594-esm.c                    |  132 +++
 drivers/misc/tps6594-pfsm.c                   |  304 +++++
 include/linux/mfd/tps6594.h                   | 1020 +++++++++++++++++
 include/uapi/linux/tps6594_pfsm.h             |   45 +
 13 files changed, 2590 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
 create mode 100644 drivers/mfd/tps6594-core.c
 create mode 100644 drivers/mfd/tps6594-i2c.c
 create mode 100644 drivers/mfd/tps6594-spi.c
 create mode 100644 drivers/misc/tps6594-esm.c
 create mode 100644 drivers/misc/tps6594-pfsm.c
 create mode 100644 include/linux/mfd/tps6594.h
 create mode 100644 include/uapi/linux/tps6594_pfsm.h


base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.37.3

