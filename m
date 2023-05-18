Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F5570880C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjERS4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjERS4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:56:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03BE130;
        Thu, 18 May 2023 11:56:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6290761B56;
        Thu, 18 May 2023 18:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FA5C433D2;
        Thu, 18 May 2023 18:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684436211;
        bh=MdvnMPPrQ/vtDiMGVDWtOIyHdjO99rGYjST9u7UGOX0=;
        h=From:To:Cc:Subject:Date:From;
        b=PcXlB8MZgZ4xhZB32EeIs8927VsmYw+q0bfWMgLbrj6uSBAHsdfw6MoVaJWzn1A8o
         ZOoB0DKH6M/e+KPgvbEMURCrSvm7CMaUlgnTNGkqstz+FtWH2LlrxVZDQmxMwFWoNy
         s8s67LacTxXK+WkLvLSb6kA//lWr2wjdxT/H5ITARbhWtq3a5LWgNGV/asS/IL6Y7n
         umcG0apV8J3wPxvQ5EKvmxurUj/CiGIllSJQNzvxZSU1NkiSKCKJokcoUoE1nuVjGM
         BTi2xIqNZJx6tstME5f/2g992abZS9aHQ+xseKv425eaYPHH11vFnMbHN6apO2w7wN
         +zA2zGa/xa+Ew==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Yangtao Li <frank.li@vivo.com>,
        Wei Fu <wefu@redhat.com>, Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 0/9] Add Sipeed Lichee Pi 4A RISC-V board support
Date:   Fri, 19 May 2023 02:45:32 +0800
Message-Id: <20230518184541.2627-1-jszhang@kernel.org>
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

Sipeed's Lichee Pi 4A development board uses Lichee Module 4A core
module which is powered by T-HEAD's TH1520 SoC. Add minimal device
tree files for the core module and the development board.

Support basic uart/gpio/dmac drivers, so supports booting to a basic
shell.

FWICT, one issue I'm not sure is the cpu reset dt-binding: IIUC, the
secondary CPUs in T-HEAD SMP capable platforms need some special
handling. The first one is to write the warm reset entry to entry
register. The second one is write a SoC specific control value to
a SoC specific control reg. The last one is to clone some CSRs for
secondary CPUs to ensure these CSRs' values are the same as the
main boot CPU. This DT node is mainly used by opensbi firmware.
Any suggestion about this reset dt-binding is appreciated!

Thanks

Since v1:
  - add missing plic, clint, th1520 itself dt-bindings
  - use c900-plic
  - s/light/th1520
  - add dt-binding for T-HEAD CPU reset
  - enable ARCH_THEAD in defconfig
  - fix all dtbs_check error/warning except the CPU RESET, see above.

Jisheng Zhang (9):
  dt-bindings: interrupt-controller: Add T-HEAD's TH1520 PLIC
  dt-bindings: timer: Add T-HEAD TH1520 clint
  dt-bindings: riscv: Add T-HEAD TH1520 board compatibles
  dt-binding: riscv: add T-HEAD CPU reset
  riscv: Add the T-HEAD SoC family Kconfig option
  riscv: dts: add initial T-HEAD TH1520 SoC device tree
  riscv: dts: thead: add sipeed Lichee Pi 4A board device tree
  MAINTAINERS: add entry for T-HEAD RISC-V SoC
  riscv: defconfig: enable T-HEAD SoC

 .../sifive,plic-1.0.0.yaml                    |   1 +
 .../bindings/riscv/thead,cpu-reset.yaml       |  69 +++
 .../devicetree/bindings/riscv/thead.yaml      |  29 ++
 .../bindings/timer/sifive,clint.yaml          |   1 +
 MAINTAINERS                                   |   6 +
 arch/riscv/Kconfig.socs                       |   6 +
 arch/riscv/boot/dts/Makefile                  |   1 +
 arch/riscv/boot/dts/thead/Makefile            |   2 +
 .../dts/thead/th1520-lichee-module-4a.dtsi    |  38 ++
 .../boot/dts/thead/th1520-lichee-pi-4a.dts    |  32 ++
 arch/riscv/boot/dts/thead/th1520.dtsi         | 451 ++++++++++++++++++
 arch/riscv/configs/defconfig                  |   1 +
 12 files changed, 637 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/thead,cpu-reset.yaml
 create mode 100644 Documentation/devicetree/bindings/riscv/thead.yaml
 create mode 100644 arch/riscv/boot/dts/thead/Makefile
 create mode 100644 arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
 create mode 100644 arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
 create mode 100644 arch/riscv/boot/dts/thead/th1520.dtsi

-- 
2.40.0

