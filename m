Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB8967E5A6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbjA0Mnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjA0Mnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:43:31 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 165E8977C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:43:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB6642F;
        Fri, 27 Jan 2023 04:44:04 -0800 (PST)
Received: from [10.57.88.221] (unknown [10.57.88.221])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 993FF3F5A1;
        Fri, 27 Jan 2023 04:43:21 -0800 (PST)
Message-ID: <d454c9a2-5300-b600-a2ae-21d82d338470@arm.com>
Date:   Fri, 27 Jan 2023 12:43:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V2] arm64/mm: Intercept pfn changes in set_pte_at()
Content-Language: en-GB
To:     Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20230109052816.405335-1-anshuman.khandual@arm.com>
 <e924c1aa-5f04-fd7f-52d4-7cf22c476016@arm.com>
 <20230126133321.GB29148@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230126133321.GB29148@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-26 13:33, Will Deacon wrote:
> On Tue, Jan 24, 2023 at 11:11:49AM +0530, Anshuman Khandual wrote:
>> On 1/9/23 10:58, Anshuman Khandual wrote:
>>> Changing pfn on a user page table mapped entry, without first going through
>>> break-before-make (BBM) procedure is unsafe. This just updates set_pte_at()
>>> to intercept such changes, via an updated pgattr_change_is_safe(). This new
>>> check happens via __check_racy_pte_update(), which has now been renamed as
>>> __check_safe_pte_update().
>>>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>> This applies on v6.2-rc3. This patch had some test time on an internal CI
>>> system without any issues being reported.
>>
>> Gentle ping, any updates on this patch ? Still any concerns ?
> 
> I don't think we really got to the bottom of Mark's concerns with
> unreachable ptes on the stack, did we? I also have vague recollections
> of somebody (Robin?) running into issues with the vmap code not honouring
> BBM.

Doesn't ring a bell, so either it wasn't me, or it was many years ago 
and about 5 levels deep into trying to fix something else :/

> So I think we should confirm/fix the vmap issue before we enable this check
> and also try to get some testing coverage to address Mark's worries. I think
> he has a syzkaller instance set up, so that sound like a good place to
> start.

I think we're also missing a subtlety here in that this restriction 
doesn't *always* apply. For instance if someone wants to move a page by 
making the mapping read-only, copying the contents to a new page, then 
pointing the RO mapping at that new page, that should technically not 
require BBM.

Thanks,
Robin.
