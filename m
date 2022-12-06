Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE4E644AA7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiLFRyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiLFRyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:54:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDE812BB11
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:54:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2969423A;
        Tue,  6 Dec 2022 09:54:52 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78C8F3F73B;
        Tue,  6 Dec 2022 09:54:41 -0800 (PST)
Message-ID: <e7d6c19b-593d-acfd-35af-73b1840be276@arm.com>
Date:   Tue, 6 Dec 2022 18:54:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/7] sched: Teach arch_asym_cpu_priority() the idle
 state of SMT siblings
Content-Language: en-US
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-4-ricardo.neri-calderon@linux.intel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20221122203532.15013-4-ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2022 21:35, Ricardo Neri wrote:
> Some processors (e.g., Intel processors with ITMT) use asym_packing to
> balance load between physical cores with SMT. In such case, a core with all
> its SMT siblings idle is more desirable than another with one or more busy
> siblings.
> 
> Other processors (e.g, Power7 with SMT8) use asym_packing to balance load
> among SMT siblings of different priority, regardless of their idle state.
> 
> Add a new parameter, check_smt, that architectures can use as needed.

[...]

> Changes since v1:
>  * Introduced this patch.

[...]

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d18947a9c03e..0e4251f83807 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -142,8 +142,11 @@ __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
>  #ifdef CONFIG_SMP
>  /*
>   * For asym packing, by default the lower numbered CPU has higher priority.
> + *
> + * When doing ASYM_PACKING at the "MC" or higher domains, architectures may

There is this new CLUSTER level between SMT and MC.

> + * want to check the idle state of the SMT siblngs of @cpu.

s/siblngs/siblings

The scheduler calls sched_asym_prefer(..., true) from
find_busiest_queue(), asym_active_balance() and nohz_balancer_kick()
even from SMT layer on !x86. So I guess a `bool check_smt` wouldn't be
sufficient to distinguish whether sched_smt_siblings_idle() should be
called or not. To me this comment is a little bit misleading. Not an
issue currently since there is only the x86 overwrite right now.

>   */
> -int __weak arch_asym_cpu_priority(int cpu)
> +int __weak arch_asym_cpu_priority(int cpu, bool check_smt)
>  {
>  	return -cpu;
>  }

[...]

