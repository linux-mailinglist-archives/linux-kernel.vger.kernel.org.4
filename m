Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6270964B6A2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbiLMN4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiLMN4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:56:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A2101A238;
        Tue, 13 Dec 2022 05:56:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE1F62F4;
        Tue, 13 Dec 2022 05:56:52 -0800 (PST)
Received: from [10.34.100.128] (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA96C3F71E;
        Tue, 13 Dec 2022 05:56:10 -0800 (PST)
Message-ID: <a675a7a1-e0bc-9ec1-6570-3dbaa35d98c6@arm.com>
Date:   Tue, 13 Dec 2022 14:56:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [ANNOUNCE] v6.0.5-rt14
To:     Clark Williams <williams@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, stable-rt@vger.kernel.org
References: <Y1o8hqwQKDpOTkNr@linutronix.de>
 <649af0f6-e5e2-c450-879c-e9153e0c0abc@arm.com>
 <Y1/NFIjRFZzszZB6@linutronix.de>
 <CAMLffL_VY52DAHxVO_BE=nAjXwzvq-jmAOO4JwDT3vw3sHy15A@mail.gmail.com>
Content-Language: en-US
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CAMLffL_VY52DAHxVO_BE=nAjXwzvq-jmAOO4JwDT3vw3sHy15A@mail.gmail.com>
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

Hello Sebastian, Clark,

On 10/31/22 15:06, Clark Williams wrote:
> I can pick them up for v5.19-rt
> 
> On Mon, Oct 31, 2022 at 1:28 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
>>
>> On 2022-10-28 11:47:28 [+0200], Pierre Gondois wrote:
>>> Hello Sebastian,
>>
>> Hi Pierre,
>>
>>> About the issues Valentin reported:
>>>
>>> - [SPLAT 1/3] arm_pmu: Sleeping spinlocks down armpmu_alloc_atomic()
>>> will be fixed by:
>>> https://lore.kernel.org/all/20220930111844.1522365-1-mark.rutland@arm.com/
>>
>> This is still pending and I don't see it in next. Could someone give me
>> a ping once this is merged, please?

This is now merged at:
commit fe40ffdb7656 ("arm_pmu: rework ACPI probing")
commit 6349a2470d07 ("arm_pmu: factor out PMU matching")
commit ad51b5043bb3 ("arm_pmu: acpi: factor out PMU<->CPU association")

If you also judge it is necessary to take:
commit f55a9b59e8f0 ("irqchip/gic-v3-its: Remove cpumask_var_t allocation")

Regards,
Pierre

>>
>>> - [SPLAT 2/3] irqchip/gic-v3-its: Sleeping spinlocks down gic_reserve_range()
>>> was fixed by:
>>> https://lore.kernel.org/lkml/20211027151506.2085066-3-valentin.schneider@arm.com/
>>
>> That is
>>     d23bc2bc1d634 ("irqchip/gic-v3-its: Postpone LPI pending table freeing and memreserve")
>>     v5.17-rc1
>>
>>> - [SPLAT 3/3] gpio: dwapb: Sleeping spinlocks down IRQ mapping
>>> was fixed by:
>>> https://lore.kernel.org/all/20220419012810.88417-1-schspa@gmail.com/
>>    3c938cc5cebcb ("gpio: use raw spinlock for gpio chip shadowed data")
>>    v5.19-rc1
>>
>> Is someone picking the two up or RT-stable?
>>
>>> Regards,
>>> Pierre
>>
>> Sebastian
>>
> 
