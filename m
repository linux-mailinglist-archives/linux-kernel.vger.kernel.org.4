Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8062B6629D2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjAIPY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjAIPYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:24:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D478E0E3;
        Mon,  9 Jan 2023 07:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Bl/KPyGidpQAZ9cQmYFAHIBqyh50nPqzGXHF5q8Zze8=; b=iz4Uan2NUjMCkwR13vVUYh6GvE
        nnDzOD+bJqpzT2xl6Y38mps9b0LgIAJUXqiQIFu1aykQ7kynJB6h9khoh225ldrUpolKLHSsSappX
        gEuUNXaA9c2Bps/xiE9LAPlXgb3DU3TJyYp7lgqiP3Jpzebwk2hSEEMZagervLMta9YDgAp2jAmel
        hsfPjqYnt2wfKhAOaRPK0X+/KM+YeX0CYgccbPXC48PeBQrbKLdI4UXQ3HxmV4AXTq8axEbPTUo65
        wlQkNLXieRS3kFSC9l1q/gz3A4K/+55H3zHXEPOsO4V5oa/nmF3JB/U2LltEa7myuVOEu2UnGQWwk
        Fda6jLFA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEu0Q-002OMt-Tj; Mon, 09 Jan 2023 15:24:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0EAC3300033;
        Mon,  9 Jan 2023 16:23:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E4094201AB409; Mon,  9 Jan 2023 16:23:56 +0100 (CET)
Date:   Mon, 9 Jan 2023 16:23:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] locking/rwbase: Prevent indefinite writer starvation
Message-ID: <Y7wxjBN9bDaZ0BKo@hirez.programming.kicks-ass.net>
References: <20230106142743.30759-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106142743.30759-1-mgorman@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 02:27:43PM +0000, Mel Gorman wrote:
> rw_semaphore and rwlock are explicitly unfair to writers in the presense
> of readers by design with a PREEMPT_RT configuration. Commit 943f0edb754f
> ("locking/rt: Add base code for RT rw_semaphore and rwlock") notes;
> 
> 	The implementation is writer unfair, as it is not feasible to do
> 	priority inheritance on multiple readers, but experience has shown
> 	that real-time workloads are not the typical workloads which are
> 	sensitive to writer starvation.
> 
> While atypical, it's also trivial to block writers with PREEMPT_RT
> indefinitely without ever making forward progress. Since LTP-20220121,
> the dio_truncate test case went from having 1 reader to having 16 readers
> and the number of readers is sufficient to prevent the down_write ever
> succeeding while readers exist. Ultimately the test is killed after 30
> minutes as a failure.
> 
> dio_truncate is not a realtime application but indefinite writer starvation
> is undesirable. The test case has one writer appending and truncating files
> A and B while multiple readers read file A.  The readers and writer are
> contending for one file's inode lock which never succeeds as the readers
> keep reading until the writer is done which never happens.
> 
> This patch records a timestamp when the first writer is blocked. Reader
> bias is allowed until the first writer has been blocked for a minimum of
> 4ms and a maximum of (4ms + 1 jiffie). The cutoff time is arbitrary on
> the assumption that a hard realtime application missing a 4ms deadline
> would not need PRREMPT_RT. It's expected that hard realtime applications
> avoid such heavy reader/writer contention by design. On a test machine,
> the test completed in 92 seconds.

>  static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
>  				      unsigned int state)
>  {
> @@ -76,7 +79,8 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
>  	 * Allow readers, as long as the writer has not completely
>  	 * acquired the semaphore for write.
>  	 */
> -	if (atomic_read(&rwb->readers) != WRITER_BIAS) {
> +	if (atomic_read(&rwb->readers) != WRITER_BIAS &&
> +	    jiffies - rwb->waiter_blocked < RW_CONTENTION_THRESHOLD) {
>  		atomic_inc(&rwb->readers);
>  		raw_spin_unlock_irq(&rtm->wait_lock);
>  		return 0;

Blergh.

So a number of comments:

 - this deserves a giant comment, not only an obscure extra condition.

 - this would be better if it were limited to only have effect
   when there are no RT/DL tasks involved.

This made me re-read the phase-fair rwlock paper and again note that RW
semaphore (eg blocking) variant was delayed to future work and AFAICT
this future hasn't happened yet :/

AFAICT it would still require boosting the readers (something tglx still
has nightmares of) and limiting reader concurrency, another thing that
hurts.


