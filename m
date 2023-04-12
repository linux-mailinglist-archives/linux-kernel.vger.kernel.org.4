Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1176DF76B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjDLNje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjDLNja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:39:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF7649C2;
        Wed, 12 Apr 2023 06:39:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 165AD6353E;
        Wed, 12 Apr 2023 13:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C06C4339E;
        Wed, 12 Apr 2023 13:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681306768;
        bh=GOykW6XA+0igU5TTxTnc1Z+ANk1/amyaw2FES3+7QbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S06GYfa0tW/T6dAqB6kE/T7Ra7by1ctHfjP+AKCOzRCWE7jX3z97ZKg/Q5z5v8r2s
         kf1P8tn30DVeWBZE269ec6ASQNBGVrVw7s/Yk5K7DQVqwAdaRZpyuOHvJPCDJSzigX
         F4yKv0gyqSeYA04L9VZXXo1iEqxSZZu5KmqqE8GE8SxGRYdedjHGeN1xq1+nC7dAXt
         YvmBiNDGhFHsS2zS6Pr471UcjrSjx3oy/pJGKkbdaKzKVa2kLjv242x90zmCybbEcx
         BR2QAipN/RjOwXU32U82VD9PYDfLcjIzM2Kd7NYiS7hVF0fsZ7AoHrYxlDfHVbDTjH
         xKbeV3CRb36VQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F115840080; Wed, 12 Apr 2023 10:39:25 -0300 (-03)
Date:   Wed, 12 Apr 2023 10:39:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Hangliang Lai <laihangliang1@huawei.com>
Cc:     namhyung@kernel.org, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, brauner@kernel.org,
        hewenliang4@huawei.com, irogers@google.com, jolsa@kernel.org,
        linfeilong@huawei.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, liuwenyu7@huawei.com,
        mark.rutland@arm.com, mingo@redhat.com, yeyunfeng@huawei.com
Subject: Re: [PATCH v4] perf top: expand the range of multithreaded phase
Message-ID: <ZDa0jXAk0F+tLw1V@kernel.org>
References: <CAM9d7cjy-XivELAgq49YF9RKxFZ3M+H3V6s6zVboenRT3oRFDA@mail.gmail.com>
 <20230411013224.2079-1-laihangliang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411013224.2079-1-laihangliang1@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 11, 2023 at 09:32:24AM +0800, Hangliang Lai escreveu:
> In __cmd_top, perf_set_multithreaded is used to enable pthread_rwlock, thus
> donw_read and down_write can work to handle concurrency problems. Then top
> use perf_set_singlethreaded and switch to single threaded phase, assuming
> that no thread concurrency will happen later.
> However, a UAF problem could occur in perf top in single threaded phase,
> The concurrent procedure is like this:
> display_thread                              process_thread
> --------------                              --------------
> thread__comm_len
>   -> thread__comm_str
>     -> __thread__comm_str(thread)
>                                             thread__delete
>                                              -> comm__free
>                                               -> comm_str__put
>                                                -> zfree(&cs->str)
>     -> thread->comm_len = strlen(comm);
> Since in single thread phase, perf_singlethreaded is true, down_read and
> down_write can not work to avoid concurrency problems.
> This patch put perf_set_singlethreaded to the function tail to expand the
> multithreaded phase range, make display_thread and process_thread run
> safe.
> 
> Signed-off-by: Hangliang Lai  <laihangliang1@huawei.com>
> Co-developed-by: Wenyu Liu <liuwenyu7@huawei.com>
> Reviewed-by: Yunfeng Ye <yeyunfeng@huawei.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo


> ---
> v3 -> v4
>  - Add Acked-by and Co-developed-by. 
> 
>  tools/perf/builtin-top.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index d4b5b02bab73..ae96ddaf85c4 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1273,8 +1273,7 @@ static int __cmd_top(struct perf_top *top)
>  				    top->evlist->core.threads, true, false,
>  				    top->nr_threads_synthesize);
>  
> -	if (top->nr_threads_synthesize > 1)
> -		perf_set_singlethreaded();
> +	perf_set_multithreaded();
>  
>  	if (perf_hpp_list.socket) {
>  		ret = perf_env__read_cpu_topology_map(&perf_env);
> @@ -1352,6 +1351,7 @@ static int __cmd_top(struct perf_top *top)
>  out_join_thread:
>  	cond_signal(&top->qe.cond);
>  	pthread_join(thread_process, NULL);
> +	perf_set_singlethreaded();
>  	return ret;
>  }
>  
> -- 
> 2.33.0
> 

-- 

- Arnaldo
