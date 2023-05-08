Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493CF6F9DE9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 04:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjEHC7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 22:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEHC7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 22:59:45 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1687DBD;
        Sun,  7 May 2023 19:59:44 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-52c6f81193cso2734357a12.1;
        Sun, 07 May 2023 19:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683514783; x=1686106783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cr2z/ioqIoXjL8G8xbpb2j6Zw3xgpr1RQ8tUYJ7S/KA=;
        b=qaijRNHfAC6/mLTf8wI5Lm/r5GcDhQiHoWvfOIV7CW1R/xdIMXJvv8M9UoHSERR5Ov
         xFfTMPM7AN71moRjJKtyKnatommuKKEeSkosGSDoEw8JuJlryayAa29R+jqbDNzOjpzH
         emFUCcXuVMFudIEkNcVnZzococUx1BLVDYDjP1wy2RPU432neBJDKq5k8mCIhf0gaGB5
         O447CXQJEZwUAp20K9nJlpMc8vmJpOt/ac8Af1d2khbzTxdgWv7YGBZDC7fz6cDnVDwm
         1yQgNWMfLkOCO/foURg6XwAM6TZkZOi+ZaiycruEYxh/+bz/HpZ3bpDCeilSHZcyP5vm
         tEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683514783; x=1686106783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cr2z/ioqIoXjL8G8xbpb2j6Zw3xgpr1RQ8tUYJ7S/KA=;
        b=HIrTS3pZn04kRcb8Q7qJ1KFI6J2xYTx3tWT1vwGXfpFVSE4PfhGlqghG9XcWHBnUCR
         Fc2OKkwIGnJtgHaMeE+MCXwYj/+ZHQ5IVOnOE8VmVYZsIxbW11hXV5EkUY5qOnmnB48e
         BhCjHApRUbBnSOPArK/3CgbE5oOfCjTKJy3/L19pALou7+y0pzhXDkS6PJiLQ+oua3Fe
         vcjrZipKnoM7nBEqgfdm5cun/ri6DhBXF1AuG8WghKsJb9ntD9nzDNkfK4QtEggXGWIz
         NccbvklOD9SKZ4rJBAyfLCe+QeRdRAUzBpHkPZd+P6paGzFI+hwlbPjgaBEQpz3zBZZE
         3yLA==
X-Gm-Message-State: AC+VfDxI7ZPD6pFDU2TLmgz1C6E/Vj51dQLWhUwvcYgXb7Ox7lSsHnUF
        ahpZJQrtd1XVO4av7qREDNv+F67scDwrsQ==
X-Google-Smtp-Source: ACHHUZ4At6ZmowF7k1qDICeykgbLxo4i/+hi8EP2UrPfQRDvJMYVjWN1002Dw7Y4t3ekXWOJP/lZiQ==
X-Received: by 2002:a05:6a20:914b:b0:100:80dd:afc6 with SMTP id x11-20020a056a20914b00b0010080ddafc6mr2005085pzc.7.1683514783424;
        Sun, 07 May 2023 19:59:43 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id y3-20020aa78543000000b0064559b58eb8sm1525422pfn.154.2023.05.07.19.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 19:59:43 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, tmaimon77@gmail.com, catalin.marinas@arm.com,
        will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v10 00/10] Introduce Nuvoton ma35d1 SoC
Date:   Mon,  8 May 2023 02:59:26 +0000
Message-Id: <20230508025936.36776-1-ychuang570808@gmail.com>
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

This patchset had been applied to Linux kernel 6.4.0-rc1-dirty
and tested on the Nuvoton ma35d1 SOM evaluation board.

(ma35d1 information: https://www.nuvoton.com/products/microprocessors/arm-cortex-a35-mpus/)
MA35D1 porting on linux-5.10.y can be found at: https://github.com/OpenNuvoton/MPU-Family

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
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 232 +++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/nuvoton/Kconfig                   |  19 +
 drivers/clk/nuvoton/Makefile                  |   4 +
 drivers/clk/nuvoton/clk-ma35d1-divider.c      | 140 +++
 drivers/clk/nuvoton/clk-ma35d1-pll.c          | 365 +++++++
 drivers/clk/nuvoton/clk-ma35d1.c              | 948 ++++++++++++++++++
 drivers/reset/Kconfig                         |   6 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-ma35d1.c                  | 234 +++++
 drivers/tty/serial/Kconfig                    |  18 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/ma35d1_serial.c            | 796 +++++++++++++++
 .../dt-bindings/clock/nuvoton,ma35d1-clk.h    | 253 +++++
 .../dt-bindings/reset/nuvoton,ma35d1-reset.h  | 108 ++
 27 files changed, 3449 insertions(+), 3 deletions(-)
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

