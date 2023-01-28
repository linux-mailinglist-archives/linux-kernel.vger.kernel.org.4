Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC7167F733
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbjA1Klj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjA1Klh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:41:37 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A884D7579A
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:41:35 -0800 (PST)
Received: from dggpeml500018.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4P3rXt4dYHzRrGL;
        Sat, 28 Jan 2023 18:39:26 +0800 (CST)
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 28 Jan 2023 18:41:33 +0800
Message-ID: <51b603d3-72bf-91c2-1559-b3f85b4865ba@huawei.com>
Date:   Sat, 28 Jan 2023 18:41:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] sched/fair: sanitize vruntime of entity being placed
To:     Roman Kagan <rkagan@amazon.de>, <linux-kernel@vger.kernel.org>
CC:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Juri Lelli <juri.lelli@redhat.com>
References: <20230127163230.3339408-1-rkagan@amazon.de>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <20230127163230.3339408-1-rkagan@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.186]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/1/28 0:32, Roman Kagan 写道:
> From: Zhang Qiao <zhangqiao22@huawei.com>
> 
> When a scheduling entity is placed onto cfs_rq, its vruntime is pulled
> to the base level (around cfs_rq->min_vruntime), so that the entity
> doesn't gain extra boost when placed backwards.
> 
> However, if the entity being placed wasn't executed for a long time, its
> vruntime may get too far behind (e.g. while cfs_rq was executing a
> low-weight hog), which can inverse the vruntime comparison due to s64
> overflow.  This results in the entity being placed with its original
> vruntime way forwards, so that it will effectively never get to the cpu.
> 
> To prevent that, ignore the vruntime of the entity being placed if it
> didn't execute for much longer than the characteristic sheduler time
> scale.
> 


Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>


> [rkagan: formatted, adjusted commit log, comments, cutoff value]
> Co-developed-by: Roman Kagan <rkagan@amazon.de>
> Signed-off-by: Roman Kagan <rkagan@amazon.de>
> ---
> @zhangqiao22, I took the liberty to put you as the author of the patch,
> as this is essentially what you posted for discussion, with minor
> tweaks.  Please stamp with your s-o-b if you're ok with it.
> 
>  kernel/sched/fair.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0f8736991427..d6cf131ebb0b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4656,6 +4656,7 @@ static void
>  place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>  {
>  	u64 vruntime = cfs_rq->min_vruntime;
> +	u64 sleep_time;
>  
>  	/*
>  	 * The 'current' period is already promised to the current tasks,
> @@ -4685,8 +4686,18 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>  		vruntime -= thresh;
>  	}
>  
> -	/* ensure we never gain time by being placed backwards. */
> -	se->vruntime = max_vruntime(se->vruntime, vruntime);
> +	/*
> +	 * Pull vruntime of the entity being placed to the base level of
> +	 * cfs_rq, to prevent boosting it if placed backwards.  If the entity
> +	 * slept for a long time, don't even try to compare its vruntime with
> +	 * the base as it may be too far off and the comparison may get
> +	 * inversed due to s64 overflow.
> +	 */
> +	sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> +	if ((s64)sleep_time > 60 * NSEC_PER_SEC)

In order to avoid overflowing, it'd better be "60LL * NSEC_PER_SEC"

Thanks,
Qiao.


> +		se->vruntime = vruntime;
> +	else
> +		se->vruntime = max_vruntime(se->vruntime, vruntime);
>  }
>  
>  static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
> 
