Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F3274FD31
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 04:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjGLClj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 22:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjGLCle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 22:41:34 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE85F1734
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 19:41:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0VnAvL2U_1689129671;
Received: from 30.97.49.43(mailfrom:cruzzhao@linux.alibaba.com fp:SMTPD_---0VnAvL2U_1689129671)
          by smtp.aliyun-inc.com;
          Wed, 12 Jul 2023 10:41:22 +0800
Message-ID: <bac49956-5968-3513-b487-28f99f214967@linux.alibaba.com>
Date:   Wed, 12 Jul 2023 10:41:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3] sched/core: introduce sched_core_idle_cpu()
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        quic_neeraju@quicinc.com, joel@joelfernandes.org,
        josh@joshtriplett.org, boqun.feng@gmail.com,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        qiang1.zhang@intel.com, jstultz@google.com,
        clingutla@codeaurora.org, nsaenzju@redhat.com, tglx@linutronix.de,
        frederic@kernel.org, linux-kernel@vger.kernel.org
References: <1688011324-42406-1-git-send-email-CruzZhao@linux.alibaba.com>
 <20230704053946.GA658436@ziqianlu-dell>
From:   cruzzhao <cruzzhao@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20230704053946.GA658436@ziqianlu-dell>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/4 下午1:39, Aaron Lu 写道:
>> +#ifdef CONFIG_SCHED_CORE
>> +int sched_core_idle_cpu(int cpu)
>> +{
>> +	struct rq *rq = cpu_rq(cpu);
>> +
>> +	if (sched_core_enabled(rq) && rq->curr == rq->idle)
>> +		return 1;
> 
> If the intention is to consider forced idle cpus as idle, then should
> the above condition written as:
> 
> 	if (sched_core_enabled(rq) && rq->core->core_forceidle_count)
> 		return 1;
> ?
> 
> Or as long as a single cookied task is running, all normal idle cpus are
> regarded forced idle here and 1 is returned while previously, idle_cpu()
> is called for those cpus and if they have wakeup task pending, they are
> not regarded as idle so looks like a behaviour change.
> 
> Thanks,
> Aaron
> 

I'll fix this problem in the next version.

Best,
Cruz Zhao

>> +
>> +	return idle_cpu(cpu);
>> +}
>> +
>> +#endif
>> +
>>  #ifdef CONFIG_SMP
>>  /*
>>   * This function computes an effective utilization for the given CPU, to be
>> diff --git a/kernel/softirq.c b/kernel/softirq.c
>> index c8a6913c067d..98b98991ce45 100644
>> --- a/kernel/softirq.c
>> +++ b/kernel/softirq.c
>> @@ -630,7 +630,7 @@ static inline void tick_irq_exit(void)
>>  	int cpu = smp_processor_id();
>>  
>>  	/* Make sure that timer wheel updates are propagated */
>> -	if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
>> +	if ((sched_core_idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
>>  		if (!in_hardirq())
>>  			tick_nohz_irq_exit();
>>  	}
>> -- 
>> 2.27.0
>>
