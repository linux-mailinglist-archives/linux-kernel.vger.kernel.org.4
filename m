Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE565B5687
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiILIp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiILIpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:45:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F501275FD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:45:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51F00113E;
        Mon, 12 Sep 2022 01:45:30 -0700 (PDT)
Received: from [172.16.16.241] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5301D3F73D;
        Mon, 12 Sep 2022 01:45:22 -0700 (PDT)
Message-ID: <294b8903-393f-7242-a887-6ec6d6fc829e@arm.com>
Date:   Mon, 12 Sep 2022 10:45:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/4] sched/fair: cleanup loop_max and loop_break
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Cc:     zhangqiao22@huawei.com
References: <20220825122726.20819-1-vincent.guittot@linaro.org>
 <20220825122726.20819-3-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220825122726.20819-3-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2022 14:27, Vincent Guittot wrote:
> sched_nr_migrate_break is set to a fix value and never changes so we can
> replace it by a define SCHED_NR_MIGRATE_BREAK.
> 
> Also, we adjust SCHED_NR_MIGRATE_BREAK to be aligned with the init value
> of sysctl_sched_nr_migrate which can be init to different values.
> 
> Then, use SCHED_NR_MIGRATE_BREAK to init sysctl_sched_nr_migrate.
> 
> The behavior stays unchanged unless you modify sysctl_sched_nr_migrate
> trough debugfs.

I don't quite get this sentence. The behavior would potentially change
if you change sysctl_sched_nr_migrate before this patch too?

> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/core.c  |  6 +-----
>  kernel/sched/fair.c  | 11 ++++-------
>  kernel/sched/sched.h |  6 ++++++
>  3 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 64c08993221b..a21e817bdd1c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -142,11 +142,7 @@ __read_mostly int sysctl_resched_latency_warn_once = 1;
>   * Number of tasks to iterate in a single balance run.
>   * Limited because this is done with IRQs disabled.
>   */

    ^^^
Shouldn't this comment be removed as well?

> -#ifdef CONFIG_PREEMPT_RT
> -const_debug unsigned int sysctl_sched_nr_migrate = 8;
> -#else
> -const_debug unsigned int sysctl_sched_nr_migrate = 32;
> -#endif
> +const_debug unsigned int sysctl_sched_nr_migrate = SCHED_NR_MIGRATE_BREAK;
>  
>  __read_mostly int scheduler_running;

[...]
