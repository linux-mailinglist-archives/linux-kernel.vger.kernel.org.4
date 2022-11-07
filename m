Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9BB62005C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbiKGVIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbiKGVIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:08:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CA430F60
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 13:06:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E2296130B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 21:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1765C433D6;
        Mon,  7 Nov 2022 21:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1667855150;
        bh=pCGvl5DYveYXMsDaHTopb0oM8wkmKavzUHbdH4jUHgs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tgABxHVouokz8n3DnNqt2QSAGMehXffif3y6AoDURdpIahOWz9R/WY0PNVfXlR7wf
         Sll1NyfTfyJc/CpP3M+JiDAOsfmQkStRd6xg8QskDT8A8odu20JRewB/vehrD94F6R
         31Espiy8bS89tn4UTE+wN7bskNqkQUFsjn9/Ovps=
Date:   Mon, 7 Nov 2022 13:05:49 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] percpu_counter: add percpu_counter_sum_all interface
Message-Id: <20221107130549.db68c48afe5f711b2e99c5c0@linux-foundation.org>
In-Reply-To: <20221105014013.930636-1-shakeelb@google.com>
References: <20221105014013.930636-1-shakeelb@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  5 Nov 2022 01:40:13 +0000 Shakeel Butt <shakeelb@google.com> wrote:

> The percpu_counter is used for scenarios where performance is more
> important than the accuracy. For percpu_counter users, who want more
> accurate information in their slowpath, percpu_counter_sum is provided
> which traverses all the online CPUs to accumulate the data. The reason
> it only needs to traverse online CPUs is because percpu_counter does
> implement CPU offline callback which syncs the local data of the
> offlined CPU.
> 
> However there is a small race window between the online CPUs traversal
> of percpu_counter_sum and the CPU offline callback. The offline callback
> has to traverse all the percpu_counters on the system to flush the CPU
> local data which can be a lot. During that time, the CPU which is going
> offline has already been published as offline to all the readers. So, as
> the offline callback is running, percpu_counter_sum can be called for
> one counter which has some state on the CPU going offline. Since
> percpu_counter_sum only traverses online CPUs, it will skip that
> specific CPU and the offline callback might not have flushed the state
> for that specific percpu_counter on that offlined CPU.

OK, got it, thanks.

> Normally this is not an issue because percpu_counter users can deal with
> some inaccuracy for small time window. However a new user i.e. mm_struct
> on the cleanup path wants to check the exact state of the percpu_counter
> through check_mm(). For such users, this patch introduces
> percpu_counter_sum_all() which traverses all possible CPUs.

And uses it in fork.c:check_mm()!

> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -756,7 +756,7 @@ static void check_mm(struct mm_struct *mm)
>  			 "Please make sure 'struct resident_page_types[]' is updated as well");
>  
>  	for (i = 0; i < NR_MM_COUNTERS; i++) {
> -		long x = percpu_counter_sum(&mm->rss_stat[i]);
> +		long x = percpu_counter_sum_all(&mm->rss_stat[i]);

check_mm() just became more expensive in some cases.  nr_possible_cpus
* 4.  I wonder if this is enough for people to start caring about.

check_mm() is presently non-optional and I'd be reluctant to change
this, given how commonly we see the "BUG: Bad rss-counter state"
getting reported (22 million hits in a google search!).

We could save a ton of that cost by running percpu_counter_sum() first,
then trying percpu_counter_sum_all() if percpu_counter_sum() indicated
an error.  This is only worth bothering about if the new check_mm()
cost is a concern.


