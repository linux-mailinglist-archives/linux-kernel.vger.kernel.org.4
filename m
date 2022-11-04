Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B9F61A556
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 00:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiKDXGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 19:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKDXF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 19:05:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9E642999
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 16:05:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07CB261A59
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 23:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F69C433D7;
        Fri,  4 Nov 2022 23:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1667603153;
        bh=Rw/MCWcvLjCJ/UWizKXePGmZvqTCn6fbSwOgN113JjU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MjklJDPHV10dl3G3Mc3kX/3WBeuIFfo+ldITzNm0LKr27MJrZLTXB0dA6tQLoVdLu
         YiqFyit8Xt8MmuzxlgmCoREIG472Rm/9MGgnBHaR6aG+JQNAEUI3P8M0/ulLEZ1o5i
         jnM3C0OVq++n5h8Jk3dy5fh8BWTma5R0EiSRMUTw=
Date:   Fri, 4 Nov 2022 16:05:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: convert mm's rss stats into percpu_counter
Message-Id: <20221104160552.c249397512c5c7f8b293869f@linux-foundation.org>
In-Reply-To: <20221103171407.ydubp43x7tzahriq@google.com>
References: <20221024052841.3291983-1-shakeelb@google.com>
        <CGME20221102210957eucas1p2915f88d8b923ccf79f0e8770d208a1bd@eucas1p2.samsung.com>
        <fb370ccf-d22a-7885-1773-da85c9d7ea8c@samsung.com>
        <20221103171407.ydubp43x7tzahriq@google.com>
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

On Thu, 3 Nov 2022 17:14:07 +0000 Shakeel Butt <shakeelb@google.com> wrote:

> 
> ...
>
> Thanks for the report. It seems like there is a race between
> for_each_online_cpu() in __percpu_counter_sum() and
> percpu_counter_cpu_dead()/cpu-offlining. Normally this race is fine for
> percpu_counter users but for check_mm() is not happy with this race. Can
> you please try the following patch:

percpu-counters supposedly avoid such races via the hotplup notifier. 
So can you please fully describe the race and let's see if it can be
fixed at the percpu_counter level?

> 
> From: Shakeel Butt <shakeelb@google.com>
> Date: Thu, 3 Nov 2022 06:05:13 +0000
> Subject: [PATCH] mm: percpu_counter: use race free percpu_counter sum
>  interface
> 
> percpu_counter_sum can race with cpu offlining. Add a new interface
> which does not race with it and use that for check_mm().

I'll grab this version for now, as others might be seeing this issue.


> ---
>  include/linux/percpu_counter.h | 11 +++++++++++
>  kernel/fork.c                  |  2 +-
>  lib/percpu_counter.c           | 24 ++++++++++++++++++------
>  3 files changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
> index bde6c4c1f405..3070c1043acf 100644
> --- a/include/linux/percpu_counter.h
> +++ b/include/linux/percpu_counter.h
> @@ -45,6 +45,7 @@ void percpu_counter_set(struct percpu_counter *fbc, s64 amount);
>  void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount,
>  			      s32 batch);
>  s64 __percpu_counter_sum(struct percpu_counter *fbc);
> +s64 __percpu_counter_sum_all(struct percpu_counter *fbc);
>  int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch);
>  void percpu_counter_sync(struct percpu_counter *fbc);
>  
> @@ -85,6 +86,11 @@ static inline s64 percpu_counter_sum(struct percpu_counter *fbc)
>  	return __percpu_counter_sum(fbc);
>  }
>  
> +static inline s64 percpu_counter_sum_all(struct percpu_counter *fbc)
> +{
> +	return __percpu_counter_sum_all(fbc);
> +}

We haven't been good about documenting these interfaces.  Can we please
start now? ;)

>
> ...
>
> +
> +/*
> + * Add up all the per-cpu counts, return the result.  This is a more accurate
> + * but much slower version of percpu_counter_read_positive()
> + */
> +s64 __percpu_counter_sum(struct percpu_counter *fbc)
> +{
> +	return __percpu_counter_sum_mask(fbc, cpu_online_mask);
> +}
>  EXPORT_SYMBOL(__percpu_counter_sum);
>  
> +s64 __percpu_counter_sum_all(struct percpu_counter *fbc)
> +{
> +	return __percpu_counter_sum_mask(fbc, cpu_possible_mask);
> +}
> +EXPORT_SYMBOL(__percpu_counter_sum_all);

Probably here is a good place to document it.

Is there any point in having the
percpu_counter_sum_all()->__percpu_counter_sum_all() inlined wrapper? 
Why not name this percpu_counter_sum_all() directly?

>  int __percpu_counter_init(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
>  			  struct lock_class_key *key)
>  {
> -- 
> 2.38.1.431.g37b22c650d-goog
