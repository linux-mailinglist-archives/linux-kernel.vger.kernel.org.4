Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CA9607210
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJUIXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiJUIWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:22:50 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3318106A4E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:22:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=shawnwang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VSifkpr_1666340561;
Received: from 30.97.48.140(mailfrom:shawnwang@linux.alibaba.com fp:SMTPD_---0VSifkpr_1666340561)
          by smtp.aliyun-inc.com;
          Fri, 21 Oct 2022 16:22:43 +0800
Message-ID: <86fc22a2-e779-b7ab-67d6-a3aff975ae56@linux.alibaba.com>
Date:   Fri, 21 Oct 2022 16:22:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
From:   Shawn Wang <shawnwang@linux.alibaba.com>
Subject: Re: [PATCH v2] x86/resctrl: Clear the stale staged config after the
 configuration is completed
To:     Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com
References: <1665304608-120466-1-git-send-email-shawnwang@linux.alibaba.com>
 <7fa6ed4e-abae-85fb-4e95-8c73755a4263@intel.com>
 <ad08eee6-cfea-3858-0def-e2e3fef315fb@linux.alibaba.com>
 <ff44b0ff-6adb-3bae-d17e-4c341c09df5d@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        James Morse <james.morse@arm.com>, jamie@nuviainc.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <ff44b0ff-6adb-3bae-d17e-4c341c09df5d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 10/21/2022 12:35 AM, Reinette Chatre wrote:

...

>>>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>> index 1dafbdc5ac31..2c719da5544f 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>> @@ -338,6 +338,8 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
>>>>                    msr_param.high = max(msr_param.high, idx + 1);
>>>>                }
>>>>            }
>>>> +        /* Clear the stale staged config */
>>>> +        memset(d->staged_config, 0, sizeof(d->staged_config));
>>>>        }
>>>>          if (cpumask_empty(cpu_mask))
>>>
>>> Please also ensure that the temporary storage is cleared if there is an
>>> early exist because of failure. Please do not duplicate the memset() code
>>> but instead move it to a common exit location.
>>>
>>
>> There are two different resctrl_arch_update_domains() function call paths:
>>
>> 1.rdtgroup_mkdir()->rdtgroup_mkdir_ctrl_mon()->rdtgroup_init_alloc()->resctrl_arch_update_domains()
>> 2.rdtgroup_schemata_write()->resctrl_arch_update_domains()
>>
>> Perhaps there is no common exit location if we want to clear staged_config[] after every call of resctrl_arch_update_domains().
> 
> I was referring to a common exit out of resctrl_arch_update_domains().
> 
> Look at how resctrl_arch_update_domains() behaves with this change:
> 
> resctrl_arch_update_domains()
> {
> 	...
> 
> 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
> 		return -ENOMEM;
> 
> 	...
> 	list_for_each_entry(d, &r->domains, list) {
> 		...
> 		memset(d->staged_config, 0, sizeof(d->staged_config));
> 	}
> 
> 
> 	...
> done:
> 	free_cpumask_var(cpu_mask);
> 	
> 	return 0;
> }
> 
> 
> The goal of this fix is to ensure that staged_config[] is cleared on
> return from resctrl_arch_update_domains() so that there is no stale
> data in staged_config[] when resctrl_arch_update_domains() is called
> again.
> 
> Considering this, I can see two scenarios in the above solution where
> staged_config[] is not cleared on exit from resctrl_arch_update_domains():

It may not be enough to just clear staged_config[] when 
resctrl_arch_update_domains() exits. I think the fix needs to make sure 
staged_config[] can be cleared where it is set.

The modification of staged_config[] comes from two paths:

Path 1:
rdtgroup_schemata_write() {
	...
	rdtgroup_parse_resource() 	// set staged_config[]
	...				
	resctrl_arch_update_domains() 	// clear staged_config[]
	...
}

Path 2:
rdtgroup_init_alloc() {
	...
	rdtgroup_init_mba()/rdtgroup_init_cat()	// set staged_config[]
	...
	resctrl_arch_update_domains()		// clear staged_config[]
	...
}

If we clear staged_config[] in resctrl_arch_update_domains(), goto 
statement for error handling between setting staged_config[] and calling 
resctrl_arch_update_domains() will be ignored. This can still remain the 
stale staged_config[].

I think maybe it is better to put the clearing work where 
rdtgroup_schemata_write() and rdtgroup_init_alloc() exit.

(Sorry, I mistakenly wrote rdtgroup_init_alloc() to 
rdtgroup_mkdir_ctrl_mon() in my last reply.)

Thank you,

Shawn
