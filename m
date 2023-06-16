Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDAC733A47
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345683AbjFPUBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjFPUBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:01:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1221735A3;
        Fri, 16 Jun 2023 13:01:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B4F962E05;
        Fri, 16 Jun 2023 20:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E208FC433C0;
        Fri, 16 Jun 2023 20:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686945682;
        bh=NNR06pawYLcrluh/DT0ZjxTIOvEpuKGIsr6P52TLsXk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B2x9p0bw9e1c5FEiElfS0dqOB9kBN1XvLc3rdRIjWsCJR6DEA+8/fPzx0tD0XRds9
         xnUob2gqF2SwBz+B8m0N3hPtdbY9Zjp4OWtxr5mJ453zMkqDfQfhs3Bk0NKVLLnJ8T
         YRFinBI4ZyqxgEMzd4FvqZ96m1iAvyUW5PzZ9IkU7jzJf2O+Uh3mAZnkJkvCh4Irzi
         y8m2OdBztq5JFis9yBA+hEUTNF3tMD5RAOz5rdpO89Y54dunPa4NAr9k6faBzowxQk
         AVRlbo+pV0l2tH94RtPSD4Alk/lhusm0f9qKVWPhAsHRvmHc3DaWJj06DslGvi6t1A
         z4M//Xaki6glw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4f766777605so1569607e87.1;
        Fri, 16 Jun 2023 13:01:22 -0700 (PDT)
X-Gm-Message-State: AC+VfDyVb1J0jxb7ByxdQPFCoN6rG5PynZqV/6xLihGaBnsDfgruhCon
        IUH8GAu3x/TSlzsgzzJMcx1NcvAGKA32lec/Nr8=
X-Google-Smtp-Source: ACHHUZ5JqRMNnpRMFCyZiMjc+UWPs6A2cx1mTw/2r3SQw3woyTfRJjaUEkhnoXK7xbHKeHI/ilSSCGbka/vlr73Fo7g=
X-Received: by 2002:a05:6512:60a:b0:4f8:5635:2ccf with SMTP id
 b10-20020a056512060a00b004f856352ccfmr2048673lfe.8.1686945680955; Fri, 16 Jun
 2023 13:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230616085038.4121892-1-rppt@kernel.org> <20230616085038.4121892-7-rppt@kernel.org>
In-Reply-To: <20230616085038.4121892-7-rppt@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 16 Jun 2023 13:01:08 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4J+rFvh9WJVWLZxFHtcYxahYk=NoKYdU9FMibZU8986w@mail.gmail.com>
Message-ID: <CAPhsuW4J+rFvh9WJVWLZxFHtcYxahYk=NoKYdU9FMibZU8986w@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] mm/execmem: introduce execmem_data_alloc()
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

On Fri, Jun 16, 2023 at 1:51=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> Data related to code allocations, such as module data section, need to
> comply with architecture constraints for its placement and its
> allocation right now was done using execmem_text_alloc().
>
> Create a dedicated API for allocating data related to code allocations
> and allow architectures to define address ranges for data allocations.
>
> Since currently this is only relevant for powerpc variants that use the
> VMALLOC address space for module data allocations, automatically reuse
> address ranges defined for text unless address range for data is
> explicitly defined by an architecture.
>
> With separation of code and data allocations, data sections of the
> modules are now mapped as PAGE_KERNEL rather than PAGE_KERNEL_EXEC which
> was a default on many architectures.
>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
[...]
>  static void free_mod_mem(struct module *mod)
> diff --git a/mm/execmem.c b/mm/execmem.c
> index a67acd75ffef..f7bf496ad4c3 100644
> --- a/mm/execmem.c
> +++ b/mm/execmem.c
> @@ -63,6 +63,20 @@ void *execmem_text_alloc(size_t size)
>                              fallback_start, fallback_end, kasan);
>  }
>
> +void *execmem_data_alloc(size_t size)
> +{
> +       unsigned long start =3D execmem_params.modules.data.start;
> +       unsigned long end =3D execmem_params.modules.data.end;
> +       pgprot_t pgprot =3D execmem_params.modules.data.pgprot;
> +       unsigned int align =3D execmem_params.modules.data.alignment;
> +       unsigned long fallback_start =3D execmem_params.modules.data.fall=
back_start;
> +       unsigned long fallback_end =3D execmem_params.modules.data.fallba=
ck_end;
> +       bool kasan =3D execmem_params.modules.flags & EXECMEM_KASAN_SHADO=
W;
> +
> +       return execmem_alloc(size, start, end, align, pgprot,
> +                            fallback_start, fallback_end, kasan);
> +}
> +
>  void execmem_free(void *ptr)
>  {
>         /*
> @@ -101,6 +115,28 @@ static bool execmem_validate_params(struct execmem_p=
arams *p)
>         return true;
>  }
>
> +static void execmem_init_missing(struct execmem_params *p)

Shall we call this execmem_default_init_data?

> +{
> +       struct execmem_modules_range *m =3D &p->modules;
> +
> +       if (!pgprot_val(execmem_params.modules.data.pgprot))
> +               execmem_params.modules.data.pgprot =3D PAGE_KERNEL;

Do we really need to check each of these? IOW, can we do:

if (!pgprot_val(execmem_params.modules.data.pgprot)) {
       execmem_params.modules.data.pgprot =3D PAGE_KERNEL;
       execmem_params.modules.data.alignment =3D m->text.alignment;
       execmem_params.modules.data.start =3D m->text.start;
       execmem_params.modules.data.end =3D m->text.end;
       execmem_params.modules.data.fallback_start =3D m->text.fallback_star=
t;
      execmem_params.modules.data.fallback_end =3D m->text.fallback_end;
}

Thanks,
Song

[...]
