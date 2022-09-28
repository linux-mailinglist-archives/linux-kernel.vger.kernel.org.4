Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BED5EDDE1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiI1Njw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbiI1NjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:39:20 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D0EA4062
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:39:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=shawnwang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VQwO3md_1664372351;
Received: from 192.168.1.184(mailfrom:shawnwang@linux.alibaba.com fp:SMTPD_---0VQwO3md_1664372351)
          by smtp.aliyun-inc.com;
          Wed, 28 Sep 2022 21:39:12 +0800
Message-ID: <e9dc4d2a-e404-990a-3efc-c359799bc986@linux.alibaba.com>
Date:   Wed, 28 Sep 2022 21:37:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH] x86/resctrl: Clear the staged configs when destroying
 schemata list
To:     Reinette Chatre <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>, fenghua.yu@intel.com
References: <1664247269-41295-1-git-send-email-shawnwang@linux.alibaba.com>
 <80d6238b-223c-e60a-6930-24a981d9dd0c@arm.com>
 <2728c354-ac75-be4c-66ad-86ebd9c50248@intel.com>
From:   Shawn Wang <shawnwang@linux.alibaba.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <2728c354-ac75-be4c-66ad-86ebd9c50248@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette and James,

Sorry for some mistakes in the last reply email, so I send it again.

On 9/28/22 5:21 AM, Reinette Chatre wrote:
> Hi James and Shawn,
> 
> On 9/27/2022 6:06 AM, James Morse wrote:
>> On 27/09/2022 03:54, Shawn Wang wrote:
>>> Array staged_config in struct rdt_domain still maintains the original value when
>>> resctrl is unmounted. If resctrl is mounted with cdp option and then remounted
>>> without cdp option, field have_new_ctrl in staged_config[CDP_CODE] and
>>> staged_config[CDP_DATA] will still be true.
>>
>> staged_config[CDP_DATA] is an array - its always 'true'. I think you mean
>> staged_config[CDP_DATA].have_new_ctrl, which will still be true because it is only
>> memset() when the schemata file is written to.
>>
>>
>>> Since resctrl_arch_update_domains()
>>> traverses all resctrl_conf_type, it will continue to update CDP_CODE and
>>> CDP_DATA configurations, which can cause overflow problem.
>>
>> Only if its called with a stale staged config, and it should only be called when the
>> schemata file is written to, which would memset() the staged config first.
>>
>>
>>> The problem can be reproduced by the following commands:
>>>      # A system with 16 usable closids and mba disabled
>>>      mount -t resctrl resctrl -o cdp /sys/fs/resctrl
>>>      mkdir /sys/fs/resctrl/p{1..7}
>>>      umount /sys/fs/resctrl/
>>>      mount -t resctrl resctrl /sys/fs/resctrl
>>>      mkdir /sys/fs/resctrl/p{1..8}
>>
>> Thanks for the reproducer - but I don't see what could set have_new_ctrl in this sequence.
>> You can't call apply_config() to set CPUs in the mask without that being set.
>>
>> Creating a new control group, (your mkdir step) shouldn't touch the hardware at all, as it
>> should be left in its reset state from the last umount(), or setup.
> 
> There is an attempt to configure the hardware in the mkdir path:
> rdtgroup_mkdir()->rdtgroup_mkdir_ctrl_mon()->rdtgroup_init_alloc()->resctrl_arch_update_domains()
> 
> This is required in support of the different resource group modes. When a new
> resource group is created via mkdir the configuration should respect any
> exclusive resource groups that exist at that point.
> 
>>
>> I can't reproduce this on v6.0-rc7.
>> Even if I dirty the configuration by writing to the schemata file, I can't reproduce this.
>>
> 
>  From what I can tell the reproducer is dependent on (a) whether hardware
> supports CDP, and (b) the number of CLOSIDs supported by the system. The reproducer
> works for hardware that has 16 CLOSIDs (see later).
> 
>> (I have mba enabled, but all this should affect is the number of closid available)
>>

I reproduce this on v6.0-rc6. The key to reproduction is to ensure that 
the number of usable groups is different between CDP enabled and CDP 
disabled.

The system I use has 16 CLOSIDs for L3 CAT and 8 CLOSIDs for MBA. MBA 
limits the max number of groups to 8, even if CDP is disabled. This is 
the reason why I disable MBA.

>>
>>> dmesg will generate the following error:
>>
>> Which kernel version is this?
>>
>>>      [ 6180.939345] unchecked MSR access error: WRMSR to 0xca0 (tried to write
>>>      0x00000000000007ff) at rIP: 0xffffffff82249142 (cat_wrmsr+0x32/0x60)
>>
>> Is 0x7ff the default CBM bitmap for this CPU? Or was it written in a step missing from the
>> reproducer above?
> 
> The value of interest here is the register it tries to write to ... 0xca0.
> On a system with 16 CLOSIDs the range of registers available to set the CBM
> would be 0xc90 to 0xc9f that corresponds to CLOSID 0 to CLOSID 15. The error is
> an attempt to write to an unsupported register - there appears to have been an
> attempt to configure non-existent CLOSID 16.
> 
> As Shawn already root-caused, this is because the staged_config contains data from
> the previous run when CDP was enabled and it is never cleared before the resource group
> creation flow (triggered by mkdir).
> 
> 
> CDP enabled:
> mkdir <resource group>
> 	domainX.staged_config[CDP_NONE].have_new_ctrl = false
> 	domainX.staged_config[CDP_NONE].new_ctrl = 0
> 	domainX.staged_config[CDP_CODE].have_new_ctrl = true
> 	domainX.staged_config[CDP_CODE].new_ctrl = 0x7ff
> 	domainX.staged_config[CDP_DATA].have_new_ctrl = true
> 	domainX.staged_config[CDP_CODE].new_ctrl = 0x7ff
> 
> unmount/remount resctrl (CDP disabled):
> mkdir <resource group>
> 	domainX.staged_config[CDP_NONE].have_new_ctrl = true
> 	domainX.staged_config[CDP_NONE].new_ctrl = 0x7ff
> 	domainX.staged_config[CDP_CODE].have_new_ctrl = true /* stale */
> 	domainX.staged_config[CDP_CODE].new_ctrl = 0x7ff     /* stale */
> 	domainX.staged_config[CDP_DATA].have_new_ctrl = true /* stale */
> 	domainX.staged_config[CDP_CODE].new_ctrl = 0x7ff     /* stale */
> 
> Above becomes an issue when the resource group being created is
> for a CLOSID # that is more than half of the CLOSIDs supported.
> In the reproducer the issue was encountered when creating resource
> group for CLOSID 8 on a system that supports 16 CLOSIDs.
> 
> In this case get_config_index() called from
> resctrl_arch_update_domains() will return 16 and 17 when processing
> this resource group and that translated to an invalid register - 0xca0 in this
> scenario.
> 

Thanks for the detailed explanation. That's exactly what I mean.

> 
>> The rest of this splat isn't helpful as its the result of an IPI...
>>
>>>      [ 6180.951983] Call Trace:
>>>      [ 6180.954516]  <IRQ>
>>>      [ 6180.956619]  __flush_smp_call_function_queue+0x11d/0x170
>>>      [ 6180.962028]  __sysvec_call_function+0x24/0xd0
>>>      [ 6180.966485]  sysvec_call_function+0x89/0xc0
>>>      [ 6180.970760]  </IRQ>
>>>      [ 6180.972947]  <TASK>
>>>      [ 6180.975131]  asm_sysvec_call_function+0x16/0x20
>>>      [ 6180.979757] RIP: 0010:cpuidle_enter_state+0xcd/0x400
>>>      [ 6180.984821] Code: 49 89 c5 0f 1f 44 00 00 31 ff e8 1e e5 77 ff 45 84
>>>      ff 74 12 9c 58 f6 c4 02 0f 85 13 03 00 00 31 ff e8 67 70 7d ff fb 45 85
>>>      f6 <0f> 88 75 01 00 00 49 63 c6 4c 2b 2c 24 48 8d 14 40 48 8d 14 90 49
>>>      [ 6181.003710] RSP: 0018:ffffffff83a03e48 EFLAGS: 00000202
>>>      [ 6181.009028] RAX: ffff943400800000 RBX: 0000000000000001 RCX: 000000000000001f
>>>      [ 6181.016261] RDX: 0000000000000000 RSI: ffffffff83795059 RDI: ffffffff837c101e
>>>      [ 6181.023490] RBP: ffff9434c9352000 R08: 0000059f1cb1a05e R09: 0000000000000008
>>>      [ 6181.030717] R10: 0000000000000001 R11: 0000000000005c66 R12: ffffffff83bbf3a0
>>>      [ 6181.037944] R13: 0000059f1cb1a05e R14: 0000000000000001 R15: 0000000000000000
>>>      [ 6181.045202]  ? cpuidle_enter_state+0xb2/0x400
>>>      [ 6181.049678]  cpuidle_enter+0x24/0x40
>>>      [ 6181.053370]  do_idle+0x1dd/0x260
>>>      [ 6181.056713]  cpu_startup_entry+0x14/0x20
>>>      [ 6181.060753]  rest_init+0xbb/0xc0
>>>      [ 6181.064097]  arch_call_rest_init+0x5/0xa
>>>      [ 6181.068137]  start_kernel+0x668/0x691
>>>      [ 6181.071914]  secondary_startup_64_no_verify+0xe0/0xeb
>>>      [ 6181.077086]  </TASK>
>>
>> It would be good to know what triggered this IPI. It may not have been
>> resctrl_arch_update_domains(). This pattern also happens from reset_all_ctrls() which
> 
> I believe this is indeed from resctrl_arch_update_domains() since it calls
> smp_call_function_many() to configure all the domains.
> 
>> happens during umount(). (and that would write the default CBM bitmap)
>>
>> If you can reproduce this easily, could you add dump_stack() to update_config() to see if
>> any path is setting have_new_ctrl. You aren't writing to the schemata file in your reproducer.
>>
>>
>>> We fix this issue by clearing the staged configs when destroying schemata list.
>>
>>
>>> Signed-off-by: Shawn Wang <shawnwang@linux.alibaba.com>
>>> Suggested-by: Xin Hao <xhao@linux.alibaba.com>
>>
>> If we can work out why you are seeing this, it would need a Fixes tag.
>>
>> Otherwise I agree it makes sense to make this more robust, but it would need a different
>> commit message.
> 
> What do you think about clearing the staged config within resctrl_arch_update_domains()
> after the configuration is complete and there is no more need for it? That may reduce
> complexity where each caller no longer need to remember to do so.
> I see "staged_config" as a temporary storage and it my help to understand the code better
> if it is treated as such.
> 

I think this is better. I have tested it and will give a new version.

>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index f276aff521e8..b4a817ae83ab 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -2127,8 +2127,15 @@ static int schemata_list_create(void)
>>>   static void schemata_list_destroy(void)
>>>   {
>>>   	struct resctrl_schema *s, *tmp;
>>> +	struct rdt_domain *dom;
>>>   
>>>   	list_for_each_entry_safe(s, tmp, &resctrl_schema_all, list) {
>>> +		/*
>>> +		 * Clear staged_config on each domain before schemata list is
>>> +		 * destroyed.
>>> +		 */
>>> +		list_for_each_entry(dom, &s->res->domains, list)
>>> +			memset(dom->staged_config, 0, sizeof(dom->staged_config));
>>>   		list_del(&s->list);
>>>   		kfree(s);
>>>   	}
>>
> 
> Reinette

Thanks,

Shawn
