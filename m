Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42113733A63
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245126AbjFPUFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjFPUFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:05:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE4C1FF9;
        Fri, 16 Jun 2023 13:05:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52207632AC;
        Fri, 16 Jun 2023 20:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A6EC433CB;
        Fri, 16 Jun 2023 20:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686945943;
        bh=WtL681uu0xgDuNDCtnoYcQSLjySma9uSe62fWHoJUhA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f6jdPi0vbCVqLqgQDDmD+GO6OBfmTAAnNSnv31ejf0X579gkscpmfn1bTrsu+q2ra
         40XK5tgjD4Pn3DEwgEMNXaNpAJoNV7jL4P4r8shZe9dBhyksUMC8rwkwFkvZkFVkCR
         IGp3JmtLPxLnrzx47G+lStd1hKB4UgLYKewi3Ki/K5woVsZktBsRAZ2Di1MUFiXRWn
         1YkJryPbn+hll4loxeYSz5PcOp11n7V/droF7ZpB0pqIuzSutJSGr0pq7VRjU9BgpD
         r54x5CfpgaRK4fVGltSX9D3VAd0D4uJxrcV171/lcN7V+Y7pDOa0WYzp0o27UZTPXi
         Y80FFy3waZkgA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4f6370ddd27so1591514e87.0;
        Fri, 16 Jun 2023 13:05:43 -0700 (PDT)
X-Gm-Message-State: AC+VfDxll20kBKAOmJdD0scrWKrC23RJCkpcNBQmT+5Y0lM5YvEt4xiF
        Yi07xqmhGlL0o1XKTyDs8ix+PLGFK2YzBE+q8Dw=
X-Google-Smtp-Source: ACHHUZ7v0OG7lj710Dpkky2x3Qwl+xOOMZ2WmKSKGrGJ24Aq4/yPm9YniFAuyGWs2DWPlG6NvD65kdAaVeIKyOd6PQ8=
X-Received: by 2002:a19:644e:0:b0:4e9:9e45:3470 with SMTP id
 b14-20020a19644e000000b004e99e453470mr2381818lfj.3.1686945941704; Fri, 16 Jun
 2023 13:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230616085038.4121892-1-rppt@kernel.org> <20230616085038.4121892-8-rppt@kernel.org>
In-Reply-To: <20230616085038.4121892-8-rppt@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 16 Jun 2023 13:05:29 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6BG2oVrGDOpCKyOEvU9fBOboYYhducv96KUBe276Mvng@mail.gmail.com>
Message-ID: <CAPhsuW6BG2oVrGDOpCKyOEvU9fBOboYYhducv96KUBe276Mvng@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] arm64, execmem: extend execmem_params for
 generated code definitions
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
> The memory allocations for kprobes on arm64 can be placed anywhere in
> vmalloc address space and currently this is implemented with an override
> of alloc_insn_page() in arm64.
>
> Extend execmem_params with a range for generated code allocations and
> make kprobes on arm64 use this extension rather than override
> alloc_insn_page().
>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>  arch/arm64/kernel/module.c         |  9 +++++++++
>  arch/arm64/kernel/probes/kprobes.c |  7 -------
>  include/linux/execmem.h            | 11 +++++++++++
>  mm/execmem.c                       | 14 +++++++++++++-
>  4 files changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> index c3d999f3a3dd..52b09626bc0f 100644
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -30,6 +30,13 @@ static struct execmem_params execmem_params =3D {
>                         .alignment =3D MODULE_ALIGN,
>                 },
>         },
> +       .jit =3D {
> +               .text =3D {
> +                       .start =3D VMALLOC_START,
> +                       .end =3D VMALLOC_END,
> +                       .alignment =3D 1,
> +               },
> +       },
>  };

This is growing fast. :) We have 3 now: text, data, jit. And it will be
5 when we split data into rw data, ro data, ro after init data. I wonder
whether we should still do some type enum here. But we can revisit
this topic later.

Other than that

Acked-by: Song Liu <song@kernel.org>
