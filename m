Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA44772B581
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 04:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbjFLCyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 22:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFLCyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 22:54:04 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11626BF;
        Sun, 11 Jun 2023 19:54:02 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-65299178ac5so4270697b3a.1;
        Sun, 11 Jun 2023 19:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686538441; x=1689130441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SJ4E1TgPuKj4e6/UbDNdpEAQ2dguYdZ7sp49HDGjVLI=;
        b=XtbMv+TYZ2FCIG+gAx6eT3GNWYeuNplC2pPNxGhm9EH9ap2kumPpsKtqD1kPX+XAgX
         4DWnK/wX4PxZNW6Mbi9J26d0wzkkj83dIcOfFTIH/qjHfD1s99JWV7y8PsCwbfeW2Yf9
         jReHN1bOYow/ky/pr6wcF76qoReaqOfWXJFhodWVcN9XN9TkZ6nN5F/h4evPjVDzoVjU
         AWoN+SkrGbtWh8uOWS6e2lhQ25VchunRJ6P5ELxJvabIzdRbATRsjh9WhVZyDoddLeX3
         NHAh3194LeKCNkEtQBNtdenoA4Lf2BGp/LtIyqjf8mA4niY+i7yrx/HS28aojBX0YC1S
         NHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686538441; x=1689130441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJ4E1TgPuKj4e6/UbDNdpEAQ2dguYdZ7sp49HDGjVLI=;
        b=EAoBPJbYNIze1heXXu2B/5vBy1/U3nrW+Y1YccH+HN0Y9gGGVB5K3/A8iIzJjywToz
         hwz+VmOb8uEUgp6cfsoAgfDppl0f+qnuaKJ5D4KTlgMRptvoeot4kKkMcPgE9MTF1SQp
         RxYgmr+iMivKqDPaVcTO4joqPnEZw8mAVZ63uyAP/pnqLL4pcDK47Rscc8lf/XAwy8af
         iQBd1IbNjNaE3wXkUl5jtGPpYJeP8j5B+cJEFgaHoCzESDFCMRujuVbG/rGNwtVJHJwk
         Rwr6D/bfnMQzgz2ZyCc7Ddk32TNBj9M+C0J/3s9n+6hckLkk2AggxW4ugJGbMdkT3fvE
         IeLA==
X-Gm-Message-State: AC+VfDyWi6jpt2he7n5PC/A+JQoethsX23fm7nnpOQQWCUSB1DtLWqey
        m4FgVGSPw4k5BzgCNWqSeVg=
X-Google-Smtp-Source: ACHHUZ5Mvcf8OPknIRnZQm3CgeiEWpRcROv0fp6QqNJv5Eu/nEMOEz9silQMOUqDgNY/o+eGRaeiLA==
X-Received: by 2002:a05:6a20:244d:b0:10c:dd4f:faa9 with SMTP id t13-20020a056a20244d00b0010cdd4ffaa9mr9762483pzc.14.1686538441367;
        Sun, 11 Jun 2023 19:54:01 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id i21-20020aa78d95000000b0064d34ace753sm5931403pfr.114.2023.06.11.19.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 19:54:00 -0700 (PDT)
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
Subject: [PATCH v14 0/1] Introduce Nuvoton ma35d1 SoC
Date:   Mon, 12 Jun 2023 02:53:54 +0000
Message-Id: <20230612025355.547871-1-ychuang570808@gmail.com>
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

Jacky Huang (1):
  tty: serial: Add Nuvoton ma35d1 serial driver support

 drivers/tty/serial/Kconfig         |  18 +
 drivers/tty/serial/Makefile        |   1 +
 drivers/tty/serial/ma35d1_serial.c | 817 +++++++++++++++++++++++++++++
 include/uapi/linux/serial_core.h   |   3 +
 4 files changed, 839 insertions(+)
 create mode 100644 drivers/tty/serial/ma35d1_serial.c

-- 
2.34.1

