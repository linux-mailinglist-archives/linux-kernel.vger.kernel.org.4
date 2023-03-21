Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF4D6C37DE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjCURLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjCURLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:11:06 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280D93A82
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:10:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso1016728wmo.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679418623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/UziWlDmjNcjfsalPu/efplDFLQQZhUDiMxL92GPlU8=;
        b=Kt2FXpLIXzsQz/qZI1KmFGbtdRT0y8ochCon83eL88/iAjB0A088QD9XEA/BT0ya0F
         LrmX8xzsDj1k+NFYF29NO/Einn9ifSAbBirYwQvhekVJEC/HiDiMaLrBJVcRIzZupztf
         8lUY5gY6oG1/6XSohvDQqjHjHGu6PzJg0DKxFtgEV5FgHfDJQ9yWB0f/D4G0wKcmwLK9
         BVSZ0T05QTCbKh1WMJn6Sn7yN8oEFzBMgfnge1wqLkHn6xB4+nwmUhhcb6E9+swY9RzF
         S4l+28g9Jx+tTWP5A1lNBXcLAusSlx0ATKbFEYrUcKBmdfmvBgTqBVY9YyivsK7ExLF7
         UibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679418623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/UziWlDmjNcjfsalPu/efplDFLQQZhUDiMxL92GPlU8=;
        b=ZCUC9q+oplvxySfeCXGdwcIEtFX4JxAwIVVYOJm0yVFE3Fhf91gp6MDT2/8AHIEYc2
         +4r3HD2KOJb9ZcuJLsZN5I9IADl2eStH0STgWnb+Ndk6MiZoUiOaXQTRwTMUCl7kQNkA
         vOVoqzR+D0oB3D3LfK5++87X03NXzV8LNWF0R99EnkNxFQp6DOJZnYvowXcxP33YNfnK
         gU4KS4zdq19/oi546I9kM+DBILcPXS/9nYt9dseZX8TWc9lC931O8eRYtahwa6ie84Fn
         iAvtsAvJsKPymN+EWS5R88umZX6VfiG7to9Z06SoHan2twkApOQEs0CtSe5/AO36zftO
         WFcQ==
X-Gm-Message-State: AO0yUKVkDwywAMzSN+WpiHIBR26heT9H0wmY1E1Qs5dEvBo/sPfewbw8
        Jck42iUIwQjgHSq+YG3Wm6i6ig==
X-Google-Smtp-Source: AK7set8NXZ/xh1t+gruBsHs+QR9lI0pckQQSjPaxb4UtNhFt8EtvgdMMKb9f57F1kf7AWPWXh8xhuA==
X-Received: by 2002:a05:600c:2194:b0:3db:8de:6993 with SMTP id e20-20020a05600c219400b003db08de6993mr3051336wme.4.1679418623199;
        Tue, 21 Mar 2023 10:10:23 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (151.31.102.84.rev.sfr.net. [84.102.31.151])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600c350400b003eddf20ed5bsm8308347wmq.18.2023.03.21.10.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 10:10:22 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net, arnd@arndb.de,
        gregkh@linuxfoundation.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com
Cc:     eric.auger@redhat.com, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, davem@davemloft.net,
        christian.koenig@amd.com, contact@emersion.fr,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, sterzik@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, jneanne@baylibre.com
Subject: [PATCH v3 0/4] TI TPS6594 PMIC support (Core, ESM, PFSM)
Date:   Tue, 21 Mar 2023 18:10:16 +0100
Message-Id: <20230321171020.74736-1-jpanis@baylibre.com>
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

Link to v2:
https://lore.kernel.org/all/20230315110736.35506-1-jpanis@baylibre.com/

Others series will be submitted over the next few weeks, providing
drivers for others child devices like GPIOs (pinctrl), RTC, and
regulators. Board support will also be added (device trees).

Julien Panis (4):
  dt-bindings: mfd: Add TI TPS6594 PMIC
  mfd: tps6594: Add driver for TI TPS6594 PMIC
  misc: tps6594-esm: Add driver for TI TPS6594 ESM
  misc: tps6594-pfsm: Add driver for TI TPS6594 PFSM

 .../devicetree/bindings/mfd/ti,tps6594.yaml   |  231 ++++
 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 drivers/mfd/Kconfig                           |   32 +
 drivers/mfd/Makefile                          |    3 +
 drivers/mfd/tps6594-core.c                    |  453 ++++++++
 drivers/mfd/tps6594-i2c.c                     |  244 ++++
 drivers/mfd/tps6594-spi.c                     |  129 +++
 drivers/misc/Kconfig                          |   23 +
 drivers/misc/Makefile                         |    2 +
 drivers/misc/tps6594-esm.c                    |  132 +++
 drivers/misc/tps6594-pfsm.c                   |  304 +++++
 include/linux/mfd/tps6594.h                   | 1020 +++++++++++++++++
 include/uapi/linux/tps6594_pfsm.h             |   45 +
 13 files changed, 2619 insertions(+)
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

