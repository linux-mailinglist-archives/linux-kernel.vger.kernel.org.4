Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9D35E7D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbiIWOnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbiIWOnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:43:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53530143280;
        Fri, 23 Sep 2022 07:43:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B8233219F6;
        Fri, 23 Sep 2022 14:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663944183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3eRIeqJ35bjBaxEIVHyjl5HzJmU8eUg6UuiOKVVDhfI=;
        b=pjBYBvVquyKzp9m/dCfmi5ulC/6lWsIX/9ZYV8ku+G07BvI2orRR6wcvN3rJlD54BThb0V
        TPnLhu0D9cr0KZZ7TjMunkwpvmTkrAd3cKB9kuPUg3qug7CbB5bm2HM7Q6qnBUH7CbzSbg
        BFibh786yP7q2BPSvJOSXGz4Yr8GuwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663944183;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3eRIeqJ35bjBaxEIVHyjl5HzJmU8eUg6UuiOKVVDhfI=;
        b=BqksOAX4xO6kfjd1zqXmCr3Qb02d8iX6p3pHkpUHPMJQR84+hdETfPOPNtr+82WUJV5deM
        rHwtczfMmOIi3nBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A903E13A00;
        Fri, 23 Sep 2022 14:43:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TI87KffFLWPOKwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 23 Sep 2022 14:43:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3415CA0685; Fri, 23 Sep 2022 16:43:03 +0200 (CEST)
Date:   Fri, 23 Sep 2022 16:43:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Yu Kuai <yukuai1@huaweicloud.com>, Jan Kara <jack@suse.cz>,
        Liu Song <liusong@linux.alibaba.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] sbitmap: fix lockup while swapping
Message-ID: <20220923144303.fywkmgnkg6eken4x@quack3>
References: <aef9de29-e9f5-259a-f8be-12d1b734e72@google.com>
 <YyjdiKC0YYUkI+AI@kbusch-mbp>
 <f2d130d2-f3af-d09d-6fd7-10da28d26ba9@google.com>
 <20220921164012.s7lvklp2qk6occcg@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921164012.s7lvklp2qk6occcg@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-09-22 18:40:12, Jan Kara wrote:
> On Mon 19-09-22 16:01:39, Hugh Dickins wrote:
> > On Mon, 19 Sep 2022, Keith Busch wrote:
> > > On Sun, Sep 18, 2022 at 02:10:51PM -0700, Hugh Dickins wrote:
> > > > I have almost no grasp of all the possible sbitmap races, and their
> > > > consequences: but using the same !waitqueue_active() check as used
> > > > elsewhere, fixes the lockup and shows no adverse consequence for me.
> > > 
> > >  
> > > > Fixes: 4acb83417cad ("sbitmap: fix batched wait_cnt accounting")
> > > > Signed-off-by: Hugh Dickins <hughd@google.com>
> > > > ---
> > > > 
> > > >  lib/sbitmap.c |    2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > --- a/lib/sbitmap.c
> > > > +++ b/lib/sbitmap.c
> > > > @@ -620,7 +620,7 @@ static bool __sbq_wake_up(struct sbitmap
> > > >  		 * function again to wakeup a new batch on a different 'ws'.
> > > >  		 */
> > > >  		if (cur == 0)
> > > > -			return true;
> > > > +			return !waitqueue_active(&ws->wait);
> > > 
> > > If it's 0, that is supposed to mean another thread is about to make it not zero
> > > as well as increment the wakestate index. That should be happening after patch
> > > 48c033314f37 was included, at least.
> > 
> > I believe that the thread about to make wait_cnt not zero (and increment the
> > wakestate index) is precisely this interrupted thread: the backtrace shows
> > that it had just done its wakeups, so has not yet reached making wait_cnt
> > not zero; and I suppose that either its wakeups did not empty the waitqueue
> > completely, or another waiter got added as soon as it dropped the spinlock.

I was trying to wrap my head around this but I am failing to see how we
could have wait_cnt == 0 for long enough to cause any kind of stall let
alone a lockup in sbitmap_queue_wake_up() as you describe. I can understand
we have:

CPU1						CPU2
sbitmap_queue_wake_up()
  ws = sbq_wake_ptr(sbq);
  cur = atomic_read(&ws->wait_cnt);
  do {
	...
	wait_cnt = cur - sub;	/* this will be 0 */
  } while (!atomic_try_cmpxchg(&ws->wait_cnt, &cur, wait_cnt));
  ...
						/* Gets the same waitqueue */
						ws = sbq_wake_ptr(sbq);
						cur = atomic_read(&ws->wait_cnt);
						do {
							if (cur == 0)
								return true; /* loop */
  wake_up_nr(&ws->wait, wake_batch);
  smp_mb__before_atomic();
  sbq_index_atomic_inc(&sbq->wake_index);
  atomic_set(&ws->wait_cnt, wake_batch); /* This stops looping on CPU2 */

So until CPU1 reaches the atomic_set(), CPU2 can be looping. But how come
this takes so long that is causes a hang as you describe? Hum... So either
CPU1 takes really long to get to atomic_set():
- can CPU1 get preempted? Likely not at least in the context you show in
  your message
- can CPU1 spend so long in wake_up_nr()? Maybe the waitqueue lock is
  contended but still...

or CPU2 somehow sees cur==0 for longer than it should. The whole sequence
executed in a loop on CPU2 does not contain anything that would force CPU2
to refresh its cache and get new ws->wait_cnt value so we are at the mercy
of CPU cache coherency mechanisms to stage the write on CPU1 and propagate
it to other CPUs. But still I would not expect that to take significantly
long. Any other ideas?
 
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
