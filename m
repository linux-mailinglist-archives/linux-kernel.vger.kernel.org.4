Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7492B6B2C20
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 18:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCIRgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 12:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjCIRfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 12:35:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE891FA0B9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 09:35:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C987AD7;
        Thu,  9 Mar 2023 09:36:19 -0800 (PST)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A6073F5A1;
        Thu,  9 Mar 2023 09:35:31 -0800 (PST)
Message-ID: <f8a25b5f-4a7d-0891-1152-33f349059b5d@arm.com>
Date:   Thu, 9 Mar 2023 17:35:29 +0000
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
 <c8d85eae-e291-99a6-509c-94c41514ac16@arm.com>
 <CALPaoCgEaT2oax35ezRydUZwL9bMmMFFr2wRqPe4VYAnEQ-GGg@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <CALPaoCgEaT2oax35ezRydUZwL9bMmMFFr2wRqPe4VYAnEQ-GGg@mail.gmail.com>
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

On 09/03/2023 13:41, Peter Newman wrote:
> On Wed, Mar 8, 2023 at 6:45 PM James Morse <james.morse@arm.com> wrote:
>> On 06/03/2023 13:14, Peter Newman wrote:
>>> On Mon, Mar 6, 2023 at 12:34 PM James Morse <james.morse@arm.com> wrote:
>>
>>> Instead, when configuring a counter, could you use the firmware table
>>> value to compute the time when the counter will next be valid and return
>>> errors on read requests received before that?
>>
>> The monitor might get re-allocated, re-programmed and become valid for a different
>> PARTID+PMG in the mean time. I don't think these things should remain allocated over a
>> return to user-space. Without doing that I don't see how we can return-early and make
>> progress.
>>
>> How long should a CSU monitor remain allocated to a PARTID+PMG? Currently its only for the
>> duration of the read() syscall on the file.
>>
>>
>> The problem with MPAM is too much of it is optional. This particular behaviour is only
>> valid for CSU monitors, (llc_occupancy), and then, only if your hardware designers didn't
>> have a value to hand when the monitor is programmed, and need to do a scan of the cache to
>> come up with a result. The retry is only triggered if the hardware sets NRDY.
>> This is also only necessary if there aren't enough monitors for every RMID/(PARTID*PMG) to
>> have its own. If there were enough, the monitors could be allocated and programmed at
>> startup, and the whole thing becomes cheaper to access.
>>
>> If a hardware platform needs time to do this, it has to come from somewhere. I don't think
>> maintaining an epoch based list of which monitor secretly belongs to a PARTID+PMG in the
>> hope user-space reads the file again 'quickly enough' is going to be maintainable.
>>
>> If returning errors early is an important use-case, I can suggest ensuring the MPAM driver
>> allocates CSU monitors up-front if there are enough (today it only does this for MBWU
>> monitors). We then have to hope that folk who care about this also build hardware
>> platforms with enough monitors.
> 
> Thanks, this makes more sense now. Since CSU data isn't cumulative, I
> see how synchronously collecting a snapshot is useful in this situation.
> I was more concerned about understanding the need for the new behavior
> than getting errors back quickly.
> 
> However, I do want to be sure that MBWU counters will never be silently
> deallocated because we will never be able to trust the data unless we
> know that the counter has been watching the group's tasks for the
> entirety of the measurement window.

Absolutely.

The MPAM driver requires the number of monitors to match the value of
resctrl_arch_system_num_rmid_idx(), otherwise 'mbm_local' won't be offered via resctrl.
(see class_has_usable_mbwu() in [0])

If the files exist in resctrl, then a monitor was reserved for this PARTID+PMG, and won't
get allocated for anything else.


[0]
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot/v6.2&id=f28d3fefdcf7022a49f62752acbecf180ea7d32f


> Unlike on AMD, MPAM allows software to control which PARTID+PMG the
> monitoring hardware is watching. Could we instead make the user
> explicitly request the mbm_{total,local}_bytes events be allocated to
> monitoring groups after creating them? Or even just allocating the
> events on monitoring group creation only when they're available could
> also be marginably usable if a single user agent is managing rdtgroups.

Hmmmm, what would that look like to user-space?

I'm against inventing anything new here until there is feature-parity where possible
upstream. It's a walk, then run kind of thing.

I worry that extra steps to setup the monitoring on MPAM:resctrl will be missing or broken
in many (all?) software projects if they're not also required on Intel:resctrl.

My plan for hardware with insufficient counters is to make the counters accessible via
perf, and do that in a way that works on Intel and AMD too.


Thanks,

James
