Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC55734A92
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 05:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjFSDXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 23:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFSDXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 23:23:38 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8586E4C;
        Sun, 18 Jun 2023 20:23:36 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-541f4ee6f89so2057983eaf.2;
        Sun, 18 Jun 2023 20:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687145016; x=1689737016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R/URVcwlUJxFg0RTaUSG0e9d5zefFVGNA9S05TryLWk=;
        b=AaGtHulSvzJcZZWXqrsJXrD1/ovFvq1Yokc1DuXc5X9qIQEPsxOjCzY+HnoSWJ0y+Z
         YB0ul245+chtOrh1YxUBozCVYWcrqpRrSEEYUHMhH3wroJycLfm6hR/8Fvm5x7Ek+7/x
         +9WF2Wo8XsLDp+67yFD4dXhJdXPBR3DOxMaAaSJNwQYiuTkmo85xlAuD/x7XPrqpcgL3
         p4u/ayJpT7j8lhVgTLgryrlPmL4Wc7CMo9mBKpTxYYDS6tIuS1Lt3XGSEsra0MuyFyss
         Pov2RjMGoac9h++F9dq1WvS3BSi33H/mxrm66rl19Z/tdCoJGtfgHGYV5lWvyqATLWFk
         Bg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687145016; x=1689737016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R/URVcwlUJxFg0RTaUSG0e9d5zefFVGNA9S05TryLWk=;
        b=dCHwP/sjjxQH+eweyUUaQ4liIAPvOjQUaZJ/t6TJ8wPElvVchdpJxyH+q6FIxUIQpz
         raOi+iSIGahW7T9fzERkjBoZqWHYqAMAV6Aj4K3EEp0IcdzU0atE6W2WlLmgnOTZQtnL
         Q6tz/Fz3JO1MxpoAz9j60wZ4WLmMZEh5VTKuzlvTrYlgTGVKk+dW7qyRsOyrwVr3ingn
         V58m1IqM0p2YFwpthsreJH1uXsZoqBlvYCmzskVskvbHWLdRNB6qPaWLAVd+Q74V+otc
         w4FoqMelHWT6T0gUP8mUObX4gaGvryka+joZEInivU0/i2COeUNJtG5nW6vKOHWT17ee
         j4cA==
X-Gm-Message-State: AC+VfDwr9Ccc3+FGIFTyTJFJjxE0hGTpunZnFvkDaBLOjUEdgbGdJsph
        eBgcfokKPN0aRB+RTvBHmf0=
X-Google-Smtp-Source: ACHHUZ6veHjV1YzQDokbmdcMUV4xJcLpRtRWHnq4/5F7dICcAFwSOv56JbHdfWqdcuCSJTavYQAwZA==
X-Received: by 2002:aca:2b0b:0:b0:396:d10:43a0 with SMTP id i11-20020aca2b0b000000b003960d1043a0mr9026597oik.46.1687145016084;
        Sun, 18 Jun 2023 20:23:36 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b001a4fecf79e4sm19329817plh.49.2023.06.18.20.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 20:23:35 -0700 (PDT)
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
Subject: [PATCH v15 0/2] Introduce Nuvoton ma35d1 SoC
Date:   Mon, 19 Jun 2023 03:23:28 +0000
Message-Id: <20230619032330.233796-1-ychuang570808@gmail.com>
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

This patchset had been applied to Linux kernel 6.4.0-rc6
and tested on the Nuvoton ma35d1 SOM evaluation board.

(ma35d1 information: https://www.nuvoton.com/products/microprocessors/arm-cortex-a35-mpus/)
MA35D1 porting on linux-5.10.y can be found at: https://github.com/OpenNuvoton/MPU-Family

v15:
  - Modified the serial driver
    - Instead of adding a new port type PORT_MA35 to serial_core.h,
      now using port->type = 1.
    - Updated Kconfig descriptions.
    - Added a description about the name ttyNVT to the patch log.
  - Modified the clock driver
    - Added clk-ma35d1.h for external functions.
    - Updated all parent strings as clk_parent_data.

v14:
  - Removed patches PATCH v13 1/10 ~ 9/10 as they were applied
  - Modify serial driver
    - Fixed coding style issues

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

Jacky Huang (2):
  tty: serial: Add Nuvoton ma35d1 serial driver support
  clk: nuvoton: Add clock driver for ma35d1 clock controller

 drivers/clk/Kconfig                      |    1 +
 drivers/clk/Makefile                     |    1 +
 drivers/clk/nuvoton/Kconfig              |   19 +
 drivers/clk/nuvoton/Makefile             |    4 +
 drivers/clk/nuvoton/clk-ma35d1-divider.c |  132 +++
 drivers/clk/nuvoton/clk-ma35d1-pll.c     |  360 ++++++++
 drivers/clk/nuvoton/clk-ma35d1.c         | 1046 ++++++++++++++++++++++
 drivers/clk/nuvoton/clk-ma35d1.h         |   18 +
 drivers/tty/serial/Kconfig               |   23 +
 drivers/tty/serial/Makefile              |    1 +
 drivers/tty/serial/ma35d1_serial.c       |  821 +++++++++++++++++
 11 files changed, 2426 insertions(+)
 create mode 100644 drivers/clk/nuvoton/Kconfig
 create mode 100644 drivers/clk/nuvoton/Makefile
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1-divider.c
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1-pll.c
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1.c
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1.h
 create mode 100644 drivers/tty/serial/ma35d1_serial.c

-- 
2.34.1

