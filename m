Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAD9644A3F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbiLFRXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbiLFRXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:23:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 673C3391E8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:23:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA3CB23A;
        Tue,  6 Dec 2022 09:23:07 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E20953F73B;
        Tue,  6 Dec 2022 09:22:57 -0800 (PST)
Message-ID: <76e23104-a8c0-a5fc-b8c6-27de79df2372@arm.com>
Date:   Tue, 6 Dec 2022 18:22:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/7] sched/fair: Generalize asym_packing logic for SMT
 local sched group
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
 <20221122203532.15013-2-ricardo.neri-calderon@linux.intel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20221122203532.15013-2-ricardo.neri-calderon@linux.intel.com>
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
> When balancing load between two physical cores, an idle destination CPU can
> help another core only if all of its SMT siblings are also idle. Otherwise,
> there is not increase in throughput. It does not matter whether the other
> core is composed of SMT siblings.
> 
> Simply check if there are any tasks running on the local group and the
> other core has exactly one busy CPU before proceeding. Let
> find_busiest_group() handle the case of more than one busy CPU. This is
> true for SMT2, SMT4, SMT8, etc.

[...]

> Changes since v1:
>  * Reworded commit message and inline comments for clarity.
>  * Stated that this changeset does not impact STM4 or SMT8.
> ---
>  kernel/sched/fair.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e4a0b8bd941c..18c672ff39ef 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8900,12 +8900,10 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
>  				    struct sched_group *sg)

I'm not sure why you change asym_smt_can_pull_tasks() together with
removing SD_ASYM_PACKING from SMT level (patch 5/7)?

update_sg_lb_stats()

  ... && env->sd->flags & SD_ASYM_PACKING && .. && sched_asym()
                                                   ^^^^^^^^^^^^
    sched_asym()

      if ((sds->local->flags & SD_SHARE_CPUCAPACITY) ||
          (group->flags & SD_SHARE_CPUCAPACITY))
        return asym_smt_can_pull_tasks()
               ^^^^^^^^^^^^^^^^^^^^^^^^^

So x86 won't have a sched domain with SD_SHARE_CPUCAPACITY and
SD_ASYM_PACKING anymore. So sched_asym() would call sched_asym_prefer()
directly on MC. What do I miss here?

[...]
