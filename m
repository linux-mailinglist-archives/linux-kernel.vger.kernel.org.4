Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D4D612C38
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 19:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJ3SYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 14:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJ3SYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 14:24:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F02D26EF;
        Sun, 30 Oct 2022 11:24:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 878DD60F18;
        Sun, 30 Oct 2022 18:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8EBC433C1;
        Sun, 30 Oct 2022 18:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667154270;
        bh=mubS3YXKFLLh3bjwf9Uf7SYQ9nzXFnwDXmBw9ncTy4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b+IZVL+CzFtkqlZxUHuYZs8cFJDEI1jMf1BgDhyoz62TgPxdgvI6ZaQL1F1qg1RHT
         DtITbdfWYiTmmSCKF0/iJlsrBkT37MnGh2VBFiI39EsJV1K6b2Zi+3uUiEWztsBth3
         Hj1rFvGAtz/gUcZBF7kWGz9ryiea4gAl4Fkr2iPiKw07nCtXQTR1G50Wf/HAKTWR+5
         ybrVDSK5SKZju0AhEn5/GspjPdaPN+jUy5p8Yo3EqRtc6vdbw4r4Huwl4l1SD5ZNjj
         9T5AJxLHXgxBdUEUz1TidUyBuEDcgx87ZYl1VoBQsL6wyrl/iKPDxx3SYxm/0urDwT
         T84bhnSV+P4jQ==
Date:   Sun, 30 Oct 2022 18:24:24 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v5 0/7] Add support for Renesas RZ/Five SoC
Message-ID: <Y17BWPuEcmY7Bba3@spud>
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 05:59:14PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Hi All,
> 
> The RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP Single)
> 1.0 GHz, 16-bit DDR3L/DDR4 interface. And it also has many interfaces such
> as Gbit-Ether, CAN, and USB 2.0, making it ideal for applications such as
> entry-class social infrastructure gateway control and industrial gateway
> control.
> 
> This patch series adds initial SoC DTSi support for Renesas RZ/Five
> (R9A07G043) SoC. Below is the list of IP blocks enabled in the initial
> board DTS which can be used to boot via initramfs on RZ/Five SMARC EVK:
> - AX45MP CPU
> - CPG
> - PINCTRL

Hey,
Looks like you've got a pair of warnings here from dtbs_check. I tested
this on top of 20221028's next, with the three branches below merged in,
hopefully my merges aren't the source of them:

linux/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: pinctrl@11030000: 'interrupt-controller' is a required property
        From schema: Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
linux/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: pinctrl@11030000: '#interrupt-cells' is a required property
        From schema: linux/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml

With this sorted, whatever wasn't already is now:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Thanks for putting up with my messing around re: kconfig symbols and I
am glad that we ended up being able to share the dts across archs in the
end, so thanks to everyone involved in that :)

> - PLIC
> - SCIF0
> - SYSC
> 
> Useful links:
> -------------
> [0] https://www.renesas.com/us/en/products/microcontrollers-microprocessors/rz-mpus/rzfive-risc-v-general-purpose-microprocessors-risc-v-cpu-core-andes-ax45mp-single-10-ghz-2ch-gigabit-ethernet
> [1] http://www.andestech.com/en/products-solutions/andescore-processors/riscv-ax45mp/
> 
> Patch series depends on the below patches (which are queued in the Renesas tree for v6.2):
> ------------------------------------------------------------------------------------
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git/commit/?h=renesas-dt-bindings-for-v6.2&id=c27ce08b806d606cd5cd0e8252d1ed2b729b5b55
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git/commit/?h=renesas-dt-bindings-for-v6.2&id=7dd1d57c052e88f98b9e9145461b13bca019d108
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git/commit/?h=renesas-arm-soc-for-v6.2&id=b3acbca3c80e612478b354e43c1480c3fc15873e
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git/commit/?h=renesas-arm-dt-for-v6.2&id=49669da644cf000eb79dbede55bd04acf3f2f0a0
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git/commit/?h=renesas-arm-dt-for-v6.2&id=b9a0be2054964026aa58966ce9724b672f210835
> 
> v4 -> v5:
> ---------
> * Rebased patches on -next
> * Included RB tags
> * Dropped patches #1 and #4 (form v4) as they are queued up by Renesas trees
> * Patch #7 from v4 was not needed anymore so dropped it
> * Patches #4 and #5 are new
> 
> v4: https://lore.kernel.org/all/20220920184904.90495-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> v3: https://lore.kernel.org/lkml/20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> v2: https://lore.kernel.org/all/20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> v1: https://lore.kernel.org/lkml/20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> 
> Below are the logs from RZ/Five SMARC EVK:
> ------------------------------------------
> 
> / # uname -ra;
> Linux (none) 6.1.0-rc2-00036-gbad82a074f62 #145 SMP Fri Oct 28 17:18:41 BST 2022 riscv64 GNU/Linux
> / # cat /proc/cpuinfo;
> processor       : 0
> hart            : 0
> isa             : rv64imafdc
> mmu             : sv39
> uarch           : andestech,ax45mp
> mvendorid       : 0x31e
> marchid         : 0x8000000000008a45
> mimpid          : 0x500
> 
> / # for i in machine family soc_id revision; do echo -n "$i: ";cat /sys/devices/
> soc0/$i; done
> machine: Renesas SMARC EVK based on r9a07g043f01
> family: RZ/Five
> soc_id: r9a07g043
> revision: 0
> / #
> / # cat /proc/interrupts
>            CPU0
>   1:          0  SiFive PLIC 412 Level     1004b800.serial:rx err
>   2:         16  SiFive PLIC 414 Level     1004b800.serial:rx full
>   3:        402  SiFive PLIC 415 Level     1004b800.serial:tx empty
>   4:          0  SiFive PLIC 413 Level     1004b800.serial:break
>   5:      41826  RISC-V INTC   5 Edge      riscv-timer
>   6:         10  SiFive PLIC 416 Level     1004b800.serial:rx ready
> IPI0:         0  Rescheduling interrupts
> IPI1:         0  Function call interrupts
> IPI2:         0  CPU stop interrupts
> IPI3:         0  IRQ work interrupts
> IPI4:         0  Timer broadcast interrupts
> / #
> / # cat /proc/meminfo
> MemTotal:         882252 kB
> MemFree:          860848 kB
> MemAvailable:     858608 kB
> Buffers:               0 kB
> Cached:             1796 kB
> SwapCached:            0 kB
> Active:                0 kB
> Inactive:             72 kB
> Active(anon):          0 kB
> Inactive(anon):       72 kB
> Active(file):          0 kB
> Inactive(file):        0 kB
> Unevictable:        1796 kB
> Mlocked:               0 kB
> SwapTotal:             0 kB
> SwapFree:              0 kB
> Dirty:                 0 kB
> Writeback:             0 kB
> AnonPages:           108 kB
> Mapped:             1200 kB
> Shmem:                 0 kB
> KReclaimable:       6760 kB
> Slab:              12360 kB
> SReclaimable:       6760 kB
> SUnreclaim:         5600 kB
> KernelStack:         620 kB
> PageTables:           32 kB
> SecPageTables:         0 kB
> NFS_Unstable:          0 kB
> Bounce:                0 kB
> WritebackTmp:          0 kB
> CommitLimit:      441124 kB
> Committed_AS:        592 kB
> VmallocTotal:   67108864 kB
> VmallocUsed:        1132 kB
> VmallocChunk:          0 kB
> Percpu:               84 kB
> HugePages_Total:       0
> HugePages_Free:        0
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> Hugepagesize:       2048 kB
> Hugetlb:               0 kB
> / #
> / #
> 
> Cheers,
> Prabhakar
> 
> Lad Prabhakar (7):
>   dt-bindings: riscv: Sort the CPU core list alphabetically
>   dt-bindings: riscv: Add Andes AX45MP core to the list
>   riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option
>   riscv: dts: renesas: Add initial devicetree for Renesas RZ/Five SoC
>   riscv: dts: renesas: Add minimal DTS for Renesas RZ/Five SMARC EVK
>   MAINTAINERS: Add entry for Renesas RISC-V
>   riscv: configs: defconfig: Enable Renesas RZ/Five SoC
> 
>  .../devicetree/bindings/riscv/cpus.yaml       | 11 ++-
>  MAINTAINERS                                   |  3 +-
>  arch/riscv/Kconfig.socs                       |  5 +
>  arch/riscv/boot/dts/Makefile                  |  1 +
>  arch/riscv/boot/dts/renesas/Makefile          |  2 +
>  arch/riscv/boot/dts/renesas/r9a07g043f.dtsi   | 57 ++++++++++++
>  .../boot/dts/renesas/r9a07g043f01-smarc.dts   | 27 ++++++
>  .../boot/dts/renesas/rzfive-smarc-som.dtsi    | 58 ++++++++++++
>  arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi | 91 +++++++++++++++++++
>  arch/riscv/configs/defconfig                  |  3 +
>  10 files changed, 252 insertions(+), 6 deletions(-)
>  create mode 100644 arch/riscv/boot/dts/renesas/Makefile
>  create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
>  create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dts
>  create mode 100644 arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
>  create mode 100644 arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
> 
> -- 
> 2.25.1
> 
