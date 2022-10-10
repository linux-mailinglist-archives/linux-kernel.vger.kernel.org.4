Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7DC5F9D08
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiJJKqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiJJKqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:46:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1C1D67C95;
        Mon, 10 Oct 2022 03:46:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E548E1480;
        Mon, 10 Oct 2022 03:46:38 -0700 (PDT)
Received: from [10.57.5.39] (unknown [10.57.5.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50A333F792;
        Mon, 10 Oct 2022 03:46:31 -0700 (PDT)
Message-ID: <7ded9241-6c21-6631-8910-9f1150db6724@arm.com>
Date:   Mon, 10 Oct 2022 11:46:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] cpufreq: Update CPU capacity reduction in
 store_scaling_max_freq()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        linux-pm@vger.kernel.org, Dietmar.Eggemann@arm.com,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
References: <20220930094821.31665-1-lukasz.luba@arm.com>
 <20220930094821.31665-2-lukasz.luba@arm.com>
 <20221010053902.5rofnpzvyynumw3e@vireshk-i7>
 <3f9a4123-171b-5fa7-f506-341355f71483@arm.com>
 <CAKfTPtBPqcTm5_-M_Ka3y46yQ2322TmH8KS-QyDbAiKk5B6hEQ@mail.gmail.com>
 <8a7968c2-dbf7-5316-ef36-6d45143e0605@arm.com>
 <CAKfTPtB3Lk5bc9k634O+Yi8wwP=MVeKS5NPbpaqwhX1F4t5EbA@mail.gmail.com>
 <9611971c-d8dd-7877-6f50-c5afbf38b171@arm.com>
 <Y0Py/Ol9t+LMM1pI@hirez.programming.kicks-ass.net>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <Y0Py/Ol9t+LMM1pI@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+CC Daniel, since I have mentioned a few times DTPM

On 10/10/22 11:25, Peter Zijlstra wrote:
> On Mon, Oct 10, 2022 at 11:12:06AM +0100, Lukasz Luba wrote:
>> BTW, those Android user space max freq requests are not that long,
>> mostly due to camera capturing (you can see a few in this file,
>> e.g. [1]).
> 
> It does what now ?!? Why is Android using this *at*all* ?

It tries to balance the power budget, before bad things happen
randomly (throttling different devices w/o a good context what's
going on). Please keep in mind that we have ~3 Watts total power
budget in a phone, while several devices might be suddenly used:
1. big CPU with max power ~3-3.5 Watts (and we have 2 cores on pixel6)
2. GPU with max power ~6Watts (normally ~1-2Watts when lightly used)
3. ISP (Image Signal Processor) up to ~2Watts
4. DSP also up to 1-2Watts

We don't have currently a good mechanism which could be aware
of the total power/thermal budget and relations between those
devices. Vendors and OEMs run experiments on devices and profile
them to work more predictable in those 'important to users' scenarios.

AFAIK Daniel Lescano is trying to help with this new interface
for PowerCap: DTMP. It might be use as a new interface for those known
scenarios like the camera snapshot. But that interface is on the list
that I have also mentioned - it's missing the notification mechanism
for the scheduler reduced capacity due to user-space new scenario.
