Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5F15EBFC9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiI0Kb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiI0Kb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:31:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30D732BB8;
        Tue, 27 Sep 2022 03:31:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A0E021F8EF;
        Tue, 27 Sep 2022 10:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664274684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WQeqxJpFXOffljI+erBl+eKEoj5m7jMkx7sJN3gl0Ys=;
        b=OGW+jykfyd9xyK/mjVbtQ7SDndUMikKv1DMIWtjHGqSfiXXJxkbLtDPLslS06NjbIR5A8Z
        V7kB8ii0BwtibLnxIzqLH4HnI4d70xSXNb9dhzO3OXfl1Bh+vOJ9ehzPs5bEqAfBk5GLe6
        4wUrorblErAjtU9RO0DOJUZJuK6Xzj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664274684;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WQeqxJpFXOffljI+erBl+eKEoj5m7jMkx7sJN3gl0Ys=;
        b=P1gIiuP9faZ47mQgkN3hzYCEPGcELvpeqZs/fKeX7zi8EauKhn8LLSXf+3bxdanSbD8eFE
        n8t7Aw5RfRQWOhBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91BEB139B3;
        Tue, 27 Sep 2022 10:31:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 55+QI/zQMmMbUAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 27 Sep 2022 10:31:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BDF61A0685; Tue, 27 Sep 2022 12:31:23 +0200 (CEST)
Date:   Tue, 27 Sep 2022 12:31:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Jan Kara <jack@suse.cz>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Liu Song <liusong@linux.alibaba.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] sbitmap: fix lockup while swapping
Message-ID: <20220927103123.cvjbdx6lqv7jxa2w@quack3>
References: <YyjdiKC0YYUkI+AI@kbusch-mbp>
 <f2d130d2-f3af-d09d-6fd7-10da28d26ba9@google.com>
 <20220921164012.s7lvklp2qk6occcg@quack3>
 <20220923144303.fywkmgnkg6eken4x@quack3>
 <d83885c9-2635-ef45-2ccc-a7e06421e1cc@google.com>
 <Yy4D54kPpenBkjHz@kbusch-mbp.dhcp.thefacebook.com>
 <391b1763-7146-857-e3b6-dc2a8e797162@google.com>
 <929a3aba-72b0-5e-5b80-824a2b7f5dc7@google.com>
 <20220926114416.t7t65u66ze76aiz7@quack3>
 <4539e48-417-edae-d42-9ef84602af0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4539e48-417-edae-d42-9ef84602af0@google.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 26-09-22 20:39:03, Hugh Dickins wrote:
> On Mon, 26 Sep 2022, Jan Kara wrote:
> > On Fri 23-09-22 16:15:29, Hugh Dickins wrote:
> > 
> > I don't think any magic with sbq_index_atomic_inc() is going to reliably
> > fix this. After all the current waitqueue may be the only one that has active
> > waiters so sbq_wake_ptr() will always end up returning this waitqueue
> > regardless of the current value of sbq->wake_index.
> > 
> > Honestly, this whole code needs a serious redesign.
> 
> I was pleased to see you say so, Jan: I do agree.
> 
> > I have some
> > simplifications in mind but it will take some thinking and benchmarking
> 
> I'm definitely not the right person to take it on, and glad if you can.
> But I did have some thoughts and experiments over the weekend, and would
> like to throw a couple of suggestions into the pot.
> 
> One, not a big issue, but I think sbq_index_atomic_inc() is misconceived.
> It's unhelpful for multiple racers to be adjusting sbq->wake_index, and
> 	wake_index = ws - sbq->ws;
> 	atomic_cmpxchg(&sbq->wake_index, wake_index, sbq_index_inc(wake_index));
> seems to me a better way for __sbq_wake_up() to increment it.

So my thinking was that instead of having multiple counters, we'd have just
two - one counting completions and the other one counting wakeups and if
completions - wakeups > batch, we search for waiters in the wait queues,
wake them up so that 'wakeups' counter catches up. That also kind of
alleviates the 'wake_index' issue because racing updates to it will lead to
reordering of wakeups but not to lost wakeups, retries, or anything.

I also agree with your wake_up_nr_return() idea below, that is part of this
solution (reliably waking given number of waiters) and in fact I have
already coded that yesterday while thinking about the problem ;)

> Two, and here the depths of my naivete and incomprehension may be on
> display, but: I get the impression that __sbq_wake_up() is intended
> to accumulate wake_batch-1 wakeups while doing nothing, then on the
> wake_batch'th it hopes to do all those wake_batch wakeups.

Correct. That is the idea of this code as far as I understand it as well
(but bear in mind that I'm digging into this code for only about 50 days
longer than you ;).

> I assume someone in the past has established that that's a safe way to
> procede here, though it's not obviously safe to me.

Yes, it is not obvious and even not universally safe. wake_batch has to be
suitably tuned based on the number of available bits in the bitmap to avoid
deadlocks (freeing of a bit is what generates a wakeup). For numbers of
bits smaller than the number of waitqueues we have, we are using wake_batch
== 1, which is obviously safe. As the number of bits grows larger we can
set wake batch as wake_batch =~ bits/waitqueues. That makes sure all the
waitqueues will be woken up and because new waiters are added only when all
bits are used, this even makes sure all waiters will eventually wake up as
the bits get used / freed. I won't comment on fairness, that has apparently
not been a design consideration.

> Now, those !waitqueue_active(&ws->wait) checks are good for catching
> when the hoped-for procedure has gone so "wrong" that there's actually
> nothing to be woken on this ws (so proceed to the next); but they give
> no clue as to when there are some but not enough wakeups done.
> 
> It is very easy to add a wake_up_nr_return() to kernel/sched/wait.c,
> which returns the nr_exclusive still not woken (__wake_up_common_lock()
> merely has to return nr_exclusive itself); and then __sbq_wake_up() can
> be recalled until wake_batch have been woken (or all queues empty).

Fully agreed about this. I'd just note that the waitqueue_active() checks
are enough for the above reasoning to guarantee waking all the wait queues
in principle. They just break down if multiple processes want to wakeup on
the same waitqueue because of TTCTTU races. And that was the last straw
that made me go with wake_up_nr_return() as you describe it.

> I do have an experiment running that way: but my testing is much too
> limited to draw serious conclusions from, and I've already admitted
> that I may just be misunderstanding the whole thing.  But, just maybe,
> a wake_up_nr_return() might be useful.  End of those suggestions.
> 
> > so
> > we need some fix for the interim. I was pondering for quite some time about
> > some band aid to the problem you've found but didn't find anything
> > satisfactory.
> > 
> > In the end I see two options: 
> > 
> > 1) Take your patch (as wrong as it is ;). Yes, it can lead to lost wakeups
> > but we were living with those for a relatively long time so probably we can
> > live with them for some longer.
> 
> In getting that experiment above going, I did have to make this change
> below: and it looks to me now as better than my original patch - since
> this one does try all SBQ_WAIT_QUEUES before giving up, whereas my first
> patch immediately gave up on the waitqueue_active !wait_cnt case.
> 
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -587,7 +587,7 @@ static struct sbq_wait_state *sbq_wake_p
>  	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
>  		struct sbq_wait_state *ws = &sbq->ws[wake_index];
>  
> -		if (waitqueue_active(&ws->wait)) {
> +		if (waitqueue_active(&ws->wait) && atomic_read(&ws->wait_cnt)) {
>  			if (wake_index != atomic_read(&sbq->wake_index))
>  				atomic_set(&sbq->wake_index, wake_index);
>  			return ws;
> 
> TBH I have not tested this one outside of that experiment: would you
> prefer this patch to my first one, I test and sign this off and send?

Yes, actually this is an elegant solution. It has the same inherent
raciness as your waitqueue_active() patch so wakeups could be lost even
though some waiters need them but that seems pretty unlikely. So yes, if
you can submit this, I guess this is a good band aid for the coming merge
window.

> > 2) Revert Yu Kuai's original fix 040b83fcecfb8 ("sbitmap: fix possible io
> > hung due to lost wakeup") and my fixup 48c033314f37 ("sbitmap: Avoid leaving
> > waitqueue in invalid state in __sbq_wake_up()"). But then Keith would have
> > to redo his batched accounting patches on top.
> 
> I know much too little to help make that choice.

Yeah, I guess it is Jens' call in the end. I'm fine with both options.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
