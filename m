Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D196D90D2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbjDFH4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbjDFH42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:56:28 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C5861BA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 00:56:26 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l10-20020a05600c1d0a00b003f04bd3691eso8375370wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 00:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680767785; x=1683359785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RyMJ/LPWyITMHJeLGKmI4fclBoXgbQHEcia5vkVYuYQ=;
        b=C1Gm3N8nHtU7kLWsmrNG8Nk2scc1RfScS2FvPY72/2b757hkeS1ferVMmT6+GNB/k8
         F266u9ZdxlTE+SrC5qF05azDXRDCADMovyHGxWsi88ETJbVrqrlXtn65MOiQ0nyNXZ3R
         8bub+pTFtzzd6HsmtCymyqTm5IO5j5AVh5o/k85nTWtPd84dMGAIP4BLbDLWbjIph+Rl
         UN/7alvEAYRLFeAZuuw3Avhxftc1tBroSjw30x3bdshAk8ahLISL/X8XbG3cC2jYXieb
         Ondso4SwEdb9NHRGsa8ZI95BAXovuiRzCa6pTQFXMXpkmxilx9GNv5Kw8cVZGJeLOAQV
         dz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680767785; x=1683359785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RyMJ/LPWyITMHJeLGKmI4fclBoXgbQHEcia5vkVYuYQ=;
        b=hrYYj46gyUH++k4IYHRlmOQMWQO3hqeD1b/AQIrFYicQ8Zdh2jYTbQgsjnv+2voBYP
         GLco3qyBqY37Npea/YAHLDOLZy0ADOuzZgHVxO8hpBLBKiuFoShacVdsbZ4OnHHrDqd3
         f4DBVhiRFaJLZ+wPqGtAGB5UQAau7K/pb12kQaObmpQxmw/y4VEsCuKhOBIPCsbm42IG
         BU3wEIaaNl7frscG9qWT4JxRUNexxkge2h4xFXJ5n9KHtf/60uxxj/9kMlKffBIje8SV
         HvV/64Cx8IG5RmE7QySdIT+a2xOCCRBZLdpvX9awNSbZQb8ztlQBsueQjsegsSyfWyCW
         9CCQ==
X-Gm-Message-State: AAQBX9fkj7bNvnXDd2aBCkrWyr7wz674SXe6kfVeYR3h1u4jyGOc5/jY
        VlIlguKYobOvUsZ92F24qbatQQ==
X-Google-Smtp-Source: AKy350aRCbPwVFoCElS5gaRlAjyKcd2c6JbclERtzragMJZPLJ2jGCUwBnm/fKh1DP/Wwz1WO/LQ2w==
X-Received: by 2002:a1c:4c16:0:b0:3ee:1084:aa79 with SMTP id z22-20020a1c4c16000000b003ee1084aa79mr3141461wmf.20.1680767785225;
        Thu, 06 Apr 2023 00:56:25 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (151.31.102.84.rev.sfr.net. [84.102.31.151])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c458f00b003f03d483966sm4572651wmo.44.2023.04.06.00.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 00:56:24 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net, arnd@arndb.de,
        gregkh@linuxfoundation.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com
Cc:     yi.l.liu@intel.com, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, prabhakar.csengg@gmail.com,
        contact@emersion.fr, macro@orcam.me.uk, dsahern@kernel.org,
        alex.williamson@redhat.com, akrowiak@linux.ibm.com,
        mark.rutland@arm.com, ye.xingchen@zte.com.cn, ojeda@kernel.org,
        keescook@chromium.org, me@kloenk.de, mhiramat@kernel.org,
        milan@mdaverde.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        sterzik@ti.com, u-kumar1@ti.com, eblanc@baylibre.com,
        jneanne@baylibre.com
Subject: [PATCH v6 0/6] TI TPS6594 PMIC support (Core, ESM, PFSM)
Date:   Thu,  6 Apr 2023 09:56:16 +0200
Message-Id: <20230406075622.8990-1-jpanis@baylibre.com>
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

Changes since v5 [all related to PFSM 'misc' driver]:
* [PFSM driver] Return -ENOIOCTLCMD instead of -EINVAL for unknown ioctl command.
* [PFSM driver] Add compat_ioctl pointer set to compat_ptr_ioctl() helper.
* [PFSM driver] Replace PMIC_SET_STATE ioctl command with 3 different ioctl
commands, and rename/modify pmic_state struct accordingly (enum removed and
bitfield replaced with several __u8 to enable/disable state options).
* [doc] Add 'tps6594-pfsm.rst' file to 'Documentation/misc-devices' directory.
* [doc] Modify command range in 'ioctl-number.rst'.
* [samples] Add 'pfsm/pfsm-wakeup.c' userspace code to 'samples' directory.

Link to v5:
https://lore.kernel.org/all/20230330082006.11216-1-jpanis@baylibre.com/

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


base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.37.3

