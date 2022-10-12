Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AA55FC72C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 16:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJLOW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 10:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJLOWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 10:22:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3C5CCAE5A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 07:22:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CC8115A1;
        Wed, 12 Oct 2022 07:23:00 -0700 (PDT)
Received: from wubuntu (unknown [10.57.35.175])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CD633F792;
        Wed, 12 Oct 2022 07:22:50 -0700 (PDT)
Date:   Wed, 12 Oct 2022 15:22:48 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        chris.hyser@oracle.com, valentin.schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org
Subject: Re: [PATCH v5 5/7] sched/fair: Add sched group latency support
Message-ID: <20221012142248.k6pdjgxwkk2cshuu@wubuntu>
References: <20220925143908.10846-1-vincent.guittot@linaro.org>
 <20220925143908.10846-6-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220925143908.10846-6-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/22 16:39, Vincent Guittot wrote:
> Task can set its latency priority with sched_setattr(), which is then used
> to set the latency offset of its sched_entity, but sched group entities
> still have the default latency offset value.
> 
> Add a latency.nice field in cpu cgroup controller to set the latency
> priority of the group similarly to sched_setattr(). The latency priority
> is then used to set the offset of the sched_entities of the group.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  8 ++++
>  kernel/sched/core.c                     | 53 +++++++++++++++++++++++++
>  kernel/sched/fair.c                     | 33 +++++++++++++++
>  kernel/sched/sched.h                    |  4 ++
>  4 files changed, 98 insertions(+)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index be4a77baf784..d8ae7e411f9c 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1095,6 +1095,14 @@ All time durations are in microseconds.
>          values similar to the sched_setattr(2). This maximum utilization
>          value is used to clamp the task specific maximum utilization clamp.
>  
> +  cpu.latency.nice
> +	A read-write single value file which exists on non-root
> +	cgroups.  The default is "0".
> +
> +	The nice value is in the range [-20, 19].
> +
> +	This interface file allows reading and setting latency using the
> +	same values used by sched_setattr(2).

I still don't understand how tasks will inherit the latency_nice value from
cgroups they're attached to.

For example, in EAS path we operate at task level only. If the task's
p->latency_nice = 0, but it belongs to a task group tg->latency_nice = -19;
what should the task's latency_nice be in this case? If it's in a hierarchy,
how would the effective value be calculated?


Thanks

--
Qais Yousef
