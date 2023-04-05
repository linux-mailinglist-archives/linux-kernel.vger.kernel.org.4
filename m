Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85626D87E0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbjDEUJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjDEUJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:09:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8480983D3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 13:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7Y6iQodb8+3WzWvrWHFXtjjlmxN953XIjhiQ322zPrI=; b=nYBP6UPYWuhKAnjlzVKPzu91LH
        L7+kiazA+3VM0W/Yzo5XEAPbGbvkWKUjgIU90528EiortPXQ7kdQQMxsXbaR+rjZFroxO1iwkZvVC
        g+3hifioR9+CihjGebrZQNYl5apOVnY6Z+6RLP69NOGc8r3RKWeeqs44uowU7zJAsLtc320lcQFAn
        LlQ/rvpijtpF0d/+4P8HN//9XsNXJbFmZRP4iHXSpK7JN86n/YdxBUMQZ6l7QRSlyfIev3ULuFkd0
        d8HtcmHj5+O9UEIDTOwdWAP+ekz83BFmLqdVcBfR8kq7o88ozO9neznpCTd+FLwt/DnZ0/f4C6XCA
        BgkvnqZA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pk9Pu-00GiWX-SA; Wed, 05 Apr 2023 20:07:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 56639300194;
        Wed,  5 Apr 2023 22:07:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F16426A1B94A; Wed,  5 Apr 2023 22:07:37 +0200 (CEST)
Date:   Wed, 5 Apr 2023 22:07:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, vincent.guittot@linaro.org, jon.grimm@amd.com,
        bharata@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <20230405200737.GD365912@hirez.programming.kicks-ass.net>
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
 <20230403052233.1880567-8-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403052233.1880567-8-ankur.a.arora@oracle.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 10:22:31PM -0700, Ankur Arora wrote:
> Define TIF_ALLOW_RESCHED to allow threads to mark themselves as allowing
> rescheduling in the irqexit path with PREEMPTION_NONE/_VOLUNTARY.
> 
> This is meant to be used for long running tasks where it is
> not convenient to periodically call cond_resched().
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  arch/x86/include/asm/thread_info.h |  2 ++
>  include/linux/sched.h              | 29 +++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index f1cccba52eb9..8c18b9eaeec4 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -100,6 +100,7 @@ struct thread_info {
>  #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
>  #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
>  #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
> +#define TIF_RESCHED_ALLOW	30	/* can reschedule if needed */
>  
>  #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
> @@ -122,6 +123,7 @@ struct thread_info {
>  #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
>  #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
>  #define _TIF_ADDR32		(1 << TIF_ADDR32)
> +#define _TIF_RESCHED_ALLOW	(1 << TIF_RESCHED_ALLOW)
>  
>  /* flags to check in __switch_to() */
>  #define _TIF_WORK_CTXSW_BASE					\
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 63d242164b1a..1e7536e6d9ce 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2229,6 +2229,35 @@ static __always_inline bool need_resched(void)
>  	return unlikely(tif_need_resched());
>  }
>  
> +/*
> + * Define this in common code to avoid include hell.
> + */
> +static __always_inline bool resched_allowed(void)
> +{
> +#ifndef TIF_RESCHED_ALLOW
> +	return false;
> +#else
> +	return unlikely(test_tsk_thread_flag(current, TIF_RESCHED_ALLOW));
> +#endif
> +}
> +
> +static inline void allow_resched(void)
> +{
> +	/*
> +	 * allow_resched() allows preemption via the irqexit context.
> +	 * To ensure that we stick around on the current runqueue,
> +	 * disallow migration.
> +	 */
> +	migrate_disable();
> +	set_tsk_thread_flag(current, TIF_RESCHED_ALLOW);
> +}
> +
> +static inline void disallow_resched(void)
> +{
> +	clear_tsk_thread_flag(current, TIF_RESCHED_ALLOW);
> +	migrate_enable();
> +}

Why the migrate_disable(), that comment doesn't help much.
