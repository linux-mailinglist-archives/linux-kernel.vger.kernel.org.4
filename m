Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E565EB8E9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 05:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiI0Dj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 23:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiI0DjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 23:39:19 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D749AC25B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 20:39:18 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id d15so5346981qka.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 20:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date;
        bh=ZH4Ham6QOYlPJxFlz6NHTTKOMx8HcWnSTKQZP+8VER0=;
        b=RFbZI3xEL5vv8HSqcE2cVEQbAFDe2oFUs/anu59++xOuOitH5qKR4o+UDeN5Gn/UNE
         3roofFKh6ChKQIQgSoSFMV94SdHSd0rrooSJgfYWPLFCtX4kWJRDgLkB23BSRkv8AXlm
         q8K2CiuZM/JRQ3+qCurzhCanF4Mr1l6pe39tZfISBVlXrRZ99AlDba/nYvMVHBI/2gbb
         r1dpn4gIgjrkle/NCPLDfAdNe/JQ/472tYUHJA6ip2ka/7gAauhJ5vdvu/TZynvu1IRV
         z6fUABXayr+gXGc3sAiojufbH3NvwfDhZelkhFYeqoQhKxN8KV8LJvP0yBvZdIoGm/sc
         2BMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZH4Ham6QOYlPJxFlz6NHTTKOMx8HcWnSTKQZP+8VER0=;
        b=0ue2F06MWXXArS4xzbsiU1YJCI1gU9lD3iy5q7uebyfQXUUgqzlm0W16oxJVXXuHIZ
         WPj/Vs6ifRhKo3ikX+eI2dzH7c6vMrvpyIyNAyf3zhgOcKTWvKHZZCpsKQJ5IAb+ynix
         gGe5iwwZJODi37guxHETfPg2YVl9RhkH0rm4loOMBDEiOfeYtqraL8at/u/mWKyaHFqR
         CwEFtcmMjACbznX4Khhih19VTrlX+xhxqdTRgqVVcL+TwHCHk4NvFjQDsHMicK1Yx/nE
         BhvTd/Njia5YbwLqzeXAC8dQPpJ12yBQpM4GhKRWAAn8jZXglqZYMnQ6sGjZyY8AA/FP
         +QIQ==
X-Gm-Message-State: ACrzQf2TMhVmrkmmXsWxzqJ/hPo5Km3L2wmFjOAx25r1Yk6AaowZ4aG0
        u/usTGLIVK0j4hTUIUI6boPQYg==
X-Google-Smtp-Source: AMsMyM5YZB/KpqvuCJvz1223w+yYHQxY7+ypCr/nHs3CQv7HgvYdIw8Y6LdNJ6LzFNajYC7+zI/e2A==
X-Received: by 2002:a05:620a:244b:b0:6ce:8443:bda1 with SMTP id h11-20020a05620a244b00b006ce8443bda1mr15920184qkn.685.1664249957360;
        Mon, 26 Sep 2022 20:39:17 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p14-20020a05620a22ae00b006ce60296f97sm256654qkh.68.2022.09.26.20.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 20:39:17 -0700 (PDT)
Date:   Mon, 26 Sep 2022 20:39:03 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jan Kara <jack@suse.cz>
cc:     Hugh Dickins <hughd@google.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Liu Song <liusong@linux.alibaba.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] sbitmap: fix lockup while swapping
In-Reply-To: <20220926114416.t7t65u66ze76aiz7@quack3>
Message-ID: <4539e48-417-edae-d42-9ef84602af0@google.com>
References: <aef9de29-e9f5-259a-f8be-12d1b734e72@google.com> <YyjdiKC0YYUkI+AI@kbusch-mbp> <f2d130d2-f3af-d09d-6fd7-10da28d26ba9@google.com> <20220921164012.s7lvklp2qk6occcg@quack3> <20220923144303.fywkmgnkg6eken4x@quack3> <d83885c9-2635-ef45-2ccc-a7e06421e1cc@google.com>
 <Yy4D54kPpenBkjHz@kbusch-mbp.dhcp.thefacebook.com> <391b1763-7146-857-e3b6-dc2a8e797162@google.com> <929a3aba-72b0-5e-5b80-824a2b7f5dc7@google.com> <20220926114416.t7t65u66ze76aiz7@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2022, Jan Kara wrote:
> On Fri 23-09-22 16:15:29, Hugh Dickins wrote:
> 
> I don't think any magic with sbq_index_atomic_inc() is going to reliably
> fix this. After all the current waitqueue may be the only one that has active
> waiters so sbq_wake_ptr() will always end up returning this waitqueue
> regardless of the current value of sbq->wake_index.
> 
> Honestly, this whole code needs a serious redesign.

I was pleased to see you say so, Jan: I do agree.

> I have some
> simplifications in mind but it will take some thinking and benchmarking

I'm definitely not the right person to take it on, and glad if you can.
But I did have some thoughts and experiments over the weekend, and would
like to throw a couple of suggestions into the pot.

One, not a big issue, but I think sbq_index_atomic_inc() is misconceived.
It's unhelpful for multiple racers to be adjusting sbq->wake_index, and
	wake_index = ws - sbq->ws;
	atomic_cmpxchg(&sbq->wake_index, wake_index, sbq_index_inc(wake_index));
seems to me a better way for __sbq_wake_up() to increment it.

Two, and here the depths of my naivete and incomprehension may be on
display, but: I get the impression that __sbq_wake_up() is intended
to accumulate wake_batch-1 wakeups while doing nothing, then on the
wake_batch'th it hopes to do all those wake_batch wakeups.  I assume
someone in the past has established that that's a safe way to procede
here, though it's not obviously safe to me.

Now, those !waitqueue_active(&ws->wait) checks are good for catching
when the hoped-for procedure has gone so "wrong" that there's actually
nothing to be woken on this ws (so proceed to the next); but they give
no clue as to when there are some but not enough wakeups done.

It is very easy to add a wake_up_nr_return() to kernel/sched/wait.c,
which returns the nr_exclusive still not woken (__wake_up_common_lock()
merely has to return nr_exclusive itself); and then __sbq_wake_up() can
be recalled until wake_batch have been woken (or all queues empty).

I do have an experiment running that way: but my testing is much too
limited to draw serious conclusions from, and I've already admitted
that I may just be misunderstanding the whole thing.  But, just maybe,
a wake_up_nr_return() might be useful.  End of those suggestions.

> so
> we need some fix for the interim. I was pondering for quite some time about
> some band aid to the problem you've found but didn't find anything
> satisfactory.
> 
> In the end I see two options: 
> 
> 1) Take your patch (as wrong as it is ;). Yes, it can lead to lost wakeups
> but we were living with those for a relatively long time so probably we can
> live with them for some longer.

In getting that experiment above going, I did have to make this change
below: and it looks to me now as better than my original patch - since
this one does try all SBQ_WAIT_QUEUES before giving up, whereas my first
patch immediately gave up on the waitqueue_active !wait_cnt case.

--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -587,7 +587,7 @@ static struct sbq_wait_state *sbq_wake_p
 	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
 		struct sbq_wait_state *ws = &sbq->ws[wake_index];
 
-		if (waitqueue_active(&ws->wait)) {
+		if (waitqueue_active(&ws->wait) && atomic_read(&ws->wait_cnt)) {
 			if (wake_index != atomic_read(&sbq->wake_index))
 				atomic_set(&sbq->wake_index, wake_index);
 			return ws;

TBH I have not tested this one outside of that experiment: would you
prefer this patch to my first one, I test and sign this off and send?

> 
> 2) Revert Yu Kuai's original fix 040b83fcecfb8 ("sbitmap: fix possible io
> hung due to lost wakeup") and my fixup 48c033314f37 ("sbitmap: Avoid leaving
> waitqueue in invalid state in __sbq_wake_up()"). But then Keith would have
> to redo his batched accounting patches on top.

I know much too little to help make that choice.

Hugh
