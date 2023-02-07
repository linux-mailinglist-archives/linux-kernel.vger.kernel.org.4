Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA19C68CC8E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjBGCbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBGCby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:31:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD0F11642
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 18:31:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 562B66115D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBACC433A4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675737111;
        bh=YNJzTPstzfVtUYzB7oLj22npuuOQ+S7JUDF7ZiXgA9I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rFhOdaHKeXENP6WkZQgrDA1v9V3zzeOWnL6Umu9e0FtZ8MOKYa70OLV5kzw+gKwK4
         lAHDrAQ+eyyslQP92e/ZFvqI0oEbMCXNdN2c1Uj1IoBQtWDd4laHtwDy4jWnxqWSnk
         WKnbhnxoDhvUfN1XEvBOLtajFUml0Hiq+2AtuGLo52EkThgwXOgExwE86Mvs6jToo7
         YasCkK8x0W2/BzNh3vfbJus5lENdAIoBSBLxde+qn7h9PAwlsQ21qZs4pJYd0o/sl+
         woENYyOXPJm0q8HLeNI3IgYNGIAl/sn1RndkLhPllyxIyYe0a8WS8D2YUBtli5RK3n
         a5RYcHbxLCpoQ==
Received: by mail-ej1-f52.google.com with SMTP id gr7so39645960ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 18:31:51 -0800 (PST)
X-Gm-Message-State: AO0yUKX6z7vN4fShD0KMAv80Nm6fdDlJCLjpBQmlmydU9ID9cm7+m/uS
        A8WJFPXAjxbwN6LIiDzVK0PXRogXAU3ok6403+M=
X-Google-Smtp-Source: AK7set/ugU5LEV6s3oXRzQ8fYC/n7btWtYlDIwJQZiAM5/v4sHJ4oabsYtaJIYsxGoUYOGrr6vWt2yZZt6uCQDIxByw=
X-Received: by 2002:a17:906:3e04:b0:884:c19c:7c6 with SMTP id
 k4-20020a1709063e0400b00884c19c07c6mr379762eji.120.1675737109913; Mon, 06 Feb
 2023 18:31:49 -0800 (PST)
MIME-Version: 1.0
References: <20230107133549.4192639-1-guoren@kernel.org> <20230107133549.4192639-2-guoren@kernel.org>
 <Y7xMvAJXjHaus0Bm@FVFF77S0Q05N> <CAJF2gTRzS0hBdqBUNbijvKKx3Kf_mY55XSkUyPJsfOK8p15_Mw@mail.gmail.com>
 <Y7/3hoFjS49yy52W@FVFF77S0Q05N> <CAJF2gTQXRt-mmuA=kKKdQojgLG-eQm6PqTuwf0ccw4cdYdbYfQ@mail.gmail.com>
 <Y9enOQUDsMbY1Y/f@FVFF77S0Q05N>
In-Reply-To: <Y9enOQUDsMbY1Y/f@FVFF77S0Q05N>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 7 Feb 2023 10:31:38 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRpVHygPuxTAyJaYWRaA5kQdULMKp2HnGscTSeh88R1CQ@mail.gmail.com>
Message-ID: <CAJF2gTRpVHygPuxTAyJaYWRaA5kQdULMKp2HnGscTSeh88R1CQ@mail.gmail.com>
Subject: Re: [PATCH -next V6 1/7] riscv: ftrace: Fixup panic by disabling preemption
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

On Mon, Jan 30, 2023 at 7:17 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Sat, Jan 28, 2023 at 06:00:20PM +0800, Guo Ren wrote:
> > On Thu, Jan 12, 2023 at 8:05 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> > > Ignoring things which require HW changes, you could consider doing something
> > > like what I'm doing for arm64 with DYNAMIC_FTRACE_WITH_CALL_OPS:
> > >
> > >   https://lore.kernel.org/lkml/20230109135828.879136-1-mark.rutland@arm.com/
> > The idea of DYNAMIC_FTRACE_WITH_CALL_OPS (Using data load/store +
> > indirect jump instead of auipc+jalr) is similar to Andy's solution
> > (See youtube link, last page of ppt).
>
> Sure; I was present in that room and I spoke with Andy at the time.
>
> The solutions are similar, but the important detail with
> DYNAMIC_FTRACE_WITH_CALL_OPS is that the load and indirect branch is moved into
> a common trampoline so that each call-site can be smaller. The ops pointer is
> placed *before* the function entry point and doesn't need to be skipped with a
> direct branch (which Andy's approach could also do if he aligned functions
> similarly).
>
> > But the key problem is you also expand the size of the prologue of the
> > function. 64BIT is already expensive, and we can't afford more of it. I would
> > change to seek a new atomic auipc+jalr ISA extension to solve this problem.
>
> Sure, and that's nice for *new* hardware, but I'm talking about a solution
> which works on *current* hardware.
>
> > DYNAMIC_FTRACE_WITH_CALL_OPS  would speed up ftrace_(regs)_caller (Mostly for
> > kernel debug), but it won't help DYNAMIC_FTRACE_WITH_DIRECT_CALLS. So I do
> > not so care about the ftrace_(regs)_caller performance gain.
>
> Actually, the plan is that it *will* help DYNAMIC_FTRACE_WITH_DIRECT_CALLS; we
> just didn't make all the necessary changes in one go.
>
> Florent Revest is looking at implementing that by placing the direct call
> pointer into the ops, so the common trampoline can load that directly.
>
> He has an older draft available at:
>
>   https://github.com/FlorentRevest/linux/commits/indirect-direct-calls-3
Thx for sharing :)

>
> ... and since then, having spoken to Steven, we came up with a plan to make all
> direct calls require an ops (which is the case for DIRECT_CALLS_MULTI), and
> place a trampoline pointer in the ops.
>
> That way, the common trampoline can do something like (in arm64 asm):
>
> |       LDR     <tmp>, [<ops>, #OPS_TRAMP_PTR]
> |       CBNZ    <tmp>, __call_tramp_directly
> |
> |       // ... regular regs trampoline logic here
> |
> | __call_tramp_directly:
> |
> |       // ... shuffle registers here
> |
> |       BR      <tmp>
>
> ... and I believe the same should work for riscv.
I agree; I would try next.

>
> Thanks,
> Mark.



-- 
Best Regards
 Guo Ren
