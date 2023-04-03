Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26C26D3ED2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjDCIV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjDCIVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:21:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117ABCDE2;
        Mon,  3 Apr 2023 01:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ru1UgQqnTK+cQyfSkbKek3qx1F4WSiaJst22Mg2vr8w=; b=N1y7Mh1CxXBC4aH0v11HS9q7is
        36O/d/KpyFhL5QqxzCUDy/0bghg1IX+jcMrHB77HlLY3QS5DT5BKX5tBeLeZ8mP6M+4BDHRW+uu6w
        Q5ILrJNnXVVYJRb+cyoZE09OuUmowZed1UCtWurTXdgy4YET+aLkZ4GJfgQlz9JM+xNejg/rSPrT5
        BukT1JUwKKAi9Iav4GUf29edXzj/LG4P6SwOgPoyHmNF8XTxj4FKcYQS+ZFQJ8XC9hbgisq36Ahh5
        wCMtl6AbQErnc1Y9DcISxL8TzOl9M8cTvTRZyXSsvL5KWfeWhOgN/hDWM/xtpn9uwTzeTj1EVSBgP
        Sfh1rLvQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjFQs-008nSZ-1v;
        Mon, 03 Apr 2023 08:20:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5C03A300202;
        Mon,  3 Apr 2023 10:20:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 14C812421CE74; Mon,  3 Apr 2023 10:20:52 +0200 (CEST)
Date:   Mon, 3 Apr 2023 10:20:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 03/13] rust: lock: introduce `Mutex`
Message-ID: <20230403082052.GR4253@hirez.programming.kicks-ass.net>
References: <20230330043954.562237-1-wedsonaf@gmail.com>
 <20230330043954.562237-3-wedsonaf@gmail.com>
 <20230330130108.GE124812@hirez.programming.kicks-ass.net>
 <ZCXZMNj7aOKbC7Ev@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCXZMNj7aOKbC7Ev@boqun-archlinux>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 11:47:12AM -0700, Boqun Feng wrote:
> On Thu, Mar 30, 2023 at 03:01:08PM +0200, Peter Zijlstra wrote:
> > On Thu, Mar 30, 2023 at 01:39:44AM -0300, Wedson Almeida Filho wrote:
> > > From: Wedson Almeida Filho <walmeida@microsoft.com>
> > > 
> > > This is the `struct mutex` lock backend and allows Rust code to use the
> > > kernel mutex idiomatically.
> > 
> > What, if anything, are the plans to support the various lockdep
> > annotations? Idem for the spinlock thing in the other patch I suppose.
> 
> FWIW:
> 
> *	At the init stage, SpinLock and Mutex in Rust use initializers
> 	that are aware of the lockdep, so everything (lockdep_map and
> 	lock_class) is all set up.
> 
> *	At acquire or release time, Rust locks just use ffi to call C
> 	functions that have lockdep annotations in them, so lockdep
> 	should just work.
> 

ffi is what the C++ world calls RAII ?

But yes, I got that far, but I wondered about things like
spin_lock_nested(&foo, SINGLE_DEPTH_NESTING) and other such 'advanced'
annotations.

Surely we're going to be needing them at some point. I suppose you can
do the single depth nesting one with a special guard type (or whatever
you call that in the rust world) ?
