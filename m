Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0299270AE8C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 17:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjEUPXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 11:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjEUPXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 11:23:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98647BD;
        Sun, 21 May 2023 08:23:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E80B60C94;
        Sun, 21 May 2023 15:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974F7C4339C;
        Sun, 21 May 2023 15:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684682583;
        bh=lcCL7l5MucY/Bkz5R8v28fihpFuh/D4Q41f1k26mjjo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gdmulyhhc5HZ35wu1nkoyEwOxCuaZ2ezbEKtjUsmS+VQ40W3w0ZysS/lm/eUwOIy4
         wmLM2iQG/+YSwss4uCrEfWAeKowUuRI4S81XHPbuzJJKLEjl+kyLhRWo86wYUFBzZ5
         +co6hUufbqmHqaw/SmsLe/tpM7yD3rc4b0/tasLJuqbhz57Zg8uRumymDUJtxoG0d4
         ChlFCPtYBIf0oAHaK9yvygx3N6QWuJ+dOUcU9627bs482dEFXE27uTIQDInJAfqOS5
         hFyckmQCJ3yayrPju3NJqnqyY1eQyvev7m86lORQv2PikSZTu7w44kvqE92WVjrhki
         bxxWyjI04jBfQ==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-96f53c06babso573850866b.3;
        Sun, 21 May 2023 08:23:03 -0700 (PDT)
X-Gm-Message-State: AC+VfDwa5ILsjx/1yRZx6S81zDabH3e8E7oq+0esYjkpubCpCfd3XfOt
        uyiOD6xXOfUjzR8Q3izlblbJFkj1Dku+24sPUUs=
X-Google-Smtp-Source: ACHHUZ4LaKko7cWDqd76REOTyfzZg6BnmYybNhWAiaq+pUErOMuV065M8IyxkWY+cTMVj9c33sYN7T6NSeNH3qp21lo=
X-Received: by 2002:a17:907:9712:b0:96f:e622:6865 with SMTP id
 jg18-20020a170907971200b0096fe6226865mr39583ejc.57.1684682581700; Sun, 21 May
 2023 08:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230510101857.2953955-1-suagrfillet@gmail.com>
 <20230510101857.2953955-4-suagrfillet@gmail.com> <87ttwjjpx8.fsf@all.your.base.are.belong.to.us>
 <50d56c9c-49c7-8d93-6698-3d0e90d89c54@yadro.com>
In-Reply-To: <50d56c9c-49c7-8d93-6698-3d0e90d89c54@yadro.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 21 May 2023 23:22:50 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT_+Pcf5xNpa_=CTTsPfLvVLQaQ-6qm0+2gej17gdeEuA@mail.gmail.com>
Message-ID: <CAJF2gTT_+Pcf5xNpa_=CTTsPfLvVLQaQ-6qm0+2gej17gdeEuA@mail.gmail.com>
Subject: Re: [PATCH V9 3/4] riscv: ftrace: Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 support
To:     Evgenii Shatokhin <e.shatokhin@yadro.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Song Shuai <suagrfillet@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        rostedt@goodmis.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
        mhiramat@kernel.org, mark.rutland@arm.com, jszhang@kernel.org
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

On Thu, May 11, 2023 at 9:30=E2=80=AFPM Evgenii Shatokhin <e.shatokhin@yadr=
o.com> wrote:
>
> Hi,
>
> On 11.05.2023 10:19, Bj=C3=B6rn T=C3=B6pel wrote:
> > Song Shuai <suagrfillet@gmail.com> writes:
> >
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
> >> Tested-by: Guo Ren <guoren@kernel.org>
> >> Signed-off-by: Guo Ren <guoren@kernel.org>
> >> ---
> >>   arch/riscv/Kconfig              |  1 +
> >>   arch/riscv/include/asm/ftrace.h |  8 ++++++++
> >>   arch/riscv/kernel/mcount-dyn.S  | 10 ++++++++++
> >>   3 files changed, 19 insertions(+)
> >>
> >> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >> index e0632493482f..fdf0b219a02c 100644
> >> --- a/arch/riscv/Kconfig
> >> +++ b/arch/riscv/Kconfig
> >> @@ -144,6 +144,7 @@ config RISCV
> >>        select UACCESS_MEMCPY if !MMU
> >>        select ZONE_DMA32 if 64BIT
> >>        select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && (CLANG_SUPP=
ORTS_DYNAMIC_FTRACE || GCC_SUPPORTS_DYNAMIC_FTRACE)
> >> +     select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> >>        select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> >>        select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> >>        select HAVE_FUNCTION_GRAPH_TRACER
> >> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/=
ftrace.h
> >> index 84f856a3286e..84904c1e4369 100644
> >> --- a/arch/riscv/include/asm/ftrace.h
> >> +++ b/arch/riscv/include/asm/ftrace.h
> >> @@ -114,6 +114,14 @@ struct ftrace_regs;
> >>   void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> >>                       struct ftrace_ops *op, struct ftrace_regs *fregs=
);
> >>   #define ftrace_graph_func ftrace_graph_func
> >> +
> >> +static inline void
> >> +__arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long a=
ddr)
> >> +{
> >> +             regs->t1 =3D addr;
> >> +}
> >> +#define arch_ftrace_set_direct_caller(fregs, addr) \
> >> +     __arch_ftrace_set_direct_caller(&(fregs)->regs, addr)
> >>   #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> >>
> >>   #endif /* __ASSEMBLY__ */
> >> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount=
-dyn.S
> >> index f26e9f6e2fed..9d405baedb52 100644
> >> --- a/arch/riscv/kernel/mcount-dyn.S
> >> +++ b/arch/riscv/kernel/mcount-dyn.S
> >> @@ -231,6 +231,7 @@ ENDPROC(ftrace_caller)
> >>
> >>   #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> >>   ENTRY(ftrace_regs_caller)
> >> +     move    t1, zero
> >
> > Please use "mv", and not "move" [1].
> >
> >>        SAVE_ABI_REGS 1
> >>        PREPARE_ARGS
> >>
> >> @@ -239,7 +240,10 @@ ftrace_regs_call:
> >>        call    ftrace_stub
> >>
> >>        RESTORE_ABI_REGS 1
> >> +     bnez    t1,.Ldirect
> >>        jr t0
> >> +.Ldirect:
> >> +     jr t1
> >
> > Again, while you're doing changes here, please try to align op/operands=
.
> >
> > Wearing my BPF hat, I'm happy to finally get DIRECT_CALLS support!
> >
> > This does not take the WITH_CALL_OPS approach Mark suggested in the v7
> > threads, but given that text patching story on RISC-V is still a bit sa=
d
> > (inconsistency in the RV tree, no specification, cannot work with
> > preempt, ...) I'd say this approach is OK for now, and we can change to
> > WITH_CALL_OPS later in a wider "let's improve RISC-V textpatching" work=
.
> >
> > Thoughts?
>
> The WITH_CALL_OPS approach seems to need much more time and effort, so,
> yes, I'd also use this implementation of DIRECT_CALLS for now. Other
> improvements could wait for the future "big patching rework".
I agree to make DIRECT_CALLS merged first, WITH_CALL_OPS is another
"big patching rework".

>
> FWIW, the implementation of kprobes for RISC-V has been improving
> gradually too, not everything was done in the first very patchset, but
> it was usable nonetheless.
>
> I have not tested this particular version of this
> DYNAMIC_FTRACE_WITH_DIRECT_CALLS series, only some previous ones - there
> were no outstanding problems there. The code looks sane to me.
>
> >
> >
> > Bj=C3=B6rn
> >
> > [1] https://github.com/riscv-non-isa/riscv-asm-manual/blob/master/riscv=
-asm.md#-a-listing-of-standard-risc-v-pseudoinstructions
> >
>
> Regards,
> Evgenii
>
>


--=20
Best Regards
 Guo Ren
