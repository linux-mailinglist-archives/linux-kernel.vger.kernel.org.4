Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18326BA928
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjCOHae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjCOH36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:29:58 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025776C185;
        Wed, 15 Mar 2023 00:29:09 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id i5so19121160pla.2;
        Wed, 15 Mar 2023 00:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678865348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HHBG+GBH2Y36NH+y5oqClFdickE+NYlXm3x/SDfpRmU=;
        b=LP9VfDZ8o0b2f8nkY9qkxCfALKqP0kGRvUwiitl1P2PB35MO7NZ/2sXc+5DLUBbo4l
         W8NYwsakx1Bxnj509vaV3p84a/uVZb/Np6Z3xFh2O0q4Wu62W6GPQegTQDvCXFd6PNyv
         xJS2PoKxuQ+9P0Quh97yG0V/PpnK9Z3thOZkuw/3Xi0Assq9D9/JG+FW2ojPRQOZVA8i
         q+K65c6IGYLIBeKKsy6IjOQ9HF0gYd8GnUKpa1kXIECOGMxRlLSwvhgLZ8xEmPyRXwXf
         N3FJBQ0a1rbYmkNNmM2ch/1LVyJRDB5RTMOFbtx8ZJ+NL71ETSNgf7UAvbznB6HF7b0x
         lEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678865348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHBG+GBH2Y36NH+y5oqClFdickE+NYlXm3x/SDfpRmU=;
        b=C0z3/CqmU8GF7oLxNl8RuAAbGBoRgjWT2sJiyEBx+2NtO48TCkCxBF3zXSrDa3qF4+
         WpmYVREej8xf4cSShfME+W/hfYNjinw04Z7nA6ZfRmZaJFaR2J+i6tfMqipVDDb6C5tT
         Lvymio9xUer39/9wkef4DcHrJkL3us6FEIB5FXlcFff3VhDHR6dbN9Jnce7bCzJC0kbB
         J1Ytyhee59BtmYRAzw4gjin5cSlUt0p49sJfX9TjZ1m3DzZmjVqc1LTn0318Qxw8bYFb
         SJ123MXEsO5i4fYNXqckualL8PgEcG6zx2mIwI3ZdB+D+EsQ21XFmha1Genm5FYMR1ZO
         nPxw==
X-Gm-Message-State: AO0yUKVRDOZKPunn62jVFDpvwKSrZcs9IvvpmMKM4d0QLx7lCcnQuSZ1
        g26n0duUcslEQHkIqroO98w=
X-Google-Smtp-Source: AK7set+IQmNam8y5NMeNhZKMBu+L44gcs3L+F1T9/MGbySKvfES+ivyf76SIptpiuqvswlomnfhVSw==
X-Received: by 2002:a17:902:e74d:b0:19e:6bc5:8769 with SMTP id p13-20020a170902e74d00b0019e6bc58769mr1819994plf.69.1678865348685;
        Wed, 15 Mar 2023 00:29:08 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id kz11-20020a170902f9cb00b001a0667822c8sm2740003plb.94.2023.03.15.00.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 00:29:08 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 00/15] Introduce Nuvoton ma35d1 SoC
Date:   Wed, 15 Mar 2023 07:28:47 +0000
Message-Id: <20230315072902.9298-1-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

This patchset had been applied to Linux kernel 6.3-rc2 and tested on the
Nuvoton ma35d1 SOM evaluation board.

(ma35d1 information: https://www.nuvoton.com/products/microprocessors/arm-cortex-a35-mpus/)
MA35D1 porting on linux-5.10.y can be found at: https://github.com/OpenNuvoton/MPU-Family

Jacky Huang (15):
  arm64: Kconfig.platforms: Add config for Nuvoton MA35 platform
  arm64: defconfig: Add Nuvoton MA35 family support
  mfd: Add the header file of Nuvoton ma35d1 system manager
  dt-bindings: clock: nuvoton: add binding for ma35d1 clock controller
  dt-bindings: reset: nuvoton: add binding for ma35d1 IP reset control
  dt-bindings: mfd: syscon: Add nuvoton,ma35d1-sys compatible
  dt-bindings: arm: Add initial bindings for Nuvoton platform
  dt-bindings: clock: Document ma35d1 clock controller bindings
  dt-bindings: reset: Document ma35d1 reset controller bindings
  dt-bindings: serial: Document ma35d1 uart controller bindings
  arm64: dts: nuvoton: Add initial ma35d1 device tree
  clk: nuvoton: Add clock driver for ma35d1 clock controller
  reset: Add Nuvoton ma35d1 reset driver support
  tty: serial: Add Nuvoton ma35d1 serial driver support
  MAINTAINERS: Add entry for NUVOTON MA35

 .../devicetree/bindings/arm/nuvoton.yaml      |  30 +
 .../bindings/clock/nuvoton,ma35d1-clk.yaml    |  83 ++
 .../devicetree/bindings/mfd/syscon.yaml       |   1 +
 .../bindings/reset/nuvoton,ma35d1-reset.yaml  |  50 +
 .../serial/nuvoton,ma35d1-serial.yaml         |  52 +
 MAINTAINERS                                   |  12 +
 arch/arm64/Kconfig.platforms                  |   9 +
 arch/arm64/boot/dts/nuvoton/Makefile          |   2 +
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  24 +
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  23 +
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 272 +++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/nuvoton/Makefile                  |   4 +
 drivers/clk/nuvoton/clk-ma35d1-divider.c      | 144 +++
 drivers/clk/nuvoton/clk-ma35d1-pll.c          | 534 ++++++++++
 drivers/clk/nuvoton/clk-ma35d1.c              | 970 ++++++++++++++++++
 drivers/clk/nuvoton/clk-ma35d1.h              | 198 ++++
 drivers/reset/Kconfig                         |   6 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-ma35d1.c                  | 152 +++
 drivers/tty/serial/Kconfig                    |  18 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/ma35d1_serial.c            | 842 +++++++++++++++
 drivers/tty/serial/ma35d1_serial.h            |  93 ++
 .../dt-bindings/clock/nuvoton,ma35d1-clk.h    | 253 +++++
 .../dt-bindings/reset/nuvoton,ma35d1-reset.h  | 108 ++
 include/linux/mfd/ma35d1-sys.h                |  95 ++
 include/uapi/linux/serial_core.h              |   3 +
 29 files changed, 3982 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/nuvoton.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.yaml
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
 create mode 100644 drivers/clk/nuvoton/Makefile
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1-divider.c
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1-pll.c
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1.c
 create mode 100644 drivers/clk/nuvoton/clk-ma35d1.h
 create mode 100644 drivers/reset/reset-ma35d1.c
 create mode 100644 drivers/tty/serial/ma35d1_serial.c
 create mode 100644 drivers/tty/serial/ma35d1_serial.h
 create mode 100644 include/dt-bindings/clock/nuvoton,ma35d1-clk.h
 create mode 100644 include/dt-bindings/reset/nuvoton,ma35d1-reset.h
 create mode 100644 include/linux/mfd/ma35d1-sys.h

-- 
2.34.1

