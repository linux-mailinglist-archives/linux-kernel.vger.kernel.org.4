Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C975C0492
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiIUQsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiIUQrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:47:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A857C768;
        Wed, 21 Sep 2022 09:40:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1A2ED21AFE;
        Wed, 21 Sep 2022 16:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663778413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fQ6I4XtQfJnZQz6LgnGLVxz3Ncndyjiosk1VIoApvwk=;
        b=w24u+JpFDcIoCAkC38lNz1SZQ+QkYuCqorfRAeXfIJNwL6LGclCRntunwkv/lw4jNKyMU3
        25ZnoNu5b+yiA56IemgzpshGsoeZV/J+qqg/siLBo4QjB0FspOlPMybQTaa4bynQpB760X
        cVwqHSrA17z29BkWi4XVKOJLixmbIas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663778413;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fQ6I4XtQfJnZQz6LgnGLVxz3Ncndyjiosk1VIoApvwk=;
        b=O+9jPD4kOL9kiQQ9sn/HiPptrqTeTxmKZb7KpObGPDIHopND+eGYJ/ulCWHsEW9oEeZgPJ
        pJv8NS2gz73xqkCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F05E513A89;
        Wed, 21 Sep 2022 16:40:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9iehOmw+K2NtDgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 21 Sep 2022 16:40:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5258BA0684; Wed, 21 Sep 2022 18:40:12 +0200 (CEST)
Date:   Wed, 21 Sep 2022 18:40:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Yu Kuai <yukuai1@huaweicloud.com>, Jan Kara <jack@suse.cz>,
        Liu Song <liusong@linux.alibaba.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] sbitmap: fix lockup while swapping
Message-ID: <20220921164012.s7lvklp2qk6occcg@quack3>
References: <aef9de29-e9f5-259a-f8be-12d1b734e72@google.com>
 <YyjdiKC0YYUkI+AI@kbusch-mbp>
 <f2d130d2-f3af-d09d-6fd7-10da28d26ba9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2d130d2-f3af-d09d-6fd7-10da28d26ba9@google.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 19-09-22 16:01:39, Hugh Dickins wrote:
> On Mon, 19 Sep 2022, Keith Busch wrote:
> > On Sun, Sep 18, 2022 at 02:10:51PM -0700, Hugh Dickins wrote:
> > > I have almost no grasp of all the possible sbitmap races, and their
> > > consequences: but using the same !waitqueue_active() check as used
> > > elsewhere, fixes the lockup and shows no adverse consequence for me.
> > 
> >  
> > > Fixes: 4acb83417cad ("sbitmap: fix batched wait_cnt accounting")
> > > Signed-off-by: Hugh Dickins <hughd@google.com>
> > > ---
> > > 
> > >  lib/sbitmap.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > --- a/lib/sbitmap.c
> > > +++ b/lib/sbitmap.c
> > > @@ -620,7 +620,7 @@ static bool __sbq_wake_up(struct sbitmap
> > >  		 * function again to wakeup a new batch on a different 'ws'.
> > >  		 */
> > >  		if (cur == 0)
> > > -			return true;
> > > +			return !waitqueue_active(&ws->wait);
> > 
> > If it's 0, that is supposed to mean another thread is about to make it not zero
> > as well as increment the wakestate index. That should be happening after patch
> > 48c033314f37 was included, at least.
> 
> I believe that the thread about to make wait_cnt not zero (and increment the
> wakestate index) is precisely this interrupted thread: the backtrace shows
> that it had just done its wakeups, so has not yet reached making wait_cnt
> not zero; and I suppose that either its wakeups did not empty the waitqueue
> completely, or another waiter got added as soon as it dropped the spinlock.
> 
> > 
> > Prior to 4acb83417cad, the code would also return 'true' if the count was
> > already zero, and this batched code wasn't supposed to behave any different in
> > that condition.
> 
> In principle yes, but in practice no.  Prior to 4acb83417cad, the swapping
> load would run okayish for a few minutes, before freezing up mysteriously
> (presumably due to missed wakeups).  The "ish" in "okayish" because the
> system time was abnormally high, and occasionally there was an odd message
> from systemd about killing its journal or something - 4acb83417cad saved
> me from having to investigate that further.
> 
> Prior to 4acb83417cad, it never locked up looping on wait_cnt < 0;
> after 4acb83417cad, it would lock up on wait_cnt 0 in a few seconds.
> 
> But in writing that, and remembering the abnormal systime, I begin to
> suspect that it might have often been in a tight loop on wait_cnt < 0,
> but the batch accounting sufficiently wrong that it always got rescued
> by an unrelated wakeup (shifting wakestate index), before any lockup
> ever got observed and reported.  Or something like that.
> 
> (And I'm trying to avoid making a fool of myself with the arithmetic:
> how quickly would wait_cnt 0 have got decremented to positive before?)
> 
> I won't mind Jens deleting that "Fixes: 4acb83417cad" if it's unfair.
> 
> > 
> > Anyway, I don't think the waitqueue_active criteria of the current waitstate is
> > correct either. The next waitstate may have waiters too, so we still may need
> > to account for this batch's count in order to wake them.
> 
> I cannot usefully comment on that, it's all rather too subtle for me.
> 
> But I did wonder if each of those !waitqueue_active()s would be better
> replaced just by "false"s: we only get that far into __sbq_wake_up() if
> waitqueue_active(), so the !waitqueue_active() case reflects a race:
> a possible race, yes, but a race that wants precise accounting at a
> few imprecise locations?

I think the code is actually too subtle and complex for anybody to sensibly
reason about it (as the continuous stream of bugs demostrates ;)). That
being said I agree with Keith that your "fix" looks suspicious and it is
not how things are expected to work and we can possibly loose wakeups with
your change. So we need to understand better how the code can be looping on
your system. I'll think more about it tomorrow...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
