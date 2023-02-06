Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E227768B918
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjBFJ4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBFJ4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:56:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9C8A1CADB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 01:56:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD3F1113E;
        Mon,  6 Feb 2023 01:57:13 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.91.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB16D3F71E;
        Mon,  6 Feb 2023 01:56:28 -0800 (PST)
Date:   Mon, 6 Feb 2023 09:56:26 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Evgenii Shatokhin <e.shatokhin@yadro.com>, suagrfillet@gmail.com,
        andy.chiu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, linux@yadro.com
Subject: Re: [PATCH -next V7 0/7] riscv: Optimize function trace
Message-ID: <Y+DOyqehZvBJlb8N@FVFF77S0Q05N>
References: <20230112090603.1295340-1-guoren@kernel.org>
 <c68bac83-5c88-80b1-bac9-e1fd4ea8f07e@yadro.com>
 <CAJF2gTQm11px3mqyrNk1SRiJZud1yeY2avK99UX9KetWAGe5BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTQm11px3mqyrNk1SRiJZud1yeY2avK99UX9KetWAGe5BA@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2023 at 02:40:52PM +0800, Guo Ren wrote:
> On Mon, Jan 16, 2023 at 11:02 PM Evgenii Shatokhin
> <e.shatokhin@yadro.com> wrote:
> >
> > Hi,
> >
> > On 12.01.2023 12:05, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > The previous ftrace detour implementation fc76b8b8011 ("riscv: Using
> > > PATCHABLE_FUNCTION_ENTRY instead of MCOUNT") contain three problems.
> > >
> > >   - The most horrible bug is preemption panic which found by Andy [1].
> > >     Let's disable preemption for ftrace first, and Andy could continue
> > >     the ftrace preemption work.
> >
> > It seems, the patches #2-#7 of this series do not require "riscv:
> > ftrace: Fixup panic by disabling preemption" and can be used without it.
> >
> > How about moving that patch out of the series and processing it separately?
> Okay.
> 
> >
> > As it was pointed out in the discussion of that patch, some other
> > solution to non-atomic changes of the prologue might be needed anyway.
> I think you mean Mark Rutland's DYNAMIC_FTRACE_WITH_CALL_OPS. But that
> still needs to be ready. Let's disable PREEMPT for ftrace first.

FWIW, taking the patch to disable FTRACE with PREEMPT for now makes sense to
me, too.

The DYNAMIC_FTRACE_WITH_CALL_OPS patches should be in v6.3. They're currently
queued in the arm64 tree in the for-next/ftrace branch:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/ftrace
  https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/ 

... and those *should* be in v6.3.

Patches to imeplement DIRECT_CALLS atop that are in review at the moment:

  https://lore.kernel.org/linux-arm-kernel/20230201163420.1579014-1-revest@chromium.org/

... and if riscv uses the CALL_OPS approach, I believe it can do much the same
there.

If riscv wants to do a single atomic patch to each patch-site (to avoid
stop_machine()), then direct calls would always needs to bounce through the
ftrace_caller trampoline (and acquire the direct call from the ftrace_ops), but
that might not be as bad as it sounds -- from benchmarking on arm64, the bulk
of the overhead seen with direct calls is when using the list_ops or having to
do a hash lookup, and both of those are avoided with the CALL_OPS approach.
Calling directly from the patch-site is a minor optimization relative to
skipping that work.

Thanks,
Mark.
