Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE97A637FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 20:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiKXTxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 14:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiKXTw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 14:52:58 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC1955CB3;
        Thu, 24 Nov 2022 11:52:56 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id r26so1664472edc.10;
        Thu, 24 Nov 2022 11:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jAnK/JcM0zX8dnekJkRYtzDHjOJKPhsEIM5kaa8Kd9c=;
        b=GPM0Bz9korDKFqBQzpL4ixnmJME93AytUynA75PXV46+NJpsKVKgdHFRwJY/hi4I5j
         q2LDSVMJkFIjQ/YbXki1homZM7jK7JN7wLky/f2CAy44cBaAAWE+whk2nSPls8Qg+FwR
         ivUzDz1nSUHkNs+rdmZT7nELEpuu1/JBresXwj7mHu0emOhDYltgJRjCXbkQcASDzH7i
         sA6Cg1g4ueX/ftcf+ihqwTa1ax2C1Rl6wfRefTrL/f7YeFPQqlFgM+6T91EuKZUj4wsv
         fmKzTIZ4hK/TBiK0PvFKq9cfBKtjTkAGGMEQdOq+0THY4d/xibfGWn6wGdQJBCe2GXAl
         yHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAnK/JcM0zX8dnekJkRYtzDHjOJKPhsEIM5kaa8Kd9c=;
        b=EYg4mmwdUywOSPzKhJlt5ptufrDeQiscoCGEvJ/cJqzzrAZOEWFkodGX1ch8QqTjZQ
         QmB2srzAcP3zPxovf0cZkMUkcNnocebkOQ8vr4lpFkeNmC4VlywntRYIwWMlnNiImmSL
         wOfP37m2PD6tC7VzKGTSSAurAwtAXyNb/V0kD9FXdvfe5wfYH3s54Gm4x9PpKAz0CIHr
         C/BEyVglmOsRESsryajE/DESPl/jbDNINOAIHfdWmUaZjrFvTges6TpiN8vikzw2c2/U
         OFAi+PBtxqHD653Y8JnYOovxTXtuCU3USU+Sd2cU4j3/XiEMAHGl659Ejtu9XLrDeBxD
         bwYQ==
X-Gm-Message-State: ANoB5pl/lYlh3NjVR83yvYcWomvxlnCfDeYSd7uGFK35NxMvgbEjlC1r
        ABqr1HFp8vI9XewSaKQMynU1rM4wKddf02cf+e8=
X-Google-Smtp-Source: AA0mqf70Jbpsi5I4U3QPDQQjjvPYf4fwg3Sz1ESxXsc4lqVqhb0WVZydaw41Um7cZvT+KB+Un2UBUhfGMQIjK8QLr40=
X-Received: by 2002:a05:6402:f:b0:468:56c3:7c8 with SMTP id
 d15-20020a056402000f00b0046856c307c8mr31976256edu.109.1669319574521; Thu, 24
 Nov 2022 11:52:54 -0800 (PST)
MIME-Version: 1.0
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <Y3/I4KzHnzyPo1Fe@spud>
In-Reply-To: <Y3/I4KzHnzyPo1Fe@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 24 Nov 2022 19:52:28 +0000
Message-ID: <CA+V-a8viAfvLnScDKADpKMRqNEaMdhf5kA1GqAdgaGAEo+XpBQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] AX45MP: Add support to non-coherent DMA
To:     Conor Dooley <conor@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

Thank you for the quick test.

On Thu, Nov 24, 2022 at 7:41 PM Conor Dooley <conor@kernel.org> wrote:
>
> Hey!
>
> On Thu, Nov 24, 2022 at 05:22:00PM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Hi All,
> >
> > On the Andes AX45MP core, cache coherency is a specification option so it
> > may not be supported. In this case DMA will fail. To get around with this
> > issue this patch series does the below:
> >
> > 1] Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
> > block that allows dynamic adjustment of memory attributes in the runtime.
> > It contains a configurable amount of PMA entries implemented as CSR
> > registers to control the attributes of memory locations in interest. PMA
> > regions are passed from the l2 node which are configured as
> > non-cacheable + bufferable with the SBI call.
> >
> >         l2cache: cache-controller@13400000 {
> >                 ....
> >                 andestech,pma-regions = <0x58000000 0x08000000
> >                                          (AX45MP_PMACFG_ETYP_NAPOT |
> >                                           AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF)>;
> >                 ....
> >         };
> >
> > 2] We provide callbacks to synchronize specific content between memory and
> > cache.
> >
> >         - arch_sync_dma_for_device()
> >         - arch_sync_dma_for_cpu()
> >
> > Below are the configs that are enabled:
> >
> >         - DMA_GLOBAL_POOL
> >         - RISCV_DMA_NONCOHERENT
> >
> > 3] We reserve the shared DMA pool, so the DMA memory requests go through
> >    this pool:
> >
> >         reserved-memory {
> >                 #address-cells = <2>;
> >                 #size-cells = <2>;
> >                 ranges;
> >
> >                 reserved: linux,cma@58000000 {
> >                         compatible = "shared-dma-pool";
> >                         no-map;
> >                         linux,dma-default;
> >                         reg = <0x0 0x58000000 0x0 0x08000000>;
> >                 };
> >         };
> >
> >
> > Below is the L2 cache DT node:
> >
> >         l2cache: cache-controller@13400000 {
> >                 compatible = "andestech,ax45mp-cache", "cache";
> >                 cache-size = <0x40000>;
> >                 cache-line-size = <64>;
> >                 cache-sets = <1024>;
> >                 cache-unified;
> >                 reg = <0x0 0x13400000 0x0 0x100000>;
> >                 andestech,pma-regions = <0x0 0x58000000 0x0 0x08000000 0x0
> >                                          (AX45MP_PMACFG_ETYP_NAPOT |
> >                                           AX45MP_PMACFG_MTYP_MEM_NON_CACHE_BUF)>;
> >                 interrupts = <SOC_PERIPHERAL_IRQ(476, IRQ_TYPE_LEVEL_HIGH)>;
> >         };
> >
> > Due to the above approach custom SBI calls have been implemented. The
> > above implementation is in preparation for adding support for Renesas
> > RZ/Five SoC which uses the AX45MP core. As with the above approach the
> > kernel image might not be generic so that it can be used on other
> > platforms.
> >
> > OpenSBI implementation isn't upstreamed yet, public repo for access is
> > available at [0].
> >
> > [0] https://github.com/renesas-rz/rz_opensbi/tree/work/OpenSBI-PMA
> >
> > Note,
> > - This series requires testing on Cores with zibcom and T-Head SoCs
> > - Ive used GCC 9.4.0 for compilation
>
> Just dumping the following, which I saw with gcc 12.1 & binutils 2.39
> while building allmodconfig. Perhaps it is worth you upgrading to a
> recent toolchain for testing purposes. FWIW, I applied your patches on
> top of 20221122.
>
> /stuff/linux/arch/riscv/mm/dma-noncoherent.c: Assembler messages:
> /stuff/linux/arch/riscv/mm/dma-noncoherent.c:62: Error: attempt to move .org backwards
> /stuff/linux/arch/riscv/mm/dma-noncoherent.c:66: Error: attempt to move .org backwards
> /stuff/linux/arch/riscv/mm/dma-noncoherent.c:84: Error: attempt to move .org backwards
> /stuff/linux/arch/riscv/mm/dma-noncoherent.c:96: Error: attempt to move .org backwards
>
Hmm that looks interesting! I'll give that a shot with the latest tool-chain.

BTW is there a link to get the latest toolchain?
>
> In file included from /stuff/linux/arch/riscv/errata/andes/errata.c:16:
> /stuff/linux/arch/riscv/errata/andes/errata.c: In function 'is_auipc_insn':
> /stuff/linux/arch/riscv/errata/andes/errata.c:25:34: error: 'MASK_AUIPC' undeclared (first use in this function)
>    25 | DECLARE_INSN(auipc, MATCH_AUIPC, MASK_AUIPC)
>       |                                  ^~~~~~~~~~
> /stuff/linux/arch/riscv/include/asm/parse_asm.h:175:25: note: in definition of macro 'DECLARE_INSN'
>   175 |         return (insn & (INSN_MASK)) == (INSN_MATCH); \
>       |                         ^~~~~~~~~
> /stuff/linux/arch/riscv/errata/andes/errata.c:25:34: note: each undeclared identifier is reported only once for each function it appears in
>    25 | DECLARE_INSN(auipc, MATCH_AUIPC, MASK_AUIPC)
>       |                                  ^~~~~~~~~~
> /stuff/linux/arch/riscv/include/asm/parse_asm.h:175:25: note: in definition of macro 'DECLARE_INSN'
>   175 |         return (insn & (INSN_MASK)) == (INSN_MATCH); \
>       |                         ^~~~~~~~~
> /stuff/linux/arch/riscv/errata/andes/errata.c:25:21: error: 'MATCH_AUIPC' undeclared (first use in this function); did you mean 'OPC_AUIPC'?
>    25 | DECLARE_INSN(auipc, MATCH_AUIPC, MASK_AUIPC)
>       |                     ^~~~~~~~~~~
> /stuff/linux/arch/riscv/include/asm/parse_asm.h:175:41: note: in definition of macro 'DECLARE_INSN'
>   175 |         return (insn & (INSN_MASK)) == (INSN_MATCH); \
>       |                                         ^~~~~~~~~~
> /stuff/linux/arch/riscv/errata/andes/errata.c: In function 'riscv_alternative_fix_auipc_jalr':
> /stuff/linux/arch/riscv/errata/andes/errata.c:64:23: error: implicit declaration of function 'EXTRACT_RD_REG' [-Werror=implicit-function-declaration]
>    64 |                 rd1 = EXTRACT_RD_REG(*(alt_ptr + i));
>       |                       ^~~~~~~~~~~~~~
> /stuff/linux/arch/riscv/errata/andes/errata.c:69:24: error: implicit declaration of function 'EXTRACT_UTYPE_IMM'; did you mean 'EXTRACT_BTYPE_IMM'? [-Werror=implicit-function-declaration]
>    69 |                 imm1 = EXTRACT_UTYPE_IMM(*(alt_ptr + i));
>       |                        ^~~~~~~~~~~~~~~~~
>       |                        EXTRACT_BTYPE_IMM
> /stuff/linux/arch/riscv/errata/andes/errata.c:78:30: error: 'U_IMM_31_12_MASK' undeclared (first use in this function); did you mean 'J_IMM_19_12_MASK'?
>    78 |                 call[0] &= ~(U_IMM_31_12_MASK);
>       |                              ^~~~~~~~~~~~~~~~
>       |                              J_IMM_19_12_MASK
> /stuff/linux/arch/riscv/errata/andes/errata.c: In function 'is_auipc_insn':
> /stuff/linux/arch/riscv/include/asm/parse_asm.h:176:1: error: control reaches end of non-void function [-Werror=return-type]
>   176 | }
>       | ^
> /stuff/linux/arch/riscv/errata/andes/errata.c:25:1: note: in expansion of macro 'DECLARE_INSN'
>    25 | DECLARE_INSN(auipc, MATCH_AUIPC, MASK_AUIPC)
>       | ^~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
>
Oops I missed to mention the dependency here we need patches from [0]
. Just patches 1-5 should be sufficient for this build (as including
patch 6/7 gave me a build issue).

[0] https://patchwork.kernel.org/project/linux-riscv/cover/20221110164924.529386-1-heiko@sntech.de/

Cheers,
Prabhakar
