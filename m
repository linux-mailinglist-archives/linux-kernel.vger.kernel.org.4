Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8F76FFCA9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 00:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239382AbjEKWbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 18:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239311AbjEKWbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 18:31:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB772738
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=MTY93NpBqjnUjav5lCb8iifRMRcdMW81B6x1yVvfcEQ=; b=M2nEAcQmewAmFfBIMGiiYT1pmI
        ZZYeDhIFhVsB5P1mr0RWv0sh7a0VyYcbgc5xTWwH3/qaSE43EpQUSgm/jHF85eE6gZ37AsKzLFlga
        lvvh4SQS8ZAxg/apglt3sF2/gSsTyrmVdZvBbCz0G4H4Pc5f687US7/DQkiV//rCLjha2EzpyRxhC
        SB061Ymwb6D47w0RTyWtchmJJ5hwsEWxdHcpYGL+qtpqqpP7SDTrVC9cPtJJ2hN8EbAbUv7sd3jh0
        9UgxNzyO/JbeYptWwmG0BThKJTmqBkZFd0Smdye+UVijLngRb69PV32FUvQV35HEJwhDGdVF4kok2
        YYNKApmw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pxEoo-0002Lm-Ld; Thu, 11 May 2023 22:31:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BF141300244;
        Fri, 12 May 2023 00:31:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A564C2C7C5BED; Fri, 12 May 2023 00:31:24 +0200 (CEST)
Date:   Fri, 12 May 2023 00:31:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] sched/wait: Fix a kthread_park race with wait_woken()
Message-ID: <20230511223124.GJ2296992@hirez.programming.kicks-ass.net>
References: <20230406194053.876844-1-arve@android.com>
 <20230511214144.1924757-1-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511214144.1924757-1-jstultz@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 09:41:30PM +0000, John Stultz wrote:
> From: Arve Hjønnevåg <arve@android.com>
> 
> kthread_park and wait_woken have a similar race that kthread_stop and
> wait_woken used to have before it was fixed in
> cb6538e740d7543cd989128625cf8cac4b471e0a. Extend that fix to also cover

  cb6538e740d7 ("sched/wait: Fix a kthread race with wait_woken()")

> kthread_park.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Arve Hjønnevåg <arve@android.com>
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> This seemingly slipped by, so I wanted to resend it
> for review.
> ---
>  kernel/sched/wait.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
> index 133b74730738..a9cf49da884b 100644
> --- a/kernel/sched/wait.c
> +++ b/kernel/sched/wait.c
> @@ -425,9 +425,9 @@ int autoremove_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, i
>  }
>  EXPORT_SYMBOL(autoremove_wake_function);
>  
> -static inline bool is_kthread_should_stop(void)
> +static inline bool is_kthread_should_stop_or_park(void)
>  {
> -	return (current->flags & PF_KTHREAD) && kthread_should_stop();
> +	return (current->flags & PF_KTHREAD) && (kthread_should_stop() || kthread_should_park());
>  }
>  
>  /*

That's a bit sad; that two function calls for checking two consecutive
bits in the same word :-(

If we move this to kthread.c and write it like:

	kthread = __to_kthread(current);
	if (!kthread)
		return false;

	return test_bit(KTHREAD_SHOULD_STOP, &kthread->flags) ||
	       test_bit(KTHREAD_SHOULD_PARK, &kthread->flags);

Then the compiler should be able to merge the two bits in a single load
and test due to constant_test_bit() -- do check though.

> @@ -459,7 +459,7 @@ long wait_woken(struct wait_queue_entry *wq_entry, unsigned mode, long timeout)
>  	 * or woken_wake_function() sees our store to current->state.
>  	 */
>  	set_current_state(mode); /* A */
> -	if (!(wq_entry->flags & WQ_FLAG_WOKEN) && !is_kthread_should_stop())
> +	if (!(wq_entry->flags & WQ_FLAG_WOKEN) && !is_kthread_should_stop_or_park())
>  		timeout = schedule_timeout(timeout);
>  	__set_current_state(TASK_RUNNING);
>  
> -- 
> 2.40.1.606.ga4b1b128d6-goog
> 
