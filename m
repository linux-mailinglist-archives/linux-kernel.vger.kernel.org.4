Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60BF623141
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiKIRTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiKIRTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:19:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C2EA25C8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 09:19:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 004BD1FB;
        Wed,  9 Nov 2022 09:19:18 -0800 (PST)
Received: from [10.1.197.38] (eglon.cambridge.arm.com [10.1.197.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2DDD3F703;
        Wed,  9 Nov 2022 09:19:08 -0800 (PST)
Message-ID: <54bbb5b1-6d04-6d45-d6c9-45e714928cf4@arm.com>
Date:   Wed, 9 Nov 2022 17:18:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 18/18] x86/resctrl: Separate arch and fs resctrl locks
Content-Language: en-GB
To:     Peter Newman <peternewman@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, xingxin.hx@openanolis.org,
        baolin.wang@linux.alibaba.com
References: <20221021131204.5581-1-james.morse@arm.com>
 <20221021131204.5581-19-james.morse@arm.com>
 <CALPaoCjTzzdqtEoqSWv-w=Fvq-dLLjvt8VJrP_RzmijLTD5=2w@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <CALPaoCjTzzdqtEoqSWv-w=Fvq-dLLjvt8VJrP_RzmijLTD5=2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 31/10/2022 14:21, Peter Newman wrote:
> On Fri, Oct 21, 2022 at 3:13 PM James Morse <james.morse@arm.com> wrote:
>>
>> MPAM's monitors have an overflow interrupt, so it needs to be possible
>> to walk the domains list in irq context. RCU is ideal for this,
>> but some paths need to be able to sleep to allocate memory.

> I'm curious about this requirement. There are already counters which can
> overflow on Intel, but we've been able to detect overflows soon enough
> by checking at a reasonable interval. Are we expecting MSCs to have
> counters that overflow so quickly that the overflows need to be handled
> directly in IRQ context vs being able to run a threaded handler before
> the second overflow?

Ultimately, I don't know. MPAM has three sizes of counter, 31, 44 and 63.
I think its entirely possible someone builds a system with an inconvenient size for the
way they use it - but this wasn't how I anticipated this getting used...


> It seems like MBM would be really intrusive if it could cause the system
> to process overflow IRQs at a high rate.

... I agree ..


> Also is the overflow interrupt handler in one of your MPAM preview
> branches? I was only able to find an error IRQ handler in
> mpam/snapshot/v6.0:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tree/drivers/platform/mpam/mpam_devices.c?h=mpam/snapshot/v6.0#n1813

Because there probably won't be enough monitors to expose the free-running resctrl files,
I anticipate that most use of the memory bandwidth counters will be via perf, which gives
MPAM the start/stop calls it needs to allocate and free a monitor.

The PMU driver gets asked to read the counters in IRQ context, see __perf_event_read()
called via smp_call_function_single(). (I'm sure there are others).

This is the first reason why the domain list needs to be protected by something like RCU.

Perf also has a sampling mode, where it sets the value to overflow after a specific number
of events, and times how long that takes to occur. (I haven't completely got my head round
it yet) In this mode, the MPAM driver would need to invoke the PMU driver to read the
counters in IRQ context.

I haven't written the overflow  interrupt code yet because I've got no access to a
platform (virtual or otherwise) with working counters, so couldn't possibly test it. (See
also, the 44 and 63 bit counter support!)

I was being lazy with the commit message and only describing the last case. Is the
future-plot-arc important? It would result in a bit of a brain-dump/essay in the commit
message.


Thanks,

James
