Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528AE721CD2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 06:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjFEEIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 00:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjFEEH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 00:07:57 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC33A6;
        Sun,  4 Jun 2023 21:07:56 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b011cffef2so40585145ad.3;
        Sun, 04 Jun 2023 21:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685938075; x=1688530075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=652JpJkLoWj/t+Dv8KQmBEx358qgiU+Lje74sKtKVzo=;
        b=o2kG8IFEgF9X46L1mat+0mEHB8VrXmIs7IFQRAizQkDdDBG01eLu0Gn1kAgDT3P1NO
         lKowFn+oFbYNvi+8A1VmY8OkipcLQbui4neuEztHz7o5gJPyFArTFpeJv7KmokQBN29Z
         YECZoHtgteAHtwfbxIBxqIiNgX/ntRdgra8IaWb/mrtctTO4AC8opEaOfFFGr/qaz9sy
         jhNRN6teh1bNMoVJk/ZWFAjJfi0gQfuboAMrY4apE3jbhjPhocEa6fiohOIMVsu4ARLl
         tkRUv6VT78w+fe6UkYuydX45InK2VQf+NGuDF4twDu8MRGC+SB8tJLGOiZAbYPQItU3F
         Eshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685938075; x=1688530075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=652JpJkLoWj/t+Dv8KQmBEx358qgiU+Lje74sKtKVzo=;
        b=h+pnOmmarh450Zy98qHXVza5ovtNsLVeHlJFf7MbIqsRR6I7eJ4U5pYTtcjgWAmwM1
         Jo8tUelK1utgfXKw30aiqfb7HjVuDA5EQMxEaV7KKVcBWb00upCb0dNk2SjFB4rkMjiq
         1zCvL2Ov9oRP5A0fiLP989CiODVyEyGoZjoWwPbN/MTBsR7oUFmHcVmeqxUSVgJ7m5DM
         oDGoBt60s/5s7CqOp7AOuqhufg7lO37ZPQDta5uS8o2hKN0f5QwsmWyRQ22VKqHwMUfF
         dAiukL4jjthZRSgCPNrxM0V6n0jLTpnqjAgw8j9qXrKKY4PZzSqv3VKYV55lysrSEuZj
         EMPg==
X-Gm-Message-State: AC+VfDy26jjlKi8GZpuzZPqoX8ZdZcq/gSzrViJsF5uL1NUSSFZqOtfI
        T4NrTBw4We1R2yJ4MNLwc0EpcNAF07M=
X-Google-Smtp-Source: ACHHUZ7Y4u3Z8ob/D7XXc51E40iSzJIBaa+3ztJQ3n6LUEVWfGUDXBrL/UmhoBgOaZM3cKYbf+yLlg==
X-Received: by 2002:a17:902:d34b:b0:1b0:1095:f4f6 with SMTP id l11-20020a170902d34b00b001b01095f4f6mr6169360plk.24.1685938075344;
        Sun, 04 Jun 2023 21:07:55 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id b4-20020a170903228400b001b21bcea439sm206164plh.170.2023.06.04.21.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 21:07:54 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, tmaimon77@gmail.com, catalin.marinas@arm.com,
        will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, soc@kernel.org,
        schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v13 00/10] Introduce Nuvoton ma35d1 SoC
Date:   Mon,  5 Jun 2023 04:07:39 +0000
Message-Id: <20230605040749.67964-1-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

This patchset adds initial support for the Nuvoton ma35d1 SoC, including
initial device tree, clock driver, reset driver, and serial driver.

This patchset cover letter is based from the initial support for Nuvoton
ma35d1 to keep tracking the version history.

This patchset had been applied to Linux kernel 6.4.0-rc5
and tested on the Nuvoton ma35d1 SOM evaluation board.

(ma35d1 information: https://www.nuvoton.com/products/microprocessors/arm-cortex-a35-mpus/)
MA35D1 porting on linux-5.10.y can be found at: https://github.com/OpenNuvoton/MPU-Family

v13:
  - Modify serial driver
    - Added a check for oops_in_progress in ma35d1serial_console_write to
      determine whether to perform the spin_lock.
    - Rebased drivers/tty/serial/Kconfig and recreate the patch
    - Rebased MAINTAINERS and recreate the patch

v12:
  - Modify serial driver
    - Added PORT_MA35 to include/uapi/linux/serial_core.h, and apply to
      the port->type of ma35d1 serial driver
    - Added check for the return value of ioremap()
    - Fixed several coding issues
  - Rebase MAINTAINERS and recreate the patch

v11:
  - Rebase on top of 2023.05.24
  - Modify serial driver
    - Fixed several coding style issues
    - Fixed ma35d1serial_set_mctrl()
    - Added the 'MA35_' prefix to all register and bit field definitions.
    - Used 'ttyNVT' instead of 'ttyS'
  - Modify clock driver
    - Added 'source nuvoton/Kconfig' to drivers/clk/Kconfig
    - Fixed several coding issues
    - Removed unnecessary inline specifier
  - Modify reset driver
    - Fixed typo and added comments
  - Modify ma35d1.dtsi l2-cache node
    - Added cache-unified and cache-size properties

v10:
  - Change from using ARCH_NUVOTON to using ARCH_MA35. The following patch files
    have been modified:
    - patch 1 arch/arm64/Kconfig.platforms
    - patch 2 arch/arm64/configs/defconfig
    - patch 7 arch/arm64/boot/dts/nuvoton/Makefile
    - patch 8 drivers/clk/Makefile
              drivers/clk/nuvoton/Kconfig
              drivers/clk/nuvoton/Makefile
    - patch 9 drivers/reset/Kconfig
    - patch 10 drivers/tty/serial/Kconfig

v9:
  - Combine MAINTAINERS patch into patch 5 'dt-bindings: arm: Add initial bindings
    for Nuvoton platform'
  - Modify clock driver
    - Use the helper function for 64-bit division
    - Fixed minor issues
  - Modify reset driver
    - Refine coding style and add required header files
    - Add spin_lock protection
  - Add error return handling to the serial driver probe function

v8:
  - Remove '0005-dt-bindings-mfd-syscon-Add-nuvoton-ma35d1-sys-compat.patch' as it was applied.
  - Modify MAINTAINERS NUVOTON MA35 and NPCM path settings
  - Remove 'syscon' from dtsi 'sys' node and modify the corresponding yaml
  - Modify clock driver
    - Remove the header file and move definitions into .c files.
    - Use parent_data instead of parent name.
  - Modify serial driver
  - Modify reset driver
    - Modify reset register/offset lookup table to be indexed by reset id
    - Combined reset and reboot structure

v7:
  - Fixed dts system-management node and compatible driver
  - move 'nuvoton,npcm-gcr.yaml' from 'binding/arm/nuvoton' to 'binding/soc/nuvoton'
  - In ma35d1.dtsi, create the soc node for ma35d1 SoC
  - Modify the issues found in serial driver
  - Modify the issues found in clock driver
  - Modify the IDs of reset driver to be contiguous numbers and use lookup table
    to find register offset and bit position.
  - Modify MAINTAINERS NUVOTON NPCM path as npcm directory name to nuvoton

v6:
  - Combine nuvoton,ma35d1-clk.yaml and nuvoton,ma35d1-clk.h into one patch
  - Combine nuvoton,ma35d1-reset.yaml and nuvoton,ma35d1-reset.h into one patch
  - rename Documentation/devicetree/bindings/arm/npcm directory as nuvoton
  - Remove patch for adding include/linux/mfd/ma35d1-sys.h as it's not required
  - Update dtsi & dts files and move board-specific nodes to dts
  - Modify reset driver
  - Modify serial driver, fix coding style issues
  - Modify clock driver, rewrite the PLL calculation functions

v5:
  - Add ARCH_NUVOTON to arm64 Kconfig
  - Add ARCH_NUVOTON to defconfig
  - Add the clock driver
  - Add the reset driver
  - Add the serial driver
  - Add us to the maintainer

v4:
  - patch 4/5 is a resend
  - Fixed dt_binding_check errors of nuvoton,ma35d1-clk.yaml
  - Modify ma35d1.dtsi
    1. Add a node hxt_24m
    2. Fixed the base address of gic node
    3. Add clocks and clock-names to clock node
  - Fixed borad binding mistakes of nuvoton.yaml

v3:
  - added patch 4/5 and 5/5
  - introduce CONFIG_ARCH_NUVOTON option
  - add initial bindings for Nuvoton Platform boards
  - fixed coding style problem of nuvoton,ma35d1-clk.h
  - added CAPLL to clock-controller node
  - modify the chosen node of ma35d1-evb.dts
  - modify clock yaml "clk-pll-mode" to "nuvoton,clk-pll-mode"

v2:
  - fixed dt_binding_check failed of nuvoton,ma35d1-clk.yaml

Jacky Huang (10):
  arm64: Kconfig.platforms: Add config for Nuvoton MA35 platform
  arm64: defconfig: Add support for Nuvoton MA35 family SoCs
  dt-bindings: clock: nuvoton: add binding for ma35d1 clock controller
  dt-bindings: reset: nuvoton: Document ma35d1 reset control
  dt-bindings: arm: Add initial bindings for Nuvoton platform
  dt-bindings: serial: Document ma35d1 uart controller
  arm64: dts: nuvoton: Add initial ma35d1 device tree
  clk: nuvoton: Add clock driver for ma35d1 clock controller
  reset: Add Nuvoton ma35d1 reset driver support
  tty: serial: Add Nuvoton ma35d1 serial driver support

 .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  |  30 +
 .../npcm.yaml => nuvoton/nuvoton,npcm.yaml}   |   2 +-
 .../bindings/clock/nuvoton,ma35d1-clk.yaml    |  63 ++
 .../bindings/reset/nuvoton,ma35d1-reset.yaml  |  45 +
 .../serial/nuvoton,ma35d1-serial.yaml         |  48 +
 .../nuvoton/nuvoton,npcm-gcr.yaml}            |   2 +-
 MAINTAINERS                                   |  13 +-
 arch/arm64/Kconfig.platforms                  |   8 +
 arch/arm64/boot/dts/nuvoton/Makefile          |   2 +
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  56 ++
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  56 ++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 234 +++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/Kconfig                           |   1 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/nuvoton/Kconfig                   |  19 +
 drivers/clk/nuvoton/Makefile                  |   4 +
 drivers/clk/nuvoton/clk-ma35d1-divider.c      | 135 +++
 drivers/clk/nuvoton/clk-ma35d1-pll.c          | 361 +++++++
 drivers/clk/nuvoton/clk-ma35d1.c              | 933 ++++++++++++++++++
 drivers/reset/Kconfig                         |   6 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-ma35d1.c                  | 235 +++++
 drivers/tty/serial/Kconfig                    |  18 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/ma35d1_serial.c            | 808 +++++++++++++++
 .../dt-bindings/clock/nuvoton,ma35d1-clk.h    | 253 +++++
 .../dt-bindings/reset/nuvoton,ma35d1-reset.h  | 108 ++
 include/uapi/linux/serial_core.h              |   3 +
 29 files changed, 3444 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml
 rename Documentation/devicetree/bindings/arm/{npcm/npcm.yaml => nuvoton/nuvoton,npcm.yaml} (93%)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.yaml
 rename Documentation/devicetree/bindings/{arm/npcm/nuvoton,gcr.yaml => soc/nuvoton/nuvoton,npcm-gcr.yaml} (93%)
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
 create mode 100644 drivers/clk/nuvoton/Kconfig
 create mode 100644 drivers/clk/nuvoton/Makefile
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1-divider.c
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1-pll.c
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1.c
 create mode 100644 drivers/reset/reset-ma35d1.c
 create mode 100644 drivers/tty/serial/ma35d1_serial.c
 create mode 100644 include/dt-bindings/clock/nuvoton,ma35d1-clk.h
 create mode 100644 include/dt-bindings/reset/nuvoton,ma35d1-reset.h

-- 
2.34.1

