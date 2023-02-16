Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2676699321
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjBPLaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjBPLax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:30:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6403C79E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 03:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0tv9nEA8m2S6K8/UhiZeHlpixxVHzhHoy3L6P2KNEV8=; b=ipIX1llL46ob2Hqhpi/U7TY7ZR
        r8eQy7TuCDKPi3j76KFDxvAi2q7TbId6BdYR2fFDneUzG/WO/UwhsxqOv0GL/yFOMe6Dxf9opFo7y
        wYcke4Hqo9rY1/TXoToUX9Ko490Beonl0UjiMuc0T8IjRChaEU64k0PN5tej5n3uSp/C3c1zzXYkL
        3bzspdxUh5G5S5cgRBNMgRJCPIaVUNYUDMOlDA/dycK/TbdIkoD0ylXxlb30Qp8sxFeUcaWtnOSXB
        srfQJmjZnp+hccmd4YcfepfaJTdVtW+Gk4jgrS6YdQoDh9DGCwUWaVSq/Kbxm7pzGNN95IWF7mEiG
        t9SS7bng==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pScT5-008Mw8-05; Thu, 16 Feb 2023 11:30:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6C15130056B;
        Thu, 16 Feb 2023 12:30:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1979520CB2A44; Thu, 16 Feb 2023 12:30:24 +0100 (CET)
Date:   Thu, 16 Feb 2023 12:30:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 2/2] x86/entry: Fix unwinding from kprobe on PUSH/POP
 instruction
Message-ID: <Y+4T0EV8SBN09KxA@hirez.programming.kicks-ass.net>
References: <cover.1676068346.git.jpoimboe@kernel.org>
 <baafcd3cc1abb14cb757fe081fa696012a5265ee.1676068346.git.jpoimboe@kernel.org>
 <20230213234357.1fe194b2767d9bc431202d4c@kernel.org>
 <Y+tx6DZyoQ362lUM@hirez.programming.kicks-ass.net>
 <20230214170552.glhdytvunczyxxao@treble>
 <Y+yzMmL7gUprDru3@hirez.programming.kicks-ass.net>
 <20230215231637.laryjsua5p4wcd57@treble>
 <Y+4JhmEGDR16EVpi@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+4JhmEGDR16EVpi@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 11:46:30AM +0100, Peter Zijlstra wrote:
> On Wed, Feb 15, 2023 at 03:16:37PM -0800, Josh Poimboeuf wrote:
> > On Wed, Feb 15, 2023 at 11:25:54AM +0100, Peter Zijlstra wrote:
> 
> > > Well, I was specifically thinking about #DB, why don't we need to
> > > decrement when we put a hardware breakpoint on a stack modifying op?
> > 
> > I assume you mean the INT1 instruction.  Yeah, maybe we should care
> > about that.
> 
> Nah, I was thinking #DB from DR7, but ...
> 
> > I'm struggling to come up with any decent ideas about how to implement
> > that.  Presumably the #DB handler would have to communicate to the
> > unwinder somehow whether the given frame is a trap.
> 
> ... I had forgotten that #DB is not unconditionally trap :/ The worst
> part seems to be that code breakpoints are faults while data breakpoints
> are traps.
> 
> And you so don't want to go decode the DR registers in the unwinder,
> quality mess this :/
> 
> Put a breakpoint on the stack and you've got PUSH doing a trap, put a
> breakpoint on the PUSH instruction and you get a fault, and lo and
> behold, you get a different unwind :-(

It could be I'm just confusing things... when #DB traps it is actually
because the instruction is complete, so looking up the ORC based on the
next instruction is correct, while when #DB faults, it is because the
instruction has not yet completed and again ORC lookup on IP just works.

So while determining if #DB is trap or fault is a giant pain in the
arse, it does not actually matter for the unwinder in this case.

And with the INT3 thing the problem is that we've replaced an
instruction that was supposed to do a stack op.


