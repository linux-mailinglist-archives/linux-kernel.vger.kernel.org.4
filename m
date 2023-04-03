Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345986D3F9C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjDCJA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjDCJAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:00:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F575CDC4;
        Mon,  3 Apr 2023 02:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=evda/SuAwOIMhD/EDAEOROxMBHIC6v8BvQ+meUe3n+Q=; b=GgBB6OBKxMGzKsYRvT2vCOPV06
        z3QkqxC+8CwokpPcZ8LkMCS5/Ir6IZO/X51iYN8FGMZ/+YzoMH7nYmowSbxghrxkEgcJ0TwjFitvk
        lPJU0SxNzjCws2YL2nEPRtmSdtCEQQwPUdvvBZ88JeG6dXGBQanJw+BCjxUfaENDZrWMihcBzYhFH
        15lree/JtoNSrcHGfmXmlQBwtX3S5AggbpjfObTXcWxKjQ2yJi6B3THx2Fuow2kIllJBlLEsmeb0+
        F/Tiru4/b+bpN0tL6WLSuB5Pr+EWPCobzvwP0PXkkXb0BlP0lKpdWtccMTcC3ytMk+WQm1y5P9PaM
        OYOMl8nA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjG2j-008oBc-08;
        Mon, 03 Apr 2023 09:00:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DF358300338;
        Mon,  3 Apr 2023 10:59:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C0F27285EA717; Mon,  3 Apr 2023 10:59:59 +0200 (CEST)
Date:   Mon, 3 Apr 2023 10:59:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 12/13] rust: sync: introduce `CondVar`
Message-ID: <20230403085959.GS4253@hirez.programming.kicks-ass.net>
References: <20230330043954.562237-1-wedsonaf@gmail.com>
 <20230330043954.562237-12-wedsonaf@gmail.com>
 <20230330125927.GD124812@hirez.programming.kicks-ass.net>
 <ZCWjIaByRHDhdCud@wedsonaf-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCWjIaByRHDhdCud@wedsonaf-dev>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 11:56:33AM -0300, Wedson Almeida Filho wrote:
> On Thu, Mar 30, 2023 at 02:59:27PM +0200, Peter Zijlstra wrote:
> > On Thu, Mar 30, 2023 at 01:39:53AM -0300, Wedson Almeida Filho wrote:
> > 
> > > +    fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, guard: &mut Guard<'_, T, B>) {
> > > +        let wait = Opaque::<bindings::wait_queue_entry>::uninit();
> > > +
> > > +        // SAFETY: `wait` points to valid memory.
> > > +        unsafe { bindings::init_wait(wait.get()) };
> > > +
> > > +        // SAFETY: Both `wait` and `wait_list` point to valid memory.
> > > +        unsafe {
> > > +            bindings::prepare_to_wait_exclusive(self.wait_list.get(), wait.get(), wait_state as _)
> > > +        };
> > 
> > I can't read this rust gunk, but where is the condition test gone?
> > 
> > Also, where is the loop gone to?
> 
> They're both at the caller. The usage of condition variables is something like:
> 
> while guard.value != v {
>     condvar.wait_uninterruptible(&mut guard);
> }
> 
> (Note that this is not specific to the kernel or to Rust: this is how condvars
> work in general. You'll find this in any textbook on the topic.)
> 
> In the implementation of wait_internal(), we add the local wait entry to the
> wait queue _before_ releasing the lock (i.e., before the test result can
> change), so we guarantee that we don't miss wake up attempts.

Ah, so you've not yet been exposed to the wonderful 'feature' where
pthread_cond_timedwait() gets called with .mutex=NULL and people expect
things to just work :/ (luckily not accepted by the majority of
implementations)

Or a little more devious, calling signal and not holding the same mutex.

But then yes, I suppose it should work. I just got alarm bells going off
because I see prepare_to_wait without an obvious loop around it.
