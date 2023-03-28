Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF336CCA16
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 20:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjC1Sfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 14:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjC1Sft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 14:35:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66CE1BF6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 11:35:44 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r11so53552813edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 11:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680028543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o2hU/6GK4yHeI2E04kJ+wsLD2zzLn1ZOn5QkCTAS5dA=;
        b=s0OoCPYdYEkWiMM8TXR/F3G9QugCTOtdgkWp/fAicaUkKXgp2XFtYk3zAUJDnqMevi
         Xf3+4b4fd5Hu48QoqkKSoCVZsT/Yu/N42Wa9Xnu6CA1219jcL+oRyO5XLEoidveTUKxo
         n9LN1JGvmoY8hBOw5A5+2YwYwtSgihqAfZHA/SSCzYsNIbb59Gr3mxUyfBoQLyigm3lG
         H5c/SlIDP4jZ6S555S4kX6KlRLshghyMMwqgBANA/rYnynD/kB+E28gcQIpx3ZCw4xvH
         0Ozo6mqt8M0TtOo4/jZmtibYgtdp6nIfHpBDsPH0Xk+R5aSBpV0qEeiqa9Sdjd6u/uQ6
         FU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680028543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2hU/6GK4yHeI2E04kJ+wsLD2zzLn1ZOn5QkCTAS5dA=;
        b=xMe2fY68c258RazIAFnUZzDQ+D1MispJkDPsyb7BxXu+41OHwoSsKoBpc81Q6n0jSY
         UKM8Ma4Mx38+5G3qObl7cPw5N08kxAtVOxDgZpF6caGMRSdddT8KY2hdXekRPsm3ZT9U
         Y5qNQR6AUs9TyHAPB1oJACYUvDd+ZlSOB/dvIQ+u9dEdQ8A+p66+Fo/I1MyzaJN8Q/oa
         ShaTRJCd3Kxl58fNEFSVA77wABcFENnrCcpu4aD5mk4rNwr548aKe7hjuOly4dzycpUT
         nqMWjPeMp2AePGl+xA8PJAQ6ozin5ddrfAY9/r4SzTOh6mSJV/xV5UazrhGuFd22D5a8
         pChw==
X-Gm-Message-State: AAQBX9dOL3puWJwH7ByMFVQl0gas+ejlflvdIPQ73n/zqd1Y8IRb/bgc
        4xgFhow7cTwwwJHXkOwwTCw2eQ==
X-Google-Smtp-Source: AKy350bYttSe2oGRVQfhpmdTk3tJEKqV5AnnS8nas8nc2Mr9yRQPwSpOo1ua8Z0xDEcEaG7DPr+yeQ==
X-Received: by 2002:a17:907:7e8e:b0:932:dae5:2af9 with SMTP id qb14-20020a1709077e8e00b00932dae52af9mr22308243ejc.51.1680028543196;
        Tue, 28 Mar 2023 11:35:43 -0700 (PDT)
Received: from localhost ([2a02:8070:6387:ab20:5139:4abd:1194:8f0e])
        by smtp.gmail.com with ESMTPSA id xh1-20020a170906da8100b0093f83562f09sm4460301ejb.87.2023.03.28.11.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 11:35:43 -0700 (PDT)
Date:   Tue, 28 Mar 2023 14:35:41 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v1 6/9] memcg: sleep during flushing stats in safe
 contexts
Message-ID: <ZCMzfQuo9IhWVzRA@cmpxchg.org>
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-7-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328061638.203420-7-yosryahmed@google.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 06:16:35AM +0000, Yosry Ahmed wrote:
> @@ -642,24 +642,57 @@ static void __mem_cgroup_flush_stats(void)
>  	 * from memcg flushers (e.g. reclaim, refault, etc).
>  	 */
>  	if (atomic_xchg(&stats_flush_ongoing, 1))
> -		return;
> +		return false;
>  
>  	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
> -	cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
> +	return true;
> +}
> +
> +static void mem_cgroup_post_stats_flush(void)
> +{
>  	atomic_set(&stats_flush_threshold, 0);
>  	atomic_set(&stats_flush_ongoing, 0);
>  }
>  
> -void mem_cgroup_flush_stats(void)
> +static bool mem_cgroup_should_flush_stats(void)
>  {
> -	if (atomic_read(&stats_flush_threshold) > num_online_cpus())
> -		__mem_cgroup_flush_stats();
> +	return atomic_read(&stats_flush_threshold) > num_online_cpus();
> +}
> +
> +/* atomic functions, safe to call from any context */
> +static void __mem_cgroup_flush_stats_atomic(void)
> +{
> +	if (mem_cgroup_pre_stats_flush()) {
> +		cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
> +		mem_cgroup_post_stats_flush();
> +	}
> +}

I'm afraid I wasn't very nuanced with my complaint about the bool
parameter in the previous version. In this case, when you can do a
common helper for a couple of API functions defined right below it,
and the callers don't spread throughout the codebase, using bools
makes things simpler while still being easily understandable:

static void do_flush_stats(bool may_sleep)
{
	if (atomic_xchg(&stats_flush_ongoing, 1))
		return;

	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
	atomic_set(&stats_flush_threshold, 0);

	if (!may_sleep)
		cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
	else
		cgroup_rstat_flush(root_mem_cgroup->css.cgroup);

	atomic_set(&stats_flush_ongoing, 0);
}

void mem_cgroup_flush_stats(void)
{
	if (atomic_read(&stats_flush_threshold) > num_online_cpus())
		do_flush_stats(true);
}

void mem_cgroup_flush_stats_atomic(void)
{
	if (atomic_read(&stats_flush_threshold) > num_online_cpus())
		do_flush_stats(false);
}

>  void mem_cgroup_flush_stats_ratelimited(void)
>  {
>  	if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
> -		mem_cgroup_flush_stats();
> +		mem_cgroup_flush_stats_atomic();
> +}

This should probably be mem_cgroup_flush_stats_atomic_ratelimited().

(Whee, kinda long, but that's alright. Very specialized caller...)

Btw, can you guys think of a reason against moving the threshold check
into the common function? It would then apply to the time-limited
flushes as well, but that shouldn't hurt anything. This would make the
code even simpler:

static void do_flush_stats(bool may_sleep)
{
	if (atomic_read(&stats_flush_threshold) <= num_online_cpus())
		return;

	if (atomic_xchg(&stats_flush_ongoing, 1))
		return;

	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
	atomic_set(&stats_flush_threshold, 0);

	if (!may_sleep)
		cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
	else
		cgroup_rstat_flush(root_mem_cgroup->css.cgroup);

	atomic_set(&stats_flush_ongoing, 0);
}

void mem_cgroup_flush_stats(void)
{
	do_flush_stats(true);
}

void mem_cgroup_flush_stats_atomic(void)
{
	do_flush_stats(false);
}

void mem_cgroup_flush_stats_atomic_ratelimited(void)
{
	if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
		do_flush_stats(false);
}

> @@ -2845,7 +2845,7 @@ static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc)
>  	 * Flush the memory cgroup stats, so that we read accurate per-memcg
>  	 * lruvec stats for heuristics.
>  	 */
> -	mem_cgroup_flush_stats();
> +	mem_cgroup_flush_stats_atomic();

I'm thinking this one could be non-atomic as well. It's called fairly
high up in reclaim without any locks held.
