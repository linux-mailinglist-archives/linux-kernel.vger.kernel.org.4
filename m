Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFF960983D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 04:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJXCcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 22:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJXCcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 22:32:06 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE4967153
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 19:32:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=shawnwang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VSrI8aC_1666578719;
Received: from 30.97.48.136(mailfrom:shawnwang@linux.alibaba.com fp:SMTPD_---0VSrI8aC_1666578719)
          by smtp.aliyun-inc.com;
          Mon, 24 Oct 2022 10:32:00 +0800
Message-ID: <2cdfbe28-01cc-926d-2f6d-2a974a4c5a74@linux.alibaba.com>
Date:   Mon, 24 Oct 2022 10:31:56 +0800
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
From:   Shawn Wang <shawnwang@linux.alibaba.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        James Morse <james.morse@arm.com>, jamie@nuviainc.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <30637459-7419-6497-6230-b13c73a947de@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 10/22/2022 2:05 AM, Reinette Chatre wrote:

...

>> It may not be enough to just clear staged_config[] when
>> resctrl_arch_update_domains() exits. I think the fix needs to make
>> sure staged_config[] can be cleared where it is set.
>>
>> The modification of staged_config[] comes from two paths:
>>
>> Path 1:
>> rdtgroup_schemata_write() {
>>      ...
>>      rdtgroup_parse_resource()     // set staged_config[]
>>      ...
>>      resctrl_arch_update_domains()     // clear staged_config[]
>>      ...
>> }
>>
>> Path 2:
>> rdtgroup_init_alloc() {
>>      ...
>>      rdtgroup_init_mba()/rdtgroup_init_cat()    // set staged_config[]
>>      ...
>>      resctrl_arch_update_domains()        // clear staged_config[]
>>      ...
>> }
>>
>> If we clear staged_config[] in resctrl_arch_update_domains(), goto
>> statement for error handling between setting staged_config[] and
>> calling resctrl_arch_update_domains() will be ignored. This can still
>> remain the stale staged_config[].
> ah - indeed. Thank you for catching that.
> 
>>
>> I think maybe it is better to put the clearing work where
>> rdtgroup_schemata_write() and rdtgroup_init_alloc() exit.
>>
> 
> It may be more robust to let rdtgroup_init_alloc() follow
> how rdtgroup_schemata_write() already ensures that it is
> working with a clean state by clearing staged_config[] before
> placing its staged config within.
> 

I want to make sure, do you mean just ignore the stale value and place 
the clearing work before staged_config[] is used? If so, maybe the only
thing the fix should do is to add memset() to rdtgroup_init_alloc().

Thanks,

Shawn
