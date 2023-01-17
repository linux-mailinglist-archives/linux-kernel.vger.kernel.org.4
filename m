Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207CE66D4EB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 04:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjAQDU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 22:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbjAQDU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 22:20:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223F31EFE9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 19:20:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DE6B61195
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:20:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6D7C433F1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673925653;
        bh=wriUBgicTaC+t8IkV16XbM7mUlfFrKd1Nr42jZaqoUY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wyp9nwrle5LCPrnI5asouXCAgK/2sPXHMTkc4fKL1vhaodYcp9OgUYX7OyMfwDZ5H
         /7SShDJGutLG6hKF2cWEwzO9PMv5YYl4kfhu3RUCnKmNhPPpp8k9QoiKGxxDWu3rst
         nY10u1KPR7vtHVeH+f0DfshgZaMXRS/ObOrTheHkYjy7BJV5I8Oa6TwNW3nE2nDeD8
         qHUMnfD15ni4VctUMIk0jSBzdUQxj0NaEZCdlH/Xlft4sVgNE2uHI0EX/9KDxdJrSh
         DR2fB/OcBjLuYteGLXhBAajX8VrEiNyo8FWPZDT3FIHpf1Yb5Xr/NecRHRA/3CVR5j
         WPGp9avl9+Atg==
Received: by mail-ed1-f54.google.com with SMTP id b4so23707365edf.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 19:20:53 -0800 (PST)
X-Gm-Message-State: AFqh2kp6X6vVt84VJYCitsjPGx3sdaXXt+L5fI1dZ1gowmvrk+2Nk8mH
        7LZ3u+nU8J+m0CSCtM+zeK1Xgi4LuInzzzX59R0=
X-Google-Smtp-Source: AMrXdXsjijdmnxaYDVxGSsrWYrO+VMZMTXKVy28Nf83PY6STDnn/HbqXlWFcLrh14iVSsb2wkjMjcEZYLp725h3BVvc=
X-Received: by 2002:a05:6402:22f7:b0:49b:651d:7930 with SMTP id
 dn23-20020a05640222f700b0049b651d7930mr146650edb.79.1673925651961; Mon, 16
 Jan 2023 19:20:51 -0800 (PST)
MIME-Version: 1.0
References: <20230107133549.4192639-1-guoren@kernel.org> <20230107133549.4192639-8-guoren@kernel.org>
 <CAAYs2=h464Fx8ix4f_aJWBfRaz8BipfvxzAZoGDnBQkPrY_nNQ@mail.gmail.com> <CAAYs2=jiOF8qrurRx20Hfu9e=5YSw+ONeLQPM7xV7-igiCG+7Q@mail.gmail.com>
In-Reply-To: <CAAYs2=jiOF8qrurRx20Hfu9e=5YSw+ONeLQPM7xV7-igiCG+7Q@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 17 Jan 2023 11:20:39 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRnu_05mvPoaCbw+sSMpSE=dV7n1inH4cw-wCUM8WXFwQ@mail.gmail.com>
Message-ID: <CAJF2gTRnu_05mvPoaCbw+sSMpSE=dV7n1inH4cw-wCUM8WXFwQ@mail.gmail.com>
Subject: Re: [PATCH -next V6 7/7] samples: ftrace: Add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     anup@brainfault.org, e.shatokhin@yadro.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, andy.chiu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 6:48 PM Song Shuai <suagrfillet@gmail.com> wrote:
>
> Hi,Guo:
>
> Song Shuai <suagrfillet@gmail.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=8811=E6=
=97=A5=E5=91=A8=E4=B8=89 09:50=E5=86=99=E9=81=93=EF=BC=9A
> >
> > <guoren@kernel.org> =E4=BA=8E2023=E5=B9=B41=E6=9C=887=E6=97=A5=E5=91=A8=
=E5=85=AD 13:36=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > From: Song Shuai <suagrfillet@gmail.com>
> > >
> > > select HAVE_SAMPLE_FTRACE_DIRECT and HAVE_SAMPLE_FTRACE_DIRECT_MULTI
> > > for ARCH_RV64I in arch/riscv/Kconfig. And add riscv asm code for
> > > the ftrace-direct*.c files in samples/ftrace/.
> > >
> > > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > > Tested-by: Guo Ren <guoren@kernel.org>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > ---
> > Hi,Guo && Evgenii:
> >
> > As Evgenii comments, this patch has two problems to fix:
> >
> > 1. the modification of Kconfig is missing
> > So we should add it back
> >
> > 2. the build error resulted by including of nospec-branch.h file
> > This including is exclusive for x86 architecture, moving it under
> > x86 #ifdef seems better to fix this error
> >
> > I fixed them in my GitHub repo, but I can't find a reasonable target
> > branch in your repo to PR.
> > So I paste the link of my branch here, you can pick the first 2
> > commits in the next series.
> >
> > - samples: ftrace: Add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]
> > - samples: ftrace: Include the nospec-branch.h only for x86
> This patch for the 2nd problem mentioned above seems to be omitted in
> the V7 series.
> I paste the raw patch link here. Hope you can add it in the next.
>
> https://github.com/sugarfillet/linux/commit/9539a80dc6e7d1137ec7a96ebef2a=
b912a694bd7.patch
Why do we need an x86 patchset in a riscv series? Without the patch,
what's compile error in riscv?

> >
> > Link: https://github.com/sugarfillet/linux/commits/song_ftrace_fix_up_v=
6
> >
> > >  samples/ftrace/ftrace-direct-modify.c       | 33 ++++++++++++++++++
> > >  samples/ftrace/ftrace-direct-multi-modify.c | 37 +++++++++++++++++++=
++
> > >  samples/ftrace/ftrace-direct-multi.c        | 22 ++++++++++++
> > >  samples/ftrace/ftrace-direct-too.c          | 26 +++++++++++++++
> > >  samples/ftrace/ftrace-direct.c              | 22 ++++++++++++
> > >  5 files changed, 140 insertions(+)
> > >
> > > diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/f=
trace-direct-modify.c
> > > index de5a0f67f320..be7bf472c3c7 100644
> > > --- a/samples/ftrace/ftrace-direct-modify.c
> > > +++ b/samples/ftrace/ftrace-direct-modify.c
> > > @@ -23,6 +23,39 @@ extern void my_tramp2(void *);
> > >
> > >  static unsigned long my_ip =3D (unsigned long)schedule;
> > >
> > > +#ifdef CONFIG_RISCV
> > > +
> > > +asm (" .pushsection    .text, \"ax\", @progbits\n"
> > > +"      .type           my_tramp1, @function\n"
> > > +"      .globl          my_tramp1\n"
> > > +"   my_tramp1:\n"
> > > +"      addi sp,sp,-16\n"
> > > +"      sd   t0,0(sp)\n"
> > > +"      sd   ra,8(sp)\n"
> > > +"      call my_direct_func1\n"
> > > +"      ld   t0,0(sp)\n"
> > > +"      ld   ra,8(sp)\n"
> > > +"      addi sp,sp,16\n"
> > > +"      jr t0\n"
> > > +"      .size           my_tramp1, .-my_tramp1\n"
> > > +
> > > +"      .type           my_tramp2, @function\n"
> > > +"      .globl          my_tramp2\n"
> > > +"   my_tramp2:\n"
> > > +"      addi sp,sp,-16\n"
> > > +"      sd   t0,0(sp)\n"
> > > +"      sd   ra,8(sp)\n"
> > > +"      call my_direct_func2\n"
> > > +"      ld   t0,0(sp)\n"
> > > +"      ld   ra,8(sp)\n"
> > > +"      addi sp,sp,16\n"
> > > +"      jr t0\n"
> > > +"      .size           my_tramp2, .-my_tramp2\n"
> > > +"      .popsection\n"
> > > +);
> > > +
> > > +#endif /* CONFIG_RISCV */
> > > +
> > >  #ifdef CONFIG_X86_64
> > >
> > >  #include <asm/ibt.h>
> > > diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ft=
race/ftrace-direct-multi-modify.c
> > > index d52370cad0b6..10884bf418f7 100644
> > > --- a/samples/ftrace/ftrace-direct-multi-modify.c
> > > +++ b/samples/ftrace/ftrace-direct-multi-modify.c
> > > @@ -21,6 +21,43 @@ void my_direct_func2(unsigned long ip)
> > >  extern void my_tramp1(void *);
> > >  extern void my_tramp2(void *);
> > >
> > > +#ifdef CONFIG_RISCV
> > > +
> > > +asm (" .pushsection    .text, \"ax\", @progbits\n"
> > > +"      .type           my_tramp1, @function\n"
> > > +"      .globl          my_tramp1\n"
> > > +"   my_tramp1:\n"
> > > +"       addi sp,sp,-24\n"
> > > +"       sd   a0,0(sp)\n"
> > > +"       sd   t0,8(sp)\n"
> > > +"       sd   ra,16(sp)\n"
> > > +"       call my_direct_func1\n"
> > > +"       ld   a0,0(sp)\n"
> > > +"       ld   t0,8(sp)\n"
> > > +"       ld   ra,16(sp)\n"
> > > +"       addi sp,sp,24\n"
> > > +"      jr t0\n"
> > > +"      .size           my_tramp1, .-my_tramp1\n"
> > > +
> > > +"      .type           my_tramp2, @function\n"
> > > +"      .globl          my_tramp2\n"
> > > +"   my_tramp2:\n"
> > > +"       addi sp,sp,-24\n"
> > > +"       sd   a0,0(sp)\n"
> > > +"       sd   t0,8(sp)\n"
> > > +"       sd   ra,16(sp)\n"
> > > +"       call my_direct_func2\n"
> > > +"       ld   a0,0(sp)\n"
> > > +"       ld   t0,8(sp)\n"
> > > +"       ld   ra,16(sp)\n"
> > > +"       addi sp,sp,24\n"
> > > +"      jr t0\n"
> > > +"      .size           my_tramp2, .-my_tramp2\n"
> > > +"      .popsection\n"
> > > +);
> > > +
> > > +#endif /* CONFIG_RISCV */
> > > +
> > >  #ifdef CONFIG_X86_64
> > >
> > >  #include <asm/ibt.h>
> > > diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ft=
race-direct-multi.c
> > > index ec1088922517..a35bf43bf6d7 100644
> > > --- a/samples/ftrace/ftrace-direct-multi.c
> > > +++ b/samples/ftrace/ftrace-direct-multi.c
> > > @@ -16,6 +16,28 @@ void my_direct_func(unsigned long ip)
> > >
> > >  extern void my_tramp(void *);
> > >
> > > +#ifdef CONFIG_RISCV
> > > +
> > > +asm ("       .pushsection    .text, \"ax\", @progbits\n"
> > > +"       .type           my_tramp, @function\n"
> > > +"       .globl          my_tramp\n"
> > > +"   my_tramp:\n"
> > > +"       addi sp,sp,-24\n"
> > > +"       sd   a0,0(sp)\n"
> > > +"       sd   t0,8(sp)\n"
> > > +"       sd   ra,16(sp)\n"
> > > +"       call my_direct_func\n"
> > > +"       ld   a0,0(sp)\n"
> > > +"       ld   t0,8(sp)\n"
> > > +"       ld   ra,16(sp)\n"
> > > +"       addi sp,sp,24\n"
> > > +"       jr t0\n"
> > > +"       .size           my_tramp, .-my_tramp\n"
> > > +"       .popsection\n"
> > > +);
> > > +
> > > +#endif /* CONFIG_RISCV */
> > > +
> > >  #ifdef CONFIG_X86_64
> > >
> > >  #include <asm/ibt.h>
> > > diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftra=
ce-direct-too.c
> > > index e13fb59a2b47..3b62e33c2e6d 100644
> > > --- a/samples/ftrace/ftrace-direct-too.c
> > > +++ b/samples/ftrace/ftrace-direct-too.c
> > > @@ -18,6 +18,32 @@ void my_direct_func(struct vm_area_struct *vma,
> > >
> > >  extern void my_tramp(void *);
> > >
> > > +#ifdef CONFIG_RISCV
> > > +
> > > +asm ("       .pushsection    .text, \"ax\", @progbits\n"
> > > +"       .type           my_tramp, @function\n"
> > > +"       .globl          my_tramp\n"
> > > +"   my_tramp:\n"
> > > +"       addi sp,sp,-40\n"
> > > +"       sd   a0,0(sp)\n"
> > > +"       sd   a1,8(sp)\n"
> > > +"       sd   a2,16(sp)\n"
> > > +"       sd   t0,24(sp)\n"
> > > +"       sd   ra,32(sp)\n"
> > > +"       call my_direct_func\n"
> > > +"       ld   a0,0(sp)\n"
> > > +"       ld   a1,8(sp)\n"
> > > +"       ld   a2,16(sp)\n"
> > > +"       ld   t0,24(sp)\n"
> > > +"       ld   ra,32(sp)\n"
> > > +"       addi sp,sp,40\n"
> > > +"       jr t0\n"
> > > +"       .size           my_tramp, .-my_tramp\n"
> > > +"       .popsection\n"
> > > +);
> > > +
> > > +#endif /* CONFIG_RISCV */
> > > +
> > >  #ifdef CONFIG_X86_64
> > >
> > >  #include <asm/ibt.h>
> > > diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-d=
irect.c
> > > index 1f769d0db20f..2cfe5a7d2d70 100644
> > > --- a/samples/ftrace/ftrace-direct.c
> > > +++ b/samples/ftrace/ftrace-direct.c
> > > @@ -15,6 +15,28 @@ void my_direct_func(struct task_struct *p)
> > >
> > >  extern void my_tramp(void *);
> > >
> > > +#ifdef CONFIG_RISCV
> > > +
> > > +asm ("       .pushsection    .text, \"ax\", @progbits\n"
> > > +"       .type           my_tramp, @function\n"
> > > +"       .globl          my_tramp\n"
> > > +"   my_tramp:\n"
> > > +"       addi sp,sp,-24\n"
> > > +"       sd   a0,0(sp)\n"
> > > +"       sd   t0,8(sp)\n"
> > > +"       sd   ra,16(sp)\n"
> > > +"       call my_direct_func\n"
> > > +"       ld   a0,0(sp)\n"
> > > +"       ld   t0,8(sp)\n"
> > > +"       ld   ra,16(sp)\n"
> > > +"       addi sp,sp,24\n"
> > > +"       jr t0\n"
> > > +"       .size           my_tramp, .-my_tramp\n"
> > > +"       .popsection\n"
> > > +);
> > > +
> > > +#endif /* CONFIG_RISCV */
> > > +
> > >  #ifdef CONFIG_X86_64
> > >
> > >  #include <asm/ibt.h>
> > > --
> > > 2.36.1
> > >
> >
> >
> > --
> > Thanks,
> > Song
>
>
>
> --
> Thanks,
> Song



--=20
Best Regards
 Guo Ren
