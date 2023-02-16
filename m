Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBE16998BC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjBPPYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBPPYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:24:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20515241FA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:23:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0B4C61761
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 15:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93525C433EF;
        Thu, 16 Feb 2023 15:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676561036;
        bh=yLtl/ZoTFhFQF8F15NijTr30bEfNrPFH3IlKTUdQhs0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tkf1sCPk17qoZnElk1gT130KeKtwOQr+VaA2yoTFQMS7PbPHeOpNmTwv73ug4TyX+
         NtsTV8Gqy9EU19sC29rYfA7rkPCgsIKfeK8QitE1eY/4PetAPB+4j92VcxzlidNPG6
         u49k/vNdXdUyHKWC6a3IZV1bMbRcEVrpOBAqUsxHxAx/uajLzqb44f+xK5/XSL/ULt
         /T1ln7kwIiOm///NavKe3TdF2h9ncifTOls9ubpaoANzPl/yv4xs23fr0TUSOclX8E
         tkftu8PSoqgyhcFgskKmFiN3Fd/2z9iww97DhIiTYjasQ+qzN1w2nwr2GRZ+181veC
         Y83ABU7SDyhlQ==
Date:   Fri, 17 Feb 2023 00:23:51 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Guo Ren <guoren@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        "liaochang (A)" <liaochang1@huawei.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: kprobe: Optimize kprobe with accurate atomicity
Message-Id: <20230217002351.112635f4fb35f84002666d29@kernel.org>
In-Reply-To: <Y9juYX8Bt1Z55lv0@FVFF77S0Q05N>
References: <20230126161559.1467374-1-guoren@kernel.org>
        <0abbbdd4-6b85-9659-03ee-97c56a5b77c1@huawei.com>
        <CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com>
        <87r0vc9h4g.fsf@all.your.base.are.belong.to.us>
        <Y9fm+6LPXgtDSma/@FVFF77S0Q05N>
        <CAJF2gTRgze_owuWvJjnrPpBNs8+GY-km7wvHU4EuJzarQc+BPQ@mail.gmail.com>
        <Y9juYX8Bt1Z55lv0@FVFF77S0Q05N>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry I missed this thread.

On Tue, 31 Jan 2023 10:33:05 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> On Tue, Jan 31, 2023 at 09:48:29AM +0800, Guo Ren wrote:
> > On Mon, Jan 30, 2023 at 11:49 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > Hi Bjorn,
> > >
> > > On Mon, Jan 30, 2023 at 04:28:15PM +0100, Björn Töpel wrote:
> > > > Guo Ren <guoren@kernel.org> writes:
> > > >
> > > > >> In the serie of RISCV OPTPROBES [1], it patches a long-jump instructions pair
> > > > >> AUIPC/JALR in kernel text, so in order to ensure other CPUs does not execute
> > > > >> in the instructions that will be modified, it is still need to stop other CPUs
> > > > >> via patch_text API, or you have any better solution to achieve the purpose?
> > > > >  - The stop_machine is an expensive way all architectures should
> > > > > avoid, and you could keep that in your OPTPROBES implementation files
> > > > > with static functions.
> > > > >  - The stop_machine couldn't work with PREEMPTION, so your
> > > > > implementation needs to work with !PREEMPTION.
> > > >
> > > > ...and stop_machine() with !PREEMPTION is broken as well, when you're
> > > > replacing multiple instructions (see Mark's post at [1]). The
> > > > stop_machine() dance might work when you're replacing *one* instruction,
> > > > not multiple as in the RISC-V case. I'll expand on this in a comment in
> > > > the OPTPROBES v6 series.
> > >
> > > Just to clarify, my comments in [1] were assuming that stop_machine() was not
> > > used, in which case there is a problem with or without PREEMPTION.
> > >
> > > I believe that when using stop_machine(), the !PREEMPTION case is fine, since
> > > stop_machine() schedules work rather than running work in IRQ context on the
> > > back of an IPI, so no CPUs should be mid-sequnce during the patching, and it's
> > > not possible for there to be threads which are preempted mid-sequence.
> > >
> > > That all said, IIUC optprobes is going to disappear once fprobe is ready
> > > everywhere, so that might be moot.
> > The optprobes could be in the middle of a function, but fprobe must be
> > the entry of a function, right?
> > 
> > Does your fprobe here mean: ?
> > 
> > The Linux kernel configuration item CONFIG_FPROBE:
> > 
> > prompt: Kernel Function Probe (fprobe)
> > type: bool
> > depends on: ( CONFIG_FUNCTION_TRACER ) && (
> > CONFIG_DYNAMIC_FTRACE_WITH_REGS ) && ( CONFIG_HAVE_RETHOOK )
> > defined in kernel/trace/Kconfig
> 
> Yes.
> 
> Masami, Steve, and I had a chat at the tracing summit late last year (which
> unfortunately, was not recorded), and what we'd like to do is get each
> architecture to have FPROBE (and FTRACE_WITH_ARGS), at which point OPTPROBE
> and KRETPROBE become redundant and could be removed.

No, the fprobe will replace the KRETPROBE but not OPTPROBE. The OPTPROBE
is completely different one. Fprobe is used only for function entry, but
optprobe is applied to the function body.

> 
> i.e. we'd keep KPROBES as a "you can trace any instruction" feature, but in the
> few cases where OPTPROBES can make things fater by using FTRACE, you should
> just use that directly via FPROBE.

I think what you are saying is KPROBE_ON_FTRACE, and that will be replaced by
FPROBES.

Thank you,

> 
> Thanks,
> Mark.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
