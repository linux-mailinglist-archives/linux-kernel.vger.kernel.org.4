Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8AC70C3C8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbjEVQ6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjEVQ6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:58:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62438CD
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:58:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 020A611FB;
        Mon, 22 May 2023 09:59:17 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E82893F762;
        Mon, 22 May 2023 09:58:29 -0700 (PDT)
Message-ID: <5e5c9d89-0751-abc2-4d43-5c8083735724@arm.com>
Date:   Mon, 22 May 2023 18:58:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] sched/deadline: simplify dl_bw_cpus() using
 cpumask_weight_and()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
References: <20230522115605.1238227-1-linmiaohe@huawei.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230522115605.1238227-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2023 13:56, Miaohe Lin wrote:
> cpumask_weight_and() can be used to count of bits both in rd->span and
> cpu_active_mask. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  kernel/sched/deadline.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 166c3e6eae61..fe983ed7bb12 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -110,20 +110,11 @@ static inline struct dl_bw *dl_bw_of(int i)
>  static inline int dl_bw_cpus(int i)
>  {
>  	struct root_domain *rd = cpu_rq(i)->rd;
> -	int cpus;
>  
>  	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
>  			 "sched RCU must be held");
>  
> -	if (cpumask_subset(rd->span, cpu_active_mask))
> -		return cpumask_weight(rd->span);
> -
> -	cpus = 0;
> -
> -	for_each_cpu_and(i, rd->span, cpu_active_mask)
> -		cpus++;
> -
> -	return cpus;
> +	return cpumask_weight_and(rd->span, cpu_active_mask);
>  }
>  
>  static inline unsigned long __dl_bw_capacity(const struct cpumask *mask)

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
