Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341FF67E958
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbjA0PUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjA0PUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:20:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC89283D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:20:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C7EB2B;
        Fri, 27 Jan 2023 07:20:49 -0800 (PST)
Received: from [10.57.88.221] (unknown [10.57.88.221])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77FFF3F64C;
        Fri, 27 Jan 2023 07:20:06 -0800 (PST)
Message-ID: <6e0728ae-74a3-b76f-c5c3-6504e13c721f@arm.com>
Date:   Fri, 27 Jan 2023 15:19:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/8] iommu: Decouple iommu_present() from bus ops
Content-Language: en-GB
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     joro@8bytes.org, will@kernel.org, hch@lst.de,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1673978700.git.robin.murphy@arm.com>
 <1fb168b22cbbb5c24162d29d2a9aca339cda2c72.1673978700.git.robin.murphy@arm.com>
 <c96aaa6c-0f46-39dc-0c72-f38394e37cc3@linux.intel.com>
 <ce25dcdc-99a9-61ff-0cad-6c6cd9552680@arm.com> <Y9KRBRKdwSIRrvQw@nvidia.com>
 <b6b55688-1390-4e92-8184-770154a8955d@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <b6b55688-1390-4e92-8184-770154a8955d@linux.intel.com>
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

On 2023-01-27 13:50, Baolu Lu wrote:
> On 2023/1/26 22:41, Jason Gunthorpe wrote:
>> On Thu, Jan 26, 2023 at 02:21:29PM +0000, Robin Murphy wrote:
>>
>>> The "check" is inherent in the fact that it's been called at all. VFIO
>>> noiommu*is*  an IOMMU driver in the sense that it provides a bare 
>>> minimum of
>>> IOMMU API functionality (i.e. creating groups), sufficient to support
>>> (careful) usage by VFIO drivers. There would not seem to be a legitimate
>>> reason for some*other*  driver to be specifically querying a device 
>>> while it
>>> is already bound to a VFIO driver (and thus may have a noiommu group).
>> Yes, the devices that VFIO assigns to its internal groups never leak
>> outside VFIO's control during their assignment - ie they are
>> continuously bound to VFIO never another driver.
>>
>> So no other driver can ever see the internal groups unless it is
>> messing around with devices it is not bound to 😄
> 
> Fair enough. I was thinking that probably we could make it like below:
> 
> /**
>   * device_iommu_mapped - Returns true when the device DMA is translated
>   *                       by an IOMMU
>   * @dev: Device to perform the check on
>   */
> static inline bool device_iommu_mapped(struct device *dev)
> {
>          return (dev->iommu && dev->iommu->iommu_dev);
> }
> 
> The iommu probe device code guarantees that dev->iommu->iommu_dev is
> valid only after the IOMMU driver's .probe_device returned successfully.
> 
> Any thoughts?

Heh, I actually wrote that helper yesterday for v2, but as an internal 
check for valid ops :)

The current implementation of device_iommu_mapped() just dates back to 
when dev->iommu_group was the only per-device thing we had, so in 
principle I don't have any conceptual objection to redefining it in 
terms of "device has ops" rather than "device has a group", but as 
things stand you'd still have to do something about PPC first (I know 
Jason had been pushing on that, but I've not kept track of where it got to).

Thanks,
Robin.
