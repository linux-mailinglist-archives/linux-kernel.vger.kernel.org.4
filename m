Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074A36534C1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiLUROQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbiLURNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:13:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96EDB2528C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:13:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 918922F4;
        Wed, 21 Dec 2022 09:13:45 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF1053F703;
        Wed, 21 Dec 2022 09:13:01 -0800 (PST)
Message-ID: <72ed59b5-c7e1-c425-d1b6-e8d703d11d7a@arm.com>
Date:   Wed, 21 Dec 2022 18:12:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 3/7] sched: Teach arch_asym_cpu_priority() the idle
 state of SMT siblings
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
 <20221122203532.15013-4-ricardo.neri-calderon@linux.intel.com>
 <e7d6c19b-593d-acfd-35af-73b1840be276@arm.com>
 <20221212175433.GB27353@ranerica-svr.sc.intel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20221212175433.GB27353@ranerica-svr.sc.intel.com>
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
> On Tue, Dec 06, 2022 at 06:54:39PM +0100, Dietmar Eggemann wrote:
>> On 22/11/2022 21:35, Ricardo Neri wrote:

[...]

>>> + * want to check the idle state of the SMT siblngs of @cpu.
>>
>> s/siblngs/siblings
>>
>> The scheduler calls sched_asym_prefer(..., true) from
>> find_busiest_queue(), asym_active_balance() and nohz_balancer_kick()
> 
> In these places we are comparing two specific CPUs, of which the idle
> state of its siblings impact their throughput and, in consequence, the
> decision of attempt to balance load.  
> 
> In the places were sched_asym_prefer(...., false) is called we compare the
> destination CPU with a CPU that bears the priority of a sched group,
> regardless of the idle state of its siblings.

OK.

>> even from SMT layer on !x86.
> 
> This is true, but the default arch_asym_cpu_priority ignores check_smt.

True.

>>  So I guess a `bool check_smt` wouldn't be
>> sufficient to distinguish whether sched_smt_siblings_idle() should be
>> called or not.
> 
> But it is the caller who determines whether the idle state of the SMT
> siblings of @cpu may be relevant.

I assume caller being the task scheduler here. Callers with
`check_smt=true` can be called from any SD level with SD_ASYM_PACKING.

Imagine an arch w/ SD_ASYM_PACKING on SMT & MC overwriting
arch_asym_cpu_priority(). `bool check_smt` wouldn't be sufficient to
know whether a call to something like sched_smt_siblings_idle()
(is_core_idle()) which iterates over cpu_smt_mask(cpu) would make sense.

>> To me this comment is a little bit misleading. Not an
>> issue currently since there is only the x86 overwrite right now.
> 
> If my justification make sense to you, I can expand the comment to state
> that the caller decides whether check_smt is needed but arch-specific
> implementations are free to ignore it.

Not a big issue but to me if the task scheduler asks for `bool
check_smt` then archs would have to check to guarantee common behaviour.
And the meaning of `bool check_smt` on SMT is unclear to me.
Since only x86 would use this so far it can be adapted later for others
if needed.

[...]
