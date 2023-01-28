Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D5167F6BD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 10:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjA1JiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 04:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjA1JiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 04:38:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7C0271F
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 01:38:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A16C60B34
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 09:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF15C4339E
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 09:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674898680;
        bh=A81CewjcXvK7A/fHF1zCwSH4yZPOZFCVv7q+F0V2Y2A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FL/aOMeeuYnmeVOgH4Bah0NmZkNpXpRjdsKi/p2nNsGepMRCgTudZBspbos6YPpUV
         aonsod7z64rQ4k2QMXyQwCpO4j5jxsxA5HPIvQ2yS2JE6caUkvb5hqoTGnEv3fLETu
         NGuJPgiT8CDHntNApjoF+ajJUQM2xFb0r5OvBte2nNwBhZWHsxzVKANSEJveUoituy
         RDPSIWKkAfejyqllyR58TyCaGoxDUYM7yajsgHwgoIDHw+tKAvGqhXEN7fE2oq3NsT
         huI64/PFwu/etFRQjp8MXnjjvsQRvgYbfJR4OSNa5zrmuLzix1sqG5+wF0AoA+KTq4
         KaGlIhzM7MmQg==
Received: by mail-ed1-f51.google.com with SMTP id fi26so6734670edb.7
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 01:38:00 -0800 (PST)
X-Gm-Message-State: AO0yUKVyXRBhzBWlemKWgvVrFvTqXHQkMWf3kTwcBdXac2x0A5EFs1gr
        77jDvD3zrugpWH+9r0zSEm8V6KO1IabOdOTo3UQ=
X-Google-Smtp-Source: AK7set/sd3pDWvNtIDqKhlwf94lwgqoqaqniVsLJdgx6sbVTVaCT5WEhmxQUYWWsEgC3e5r9oByKJZSDJApy7TxTp5Y=
X-Received: by 2002:a50:c30a:0:b0:4a0:e01c:49aa with SMTP id
 a10-20020a50c30a000000b004a0e01c49aamr2730230edb.66.1674898678892; Sat, 28
 Jan 2023 01:37:58 -0800 (PST)
MIME-Version: 1.0
References: <20230112090603.1295340-1-guoren@kernel.org> <20230112090603.1295340-2-guoren@kernel.org>
 <Y7/6AtX5X0+5qF6Y@FVFF77S0Q05N>
In-Reply-To: <Y7/6AtX5X0+5qF6Y@FVFF77S0Q05N>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 28 Jan 2023 17:37:46 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTqW5A8qS5CQEr=kakxKw5FaFRDswet6CnBGUDasNJnbQ@mail.gmail.com>
Message-ID: <CAJF2gTTqW5A8qS5CQEr=kakxKw5FaFRDswet6CnBGUDasNJnbQ@mail.gmail.com>
Subject: Re: [PATCH -next V7 1/7] riscv: ftrace: Fixup panic by disabling preemption
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, suagrfillet@gmail.com, andy.chiu@sifive.com,
        e.shatokhin@yadro.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 8:16 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Guo,
>
> On Thu, Jan 12, 2023 at 04:05:57AM -0500, guoren@kernel.org wrote:
> > From: Andy Chiu <andy.chiu@sifive.com>
> >
> > In RISCV, we must use an AUIPC + JALR pair to encode an immediate,
> > forming a jump that jumps to an address over 4K. This may cause errors
> > if we want to enable kernel preemption and remove dependency from
> > patching code with stop_machine(). For example, if a task was switched
> > out on auipc. And, if we changed the ftrace function before it was
> > switched back, then it would jump to an address that has updated 11:0
> > bits mixing with previous XLEN:12 part.
> >
> > p: patched area performed by dynamic ftrace
> > ftrace_prologue:
> > p|      REG_S   ra, -SZREG(sp)
> > p|      auipc   ra, 0x? ------------> preempted
> >                                       ...
> >                               change ftrace function
> >                                       ...
> > p|      jalr    -?(ra) <------------- switched back
> > p|      REG_L   ra, -SZREG(sp)
> > func:
> >       xxx
> >       ret
>
> As mentioned on the last posting, I don't think this is sufficient to fix the
> issue. I've replied with more detail there:
>
>   https://lore.kernel.org/lkml/Y7%2F3hoFjS49yy52W@FVFF77S0Q05N/
>
> Even in a non-preemptible SMP kernel, if one CPU can be in the middle of
> executing the ftrace_prologue while another CPU is patching the
> ftrace_prologue, you have the exact same issue.
>
> For example, if CPU X is in the prologue fetches the old AUIPC and the new
> JALR (because it races with CPU Y modifying those), CPU X will branch to the
> wrong address. The race window is much smaller in the absence of preemption,
> but it's still there (and will be exacerbated in virtual machines since the
> hypervisor can preempt a vCPU at any time).
>
> Note that the above is even assuming that instruction fetches are atomic, which
> I'm not sure is the case; for example arm64 has special CMODX / "Concurrent
> MODification and eXecutuion of instructions" rules which mean only certain
> instructions can be patched atomically.
>
> Either I'm missing something that provides mutual exclusion between the
> patching and execution of the ftrace_prologue, or this patch is not sufficient.
This patch is sufficient because riscv isn't the same as arm64. It
uses default arch_ftrace_update_code, which uses stop_machine.
See kernel/trace/ftrace.c:
void __weak arch_ftrace_update_code(int command)
{
        ftrace_run_stop_machine(command);
}

ps:
 Yes, it's not good, and it's expensive.

>
> Thanks,
> Mark.
>
> > Fixes: afc76b8b8011 ("riscv: Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT")
> > Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index e2b656043abf..ee0d39b26794 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -138,7 +138,7 @@ config RISCV
> >       select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> >       select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> >       select HAVE_FUNCTION_GRAPH_TRACER
> > -     select HAVE_FUNCTION_TRACER if !XIP_KERNEL
> > +     select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
> >
> >  config ARCH_MMAP_RND_BITS_MIN
> >       default 18 if 64BIT
> > --
> > 2.36.1
> >



-- 
Best Regards
 Guo Ren
