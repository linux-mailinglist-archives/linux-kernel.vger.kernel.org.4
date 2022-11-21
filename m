Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6F463223B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiKUMfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiKUMe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:34:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B99CA6A0B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZcpLHc2YCyh5+c7me4kst+L3Ex3Jlpt5gOuzGZpHuWw=; b=WCCn/uYNi8EpKuY/HvqyHeglsh
        LNM0ytvHtQ9+fznRtFFtFHcASvqOJeddeOo+JWYXTUEjYoNoUhBO1SvNfAQ2H9KQS2O6MX4isFhG/
        sIGF+Gt+7W4AO+VJ1b1RYuVKUnEnlap7fVQrztp9nBxux/hkvHKXv5+eEOxPidwAr3Rah8xdvLGzG
        UDOPbC5j9V3H6lO+bTcxRSUttbino5x3VH6Jz1lI8wEclChpbjA86r5/0x9rs/AjCoq9VVhFgV7U/
        0bWhKXKuDodS3w7k6HQx4EnNe5rY+KrRU3KnyNDx6n6EyJuwj1mj6BXQzNbkZxoAYAnQgI6j7F82Z
        UE8N0h4g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ox60Y-005D4w-Hl; Mon, 21 Nov 2022 12:34:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 231CD300445;
        Mon, 21 Nov 2022 13:34:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F2DFD2D2DAA9D; Mon, 21 Nov 2022 13:34:33 +0100 (CET)
Date:   Mon, 21 Nov 2022 13:34:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH v3] sched: async unthrottling for cfs bandwidth
Message-ID: <Y3twWYeAW6U2/D92@hirez.programming.kicks-ass.net>
References: <20221117005418.3499691-1-joshdon@google.com>
 <Y3d+1a9AEnWaxFwq@hirez.programming.kicks-ass.net>
 <CABk29NtSmXVCvkdpymeam7AYmXhZy2JLYLPFTdKpk5g6AN1-zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29NtSmXVCvkdpymeam7AYmXhZy2JLYLPFTdKpk5g6AN1-zg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 11:25:09AM -0800, Josh Don wrote:

> > Maybe have this function return false when local and save that cfs_rq in
> > a local var to process again later, dunno, that might turn messy.
> 
> Maybe something like this? Apologies for inline diff formatting.

That looks entirely reasonable, not nearly as horrible as I feared. Let
me go make that happen.

> Note that one change we definitely want is the extra setting of
> throttled = true in the case that cfs_rq->runtime_remaining <= 0, to
> catch the case where we run out of runtime to distribute on the last
> entity in the list.

Done.

> > > +
> > > +     /* Already enqueued */
> > > +     if (SCHED_WARN_ON(!list_empty(&cfs_rq->throttled_csd_list)))
> > > +             return;
> > > +
> > > +     list_add_tail(&cfs_rq->throttled_csd_list, &rq->cfsb_csd_list);
> > > +
> > > +     smp_call_function_single_async(cpu_of(rq), &rq->cfsb_csd);
> >
> > Hurmph.. so I was expecting something like:
> >
> >         first = list_empty(&rq->cfsb_csd_list);
> >         list_add_tail(&cfs_rq->throttled_csd_list, &rq->cfsb_csd_list);
> >         if (first)
> >                 smp_call_function_single_async(cpu_of(rq), &rq->cfsb_csd);
> >
> > But I suppose I'm remembering the 'old' version. I don't think it is
> > broken as written. There's a very narrow window where you'll end up
> > sending a second IPI for naught, but meh.
> 
> The CSD doesn't get  unlocked until right before we call the func().
> But you're right that that's a (very) narrow window for an  extra IPI.
> Please feel free to modify the patch with that diff if you like.

Since I was manually editing things, I did that too.

Please test the final version as found here:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/core&id=4e3c1b7b489e218dfa576cd6af0680b975b8743e
