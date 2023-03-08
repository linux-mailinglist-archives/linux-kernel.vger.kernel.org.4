Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071096B1060
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCHRpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCHRpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:45:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CD3830CD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:45:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 930B71063;
        Wed,  8 Mar 2023 09:46:24 -0800 (PST)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12EBA3F67D;
        Wed,  8 Mar 2023 09:45:37 -0800 (PST)
Message-ID: <c8d85eae-e291-99a6-509c-94c41514ac16@arm.com>
Date:   Wed, 8 Mar 2023 17:45:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 09/18] x86/resctrl: Allow resctrl_arch_rmid_read() to
 sleep
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
        Xin Hao <xhao@linux.alibaba.com>,
        Stephane Eranian <eranian@google.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-10-james.morse@arm.com>
 <CALPaoCg4T52ju5XJC-BVX-EuZUtc67LruWbgyH5s8CoiEwOUPw@mail.gmail.com>
 <c3ca6d66-e58c-8ace-e88e-45ded5de836f@arm.com>
 <CALPaoCik0j7ATCv-He5HWVqbL+3njpqO1fhF5FQJO7qqT1zR3w@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <CALPaoCik0j7ATCv-He5HWVqbL+3njpqO1fhF5FQJO7qqT1zR3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 06/03/2023 13:14, Peter Newman wrote:
> On Mon, Mar 6, 2023 at 12:34 PM James Morse <james.morse@arm.com> wrote:
>> On 23/01/2023 15:33, Peter Newman wrote:
>>> On Fri, Jan 13, 2023 at 6:56 PM James Morse <james.morse@arm.com> wrote:
>>>> MPAM's cache occupancy counters can take a little while to settle once
>>>> the monitor has been configured. The maximum settling time is described
>>>> to the driver via a firmware table. The value could be large enough
>>>> that it makes sense to sleep.
>>>
>>> Would it be easier to return an error when reading the occupancy count
>>> too soon after configuration? On Intel it is already normal for counter
>>> reads to fail on newly-allocated RMIDs.
>>
>> For x86, you have as many counters as there are RMIDs, so there is no issue just accessing
>> the counter.
> 
> I should have said AMD instead of Intel, because their implementations
> have far fewer counters than RMIDs.

Right, I assume Intel and AMD behaved in the same way here.


>> With MPAM there may be as few as 1 monitor for the CSU (cache storage utilisation)
>> counter, which needs to be multiplexed between different PARTID to find the cache
>> occupancy (This works for CSU because its a stable count, it doesn't work for the
>> bandwidth monitors)
>> On such a platform the monitor needs to be allocated and programmed before it reads a
>> value for a particular PARTID/CLOSID. If you had two threads trying to read the same
>> counter, they could interleave perfectly to prevent either thread managing to read a value.
>> The 'not ready' time is advertised in a firmware table, and the driver will wait at most
>> that long before giving up and returning an error.

> Likewise, on AMD, a repeating sequence of tasks which are LRU in terms
> of counter -> RMID allocation could prevent RMID event reads from ever
> returning a value.

Isn't that a terrible user-space interface? "If someone else is reading a similar file,
neither of you make progress".


> The main difference I see with MPAM is that software allocates the
> counters instead of hardware, but the overall behavior sounds the same.
> 
> The part I object to is introducing the wait to the counter read because
> existing software already expects an immediate error when reading a
> counter too soon. To produce accurate data, these readings are usually
> read at intervals of multiple seconds.


> Instead, when configuring a counter, could you use the firmware table
> value to compute the time when the counter will next be valid and return
> errors on read requests received before that?

The monitor might get re-allocated, re-programmed and become valid for a different
PARTID+PMG in the mean time. I don't think these things should remain allocated over a
return to user-space. Without doing that I don't see how we can return-early and make
progress.

How long should a CSU monitor remain allocated to a PARTID+PMG? Currently its only for the
duration of the read() syscall on the file.


The problem with MPAM is too much of it is optional. This particular behaviour is only
valid for CSU monitors, (llc_occupancy), and then, only if your hardware designers didn't
have a value to hand when the monitor is programmed, and need to do a scan of the cache to
come up with a result. The retry is only triggered if the hardware sets NRDY.
This is also only necessary if there aren't enough monitors for every RMID/(PARTID*PMG) to
have its own. If there were enough, the monitors could be allocated and programmed at
startup, and the whole thing becomes cheaper to access.

If a hardware platform needs time to do this, it has to come from somewhere. I don't think
maintaining an epoch based list of which monitor secretly belongs to a PARTID+PMG in the
hope user-space reads the file again 'quickly enough' is going to be maintainable.

If returning errors early is an important use-case, I can suggest ensuring the MPAM driver
allocates CSU monitors up-front if there are enough (today it only does this for MBWU
monitors). We then have to hope that folk who care about this also build hardware
platforms with enough monitors.


Thanks,

James
