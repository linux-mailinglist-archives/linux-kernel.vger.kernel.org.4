Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFFF6FEF4B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237776AbjEKJwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237231AbjEKJwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:52:02 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB175FCA
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:51:30 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f475366522so12400035e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1683798688; x=1686390688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mTPp8QywfNyVkAufTyppdZdc6KOGJR4M0+qiLr9qQQs=;
        b=M2LUQPL7PGkS+h9rK5dhBDsGVIwbi0H+SqqKfbvwmMT4krCHZpXTMCrmE767sePMqb
         5EFNi9lAb8z2EPxdCaSX5WyuyNG+8Jeak/9aH0u5mNxLUTDAGYB6YSkCzl1Aa3C1nOPF
         qgiNUixn91e4zCXCs4gRgx1SSm3nnbNujpyJNDyIocg9GMfbEQKIVB3ntxdxfhqfz3OA
         Pyx/6zE2kN3KXlul2bovKxK6LNwQZ7/kLn3jrW5mxMmTb0/vt/iggQ/Z5N6AL/aRrECY
         EWALL8QzrwTG6aunVX+pvC32pBlrasFOVMbAITa8aOcfGcvhPUweEn3pltZtel+PWhOO
         NLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683798688; x=1686390688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTPp8QywfNyVkAufTyppdZdc6KOGJR4M0+qiLr9qQQs=;
        b=AIsT5Z0ap50SyboQpOLrc5e6d7RbJgbkk/ioIezJENWaOfoouuP5PPbu6NeT0OiJN7
         LDgdOCOhcNGEZf7Ofx0CIhiepOs2Oiw3TMl5p2D5DR2UAChqWwbX/NKgBAkRH8Eytdlv
         ETechZVoBTUhPIgbUsQN+eqAsYQnbyQa0RvNLeXXjkvDdgBKb4jezLEnutMoIOEYniEM
         ovxAZRK9aC9glFVR8Xme3JxPOhfEY2v2j+kk1ib2MHR8r5yn72NfYkxVgNYDypwLk58/
         UQKi+c9Cf1J/I5HNLV1BMuXaEPfPdxmrzcKbx5nRAHDfQt8M/CdR7lZQ9Y+St0G3gWfg
         ncmA==
X-Gm-Message-State: AC+VfDy0Cq/Vmdhj5CtoLqWrF2blVKs8HXRoqtM2u6FfXpZr1Dh+8MKj
        NnDNhZeKxN4C5nFI8Vrc8vbBLA==
X-Google-Smtp-Source: ACHHUZ77oPngL+MeroQzjAKoRK3YdxsUu7omuG52qRybdXF4Kk8HqteMTujXJ2HNRwHilGunhJuR4w==
X-Received: by 2002:a05:600c:b4b:b0:3f4:2897:4eb7 with SMTP id k11-20020a05600c0b4b00b003f428974eb7mr7663813wmr.38.1683798688437;
        Thu, 11 May 2023 02:51:28 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (120.205.87.79.rev.sfr.net. [79.87.205.120])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c114900b003f4069417absm22389956wmz.24.2023.05.11.02.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 02:51:28 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, arnd@arndb.de, gregkh@linuxfoundation.org,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com
Cc:     macro@orcam.me.uk, baolu.lu@linux.intel.com, yi.l.liu@intel.com,
        jirislaby@kernel.org, rostedt@goodmis.org, revest@chromium.org,
        gehao@kylinos.cn, akpm@linux-foundation.org, jgg@ziepe.ca,
        razor@blackwall.org, stephen@networkplumber.org,
        prabhakar.csengg@gmail.com, contact@emersion.fr,
        alex.williamson@redhat.com, akrowiak@linux.ibm.com,
        mark.rutland@arm.com, ye.xingchen@zte.com.cn, ojeda@kernel.org,
        me@kloenk.de, milan@mdaverde.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        sterzik@ti.com, u-kumar1@ti.com, eblanc@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com
Subject: [PATCH v7 0/6] TI TPS6594 PMIC support (Core, ESM, PFSM)
Date:   Thu, 11 May 2023 11:51:20 +0200
Message-Id: <20230511095126.105104-1-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
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

Changes since v6:
* Rebase on linux v6.4-rc1 (no modification in the series)

Link to v6:
https://lore.kernel.org/all/20230406075622.8990-1-jpanis@baylibre.com/

Others series will be submitted over the next few weeks, providing
drivers for others child devices like GPIOs (pinctrl), RTC, and
regulators. Board support will also be added (device trees).

Julien Panis (6):
  dt-bindings: mfd: Add TI TPS6594 PMIC
  mfd: tps6594: Add driver for TI TPS6594 PMIC
  misc: tps6594-esm: Add driver for TI TPS6594 ESM
  misc: tps6594-pfsm: Add driver for TI TPS6594 PFSM
  Documentation: Add TI TPS6594 PFSM
  samples: Add userspace example for TI TPS6594 PFSM

 .../devicetree/bindings/mfd/ti,tps6594.yaml   |  193 ++++
 Documentation/misc-devices/index.rst          |    1 +
 Documentation/misc-devices/tps6594-pfsm.rst   |   87 ++
 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 drivers/mfd/Kconfig                           |   32 +
 drivers/mfd/Makefile                          |    3 +
 drivers/mfd/tps6594-core.c                    |  462 ++++++++
 drivers/mfd/tps6594-i2c.c                     |  244 ++++
 drivers/mfd/tps6594-spi.c                     |  129 +++
 drivers/misc/Kconfig                          |   23 +
 drivers/misc/Makefile                         |    2 +
 drivers/misc/tps6594-esm.c                    |  132 +++
 drivers/misc/tps6594-pfsm.c                   |  306 +++++
 include/linux/mfd/tps6594.h                   | 1020 +++++++++++++++++
 include/uapi/linux/tps6594_pfsm.h             |   37 +
 samples/Kconfig                               |    6 +
 samples/Makefile                              |    1 +
 samples/pfsm/.gitignore                       |    2 +
 samples/pfsm/Makefile                         |    4 +
 samples/pfsm/pfsm-wakeup.c                    |  125 ++
 20 files changed, 2810 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
 create mode 100644 Documentation/misc-devices/tps6594-pfsm.rst
 create mode 100644 drivers/mfd/tps6594-core.c
 create mode 100644 drivers/mfd/tps6594-i2c.c
 create mode 100644 drivers/mfd/tps6594-spi.c
 create mode 100644 drivers/misc/tps6594-esm.c
 create mode 100644 drivers/misc/tps6594-pfsm.c
 create mode 100644 include/linux/mfd/tps6594.h
 create mode 100644 include/uapi/linux/tps6594_pfsm.h
 create mode 100644 samples/pfsm/.gitignore
 create mode 100644 samples/pfsm/Makefile
 create mode 100644 samples/pfsm/pfsm-wakeup.c


base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.37.3

