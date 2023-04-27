Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5295B6F0717
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243906AbjD0OQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243284AbjD0OQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:16:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DB8A49D9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:16:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C839F11FB;
        Thu, 27 Apr 2023 07:16:51 -0700 (PDT)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6949A3F64C;
        Thu, 27 Apr 2023 07:12:45 -0700 (PDT)
Message-ID: <85ae6016-5159-11c7-25e3-9d421195a453@arm.com>
Date:   Thu, 27 Apr 2023 15:12:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 10/19] x86/resctrl: Allow resctrl_arch_rmid_read() to
 sleep
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
 <20230320172620.18254-11-james.morse@arm.com>
 <db59f6df-feb0-280d-88bd-6bbf1b6e7a1e@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <db59f6df-feb0-280d-88bd-6bbf1b6e7a1e@intel.com>
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

On 01/04/2023 00:26, Reinette Chatre wrote:
> On 3/20/2023 10:26 AM, James Morse wrote:
> 
> ...
> 
>>  int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>>  			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
>>  			   u64 *val)
>>  {
>>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>  	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>> +	struct __rmid_read_arg arg;
>>  	struct arch_mbm_state *am;
>>  	u64 msr_val, chunks;
>> -	int ret;
>> +	int err;
>>  
>> -	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
>> -		return -EINVAL;
>> +	arg.rmid = rmid;
>> +	arg.eventid = eventid;
>>  
>> -	ret = __rmid_read(rmid, eventid, &msr_val);
>> -	if (ret)
>> -		return ret;
>> +	err = smp_call_function_any(&d->cpu_mask, smp_call_rmid_read, &arg, true);
>> +	if (err)
>> +		return err;
> 
> This seems to break the assumption of expected return values. __mon_event_count()
> does: 
> 	rr->err = resctrl_arch_rmid_read()
> 
> and later rdtgroup_mondata_show() only expects -EIO or -EINVAL as errors, with
> default of success.

Yes, looks like I dithered on whether cpus_read_lock() should be held over this function,
or it should tolerate the error. This is protected by rdtgroup_mutex, which means the
hotplug callbacks can't run concurrently, so the error can't occur.

I'll change it to ignore the return value.


Thanks,

James


