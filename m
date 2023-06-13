Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8061072E2C1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238408AbjFMMUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242402AbjFMMTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:19:41 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506911BD7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:19:26 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QgSHL3HPKzLmjk;
        Tue, 13 Jun 2023 20:17:34 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 20:19:23 +0800
Subject: Re: [PATCH] sched/deadline: simplify dl_bw_cpus() using
 cpumask_weight_and()
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20230522115605.1238227-1-linmiaohe@huawei.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <7bfde912-1e15-ec1f-8a62-9cc508739cd6@huawei.com>
Date:   Tue, 13 Jun 2023 20:19:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230522115605.1238227-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/22 19:56, Miaohe Lin wrote:
> cpumask_weight_and() can be used to count of bits both in rd->span and
> cpu_active_mask. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

friendly ping... :)

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
> 

