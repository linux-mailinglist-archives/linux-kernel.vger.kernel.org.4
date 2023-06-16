Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CC1733A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345032AbjFPUJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345234AbjFPUJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:09:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D8A35B5;
        Fri, 16 Jun 2023 13:09:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0302D63C70;
        Fri, 16 Jun 2023 20:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D096C433BA;
        Fri, 16 Jun 2023 20:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686946156;
        bh=OgYjmmyzs2EjPHttaKLNX98CAQTU+jc+5TBMU4O7+WI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LxCbm5cDIUCYF8vZ7/LSzW/JsLhlLxX2d0fFu2V1HgTidoI9d4L/VcB0ImMydV0Ee
         8YO3x9rZwXIg0Q8DSxAacAiTV2XZF+Tx6U090kqCtI27PsdZZcqcz9z/jPPmjP/BO+
         +hkLjrbWsn0v25jP1pDPME4x+2gpLpEY35EjhkIKvEuKe2/3rsozkAcXaNwJmCkb+A
         X7bmvsPi5j2j5SwoGSlbvPVi8ziT05b2vTUayZaz5G8lhTX7m8dLb1/JKFPYnoJ/IR
         mFM5oymVsHdTAn2VYpKaZ+WPpolrWfQDdRU+ChUXiqnpZHojozka+L/klHYc/ncUUT
         POOaZ9hxvTPSA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2b3424edd5fso15872881fa.0;
        Fri, 16 Jun 2023 13:09:16 -0700 (PDT)
X-Gm-Message-State: AC+VfDyF4Zvda2M8Pn79JSqgrXiJjRN2VoNxVXC8Ekx+miMzPDceHeeA
        inQua/f64lAZiCEeM7Qsjh3b1h/Ny57YQWjBVUQ=
X-Google-Smtp-Source: ACHHUZ5jllDYgbNtI+72IVu/75j7amNBljuYpY3fpVnJlR5XF3n+gM7EWdkroNHXMw4vgK3ry1o4z8o6D6rXoRQsv1A=
X-Received: by 2002:a2e:b705:0:b0:2b4:4a0b:8fad with SMTP id
 j5-20020a2eb705000000b002b44a0b8fadmr2685993ljo.29.1686946154254; Fri, 16 Jun
 2023 13:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230616085038.4121892-1-rppt@kernel.org> <20230616085038.4121892-9-rppt@kernel.org>
In-Reply-To: <20230616085038.4121892-9-rppt@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 16 Jun 2023 13:09:02 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4xrU5vfpwOmP6KC2jzVaovjO_-zo+07YvJL3r9masQ2Q@mail.gmail.com>
Message-ID: <CAPhsuW4xrU5vfpwOmP6KC2jzVaovjO_-zo+07YvJL3r9masQ2Q@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] riscv: extend execmem_params for kprobes allocations
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nadav Amit <nadav.amit@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 1:52=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> RISC-V overrides kprobes::alloc_insn_range() to use the entire vmalloc ar=
ea
> rather than limit the allocations to the modules area.
>
> Slightly reorder execmem_params initialization to support both 32 and 64
> bit variantsi and add definition of jit area to execmem_params to support
> generic kprobes::alloc_insn_page().
>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Acked-by: Song Liu <song@kernel.org>


> ---
>  arch/riscv/kernel/module.c         | 16 +++++++++++++++-
>  arch/riscv/kernel/probes/kprobes.c | 10 ----------
>  2 files changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index ee5e04cd3f21..cca6ed4e9340 100644
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -436,7 +436,7 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char =
*strtab,
>         return 0;
>  }
>
> -#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
> +#ifdef CONFIG_MMU
>  static struct execmem_params execmem_params =3D {
>         .modules =3D {
>                 .text =3D {
> @@ -444,12 +444,26 @@ static struct execmem_params execmem_params =3D {
>                         .alignment =3D 1,
>                 },
>         },
> +       .jit =3D {
> +               .text =3D {
> +                       .pgprot =3D PAGE_KERNEL_READ_EXEC,
> +                       .alignment =3D 1,
> +               },
> +       },
>  };
>
>  struct execmem_params __init *execmem_arch_params(void)
>  {
> +#ifdef CONFIG_64BIT
>         execmem_params.modules.text.start =3D MODULES_VADDR;
>         execmem_params.modules.text.end =3D MODULES_END;
> +#else
> +       execmem_params.modules.text.start =3D VMALLOC_START;
> +       execmem_params.modules.text.end =3D VMALLOC_END;
> +#endif
> +
> +       execmem_params.jit.text.start =3D VMALLOC_START;
> +       execmem_params.jit.text.end =3D VMALLOC_END;
>
>         return &execmem_params;
>  }
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probe=
s/kprobes.c
> index 2f08c14a933d..e64f2f3064eb 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -104,16 +104,6 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>         return 0;
>  }
>
> -#ifdef CONFIG_MMU
> -void *alloc_insn_page(void)
> -{
> -       return  __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC=
_END,
> -                                    GFP_KERNEL, PAGE_KERNEL_READ_EXEC,
> -                                    VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
> -                                    __builtin_return_address(0));
> -}
> -#endif
> -
>  /* install breakpoint in text */
>  void __kprobes arch_arm_kprobe(struct kprobe *p)
>  {
> --
> 2.35.1
>
