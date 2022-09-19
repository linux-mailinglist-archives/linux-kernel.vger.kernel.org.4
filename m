Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F6B5BCB00
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiISLqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiISLp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:45:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913012AE12;
        Mon, 19 Sep 2022 04:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/3DW1goWuoKer9u+A3DtQ9jlkLup9NoDTU3kbas6vLw=; b=N9OI/owuvMz9blgRWzlwoesiBL
        OTC+fa+ODBPVgmLMgQ+BbcchiiwfIK71hMcuQQ1exYfDdG+L+PV0252Bzkx8/NfHoYqnyjBCQcU0K
        Hiqvvma4rZxDVrJiYuF4eY1QUO9nVdMXSzCXM7gFrWnbJGpWu6mktfJg90PZ3o6PRURA6uk92gw7W
        TnmuKIhYU4DtdvaModSpQKsDcwvrWs5JJP0UrYzxBH7y8NlrAuQ4xu/pPTtZQQUbgdDwO89FYgRyW
        KOvsYNhKvWKCi769nlTYbEtvGdPmNvQRZvjkrtSZgkKO1MAUWiRx38i5+n76BrTrVF0zftvQ0EJvY
        M7V1lIVQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaFDX-00E4Q6-V2; Mon, 19 Sep 2022 11:45:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8EE30300342;
        Mon, 19 Sep 2022 13:45:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7480F2B6335FA; Mon, 19 Sep 2022 13:45:38 +0200 (CEST)
Date:   Mon, 19 Sep 2022 13:45:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Subject: Re: [PATCH] perf/x86/rapl: fix deadlock in rapl_pmu_event_stop
Message-ID: <YyhWYt9iSAay+QL9@hirez.programming.kicks-ass.net>
References: <20220917144729.118500-1-duoming@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917144729.118500-1-duoming@zju.edu.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 10:47:29PM +0800, Duoming Zhou wrote:
> There is a deadlock in rapl_pmu_event_stop(), the process is
> shown below:
> 
>     (thread 1)                 |        (thread 2)
> rapl_pmu_event_stop()          | rapl_hrtimer_handle()
>  ...                           |  if (!pmu->n_active)
>  raw_spin_lock_irqsave() //(1) |  ...
>   ...                          |
>   hrtimer_cancel()             |  raw_spin_lock_irqsave() //(2)
>   (block forever)
> 
> We hold pmu->lock in position (1) and use hrtimer_cancel() to wait
> rapl_hrtimer_handle() to stop, but rapl_hrtimer_handle() also need
> pmu->lock in position (2). As a result, the rapl_pmu_event_stop()
> will be blocked forever.
> 
> This patch extracts hrtimer_cancel() from the protection of
> raw_spin_lock_irqsave(). As a result, the rapl_hrtimer_handle() could
> obtain the pmu->lock. In order to prevent race conditions, we put
> "if (!pmu->n_active)" in rapl_hrtimer_handle() under the protection
> of raw_spin_lock_irqsave().
> 
> Fixes: 65661f96d3b3 ("perf/x86: Add RAPL hrtimer support")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
>  arch/x86/events/rapl.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index 77e3a47af5a..97c71538d01 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -219,11 +219,11 @@ static enum hrtimer_restart rapl_hrtimer_handle(struct hrtimer *hrtimer)
>  	struct perf_event *event;
>  	unsigned long flags;
>  
> +	raw_spin_lock_irqsave(&pmu->lock, flags);
> +
>  	if (!pmu->n_active)
>  		return HRTIMER_NORESTART;

Except now you return with the lock held...

>  
> -	raw_spin_lock_irqsave(&pmu->lock, flags);
> -
>  	list_for_each_entry(event, &pmu->active_list, active_entry)
>  		rapl_event_update(event);
>  
> @@ -281,8 +281,11 @@ static void rapl_pmu_event_stop(struct perf_event *event, int mode)
>  	if (!(hwc->state & PERF_HES_STOPPED)) {
>  		WARN_ON_ONCE(pmu->n_active <= 0);
>  		pmu->n_active--;
> -		if (pmu->n_active == 0)
> +		if (!pmu->n_active) {
> +			raw_spin_unlock_irqrestore(&pmu->lock, flags);
>  			hrtimer_cancel(&pmu->hrtimer);
> +			raw_spin_lock_irqsave(&pmu->lock, flags);

Doing a lock-break makes the nr_active and list_del thing non-atomic,
breaking the whole purpose of the lock.

> +		}
>  
>  		list_del(&event->active_entry);


Now; did you actually observe this deadlock or is this a code-reading
exercise? If you saw an actual deadlock, was cpu-hotplug involved?


