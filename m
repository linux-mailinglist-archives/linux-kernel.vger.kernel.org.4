Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5480B7249B6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbjFFRD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbjFFRDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:03:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF40310C2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 10:03:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 864612F4;
        Tue,  6 Jun 2023 10:04:37 -0700 (PDT)
Received: from [10.1.196.47] (eglon.cambridge.arm.com [10.1.196.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C1233F663;
        Tue,  6 Jun 2023 10:03:49 -0700 (PDT)
Message-ID: <7ff7fcf9-725b-fb3d-43f3-b80a1df3a001@arm.com>
Date:   Tue, 6 Jun 2023 18:03:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 12/24] x86/resctrl: Make resctrl_arch_rmid_read() retry
 when it is interrupted
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
        Xin Hao <xhao@linux.alibaba.com>, dfustini@baylibre.com
References: <20230525180209.19497-1-james.morse@arm.com>
 <20230525180209.19497-13-james.morse@arm.com>
 <CALPaoCjLjngabG32m4X8sSwK-bbZ28oL6BVKSn_dFnDwPzkDkg@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <CALPaoCjLjngabG32m4X8sSwK-bbZ28oL6BVKSn_dFnDwPzkDkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 06/06/2023 09:49, Peter Newman wrote:
> On Thu, May 25, 2023 at 8:03 PM James Morse <james.morse@arm.com> wrote:
>> +interrupted:
>> +       am = get_arch_mbm_state(hw_dom, rmid, eventid);
>> +       if (am)
>> +               start_msr_val = atomic64_read(&am->prev_msr);
>> +
>>         ret = __rmid_read(rmid, eventid, &msr_val);
>>         if (ret)
>>                 return ret;
>>
>>         am = get_arch_mbm_state(hw_dom, rmid, eventid);
>>         if (am) {
>> -               am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
>> -                                                hw_res->mbm_width);
>> -               chunks = get_corrected_mbm_count(rmid, am->chunks);
>> -               am->prev_msr = msr_val;
>> +               old_msr_val = atomic64_cmpxchg(&am->prev_msr, start_msr_val,
>> +                                              msr_val);
>> +               if (old_msr_val != start_msr_val)
>> +                       goto interrupted;
>> +
>> +               chunks = mbm_overflow_count(start_msr_val, msr_val,
>> +                                           hw_res->mbm_width);
>> +               atomic64_add(chunks, &am->chunks);
>> +
>> +               chunks = get_corrected_mbm_count(rmid,
>> +                                                atomic64_read(&am->chunks));
>>         } else {
>>                 chunks = msr_val;
>>         }
> 
> It looks like if __rmid_read() is interrupted by an occupancy counter
> read between writing QM_EVTSEL and reading QM_CTR, it will not perform
> any update to am->prev_msr, and the interrupted read will return the
> same counter value as in the interrupting read.

Yup, that's a problem. I was only looking at the mbm state in memory, not the CPU register.
I think the fix is to read back QM_EVTSEL after reading QM_CTR. I'll do this in
__rmid_read() to avoid returning -EINTR. It creates two retry loops which is annoying, but
making the window larger means you're more likely to see false positives.

----------------------------%<----------------------------
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl
/monitor.c
index e24390d2e661..aeba035bb680 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -101,6 +101,7 @@ static inline u64 get_corrected_mbm_count(u32 rmid, unsigned
 long val)

 static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
 {
+       u32 _rmid, _eventid;
        u64 msr_val;

        /*
@@ -110,9 +111,15 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
         * IA32_QM_CTR.data (bits 61:0) reports the monitored data.
         * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
         * are error bits.
+        * QM_EVTSEL is re-read to detect if this function was interrupted by
+        * another call, meaning the QM_CTR value may belong to a different
+        * event.
         */
-       wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
-       rdmsrl(MSR_IA32_QM_CTR, msr_val);
+       do {
+               wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
+               rdmsrl(MSR_IA32_QM_CTR, msr_val);
+               rdmsr(MSR_IA32_QM_EVTSEL, _eventid, _rmid);
+       } while (eventid != _eventid || rmid != _rmid);

        if (msr_val & RMID_VAL_ERROR)
                return -EIO;
----------------------------%<----------------------------


Thanks!

James
