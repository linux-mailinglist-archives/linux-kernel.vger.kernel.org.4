Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253AE5E7F8D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiIWQSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiIWQSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:18:10 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6E8135714
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:17:10 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id d15so388035qka.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date;
        bh=4qxMWjOIpMkOGtLLFe8WhdHhUlkbe7D+rolKd+h+uVk=;
        b=lQQdTR/g32E0O34bdirpXaGLyHEcnk6cCeQel6YdaiOTT/IR8dPFCqfsqKwybbWJZO
         pYFiHhn28GsbJNgLCwSQ36twulPuXMUOVa1lqsN0Ny+L1y3Uover2McV4+6mWQILnaTm
         vYZS/drXJcjnB18YKhwd2uYjnnXExsznxosR0jfQYtXo5tJH3k17CSSeCnnj5o3Sku2m
         6I90c4SN575CRQPhA7zopWvyUZDl106kRLCf6T41hPKKnvK7durJ0vZw6pqWeQ5vURRi
         +pwudMB1EkYloh/r7kGt7/TgzmSOHJo36agtH2yKi74TYibb7ZGMZ8Pj+/4M/2iSDoOJ
         BPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=4qxMWjOIpMkOGtLLFe8WhdHhUlkbe7D+rolKd+h+uVk=;
        b=HtRFx8rYs7ZVtME2mqefiYvPEzoFdxjzJoiFZ54SwiGM8jx3V177+MyiZuoLVPx2E5
         1kRRSd3vqPjEODBoIHNzh9GbsMPZGr+4u+24OHDnvL0VqWff0StLs2GJSFQa2GdbjMc2
         1EDWG3rWTGSwPYy5VjGEjaJ+OrlHI4ZjkZOdaUTI0QvI1h+QSa+fZwRNrwizH+asGiJK
         ORsLhqK1EcyLRjTJyiTVJAqDyfvQH1ExSvCGwDg2v7kSMPUKx/cl/2HJp98A+wroTj0Z
         YAFCcXq8SPdTcgxTAMlK5+XnJRFHUkf1eCq5ouLqoyGIUeMK9mB8vtolA2AzzNqiHVBN
         Nnkg==
X-Gm-Message-State: ACrzQf0G3+3omJUkCzmWJ8gbrWcEvOzoaUu9mwIpbyBqe+ulYqkkJrZS
        RDFYCSLPFrZIg9seZI35ndCaLA/ftZTM1w==
X-Google-Smtp-Source: AMsMyM5ihNn7PNdTw/GoVp4V09U9sYJFPx5Pxro8xvFdOqUvnnUHwcsY7d/b4qmDimwdYHQp8FEq2Q==
X-Received: by 2002:a05:620a:2204:b0:6ce:1589:7deb with SMTP id m4-20020a05620a220400b006ce15897debmr6165868qkh.327.1663949827972;
        Fri, 23 Sep 2022 09:17:07 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w15-20020a05620a424f00b006af0ce13499sm5986159qko.115.2022.09.23.09.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 09:17:07 -0700 (PDT)
Date:   Fri, 23 Sep 2022 09:16:55 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jan Kara <jack@suse.cz>
cc:     Hugh Dickins <hughd@google.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Liu Song <liusong@linux.alibaba.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] sbitmap: fix lockup while swapping
In-Reply-To: <20220923144303.fywkmgnkg6eken4x@quack3>
Message-ID: <d83885c9-2635-ef45-2ccc-a7e06421e1cc@google.com>
References: <aef9de29-e9f5-259a-f8be-12d1b734e72@google.com> <YyjdiKC0YYUkI+AI@kbusch-mbp> <f2d130d2-f3af-d09d-6fd7-10da28d26ba9@google.com> <20220921164012.s7lvklp2qk6occcg@quack3> <20220923144303.fywkmgnkg6eken4x@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2022, Jan Kara wrote:
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

Rushed reply (hoping) to help your thinking,
I'll read you more closely two hours later.

You're writing of CPU1 and CPU2, but in my case it was just the one CPU
interrupted - see again sbitmap_queue_wake_up twice in the backtrace:

sbitmap_queue_wake_up < sbitmap_queue_clear < blk_mq_put_tag <
__blk_mq_free_request < blk_mq_free_request < __blk_mq_end_request <
scsi_end_request < scsi_io_completion < scsi_finish_command <
scsi_complete < blk_complete_reqs < blk_done_softirq < __do_softirq <
__irq_exit_rcu < irq_exit_rcu < common_interrupt < asm_common_interrupt <
_raw_spin_unlock_irqrestore < __wake_up_common_lock < __wake_up <
sbitmap_queue_wake_up < sbitmap_queue_clear < blk_mq_put_tag <
__blk_mq_free_request < blk_mq_free_request < dd_bio_merge <
blk_mq_sched_bio_merge < blk_mq_attempt_bio_merge < blk_mq_submit_bio <
__submit_bio < submit_bio_noacct_nocheck < submit_bio_noacct <
submit_bio < __swap_writepage < swap_writepage < pageout <
shrink_folio_list < evict_folios < lru_gen_shrink_lruvec <
shrink_lruvec < shrink_node < do_try_to_free_pages < try_to_free_pages <
__alloc_pages_slowpath < __alloc_pages < folio_alloc < vma_alloc_folio <
do_anonymous_page < __handle_mm_fault < handle_mm_fault <
do_user_addr_fault < exc_page_fault < asm_exc_page_fault

And in one case I did study stack contents carefully, confirming
the same sbq pointer used in upper and lower sbitmap_queue_wake_up.

And on Keith's points: yes, I do have preemption enabled; but no, this
machine does not have nvme, and I never hit this on the nvme laptop.

Thanks,
Hugh
