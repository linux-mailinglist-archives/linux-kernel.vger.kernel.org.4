Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB59A6BD6D0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjCPRP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjCPRPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:15:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7822818176;
        Thu, 16 Mar 2023 10:15:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DFDE620B3;
        Thu, 16 Mar 2023 17:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99003C433D2;
        Thu, 16 Mar 2023 17:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678986953;
        bh=paYpboia4VxrbfCtT7DOi0TFcUA2l2m0b6vVWEPCcpQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DCFTD87d1LgeIPlMHHQndU91cdYEz+J0z4jZkrWPsQmcHTFgQaev0mcysL6rNzWof
         OUszJ5pWE+IS1uaIvrSOWOZ0nZtI7jvCD3ERiXi+MJoOvK9DrjQkwhCmmX2hCelU9Q
         1ObRa8JzKpZRgqwi2lbe1FgvkUmI239SRdEzGSuE8GCq0OKTE3qrBiqYXwEKE+/qZt
         tO3y6eLZi5+mavlnL+F0SR+jcoHZva1fuDYMMV08eA3zdZhuTkyTub5ZbNnR7/SJTa
         ewNrzZACCZIDtH3w8J2u3m9vTzH1RFE9Y/vhuBbjfjI16nGyGDx6brv7GEeF7h6pmm
         vgt8pOH6L9lpA==
Message-ID: <51e64093-5e2f-18fa-db04-8d6789362921@kernel.org>
Date:   Thu, 16 Mar 2023 18:15:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] tracing/hwlat: Replace sched_setaffinity with
 set_cpus_allowed_ptr
To:     Costa Shulyupin <costa.shul@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "open list:TRACING" <linux-kernel@vger.kernel.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>
Cc:     bwensley@redhat.com, constantine.shulyupin@gmail.com
References: <20230316144535.1004952-1-costa.shul@redhat.com>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230316144535.1004952-1-costa.shul@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/23 15:45, Costa Shulyupin wrote:
> There is a problem with the behavior of hwlat in a container,
> resulting in incorrect output. A warning message is generated:
> "cpumask changed while in round-robin mode, switching to mode none",
> and the tracing_cpumask is ignored. This issue arises because
> the kernel thread, hwlatd, is not a part of the container, and
> the function sched_setaffinity is unable to locate it using its PID.
> Additionally, the task_struct of hwlatd is already known.
> Ultimately, the function set_cpus_allowed_ptr achieves
> the same outcome as sched_setaffinity, but employs task_struct
> instead of PID.
> 
> Test case:
> 
>   # cd /sys/kernel/tracing
>   # echo 0 > tracing_on
>   # echo round-robin > hwlat_detector/mode
>   # echo hwlat > current_tracer
>   # unshare --fork --pid bash -c 'echo 1 > tracing_on'
>   # dmesg -c
> 
> Actual behavior:
> 
> [573502.809060] hwlat_detector: cpumask changed while in round-robin mode, switching to mode none
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

I tested it and... it works.

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks
-- Daniel

> ---
>  kernel/trace/trace_hwlat.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
> index d440ddd5fd8b..444dfc31f258 100644
> --- a/kernel/trace/trace_hwlat.c
> +++ b/kernel/trace/trace_hwlat.c
> @@ -339,7 +339,7 @@ static void move_to_next_cpu(void)
>  	cpumask_clear(current_mask);
>  	cpumask_set_cpu(next_cpu, current_mask);
>  
> -	sched_setaffinity(0, current_mask);
> +	set_cpus_allowed_ptr(current, current_mask);
>  	return;
>  
>   change_mode:
> @@ -446,7 +446,7 @@ static int start_single_kthread(struct trace_array *tr)
>  
>  	}
>  
> -	sched_setaffinity(kthread->pid, current_mask);
> +	set_cpus_allowed_ptr(kthread, current_mask);
>  
>  	kdata->kthread = kthread;
>  	wake_up_process(kthread);

