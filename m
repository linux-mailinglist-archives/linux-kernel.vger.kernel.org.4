Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481E85BCB4B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiISL46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiISL4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:56:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DA112DAA2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:55:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88F231474;
        Mon, 19 Sep 2022 04:55:42 -0700 (PDT)
Received: from [192.168.178.82] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 106293F73B;
        Mon, 19 Sep 2022 04:55:32 -0700 (PDT)
Message-ID: <000c2893-feb4-373d-2234-2ca74be94714@arm.com>
Date:   Mon, 19 Sep 2022 13:55:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 6/8] sched/fair: Add sched group latency support
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220916080305.29574-7-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220916080305.29574-7-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/valentin.schneider@arm.com//

On 16/09/2022 10:03, Vincent Guittot wrote:
> Task can set its latency priority, which is then used to decide to preempt
> the current running entity of the cfs, but sched group entities still have
> the default latency offset.
> 
> Add a latency field in task group to set the latency offset of the
> sched_eneities of the group, which will be used against other entities in

s/sched_eneities/sched_entity

> the parent cfs when deciding which entity to schedule first.

So latency for cgroups does not follow any (existing) Resource
Distribution Model/Scheme (Documentation/admin-guide/cgroup-v2.rst)?
Latency values are only used to compare sched entities at the same level.

[...]

> +static int cpu_latency_write_s64(struct cgroup_subsys_state *css,
> +				struct cftype *cft, s64 latency)
> +{

There is no [MIN, MAX] checking?

min_weight = sched_latency_to_weight[0]  = -1024
max_weight = sched_latency_to_weight[39] =   973

[MIN, MAX] = [sysctl_sched_latency * min_weight >> NICE_LATENCY_SHIFT,
              sysctl_sched_latency * max_weight >> NICE_LATENCY_SHIFT]


With the `cpu.latency` knob user would have to know for example that the
value is -24,000,000ns to get the same behaviour as for a task latency
nice = -20 (latency prio = 0) (w/ sysctl_sched_latency = 24ms)?

For `nice` we have `cpu.weight.nice` next to `cpu.weight` in cgroup v2 ?

[...]
