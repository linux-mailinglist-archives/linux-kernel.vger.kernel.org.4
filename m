Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DD7622EE5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiKIPTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiKIPS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:18:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A81D26F3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 07:18:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEC521FB;
        Wed,  9 Nov 2022 07:19:02 -0800 (PST)
Received: from [10.57.3.244] (unknown [10.57.3.244])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 858873F73D;
        Wed,  9 Nov 2022 07:18:54 -0800 (PST)
Message-ID: <8cb196d8-1a81-cfd9-6437-a1ba26a7c767@arm.com>
Date:   Wed, 9 Nov 2022 15:18:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jian-Min Liu <jian-min.liu@mediatek.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
 <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net>
 <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net>
 <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
 <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 11/7/22 13:41, Peter Zijlstra wrote:
> On Thu, Sep 29, 2022 at 03:41:47PM +0100, Kajetan Puchalski wrote:
> 
>> Based on all the tests we've seen, jankbench or otherwise, the
>> improvement can mainly be attributed to the faster ramp up of frequency
>> caused by the shorter PELT window while using schedutil.
> 
> Would something terrible like the below help some?
> 
> If not, I suppose it could be modified to take the current state as
> history. But basically it runs a faster pelt sum along side the regular
> signal just for ramping up the frequency.

[snip]

> +
> +			rcu_read_lock();
> +			curr = rcu_dereference(rq->curr);
> +			if (likely(curr->sched_class == &fair_sched_class)) {
> +				u64 runtime = curr->se.sum_exec_runtime - curr->se.exec_start;
> +				util = max_t(unsigned long, util,
> +					     faster_est_approx(runtime * 2));

That's a really nice hack :)

I wonder why we end up in such situation on Android. Maybe there is
a different solution?
Maybe shorter tick (then also align PELT Half-Life)?

The problem is mostly in those high-FPS phones. You know, we now have
phones with 144Hz displays and even games > 100FPS (which wasn't the
case a few years ago when we invested a lot of effort into this
PELT+EAS). We also have a lot faster CPUs (~2x in 3-4 years).

IMO those games (and OS mechanisms assisting them) would have different
needs probably (if they do this 'soft-real-time simulations' with such
high granularity ~120/s -> every ~8ms).

IMO one old setting might not fit well into this: 4ms tick (which is the
Android use case), which then implies scheduler min granularity, which
we also align with the y^32 PELT.
Is this a correct chain of thinking?

Would it make sense to ask Android phone vendors to experiment with
1ms tick (w/ aligned PELT HL)? With that change, there might be some
power spikes issues, though.

Regards,
Lukasz
