Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4195E7BE9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiIWNeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiIWNeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:34:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E99EE131F54;
        Fri, 23 Sep 2022 06:34:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFD3A1042;
        Fri, 23 Sep 2022 06:34:19 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.80.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2712F3F73B;
        Fri, 23 Sep 2022 06:34:10 -0700 (PDT)
Date:   Fri, 23 Sep 2022 14:34:07 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-perf-users@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, guoren@kernel.org, frederic@kernel.org,
        vincent.chen@sifive.com, ardb@kernel.org, mhiramat@kernel.org,
        rostedt@goodmis.org, keescook@chromium.org,
        catalin.marinas@arm.com, Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH for-next v2 0/4] riscv: Improvments for stacktrace
Message-ID: <Yy21z0NgBgJXF1Km@FVFF77S0Q05N>
References: <20220921125128.33913-1-chenzhongjin@huawei.com>
 <YysZf2Y37QMBDt8n@FVFF77S0Q05N>
 <7834a259-4bd7-a955-acaa-21c36c7c22c2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7834a259-4bd7-a955-acaa-21c36c7c22c2@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 04:22:23PM +0800, Chen Zhongjin wrote:
> Hi,
> 
> On 2022/9/21 22:02, Mark Rutland wrote:
> > On Wed, Sep 21, 2022 at 08:51:23PM +0800, Chen Zhongjin wrote:
> > > Currently, the stacktrace with FRAME_POINTER on riscv has some problem:
> > > 
> > > 1. stacktrace will stop at irq so it can't get the stack frames before
> > > irq entry.
> > > 2. stacktrace can't unwind all the real stack frames when there is
> > > k{ret}probes or ftrace.
> > > 
> > > These are mainly becase when there is a pt_regs on stack, we can't unwind
> > > the stack frame as normal function.
> > > 
> > > Some architectures (e.g. arm64) create a extra stackframe inside pt_regs.
> > > However this doesn't work for riscv because the ra is not ensured to be
> > > pushed to stack. As explained in:
> > > commit f766f77a74f5("riscv/stacktrace: Fix stack output without ra on the stack top")
> > FWIW, this is also a latent problem on arm64, since we don't know whether the
> > LR is live at an exception boundary (and we currently always ignore it).
> 
> In fact this is still a problem for riscv, I didn't unwind the caller of
> ftrace or probed func
> 
> of kretprobe because they are inside function pro/epilogue.
> 
> The problem on riscv is a little more complex, for leaf function, ra will
> always not be pushed to stack and fp will be pushed to ra slot. This patch
> solved this problem.

That's the same on arm64, our `LR` is equivalent to your `RA`.

I have a series at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/stacktrace/metadata

... which explciitly indicates pt_regs::pc and pt_regs::lr in the stack trace
output (and for RELIABLE_STACKTRACE we'd mark the LR entries as unreliable).

> > My plan to fix that on arm64 is to push an empty frame record to the stack upon
> > an exception, and use that to find the pt_regs, from which we can get the PC
> > and LR (and then we can report the later as unreliable). That should be roughly
> > equivalent to what you do in this series (where use use the LSB to identify
> > that the pointer is actually a pt_regs).
> 
> IIRC, this solution looks like:
> 
> =====
> 
> Func1     { lr, fp } or { nothing }
> 
> irq entry { pt_regs & empty stackframe[2] }
> 
> handler   { lr, fp }
> 
> ======
> 
> handler->fp points to stackframe, and when we find stackframe is empty, we
> know we are inside
> 
> an pt_regs and can find registers by offset.
> 
> I think it's available, there no other scenario will cause the frame list
> contains zero (unless stack is clobbered).

That's basically what I do in my series; see:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=arm64/stacktrace/metadata&id=7394a825bc4f8243b28261517999793acb6f11cd

... but I haven't posted that to the list yet as I *also* want to add code to
check that we were at an exception boundary when we saw this (based on the
prior PC/LR being in the entry text, using some metadata I have yet to add).

> And it seems only fp slot should be zero, lr will be clobbered after
> function call, we cannot use lr inside pt_regs.

I'm not sure what you mean here.

I agree that the LR in the pt_regs isn't *reliable*, and won't *always* be
valid, but it will sometimes be valid.

> > One important thing to note is that when crossing an exception boundary you
> > won't know whether RA is live, and so you might try to consume an address twice
> > (if it has also been pushed to the stack). That could be problematic for
> > unwinding ftrace or kretprobes. On arm64 we had to implement
> > HAVE_FUNCTION_GRAPH_RET_ADDR_PTR so that we could reliably unwind ftrace. See
> > commit:
> > 
> >    c6d3cd32fd0064af ("arm64: ftrace: use HAVE_FUNCTION_GRAPH_RET_ADDR_PTR")
> > 
> > ... and we haven't yet come up with something similar for kretprobes (though I
> > suspect we'll need to).
> 
> Can we test the sp and fp inside pt_regs? Because luckily arm64 saves lr, fp
> and moves sp together.
> 
> Before sp is moved we will have fp == sp from last frame 'mov x29, sp'. So
> if they are same, we uses the lr in pt_regs, conversely we use lr on stack.

The frame record (which FP points to) can live anywhere in a stack frame, so
comparing aginst SP doesn't tell us anything. Regardless of whether FP == SP,
the LTR might be valid or invalid.

There is no way of knowing if LR is live without information from the compiler
that we don't have today (though from LPC 2022, it seems like CTF *might* be
sufficient -- that's on my list of things to look at).

Thanks,
Mark.
