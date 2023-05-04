Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F926F65A8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjEDHYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjEDHYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:24:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A24270C
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 00:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9xf9cZQeugoRb72goccVY7M1wKWwww2mkQ8tgTqqbUA=; b=ukZhif4xl7kyH3Hjdtiqhw50HH
        /HFNKGe6hk1fRxYHGefccJUwC2eC5qZuCyUD4nkA3pnCtZV0Y5Gikj5qUgxTDezCMj3otuxLJM7WE
        55uS7EbP2JVRLCVaYzbDXTdmrc9I3H1d4xYhMNyES9Bl6mrudUtsq8kLEF2xee2BT9pzN3zP+Iq7K
        R2OSW/5dImxErMu3KeAq+V2gTbBWox1+bDq+0aHGu5J8W4QMXbheDf+ojKn87nQEBLc2oekpUOuX+
        g6MZlyPnXdoyTir8IHniXFUWLrSGwY8hBXASITYt4hDhq1SRsb3HkN7xlyJm1WjExbj97dSRnScTD
        GaXDBwqw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1puTJT-00AMEy-Dl; Thu, 04 May 2023 07:23:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0DECC3003CF;
        Thu,  4 May 2023 09:23:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE29720D4D11C; Thu,  4 May 2023 09:23:36 +0200 (CEST)
Date:   Thu, 4 May 2023 09:23:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v4] sched/core: Adapt WARN_DOUBLE_CLOCK machinery for
 core-sched
Message-ID: <20230504072336.GG1734100@hirez.programming.kicks-ass.net>
References: <20230406064415.17110-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406064415.17110-1-jiahao.os@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 02:44:15PM +0800, Hao Jia wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0d18c3969f90..c6e2c79152ef 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -429,11 +429,32 @@ void sched_core_put(void)
>  		schedule_work(&_work);
>  }
>  
> +/*
> + * Now, we have obtained a core-wide rq->lock, then we need to clear
> + * RQCF_UPDATED of rq->clock_update_flags of the sibiling CPU
> + * on this core to avoid the WARN_DOUBLE_CLOCK warning.
> + */
> +static inline void sched_core_clear_rqcf_updated(struct rq *rq)
> +{
> +#ifdef CONFIG_SCHED_DEBUG
> +	const struct cpumask *smt_mask;
> +	int i;
> +
> +	if (rq->core_enabled) {
> +		smt_mask = cpu_smt_mask(rq->cpu);
> +		for_each_cpu(i, smt_mask) {
> +			if (rq->cpu != i)
> +				cpu_rq(i)->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
> +		}
> +	}
> +#endif
> +}
>  #else /* !CONFIG_SCHED_CORE */
>  
>  static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
>  static inline void
>  sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
> +static inline void sched_core_clear_rqcf_updated(struct rq *rq) { }
>  
>  #endif /* CONFIG_SCHED_CORE */
>  
> @@ -548,6 +569,7 @@ void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
>  		if (likely(lock == __rq_lockp(rq))) {
>  			/* preempt_count *MUST* be > 1 */
>  			preempt_enable_no_resched();
> +			sched_core_clear_rqcf_updated(rq);
>  			return;
>  		}
>  		raw_spin_unlock(lock);

This still looks absolutely wrong. The whole RQCF thing is a pin action.
