Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312976945A3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjBMMRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjBMMRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:17:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8687244B7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:17:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFFDB4B3;
        Mon, 13 Feb 2023 04:18:05 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 724193F703;
        Mon, 13 Feb 2023 04:17:19 -0800 (PST)
Message-ID: <8300f288-7157-5e2d-3bb3-badcffd15d34@arm.com>
Date:   Mon, 13 Feb 2023 13:17:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 06/10] sched/fair: Use the prefer_sibling flag of the
 current sched domain
Content-Language: en-US
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-7-ricardo.neri-calderon@linux.intel.com>
 <Y+YXrk5NRuWaSOGR@hirez.programming.kicks-ass.net>
 <xhsmhmt5lr2nz.mognet@vschneid.remote.csb>
 <Y+Z2b/OtZDk9cT53@hirez.programming.kicks-ass.net>
 <xhsmhk00pqwap.mognet@vschneid.remote.csb>
 <20230210183155.GA11997@ranerica-svr.sc.intel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230210183155.GA11997@ranerica-svr.sc.intel.com>
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

On 10/02/2023 19:31, Ricardo Neri wrote:
> On Fri, Feb 10, 2023 at 05:12:30PM +0000, Valentin Schneider wrote:
>> On 10/02/23 17:53, Peter Zijlstra wrote:
>>> On Fri, Feb 10, 2023 at 02:54:56PM +0000, Valentin Schneider wrote:
>>>
>>>> So something like have SD_PREFER_SIBLING affect the SD it's on (and not
>>>> its parent), but remove it from the lowest non-degenerated topology level?
>>>
>>> So I was rather confused about the whole moving it between levels things
>>> this morning -- conceptually, prefer siblings says you want to try
>>> sibling domains before filling up your current domain. Now, balancing
>>> between siblings happens one level up, hence looking at child->flags
>>> makes perfect sense.
>>>
>>> But looking at the current domain and still calling it prefer sibling
>>> makes absolutely no sense what so ever.
>>>
>>
>> True :-)
>>
>>> In that confusion I think I also got the polarity wrong, I thought you
>>> wanted to kill prefer_sibling for the assymetric SMT cases, instead you
>>> want to force enable it as long as there is one SMT child around.
> 
> Exactly.
> 
>>>
>>> Whichever way around it we do it, I'm thinking perhaps some renaming
>>> might be in order to clarify things.
>>>
>>> How about adding a flag SD_SPREAD_TASKS, which is the effective toggle
>>> of the behaviour, but have it be set by children with SD_PREFER_SIBLING
>>> or something.
>>>
>>
>> Or entirely bin SD_PREFER_SIBLING and stick with SD_SPREAD_TASKS, but yeah
>> something along those lines.
> 
> I sense a consesus towards SD_SPREAD_TASKS.

Can you not detect the E-core dst_cpu case on MC with:

+       if (child)
+               sds->prefer_sibling = child->flags & SD_PREFER_SIBLING;
+       else if (sds->busiest)
+               sds->prefer_sibling = sds->busiest->group_weight > 1;
+

[...]
