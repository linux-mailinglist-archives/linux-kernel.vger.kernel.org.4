Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD00D6988B0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 00:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjBOXQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 18:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjBOXQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 18:16:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424713C28C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 15:16:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF16961DD0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF650C433D2;
        Wed, 15 Feb 2023 23:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676502999;
        bh=nn+XtUdUA9fUBtbMXv1HBnDv1Rsn0oB51la5XEORWrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JZ9umhwkM8nNdKnkvdFfKgVd+9ZvJK4CqzDVXyjsEOsAe2LF6NU1PhhvzFUjBXhLR
         LjjvwkfLEY5CQrPbmp74HYxxabBwybZwEIw860ySc7JS/Oxq5lcAlTmrvwblRA4PcG
         oZVRnfEt6Fn2U0GRfKU0Fe8SymntY51STxHm44FmbUEIWGWmLFCB5/mEG5+zM3LLmF
         u7L6XGlYSO/iBg6F7j0SJcOIuOG5Tg6ygHxNMofoXYXqcekgWD7ke+2OARXFKAR7Wh
         65fnP/sTGXFT0TggsoGVvQIgfGwu5Z8lhumtLHE2I/u4G2WPyEAlZWPwSAr1pEgjim
         T+EsgzZMQeTBQ==
Date:   Wed, 15 Feb 2023 15:16:37 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 2/2] x86/entry: Fix unwinding from kprobe on PUSH/POP
 instruction
Message-ID: <20230215231637.laryjsua5p4wcd57@treble>
References: <cover.1676068346.git.jpoimboe@kernel.org>
 <baafcd3cc1abb14cb757fe081fa696012a5265ee.1676068346.git.jpoimboe@kernel.org>
 <20230213234357.1fe194b2767d9bc431202d4c@kernel.org>
 <Y+tx6DZyoQ362lUM@hirez.programming.kicks-ass.net>
 <20230214170552.glhdytvunczyxxao@treble>
 <Y+yzMmL7gUprDru3@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+yzMmL7gUprDru3@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 11:25:54AM +0100, Peter Zijlstra wrote:
> On Tue, Feb 14, 2023 at 09:05:52AM -0800, Josh Poimboeuf wrote:
> > On Tue, Feb 14, 2023 at 12:35:04PM +0100, Peter Zijlstra wrote:
> > > On Mon, Feb 13, 2023 at 11:43:57PM +0900, Masami Hiramatsu wrote:
> > > 
> > > > > Fix it by annotating the #BP exception as a non-signal stack frame,
> > > > > which tells the ORC unwinder to decrement the instruction pointer before
> > > > > looking up the corresponding ORC entry.
> > > > 
> > > > Just to make it clear, this sounds like a 'hack' use of non-signal stack
> > > > frame. If so, can we change the flag name as 'literal' or 'non-literal' etc?
> > > > I concern that the 'signal' flag is used differently in the future.
> > 
> > Agreed, though I'm having trouble coming up with a succinct yet
> > scrutable name.  If length wasn't an issue it would be something like
> > 
> >   "decrement_return_address_when_looking_up_the_next_orc_entry"
> > 
> > > Oooh, bike-shed :-) Let me suggest trap=1, where a trap is a fault with
> > > a different return address, specifically the instruction after the
> > > faulting instruction.
> > 
> > I think "trap" doesn't work because
> > 
> >  1) It's more than just traps, it's also function calls.  We have
> >     traps/calls in one bucket (decrement IP); and everything else
> >     (faults, aborts, irqs) in the other (don't decrement IP).
> > 
> >  2) It's not necessarily all traps which need the flag, just those that
> >     affect a previously-but-now-overwritten stack-modifying instruction.
> >     So #OF (which we don't use?) and trap-class #DB don't seem to be
> >     affected.  In practice maybe this distinction doesn't matter, but
> >     for example there's no reason for ORC try to distinguish trap #DB
> >     from non-trap #DB at runtime.
> 
> Well, I was specifically thinking about #DB, why don't we need to
> decrement when we put a hardware breakpoint on a stack modifying op?

I assume you mean the INT1 instruction.  Yeah, maybe we should care
about that.

I'm struggling to come up with any decent ideas about how to implement
that.  Presumably the #DB handler would have to communicate to the
unwinder somehow whether the given frame is a trap.

Alternatively I was thinking the unwinder could read the instruction,
but then it doesn't know whether to read regs->ip or the previous
instruction.

-- 
Josh
