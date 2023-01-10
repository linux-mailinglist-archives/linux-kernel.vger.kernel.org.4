Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C68C664804
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbjAJSCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238650AbjAJR6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:58:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 000F22019
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:57:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 455722F4;
        Tue, 10 Jan 2023 09:58:15 -0800 (PST)
Received: from [10.1.196.46] (eglon.cambridge.arm.com [10.1.196.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49B603F67D;
        Tue, 10 Jan 2023 09:57:30 -0800 (PST)
Message-ID: <54d14a9f-5983-0a33-9340-c0ff48cc9757@arm.com>
Date:   Tue, 10 Jan 2023 17:57:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 01/18] x86/resctrl: Track the closid with the rmid
Content-Language: en-GB
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <20221021131204.5581-1-james.morse@arm.com>
 <20221021131204.5581-2-james.morse@arm.com>
 <IA1PR11MB609724963D5C6086A98AC0479BFB9@IA1PR11MB6097.namprd11.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <IA1PR11MB609724963D5C6086A98AC0479BFB9@IA1PR11MB6097.namprd11.prod.outlook.com>
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

Hi Fenghua,

On 06/01/2023 02:57, Yu, Fenghua wrote:
>> James Morse <james.morse@arm.com> writes:
>>
>> x86's RMID are independent of the CLOSID. An RMID can be allocated, used and
>> freed without considering the CLOSID.
>>
>> MPAM's equivalent feature is PMG, which is not an independent number, it
>> extends the CLOSID/PARTID space. For MPAM, only PMG-bits worth of 'RMID'
>> can be allocated for a single CLOSID.
>> i.e. if there is 1 bit of PMG space, then each CLOSID can have two monitor
>> groups.
>>
>> To allow rescrl to disambiguate RMID values for different CLOSID, everything in
> 
> s/rescrl/resctrl/
> 
>> resctrl that keeps an RMID value needs to know the CLOSID too. This will always
>> be ignored on x86.


>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 5f7128686cfd..4b243ba88882 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -519,7 +519,7 @@ struct rdt_domain *get_domain_from_cpu(int cpu,
>> struct rdt_resource *r);  int closids_supported(void);  void closid_free(int closid);
>> int alloc_rmid(void); -void free_rmid(u32 rmid);
>> +void free_rmid(u32 closid, u32 rmid);
>>  int rdt_get_mon_l3_config(struct rdt_resource *r);  void mon_event_count(void
>> *info);  int rdtgroup_mondata_show(struct seq_file *m, void *arg); diff --git
>> a/arch/x86/kernel/cpu/resctrl/monitor.c
>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index efe0c30d3a12..f1f66c9942a5 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -25,6 +25,7 @@
>>  #include "internal.h"
>>
>>  struct rmid_entry {
>> +	u32				closid;
> 
> Could you please add a comment for this closid field? It's expected to be form x86 RMID entry.
> So it's deserved a comment to explain a bit more on this field.

Sure ... what does it need to convey?
I'm not sure what you mean by "expected to be form x86 RMID entry".

My medium verbosity version looks like this:
|        /*
|         * Some architectures's resctrl_arch_rmid_read() needs the CLOSID value
|         * in order to access the correct monitor. This field provides the
|         * value to list walkers like __check_limbo(). On x86 this is ignored.
|         */


Does this cover it?


Thanks,

James


>>  	u32				rmid;
>>  	int				busy;
>>  	struct list_head		list;
