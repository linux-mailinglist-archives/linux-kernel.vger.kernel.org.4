Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E16A5B38DB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiIINXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiIINXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:23:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF55E10E847;
        Fri,  9 Sep 2022 06:22:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F3DCB824F2;
        Fri,  9 Sep 2022 13:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9595BC433D6;
        Fri,  9 Sep 2022 13:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662729776;
        bh=0qlI03x70o2stWy2Z82lL0xNFhhXGdqy1dPrjQ/6HAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y9fbyNCpBxmzwrne7N/iOw35GYyjk2ttvIyDSY2TfIHTGGXOfH/JJpDnc01K9nxxI
         CdceMka/P8vqu2O2d+YlRQam4nS6m490jxmx0yezCgNcgpLPeLyPvHww96rUcES/Uk
         t3BwQaHPH9DjnPrRqW1qEIljVb+GU8g9pass8cNU7645aBe/AW0A2HGI95YzbC/ouE
         ObwZafEPYaanMwt60As0HxHFEbVdoylo3UT2+hoQGUKnC7OoE864I3Slz9FAqJrdMg
         UBo/Eju3ZX3cl/CLcK3U7SugzMEfsRM51xMyIWZdBUkJUI9xJeMKGWEQ+csmWCyMPD
         GBGhPYCK1SDnA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B675F404A1; Fri,  9 Sep 2022 10:22:53 -0300 (-03)
Date:   Fri, 9 Sep 2022 10:22:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf sched: Factor out destroy_tasks()
Message-ID: <Yxs+LbaBWrUhLBgw@kernel.org>
References: <20220908225448.4105056-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908225448.4105056-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 08, 2022 at 03:54:48PM -0700, Namhyung Kim escreveu:
> Add destroy_tasks() as a counterpart of create_tasks() and put the
> thread safety notations there.  After join, it destroys semaphores too.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-sched.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index a92610eac4bf..f93737eef07b 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -690,6 +690,27 @@ static void create_tasks(struct perf_sched *sched)
>  	}
>  }
>  
> +static void destroy_tasks(struct perf_sched *sched)
> +	UNLOCK_FUNCTION(sched->start_work_mutex)
> +	UNLOCK_FUNCTION(sched->work_done_wait_mutex)
> +{
> +	struct task_desc *task;
> +	unsigned long i;
> +	int err;
> +
> +	mutex_unlock(&sched->start_work_mutex);
> +	mutex_unlock(&sched->work_done_wait_mutex);
> +	/* Get rid of threads so they won't be upset by mutex destrunction */
> +	for (i = 0; i < sched->nr_tasks; i++) {
> +		task = sched->tasks[i];
> +		err = pthread_join(task->thread, NULL);
> +		BUG_ON(err);
> +		sem_destroy(&task->sleep_sem);
> +		sem_destroy(&task->ready_for_work);
> +		sem_destroy(&task->work_done_sem);
> +	}
> +}
> +
>  static void wait_for_tasks(struct perf_sched *sched)
>  	EXCLUSIVE_LOCKS_REQUIRED(sched->work_done_wait_mutex)
>  	EXCLUSIVE_LOCKS_REQUIRED(sched->start_work_mutex)
> @@ -3324,8 +3345,7 @@ static int perf_sched__replay(struct perf_sched *sched)
>  		run_one_test(sched);
>  
>  	sched->thread_funcs_exit = true;
> -	mutex_unlock(&sched->start_work_mutex);
> -	mutex_unlock(&sched->work_done_wait_mutex);
> +	destroy_tasks(sched);
>  	return 0;
>  }
>  
> -- 
> 2.37.2.789.g6183377224-goog

-- 

- Arnaldo
