Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A86471118C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240566AbjEYRAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjEYRAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:00:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58736194;
        Thu, 25 May 2023 10:00:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8862647AF;
        Thu, 25 May 2023 17:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A629C433D2;
        Thu, 25 May 2023 17:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685034046;
        bh=NxZ51cAHmzPMD2e4CrASPFtZT14UlV6KIT2ZxbYTCKA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jTpMd7KwHu1bzXLxDMzEreVqrUCWyV9tublGIgD+EpCP5gjV+6xNOHzpVxvbEcdsB
         U82Gu2P0ETHiVYTh7/Im1vDYZc9n0xpc8GD89NDTOI5Jwi7Cf8gVfko5FtyBmHEtSG
         NnNvtxTMlQT86JZHnstd8mSQjRBluqrd5dL6OjfB9Ca5VcelPnfhsvefG1qALumdll
         MPBHlisPKWPYM8v9h+eEDhN162kDpCabhbGFr9LR+kjFfEFkqR2PUidHWSuFXnHxip
         0o3g7Uwmn9+4DVevDq97WlZgJbTPPz2lF898klWzvdZmiWLu3rUuIi/FPpr3CSO04i
         NT4f7Bivgjrug==
Message-ID: <67720a34-7519-0974-1fe6-7200f1c59ae0@kernel.org>
Date:   Thu, 25 May 2023 19:00:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 3/3] tracing/timerlat: Add user-space interface
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <cover.1684860626.git.bristot@kernel.org>
 <a7b2c215c763e95a56fa1258743332b570c81c9d.1684860626.git.bristot@kernel.org>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <a7b2c215c763e95a56fa1258743332b570c81c9d.1684860626.git.bristot@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

>  
> +static void check_timerlat_user_migration(pid_t pid, long dest_cpu);
>  /*
>   * trace_sched_switch - sched:sched_switch trace event handler
>   *
> @@ -1196,6 +1199,9 @@ trace_sched_switch_callback(void *data, bool preempt,
>  	struct osnoise_variables *osn_var = this_cpu_osn_var();
>  	int workload = test_bit(OSN_WORKLOAD, &osnoise_options);
>  
> +	if (unlikely(workload && timerlat_enabled()))
> +		check_timerlat_user_migration(n->pid, smp_processor_id());
> +

it should be !workload, anyway, I will move this check to a sched_migrate_task
tracepoint because it runs less frequently and...

[...]

the tracepoint also informs the origin CPU, so it can be passed here:

> +
> +static void check_timerlat_user_migration(pid_t pid, long dest_cpu)
> +{
> +	struct osnoise_variables *osn_var;
> +	long cpu;
> +

and we can avoid this ugly loop.

> +	for_each_possible_cpu(cpu) {
> +		osn_var = per_cpu_ptr(&per_cpu_osnoise_var, cpu);
> +		if (osn_var->pid == pid && dest_cpu != cpu) {
> +			per_cpu_ptr(&per_cpu_timerlat_var, cpu)->uthread_migrate = 1;
> +			osnoise_taint("timerlat user thread migrate\n");
> +			osnoise_stop_tracing();
> +			break;
> +		}
> +	}

Lazy daniel should have had a look first, but at least now I know I also need
to do some ifdeffery.

-- Daniel

