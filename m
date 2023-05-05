Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1CC6F8510
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 16:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjEEOua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 10:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjEEOu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 10:50:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67E01635E
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 07:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E67966348E
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 14:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE52C433EF;
        Fri,  5 May 2023 14:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683298223;
        bh=dIDBpG6dhKNh4O8MDr9mOrIop26afePz8FQfz1RjU0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MXNgQ22hNz/F6O3abYmNgNbgZaMH+72ul5lFb55gK+6PYXV0rUeqj0n6kJdTuk+Z2
         muHlMecERZdf2yrwiPk7jyurKiTDsgQINO6owAQfMGY8TA10KdkGlPgDDnnZm8zf+R
         28CDvHlGyPSGJ93iwZHOz3vgtFD7Xl8Yn2/hYGpwLK+pbMcHFh/OWJQ0q3HWKYkfxB
         UOxWo3XWAO+T9UiuUlVT+y2SZ692wsS7iuFpjL+mB594/xteG6hGR8DYA1gyeQwWYz
         SKayLRaJO06x585+4P7DLqDlzjlxOfQmRk6yt5Qx66sjvTPCR4JzHkHbrSrUSHlzaz
         mzW/XjPNR+7zg==
Date:   Fri, 5 May 2023 16:50:20 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 02/20] posix-timers: Ensure timer ID search-loop limit is
 valid
Message-ID: <ZFUXrCZtWyNG3Esi@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.932345089@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425183312.932345089@linutronix.de>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 08:48:58PM +0200, Thomas Gleixner wrote:
> posix_timer_add() tries to allocate a posix timer ID by starting from the
> cached ID which was stored by the last successful allocation.
> 
> This is done in a loop searching the ID space for a free slot one by
> one. The loop has to terminate when the search wrapped around to the
> starting point.
> 
> But that's racy vs. establishing the starting point. That is read out
> lockless, which leads to the following problem:
> 
> CPU0	  	      	     	   CPU1
> posix_timer_add()
>   start = sig->posix_timer_id;
>   lock(hash_lock);
>   ...				   posix_timer_add()
>   if (++sig->posix_timer_id < 0)
>       			             start = sig->posix_timer_id;
>      sig->posix_timer_id = 0;
> 
> So CPU1 can observe a negative start value, i.e. -1, and the loop break
> never happens because the condition can never be true:
> 
>   if (sig->posix_timer_id == start)
>      break;
> 
> While this is unlikely to ever turn into an endless loop as the ID space is
> huge (INT_MAX), the racy read of the start value caught the attention of
> KCSAN and Dmitry unearthed that incorrectness.
> 
> Rewrite it so that the start condition can never observe the negative value
> and annotate the read and the write with READ_ONCE()/WRITE_ONCE().
> 
> Reported-by: syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/sched/signal.h |    2 +-
>  kernel/time/posix-timers.c   |   30 +++++++++++++++++-------------
>  2 files changed, 18 insertions(+), 14 deletions(-)
> 
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -135,7 +135,7 @@ struct signal_struct {
>  #ifdef CONFIG_POSIX_TIMERS
>  
>  	/* POSIX.1b Interval Timers */
> -	int			posix_timer_id;
> +	unsigned int		next_posix_timer_id;
>  	struct list_head	posix_timers;
>  
>  	/* ITIMER_REAL timer for the process */
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -140,25 +140,29 @@ static struct k_itimer *posix_timer_by_i
>  static int posix_timer_add(struct k_itimer *timer)
>  {
>  	struct signal_struct *sig = current->signal;
> -	int first_free_id = sig->posix_timer_id;
>  	struct hlist_head *head;
> -	int ret = -ENOENT;
> +	unsigned int start, id;
>  
> -	do {
> +	/* Can be written by a different task concurrently in the loop below */
> +	start = READ_ONCE(sig->next_posix_timer_id);
> +
> +	for (id = ~start; start != id; id++) {
>  		spin_lock(&hash_lock);
> -		head = &posix_timers_hashtable[hash(sig, sig->posix_timer_id)];
> -		if (!__posix_timers_find(head, sig, sig->posix_timer_id)) {
> +		id = sig->next_posix_timer_id;
> +
> +		/* Write the next ID back. Clamp it to the positive space */
> +		WRITE_ONCE(sig->next_posix_timer_id, (id + 1) & INT_MAX);

Isn't that looping forever?

Thanks.
