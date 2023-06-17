Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7FC73422C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 18:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjFQQ04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 12:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjFQQ0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 12:26:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5601139;
        Sat, 17 Jun 2023 09:26:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AD7D60BA8;
        Sat, 17 Jun 2023 16:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703E8C433C0;
        Sat, 17 Jun 2023 16:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687019212;
        bh=7whImffFsXNXDTUSndk8VRw8HLujcf+MIoj28Sa/Sis=;
        h=From:To:Cc:Subject:Date:From;
        b=Spid7fkQoa7mD6jP8afMn0ZMHtWS0hnOJOwdOlG/zGMBTA/Q92s1OiZkGG2yfDaAX
         OZ7SAnEjhXGimqC39e7wWtBhJKdUGEwU7KDHKWRdj7bDjc8w1LOMu9tT5kFcqldx9e
         e2JqjwxrmYCciHwjWHHf6wDUNpdyioM/pq4e5qXDUTyGA/uySHErsV2PdTV6RhrtCu
         4Wi/oJ+5MdBLs77TR5bE0r6dTR9A1EdwIZb6CYgEiHF3rFIipBE9qufSkma9MXAb5V
         uUAvz0E3IsHsJCDOrangX5pl21erj3lv1MTc0V6W2AtbmHawJBhP8y79Xfd2pufeQs
         wHG4SxOvB5oog==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 0/8] Add Sipeed Lichee Pi 4A RISC-V board support
Date:   Sun, 18 Jun 2023 00:15:21 +0800
Message-Id: <20230617161529.2092-1-jszhang@kernel.org>
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

NOTE: the thead cpu reset dt-binding and DT node are removed in v3. This
makes secondary CPUs unable to be online. However, minimal th1520
support is better than nothing. And the community has been working on
and will work on the cpu reset dt-binding, for example, Conor, Guo and
Jessica are discussing about it, I have seen valuable comments and
inputs from them. I believe we can add back cpu reset in next
development window.

Thanks

Since v2:
  - remove thead cpu-rst dt-binding doc and its DT node from th1520.dtsi
  - collect Reviewed-by and Acked-by tags
  - update uart reg size as suggested by Yixun
  - Add Guo Ren and Fu Wei as THEAD SoCs Maintainers

Since v1:
  - add missing plic, clint, th1520 itself dt-bindings
  - use c900-plic
  - s/light/th1520
  - add dt-binding for T-HEAD CPU reset
  - enable ARCH_THEAD in defconfig
  - fix all dtbs_check error/warning except the CPU RESET, see above.

Jisheng Zhang (8):
  dt-bindings: interrupt-controller: Add T-HEAD's TH1520 PLIC
  dt-bindings: timer: Add T-HEAD TH1520 clint
  dt-bindings: riscv: Add T-HEAD TH1520 board compatibles
  riscv: Add the T-HEAD SoC family Kconfig option
  riscv: dts: add initial T-HEAD TH1520 SoC device tree
  riscv: dts: thead: add sipeed Lichee Pi 4A board device tree
  MAINTAINERS: add entry for T-HEAD RISC-V SoC
  riscv: defconfig: enable T-HEAD SoC

 .../sifive,plic-1.0.0.yaml                    |   1 +
 .../devicetree/bindings/riscv/thead.yaml      |  29 ++
 .../bindings/timer/sifive,clint.yaml          |   1 +
 MAINTAINERS                                   |   8 +
 arch/riscv/Kconfig.socs                       |   6 +
 arch/riscv/boot/dts/Makefile                  |   1 +
 arch/riscv/boot/dts/thead/Makefile            |   2 +
 .../dts/thead/th1520-lichee-module-4a.dtsi    |  38 ++
 .../boot/dts/thead/th1520-lichee-pi-4a.dts    |  32 ++
 arch/riscv/boot/dts/thead/th1520.dtsi         | 422 ++++++++++++++++++
 arch/riscv/configs/defconfig                  |   1 +
 11 files changed, 541 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/thead.yaml
 create mode 100644 arch/riscv/boot/dts/thead/Makefile
 create mode 100644 arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
 create mode 100644 arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
 create mode 100644 arch/riscv/boot/dts/thead/th1520.dtsi

-- 
2.40.0

