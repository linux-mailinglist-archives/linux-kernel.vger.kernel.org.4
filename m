Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AD16F070A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243860AbjD0OMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243830AbjD0OM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:12:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22FA71FCE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:12:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB98F143D;
        Thu, 27 Apr 2023 07:13:10 -0700 (PDT)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F8D63F7D8;
        Thu, 27 Apr 2023 07:12:15 -0700 (PDT)
Message-ID: <046af0e6-8e9a-ca74-048a-c0c9144ebb62@arm.com>
Date:   Thu, 27 Apr 2023 15:12:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 09/19] x86/resctrl: Queue mon_event_read() instead of
 sending an IPI
Content-Language: en-GB
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
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
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com
References: <20230320172620.18254-1-james.morse@arm.com>
 <20230320172620.18254-10-james.morse@arm.com>
 <5e6a2e0a-6f31-c9b0-5eec-346fd072d286@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <5e6a2e0a-6f31-c9b0-5eec-346fd072d286@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 01/04/2023 00:25, Reinette Chatre wrote:
> On 3/20/2023 10:26 AM, James Morse wrote:
>> x86 is blessed with an abundance of monitors, one per RMID, that can be
>> read from any CPU in the domain. MPAMs monitors reside in the MMIO MSC,
>> the number implemented is up to the manufacturer. This means when there are
>> fewer monitors than needed, they need to be allocated and freed.
>>
>> Worse, the domain may be broken up into slices, and the MMIO accesses
>> for each slice may need performing from different CPUs.
>>
>> These two details mean MPAMs monitor code needs to be able to sleep, and
>> IPI another CPU in the domain to read from a resource that has been sliced.
>>
>> mon_event_read() already invokes mon_event_count() via IPI, which means
>> this isn't possible. On systems using nohz-full, some CPUs need to be
>> interrupted to run kernel work as they otherwise stay in user-space
>> running realtime workloads. Interrupting these CPUs should be avoided,
>> and scheduling work on them may never complete.
>>
>> Change mon_event_read() to pick a housekeeping CPU, (one that is not using
>> nohz_full) and schedule mon_event_count() and wait. If all the CPUs
>> in a domain are using nohz-full, then an IPI is used as the fallback.
> 
> It is not clear to me where in this solution an IPI is used as fallback ...
> (see below) 

>> @@ -537,7 +543,16 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>>  	rr->val = 0;
>>  	rr->first = first;
>>  
>> -	smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
>> +	cpu = get_cpu();
>> +	if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
>> +		mon_event_count(rr);
>> +		put_cpu();
>> +	} else {
>> +		put_cpu();
>> +
>> +		cpu = cpumask_any_housekeeping(&d->cpu_mask);
>> +		smp_call_on_cpu(cpu, mon_event_count, rr, false);
>> +	}
>>  }
>>  
> 
> ... from what I can tell there is no IPI fallback here. As per previous
> patch I understand cpumask_any_housekeeping() could still return
> a nohz_full CPU and calling smp_call_on_cpu() on it would not send
> an IPI but instead queue the work to it. What did I miss?

Huh, looks like its still in my git-stash. Sorry about that. The combined hunk looks like
this:
----------------------%<----------------------
@@ -537,7 +550,26 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
        rr->val = 0;
        rr->first = first;

-       smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
+       cpu = get_cpu();
+       if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
+               mon_event_count(rr);
+               put_cpu();
+       } else {
+               put_cpu();
+
+               cpu = cpumask_any_housekeeping(&d->cpu_mask);
+
+               /*
+                * cpumask_any_housekeeping() prefers housekeeping CPUs, but
+                * are all the CPUs nohz_full? If yes, pick a CPU to IPI.
+                * MPAM's resctrl_arch_rmid_read() is unable to read the
+                * counters on some platforms if its called in irq context.
+                */
+               if (tick_nohz_full_cpu(cpu))
+                       smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
+               else
+                       smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
+       }
 }

----------------------%<----------------------

Where smp_mon_event_count() is a static wrapper to make the types work.


Thanks,

James
