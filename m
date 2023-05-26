Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A446712A98
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjEZQ0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjEZQ0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:26:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D509D3;
        Fri, 26 May 2023 09:26:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D783E60FA7;
        Fri, 26 May 2023 16:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48C4C433D2;
        Fri, 26 May 2023 16:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685118361;
        bh=LpCoyio+IAqUmLQDw7X6qQ4rC44Pv8G4ckdSGQizVQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u2zNb4VyCo++/CYxbXwsjr9J0jCeZxwNfTKGgVmr5PrInZjwP16JlNuBPQBiLC1zm
         P6dqHdAoCnS8eD9VJzGryIs6LvBZAzUQyb1WWvj0jO7DOyoMpoFCmkx4QdOK7+nHER
         smhkniuJipNp91ka79qfEf4T7qtNnpkDFIddGjyk=
Date:   Fri, 26 May 2023 17:25:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, keescook@chromium.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, ndesaulniers@google.com, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        qiang1.zhang@intel.com, rcu@vger.kernel.org, tj@kernel.org,
        tglx@linutronix.de
Subject: Re: [RFC][PATCH 2/2] sched: Use fancy new guards
Message-ID: <2023052626-blunderer-delegator-4b82@gregkh>
References: <20230526150549.250372621@infradead.org>
 <20230526151947.027972233@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526151947.027972233@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 05:05:51PM +0200, Peter Zijlstra wrote:
> Convert kernel/sched/core.c to use the fancy new guards to simplify
> the error paths.

That's slightly crazy...

I like the idea, but is this really correct:


> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c  | 1223 +++++++++++++++++++++++----------------------------
>  kernel/sched/sched.h |   39 +
>  2 files changed, 595 insertions(+), 667 deletions(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1097,24 +1097,21 @@ int get_nohz_timer_target(void)
>  
>  	hk_mask = housekeeping_cpumask(HK_TYPE_TIMER);
>  
> -	rcu_read_lock();
> -	for_each_domain(cpu, sd) {
> -		for_each_cpu_and(i, sched_domain_span(sd), hk_mask) {
> -			if (cpu == i)
> -				continue;
> +	void_scope(rcu) {
> +		for_each_domain(cpu, sd) {
> +			for_each_cpu_and(i, sched_domain_span(sd), hk_mask) {
> +				if (cpu == i)
> +					continue;
>  
> -			if (!idle_cpu(i)) {
> -				cpu = i;
> -				goto unlock;
> +				if (!idle_cpu(i))
> +					return i;

You can call return from within a "scope" and it will clean up properly?

I tried to read the cpp "mess" but couldn't figure out how to validate
this at all, have a set of tests for this somewhere?

Anyway, the naming is whack, but I don't have a proposed better name,
except you might want to put "scope_" as the prefix not the suffix, but
then that might look odd to, so who knows.

But again, the idea is good, it might save us lots of "you forgot to
clean this up on the error path" mess that we are getting constant churn
for these days...

thanks,

greg k-h
