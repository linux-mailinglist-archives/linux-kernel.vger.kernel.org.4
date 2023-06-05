Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D427230C8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 22:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjFEUN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 16:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjFEUNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:13:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A12598
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 13:13:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB91D616BC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 20:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E22C4339C;
        Mon,  5 Jun 2023 20:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685996001;
        bh=wsesdIXW5U8cDdaH6pBreit5xfy7gn52L+hBIFI8HFs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G9UoakwZCWRNcCc27Fv/xoJ+ba+Ws7XgP1kQ0nTLqDfUiKQuC81lSlEyDptwU+0f6
         j7sYfuRu3xtdqprNWYXUYdeHI/SjM/JeoHISQ7JRDac2SmZdt5zTccAAbHX+nqT9jR
         w7FjtSWGRbaqU0GjMVDSExYEM5pYr0XnVyJ2NnQEZPdOLStUb4L9AMApuua+9Jwxn4
         yP8tr57GuRgNgIB6n+0uI3wtasSzfGh7+bMttqYO9eHFfKn6y0rO6Y+GWxDcCubEOd
         X5c809uajKQNeZrejXxM644pE0EpuFS8CF8AGAFLgEiDIYEIbBzSa41enLnEzRpq4k
         xD9lnawDGyywQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b1a46ad09fso63001481fa.2;
        Mon, 05 Jun 2023 13:13:21 -0700 (PDT)
X-Gm-Message-State: AC+VfDx3L+OpNZE09147UWiHldm1sKSxXFnyZbM7QcCDBGvTUCaobczG
        X0MH1gato/Izh+I4wFU/2s/8sF9ypaRRb+d95ts=
X-Google-Smtp-Source: ACHHUZ7lWUKjuYygSYuJbIDXve4K0BnxCccF/BtDkJwgzb45y8mF0GjFCSpZLeXv5sHl7xhooP1YKfTbrOeeSo7tW3A=
X-Received: by 2002:a2e:9cd8:0:b0:2ac:8992:272d with SMTP id
 g24-20020a2e9cd8000000b002ac8992272dmr189171ljj.11.1685995999275; Mon, 05 Jun
 2023 13:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230605074024.1055863-1-puranjay12@gmail.com>
 <20230605074024.1055863-4-puranjay12@gmail.com> <CAPhsuW4JVUUzMfNQwTE_uzp3bnO3EAYDikU1Nyx6x-6ROFDNOA@mail.gmail.com>
 <CANk7y0jrPPW6GqPFi4SOTzgHyVPG_KY2tcrm=S0cG8P9=w0m1A@mail.gmail.com>
In-Reply-To: <CANk7y0jrPPW6GqPFi4SOTzgHyVPG_KY2tcrm=S0cG8P9=w0m1A@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 5 Jun 2023 13:13:06 -0700
X-Gmail-Original-Message-ID: <CAPhsuW79OdJigXU+6D8c=dKRWWeatF8+140CP-AV5xDsn2wpCg@mail.gmail.com>
Message-ID: <CAPhsuW79OdJigXU+6D8c=dKRWWeatF8+140CP-AV5xDsn2wpCg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf, arm64: use bpf_jit_binary_pack_alloc
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, catalin.marinas@arm.com,
        mark.rutland@arm.com, bpf@vger.kernel.org, kpsingh@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Mon, Jun 5, 2023 at 11:34=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> Hi,
>
> On Mon, Jun 5, 2023 at 7:05=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > On Mon, Jun 5, 2023 at 12:40=E2=80=AFAM Puranjay Mohan <puranjay12@gmai=
l.com> wrote:
> > >
> > > Use bpf_jit_binary_pack_alloc for memory management of JIT binaries i=
n
> > > ARM64 BPF JIT. The bpf_jit_binary_pack_alloc creates a pair of RW and=
 RX
> > > buffers. The JIT writes the program into the RW buffer. When the JIT =
is
> > > done, the program is copied to the final ROX buffer
> > > with bpf_jit_binary_pack_finalize.
> > >
> > > Implement bpf_arch_text_copy() and bpf_arch_text_invalidate() for ARM=
64
> > > JIT as these functions are required by bpf_jit_binary_pack allocator.
> > >
> > > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > > ---
> > >  arch/arm64/net/bpf_jit_comp.c | 119 +++++++++++++++++++++++++++++---=
--
> > >  1 file changed, 102 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_c=
omp.c
> > > index 145b540ec34f..ee9414cadea8 100644
> > > --- a/arch/arm64/net/bpf_jit_comp.c
> > > +++ b/arch/arm64/net/bpf_jit_comp.c
> > > @@ -76,6 +76,7 @@ struct jit_ctx {
> > >         int *offset;
> > >         int exentry_idx;
> > >         __le32 *image;
> > > +       __le32 *ro_image;
> >
> > We are using:
> > image vs. ro_image
> > rw_header vs. header
> > rw_image_ptr vs. image_ptr
>
> Will use "rw_image" and "image" in the next version.
>
> >
> > Shall we be more consistent with rw_ or ro_ prefix?
> >
> > >         u32 stack_size;
> > >         int fpb_offset;
> > >  };
> > > @@ -205,6 +206,20 @@ static void jit_fill_hole(void *area, unsigned i=
nt size)
> > >                 *ptr++ =3D cpu_to_le32(AARCH64_BREAK_FAULT);
> > >  }
> > >
> > > +int bpf_arch_text_invalidate(void *dst, size_t len)
> > > +{
> > > +       __le32 *ptr;
> > > +       int ret;
> > > +
> > > +       for (ptr =3D dst; len >=3D sizeof(u32); len -=3D sizeof(u32))=
 {
> > > +               ret =3D aarch64_insn_patch_text_nosync(ptr++, AARCH64=
_BREAK_FAULT);
> >
> > I think one aarch64_insn_patch_text_nosync() per 4 byte is too much ove=
rhead.
> > Shall we add a helper to do this in bigger patches?
>
> What would be the most efficient way to build this helper? As arm64 doesn=
't
> have the __text_poke() API. Calling copy_to_kernel_nofault() in a loop mi=
ght
> not be the best way. One way would be to use __put_kernel_nofault() direc=
tly.
>
> Also, what should we call this helper? aarch64_insn_memset() ?

I just found aarch64_insn_patch_text_cb() also calls
aarch64_insn_patch_text_nosync() in a loop. So it is probably OK as-is?

Thanks,
Song
