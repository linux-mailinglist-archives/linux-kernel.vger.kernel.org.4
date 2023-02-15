Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA9E6979D1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjBOK0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjBOK0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:26:20 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936A4EC6C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 02:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ne0XmoBJG2lLW8PGmzZtfoJ7ASDmLGGY2i9olcAswLM=; b=GgbUYMxpWr3xih1hcPWHt8NnoE
        mheIGoIgZhQCWTiLiJccjp9jsjwl1DLSwuz0VOJmX+Sf/OnAxAzG83aVvoKpT+Z+pWq8rAikh2u1W
        KgH07sCqewWktZduZ/6lI75kKeYHQBeP3sog2xV0J4cM4jNpzkUla7TKP8o1Psb+GIwnnM9roHeQm
        A5kpRhxna3mwvuTD7tZ0uVACKwJsfc9PDnTMX1aJN7qKhOGQiqBrR9fw99zVcHqBa5RVDZhEy0Ce4
        nXjAXokMhbZqQcj2EGEnpNsVCPCItKxGARHwNf3t4aPTNCBF2MoB9+I9HhF+GfgxgSgW9+Jb6bRXr
        DE+FHoLA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pSEyQ-009uoH-0C;
        Wed, 15 Feb 2023 10:25:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C773A3003E1;
        Wed, 15 Feb 2023 11:25:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5FF12213E4766; Wed, 15 Feb 2023 11:25:54 +0100 (CET)
Date:   Wed, 15 Feb 2023 11:25:54 +0100
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
Message-ID: <Y+yzMmL7gUprDru3@hirez.programming.kicks-ass.net>
References: <cover.1676068346.git.jpoimboe@kernel.org>
 <baafcd3cc1abb14cb757fe081fa696012a5265ee.1676068346.git.jpoimboe@kernel.org>
 <20230213234357.1fe194b2767d9bc431202d4c@kernel.org>
 <Y+tx6DZyoQ362lUM@hirez.programming.kicks-ass.net>
 <20230214170552.glhdytvunczyxxao@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214170552.glhdytvunczyxxao@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 09:05:52AM -0800, Josh Poimboeuf wrote:
> On Tue, Feb 14, 2023 at 12:35:04PM +0100, Peter Zijlstra wrote:
> > On Mon, Feb 13, 2023 at 11:43:57PM +0900, Masami Hiramatsu wrote:
> > 
> > > > Fix it by annotating the #BP exception as a non-signal stack frame,
> > > > which tells the ORC unwinder to decrement the instruction pointer before
> > > > looking up the corresponding ORC entry.
> > > 
> > > Just to make it clear, this sounds like a 'hack' use of non-signal stack
> > > frame. If so, can we change the flag name as 'literal' or 'non-literal' etc?
> > > I concern that the 'signal' flag is used differently in the future.
> 
> Agreed, though I'm having trouble coming up with a succinct yet
> scrutable name.  If length wasn't an issue it would be something like
> 
>   "decrement_return_address_when_looking_up_the_next_orc_entry"
> 
> > Oooh, bike-shed :-) Let me suggest trap=1, where a trap is a fault with
> > a different return address, specifically the instruction after the
> > faulting instruction.
> 
> I think "trap" doesn't work because
> 
>  1) It's more than just traps, it's also function calls.  We have
>     traps/calls in one bucket (decrement IP); and everything else
>     (faults, aborts, irqs) in the other (don't decrement IP).
> 
>  2) It's not necessarily all traps which need the flag, just those that
>     affect a previously-but-now-overwritten stack-modifying instruction.
>     So #OF (which we don't use?) and trap-class #DB don't seem to be
>     affected.  In practice maybe this distinction doesn't matter, but
>     for example there's no reason for ORC try to distinguish trap #DB
>     from non-trap #DB at runtime.

Well, I was specifically thinking about #DB, why don't we need to
decrement when we put a hardware breakpoint on a stack modifying op?
