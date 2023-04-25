Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFD76EE231
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 14:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbjDYMtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 08:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjDYMtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:49:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E21CC31
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 05:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=0j1x500/CHKwQ6826jwu1CrwS05m7/9cJG6OTTcmywo=; b=Q7m9Rd3zJmQ3umHWHouAecuUVZ
        ocO/LgPzKCARNTu1JAh0+lbzn/XFcki03Md5sU4OciqnXOsA1v7NqyRRTlWjjIO91ruDImjM+eAsx
        aNlXG0+4bFqn2owySLde5EWyxNSwGjURfVxFnwiIgN//AxlQVsje2JbJXbhYOj5nRwdUrgp3xlI3V
        88A8ikEfA2zRLR6uE5kgYBOu9I9dOGowj2o1eeLEw+zhckBoTs04jcMb/kXrrzgNrBcb+7sH7n/pv
        A81Mdq8DB5TW+dDC27CksLbEgSeZMNawk5sVgQcx0J5SNVFh6zrrs8IQP/P49ncebbSjdLmybps9H
        YbeVtN1w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1prI6N-001RtJ-4I; Tue, 25 Apr 2023 12:48:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 54983300380;
        Tue, 25 Apr 2023 14:48:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF799241BA676; Tue, 25 Apr 2023 14:48:56 +0200 (CEST)
Date:   Tue, 25 Apr 2023 14:48:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?5pmP6ImzKOmHh+iLkyk=?= <yanyan.yan@antgroup.com>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?B?6LCI6Ym06ZSL?= <henry.tjf@antgroup.com>,
        Tiwei Bie <tiwei.btw@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v1 1/3] sched/debug: use int type and fix wrong print for
 rq->nr_uninterruptible
Message-ID: <20230425124856.GE1335080@hirez.programming.kicks-ass.net>
References: <20230412030731.24990-1-yanyan.yan@antgroup.com>
 <20230412030731.24990-2-yanyan.yan@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230412030731.24990-2-yanyan.yan@antgroup.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 11:07:29AM +0800, 晏艳(采苓) wrote:
> commit e6fe3f422be1 ("sched: Make multiple runqueue task counters
> 32-bit") changed rq->nr_uninterruptible from 'unsigned long'
> to 'unsigned int', but left the wrong print to
> /sys/kernel/debug/sched/debug and to the console.
> 
> For example:
> Current type is 'unsigned int' and value is fffffff7, and the print
> will run the sentences,
> "do {                                    \
>     if (sizeof(rq->x) == 4)                     \
>         SEQ_printf(m, "  .%-30s: %ld\n", #x, (long)(rq->x));    \

Arguably this is wrong, because LP64 has sizeof(long) != 4. This ought
to be something like:

+               SEQ_printf(m, "  .%-30s: %d\n", #x, (int)(rq->x));      \

>     else                                \
>         SEQ_printf(m, "  .%-30s: %Ld\n", #x, (long long)(rq->x));\
> } while (0)"
> 
> The result will be 4294967287 on 64-bit machines to print (long)(rq->x)
> while old type 'unsigned long' will print -9.
> 
> And the other places that use its value will cast to int to return
> expected output, so we convert its type from 'unsigned int' to int.
> 
> Signed-off-by: Yan Yan <yanyan.yan@antgroup.com>
> ---
>  kernel/sched/loadavg.c | 2 +-
>  kernel/sched/sched.h   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
> index 52c8f8226b0d..b9867495fe8b 100644
> --- a/kernel/sched/loadavg.c
> +++ b/kernel/sched/loadavg.c
> @@ -80,7 +80,7 @@ long calc_load_fold_active(struct rq *this_rq, long adjust)
>  	long nr_active, delta = 0;
>  
>  	nr_active = this_rq->nr_running - adjust;
> -	nr_active += (int)this_rq->nr_uninterruptible;
> +	nr_active += this_rq->nr_uninterruptible;
>  
>  	if (nr_active != this_rq->calc_load_active) {
>  		delta = nr_active - this_rq->calc_load_active;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 060616944d7a..23c643948331 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1006,7 +1006,7 @@ struct rq {
>  	 * one CPU and if it got migrated afterwards it may decrease
>  	 * it on another CPU. Always updated under the runqueue lock:
>  	 */
> -	unsigned int		nr_uninterruptible;
> +	int			nr_uninterruptible;

Bit meh on this; but I suppose since calc_load_fold_active() already had
an explicit cast, it won't make the 'but signed overflow is UB' crowd
more unhappy.
