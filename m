Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B0069978A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjBPOfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjBPOfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:35:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910C54C6C5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:35:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B11A6147B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 14:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31ABC4339B;
        Thu, 16 Feb 2023 14:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676558123;
        bh=uztuERdBi+ZME82Ls63RsPH7tNHhc39ttuHzQDKz+EI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rj7zfed5o7/NpMhAYNSviQWbh1DOhWAk8Zypyy5Qh9CnZC7ydNyjk1E5kWemgIwuR
         qH9on2OvfHj8/B4Y4arUlI2i4kRxqlpbjEG1oHYRIqS24L0lp2AxxwVeMk3O1OSuHX
         Nzux9xkzg6zXKVnPgsEY+Wy3ryrWFE054FskCbiA57ugRnjBPRHmfcyyumnMQMXnC+
         uQKPrGLa+4mSjasvIYagBqBqNDfYWbqlQ+e4CerUgKjK37lfAwmU+alHqlmZJ8dF5i
         zFulYB70VKKazBCD5jEMbN25nZ7sCQlV/BdrWrNBmFNNmq7CHXJo10B34QWR4A8HuU
         +xAUX5HGa2Piw==
Date:   Thu, 16 Feb 2023 23:35:19 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 2/2] x86/entry: Fix unwinding from kprobe on PUSH/POP
 instruction
Message-Id: <20230216233519.eacdf4166d4ec20f3046a1e2@kernel.org>
In-Reply-To: <Y+4T0EV8SBN09KxA@hirez.programming.kicks-ass.net>
References: <cover.1676068346.git.jpoimboe@kernel.org>
        <baafcd3cc1abb14cb757fe081fa696012a5265ee.1676068346.git.jpoimboe@kernel.org>
        <20230213234357.1fe194b2767d9bc431202d4c@kernel.org>
        <Y+tx6DZyoQ362lUM@hirez.programming.kicks-ass.net>
        <20230214170552.glhdytvunczyxxao@treble>
        <Y+yzMmL7gUprDru3@hirez.programming.kicks-ass.net>
        <20230215231637.laryjsua5p4wcd57@treble>
        <Y+4JhmEGDR16EVpi@hirez.programming.kicks-ass.net>
        <Y+4T0EV8SBN09KxA@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023 12:30:24 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Feb 16, 2023 at 11:46:30AM +0100, Peter Zijlstra wrote:
> > On Wed, Feb 15, 2023 at 03:16:37PM -0800, Josh Poimboeuf wrote:
> > > On Wed, Feb 15, 2023 at 11:25:54AM +0100, Peter Zijlstra wrote:
> > 
> > > > Well, I was specifically thinking about #DB, why don't we need to
> > > > decrement when we put a hardware breakpoint on a stack modifying op?
> > > 
> > > I assume you mean the INT1 instruction.  Yeah, maybe we should care
> > > about that.
> > 
> > Nah, I was thinking #DB from DR7, but ...
> > 
> > > I'm struggling to come up with any decent ideas about how to implement
> > > that.  Presumably the #DB handler would have to communicate to the
> > > unwinder somehow whether the given frame is a trap.
> > 
> > ... I had forgotten that #DB is not unconditionally trap :/ The worst
> > part seems to be that code breakpoints are faults while data breakpoints
> > are traps.
> > 
> > And you so don't want to go decode the DR registers in the unwinder,
> > quality mess this :/
> > 
> > Put a breakpoint on the stack and you've got PUSH doing a trap, put a
> > breakpoint on the PUSH instruction and you get a fault, and lo and
> > behold, you get a different unwind :-(
> 
> It could be I'm just confusing things... when #DB traps it is actually
> because the instruction is complete, so looking up the ORC based on the
> next instruction is correct, while when #DB faults, it is because the
> instruction has not yet completed and again ORC lookup on IP just works.
> 
> So while determining if #DB is trap or fault is a giant pain in the
> arse, it does not actually matter for the unwinder in this case.
> 
> And with the INT3 thing the problem is that we've replaced an
> instruction that was supposed to do a stack op.
> 

If the kprobe checks whether the original instruction do a stack op and
if so, setting a flag on current_kprobe will help unwinder finds that case?

Of course all INT3 user may need to do this but it should be limited.

Thank you, 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
