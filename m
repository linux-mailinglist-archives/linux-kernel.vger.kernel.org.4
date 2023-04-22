Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5976EB895
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 12:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjDVKgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 06:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDVKgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 06:36:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9746171B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 03:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZGYfNwnZYr5ZfqamB84v/23MtJTpObaj59RE3PVRK5Q=; b=abGSPKNP6fxAZVoxQHhVdTqY1R
        mmKKFrseihUwBx97FCqUhBCZcl8tY8qYNiXdQbB+JjJiPHn6c4LxDe1bs9v0Ipt2NLJ4bX/kuk7aH
        1EfFkyN9NiXgNW961kIL107Y9FGx8G8kXWaR9siPjwF3zVdiwXLjSkNpNLAeDZkdJTNL4T+O8Sq3K
        ygphqHUUhwehVx3VWUShNywbmRI7/vtNZthg1dvvFxsMOP1NBtc61Ok3xy5L+qdmT4st5pnKQbSur
        nMICEyExRIT0Ibk+/rTC26+4vko+ia641nqmpH2AdK6d3Ym4WvvzpUJrycFlsnNmDzkP0hw6n8MBh
        47aiMJbQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pqAbL-00G9mA-Od; Sat, 22 Apr 2023 10:36:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 07635300338;
        Sat, 22 Apr 2023 12:36:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DC847206D2923; Sat, 22 Apr 2023 12:36:18 +0200 (CEST)
Date:   Sat, 22 Apr 2023 12:36:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Connor O'Brien <connoro@google.com>
Subject: Re: [PATCH v3 06/14] locking/mutex: Expose mutex_owner()
Message-ID: <20230422103618.GE1214746@hirez.programming.kicks-ass.net>
References: <20230411042511.1606592-1-jstultz@google.com>
 <20230411042511.1606592-7-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411042511.1606592-7-jstultz@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 04:25:03AM +0000, John Stultz wrote:

>  include/linux/mutex.h  | 2 ++
>  kernel/locking/mutex.c | 5 +++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index 8f226d460f51..ebdc59cb0bf6 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -118,6 +118,8 @@ do {									\
>  extern void __mutex_init(struct mutex *lock, const char *name,
>  			 struct lock_class_key *key);
>  
> +extern struct task_struct *mutex_owner(struct mutex *lock);
> +
>  /**
>   * mutex_is_locked - is the mutex locked
>   * @lock: the mutex to be queried
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 45f1b7519f63..cbc34d5f4486 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -81,6 +81,11 @@ static inline struct task_struct *__mutex_owner(struct mutex *lock)
>  	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~MUTEX_FLAGS);
>  }
>  
> +struct task_struct *mutex_owner(struct mutex *lock)
> +{
> +	return __mutex_owner(lock);
> +}
> +
>  static inline struct task_struct *__owner_task(unsigned long owner)
>  {
>  	return (struct task_struct *)(owner & ~MUTEX_FLAGS);


Urgh, no.

It exposes mutex_owner() far wider than it should be, and also it turns
what should be a simple load into a function call :/

Looking at the lastest patches I have here this used to be an inline in
kernel/locking/mutex.h and kernel/sched/core.c got to #include
"../locking/mutex.h".
