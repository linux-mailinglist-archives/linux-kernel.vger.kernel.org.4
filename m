Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA54739E71
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjFVKVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjFVKU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:20:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 019A31BC5;
        Thu, 22 Jun 2023 03:20:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AFA81042;
        Thu, 22 Jun 2023 03:21:33 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.78.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 433EF3F64C;
        Thu, 22 Jun 2023 03:20:49 -0700 (PDT)
Date:   Thu, 22 Jun 2023 11:20:47 +0100
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
        Valentin Schneider <vschneid@redhat.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>,
        Zhao Liu <zhao1.liu@linux.intel.com>
Subject: Re: [PATCH v4 18/24] sched/task_struct: Add helpers for IPC
 classification
Message-ID: <ZJQgf1PtrHWLA9q1@arm.com>
References: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
 <20230613042422.5344-19-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613042422.5344-19-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 12 Jun 2023 at 21:24:16 (-0700), Ricardo Neri wrote:
> The raw classification that hardware provides for a task may not
> be directly usable by the scheduler: the classification may change too
> frequently or architecture-specific implementations may need to consider
> additional factors. For instance, some processors with Intel Thread
> Director need to consider the state of the SMT siblings of a core.
> 
> Provide per-task helper variables that architectures can use to
> postprocess the classification that hardware provides.
> 
> Cc: Ben Segall <bsegall@google.com>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Perry Yuan <Perry.Yuan@amd.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tim C. Chen <tim.c.chen@intel.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Zhao Liu <zhao1.liu@linux.intel.com>
> Cc: x86@kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v3:
>  * None
> 
> Changes since v2:
>  * None
> 
> Changes since v1:
>  * Used bit-fields to fit all the IPC class data in 4 bytes. (PeterZ)
>  * Shortened names of the helpers.
>  * Renamed helpers with the ipcc_ prefix.
>  * Reworded commit message for clarity
> ---
>  include/linux/sched.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 0e1c38ad09c2..719147460ca8 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1541,7 +1541,17 @@ struct task_struct {
>  	 * A hardware-defined classification of task that reflects but is
>  	 * not identical to the number of instructions per cycle.
>  	 */
> -	unsigned short			ipcc;
> +	unsigned int			ipcc : 9;
> +	/*
> +	 * A candidate classification that arch-specific implementations
> +	 * qualify for correctness.
> +	 */
> +	unsigned int			ipcc_tmp : 9;
> +	/*
> +	 * Counter to filter out transient candidate classifications
> +	 * of a task.
> +	 */
> +	unsigned int			ipcc_cntr : 14;
>  #endif
>  

Why does this need to be split in task_struct? Isn't this architecture
specific? IMO the scheduler should never make use of class information
itself. It only receives the value though the call of an arch function
and passes it as an argument to an arch function to get a performance
score. So the way one interprets the class value (splits it in relevant
and helper bits) should be defined and considered in the architecture
specific code.

Thanks,
Ionela.

>  	/*
> -- 
> 2.25.1
> 
