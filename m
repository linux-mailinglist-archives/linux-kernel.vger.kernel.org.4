Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8AE653ECC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbiLVLMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbiLVLMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:12:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9A9C2AC8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:12:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0C49AD7;
        Thu, 22 Dec 2022 03:13:20 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF1953F71E;
        Thu, 22 Dec 2022 03:12:36 -0800 (PST)
Message-ID: <e55d091b-3d7a-6c4e-153b-b981b7e975bc@arm.com>
Date:   Thu, 22 Dec 2022 12:12:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 4/7] sched/fair: Introduce sched_smt_siblings_idle()
Content-Language: en-US
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
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
 <20221122203532.15013-5-ricardo.neri-calderon@linux.intel.com>
 <75ba5884-63c0-5180-00b8-e9764306a83e@arm.com>
 <20221212175458.GC27353@ranerica-svr.sc.intel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20221212175458.GC27353@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2022 18:54, Ricardo Neri wrote:
> On Tue, Dec 06, 2022 at 07:03:37PM +0100, Dietmar Eggemann wrote:
>> On 22/11/2022 21:35, Ricardo Neri wrote:

[...]

>>> +bool sched_smt_siblings_idle(int cpu)
>>> +{
>>> +	return is_core_idle(cpu);
>>> +}
>>
>> Nitpick: Can we not just have one exported function for both use-cases:
>> NUMA and x86 ITMT?
> 
> By adding a new function I intend to preserve the inlinig of is_core_idle()
> in update_numa_stats() (via numa_idle_core(), which is also inline). Do you
> think there is no value?

OK. It's only used in NUMA balancing (task_numa_fault() -> ... ->
update_numa_stats()). I can't see that this will have a noticeable perf
impact but only benchmark can really tell.

A `static inline bool sched_is_core_idle(int cpu)` via
include/linux/sched/topology.h might work? We have similar functions
(like sched_core_cookie_match()` but in the private scheduler header
file kernel/sched/sched.h though.

> A downside of having the new function is that now the code is duplicated
> in update_numa_stats() and sched_smt_siblings_idle().
> 
> I can take your suggestion if losing the inline is OK.

I doubt that it will have an impact but can't be sure.

[...]
