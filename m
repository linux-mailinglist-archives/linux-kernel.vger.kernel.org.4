Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF82F6473D2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiLHQDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLHQDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:03:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE2459B2A5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 08:03:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C578323A;
        Thu,  8 Dec 2022 08:03:12 -0800 (PST)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A48463F73D;
        Thu,  8 Dec 2022 08:03:05 -0800 (PST)
Date:   Thu, 8 Dec 2022 16:03:04 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v2 5/7] x86/sched: Remove SD_ASYM_PACKING from the "SMT"
 domain
Message-ID: <Y5IKuJTjE6Pjrw9I@arm.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-6-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122203532.15013-6-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Tuesday 22 Nov 2022 at 12:35:30 (-0800), Ricardo Neri wrote:
> There is no difference between any of the SMT siblings of a physical core.
> asym_packing load balancing is not needed among siblings.
> 
> When balancing load among physical cores, the scheduler now considers the
> state of the siblings when checking the priority of a CPU.
> 
> Cc: Ben Segall <bsegall@google.com>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tim C. Chen <tim.c.chen@intel.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v1:
>  * Introduced this patch.
> ---
>  arch/x86/kernel/smpboot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 3f3ea0287f69..c3de98224cb4 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -545,7 +545,7 @@ static int x86_core_flags(void)
>  #ifdef CONFIG_SCHED_SMT
>  static int x86_smt_flags(void)
>  {
> -	return cpu_smt_flags() | x86_sched_itmt_flags();
> +	return cpu_smt_flags();

Based on:

kernel/sched/topology.c:
sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
rcu_assign_pointer(per_cpu(sd_asym_packing, cpu), sd);

and described at:

include/linux/sched/sd_flags.h:
/*
 * Place busy tasks earlier in the domain
 *
 * SHARED_CHILD: Usually set on the SMT level. Technically could be set further
 *               up, but currently assumed to be set from the base domain
 *               upwards (see update_top_cache_domain()).
 * NEEDS_GROUPS: Load balancing flag.
 */
SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)

doesn't your change result in sd_asym_packing being NULL?

The SD_ASYM_PACKING flag requires all children of a domain to have it set
as well. So having SMT not setting the flag, while CLUSTER and MC having
set the flag would result in a broken topology, right?

Thanks,
Ionela.

>  }
>  #endif
>  #ifdef CONFIG_SCHED_CLUSTER
> -- 
> 2.25.1
> 
> 
