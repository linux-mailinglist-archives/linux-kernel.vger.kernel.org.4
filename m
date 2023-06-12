Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C4672CA57
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbjFLPge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjFLPgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:36:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAF210CB;
        Mon, 12 Jun 2023 08:36:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4938D62AE3;
        Mon, 12 Jun 2023 15:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28E4C433D2;
        Mon, 12 Jun 2023 15:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686584189;
        bh=Q1uFqQC1LApj4DW1PzaabMa/eO+1KDEQYaeqlQnBAUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zaw2dmLk2sIEWs1tdAzS+nK65mRh2kTQ8vXiyCWcv8v2lYwxuhmHUorrYCQORDzC/
         NhjSkO6Emh9xOtLHBoY5w/EClpBciNfCPzsh/D+J5/DRcSugI4nO9RsfidNg2ENR/l
         jluK3RjF10Sx3iav95GSe8PIFyhiJPu8bIXLZlegNqg9EN+5DeLZ8rK91eLS9vP7Cq
         DvrhGZ4B52If4qoJzZTHF7eAgnIGWwi//UucCHPuqrSW+I5RpR61oO1TAD59sLoCoK
         p3ZlfbvK2/QcCYap98nY5mX0LyCZlzcJPbXqd++izu9mPr9be6eXf/tcBCDU5hdX8v
         iUrNyH0hLLNZw==
Date:   Mon, 12 Jun 2023 08:36:29 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Chinner <david@fromorbit.com>, Zorro Lang <zlang@redhat.com>,
        linux-xfs@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [6.5-rc5 regression] core dump hangs (was Re: [Bug report]
 fstests generic/051 (on xfs) hang on latest linux v6.5-rc5+)
Message-ID: <20230612153629.GA11427@frogsfrogsfrogs>
References: <20230611124836.whfktwaumnefm5z5@zlang-mailbox>
 <ZIZSPyzReZkGBEFy@dread.disaster.area>
 <20230612015145.GA11441@frogsfrogsfrogs>
 <ZIaBQnCKJ6NsqGhd@dread.disaster.area>
 <CAHk-=whJqZLKPR-cpX-V4wJTXVX-_tG5Vjuj2q9knvKGCPdfkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whJqZLKPR-cpX-V4wJTXVX-_tG5Vjuj2q9knvKGCPdfkg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 11, 2023 at 08:14:25PM -0700, Linus Torvalds wrote:
> On Sun, Jun 11, 2023 at 7:22 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > I guess the regression fix needs a regression fix....
> 
> Yup.
> 
> From the description of the problem, it sounds like this happens on
> real hardware, no vhost anywhere?
> 
> Or maybe Darrick (who doesn't see the issue) is running on raw
> hardware, and you and Zorro are running in a virtual environment?

Ahah, it turns out that liburing-dev isn't installed on the test fleet,
so fstests didn't get built with io_uring support.  That probably
explains why I don't see any of these hangs.

Oh.  I can't *install* the debian liburing-dev package because it has
a versioned dependency on linux-libc-dev >= 5.1, which isn't compatible
with me having a linux-libc-dev-djwong package that contains the uapi
headers for the latest upstream kernel and Replaces: linux-libc-dev.
So either I have to create a dummy linux-libc-dev with adequate version
number that pulls in my own libc header package, or rename that package.

<sigh> It's going to take me a while to research how best to split this
stupid knot.

--D

> It sounds like zap_other_threads() and coredump_task_exit() do not
> agree about the core_state->nr_threads counting, which is part of what
> changed there.
> 
> [ Goes off to look ]
> 
> Hmm. Both seem to be using the same test for
> 
>     (t->flags & (PF_IO_WORKER | PF_USER_WORKER)) != PF_USER_WORKER
> 
> which I don't love - I don't think io_uring threads should participate
> in core dumping either, so I think the test could just be
> 
>     (t->flags & PF_IO_WORKER)
> 
> but that shouldn't be the issue here.
> 
> But according to
> 
>   https://lore.kernel.org/all/20230611124836.whfktwaumnefm5z5@zlang-mailbox/
> 
> it's clearly hanging in wait_for_completion_state() in
> coredump_wait(), so it really looks like some confusion about that
> core_waiters (aka core_state->nr_threads) count.
> 
> Oh. Humm. Mike changed that initial rough patch of mine, and I had
> moved the "if you don't participate in c ore dumps" test up also past
> the "do_coredump()" logic.
> 
> And I think it's horribly *wrong* for a thread that doesn't get
> counted for core-dumping to go into do_coredump(), because then it
> will set the "core_state" to possibly be the core-state of the vhost
> thread that isn't even counted.
> 
> So *maybe* this attached patch might fix it? I haven't thought very
> deeply about this, but vhost workers most definitely shouldn't call
> do_coredump(), since they are then not counted.
> 
> (And again, I think we should just check that PF_IO_WORKER bit, not
> use this more complex test, but that's a separate and bigger change).
> 
>               Linus

>  kernel/signal.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 2547fa73bde5..a1e11ee8537c 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2847,6 +2847,10 @@ bool get_signal(struct ksignal *ksig)
>  		 */
>  		current->flags |= PF_SIGNALED;
>  
> +		/* vhost workers don't participate in core dups */
> +		if ((current->flags & (PF_IO_WORKER | PF_USER_WORKER)) != PF_USER_WORKER)
> +			goto out;
> +
>  		if (sig_kernel_coredump(signr)) {
>  			if (print_fatal_signals)
>  				print_fatal_signal(ksig->info.si_signo);

