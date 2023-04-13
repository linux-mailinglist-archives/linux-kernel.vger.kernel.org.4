Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E261B6E0BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjDMKpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDMKpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:45:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A0D0E4A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:45:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42948C14;
        Thu, 13 Apr 2023 03:45:49 -0700 (PDT)
Received: from [10.57.20.214] (unknown [10.57.20.214])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5E2E3F6C4;
        Thu, 13 Apr 2023 03:45:03 -0700 (PDT)
Message-ID: <08c9f2a2-b2fc-2574-e10a-b6dbd0caedb0@arm.com>
Date:   Thu, 13 Apr 2023 11:44:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3] iommu: Optimise PCI SAC address trick
To:     John Garry <john.g.garry@oracle.com>, joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>, kuba@kernel.org
References: <e9abc601b00e26fd15a583fcd55f2a8227903077.1674061620.git.robin.murphy@arm.com>
 <40141c33-243c-5da6-fbea-3122e47c7808@oracle.com>
 <02eebcda-f60e-f8ed-7057-cf293d15a173@oracle.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <02eebcda-f60e-f8ed-7057-cf293d15a173@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-13 11:16, John Garry wrote:
> On 20/01/2023 11:33, John Garry wrote:
>> On 18/01/2023 17:26, Robin Murphy wrote:
>>> Per the reasoning in commit 4bf7fda4dce2 ("iommu/dma: Add config for
>>> PCI SAC address trick") and its subsequent revert, this mechanism no
>>> longer serves its original purpose, but now only works around broken
>>> hardware/drivers in a way that is unfortunately too impactful to remove.
>>>
>>> This does not, however prevent us from solving the performance impact
>>> which the workaround imposes on large-scale systems that don't need it.
>>> That is felt once the 32-bit IOVA space fills up and we keep
>>> unsuccessfully trying to allocate from it. However, if we get to that
>>> point then in fact it's already the endgame. The nature of the allocator
>>> is such that the first IOVA we give to a device after the 32-bit space
>>> runs out will be the highest possible address for that device, ever.
>>> If that works, then great, we can be pretty sure it's safe to optimise
>>> for speed by always allocating from the full range. And if it doesn't,
>>> then the worst has already happened and any brokenness is now showing,
>>> so there's no point continuing to try to hide it.
>>>
>>> To that end, implement a flag to refine this into a per-device policy
>>> that can automatically get itself out of the way if and when it stops
>>> being useful.
>>>
>>> CC: John Garry <john.garry@huawei.com>
>>> CC: Linus Torvalds <torvalds@linux-foundation.org>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> ---
>>>
>>> v3: Expand the flag name, add a print with inline commentary for good
>>>      measure, and refactor the code flow even more (too many ifs and
>>>      indents...) such that I didn't presume to carry forward John's R-b.
>>
>> I like the new changes, so feel free to add:
>>
>> Reviewed-by: John Garry <john.g.garry@oracle.com>
> 
> Is there any chance that this can be picked up?
> 
> I also saw that it fixed an issue for Jakub (cc'ed) recently.

Oh, thanks for the reminder - IIRC this wants a minor rebase now, let me 
double-check and send a v4 that applies cleanly...

Cheers,
Robin.
