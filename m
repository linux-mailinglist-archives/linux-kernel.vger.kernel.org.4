Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFCA6F9AEA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 20:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjEGSeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 14:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEGSeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 14:34:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CCA6E93;
        Sun,  7 May 2023 11:34:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9543161C65;
        Sun,  7 May 2023 18:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691D1C433D2;
        Sun,  7 May 2023 18:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683484453;
        bh=6wkccwfFp70jUqmzDa70DrICPNNNF/6YSnMyCoDzYtA=;
        h=From:To:Cc:Subject:Date:From;
        b=GGfJb8xhCtbBizsSgq+L/pzFC+wkkmQpgHPMmB2mCjLgflAzd1Jz4/tmtpjbC4qVl
         latiE9fgxVZ0BitcJNUdSCf7T5/A4dEXi6ytz/HhYq3qlpRparmrSSccKBVMQ65UQw
         pQFhGKhIMe/4ubpF4kqqezODN9244vkj2GaOBU0KwswKkuiHdPZHvW6kTzJsvqSHEp
         6SVC5mFuPhZfVAoHSV/mTzlEd5M61gV6cREX2WkExyYl3ioaB0vV8hYohrkBABxWK5
         Kg/JWGMiaaVJ3eBqnVKpAdrOyXnUdtU98a0TOROKFJ8fvYr1rwG4uYdeLyPL9rplCo
         w1aiD2EpYsSHw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Subject: [PATCH 0/5] Add Sipeed Lichee Pi 4A RISC-V board support
Date:   Mon,  8 May 2023 02:22:59 +0800
Message-Id: <20230507182304.2934-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sipeed's Lichee Pi 4A development board uses Lichee Module 4A core
module which is powered by T-HEAD's light(a.k.a TH1520) SoC. Add
minimal device tree files for the core module and the development
board.

Support basic uart/gpio/dmac drivers, so supports booting to a basic
shell.

Jisheng Zhang (5):
  irqchip/sifive-plic: Support T-HEAD's C910 PLIC
  riscv: Add the T-HEAD SoC family Kconfig option
  riscv: dts: add initial T-HEAD light SoC device tree
  riscv: dts: thead: add sipeed Lichee Pi 4A board device tree
  MAINTAINERS: add entry for T-HEAD RISC-V SoC

 .../sifive,plic-1.0.0.yaml                    |   4 +
 MAINTAINERS                                   |   6 +
 arch/riscv/Kconfig.socs                       |   6 +
 arch/riscv/boot/dts/Makefile                  |   1 +
 arch/riscv/boot/dts/thead/Makefile            |   2 +
 .../dts/thead/light-lichee-module-4a.dtsi     |  38 ++
 .../boot/dts/thead/light-lichee-pi-4a.dts     |  32 ++
 arch/riscv/boot/dts/thead/light.dtsi          | 454 ++++++++++++++++++
 drivers/irqchip/irq-sifive-plic.c             |   1 +
 9 files changed, 544 insertions(+)
 create mode 100644 arch/riscv/boot/dts/thead/Makefile
 create mode 100644 arch/riscv/boot/dts/thead/light-lichee-module-4a.dtsi
 create mode 100644 arch/riscv/boot/dts/thead/light-lichee-pi-4a.dts
 create mode 100644 arch/riscv/boot/dts/thead/light.dtsi

-- 
2.40.0

