Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336FE6F0708
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243846AbjD0OLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243547AbjD0OLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:11:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B4994690
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:11:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2965143D;
        Thu, 27 Apr 2023 07:12:26 -0700 (PDT)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2DBB3F7D8;
        Thu, 27 Apr 2023 07:11:17 -0700 (PDT)
Message-ID: <8e92b43d-dd8f-80e0-e31b-5ebfed418a0f@arm.com>
Date:   Thu, 27 Apr 2023 15:11:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 09/19] x86/resctrl: Queue mon_event_read() instead of
 sending an IPI
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
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>
References: <20230320172620.18254-1-james.morse@arm.com>
 <20230320172620.18254-10-james.morse@arm.com>
 <CALPaoCgXYBphe+toVBmF6eGKz8sCHYsaTvvd5ZnrJBf07tjbzg@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <CALPaoCgXYBphe+toVBmF6eGKz8sCHYsaTvvd5ZnrJBf07tjbzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 22/03/2023 14:07, Peter Newman wrote:
> On Mon, Mar 20, 2023 at 6:27 PM James Morse <james.morse@arm.com> wrote:
>>
>> x86 is blessed with an abundance of monitors, one per RMID, that can be
> 
> As I explained earlier, this is not the case on AMD.

I'll change it so say Intel.


>> read from any CPU in the domain. MPAMs monitors reside in the MMIO MSC,
>> the number implemented is up to the manufacturer. This means when there are
>> fewer monitors than needed, they need to be allocated and freed.
>>
>> Worse, the domain may be broken up into slices, and the MMIO accesses
>> for each slice may need performing from different CPUs.
>>
>> These two details mean MPAMs monitor code needs to be able to sleep, and
>> IPI another CPU in the domain to read from a resource that has been sliced.
> 
> This doesn't sound very convincing. Could mon_event_read() IPI all the
> CPUs in the domain? (after waiting to allocate and install monitors
> when necessary?)

On the majority of platforms this would be a waste of time as the IPI only needs sending
to one. I'd like to keep the cost of being strange limited to the strange platforms.

I don't think exposing a 'sub domain' cpumask to resctrl is helpful: this needs to be
hidden in the architecture specific code.

The IPI is because of SoC components being implemented as slices which are private to that
slice.


The sleeping is because the CSU counters are allowed to be 'not ready' immediately after
programming. The time is short, and to allow platforms that have too few CSU monitors to
support the same user-interface as x86^W Intel, the MPAM driver needs to be able to
multiplex a single CSU monitor between multiple control/monitor groups. Allowing it to
sleep for the advertised not-ready period is the simplest way of doing this.


>> mon_event_read() already invokes mon_event_count() via IPI, which means
>> this isn't possible. On systems using nohz-full, some CPUs need to be
>> interrupted to run kernel work as they otherwise stay in user-space
>> running realtime workloads. Interrupting these CPUs should be avoided,
>> and scheduling work on them may never complete.
>>
>> Change mon_event_read() to pick a housekeeping CPU, (one that is not using
>> nohz_full) and schedule mon_event_count() and wait. If all the CPUs
>> in a domain are using nohz-full, then an IPI is used as the fallback.
>>
>> This function is only used in response to a user-space filesystem request
>> (not the timing sensitive overflow code).
>>
>> This allows MPAM to hide the slice behaviour from resctrl, and to keep
>> the monitor-allocation in monitor.c.
> 
> This goal sounds more likely.
> 
> If it makes the initial enablement smoother, then I'm all for it.

> Reviewed-By: Peter Newman <peternewman@google.com>
> 
> These changes worked fine for me on tip/master, though there were merge
> conflicts to resolve.
> 
> Tested-By: Peter Newman <peternewman@google.com>

Thanks!


James
