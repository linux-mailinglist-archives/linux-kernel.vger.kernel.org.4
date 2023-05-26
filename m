Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9117C711DB0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 04:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjEZCT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 22:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjEZCT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 22:19:26 -0400
Received: from smtp.gentoo.org (dev.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC11FB2;
        Thu, 25 May 2023 19:19:22 -0700 (PDT)
Date:   Fri, 26 May 2023 10:19:10 +0800
From:   Yixun Lan <dlan@gentoo.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        devicetree@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Wei Fu <wefu@redhat.com>
Subject: Re: [PATCH v2 0/9] Add Sipeed Lichee Pi 4A RISC-V board support
Message-ID: <ZHAXHs03kXNgp0QF@ofant>
References: <20230518184541.2627-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518184541.2627-1-jszhang@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng
On 02:45 Fri 19 May     , Jisheng Zhang wrote:
> Sipeed's Lichee Pi 4A development board uses Lichee Module 4A core
> module which is powered by T-HEAD's TH1520 SoC. Add minimal device
> tree files for the core module and the development board.
> 
> Support basic uart/gpio/dmac drivers, so supports booting to a basic
> shell.
> 
> FWICT, one issue I'm not sure is the cpu reset dt-binding: IIUC, the
> secondary CPUs in T-HEAD SMP capable platforms need some special
> handling. The first one is to write the warm reset entry to entry
> register. The second one is write a SoC specific control value to
> a SoC specific control reg. The last one is to clone some CSRs for
> secondary CPUs to ensure these CSRs' values are the same as the
> main boot CPU. This DT node is mainly used by opensbi firmware.
> Any suggestion about this reset dt-binding is appreciated!
> 
> Thanks
> 
> Since v1:
>   - add missing plic, clint, th1520 itself dt-bindings
>   - use c900-plic
>   - s/light/th1520
>   - add dt-binding for T-HEAD CPU reset
>   - enable ARCH_THEAD in defconfig
>   - fix all dtbs_check error/warning except the CPU RESET, see above.
it would be nice to have a URL reference to v0
https://lore.kernel.org/all/20230507182304.2934-1-jszhang@kernel.org/

> 
> Jisheng Zhang (9):
>   dt-bindings: interrupt-controller: Add T-HEAD's TH1520 PLIC
>   dt-bindings: timer: Add T-HEAD TH1520 clint
>   dt-bindings: riscv: Add T-HEAD TH1520 board compatibles
>   dt-binding: riscv: add T-HEAD CPU reset
>   riscv: Add the T-HEAD SoC family Kconfig option
>   riscv: dts: add initial T-HEAD TH1520 SoC device tree
>   riscv: dts: thead: add sipeed Lichee Pi 4A board device tree
>   MAINTAINERS: add entry for T-HEAD RISC-V SoC
>   riscv: defconfig: enable T-HEAD SoC
> 
>  .../sifive,plic-1.0.0.yaml                    |   1 +
>  .../bindings/riscv/thead,cpu-reset.yaml       |  69 +++
>  .../devicetree/bindings/riscv/thead.yaml      |  29 ++
>  .../bindings/timer/sifive,clint.yaml          |   1 +
>  MAINTAINERS                                   |   6 +
>  arch/riscv/Kconfig.socs                       |   6 +
>  arch/riscv/boot/dts/Makefile                  |   1 +
>  arch/riscv/boot/dts/thead/Makefile            |   2 +
>  .../dts/thead/th1520-lichee-module-4a.dtsi    |  38 ++
>  .../boot/dts/thead/th1520-lichee-pi-4a.dts    |  32 ++
>  arch/riscv/boot/dts/thead/th1520.dtsi         | 451 ++++++++++++++++++
>  arch/riscv/configs/defconfig                  |   1 +
>  12 files changed, 637 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/thead,cpu-reset.yaml
>  create mode 100644 Documentation/devicetree/bindings/riscv/thead.yaml
>  create mode 100644 arch/riscv/boot/dts/thead/Makefile
>  create mode 100644 arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
>  create mode 100644 arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
>  create mode 100644 arch/riscv/boot/dts/thead/th1520.dtsi
> 
> -- 
> 2.40.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
