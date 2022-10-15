Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7505FFAC0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJOPIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiJOPIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:08:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA73537D7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AjipCgEKRcu/TILN4c/hLLWN721c5fXSxTf3IC4QIqs=; b=XVFd1LIgp7Se11/qy/RknThCaK
        /9+jleaoH+zS/S7yLLd0w/zDEgAN6p0MWf6+qhJgGul9BZDDGoDdvL/MtUPJlGz/USESi+VFIMGYF
        mYlqH4EXN1Rnv3jnIZe7zrm2QI6KyJ9xIZRtjPUMgio4M6hBS2FAtnD1Lw9pGLzkisLI5D2bAE+Sw
        /vZggwxK8vE7LH9XgO5IyD3x+MJ6wrmpX98dAY5cUKd+qVhzKZZNr74WCuwBHvq3eUbb0qukCn+Km
        xYuvvxj/uqqBv15XFuGEZI0k4xUVLSp/KYSTEpidzrKjms3E5m0o/1WzwVtuU/s3YIuEJd2TSepqd
        ROWok7zQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ojilw-008S2c-QD; Sat, 15 Oct 2022 15:08:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4EB7C30015F;
        Sat, 15 Oct 2022 17:08:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3879F201FD678; Sat, 15 Oct 2022 17:08:14 +0200 (CEST)
Date:   Sat, 15 Oct 2022 17:08:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Connor O'Brien <connoro@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 07/11] sched: Add proxy execution
Message-ID: <Y0rM3gHajrNdPcyi@hirez.programming.kicks-ass.net>
References: <20221003214501.2050087-1-connoro@google.com>
 <20221003214501.2050087-8-connoro@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003214501.2050087-8-connoro@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 09:44:57PM +0000, Connor O'Brien wrote:
> @@ -965,7 +1026,10 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
>  	if (owner & MUTEX_FLAG_HANDOFF)
>  		__mutex_handoff(lock, next);
>  
> -	preempt_disable();
> +	preempt_disable(); /* XXX connoro: why disable preemption here? */
> +#ifdef CONFIG_PROXY_EXEC
> +	raw_spin_unlock(&current->blocked_lock);
> +#endif
>  	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);

Because if we wouldn't have preemption disabled it would preempt here,
before the wakeup:

>  	wake_up_q(&wake_q);

And you'd be stuck with a priority inversion.


