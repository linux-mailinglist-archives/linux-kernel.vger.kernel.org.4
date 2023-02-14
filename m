Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77427696860
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjBNPrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjBNPrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:47:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D622629419;
        Tue, 14 Feb 2023 07:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IIwKjaQ6wzECwusGlzN9Vokv8uY84Y+MqFGs6EmmL1s=; b=oeI7KY4LLKVkp+z0Bhx9S4kgCM
        cKllOcbH3HvofGZxIWMF+eUK6moqW1KE0PNtm2sGLXLQZuwE9EUPQTqGObpDLMoTO0Epi0OKnHXyB
        4VsDrjKMCNtB4onCRNNId25v4uBYvzjbNa3qm0OYFrh4vVjXgGTZpeuoaIr8/GjkCPX4o+2yO+wRm
        u+E6RFv5L3nr10sn+3tglIxJgMhiRD5MRD/256pgRrK09cAcewW6D1fDFqz4Q7nCIXqjz2/btmi77
        pspvARfOG5BSUoN1Bt4ki8KpONIyxtgyceKuSpOh+IFozMemAjWMvCmLW4MkXTVIEq4ybicFXkm3V
        CLMJT5rw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRxW7-006c3e-CX; Tue, 14 Feb 2023 15:46:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 87A2D3001CB;
        Tue, 14 Feb 2023 11:48:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D3FC23BDB63F; Tue, 14 Feb 2023 11:48:07 +0100 (CET)
Date:   Tue, 14 Feb 2023 11:48:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Coly Li <colyli@suse.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH RFC] drivers/core: Replace lockdep_set_novalidate_class()
 with unique class keys
Message-ID: <Y+tm59SmBEY1Ywq7@hirez.programming.kicks-ass.net>
References: <Y+gjuqJ5RFxwLmht@moria.home.lan>
 <Y+hRurRwm//1+IcK@rowland.harvard.edu>
 <Y+hTEtCKPuO0zGIt@moria.home.lan>
 <Y+hW74TAVzCpSv7c@rowland.harvard.edu>
 <Y+hYn6uzIUBaxDdV@moria.home.lan>
 <Y+kEgDLSRwdODRdD@rowland.harvard.edu>
 <Y+oBveWO2z6xdTW/@hirez.programming.kicks-ass.net>
 <Y+pWhyFJeE93nlWd@rowland.harvard.edu>
 <Y+plfZnEqw6mG+XH@hirez.programming.kicks-ass.net>
 <Y+rpD7QPheQQ8Lxj@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+rpD7QPheQQ8Lxj@boqun-archlinux>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 05:51:11PM -0800, Boqun Feng wrote:
> On Mon, Feb 13, 2023 at 05:29:49PM +0100, Peter Zijlstra wrote:
> > On Mon, Feb 13, 2023 at 10:25:59AM -0500, Alan Stern wrote:
> > > On Mon, Feb 13, 2023 at 10:24:13AM +0100, Peter Zijlstra wrote:
> > > > On Sun, Feb 12, 2023 at 10:23:44AM -0500, Alan Stern wrote:
> > > > > Provided it acquires the parent device's lock first, this is 
> > > > > utterly safe no matter what order the children are locked in.  Try 
> > > > > telling that to lockdep! 
> > > > 
> > > > mutex_lock_next_lock(child->lock, parent->lock) is there to express this
> > > > exact pattern, it allows taking multiple child->lock class locks (in any
> > > > order) provided parent->lock is held.
> > > 
> > > Ah, this is news to me.  Is this sort of thing documented somewhere?
> 
> Basically if you have two lock instances A and B with the same class,
> and you know that locking ordering is always A -> B, then you can do
> 
> 	mutex_lock(A);
> 	mutex_lock_nest_lock(B, A); // lock B.
> 

No, this isn't quite right, You need at least 3 locks and 2 classes.

P, C1, C2

Then:

	mutex_lock(P)
	mutex_lock_next_lock(C1, P)
	mutex_lock_next_lock(C2, P)

And it will accept any order of Cn -- since it assumes that any
multi-lock of Cn will always hold P, therefore the ordering fully given
by P.
