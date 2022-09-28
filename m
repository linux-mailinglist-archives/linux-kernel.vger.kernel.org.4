Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563BF5EDE74
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbiI1OJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiI1OJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:09:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71F009E0C5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:08:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E5AA1595;
        Wed, 28 Sep 2022 07:09:05 -0700 (PDT)
Received: from [10.1.197.78] (eglon.cambridge.arm.com [10.1.197.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84C543F73D;
        Wed, 28 Sep 2022 07:08:57 -0700 (PDT)
Message-ID: <7728c846-0077-a34d-7fdc-bab9743edc4f@arm.com>
Date:   Wed, 28 Sep 2022 15:08:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] x86/resctrl: Clear the staged configs when destroying
 schemata list
Content-Language: en-GB
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shawn Wang <shawnwang@linux.alibaba.com>, fenghua.yu@intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
References: <1664247269-41295-1-git-send-email-shawnwang@linux.alibaba.com>
 <80d6238b-223c-e60a-6930-24a981d9dd0c@arm.com>
 <2728c354-ac75-be4c-66ad-86ebd9c50248@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <2728c354-ac75-be4c-66ad-86ebd9c50248@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 27/09/2022 22:21, Reinette Chatre wrote:
> On 9/27/2022 6:06 AM, James Morse wrote:
>> On 27/09/2022 03:54, Shawn Wang wrote:

>>> The problem can be reproduced by the following commands:
>>>     # A system with 16 usable closids and mba disabled
>>>     mount -t resctrl resctrl -o cdp /sys/fs/resctrl
>>>     mkdir /sys/fs/resctrl/p{1..7}
>>>     umount /sys/fs/resctrl/
>>>     mount -t resctrl resctrl /sys/fs/resctrl
>>>     mkdir /sys/fs/resctrl/p{1..8}
>>
>> Thanks for the reproducer - but I don't see what could set have_new_ctrl in this sequence.
>> You can't call apply_config() to set CPUs in the mask without that being set.
>>
>> Creating a new control group, (your mkdir step) shouldn't touch the hardware at all, as it
>> should be left in its reset state from the last umount(), or setup.
> 
> There is an attempt to configure the hardware in the mkdir path:
> rdtgroup_mkdir()->rdtgroup_mkdir_ctrl_mon()->rdtgroup_init_alloc()->resctrl_arch_update_domains()

Aha! I'm not sure why my grepping around didn't find this.

This is a path that doesn't memset() the staged config first, so that explains it.

[..]

> What do you think about clearing the staged config within resctrl_arch_update_domains()
> after the configuration is complete and there is no more need for it? That may reduce
> complexity where each caller no longer need to remember to do so.
> I see "staged_config" as a temporary storage and it my help to understand the code better
> if it is treated as such. 

Yup, that would it with the idea of the value being consumed by
resctrl_arch_update_domains(), which is how I think of it.


Thanks,

James
