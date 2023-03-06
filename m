Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FE16ABE35
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjCFLdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjCFLdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:33:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9F81E3B4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:33:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1AD212FC;
        Mon,  6 Mar 2023 03:34:08 -0800 (PST)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEBE73F5A1;
        Mon,  6 Mar 2023 03:33:22 -0800 (PST)
Message-ID: <314321ca-2911-efa5-c7f8-23134363054c@arm.com>
Date:   Mon, 6 Mar 2023 11:33:21 +0000
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
        Xin Hao <xhao@linux.alibaba.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-10-james.morse@arm.com>
 <CALPaoCisUdTzSP6E+9VVa4okjvcCjs6p7MhyLYpzxVGs7+8nNA@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <CALPaoCisUdTzSP6E+9VVa4okjvcCjs6p7MhyLYpzxVGs7+8nNA@mail.gmail.com>
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

On 23/01/2023 13:54, Peter Newman wrote:
> On Fri, Jan 13, 2023 at 6:56 PM James Morse <james.morse@arm.com> wrote:
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index d309b830aeb2..d6ae4b713801 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -206,17 +206,19 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
>>         return chunks >> shift;
>>  }
>>
>> -int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>> -                          u32 closid, u32 rmid, enum resctrl_event_id eventid,
>> -                          u64 *val)
>> +struct __rmid_read_arg
>>  {
>> -       struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>> -       struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>> -       struct arch_mbm_state *am;
>> -       u64 msr_val, chunks;
>> +       u32 rmid;
>> +       enum resctrl_event_id eventid;
>>
>> -       if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
>> -               return -EINVAL;
>> +       u64 msr_val;
>> +};
>> +
>> +static void __rmid_read(void *arg)
>> +{
>> +       enum resctrl_event_id eventid = ((struct __rmid_read_arg *)arg)->eventid;
>> +       u32 rmid = ((struct __rmid_read_arg *)arg)->rmid;
>> +       u64 msr_val;
>>
>>         /*
>>          * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
>> @@ -229,6 +231,28 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>>         wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
>>         rdmsrl(MSR_IA32_QM_CTR, msr_val);
>>
>> +       ((struct __rmid_read_arg *)arg)->msr_val = msr_val;
>> +}
>> +
>> +int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>> +                          u32 closid, u32 rmid, enum resctrl_event_id eventid,
>> +                          u64 *val)
>> +{
>> +       struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>> +       struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>> +       struct __rmid_read_arg arg;
>> +       struct arch_mbm_state *am;
>> +       u64 msr_val, chunks;
>> +       int err;
>> +
>> +       arg.rmid = rmid;
>> +       arg.eventid = eventid;
>> +
>> +       err = smp_call_function_any(&d->cpu_mask, __rmid_read, &arg, true);
>> +       if (err)
>> +               return err;
>> +
>> +       msr_val = arg.msr_val;
> 
> These changes are conflicting now after v6.2-rc4 due to my recent
> changes in resctrl_arch_rmid_read(), which include my own
> reintroduction of __rmid_read():
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=2a81160d29d65b5876ab3f824fda99ae0219f05e
> 
> Fortunately it looks like our respective versions of __rmid_read()
> aren't too much different from the original, but __rmid_read() does
> have a new call site in resctrl_arch_reset_rmid() to record initial
> event counts.

Yup, this is the normal headache when rebasing over other changes.
Thanks for fixing that thing - I thought the 'first' behaviour in the filesystem code
covered it, but clearly it doesn't.


Thanks,

James
