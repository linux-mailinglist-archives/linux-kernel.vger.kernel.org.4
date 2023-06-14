Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20A572F21E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 03:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbjFNBn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 21:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjFNBn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 21:43:57 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E86D173E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 18:43:52 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Qgp3y001Tz18KCM;
        Wed, 14 Jun 2023 09:38:53 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 09:43:49 +0800
Subject: Re: [PATCH] sched/deadline: simplify dl_bw_cpus() using
 cpumask_weight_and()
To:     Phil Auld <pauld@redhat.com>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <dietmar.eggemann@arm.com>,
        <quic_mojha@quicinc.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20230522115605.1238227-1-linmiaohe@huawei.com>
 <7bfde912-1e15-ec1f-8a62-9cc508739cd6@huawei.com>
 <20230613131651.GA536267@lorien.usersys.redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1d5e80c1-69e6-e2e8-a5d1-6117cb661013@huawei.com>
Date:   Wed, 14 Jun 2023 09:43:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230613131651.GA536267@lorien.usersys.redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 2023/6/13 21:16, Phil Auld wrote:
> On Tue, Jun 13, 2023 at 08:19:22PM +0800 Miaohe Lin wrote:
>> On 2023/5/22 19:56, Miaohe Lin wrote:
>>> cpumask_weight_and() can be used to count of bits both in rd->span and
>>> cpu_active_mask. No functional change intended.
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>
>> friendly ping... :)
> 
> This looks reasonable, and better, to me.
> 
> Reviewed-by: Phil Auld <pauld@redhat.com>

Many thanks for all of your reviews. :)

> 
>>
>>> ---
>>>  kernel/sched/deadline.c | 11 +----------
>>>  1 file changed, 1 insertion(+), 10 deletions(-)
>>>
>>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>>> index 166c3e6eae61..fe983ed7bb12 100644
>>> --- a/kernel/sched/deadline.c
>>> +++ b/kernel/sched/deadline.c
>>> @@ -110,20 +110,11 @@ static inline struct dl_bw *dl_bw_of(int i)
>>>  static inline int dl_bw_cpus(int i)
>>>  {
>>>  	struct root_domain *rd = cpu_rq(i)->rd;
>>> -	int cpus;
>>>  
>>>  	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
>>>  			 "sched RCU must be held");
>>>  
>>> -	if (cpumask_subset(rd->span, cpu_active_mask))
>>> -		return cpumask_weight(rd->span);
>>> -
>>> -	cpus = 0;
>>> -
>>> -	for_each_cpu_and(i, rd->span, cpu_active_mask)
>>> -		cpus++;
>>> -
>>> -	return cpus;
>>> +	return cpumask_weight_and(rd->span, cpu_active_mask);
>>>  }
>>>  
>>>  static inline unsigned long __dl_bw_capacity(const struct cpumask *mask)
>>>
>>
> 

