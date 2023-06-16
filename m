Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30A87339E7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjFPTbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjFPTbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:31:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F2D119
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 12:31:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B28C262F9C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 19:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911E3C433C8;
        Fri, 16 Jun 2023 19:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686943906;
        bh=KY1WurBWJVnkh28N5jk+SF7UxrRic16Ct16Uf95iD/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qjtiRDPGpGU7cNZSie7YNmOLFCFwuHGmzy8IoHjmtjzcgxTHU/LrWNSz69C2LVP78
         PvxaE0sfKQXpGGlQtlXV7iDL5pnQSQ2F96YOQV540/T4tw308iYlmvWzy3S0+rmVLE
         25I3X0n+RVyGqzApU7VdO8B1UIWIVBIE2EJpzMgo=
Date:   Fri, 16 Jun 2023 12:31:44 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Adam Majer <amajer@suse.com>, Jan Kara <jack@suse.cz>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] mm: Sync percpu mm RSS counters before querying
Message-Id: <20230616123144.bd2a8120dab25736c5c37297@linux-foundation.org>
In-Reply-To: <20230616180718.17725-1-mkoutny@suse.com>
References: <20230616180718.17725-1-mkoutny@suse.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2023 20:07:18 +0200 Michal Koutný <mkoutny@suse.com> wrote:

> An issue was observed with stats collected in struct rusage on ppc64le
> with 64kB pages. The percpu counters use batching with
> 	percpu_counter_batch = max(32, nr*2) # in PAGE_SIZE
> i.e. with larger pages but similar RSS consumption (bytes), there'll be
> less flushes and error more noticeable.

A fully detailed description of the issue would be helpful.  Obviously
"inaccuracy", but how bad?

> In this given case (getting consumption of exited child), we can request
> percpu counter's flush without worrying about contention with updaters.
> 
> Fortunately, the commit f1a7941243c1 ("mm: convert mm's rss stats into
> percpu_counter") didn't eradicate all traces of SPLIT_RSS_COUNTING and
> this mechanism already provided some synchronization points before
> reading stats.
> Therefore, use sync_mm_rss as carrier for percpu counters refreshes and
> forget SPLIT_RSS_COUNTING macro for good.
> 
> Impact of summing on a 8 CPU machine:
> Benchmark 1: taskset -c 1 ./shell-bench.sh
> 
> Before
>   Time (mean ± σ):      9.950 s ±  0.052 s    [User: 7.773 s, System: 2.023 s]
> 
> After
>   Time (mean ± σ):      9.990 s ±  0.070 s    [User: 7.825 s, System: 2.011 s]
> 
> cat >shell-bench.sh <<EOD
> for (( i = 0; i < 20000; i++ )); do
> 	/bin/true
> done
> EOD
> 
> The script is meant to stress fork-exit path (exit is where sync_mm_rss
> is most called, add_mm_rss_vec should be covered in fork).
> 
> ...
>
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2547,13 +2547,12 @@ static inline void setmax_mm_hiwater_rss(unsigned long *maxrss,
>  		*maxrss = hiwater_rss;
>  }
>  
> -#if defined(SPLIT_RSS_COUNTING)
> -void sync_mm_rss(struct mm_struct *mm);
> -#else
>  static inline void sync_mm_rss(struct mm_struct *mm)
>  {
> +	for (int i = 0; i < NR_MM_COUNTERS; ++i)
> +		percpu_counter_set(&mm->rss_stat[i],
> +				   percpu_counter_sum(&mm->rss_stat[i]));
>  }
> -#endif

Far too large to be inlined!  For six callsites it adds 1kb of text.

Why even modify the counter?  Can't <whatever this issue is> be
addressed by using percpu_counter_sum() in an appropriate place?

For unknown reasons percpu_counter_set() uses for_each_possible_cpu(). 
Probably just a mistake - percpu_counters are hotplug-aware and
for_each_online_cpu should suffice.

I'm really not liking percpu_counter_set().  It's only safe in
situations where the caller knows that no other CPU can be modifying
the counter.  I wonder if all the callers know that.  This situation
isn't aided by the lack of any documentation.
