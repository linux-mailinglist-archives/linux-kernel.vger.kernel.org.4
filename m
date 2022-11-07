Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2333061F447
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiKGN0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiKGN0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:26:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E991E1A3A2;
        Mon,  7 Nov 2022 05:26:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A494D22544;
        Mon,  7 Nov 2022 13:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667827592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cS3muMI5WStP103zRvSh1uu1lDBE/GBlTm1cKs3o9EU=;
        b=2PsbZxpvvUpdl6ajyETlq9RBewdCqVqAUhUciosjZbNJO4m1/RWiIuRVr+KWum+0W0qvJr
        4FUzzGzBHSN9tgA7C/b4Xl89UPXY9NfkfkNo4RQEUOp2U+yVF1w5jvIaFhCOeEpoqIY0yr
        sUTYEH+babpHLBVAV3q6/6tmQDUQ0kw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667827592;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cS3muMI5WStP103zRvSh1uu1lDBE/GBlTm1cKs3o9EU=;
        b=Hco5MwFj/aQmVrzqpS10vaWxW8eG2mMsd+brypV4yrr9kjVUQyCPI74FL+0GqQAho3zeOO
        w+0Q0YJhdjqrKPBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C54F13494;
        Mon,  7 Nov 2022 13:26:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eP09IogHaWP1WQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 07 Nov 2022 13:26:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 67FE5A0704; Mon,  7 Nov 2022 14:26:31 +0100 (CET)
Date:   Mon, 7 Nov 2022 14:26:31 +0100
From:   Jan Kara <jack@suse.cz>
To:     Khazhy Kumykov <khazhy@google.com>
Cc:     Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [RFC PATCH] bfq: fix waker_bfqq inconsistency crash
Message-ID: <20221107132631.ajhbqmgewq24jx4k@quack3>
References: <20221103013937.603626-1-khazhy@google.com>
 <3c0df3fa-8731-5863-ccc5-f2e60601dbf9@huaweicloud.com>
 <CACGdZYJ0WH+Y9sdchXy30UVTQgPCEo=fW+W9atZh1Ki7Ov4_Gw@mail.gmail.com>
 <f83404b4-84a4-de4e-fa4d-9ce38900d91c@huaweicloud.com>
 <20221103084744.xsvoul3hjgz7yyo7@quack3>
 <CACGdZYK7xk+CJw9_RKwceXXnREVhgHh9U-OWidnKgYp6B011xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGdZYK7xk+CJw9_RKwceXXnREVhgHh9U-OWidnKgYp6B011xQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-11-22 14:25:32, Khazhy Kumykov wrote:
> On Thu, Nov 3, 2022 at 1:47 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 03-11-22 11:51:15, Yu Kuai wrote:
> > > Hi,
> > >
> > > 在 2022/11/03 11:05, Khazhy Kumykov 写道:
> > > > On Wed, Nov 2, 2022 at 7:56 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > 在 2022/11/03 9:39, Khazhismel Kumykov 写道:
> > > > > > This fixes crashes in bfq_add_bfqq_busy due to waker_bfqq being NULL,
> > > > > > but woken_list_node still being hashed. This would happen when
> > > > > > bfq_init_rq() expects a brand new allocated queue to be returned from
> > > > >
> > > > >   From what I see, bfqq->waker_bfqq is updated in bfq_init_rq() only if
> > > > > 'new_queue' is false, but if 'new_queue' is false, the returned 'bfqq'
> > > > > from bfq_get_bfqq_handle_split() will never be oom_bfqq, so I'm confused
> > > > > here...
> > > > There's two calls for bfq_get_bfqq_handle_split in this function - the
> > > > second one is after the check you mentioned, and is the problematic
> > > > one.
> > > Yes, thanks for the explanation. Now I understand how the problem
> > > triggers.
> > >
> > > > >
> > > > > > bfq_get_bfqq_handle_split() and unconditionally updates waker_bfqq
> > > > > > without resetting woken_list_node. Since we can always return oom_bfqq
> > > > > > when attempting to allocate, we cannot assume waker_bfqq starts as NULL.
> > > > > > We must either reset woken_list_node, or avoid setting woken_list at all
> > > > > > for oom_bfqq - opt to do the former.
> > > > >
> > > > > Once oom_bfqq is used, I think the io is treated as issued from root
> > > > > group. Hence I don't think it's necessary to set woken_list or
> > > > > waker_bfqq for oom_bfqq.
> > > > Ack, I was wondering what's right here since, evidently, *someone* had
> > > > already set oom_bfqq->waker_bfqq to *something* (although... maybe it
> > > > was an earlier init_rq). But maybe it's better to do nothing if we
> > > > *know* it's oom_bfqq.
> > >
> > > I need to have a check how oom_bfqq get involved with waker_bfqq, and
> > > then see if it's reasonable.
> > >
> > > Probably Jan and Paolo will have better view on this.
> >
> > Thanks for the CC Kuai and thanks to Khazy for spotting the bug. The
> > oom_bfqq is just a fallback bfqq and as such it should be extempted from
> > all special handling like waker detection etc. All this stuff is just for
> > optimizing performance and when we are OOM, we have far larger troubles
> > than to optimize performance.
> >
> > So how I think we should really fix this is that we extempt oom_bfqq from
> > waker detection in bfq_check_waker() by adding:
> >
> >         bfqq == bfqd->oom_bfqq ||
> >         bfqd->last_completed_rq_bfq == bfqd->oom_bfqq)
> >
> > to the initial check and then also if bfq_get_bfqq_handle_split() returns
> > oom_bfqq we should just skip carrying over the waker information.
> Thanks for the tip! I'll send a followup, including your suggestions.
> 
> I do have some other questions in this area, if you could help me
> understand. Looking again at bfq_init_rq, inside of the !new_queue
> section - we call bfq_split_bfqq() to "split" our bfqq, then in the
> next line bfq_get_bfqq_handle_split inspects bic_to_bfqq(bic,
> is_sync), and if it's NULL, allocates a new queue. However, if we have
> an async rq, this call will return the pre-existing async bfqq, as the
> call to bfq_split_bfqq() only clears the sync bfqq, ever. The best
> understanding I have now is: "bic->bfqq[aync] is never NULL (and we
> don't merge async queues) so we'll never reach this !new_queue section
> anyways if it's async". Is that accurate?

So you are right that async queues are never merged or split. In fact, if
you have a look at bfq_get_queue(), you'll notice that async queue is
common for all processes with the same ioprio & blkcg. So all these games
with splitting, merging, waker detection etc. impact only sync queues.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
