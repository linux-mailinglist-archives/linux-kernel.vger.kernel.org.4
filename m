Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0DA736149
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 03:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjFTBvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 21:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjFTBvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 21:51:41 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DE6E42;
        Mon, 19 Jun 2023 18:51:30 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666eef03ebdso1267097b3a.1;
        Mon, 19 Jun 2023 18:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687225890; x=1689817890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PB+zWJazs4L4JdPzcmpzNhJsuWHk7uSora7gwTZHuyg=;
        b=g8EcvQ06uO57p0yCA4k4Mh8wO7kNGVK4ExX2mde0ypkrss4LQamM4eWw4p4qyzdtN0
         10trrf3y0ds4Zm/R7HtfigCHHVHIsudY7TWRKuGNmhysDO/Xvra7lpXnR5tC+fBv6YoB
         J5+3Bj/xbA2gzOMmv1iuiPHd7sIo61jRMj3PSRJuNwAqH9rtZodkOs1KK1QW2z4YgAhB
         TiDOuVlROkGHEwOOiFupvL3aqcas6FzpognB6MkKmkVXnR/lQvfAgN9yJ/PNio0BUkxv
         xV2k3FEMPnwsstASDHeYF9f8OKyFRBW4KIwP3UcLtrZCIcPzP7QXgWc8+ynkBtFhHrUC
         3TAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687225890; x=1689817890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PB+zWJazs4L4JdPzcmpzNhJsuWHk7uSora7gwTZHuyg=;
        b=jJwD41iE1ZlAeg3ZLImi4+ZYzS+8B6RkiCIZkrslzyDnSq2/m0mu0lqMuJaxcZI7AY
         iLtiSy0Xag3+2WZj8J0VwsUvlBuMPghK26O4dcCDc7DC6YN0c40VPOykx5HR5grIAzBy
         wtI0dhbC7eQ7JMWlXhsoD6azCUfAeiVTHGYRED8n/8hnoKTgEZnHhGWGrVj21+nGHApY
         Gh7AZ5wuamexB4JK3JL91y7ttmqXD+n3orKYMXe2JDfFLQjfWs/NLqI1unMNTt1z0g4S
         qRANRNimjxywir6lq3fFW6epCwIM41IFFFyKRmxEv9acBShpB7FRoSzRCy3cT5UmBb53
         FeMA==
X-Gm-Message-State: AC+VfDwKmN+kbuRSrXaq1KzEgq0yGG20ESZt2CQM1CQ/qJsBfWTes54N
        IImEoroaO4Cg7Xv9jRwynhI=
X-Google-Smtp-Source: ACHHUZ4+OMn7xe6jKDHH6vjIJoMvBjztdfYRDG/gXLNs8Uk0OkSEJ8+Oi+c8LGIuXXrNIiTwqjB0fQ==
X-Received: by 2002:a05:6a00:21d4:b0:668:9bf9:fa70 with SMTP id t20-20020a056a0021d400b006689bf9fa70mr224508pfj.34.1687225889683;
        Mon, 19 Jun 2023 18:51:29 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id g2-20020aa78742000000b0064f46570bb7sm240457pfo.167.2023.06.19.18.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 18:51:29 -0700 (PDT)
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
Subject: [PATCH v16 0/1] Introduce Nuvoton ma35d1 SoC
Date:   Tue, 20 Jun 2023 01:51:19 +0000
Message-Id: <20230620015120.234041-1-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

v16:
  - Removed the patch [PATCH v15 1/2] for the ma35d1 serial driver
    since it has already been added to tty-testing.
  - Updated the patch for the ma35d1 clock driver.
    There are no modifications to the driver itself compared to the
    previous version. Since the ma35d1 clock driver was picked at v13,
    we should submit modifications based on that version instead of
    sending a complete update to replace it. Create a new patch based
    on the following patch.
	[v13,08/10] clk: nuvoton: Add clock driver for ma35d1 clock controller
        https://git.kernel.org/soc/soc/c/691521a367cf

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
  - Fixed board binding mistakes of nuvoton.yaml

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
  clk: nuvoton: Use clk_parent_data instead and add a header file

 drivers/clk/nuvoton/clk-ma35d1-divider.c |   7 +-
 drivers/clk/nuvoton/clk-ma35d1-pll.c     |   5 +-
 drivers/clk/nuvoton/clk-ma35d1.c         | 737 +++++++++++++----------
 drivers/clk/nuvoton/clk-ma35d1.h         |  18 +
 4 files changed, 447 insertions(+), 320 deletions(-)
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1.h

-- 
2.34.1

