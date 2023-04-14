Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91B86E299E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjDNRqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDNRqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:46:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD49EC4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:46:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80FB44B3;
        Fri, 14 Apr 2023 10:46:48 -0700 (PDT)
Received: from [10.1.31.28] (010265703453.arm.com [10.1.31.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C585F3F587;
        Fri, 14 Apr 2023 10:46:02 -0700 (PDT)
Message-ID: <cef7bb32-a302-2220-68a6-726b45f91769@arm.com>
Date:   Fri, 14 Apr 2023 18:45:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4] iommu: Optimise PCI SAC address trick
Content-Language: en-GB
To:     Joerg Roedel <joro@8bytes.org>
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        John Garry <john.g.garry@oracle.com>
References: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
 <ZDk83vpIarQ9jWa7@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZDk83vpIarQ9jWa7@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-14 12:45, Joerg Roedel wrote:
> Hi Robin,
> 
> On Thu, Apr 13, 2023 at 02:40:25PM +0100, Robin Murphy wrote:
>> Per the reasoning in commit 4bf7fda4dce2 ("iommu/dma: Add config for
>> PCI SAC address trick") and its subsequent revert, this mechanism no
>> longer serves its original purpose, but now only works around broken
>> hardware/drivers in a way that is unfortunately too impactful to remove.
>>
>> This does not, however, prevent us from solving the performance impact
>> which that workaround has on large-scale systems that don't need it.
>> Once the 32-bit IOVA space fills up and a workload starts allocating and
>> freeing on both sides of the boundary, the opportunistic SAC allocation
>> can then end up spending significant time hunting down scattered
>> fragments of free 32-bit space, or just reestablishing max32_alloc_size.
>> This can easily be exacerbated by a change in allocation pattern, such
>> as by changing the network MTU, which can increase pressure on the
>> 32-bit space by leaving a large quantity of cached IOVAs which are now
>> the wrong size to be recycled, but also won't be freed since the
>> non-opportunistic allocations can still be satisfied from the whole
>> 64-bit space without triggering the reclaim path.
>>
>> However, in the context of a workaround where smaller DMA addresses
>> aren't simply a preference but a necessity, if we get to that point at
>> all then in fact it's already the endgame. The nature of the allocator
>> is currently such that the first IOVA we give to a device after the
>> 32-bit space runs out will be the highest possible address for that
>> device, ever. If that works, then great, we know we can optimise for
>> speed by always allocating from the full range. And if it doesn't, then
>> the worst has already happened and any brokenness is now showing, so
>> there's little point in continuing to try to hide it.
>>
>> To that end, implement a flag to refine the SAC business into a
>> per-device policy that can automatically get itself out of the way if
>> and when it stops being useful.
> 
> Thanks for working on this, I think this is good to go. But given the
> issues we had with last attempt I'd like to have this in linux-next for
> a few weeks before sending it upstream. Therefore I will defer this
> patch and merge it early in the next cycle.

Sounds good - I'm considerably more confident in this approach, but 
although it should not be able to break any scenario which wasn't 
already broken, it could potentially still make such a breakage more 
noticeable. Thus in all honesty I'd feel happiest giving it a full cycle 
of -next coverage as well.

Cheers,
Robin.
