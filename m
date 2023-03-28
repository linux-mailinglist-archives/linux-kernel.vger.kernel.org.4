Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A936CB3BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjC1CTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC1CTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:19:21 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AC8171F;
        Mon, 27 Mar 2023 19:19:20 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l7so9493435pjg.5;
        Mon, 27 Mar 2023 19:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679969960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0WBf2jQarhSY4/8q0wFbU+ysG8lL+dw6EMEdvJUjZAE=;
        b=iBsrxWW+TFjjRybX8B4FNvSRyl9gv9o8e2qkj5adMi9XOXv3+uMPxe4SGfO0ZxbIpM
         Xgh37/8RbBcKf1GgVKtJIbdc67EpdZ5eDjFSCfC6ZsmPAoFolxkJxYb5nLDGJm93NmmL
         LZWR6btsCJnr0e0Q4VWxbbIEuWYIh/8pfsv1DL2xS+YdWgqpeLeom7dQfAmoua6KbuTS
         16MVGX27wJBDdwiYc9QKbEDFDsLsLYX3QPhWgKQfXFQ8eG8tNxSMJQ+4hMJUj9NcQRZg
         xjU1WdaJfHjLP90i+iC+sD6oOt6mRb9D3I3RbuOiww0hD0oImBXyNwDbkv964WHriPHV
         0LCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679969960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0WBf2jQarhSY4/8q0wFbU+ysG8lL+dw6EMEdvJUjZAE=;
        b=k4jOuUS6FNoHlfvLAAYmE85A8fa3epCcj9okQFr5pySeXkp2mGFZPE3w3L2yRIaI2/
         wpPvy5SwUBVzVhPdhfi0Ox5opeZRJb42Va8jAL10u/j26d/COfLUdCYkaU17cm8dBXQp
         XiJJ27k298W5EnKRLZWbu+A5Vy3Gq4maKwVz1KKfTRozp1inmvDSuEJVFUShkV7//7db
         y5AjlEmIfoBNuDsHveQiWqKH3D0zMUBYAd2/85nCnYt2Sp5mYbBoE3cHPhqPBWzrThO8
         5jkEDArXcfDh8vVBx4fVy7qk91TvPbFjmNBpqlgKS4OFi/BOv80moYAlmdc4Q8BNaTo/
         s2JQ==
X-Gm-Message-State: AAQBX9eSLDTURLcchhUnG1Mrq3je45JSshxeE/IMQGS+snt4eCF7LWGl
        NFNiKlFdFPyudWjGeWngGQY=
X-Google-Smtp-Source: AKy350ZmWZY6l9lRRsHhMPzolqKwxdjyI1+SD+9Rzy8K2LrjfxgG75DOeK8PQvTxmP7sNy/0JRVgzQ==
X-Received: by 2002:a17:90a:86c1:b0:237:50b6:9843 with SMTP id y1-20020a17090a86c100b0023750b69843mr13217552pjv.0.1679969960035;
        Mon, 27 Mar 2023 19:19:20 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id f17-20020a17090ac29100b00232cc61e16bsm5029301pjt.35.2023.03.27.19.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 19:19:19 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v6 00/12] Introduce Nuvoton ma35d1 SoC
Date:   Tue, 28 Mar 2023 02:19:00 +0000
Message-Id: <20230328021912.177301-1-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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

This patchset had been applied to Linux kernel 6.3-rc3 and tested on the
Nuvoton ma35d1 SOM evaluation board.

(ma35d1 information: https://www.nuvoton.com/products/microprocessors/arm-cortex-a35-mpus/)
MA35D1 porting on linux-5.10.y can be found at: https://github.com/OpenNuvoton/MPU-Family

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

Jacky Huang (12):
  arm64: Kconfig.platforms: Add config for Nuvoton MA35 platform
  arm64: defconfig: Add support for Nuvoton MA35 family SoCs
  dt-bindings: clock: nuvoton: add binding for ma35d1 clock controller
  dt-bindings: reset: nuvoton: add binding for ma35d1 IP reset control
  dt-bindings: mfd: syscon: Add nuvoton,ma35d1-sys compatible
  dt-bindings: arm: Add initial bindings for Nuvoton platform
  dt-bindings: serial: Document ma35d1 uart controller
  arm64: dts: nuvoton: Add initial ma35d1 device tree
  clk: nuvoton: Add clock driver for ma35d1 clock controller
  reset: Add Nuvoton ma35d1 reset driver support
  tty: serial: Add Nuvoton ma35d1 serial driver support
  MAINTAINERS: Add entry for NUVOTON MA35

 .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  |  30 +
 .../nuvoton,npcm-gcr.yaml}                    |   2 +-
 .../npcm.yaml => nuvoton/nuvoton,npcm.yaml}   |   2 +-
 .../bindings/clock/nuvoton,ma35d1-clk.yaml    |  72 ++
 .../devicetree/bindings/mfd/syscon.yaml       |   1 +
 .../bindings/reset/nuvoton,ma35d1-reset.yaml  |  44 +
 .../serial/nuvoton,ma35d1-serial.yaml         |  48 +
 MAINTAINERS                                   |   9 +
 arch/arm64/Kconfig.platforms                  |   9 +
 arch/arm64/boot/dts/nuvoton/Makefile          |   2 +
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  56 +
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  56 +
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 231 +++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/nuvoton/Kconfig                   |  19 +
 drivers/clk/nuvoton/Makefile                  |   4 +
 drivers/clk/nuvoton/clk-ma35d1-divider.c      | 140 +++
 drivers/clk/nuvoton/clk-ma35d1-pll.c          | 350 +++++++
 drivers/clk/nuvoton/clk-ma35d1.c              | 963 ++++++++++++++++++
 drivers/clk/nuvoton/clk-ma35d1.h              | 123 +++
 drivers/reset/Kconfig                         |   6 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-ma35d1.c                  | 152 +++
 drivers/tty/serial/Kconfig                    |  18 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/ma35d1_serial.c            | 802 +++++++++++++++
 .../dt-bindings/clock/nuvoton,ma35d1-clk.h    | 253 +++++
 .../dt-bindings/reset/nuvoton,ma35d1-reset.h  | 108 ++
 29 files changed, 3502 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuvoton,ma35d1.yaml
 rename Documentation/devicetree/bindings/arm/{npcm/nuvoton,gcr.yaml => nuvoton/nuvoton,npcm-gcr.yaml} (93%)
 rename Documentation/devicetree/bindings/arm/{npcm/npcm.yaml => nuvoton/nuvoton,npcm.yaml} (93%)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.yaml
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
 create mode 100644 drivers/clk/nuvoton/Kconfig
 create mode 100644 drivers/clk/nuvoton/Makefile
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1-divider.c
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1-pll.c
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1.c
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1.h
 create mode 100644 drivers/reset/reset-ma35d1.c
 create mode 100644 drivers/tty/serial/ma35d1_serial.c
 create mode 100644 include/dt-bindings/clock/nuvoton,ma35d1-clk.h
 create mode 100644 include/dt-bindings/reset/nuvoton,ma35d1-reset.h

-- 
2.34.1

