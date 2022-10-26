Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1419B60DF40
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiJZLEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiJZLDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:03:49 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E5DB6036
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:03:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=shawnwang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VT7.Cwe_1666782217;
Received: from 30.97.48.153(mailfrom:shawnwang@linux.alibaba.com fp:SMTPD_---0VT7.Cwe_1666782217)
          by smtp.aliyun-inc.com;
          Wed, 26 Oct 2022 19:03:38 +0800
Message-ID: <03bb5543-84b4-3523-741f-6c0497f46500@linux.alibaba.com>
Date:   Wed, 26 Oct 2022 19:03:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH v2] x86/resctrl: Clear the stale staged config after the
 configuration is completed
To:     Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com
References: <1665304608-120466-1-git-send-email-shawnwang@linux.alibaba.com>
 <7fa6ed4e-abae-85fb-4e95-8c73755a4263@intel.com>
 <ad08eee6-cfea-3858-0def-e2e3fef315fb@linux.alibaba.com>
 <ff44b0ff-6adb-3bae-d17e-4c341c09df5d@intel.com>
 <86fc22a2-e779-b7ab-67d6-a3aff975ae56@linux.alibaba.com>
 <30637459-7419-6497-6230-b13c73a947de@intel.com>
 <2cdfbe28-01cc-926d-2f6d-2a974a4c5a74@linux.alibaba.com>
 <bbc21b48-58b5-6356-0248-656e22d95281@intel.com>
 <140177ee-da8f-c6eb-caf6-af0775a3de0e@linux.alibaba.com>
 <de3d3e98-ef52-e290-f47c-717f531a0659@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        James Morse <james.morse@arm.com>, jamie@nuviainc.com,
        linux-kernel@vger.kernel.org
From:   Shawn Wang <shawnwang@linux.alibaba.com>
In-Reply-To: <de3d3e98-ef52-e290-f47c-717f531a0659@intel.com>
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

On 10/26/2022 3:34 AM, Reinette Chatre wrote:
> Hi Shawn,
> 
> On 10/25/2022 8:30 AM, Shawn Wang wrote:
>> Hi Reinette,
>>
>> On 10/25/2022 12:45 AM, Reinette Chatre wrote:
>>> Hi Shawn,
>>>
>>> On 10/23/2022 7:31 PM, Shawn Wang wrote:
>>>> On 10/22/2022 2:05 AM, Reinette Chatre wrote:
>>>>
>>>> ...
>>>>
>>>>>> It may not be enough to just clear staged_config[] when
>>>>>> resctrl_arch_update_domains() exits. I think the fix needs to make
>>>>>> sure staged_config[] can be cleared where it is set.
>>>>>>
>>>>>> The modification of staged_config[] comes from two paths:
>>>>>>
>>>>>> Path 1:
>>>>>> rdtgroup_schemata_write() {
>>>>>>        ...
>>>>>>        rdtgroup_parse_resource()     // set staged_config[]
>>>>>>        ...
>>>>>>        resctrl_arch_update_domains()     // clear staged_config[]
>>>>>>        ...
>>>>>> }
>>>>>>
>>>>>> Path 2:
>>>>>> rdtgroup_init_alloc() {
>>>>>>        ...
>>>>>>        rdtgroup_init_mba()/rdtgroup_init_cat()    // set staged_config[]
>>>>>>        ...
>>>>>>        resctrl_arch_update_domains()        // clear staged_config[]
>>>>>>        ...
>>>>>> }
>>>>>>
>>>>>> If we clear staged_config[] in resctrl_arch_update_domains(), goto
>>>>>> statement for error handling between setting staged_config[] and
>>>>>> calling resctrl_arch_update_domains() will be ignored. This can still
>>>>>> remain the stale staged_config[].
>>>>> ah - indeed. Thank you for catching that.
>>>>>
>>>>>>
>>>>>> I think maybe it is better to put the clearing work where
>>>>>> rdtgroup_schemata_write() and rdtgroup_init_alloc() exit.
>>>>>>
>>>>>
>>>>> It may be more robust to let rdtgroup_init_alloc() follow
>>>>> how rdtgroup_schemata_write() already ensures that it is
>>>>> working with a clean state by clearing staged_config[] before
>>>>> placing its staged config within.
>>>>>
>>>>
>>>> I want to make sure, do you mean just ignore the stale value and
>>>> place the clearing work before staged_config[] is used? If so, maybe
>>>> the only thing the fix should do is to add memset() to
>>>> rdtgroup_init_alloc().>
>>>
>>> No, let us not leave stale data lying around.
>>>
>>> The idea is that the function calling resctrl_arch_update_domains() is
>>> responsible for initializing staged_config[] correctly and completely.
>>> To confirm, yes, the idea is to clear the staged_config[] in
>>> rdtgroup_init_alloc() before resctrl_arch_update_domains() is called
>>> to follow how it is currently done in rdtgroup_schemata_write().
>>>
>>> But, as you indicate, by itself this would leave stale data lying around.
>>>
>>> The solution that you suggested earlier, to put the clearing work where
>>> rdtgroup_schemata_write() and rdtgroup_init_alloc() exit, is most logical.
>>> That makes the code symmetrical in that staged_config[] is cleared
>>> where it is initialized and no stale data is left lying around. What was
>>> not clear to me is how this would look in the end. Were you planning to
>>> keep the staged_config[] clearing within rdtgroup_schemata_write() but
>>> not do so in rdtgroup_init_alloc()? rdtgroup_schemata_write() and
>>> rdtgroup_init_alloc() has to follow the same pattern to reduce confusion.
>>>
>>> So, to be more robust, how about:
>>>
>>> /* Clear staged_config[] to make sure working from a clean slate */
>>> resctrl_arch_update_domains()
>>> /* Clear staged_config[] to not leave stale data lying around */
>>>
>>
>> Thank you for your explanation, and it makes sense to me. But this will
>> require 4 memset() loops, how about putting the clearing work in
>> a separate function in rdtgroup.c, like rdt_last_cmd_clear():
> 
> Yes, thanks for avoiding duplicating code.
> 
>>
>> void staged_configs_clear(void) {
>>      struct resctrl_schema *s;
>>      struct rdt_domain *dom;
>>
>>      lockdep_assert_held(&rdtgroup_mutex);
>>
>>      list_for_each_entry(s, &resctrl_schema_all, list) {
>>          list_for_each_entry(dom, &s->res->domains, list)
>>              memset(dom->staged_config, 0, sizeof(dom->staged_config));
>>      }
>> }
>>
> 
> I understand that you are just copying what is currently done in
> rdtgroup_schemata_write() but for a separate function I think something
> like below would be more efficient:
> 
> 
> 	for_each_alloc_capable_rdt_resource(r) {
> 		list_for_each_entry(dom, &r->domains, list)
> 			memset(dom->staged_config, 0, sizeof(dom->staged_config));
> 	}
> 
> This would be more efficient since it would not clean the same memory area
> twice when CDP is enabled.
> 

Thank you, I didn't notice this function before. I will add it in a new version.

Shawn
