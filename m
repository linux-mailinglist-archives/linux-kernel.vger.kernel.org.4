Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8FA61FA24
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiKGQln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiKGQll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:41:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 958D4616E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:41:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 824EA1FB;
        Mon,  7 Nov 2022 08:41:46 -0800 (PST)
Received: from [10.57.36.87] (unknown [10.57.36.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E3263F534;
        Mon,  7 Nov 2022 08:41:39 -0800 (PST)
Message-ID: <1f74e7e5-f57c-e269-bc78-aeb5820031ee@arm.com>
Date:   Mon, 7 Nov 2022 16:41:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] iommu: Avoid races around device probe
Content-Language: en-GB
To:     Brian Norris <briannorris@chromium.org>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <1946ef9f774851732eed78760a78ec40dbc6d178.1667591503.git.robin.murphy@arm.com>
 <Y2W+DxePm8WcUn46@google.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Y2W+DxePm8WcUn46@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-05 01:36, Brian Norris wrote:
> On Fri, Nov 04, 2022 at 07:51:43PM +0000, Robin Murphy wrote:
>> We currently have 3 different ways that __iommu_probe_device() may be
>> called, but no real guarantee that multiple callers can't tread on each
>> other, especially once asynchronous driver probe gets involved. It would
>> likely have taken a fair bit of luck to hit this previously, but commit
>> 57365a04c921 ("iommu: Move bus setup to IOMMU device registration") ups
>> the odds since now it's not just omap-iommu that may trigger multiple
>> bus_iommu_probe() calls in parallel if probing asynchronously.
>>
>> Add a lock to ensure we can't try to double-probe a device, and also
>> close some possible race windows to make sure we're truly robust against
>> trying to double-initialise a group via two different member devices.
>>
>> Reported-by: Brian Norris <briannorris@chromium.org>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/iommu.c | 28 ++++++++++++++++++++++------
>>   1 file changed, 22 insertions(+), 6 deletions(-)
> 
> If I've tested appropriately (there's always room for operator error),
> this seems to resolve the problems I reported:
> 
> Tested-by: Brian Norris <briannorris@chromium.org>
> 
> I haven't reviewed closely enough to know how precisely this is a
> regression (your description sounds like you think the bug existed some
> time before that), but based on testing, this sounds like:
> 
> Fixes: 57365a04c921 ("iommu: Move bus setup to IOMMU device
> registration")

That commit did not introduce the race, just made it more visible. The 
underlying condition probably goes back at least 3 years to where we 
started allocating and freeing per-device data around what was then the 
ops->add_device() call.

In practice, you'd have to be absurdly lucky for an iommu_probe_device() 
call via {of,acpi}_dma_configure() to line up with bus_iommu_probe() 
touching the same device, but by inspection I think it's theoretically 
possible. Thus previously there was probably only a realistic chance of 
seeing it on certain OMAP systems, where the explicit bus_iommu_probe() 
calls could overlap if both instances probed in parallel - my commit 
just brings all the other drivers in line with that same behaviour via 
iommu_device_register(). Other systems - like Rockchip in particular - 
may have greater numbers of IOMMU instances and thus even more chance 
for parallel probes to line up just right.

Since nobody's ever reported real-world issues on OMAP (although it's 
quite likely nobody's ever tried driver_async_probe with omap-iommu 
anyway) there doesn't seem to be a compelling reason for backporting, so 
I didn't fancy spending hours digging through subsystem-wide history 
trying to figure out an appropriate fixes tag; as long as this can make 
6.1 that should be enough :)

Thanks,
Robin.

> But even if not, the report could probably use:
> 
> Link: https://lore.kernel.org/lkml/Y1CHh2oM5wyHs06J@google.com/
> 
> And most of all, thanks!
> 
> Brian
