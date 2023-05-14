Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341A7701E7A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 19:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbjENRIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 13:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjENRII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 13:08:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607F54230;
        Sun, 14 May 2023 10:08:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E04DB618B8;
        Sun, 14 May 2023 17:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303B8C433D2;
        Sun, 14 May 2023 17:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684084082;
        bh=srHAo0Y9b1qf2rL+g1G7GWSxmyN50IIlO+TTLU3U41E=;
        h=From:To:Cc:Subject:Date:From;
        b=hhX7qZTcONw+c5MKoJz/MFIzS2L9mGoGHUx01wCjDsf9VjRwGicpXV1a0c+XIoQ2k
         StCZ2xLDojeV7i0RQTG3/yGXGc8kh+Tp0M2nyUfeFuCLbNlz8sd9LEFqPwzxX6DCZK
         +qYQ1hgxhy1iRVJbwBCDwSimRsMHXj/cez1MV7k/ZZNX6RhCwmGVom614WnumvF+7n
         IYbM7tXXu1kEFGVxPXmrxOwlOSjyZNLbKM2ueOB/trhKKEeDzKb1W0o6p9CXeXhk6A
         FPIcQDTiumYo2Q2i0p5fB1K/mdIop5yHkpvunXwXg1fsEkni5uLSrlsbR8epSfdOQX
         LcUE/gbPaNmKw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v3 00/10] riscv: add Bouffalolab bl808 support
Date:   Mon, 15 May 2023 00:56:41 +0800
Message-Id: <20230514165651.2199-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds Bouffalolab uart driver and basic devicetrees for
Bouffalolab bl808 SoC and Sipeed M1s dock board.

Since v2:
  - fix dt_binding_check and dtbs_check warnings
  - use uart_port_tx_limited() helper in uart driver
  - collect Acked-by/Reviewed-by tag
  - uart0 -> uart3
  - update "riscv,ndev" property
  - mv vendor prefix binding as the first patch
  - add compatible string for bouffalolab bl808 plic

Since v1:
  - use FIELD_PREP and FIELD_GET macro
  - rewrite bflb_uart_tx_chars()
  - add vendor prefix for bouffalolab
  - add dt binding for bl808 compatibles
  - enable SOC_BOUFFALOLAB in defconfig
  - collect Reviewed-by tag
  - modify commit-msg as suggested


Jisheng Zhang (10):
  dt-bindings: vendor-prefixes: add bouffalolab
  dt-bindings: interrupt-controller: Add bouffalolab bl808 plic
  dt-bindings: serial: add documentation for Bouffalolab UART Driver
  serial: bflb_uart: add Bouffalolab UART Driver
  riscv: add the Bouffalolab SoC family Kconfig option
  dt-bindings: riscv: Add bouffalolab bl808 board compatibles
  riscv: dts: bouffalolab: add the bl808 SoC base device tree
  riscv: dts: bouffalolab: add Sipeed M1s SoM and Dock devicetree
  MAINTAINERS: riscv: add entry for Bouffalolab SoC
  riscv: defconfig: enable BOUFFALOLAB SoC

 .../sifive,plic-1.0.0.yaml                    |   1 +
 .../bindings/riscv/bouffalolab.yaml           |  29 +
 .../serial/bouffalolab,bl808-uart.yaml        |  47 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 arch/riscv/Kconfig.socs                       |   5 +
 arch/riscv/boot/dts/Makefile                  |   1 +
 arch/riscv/boot/dts/bouffalolab/Makefile      |   2 +
 .../dts/bouffalolab/bl808-sipeed-m1s-dock.dts |  25 +
 .../dts/bouffalolab/bl808-sipeed-m1s.dtsi     |  21 +
 arch/riscv/boot/dts/bouffalolab/bl808.dtsi    |  73 +++
 arch/riscv/configs/defconfig                  |   1 +
 drivers/tty/serial/Kconfig                    |  18 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/bflb_uart.c                | 586 ++++++++++++++++++
 include/uapi/linux/serial_core.h              |   3 +
 16 files changed, 822 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/bouffalolab.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/bouffalolab,bl808-uart.yaml
 create mode 100644 arch/riscv/boot/dts/bouffalolab/Makefile
 create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s-dock.dts
 create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dtsi
 create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808.dtsi
 create mode 100644 drivers/tty/serial/bflb_uart.c

-- 
2.40.0

