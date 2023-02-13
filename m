Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF41569493F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjBMO5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjBMO5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:57:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA1A1DBB3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tS3mHsBN2NLtArYoIbCiPJ9tTTfl7+rSUB/A4Ag/Xsk=; b=TtgvJa/PVbyB6rspkal84TtGNg
        JqOO8BBnM8FYMVbE7h+AlifZ182qcK9LMOKa6FhUGGJqwubUVSFkFdBEXYg/H8O7OMvGqC2NGiMNc
        WbKN9PdhypvmHoJv+OR2d4SBrT738W1iZ59r59MUMTU7X6VK+zrN++boCkBfjWVuDmIOlE8SiT3F+
        XTx4ujvmI2b2yXgKjS3NKNvj9D79v1iNN3Md73jiDJUVyeqfSmm7MdsUvSVhy5U432fhJ4BkfeYYI
        RaQVjE6/1SGqdmfT9xi/EfS6J9rbnrkFuZ+KHaW+GuyTHk1d/ep17/L1iIlLAhDtKMrjmpGTgFhHM
        MY+Eba6A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRaFu-005rM3-G7; Mon, 13 Feb 2023 14:56:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A4DF3300033;
        Mon, 13 Feb 2023 15:56:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 817E8202682CD; Mon, 13 Feb 2023 15:56:32 +0100 (CET)
Date:   Mon, 13 Feb 2023 15:56:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>, Phil Auld <pauld@redhat.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Fix a missed update of user_cpus_ptr
Message-ID: <Y+pPoOxuYtq+GBbA@hirez.programming.kicks-ass.net>
References: <20230203181849.221943-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203181849.221943-1-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 01:18:49PM -0500, Waiman Long wrote:
> Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
> cpumask"), a successful call to sched_setaffinity() should always save
> the user requested cpu affinity mask in a task's user_cpus_ptr. However,
> when the given cpu mask is the same as the current one, user_cpus_ptr
> is not updated. Fix this by saving the user mask in this case too.
> 
> Fixes: 8f9ea86fdf99 ("sched: Always preserve the user requested cpumask")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/sched/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 30d9752e2ca5..91255f791df3 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2951,8 +2951,11 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
>  	}
>  
>  	if (!(ctx->flags & SCA_MIGRATE_ENABLE)) {
> -		if (cpumask_equal(&p->cpus_mask, ctx->new_mask))
> +		if (cpumask_equal(&p->cpus_mask, ctx->new_mask)) {
> +			if (ctx->flags & SCA_USER)
> +				swap(p->user_cpus_ptr, ctx->user_mask);
>  			goto out;
> +		}
>  
>  		if (WARN_ON_ONCE(p == current &&
>  				 is_migration_disabled(p) &&

Indeed. Thanks!
