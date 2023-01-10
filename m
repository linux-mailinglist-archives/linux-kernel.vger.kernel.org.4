Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6739664E59
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjAJVyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjAJVyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:54:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F95DF89;
        Tue, 10 Jan 2023 13:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6plIPH8q9vzdITA82ASBFJ0eHrxSExO14Sl0/pAdaRI=; b=fJAmMhamBtekMM+h1QJMrul21z
        Fd0AFvwCPpOSvOj4drRVTxskDcFDX2QajWrUpxMifpvVcz0/AUBmxFf67SApSYoEPBtAUm7wFgf8J
        9ybNKgTNiC3BTEm93s+Vd6C0MKiPz7jgYOXGT1eN0v/71pISf+gzAh8WkC5OBnwGIqq2ETuy5z8ew
        6SXFgBC03CcfQQAgHgULO8xfu1JNS6PAgYxxBwleWBuoZganYhYVdtrNKpBrlqJJcM2OR8pwnc/T7
        OD3v7q+/UIrRkM3TDU3SWL65ouRTP4OjPY6p+QOWLOIxyeHKaykpkbJ8TyKj8kLhida9QqKnmobdT
        PYz2zOCw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFMa1-003Yvd-5r; Tue, 10 Jan 2023 21:54:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AEE76300327;
        Tue, 10 Jan 2023 22:54:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 68F8A2B58D074; Tue, 10 Jan 2023 22:54:35 +0100 (CET)
Date:   Tue, 10 Jan 2023 22:54:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/7] rust: sync: add `Arc` for ref-counted allocations
Message-ID: <Y73em8F0zNzUbUfg@hirez.programming.kicks-ass.net>
References: <20221228060346.352362-1-wedsonaf@gmail.com>
 <Y73JF1rvF/No/JRi@boqun-archlinux>
 <Y73WsvEEIS0jHlVb@hirez.programming.kicks-ass.net>
 <Y73aWaJ8gVHsG/Uq@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y73aWaJ8gVHsG/Uq@boqun-archlinux>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 01:36:25PM -0800, Boqun Feng wrote:
> On Tue, Jan 10, 2023 at 10:20:50PM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 10, 2023 at 12:22:47PM -0800, Boqun Feng wrote:
> > 
> > > First, I'd really appreciate it that Will, Peter or Mark can take a look
> > > at the series and see if they are happy or not ;-)
> > 
> > I only have 1 patch, and since I don't speak rust I have very limited
> > feedback. Having to use out-of-line functions seems sub-optimal, but
> > I suppose that's a limitation of the Rust-C bindings.
> > 
> > Afaict this is like C++ shared_ptr<> and using refcount_t seems okay for
> > that, not sure what else you're asking.
> > 
> 
> Thanks! I failed to find that you were only Cc for the first patch.. I
> cannot speak for Wedson, but the rest of the patchset are all based on
> the first patch and purely in Rust, maybe he was avoiding to "spam" your
> inbox ;-)
> 
> While we are at it, for a general case, say we provide Rust's interface
> of task/kthread managament, do you prefer to seeing the whole patchset
> (including how Rust side provides the APIs) or seeing only the patch
> that interacts with C?
> 
> Again, trying to find the sweet spot for collaboration ;-)

Always all patches. The more effort I need to do to find sometihng the
smaller the chance I will. Also, I get so much email, I've long since
given up on reading it all.
