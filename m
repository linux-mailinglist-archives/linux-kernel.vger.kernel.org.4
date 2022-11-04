Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80814618E98
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 04:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiKDDML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 23:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiKDDMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 23:12:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C065C252A6;
        Thu,  3 Nov 2022 20:12:05 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N3Qdt3v9jzRnyv;
        Fri,  4 Nov 2022 11:12:02 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 11:12:03 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 11:12:03 +0800
Subject: Re: [PATCH v4 4/4] rcu: Add RCU stall diagnosis information
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Josh Triplett" <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Robert Elliott <elliott@hpe.com>
References: <20221104021224.102-1-thunder.leizhen@huawei.com>
 <20221104021224.102-5-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <311242b9-e61c-376f-4db1-f3d6b30ec84e@huawei.com>
Date:   Fri, 4 Nov 2022 11:12:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20221104021224.102-5-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/4 10:12, Zhen Lei wrote:
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index d4a97e40ea9c3e2..44d49819a31f050 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -158,6 +158,22 @@ union rcu_noqs {
>  	u16 s; /* Set of bits, aggregate OR here. */
>  };
>  
> +/*
> + * Record the snapshot of the core stats at 1/2 rcu stall timeout. The member
> + * gp_seq is used to ensure that all members are updated only once during the
> + * second half period. The snapshot is taken only if this gp_seq is not equal
> + * to rdp->gp_seq.
> + */
> +struct rcu_snap_record {
> +	unsigned long	gp_seq;		/* Track rdp->gp_seq counter */
> +	u64		cputime_irq;	/* Accumulated cputime of hard irqs */
> +	u64		cputime_softirq;/* Accumulated cputime of soft irqs */
> +	u64		cputime_system; /* Accumulated cputime of kernel tasks */
> +	unsigned long	nr_hardirqs;	/* Accumulated number of hard irqs */
> +	unsigned int	nr_softirqs;	/* Accumulated number of soft irqs */
> +	unsigned long long nr_csw;	/* Accumulated number of task switches */
> +};
> +
>  /* Per-CPU data for read-copy update. */
>  struct rcu_data {
>  	/* 1) quiescent-state and grace-period handling : */
> @@ -262,6 +278,7 @@ struct rcu_data {
>  	short rcu_onl_gp_flags;		/* ->gp_flags at last online. */
>  	unsigned long last_fqs_resched;	/* Time of last rcu_resched(). */
>  	unsigned long last_sched_clock;	/* Jiffies of last rcu_sched_clock_irq(). */
> +	struct rcu_snap_record snap_record; /* Snapshot of core stats at 1/2 rcu stall timeout */
>  
>  	int cpu;
>  };

Sorry, I forgot to update linux-rcu.git. There is a conflict here.

----------------
 	int cpu;
  };
------------should be--------
 	long lazy_len;			/* Length of buffered lazy callbacks. */
 	int cpu;
----------------

-- 
Regards,
  Zhen Lei
