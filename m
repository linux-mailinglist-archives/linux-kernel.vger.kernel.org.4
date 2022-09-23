Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121725E7E01
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiIWPN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbiIWPNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:13:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DDD139416;
        Fri, 23 Sep 2022 08:13:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33815B83878;
        Fri, 23 Sep 2022 15:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A284C433D6;
        Fri, 23 Sep 2022 15:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663946024;
        bh=2RNZetd/4AvNkNba7S23VtdxTbdmnfkmLDgpHZQ1mlk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fEeiCm6+H4K9yHE6bpGVDvz73LlaBsUZx6yBOUnULi9LhTLTE+iW3Ixa+udXjKurU
         hOJ8dQkNCGURJmollBx+6FUQcp7Waq52Ud+5eJxPIzWR1PwVZvlm92vRV7pnEZyxvn
         mLV1kbb0cDnRLCMv6g5jow2qLeR7QdrE4ij5tIHlQ6+Hkx3Yw6w9f5JPExTMcCj3+w
         AireuUgkBrN0IrhTE2BcfyolhlPtlkkf81dK0mN3AG18jJmN5tFMayayg9Iqhr2NCj
         j2wmLI7+nDTMoON0MlRgf3fNNdEa96FfBswaY7CCzVmwiAhKnE75gzKOXWPGy9A6Qo
         jb1FC2n4EegmQ==
Date:   Fri, 23 Sep 2022 09:13:40 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Hugh Dickins <hughd@google.com>, Jens Axboe <axboe@kernel.dk>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Liu Song <liusong@linux.alibaba.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] sbitmap: fix lockup while swapping
Message-ID: <Yy3NJFmdxclHTKs3@kbusch-mbp.dhcp.thefacebook.com>
References: <aef9de29-e9f5-259a-f8be-12d1b734e72@google.com>
 <YyjdiKC0YYUkI+AI@kbusch-mbp>
 <f2d130d2-f3af-d09d-6fd7-10da28d26ba9@google.com>
 <20220921164012.s7lvklp2qk6occcg@quack3>
 <20220923144303.fywkmgnkg6eken4x@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923144303.fywkmgnkg6eken4x@quack3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 04:43:03PM +0200, Jan Kara wrote:
> On Wed 21-09-22 18:40:12, Jan Kara wrote:
> > On Mon 19-09-22 16:01:39, Hugh Dickins wrote:
> > > On Mon, 19 Sep 2022, Keith Busch wrote:
> > > > On Sun, Sep 18, 2022 at 02:10:51PM -0700, Hugh Dickins wrote:
> > > > > I have almost no grasp of all the possible sbitmap races, and their
> > > > > consequences: but using the same !waitqueue_active() check as used
> > > > > elsewhere, fixes the lockup and shows no adverse consequence for me.
> > > > 
> > > >  
> > > > > Fixes: 4acb83417cad ("sbitmap: fix batched wait_cnt accounting")
> > > > > Signed-off-by: Hugh Dickins <hughd@google.com>
> > > > > ---
> > > > > 
> > > > >  lib/sbitmap.c |    2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > --- a/lib/sbitmap.c
> > > > > +++ b/lib/sbitmap.c
> > > > > @@ -620,7 +620,7 @@ static bool __sbq_wake_up(struct sbitmap
> > > > >  		 * function again to wakeup a new batch on a different 'ws'.
> > > > >  		 */
> > > > >  		if (cur == 0)
> > > > > -			return true;
> > > > > +			return !waitqueue_active(&ws->wait);
> > > > 
> > > > If it's 0, that is supposed to mean another thread is about to make it not zero
> > > > as well as increment the wakestate index. That should be happening after patch
> > > > 48c033314f37 was included, at least.
> > > 
> > > I believe that the thread about to make wait_cnt not zero (and increment the
> > > wakestate index) is precisely this interrupted thread: the backtrace shows
> > > that it had just done its wakeups, so has not yet reached making wait_cnt
> > > not zero; and I suppose that either its wakeups did not empty the waitqueue
> > > completely, or another waiter got added as soon as it dropped the spinlock.
> 
> I was trying to wrap my head around this but I am failing to see how we
> could have wait_cnt == 0 for long enough to cause any kind of stall let
> alone a lockup in sbitmap_queue_wake_up() as you describe. I can understand
> we have:
> 
> CPU1						CPU2
> sbitmap_queue_wake_up()
>   ws = sbq_wake_ptr(sbq);
>   cur = atomic_read(&ws->wait_cnt);
>   do {
> 	...
> 	wait_cnt = cur - sub;	/* this will be 0 */
>   } while (!atomic_try_cmpxchg(&ws->wait_cnt, &cur, wait_cnt));
>   ...
> 						/* Gets the same waitqueue */
> 						ws = sbq_wake_ptr(sbq);
> 						cur = atomic_read(&ws->wait_cnt);
> 						do {
> 							if (cur == 0)
> 								return true; /* loop */
>   wake_up_nr(&ws->wait, wake_batch);
>   smp_mb__before_atomic();
>   sbq_index_atomic_inc(&sbq->wake_index);
>   atomic_set(&ws->wait_cnt, wake_batch); /* This stops looping on CPU2 */
> 
> So until CPU1 reaches the atomic_set(), CPU2 can be looping. But how come
> this takes so long that is causes a hang as you describe? Hum... So either
> CPU1 takes really long to get to atomic_set():
> - can CPU1 get preempted? Likely not at least in the context you show in
>   your message
> - can CPU1 spend so long in wake_up_nr()? Maybe the waitqueue lock is
>   contended but still...
> 
> or CPU2 somehow sees cur==0 for longer than it should. The whole sequence
> executed in a loop on CPU2 does not contain anything that would force CPU2
> to refresh its cache and get new ws->wait_cnt value so we are at the mercy
> of CPU cache coherency mechanisms to stage the write on CPU1 and propagate
> it to other CPUs. But still I would not expect that to take significantly
> long. Any other ideas?

Thank you for the analysis. I arrived at the same conclusions.

If this is a preempt enabled context, and there's just one CPU, I suppose the
2nd task could spin in the while(), blocking the 1st task from resetting the
wait_cnt. I doubt that's happening though, at least for nvme where we call this
function in irq context.
