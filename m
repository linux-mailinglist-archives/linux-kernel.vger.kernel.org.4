Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1BE6A8185
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjCBLuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCBLuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:50:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764B516313;
        Thu,  2 Mar 2023 03:49:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18A38B811D5;
        Thu,  2 Mar 2023 11:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93833C433D2;
        Thu,  2 Mar 2023 11:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677757796;
        bh=kISUd984NFkh845jniWJy2ik9HyMHSZeIQWhpEj02M0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=s7i81caKyadNyGN+BIhicOUkLw0eQbZXKjlT/xxuJyetXO2mmUHGZgCBfZhpQfVJ1
         hMfet/zE2xVJSW2xXclErqUCsN9AouemyGJIpoyfK5zch4g0ft9R/uNnaOz259+AFx
         Y+Mu1c3psVTPuO+ZxfNhnaqLNeFKXglPCIciRj9sbon4C4Ai7eacM8pk5puTVmTIiE
         RzZz9wiFsMjrAcfcBhKpsBqm+MyywZr9GklPkok8gH8Mt8CzqijG446p2983L/GMTk
         xoiqDmRp5Iq8bjeD+qxjopZjYKhwlIIii9/M6XA8W9DJSiIfm/I4p2IpzDPLrN6vlw
         CxOXfPZLYUhkw==
Message-ID: <92700518-46e3-88af-9be1-db18767754f5@kernel.org>
Date:   Thu, 2 Mar 2023 08:49:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] trace/hwlat: Do not restart per-cpu threads if they are
 already running
To:     Tero Kristo <tero.kristo@linux.intel.com>, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230302113654.2984709-1-tero.kristo@linux.intel.com>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230302113654.2984709-1-tero.kristo@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tero,

On 3/2/23 08:36, Tero Kristo wrote:
> Check if the hwlatd thread for the cpu is already running, before
> starting a new one. This avoids running multiple instances of the same
> CPU thread on the system. Also, do not wipe the contents of the
> per-cpu kthread data when starting the tracer, as this can completely
> forget about already running instances and start new additional per-cpu
> threads. Fixes issues where fiddling with either the mode of the hwlat
> tracer or doing cpu-hotplugs messes up the internal book-keeping
> resulting in stale hwlatd threads.

Thanks for your patch.

Would you mind explaining how do you hit the problem? that is, how can
I reproduce the same problem you faced.

I tried reproducing it by dispatching the hwlat tracer in two instances,
but the system already blocks me...

[root@vm tracing]# echo hwlat > current_tracer 
[root@vm tracing]# cd instances/
[root@vm instances]# mkdir hwlat_2
[root@vm instances]# cd hwlat_2/
[root@vm hwlat_2]# echo hwlat > current_tracer 
-bash: echo: write error: Device or resource busy

[root@vm hwlat_2]# cd ../../
[root@vm tracing]# echo nop > current_tracer 
[root@vm tracing]# cd instances/hwlat_2/
[root@vm hwlat_2]# echo hwlat > current_tracer 
[root@vm hwlat_2]# cd ..
[root@vm instances]# mkdir hwlat_1
[root@vm instances]# cd hwlat_1/
[root@vm hwlat_1]# echo hwlat > current_tracer 
-bash: echo: write error: Device or resource busy
[root@vm hwlat_1]# 

Having a reproducer helps us to think better about the problem.

-- Daniel

> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> ---
>  kernel/trace/trace_hwlat.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
> index d440ddd5fd8b..c4945f8adc11 100644
> --- a/kernel/trace/trace_hwlat.c
> +++ b/kernel/trace/trace_hwlat.c
> @@ -492,6 +492,10 @@ static int start_cpu_kthread(unsigned int cpu)
>  {
>  	struct task_struct *kthread;
>  
> +	/* Do not start a new hwlatd thread if it is already running */
> +	if (per_cpu(hwlat_per_cpu_data, cpu).kthread)
> +		return 0;
> +
>  	kthread = kthread_run_on_cpu(kthread_fn, NULL, cpu, "hwlatd/%u");
>  	if (IS_ERR(kthread)) {
>  		pr_err(BANNER "could not start sampling thread\n");
> @@ -584,9 +588,6 @@ static int start_per_cpu_kthreads(struct trace_array *tr)
>  	 */
>  	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
>  
> -	for_each_online_cpu(cpu)
> -		per_cpu(hwlat_per_cpu_data, cpu).kthread = NULL;
> -
>  	for_each_cpu(cpu, current_mask) {
>  		retval = start_cpu_kthread(cpu);
>  		if (retval)

