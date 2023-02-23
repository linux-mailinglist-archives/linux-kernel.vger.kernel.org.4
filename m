Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416286A0B11
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjBWNqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbjBWNqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:46:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B4C584BD;
        Thu, 23 Feb 2023 05:46:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 469916170C;
        Thu, 23 Feb 2023 13:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F5AC433D2;
        Thu, 23 Feb 2023 13:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677159915;
        bh=2pri+T/s3WCeS8rc0Z1BvEcngNYcJQ1Atpo18KxCzEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rl7xb/+rSv7I+dvIXh90eCDQkh1VnIAC5dOu+0gUuKGlIuNMURPtlxq9LZWmOyFUa
         sD2ihI+ZlnCj4Kji00LahaWxVNtnyEf3+MioiYaENBUC+hvfNMH+pfskrEyq7B0VEi
         Zysq2gqfcczMuUTCGIOiCzmLC+Eov9hX/BOiD++RcK3bMhZgIrIjG73tvc0A3DMZku
         UtcMoL9eJpJIDpn6qHT8nIXEB0uqrbng3+UuW5F/ERwPsK5J8dUTjM+XgT4SJQAKmA
         TNSGcFXaDQHHK4D33jwnHMnVNmJms9cgVD4/b/g/QBSz5MeT52CySdyvy6Op9e1dwd
         hL5ZPuUzg4SYg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1B8714049F; Thu, 23 Feb 2023 10:45:13 -0300 (-03)
Date:   Thu, 23 Feb 2023 10:45:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Changbin Du <changbin.du@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hui Wang <hw.huiwang@huawei.com>
Subject: Re: [PATCH] perf: fix counting when initial delay configured
Message-ID: <Y/dt6QpsCj5AAUE/@kernel.org>
References: <20230223075800.1795777-1-changbin.du@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223075800.1795777-1-changbin.du@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 23, 2023 at 03:58:00PM +0800, Changbin Du escreveu:
> When creating counters with initial delay configured, the enable_on_exec
> field is not set. So we need to enable the counters later. The problem
> is, when a workload is specified the target__none() is still true. So
> we also need to check stat_config.initial_delay.
> 
> Before this fix the event is not counted:
> $ ./perf stat -e instructions -D 100 sleep 2
> Events disabled
> Events enabled
> 
>  Performance counter stats for 'sleep 2':
> 
>      <not counted>      instructions
> 
>        1.901661124 seconds time elapsed
> 
>        0.001602000 seconds user
>        0.000000000 seconds sys
> 
> After fix it works:
> $ ./perf stat -e instructions -D 100 sleep 2
> Events disabled
> Events enabled
> 
>  Performance counter stats for 'sleep 2':
> 
>            404,214      instructions
> 
>        1.901743475 seconds time elapsed
> 
>        0.001617000 seconds user
>        0.000000000 seconds sys
> 
> Fixes: c587e77e100f ("perf stat: Do not delay the workload with --delay")

Yeap, even the comment states that we need to enable when initial_delay
is set :-)

I added the additional test output below.

Namhyung, can you please ack it?

- Arnaldo

Committer testing:

Before:

Lets use stress-ng so that we have lots of samples using a CPU stressor
and also intermingle the workload output with the messages about when
the events get enabled (i.e. later on in the workload):

  $ perf stat -e instructions -D 100 stress-ng -c 32 -t 1
  Events disabled
  stress-ng: info:  [38361] setting to a 1 second run per stressor
  stress-ng: info:  [38361] dispatching hogs: 32 cpu
  Events enabled
  stress-ng: info:  [38361] successful run completed in 1.01s

   Performance counter stats for 'stress-ng -c 32 -t 1':

       <not counted>      instructions:u

         0.916479141 seconds time elapsed

        30.868003000 seconds user
         0.049851000 seconds sys


  Some events weren't counted. Try disabling the NMI watchdog:
        echo 0 > /proc/sys/kernel/nmi_watchdog
        perf stat ...
        echo 1 > /proc/sys/kernel/nmi_watchdog
  $

After the fix:

  $ perf stat -e instructions -D 100 stress-ng -c 32 -t 1
  Events disabled
  stress-ng: info:  [40429] setting to a 1 second run per stressor
  stress-ng: info:  [40429] dispatching hogs: 32 cpu
  Events enabled
  stress-ng: info:  [40429] successful run completed in 1.01s

   Performance counter stats for 'stress-ng -c 32 -t 1':

        154117865145      instructions:u

         0.920827644 seconds time elapsed

        30.864753000 seconds user
         0.073862000 seconds sys


  $

> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  tools/perf/builtin-stat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 9f3e4b257516..c71d85577de6 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -544,7 +544,7 @@ static int enable_counters(void)
>  	 * - we don't have tracee (attaching to task or cpu)
>  	 * - we have initial delay configured
>  	 */
> -	if (!target__none(&target)) {
> +	if (!target__none(&target) || stat_config.initial_delay) {
>  		if (!all_counters_use_bpf)
>  			evlist__enable(evsel_list);
>  	}
> -- 
> 2.25.1
> 

-- 

- Arnaldo
