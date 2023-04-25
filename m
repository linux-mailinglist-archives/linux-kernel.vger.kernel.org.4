Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9BC6EE026
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjDYKYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjDYKY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:24:27 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D004FF;
        Tue, 25 Apr 2023 03:24:25 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b70f0b320so7373095b3a.1;
        Tue, 25 Apr 2023 03:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682418265; x=1685010265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vUpPEEUcQ8oEhNmbDyWnCAvrC+gdbAAhpl1Eoh+Mtd0=;
        b=JVl6g1VCoBSsIjANddkMDQ9EsJdZPQUkY0qva4F/s09udH7I/q6dPgaXSGSdl3e06k
         455JyA+p3iRBbk5JuOvq+pshzdg2+Ugaufg9r27bESso52qN1vq2gmk9jF7+RS7nuCUG
         CJ8XgdnFabXEMGGXX9rIJIvi9x/PUW/UFe8lRob2I9q4BZfuDHJOgGH3gc868x35pKDi
         WiLFkmWKCOYnFpJmNbYA78fIONghRXw63zpLyXNlVXumNUMurTT6dqzN00sJ31KnGPea
         RuaZF3Qwms4EveP4zU+Y8JJ1o4ds3TNSaYfWl0lK0KE2Fs2ZHgFLJfzMBubstckqOgvx
         j9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682418265; x=1685010265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUpPEEUcQ8oEhNmbDyWnCAvrC+gdbAAhpl1Eoh+Mtd0=;
        b=CUOrtOdcF0MlAcZYDpV/HyJWDI7APFtVO5wELvTGIdnZdYQ8Y0fOh5ADtDQ++n8R5i
         EDvKImivRKVcSs1Ra8LolR40d0E+Wu9si9B5Q0bS347p3+qN8kG+B220eVuvlyD5c7e0
         oi3U++nZHDPWGNHkaqpxIes1ncEdLU78Hhr1zXlV60oWp+U+k+JKNkXFVHxZcGL0TlBJ
         48RY/eltdIg82JEs4ZWkk0Hod+E8l/8G40uFBdQu+iEhDCzeEkZkMou4ZSxCQZ/eYlsW
         57he4inT45fgyHgXOtP39enQQ6Li/ntIU2Q3y2ZhXpcr+07IafHQ3huXWJaHkAXDk2e3
         Veuw==
X-Gm-Message-State: AAQBX9cFYxjfrgwV9WrbHzjfzFP3sOAKtjNC4JlDBVdR6Q/JJ3evwcKA
        fErckFjUh44SGXpY1d0I2mc=
X-Google-Smtp-Source: AKy350YaDVjuOhau/gdbOnXJ8ASuCUl/z9IPgkaR++BGuDzGoAp3bhaW6hVaUTePlatqXxvRGWHZ+g==
X-Received: by 2002:a05:6a21:9011:b0:ec:7696:ee96 with SMTP id tq17-20020a056a21901100b000ec7696ee96mr20391868pzb.38.1682418264644;
        Tue, 25 Apr 2023 03:24:24 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 30-20020a63125e000000b0051b70c8d446sm7644715pgs.73.2023.04.25.03.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 03:24:24 -0700 (PDT)
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
Subject: [PATCH v8 00/11] Introduce Nuvoton ma35d1 SoC
Date:   Tue, 25 Apr 2023 10:24:07 +0000
Message-Id: <20230425102418.185783-1-ychuang570808@gmail.com>
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

This patchset had been applied to Linux kernel 6.4.-rc1 and tested on the
Nuvoton ma35d1 SOM evaluation board.

(ma35d1 information: https://www.nuvoton.com/products/microprocessors/arm-cortex-a35-mpus/)
MA35D1 porting on linux-5.10.y can be found at: https://github.com/OpenNuvoton/MPU-Family

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

Jacky Huang (11):
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
  MAINTAINERS: Add entry for NUVOTON MA35

 .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  |  30 +
 .../npcm.yaml => nuvoton/nuvoton,npcm.yaml}   |   2 +-
 .../bindings/clock/nuvoton,ma35d1-clk.yaml    |  63 ++
 .../bindings/reset/nuvoton,ma35d1-reset.yaml  |  45 +
 .../serial/nuvoton,ma35d1-serial.yaml         |  48 +
 .../nuvoton/nuvoton,npcm-gcr.yaml}            |   2 +-
 MAINTAINERS                                   |  13 +-
 arch/arm64/Kconfig.platforms                  |   9 +
 arch/arm64/boot/dts/nuvoton/Makefile          |   2 +
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  56 ++
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  56 ++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 232 +++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/nuvoton/Kconfig                   |  19 +
 drivers/clk/nuvoton/Makefile                  |   4 +
 drivers/clk/nuvoton/clk-ma35d1-divider.c      | 140 +++
 drivers/clk/nuvoton/clk-ma35d1-pll.c          | 364 +++++++
 drivers/clk/nuvoton/clk-ma35d1.c              | 947 ++++++++++++++++++
 drivers/reset/Kconfig                         |   6 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-ma35d1.c                  | 229 +++++
 drivers/tty/serial/Kconfig                    |  18 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/ma35d1_serial.c            | 781 +++++++++++++++
 .../dt-bindings/clock/nuvoton,ma35d1-clk.h    | 253 +++++
 .../dt-bindings/reset/nuvoton,ma35d1-reset.h  | 108 ++
 27 files changed, 3428 insertions(+), 3 deletions(-)
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

