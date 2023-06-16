Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A95F733A81
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345570AbjFPUKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjFPUKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:10:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B76430DD;
        Fri, 16 Jun 2023 13:10:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D54CE61A33;
        Fri, 16 Jun 2023 20:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48066C433D9;
        Fri, 16 Jun 2023 20:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686946199;
        bh=WUwJ/CcnS7KQMIGc+n1lO6t7DBapdJHs3PtzN2L5DOs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TK7lwF2dgyhLjZz3axawLmkbuign1yOCHmc3Tx1v0nJMLzHE4AMIBuiBwMBtxulD8
         Z3Vut6IBWtk2ssQ8ijhfs8vBi+Qy0HXySzPTA15IW8YrnEaB7IlHu2VlzDPnGeCZmI
         K6M5pS/g15siuIekZ5t1I3/fk6k5aKAJaEj6SrOz/PCsDCt5E2f7BsT9bm6PGwrWgg
         43Q6XfEEqBYd9YLn7kuhpOmt+nKESiRp8navYHM6l1x9CJMp/jkfUZ7Re+m79aLMHD
         kbDq8gJyNG5Gays0CHzsM1Js8nifxRWQM5ErJCnC9FUIgd0MSE3JJ4Wb0UcNmLCkft
         Ujy1yQtMOaDZQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4f762b3227dso1482607e87.1;
        Fri, 16 Jun 2023 13:09:59 -0700 (PDT)
X-Gm-Message-State: AC+VfDxnGmwARsmvlN+BebDLZcp92GaeS8oe6MzbebP6N92K1Svg8lL5
        QIX8BTHOVcMGoqeGC6KLFpf3otMVMH3+9o+2Vew=
X-Google-Smtp-Source: ACHHUZ7ituqSYIn1SCVORmrSh+1n8O6ydQ9eZHh9b53aIx4zqNf09sKQF/S2prJ95SKqvJfHTGetd9Upy9eJLOlNi04=
X-Received: by 2002:a05:6512:3052:b0:4f7:47bb:2ce0 with SMTP id
 b18-20020a056512305200b004f747bb2ce0mr3066562lfb.4.1686946197316; Fri, 16 Jun
 2023 13:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230616085038.4121892-1-rppt@kernel.org> <20230616085038.4121892-10-rppt@kernel.org>
In-Reply-To: <20230616085038.4121892-10-rppt@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 16 Jun 2023 13:09:45 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6TmwsBmP4NQroE5OEFsaHh+S9zweXa4Fs_ZeJURguqAg@mail.gmail.com>
Message-ID: <CAPhsuW6TmwsBmP4NQroE5OEFsaHh+S9zweXa4Fs_ZeJURguqAg@mail.gmail.com>
Subject: Re: [PATCH v2 09/12] powerpc: extend execmem_params for kprobes allocations
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
> powerpc overrides kprobes::alloc_insn_page() to remove writable
> permissions when STRICT_MODULE_RWX is on.
>
> Add definition of jit area to execmem_params to allow using the generic
> kprobes::alloc_insn_page() with the desired permissions.
>
> As powerpc uses breakpoint instructions to inject kprobes, it does not
> need to constrain kprobe allocations to the modules area and can use the
> entire vmalloc address space.
>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Acked-by: Song Liu <song@kernel.org>


> ---
>  arch/powerpc/kernel/kprobes.c | 14 --------------
>  arch/powerpc/kernel/module.c  | 13 +++++++++++++
>  2 files changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.=
c
> index 5db8df5e3657..14c5ddec3056 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -126,20 +126,6 @@ kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned lo=
ng addr, unsigned long offse
>         return (kprobe_opcode_t *)(addr + offset);
>  }
>
> -void *alloc_insn_page(void)
> -{
> -       void *page;
> -
> -       page =3D jit_text_alloc(PAGE_SIZE);
> -       if (!page)
> -               return NULL;
> -
> -       if (strict_module_rwx_enabled())
> -               set_memory_rox((unsigned long)page, 1);
> -
> -       return page;
> -}
> -
>  int arch_prepare_kprobe(struct kprobe *p)
>  {
>         int ret =3D 0;
> diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
> index 4c6c15bf3947..8e5b379d6da1 100644
> --- a/arch/powerpc/kernel/module.c
> +++ b/arch/powerpc/kernel/module.c
> @@ -96,6 +96,11 @@ static struct execmem_params execmem_params =3D {
>                         .alignment =3D 1,
>                 },
>         },
> +       .jit =3D {
> +               .text =3D {
> +                       .alignment =3D 1,
> +               },
> +       },
>  };
>
>
> @@ -131,5 +136,13 @@ struct execmem_params __init *execmem_arch_params(vo=
id)
>
>         execmem_params.modules.text.pgprot =3D prot;
>
> +       execmem_params.jit.text.start =3D VMALLOC_START;
> +       execmem_params.jit.text.end =3D VMALLOC_END;
> +
> +       if (strict_module_rwx_enabled())
> +               execmem_params.jit.text.pgprot =3D PAGE_KERNEL_ROX;
> +       else
> +               execmem_params.jit.text.pgprot =3D PAGE_KERNEL_EXEC;
> +
>         return &execmem_params;
>  }
> --
> 2.35.1
>
