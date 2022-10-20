Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04FA60570C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 07:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJTF4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 01:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiJTF4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 01:56:10 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E01184996
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 22:56:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=shawnwang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VSdljlu_1666245355;
Received: from 30.97.48.129(mailfrom:shawnwang@linux.alibaba.com fp:SMTPD_---0VSdljlu_1666245355)
          by smtp.aliyun-inc.com;
          Thu, 20 Oct 2022 13:56:00 +0800
Message-ID: <ad08eee6-cfea-3858-0def-e2e3fef315fb@linux.alibaba.com>
Date:   Thu, 20 Oct 2022 13:55:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH v2] x86/resctrl: Clear the stale staged config after the
 configuration is completed
To:     Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com
References: <1665304608-120466-1-git-send-email-shawnwang@linux.alibaba.com>
 <7fa6ed4e-abae-85fb-4e95-8c73755a4263@intel.com>
From:   Shawn Wang <shawnwang@linux.alibaba.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        James Morse <james.morse@arm.com>, jamie@nuviainc.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <7fa6ed4e-abae-85fb-4e95-8c73755a4263@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Sorry for replying now due to other things.

On 10/12/2022 7:48 AM, Reinette Chatre wrote:
> Hi Shawn,
> 
> Thank you very much for working on getting this fixed.
> 
> On 10/9/2022 1:36 AM, Shawn Wang wrote:
>> As a temporary storage, array staged_config in struct rdt_domain is not
> 
> staged_config -> staged_config[]
> 
>> cleared after it has been used. The stale value in staged_config could
> staged_config -> staged_config[]
> (please make the above change in rest of changelog, doing so makes it
> easier to read)
> 
>> cause a MSR access error.
> 
> a MSR -> an MSR
> 
>>
>> If resctrl is mounted with CDP enabled and then remounted with CDP
>> disabled, the value of staged_config in domainX via mkdir changes as
>> follows:
>>
>> CDP enabled:
>> mkdir <resource control group>
>>      domainX.staged_config[CDP_NONE].have_new_ctrl = false
>>      domainX.staged_config[CDP_NONE].new_ctrl = 0
>>      domainX.staged_config[CDP_CODE].have_new_ctrl = true
>>      domainX.staged_config[CDP_CODE].new_ctrl = <default mask>
>>      domainX.staged_config[CDP_DATA].have_new_ctrl = true
>>      domainX.staged_config[CDP_CODE].new_ctrl = <default mask>
> 
> Apologies, you copied a copy&paste error from me ... the last one
> should be CDP_DATA.
> 
>>
>> unmount/remount resctrl (CDP disabled):
>> mkdir <resource control group>
>>      domainX.staged_config[CDP_NONE].have_new_ctrl = true
>>      domainX.staged_config[CDP_NONE].new_ctrl = <default mask>
>>      domainX.staged_config[CDP_CODE].have_new_ctrl = true      /* stale */
>>      domainX.staged_config[CDP_CODE].new_ctrl = <default mask> /* stale */
>>      domainX.staged_config[CDP_DATA].have_new_ctrl = true      /* stale */
>>      domainX.staged_config[CDP_CODE].new_ctrl = <default mask> /* stale */
> 
> (same typo here)
> 
>>
>> When creating a new resource control group, hardware will be configured by
>> resctrl_arch_update_domains():
>> rdtgroup_mkdir()->rdtgroup_mkdir_ctrl_mon()->rdtgroup_init_alloc()->resctrl_arch_update_domains()
>>
>> Since resctrl_arch_update_domains() iterates and updates all
>> resctrl_conf_type whose have_new_ctrl is true, it will continue to update
>> the stale CDP_CODE and CDP_DATA configurations when CDP is disabled.
>>
>> Based on the above analysis, an error can be reproduced on a system with
>> 16 usable CLOSIDs for a 15-way L3 Cache (MBA should be disabled if the
>> number of CLOSIDs for MB is less than 16.) :
>>      mount -t resctrl resctrl -o cdp /sys/fs/resctrl
>>      mkdir /sys/fs/resctrl/p{1..7}
>>      umount /sys/fs/resctrl/
>>      mount -t resctrl resctrl /sys/fs/resctrl
>>      mkdir /sys/fs/resctrl/p{1..8}
>>
>> dmesg will generate the following error:
> 
> I think it would be helpful to connect this reproducer to the
> explanation of what happens. Maybe just something like:
> 
> "Upon creating directory "p8", to which CLOSID 8 is automatically
>   assigned, the following error is generated:"
> 
> Please consider what is the most useful information found in the backtrace
> and only include that. Interesting enough, there is a very related example
> of what information is useful in Documentation/process/submitting-patches.rst
> (section "Backtraces in commit messages").
> 
>>      [ 6180.939345] unchecked MSR access error: WRMSR to 0xca0 (tried to write
>>      0x00000000000007ff) at rIP: 0xffffffff82249142 (cat_wrmsr+0x32/0x60)
>>      [ 6180.951983] Call Trace:
>>      [ 6180.954516]  <IRQ>
>>      [ 6180.956619]  __flush_smp_call_function_queue+0x11d/0x170
>>      [ 6180.962028]  __sysvec_call_function+0x24/0xd0
>>      [ 6180.966485]  sysvec_call_function+0x89/0xc0
>>      [ 6180.970760]  </IRQ>
>>      [ 6180.972947]  <TASK>
>>      [ 6180.975131]  asm_sysvec_call_function+0x16/0x20
>>      [ 6180.979757] RIP: 0010:cpuidle_enter_state+0xcd/0x400
>>      [ 6180.984821] Code: 49 89 c5 0f 1f 44 00 00 31 ff e8 1e e5 77 ff 45 84
>>      ff 74 12 9c 58 f6 c4 02 0f 85 13 03 00 00 31 ff e8 67 70 7d ff fb 45 85
>>      f6 <0f> 88 75 01 00 00 49 63 c6 4c 2b 2c 24 48 8d 14 40 48 8d 14 90 49
>>      [ 6181.003710] RSP: 0018:ffffffff83a03e48 EFLAGS: 00000202
>>      [ 6181.009028] RAX: ffff943400800000 RBX: 0000000000000001 RCX: 000000000000001f
>>      [ 6181.016261] RDX: 0000000000000000 RSI: ffffffff83795059 RDI: ffffffff837c101e
>>      [ 6181.023490] RBP: ffff9434c9352000 R08: 0000059f1cb1a05e R09: 0000000000000008
>>      [ 6181.030717] R10: 0000000000000001 R11: 0000000000005c66 R12: ffffffff83bbf3a0
>>      [ 6181.037944] R13: 0000059f1cb1a05e R14: 0000000000000001 R15: 0000000000000000
>>      [ 6181.045202]  ? cpuidle_enter_state+0xb2/0x400
>>      [ 6181.049678]  cpuidle_enter+0x24/0x40
>>      [ 6181.053370]  do_idle+0x1dd/0x260
>>      [ 6181.056713]  cpu_startup_entry+0x14/0x20
>>      [ 6181.060753]  rest_init+0xbb/0xc0
>>      [ 6181.064097]  arch_call_rest_init+0x5/0xa
>>      [ 6181.068137]  start_kernel+0x668/0x691
>>      [ 6181.071914]  secondary_startup_64_no_verify+0xe0/0xeb
>>      [ 6181.077086]  </TASK>
>>
>> As Reinette Chatre explained:
>> https://lore.kernel.org/all/2728c354-ac75-be4c-66ad-86ebd9c50248@intel.com/
>> "
>>   The value of interest here is the register it tries to write to ... 0xca0.
>>   On a system with 16 CLOSIDs the range of registers available to set the
>>   CBM would be 0xc90 to 0xc9f that corresponds to CLOSID 0 to CLOSID 15.
>>   The error is an attempt to write to an unsupported register - there
>>   appears to have been an attempt to configure non-existent CLOSID 16.
>>
>>   Above becomes an issue when the resource group being created is for a
>>   CLOSID # that is more than half of the CLOSIDs supported. In the
>>   reproducer the issue was encountered when creating resource group for
>>   CLOSID 8 on a system that supports 16 CLOSIDs.
>>
>>   In this case get_config_index() called from resctrl_arch_update_domains()
>>   will return 16 and 17 when processing this resource group and that
>>   translated to an invalid register - 0xca0 in this scenario.
>> "
>>
> 
> I am not sure if adding this full quote is necessary to explain the issue.
> Maybe you could just summarize it and move it to before the "Based on the
> above analysis ..."
> 

Thank you very much for your suggestion, I will revise it in the new 
version.

>> Fix this issue by clearing the staged configs when the configuration is
>> completed.
>>
>> Fixes: 75408e43509ed ("x86/resctrl: Allow different CODE/DATA configurations to be staged")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Shawn Wang <shawnwang@linux.alibaba.com>
>> Suggested-by: Xin Hao <xhao@linux.alibaba.com>
>> ---
>> Changes since v1:
>> - Move the clearing from schemata_list_destroy() to resctrl_arch_update_domains().
>> - Update the commit message suggested by Reiniette Chatre.
>> - Add stable tag suggested by James Morse.
>> ---
>>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> index 1dafbdc5ac31..2c719da5544f 100644
>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> @@ -338,6 +338,8 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
>>   				msr_param.high = max(msr_param.high, idx + 1);
>>   			}
>>   		}
>> +		/* Clear the stale staged config */
>> +		memset(d->staged_config, 0, sizeof(d->staged_config));
>>   	}
>>   
>>   	if (cpumask_empty(cpu_mask))
> 
> Please also ensure that the temporary storage is cleared if there is an
> early exist because of failure. Please do not duplicate the memset() code
> but instead move it to a common exit location.
> 

There are two different resctrl_arch_update_domains() function call paths:

1.rdtgroup_mkdir()->rdtgroup_mkdir_ctrl_mon()->rdtgroup_init_alloc()->resctrl_arch_update_domains()
2.rdtgroup_schemata_write()->resctrl_arch_update_domains()

Perhaps there is no common exit location if we want to clear 
staged_config[] after every call of resctrl_arch_update_domains().

How about doing the cleanup at the end of rdtgroup_schemata_write() and 
rdtgroup_mkdir_ctrl_mon() respectively?

Thank you,

Shawn
