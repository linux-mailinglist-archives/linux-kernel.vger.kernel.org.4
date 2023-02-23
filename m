Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F646A0944
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbjBWNCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbjBWNCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:02:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE8F51FBC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iTxPRbBYLeov8/5I76KRAXwCRmegYoWRkoKL8ZUNLs4=; b=KuMaiffMZvd/PjXonoAkFRlbbg
        4PMxJQSO5Q+p/z71seO0BR2ntn9Go+kwEqMyI0mU0ytoD6vkZtQtdR7jCRhMl7nzt/Arhz+xysGYO
        gtuL+whupxGujb/+/Y1jiPmBatcgVdCEEqV706aChMLSYfyQ0ymI/vfNrQBfEHI0W/QRLhI8ezd4y
        Gx2jS/Ua/LbCr96cOMJqegjgo28EPRZXwM6GuKAG/IQhAf8xFC+CwjziVI9gKvvBvc1F0Y/1sEci6
        Ae+q2gg14xAwyuO2s+BnHKvbEYnad0+Phqarcsgmw0+twX/ALpHUrsvqjY22AnbdujZzzxSAsdxny
        Uk3hVx3w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pVBEV-00ENb0-D3; Thu, 23 Feb 2023 13:02:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4104A300446;
        Thu, 23 Feb 2023 14:01:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7E0E2C86C32C; Thu, 23 Feb 2023 14:01:58 +0100 (CET)
Date:   Thu, 23 Feb 2023 14:01:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        stern@rowland.harvard.edu
Subject: Re: [PATCH 1/2] lockdep: lock_set_lock_cmp_fn()
Message-ID: <Y/djxk1q5EiYHFfF@hirez.programming.kicks-ass.net>
References: <20230218032117.2372071-1-kent.overstreet@linux.dev>
 <20230218032117.2372071-2-kent.overstreet@linux.dev>
 <Y/ONLYqVrWPFyboF@hirez.programming.kicks-ass.net>
 <Y/QHn+PecW2n2K5O@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/QHn+PecW2n2K5O@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 06:51:59PM -0500, Kent Overstreet wrote:
> On Mon, Feb 20, 2023 at 04:09:33PM +0100, Peter Zijlstra wrote:
> > which is much simpler to work with. Can we improve on this? Give the
> > cmp_fn an additinoal optional argument of a string pointer or so to fill
> > out with actual details to be printed?
> 
> Here you go, example bcache output:
> 
> Patch is not as pretty as I'd like because not every path that prints a
> lock has held_lock available - but the ones we care about in this
> scenario do.

Right, unavoidable that.

> ============================================
> WARNING: possible recursive locking detected
> 6.2.0-rc8-00003-g7d81e591ca6a-dirty #15 Not tainted
> --------------------------------------------
> kworker/14:3/938 is trying to acquire lock:
> ffff8880143218c8 (&b->lock l=0 0:2803368){++++}-{3:3}, at: bch_btree_node_get.part.0+0x81/0x2b0
> 
> but task is already holding lock:
> ffff8880143de8c8 (&b->lock l=1 1048575:9223372036854775807){++++}-{3:3}, at: __bch_btree_map_nodes+0xea/0x1e0
> and the lock comparison function returns 1:
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&b->lock l=1 1048575:9223372036854775807);
>   lock(&b->lock l=0 0:2803368);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 3 locks held by kworker/14:3/938:
>  #0: ffff888005ea9d38 ((wq_completion)bcache){+.+.}-{0:0}, at: process_one_work+0x1ec/0x530
>  #1: ffff8880098c3e70 ((work_completion)(&cl->work)#3){+.+.}-{0:0}, at: process_one_work+0x1ec/0x530
>  #2: ffff8880143de8c8 (&b->lock l=1 1048575:9223372036854775807){++++}-{3:3}, at: __bch_btree_map_nodes+0xea/0x1e0

Much better indeed. Thanks!

> -- >8 --
> Subject: [PATCH] lockdep: lock_set_print_fn()
> 
> This implements a new interface to lockedp, lock_set_print_fn(), for
> printing additional information about a lock.
> 
> This is intended to be useful with the previous lock_set_cmp_fn(); when
> defininig an ordering for locks of a given type, we'll want to print out
> information about that lock that's relevant for the ordering we defined.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> ---
>  include/linux/lockdep.h       |  3 ++
>  include/linux/lockdep_types.h |  2 +
>  kernel/locking/lockdep.c      | 81 ++++++++++++++++++++++-------------
>  3 files changed, 57 insertions(+), 29 deletions(-)
> 
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 98e0338a74..66d8a5a24e 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -664,10 +664,13 @@ lockdep_rcu_suspicious(const char *file, const int line, const char *s)
>  
>  #ifdef CONFIG_PROVE_LOCKING
>  void lockdep_set_lock_cmp_fn(struct lockdep_map *lock, lock_cmp_fn fn);
> +void lockdep_set_lock_print_fn(struct lockdep_map *lock, lock_print_fn fn);

I would suggest the same as last time; integrate this in the class
setting zoo of functions. If you insiste, please keep it one function
and force print_fn when cmp_fn. We don't want people to skimp out on
this.

Other than that, I don't think this can fully replace subclasses, since
subclasses would allow lock hierarchies with other classes inter-twined,
while this really relies on pure class nesting.

That is:

	A/0
	B
	A/1

is a valid subclass nesting set, but you can't achieve the same with
this.

That said; it does seem like a very useful additional annotation for the
more complex nesting sets.

Thanks!
