Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75EA6D7F5C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbjDEO0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238455AbjDEO0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:26:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FABD30FF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 07:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VbAA/+jFaexy4HsrkNJtkuLLB+Vp9KUEXqXY3TJrPfo=; b=cBf3Wefvj04IDnDgud+7e/V0wa
        b2Ro18nimzr2s2we5w8M21t9ILTxvWfJNBWUvUCXQNNCKp/gAWAHNi5cKnzKrT79aZUGeRx1R2LjW
        6l8UcQvIoyCxlwtQMdJk9kXXq3BZ5mhlN8oS96L7Ad9QM8NdwBRAmucfxxht93P+/CX0PaNbe/e/N
        7JVJ5ajan0EHsLQo+p5Z/ilR/g7qPodTcnuT718F4JIrLfkBZjoAKPi2FSj9pI2POowhoqyoawhIw
        cDTyXUT581LgF14gcIcWkPP1UdrmS1A7LmP2fl+DNzXHfftxDMDHBsFQZFx1RA/R0c4NMvencujun
        jo9BhZAw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pk458-00GS8s-Uv; Wed, 05 Apr 2023 14:25:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 67160300202;
        Wed,  5 Apr 2023 16:25:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2468826A759A1; Wed,  5 Apr 2023 16:25:48 +0200 (CEST)
Date:   Wed, 5 Apr 2023 16:25:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ma Xing <maxing.lan@bytedance.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.co,
        linux-kernel@vger.kernel.org, yuanzhu@bytedance.com
Subject: Re: [PATCH] sched/cputime: Make cputime_adjust() more accurate
Message-ID: <20230405142548.GE351571@hirez.programming.kicks-ass.net>
References: <20230328024827.12187-1-maxing.lan@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328024827.12187-1-maxing.lan@bytedance.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 10:48:27AM +0800, Ma Xing wrote:
> In the current algorithm of cputime_adjust(), the accumulated stime and
> utime are used to divide the accumulated rtime. When the value is very
> large, it is easy for the stime or utime not to be updated. It can cause
> sys or user utilization to be zero for long time.
> 
> A better and intuitive way is to save the last stime and utime, and
> divide the rtime increment proportionally according to the tick
> increment.

<snip>

> In addition, this patch has been running stably for 2 months and no problems have been found.
> 
> Signed-off-by: Ma Xing <maxing.lan@bytedance.com>
> ---
>  include/linux/sched.h         |  2 ++
>  include/linux/sched/cputime.h |  1 +
>  kernel/sched/cputime.c        | 38 +++++++++++++++++++++++++----------
>  3 files changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 6d654eb4cabd..e1bac4ee48ba 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -326,6 +326,8 @@ struct prev_cputime {
>  #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
>  	u64				utime;
>  	u64				stime;
> +	u64				utick;
> +	u64				stick;

Not a fan of the naming, cputime_adjust() isn't tick bound, you can run
it however much you want through proc and various syscalls.

>  	raw_spinlock_t			lock;
>  #endif
>  };
> diff --git a/include/linux/sched/cputime.h b/include/linux/sched/cputime.h
> index 5f8fd5b24a2e..855503bbd067 100644
> --- a/include/linux/sched/cputime.h
> +++ b/include/linux/sched/cputime.h
> @@ -173,6 +173,7 @@ static inline void prev_cputime_init(struct prev_cputime *prev)
>  {
>  #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
>  	prev->utime = prev->stime = 0;
> +	prev->utick = prev->stick = 0;
>  	raw_spin_lock_init(&prev->lock);
>  #endif
>  }
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index af7952f12e6c..ee8084957578 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -559,6 +559,7 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
>  		    u64 *ut, u64 *st)
>  {
>  	u64 rtime, stime, utime;
> +	s64 delta_rtime, delta_stime, delta_utime;
>  	unsigned long flags;
>  
>  	/* Serialize concurrent callers such that we can honour our guarantees */
> @@ -579,22 +580,36 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
>  	stime = curr->stime;
>  	utime = curr->utime;
>  
> +

Superfluous extra white space.

> +	delta_rtime = rtime - prev->stime - prev->utime;
> +	delta_stime = stime - prev->stick;
> +	delta_utime = utime - prev->utick;
> +
> +	prev->stick = stime;
> +	prev->utick = utime;
> +
>  	/*
>  	 * If either stime or utime are 0, assume all runtime is userspace.
>  	 * Once a task gets some ticks, the monotonicity code at 'update:'
>  	 * will ensure things converge to the observed ratio.
>  	 */
>  	if (stime == 0) {
> -		utime = rtime;
> +		delta_utime = delta_rtime;
>  		goto update;
>  	}
>  
>  	if (utime == 0) {
> -		stime = rtime;
> +		delta_stime = delta_rtime;
>  		goto update;
>  	}
>  
> -	stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
> +	if (delta_stime <= 0)
> +		goto update;
> +
> +	if (delta_utime <= 0)
> +		goto update;

Those things really should not be negative; see the initial goto out.

> +
> +	delta_stime = mul_u64_u64_div_u64(delta_stime, delta_rtime, delta_stime + delta_utime);

So the primary difference is that while the previous code maintained the
stime:utime ratio, this does not. I'm not sure that actually matters,
but it isn't called out and no argument is made.

In fact the Changelog is very sparse on actual details.

>  
>  update:
>  	/*
> @@ -606,21 +621,22 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
>  	 *            = (rtime_i+1 - rtime_i) + utime_i
>  	 *            >= utime_i
>  	 */
> -	if (stime < prev->stime)
> -		stime = prev->stime;
> -	utime = rtime - stime;
> +	if (delta_stime <= 0)
> +		delta_stime = 0;

Is this really still valid? The previous case was because we retained
the stime:utime ratio and this enforced monotinicity, but this should be
covered in the above condition if at all.

> +	delta_utime = delta_rtime - delta_stime;
> +
>  
>  	/*
>  	 * Make sure utime doesn't go backwards; this still preserves
>  	 * monotonicity for stime, analogous argument to above.
>  	 */
> -	if (utime < prev->utime) {
> -		utime = prev->utime;
> -		stime = rtime - utime;
> +	if (delta_utime <= 0) {
> +		delta_utime = 0;
> +		delta_stime = delta_rtime;
>  	}

idem.

>  
> -	prev->stime = stime;
> -	prev->utime = utime;
> +	prev->stime += delta_stime;
> +	prev->utime += delta_utime;
>  out:
>  	*ut = prev->utime;
>  	*st = prev->stime;
> -- 
> 2.20.1
> 
