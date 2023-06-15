Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D0B7317D1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344640AbjFOLrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344535AbjFOLrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:47:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0520359E4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:43:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08E7F1FB;
        Thu, 15 Jun 2023 04:42:47 -0700 (PDT)
Received: from [10.57.85.251] (unknown [10.57.85.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A58463F64C;
        Thu, 15 Jun 2023 04:42:01 -0700 (PDT)
Message-ID: <99c1e8ab-a064-c770-072f-23ef9e9abb82@arm.com>
Date:   Thu, 15 Jun 2023 12:41:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4] iommu: Optimise PCI SAC address trick
Content-Language: en-GB
To:     John Garry <john.g.garry@oracle.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
 <ZDk83vpIarQ9jWa7@8bytes.org> <20230613105850.30172085@kernel.org>
 <4f9184c5-e6a2-08da-f44a-3000b6cdfe35@oracle.com>
 <198a73b0-d7c0-57d6-5ef9-4e9dddb6365b@arm.com>
 <568df53c-41a7-94d7-6662-f8f7c72e5178@oracle.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <568df53c-41a7-94d7-6662-f8f7c72e5178@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-15 11:11, John Garry wrote:
> On 15/06/2023 10:04, Robin Murphy wrote:
>>> Since we're at rc6 time and a cautious approach was wanted to merge 
>>> this change, I doubt that this will be merged for this cycle. That's 
>>> quite unfortunate.
>>>
>>> Please note what I mentioned earlier about using 
>>> dma_opt_mapping_size(). This API is used by some block storage 
>>> drivers to avoid your same problem, by clamping max_sectors_kb at 
>>> this size - see sysfs-block Doc for info there. Maybe it can be used 
>>> similarly for network drivers.
>>
>> It's not the same problem - in this case the mappings are already 
>> small enough to use the rcaches, and it seems more to do with the 
>> total number of unusable cached IOVAs being enough to keep the 32-bit 
>> space almost-but-not-quite full most of the time, defeating the 
>> max32_alloc_size optimisation whenever the caches run out of the right 
>> size entries.
> 
> Sure, not the same problem.
> 
> However when we switched storage drivers to use dma_opt_mapping_size() 
> then performance is similar to iommu.forcedac=1 - that's what I found, 
> anyway.
> 
> This tells me that that even though IOVA allocator performance is poor 
> when the 32b space fills, it was those large IOVAs which don't fit in 
> the rcache which were the major contributor to hogging the CPU in the 
> allocator.

The root cause is that every time the last usable 32-bit IOVA is 
allocated, the *next* PCI caller to hit the rbtree for a SAC allocation 
is burdened with walking the whole 32-bit subtree to determine that it's 
full again and re-set max32_alloc_size. That's the overhead that 
forcedac avoids.

In the storage case with larger buffers, dma_opt_mapping_size() also 
means you spend less time in the rbtree, but because you're inherently 
hitting it less often at all, since most allocations can now hopefully 
be fulfilled by the caches. That's obviously moot when the mappings are 
already small enough to be cached and the only reason for hitting the 
rbtree is overflow/underflow in the depot because the working set is 
sufficiently large and the allocation pattern sufficiently "bursty".

Thanks,
Robin.
