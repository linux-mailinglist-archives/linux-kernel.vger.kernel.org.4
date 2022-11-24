Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619DF637D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 16:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiKXPbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 10:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiKXPb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 10:31:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090AF11370F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 07:31:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98AC8621AF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 15:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16F1C433D6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 15:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669303886;
        bh=TDMuBu38U1AMrW3mcmFNJeSUQwnbe0WArXcInbl7bVw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZuYiUni2iJILK+gszXOLekonZV+0uIJj/L/WPxCoRl+yYv+dFpQvc5+SydWxHv3Xw
         69QWcf3PR0TTYDpWHctJdPxiYnFr3FukFy5ekJvYvxt/sS2odZPp3Zm3xpKxzNsKcN
         hRwkIM+oh1NslDAowSJ4RfXqsk/o3RNIh3YV7CTpFIgjMq6JPciXbor8NwOU+6vLMu
         iAOnzrtchM0YNLI34AyZ2qKDIBX3AeGn4cld6Y9u7LqRkRkZGw93UIf0lTwAHXhHrj
         EEkyflTgbEcStMh4UyKigVSuWI9klRDPOxNeEi6w7DhZuZM1rJZTW/SjbsS4ZXrEOG
         SQOjVnTno5TCQ==
Received: by mail-ej1-f47.google.com with SMTP id n21so4856207ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 07:31:25 -0800 (PST)
X-Gm-Message-State: ANoB5pkhRvOh+6IWtk1qXLkyGWtVRSuTFHJTlugGs57Ax9zyGjhGE+5t
        bciRBnNAHFyFesKdAuS7L1Rq1MA6FT3Sfn1iDYc=
X-Google-Smtp-Source: AA0mqf5uEZ6EnzDTd1z6S1Ab2kydukpFXBLZV5kE7YxTMsmWCnZlk8uwjby79zF1TP73le5ESnqyrMl96pMNQAAuw/M=
X-Received: by 2002:a17:906:19d7:b0:7b2:b782:e1df with SMTP id
 h23-20020a17090619d700b007b2b782e1dfmr23920529ejd.308.1669303884230; Thu, 24
 Nov 2022 07:31:24 -0800 (PST)
MIME-Version: 1.0
References: <20221123142025.1504030-1-suagrfillet@gmail.com>
 <20221123142025.1504030-2-suagrfillet@gmail.com> <CAJF2gTTwvApRaGhZJxOrdcjWUC9DN-WF_7EKcHXx5HZ9Jkd5EA@mail.gmail.com>
 <CAAYs2=ghhMmmrM4Bktvw9iGiajS5PLd1=Z61j2ZfhbhGUi4ekg@mail.gmail.com>
In-Reply-To: <CAAYs2=ghhMmmrM4Bktvw9iGiajS5PLd1=Z61j2ZfhbhGUi4ekg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 24 Nov 2022 23:31:11 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTWSr0qYTnRORSexEHMqUt-Lj6xZd0O-fUgC+f74FfCZA@mail.gmail.com>
Message-ID: <CAJF2gTTWSr0qYTnRORSexEHMqUt-Lj6xZd0O-fUgC+f74FfCZA@mail.gmail.com>
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
>
> Actually the reg t0 always saves the address of function entry with 8B
> offset, it should only
> changed by the IPMODIFY ops instead of the direct_ops.
How about:
static inline void arch_ftrace_set_direct_caller(struct pt_regs *regs,
unsigned long addr)
{
               regs->t1 =3D regs->t0;
               regs->t0 =3D addr;

direct_caller:
add sp,sp,-?
sd t1,?(sp)
sd ra,?(sp)
call foo
ld t1,?(sp)
ld ra,?(sp)
add sp,sp,?
jr t1 // <- back to function entry

And delete all mcount-dyn.S modification.

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
