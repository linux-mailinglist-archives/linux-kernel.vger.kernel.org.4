Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4D4637FC1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 20:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiKXTla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 14:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKXTl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 14:41:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929477F5A1;
        Thu, 24 Nov 2022 11:41:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B3316211D;
        Thu, 24 Nov 2022 19:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109F2C433C1;
        Thu, 24 Nov 2022 19:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669318887;
        bh=8nMprFxd6bPUC6N+QF2IIgflbHnknGxL158ItvZo3pk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iptiuqYP+LEKiq/VT2TTo5T2Vnd2t3FxQPKVUlVQLG+ln6niIoifIIcShoKDMcNZV
         L/6OEOLhr96XhdUIlHhHuHl95DY7qNvRozghc05b+JYj0b4rrVdnkv+RsSkAnrMl4+
         mcKz1IfMkZISdt/jD9zf2iaupOLBK+RmtcQX5fcRY0AtGFN8DLmtq39m0KoC1+SIHi
         w+wo6jfHAprNdgP9sM0k+oekYYYIZVLkXd8Aw0ziVDD+uzvQs4n7reStN5FC8ESgUq
         VnouIoDEeHMn+NSeTqXOYfXGVs7g0l6WQEWNnaK9xW/YFCeF+we47GMl/XvNozpjs7
         jgcW6Ryszz5mw==
Date:   Thu, 24 Nov 2022 19:41:20 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 0/7] AX45MP: Add support to non-coherent DMA
Message-ID: <Y3/I4KzHnzyPo1Fe@spud>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey!

On Thu, Nov 24, 2022 at 05:22:00PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Hi All,
> 
> On the Andes AX45MP core, cache coherency is a specification option so it
> may not be supported. In this case DMA will fail. To get around with this
> issue this patch series does the below:
> 
> 1] Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
> block that allows dynamic adjustment of memory attributes in the runtime.
> It contains a configurable amount of PMA entries implemented as CSR
> registers to control the attributes of memory locations in interest. PMA
> regions are passed from the l2 node which are configured as
> non-cacheable + bufferable with the SBI call.
> 
>         l2cache: cache-controller@13400000 {
>                 ....
>                 andestech,pma-regions = <0x58000000 0x08000000
>                                          (AX45MP_PMACFG_ETYP_NAPOT |
>                                           AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF)>;
>                 ....
>         };
> 
> 2] We provide callbacks to synchronize specific content between memory and
> cache.
> 
>         - arch_sync_dma_for_device()
>         - arch_sync_dma_for_cpu()
> 
> Below are the configs that are enabled:
> 
>         - DMA_GLOBAL_POOL
>         - RISCV_DMA_NONCOHERENT
> 
> 3] We reserve the shared DMA pool, so the DMA memory requests go through
>    this pool:
> 
>         reserved-memory {
>                 #address-cells = <2>;
>                 #size-cells = <2>;
>                 ranges;
> 
>                 reserved: linux,cma@58000000 {
>                         compatible = "shared-dma-pool";
>                         no-map;
>                         linux,dma-default;
>                         reg = <0x0 0x58000000 0x0 0x08000000>;
>                 };
>         };
> 
> 
> Below is the L2 cache DT node:
> 
>         l2cache: cache-controller@13400000 {
>                 compatible = "andestech,ax45mp-cache", "cache";
>                 cache-size = <0x40000>;
>                 cache-line-size = <64>;
>                 cache-sets = <1024>;
>                 cache-unified;
>                 reg = <0x0 0x13400000 0x0 0x100000>;
>                 andestech,pma-regions = <0x0 0x58000000 0x0 0x08000000 0x0
>                                          (AX45MP_PMACFG_ETYP_NAPOT |
>                                           AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF)>;
>                 interrupts = <SOC_PERIPHERAL_IRQ(476, IRQ_TYPE_LEVEL_HIGH)>;
>         };
> 
> Due to the above approach custom SBI calls have been implemented. The
> above implementation is in preparation for adding support for Renesas
> RZ/Five SoC which uses the AX45MP core. As with the above approach the
> kernel image might not be generic so that it can be used on other
> platforms.
> 
> OpenSBI implementation isn't upstreamed yet, public repo for access is
> available at [0].
> 
> [0] https://github.com/renesas-rz/rz_opensbi/tree/work/OpenSBI-PMA
> 
> Note,
> - This series requires testing on Cores with zibcom and T-Head SoCs
> - Ive used GCC 9.4.0 for compilation

Just dumping the following, which I saw with gcc 12.1 & binutils 2.39
while building allmodconfig. Perhaps it is worth you upgrading to a
recent toolchain for testing purposes. FWIW, I applied your patches on
top of 20221122.

/stuff/linux/arch/riscv/mm/dma-noncoherent.c: Assembler messages:
/stuff/linux/arch/riscv/mm/dma-noncoherent.c:62: Error: attempt to move .org backwards
/stuff/linux/arch/riscv/mm/dma-noncoherent.c:66: Error: attempt to move .org backwards
/stuff/linux/arch/riscv/mm/dma-noncoherent.c:84: Error: attempt to move .org backwards
/stuff/linux/arch/riscv/mm/dma-noncoherent.c:96: Error: attempt to move .org backwards


In file included from /stuff/linux/arch/riscv/errata/andes/errata.c:16:
/stuff/linux/arch/riscv/errata/andes/errata.c: In function 'is_auipc_insn':
/stuff/linux/arch/riscv/errata/andes/errata.c:25:34: error: 'MASK_AUIPC' undeclared (first use in this function)
   25 | DECLARE_INSN(auipc, MATCH_AUIPC, MASK_AUIPC)
      |                                  ^~~~~~~~~~
/stuff/linux/arch/riscv/include/asm/parse_asm.h:175:25: note: in definition of macro 'DECLARE_INSN'
  175 |         return (insn & (INSN_MASK)) == (INSN_MATCH); \
      |                         ^~~~~~~~~
/stuff/linux/arch/riscv/errata/andes/errata.c:25:34: note: each undeclared identifier is reported only once for each function it appears in
   25 | DECLARE_INSN(auipc, MATCH_AUIPC, MASK_AUIPC)
      |                                  ^~~~~~~~~~
/stuff/linux/arch/riscv/include/asm/parse_asm.h:175:25: note: in definition of macro 'DECLARE_INSN'
  175 |         return (insn & (INSN_MASK)) == (INSN_MATCH); \
      |                         ^~~~~~~~~
/stuff/linux/arch/riscv/errata/andes/errata.c:25:21: error: 'MATCH_AUIPC' undeclared (first use in this function); did you mean 'OPC_AUIPC'?
   25 | DECLARE_INSN(auipc, MATCH_AUIPC, MASK_AUIPC)
      |                     ^~~~~~~~~~~
/stuff/linux/arch/riscv/include/asm/parse_asm.h:175:41: note: in definition of macro 'DECLARE_INSN'
  175 |         return (insn & (INSN_MASK)) == (INSN_MATCH); \
      |                                         ^~~~~~~~~~
/stuff/linux/arch/riscv/errata/andes/errata.c: In function 'riscv_alternative_fix_auipc_jalr':
/stuff/linux/arch/riscv/errata/andes/errata.c:64:23: error: implicit declaration of function 'EXTRACT_RD_REG' [-Werror=implicit-function-declaration]
   64 |                 rd1 = EXTRACT_RD_REG(*(alt_ptr + i));
      |                       ^~~~~~~~~~~~~~
/stuff/linux/arch/riscv/errata/andes/errata.c:69:24: error: implicit declaration of function 'EXTRACT_UTYPE_IMM'; did you mean 'EXTRACT_BTYPE_IMM'? [-Werror=implicit-function-declaration]
   69 |                 imm1 = EXTRACT_UTYPE_IMM(*(alt_ptr + i));
      |                        ^~~~~~~~~~~~~~~~~
      |                        EXTRACT_BTYPE_IMM
/stuff/linux/arch/riscv/errata/andes/errata.c:78:30: error: 'U_IMM_31_12_MASK' undeclared (first use in this function); did you mean 'J_IMM_19_12_MASK'?
   78 |                 call[0] &= ~(U_IMM_31_12_MASK);
      |                              ^~~~~~~~~~~~~~~~
      |                              J_IMM_19_12_MASK
/stuff/linux/arch/riscv/errata/andes/errata.c: In function 'is_auipc_insn':
/stuff/linux/arch/riscv/include/asm/parse_asm.h:176:1: error: control reaches end of non-void function [-Werror=return-type]
  176 | }
      | ^
/stuff/linux/arch/riscv/errata/andes/errata.c:25:1: note: in expansion of macro 'DECLARE_INSN'
   25 | DECLARE_INSN(auipc, MATCH_AUIPC, MASK_AUIPC)
      | ^~~~~~~~~~~~
cc1: all warnings being treated as errors


> - Tested all the IP blocks on RZ/Five which use DMA
> 
> RFC v3 -> v4
> * Implemented ALTERNATIVE_3() macro 
> * Now using runtime patching mechanism instead of compile time config
> * Added Andes CMO as and errata
> * Fixed comments pointed by Geert
> 
> RFC v2-> RFC v3
> * Fixed review comments pointed by Conor
> * Move DT binding into cache folder
> * Fixed DT binding check issue
> * Added andestech,ax45mp-cache.h header file
> * Now passing the flags for the PMA setup as part of andestech,pma-regions
>   property.
> * Added andestech,inst/data-prefetch and andestech,tag/data-ram-ctl
>   properties to configure the L2 cache.
> * Registered the cache driver as platform driver
> 
> RFC v1-> RFC v2
> * Moved out the code from arc/riscv to drivers/soc/renesas
> * Now handling the PMA setup as part of the L2 cache
> * Now making use of dma-noncoherent.c instead SoC specific implementation.
> * Dropped arch_dma_alloc() and arch_dma_free()
> * Switched to RISCV_DMA_NONCOHERENT
> * Included DT binding doc
> 
> RFC v2: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20221003223222.448551-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> RFC v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20220906102154.32526-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> 
> Cheers,
> Prabhakar
> 
> Lad Prabhakar (7):
>   riscv: asm: alternative-macros: Introduce ALTERNATIVE_3() macro
>   riscv: asm: vendorid_list: Add Andes Technology to the vendors list
>   riscv: errata: Add Andes alternative ports
>   riscv: errata: andes: Fix auipc-jalr addresses in patched alternatives
>   riscv: mm: dma-noncoherent: Pass direction and operation to
>     ALT_CMO_OP()
>   dt-bindings: cache: r9a07g043f-l2-cache: Add DT binding documentation
>     for L2 cache controller
>   soc: renesas: Add L2 cache management for RZ/Five SoC
> 
>  .../cache/andestech,ax45mp-cache.yaml         |  93 ++++
>  arch/riscv/Kconfig.erratas                    |  22 +
>  arch/riscv/errata/Makefile                    |   1 +
>  arch/riscv/errata/andes/Makefile              |   1 +
>  arch/riscv/errata/andes/errata.c              | 139 ++++++
>  arch/riscv/include/asm/alternative-macros.h   |  94 ++++
>  arch/riscv/include/asm/alternative.h          |   3 +
>  arch/riscv/include/asm/cacheflush.h           |  12 +
>  arch/riscv/include/asm/errata_list.h          |  45 +-
>  arch/riscv/include/asm/vendorid_list.h        |   1 +
>  arch/riscv/kernel/alternative.c               |   5 +
>  arch/riscv/mm/dma-noncoherent.c               |  15 +-
>  drivers/soc/renesas/Kconfig                   |   7 +
>  drivers/soc/renesas/Makefile                  |   2 +
>  drivers/soc/renesas/rzfive/Kconfig            |   6 +
>  drivers/soc/renesas/rzfive/Makefile           |   3 +
>  drivers/soc/renesas/rzfive/ax45mp_cache.c     | 415 ++++++++++++++++++
>  drivers/soc/renesas/rzfive/ax45mp_sbi.h       |  29 ++
>  .../cache/andestech,ax45mp-cache.h            |  38 ++
>  19 files changed, 918 insertions(+), 13 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
>  create mode 100644 arch/riscv/errata/andes/Makefile
>  create mode 100644 arch/riscv/errata/andes/errata.c
>  create mode 100644 drivers/soc/renesas/rzfive/Kconfig
>  create mode 100644 drivers/soc/renesas/rzfive/Makefile
>  create mode 100644 drivers/soc/renesas/rzfive/ax45mp_cache.c
>  create mode 100644 drivers/soc/renesas/rzfive/ax45mp_sbi.h
>  create mode 100644 include/dt-bindings/cache/andestech,ax45mp-cache.h
> 
> -- 
> 2.25.1
> 
