Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257EF6A9F04
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjCCSiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjCCShv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:37:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 309F061884
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:37:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 303A6143D;
        Fri,  3 Mar 2023 10:38:23 -0800 (PST)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64F183F93E;
        Fri,  3 Mar 2023 10:37:36 -0800 (PST)
Message-ID: <aef194a3-83b4-a9b8-7537-ebe53f07a14a@arm.com>
Date:   Fri, 3 Mar 2023 18:37:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 07/18] x86/resctrl: Move CLOSID/RMID matching and
 setting to use helpers
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
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-8-james.morse@arm.com>
 <IA1PR11MB6097186B7E9C2CF52A7F29C99BC69@IA1PR11MB6097.namprd11.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <IA1PR11MB6097186B7E9C2CF52A7F29C99BC69@IA1PR11MB6097.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 17/01/2023 19:10, Yu, Fenghua wrote:
>> When switching tasks, the CLOSID and RMID that the new task should use are
>> stored in struct task_struct. For x86 the CLOSID known by resctrl, the value in
>> task_struct, and the value written to the CPU register are all the same thing.
>>
>> MPAM's CPU interface has two different PARTID's one for data accesses the
>> other for instruction fetch. Storing resctrl's CLOSID value in struct task_struct
>> implies the arch code knows whether resctrl is using CDP.
>>
>> Move the matching and setting of the struct task_struct properties to use
>> helpers. This allows arm64 to store the hardware format of the register, instead
>> of having to convert it each time.
>>
>> __rdtgroup_move_task()s use of READ_ONCE()/WRITE_ONCE() ensures torn
>> values aren't seen as another CPU may schedule the task being moved while the
>> value is being changed. MPAM has an additional corner-case here as the PMG
>> bits extend the PARTID space. If the scheduler sees a new-CLOSID but old-RMID,
>> the task will dirty an RMID that the limbo code is not watching causing an
>> inaccurate count. x86's RMID are independent values, so the limbo code will still
>> be watching the old-RMID in this circumstance.
>> To avoid this, arm64 needs both the CLOSID/RMID WRITE_ONCE()d together.
>> Both values must be provided together.
>>
>> Because MPAM's RMID values are not unique, the CLOSID must be provided
>> when matching the RMID.

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index e1f879e13823..ced7400decae 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -84,7 +84,7 @@ void rdt_last_cmd_printf(const char *fmt, ...)
>>   *
>>   * Using a global CLOSID across all resources has some advantages and
>>   * some drawbacks:
>> - * + We can simply set "current->closid" to assign a task to a resource
>> + * + We can simply set current's closid to assign a task to a resource
>>   *   group.
> 
> Seems this change doesn't gain anything. Maybe this change can be removed?

After this patch the CLOSID might not be in current at all, this comment would be the only
thing that suggests it is. I'd prefer not to suggest anyone access 'current->closid'
directly in resctrl, as such code wouldn't compile on arm64.

This is a 'saves bugs in the future' change.


>>   * + Context switch code can avoid extra memory references deciding which
>>   *   CLOSID to load into the PQR_ASSOC MSR

(please trim your replies!)


Thanks,

James
