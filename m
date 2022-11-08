Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5316216E1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiKHOeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbiKHOeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:34:05 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AD510FDE;
        Tue,  8 Nov 2022 06:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1667918044; x=1699454044;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qOdEnRahWCmwalQFuY7ezIy6Teu29RvUmEBMKjiPkTg=;
  b=xAdp/L8qNKS5bQldbbdflT8P6y4wQPwnuJLB6la3/mN4GW+MtaBC8ZTI
   ZEzrZuxhnQ4MWovb+Er5beA4Zm2A5s+kp8Cf8WUnXwVeSTdBfbJBPT+EQ
   akbjCR6kBgCkwYXH/AEdyM34f8aXZessWlnURmutPK9LI6c7JZOnDx8Gy
   8=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Nov 2022 06:34:04 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 06:34:04 -0800
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 8 Nov 2022
 06:34:00 -0800
Message-ID: <2a72fbf3-a6b7-0621-9671-d06409fe026b@quicinc.com>
Date:   Tue, 8 Nov 2022 20:03:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v5 3/4] sched: Add helper nr_context_switches_cpu()
Content-Language: en-US
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Neeraj Upadhyay" <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Robert Elliott <elliott@hpe.com>
References: <20221104141118.119-1-thunder.leizhen@huawei.com>
 <20221104141118.119-4-thunder.leizhen@huawei.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20221104141118.119-4-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/4/2022 7:41 PM, Zhen Lei wrote:
> Returns the number of context switches on the specified CPU, which can be
> used to diagnose rcu stall.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com> > ---
>   include/linux/kernel_stat.h | 1 +
>   kernel/sched/core.c         | 5 +++++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
> index 898076e173a928a..9935f7ecbfb9e31 100644
> --- a/include/linux/kernel_stat.h
> +++ b/include/linux/kernel_stat.h
> @@ -52,6 +52,7 @@ DECLARE_PER_CPU(struct kernel_cpustat, kernel_cpustat);
>   #define kstat_cpu(cpu) per_cpu(kstat, cpu)
>   #define kcpustat_cpu(cpu) per_cpu(kernel_cpustat, cpu)
>   
> +extern unsigned long long nr_context_switches_cpu(int cpu);
>   extern unsigned long long nr_context_switches(void);
>   
>   extern unsigned int kstat_irqs_cpu(unsigned int irq, int cpu);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5800b0623ff3068..a0d19f67f2046d9 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5229,6 +5229,11 @@ bool single_task_running(void)
>   }
>   EXPORT_SYMBOL(single_task_running);
>   
> +unsigned long long nr_context_switches_cpu(int cpu)
> +{
> +	return cpu_rq(cpu)->nr_switches;
> +}
> +
>   unsigned long long nr_context_switches(void)
>   {
>   	int i;

LGTM.
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
