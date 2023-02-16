Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD5E69936F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjBPLoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBPLoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:44:16 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445FA5593
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 03:44:14 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ky6so4523279ejc.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 03:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xi49EHz6DZ/mw9xN54iHArfnYQdI2e0Se82zwiFKKsc=;
        b=Zdo8aV9ikPUkSGN2CESlpPfqadoQLb8lF1rybEh/pXuyo2ybAel/s1Iwia18aXLquX
         4x2MGvzGOwz7bnuezKD42U98Td+jKgDxbsRZAijYKmlv39C2nJQ3LX7Vbe41W7Ct0GXg
         YNBXmXy6g+vp0ePiSs3jsf5ErPOlmXKNxjfuJD0/NG9dnKNNhV0pOTm+VVAx2h7DXWyH
         Bvre3a1GjxDo0MSvk4Xj8r5YL7Nk43SwTzx4+2J3tYAPvIHuax3GlM8/K64+zr1WTf69
         ZNZ0iKFjjbmyY97U6IQVK1qKQKRYgqH3hsGzyn1di+C/EI3Na/SacvBWkroV/jwactfr
         8DwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xi49EHz6DZ/mw9xN54iHArfnYQdI2e0Se82zwiFKKsc=;
        b=IS88+EsH5FrjbIz6zO0uTuvLU85IP1dduhkTTq47SJaAqqngdv47xuXoqR70M+8OnB
         huxAtEM6T6blwVurbWX+BLtwKH5wIFNwDG0U3cul9E9cdJh6YmjlBdnnXbxVr7dCanu/
         8ul/sMhnz4gNBAgiC6F01AHkgkldRpSitx3Bkws+qVUqECYXs2WIu7mzP4DUHqrAFgRa
         kUcixDxd+K2d5Qt7kROkNTaKjqbA6iWMmgmgHoyNFwl9KjwIqpOIWWSuBEc/TWiCYyhe
         7+/wwEzPWy4EZ8a3kCYyaJuSPlFR0k6DcaJ5F1CKZ4sQ0DRjSJgsNFgivqP8NYbWFAOJ
         uIQw==
X-Gm-Message-State: AO0yUKV/HrMlvBYtnipN6/gNuSiY0hwO1Yl8k0odf3FziOV7p5D9Ty85
        RFfial5XB8Tc8GUCsJRE1jC4rA==
X-Google-Smtp-Source: AK7set/NakAImmWUePa800VVsPhcXpujosV2WTtofepAz4qEq0rJQ329wd+z/mdFswZDHcr70jxy2Q==
X-Received: by 2002:a17:906:b35a:b0:8b1:4d4f:aa0a with SMTP id cd26-20020a170906b35a00b008b14d4faa0amr4158489ejb.18.1676547852788;
        Thu, 16 Feb 2023 03:44:12 -0800 (PST)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (247.165.185.81.rev.sfr.net. [81.185.165.247])
        by smtp.gmail.com with ESMTPSA id k20-20020a170906a39400b008b14c5a82e7sm698153ejz.127.2023.02.16.03.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 03:44:12 -0800 (PST)
From:   Julien Panis <jpanis@baylibre.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net
Cc:     hdegoede@redhat.com, eric.auger@redhat.com, jgg@ziepe.ca,
        razor@blackwall.org, suma.hegde@amd.com,
        stephen@networkplumber.org, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, eblanc@baylibre.com,
        jneanne@baylibre.com
Subject: [PATCH v1 0/4] TI TPS6594 PMIC support (Core, ESM, PFSM)
Date:   Thu, 16 Feb 2023 12:44:06 +0100
Message-Id: <20230216114410.183489-1-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
TPS6594 is the super-set device while TPS6593 and LP8764X are derivatives.

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

Others series will be submitted over the next few weeks, providing
drivers for others child devices like GPIOs (pinctrl), RTC, and
regulators. Board support will also be added (device trees).

Julien Panis (4):
  dt-bindings: mfd: Add DT bindings for TI TPS6594 PMIC
  mfd: tps6594: Add driver for TI TPS6594 PMIC
  mfd: tps6594-esm: Add driver for TI TPS6594 ESM
  mfd: tps6594-pfsm: Add driver for TI TPS6594 PFSM

 .../devicetree/bindings/mfd/ti,tps6594.yaml   |  164 +++
 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 drivers/mfd/Kconfig                           |   53 +
 drivers/mfd/Makefile                          |    5 +
 drivers/mfd/tps6594-core.c                    |  413 +++++++
 drivers/mfd/tps6594-esm.c                     |  132 +++
 drivers/mfd/tps6594-i2c.c                     |  240 ++++
 drivers/mfd/tps6594-pfsm.c                    |  304 +++++
 drivers/mfd/tps6594-spi.c                     |  125 ++
 include/linux/mfd/tps6594.h                   | 1018 +++++++++++++++++
 include/uapi/linux/tps6594_pfsm.h             |   45 +
 11 files changed, 2500 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
 create mode 100644 drivers/mfd/tps6594-core.c
 create mode 100644 drivers/mfd/tps6594-esm.c
 create mode 100644 drivers/mfd/tps6594-i2c.c
 create mode 100644 drivers/mfd/tps6594-pfsm.c
 create mode 100644 drivers/mfd/tps6594-spi.c
 create mode 100644 include/linux/mfd/tps6594.h
 create mode 100644 include/uapi/linux/tps6594_pfsm.h


base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
-- 
2.37.3

