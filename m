Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01604637039
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 03:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiKXCIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 21:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKXCIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 21:08:31 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C491C606BA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 18:08:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 03853CE28E6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39F7C43145
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669255704;
        bh=HR8w//VHwZwvQaS0YJg6erH8I27q6vnRtZMxt1FAYzA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fuLFLmszeHWtvtJ3EUM/43KdoAnPg4LteW9PWtMTOqBrFh0nh0wRWysPfxHi9D/tz
         gEDhg0DGGQ6pboWrYare6LqiEZbOdfMr2td5wpD2ZJVHtDJaqG1mc03CNIKcXybtps
         JHuF4jBaJaYqlWBzUm/gQXIOCLtOOrKWH0OLtLy75pRXKC7TLEM8b450sWVP3gaEQh
         600eWdODSu++vxVa3CX2LXGikkzk2uU0N0S5r7wdng79DUY7tOx5rPjoLKMEAzBveG
         OIFUF/hSBSj622PL+c+U//W8aPjyHoLiQ2IAPjBLMJoJvZKCvBpYmnAFgzOTtgOhWz
         s3iBamBQ0UB8w==
Received: by mail-ej1-f53.google.com with SMTP id ho10so1184590ejc.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 18:08:23 -0800 (PST)
X-Gm-Message-State: ANoB5pkGCxNePyq8L0uyqm9cdVcUwvjS/UYGbSechb+10ACk/J7+rGsO
        jhfaZU5atI0GKJzoifsar/WREekMldNMfm1rC/Y=
X-Google-Smtp-Source: AA0mqf7+jVujXIP+lyusS56nUJfILvJ+Hp/TSudQIeB4APkelF0/LZfiC4VbVnCdIYrSELTqk4ZXwVz9NxhPqHQaCp8=
X-Received: by 2002:a17:906:4e8c:b0:7ba:9c18:1204 with SMTP id
 v12-20020a1709064e8c00b007ba9c181204mr2773475eju.262.1669255702092; Wed, 23
 Nov 2022 18:08:22 -0800 (PST)
MIME-Version: 1.0
References: <20221123142025.1504030-1-suagrfillet@gmail.com>
 <20221123142025.1504030-2-suagrfillet@gmail.com> <CAJF2gTTwvApRaGhZJxOrdcjWUC9DN-WF_7EKcHXx5HZ9Jkd5EA@mail.gmail.com>
 <CAAYs2=ghhMmmrM4Bktvw9iGiajS5PLd1=Z61j2ZfhbhGUi4ekg@mail.gmail.com>
In-Reply-To: <CAAYs2=ghhMmmrM4Bktvw9iGiajS5PLd1=Z61j2ZfhbhGUi4ekg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 24 Nov 2022 10:08:10 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTgTfGAYTWbqqrdZg9bMjbpQfx8GzFzxoq3C4r9HDpz8Q@mail.gmail.com>
Message-ID: <CAJF2gTTgTfGAYTWbqqrdZg9bMjbpQfx8GzFzxoq3C4r9HDpz8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv/ftrace: add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, peterz@infradead.org, jolsa@redhat.com,
        bp@suse.de, jpoimboe@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Thu, Nov 24, 2022 at 1:27 AM Song Shuai <suagrfillet@gmail.com> wrote:
>
> Guo Ren <guoren@kernel.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8823=E6=97=A5=
=E5=91=A8=E4=B8=89 23:02=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Cool job, thx.
> >
> > On Wed, Nov 23, 2022 at 10:20 PM Song Shuai <suagrfillet@gmail.com> wro=
te:
> >>
> >> This patch adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for RISC-V.
> >>
> >> select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide the
> >> register_ftrace_direct[_multi] interfaces allowing users to register
> >> the customed trampoline (direct_caller) as the mcount for one or
> >> more target functions. And modify_ftrace_direct[_multi] are also
> >> provided for modifying direct_caller.
> >>
> >> To make the direct_caller and the other ftrace hooks (eg. function/fgr=
aph
> >> tracer, k[ret]probes) co-exist, a temporary register is nominated to
> >> store the address of direct_caller in ftrace_regs_caller. After the
> >> setting of the address direct_caller by direct_ops->func and the
> >> RESTORE_REGS in ftrace_regs_caller, direct_caller will be jumped to
> >> by the `jr` inst.
> >>
> >> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> >> ---
> >>  arch/riscv/Kconfig              | 1 +
> >>  arch/riscv/include/asm/ftrace.h | 6 ++++++
> >>  arch/riscv/kernel/mcount-dyn.S  | 4 ++++
> >>  3 files changed, 11 insertions(+)
> >>
> >> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >> index 39ec8d628cf6..d083ec08d0b6 100644
> >> --- a/arch/riscv/Kconfig
> >> +++ b/arch/riscv/Kconfig
> >> @@ -278,6 +278,7 @@ config ARCH_RV64I
> >>         select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> >>         select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-optio=
n,-fpatchable-function-entry=3D8)
> >>         select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> >> +       select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> >>         select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> >>         select HAVE_FUNCTION_GRAPH_TRACER
> >>         select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
> >> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/=
ftrace.h
> >> index 01bebb28eabe..be4d57566139 100644
> >> --- a/arch/riscv/include/asm/ftrace.h
> >> +++ b/arch/riscv/include/asm/ftrace.h
> >> @@ -114,6 +114,12 @@ struct ftrace_regs;
> >>  void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> >>                        struct ftrace_ops *op, struct ftrace_regs *freg=
s);
> >>  #define ftrace_graph_func ftrace_graph_func
> >> +
> >> +static inline void arch_ftrace_set_direct_caller(struct pt_regs *regs=
, unsigned long addr)
> >> +{
> >> +               regs->t1 =3D addr;
> >
> > How about regs->t0 =3D addr; ?
> > And delete all mcount-dyn.S modification.
> >
> The direct_caller has the same program layout as the ftrace_caller, which=
 means
> the reg t0 will never be changed when direct_caller returns.
>
> If regs->t0 changes here and ftrace_regs_caller executes `jr t0`,
> direct_caller will enter the dead loop.
?

ftrace_regs_caller->call_direct_funcs->
arch_ftrace_set_direct_caller-> ftrace_regs_caller jr t0.

Only call_direct_funcs call arch_ftrace_set_direct_caller !

static void call_direct_funcs(unsigned long ip, unsigned long pip,
                              struct ftrace_ops *ops, struct ftrace_regs *f=
regs)
{
        struct pt_regs *regs =3D ftrace_get_regs(fregs);
        unsigned long addr;

        addr =3D ftrace_find_rec_direct(ip);
        if (!addr)
                return;

        arch_ftrace_set_direct_caller(regs, addr);
}

>
> Actually the reg t0 always saves the address of function entry with 8B
> offset, it should only
> changed by the IPMODIFY ops instead of the direct_ops.
> >>
> >> +}
> >> +
> >>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> >>
> >>  #endif /* __ASSEMBLY__ */
> >> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount=
-dyn.S
> >> index 466c6ef217b1..b89c85a58569 100644
> >> --- a/arch/riscv/kernel/mcount-dyn.S
> >> +++ b/arch/riscv/kernel/mcount-dyn.S
> >> @@ -233,6 +233,7 @@ ENDPROC(ftrace_caller)
> >>  #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> >>  ENTRY(ftrace_regs_caller)
> >>         SAVE_ABI_REGS 1
> >> +       REG_S   x0, PT_T1(sp)
> >>         PREPARE_ARGS
> >>
> >>  ftrace_regs_call:
> >> @@ -241,7 +242,10 @@ ftrace_regs_call:
> >>
> >>
> >>         RESTORE_ABI_REGS 1
> >> +       bnez    t1,.Ldirect
> >>         jr t0
> >> +.Ldirect:
> >> +       jr t1
> >>  ENDPROC(ftrace_regs_caller)
> >>
> >>  ENTRY(ftrace_caller)
> >> --
> >> 2.20.1
> >>
> >
> >
> > --
> > Best Regards
> >  Guo Ren



--=20
Best Regards
 Guo Ren
