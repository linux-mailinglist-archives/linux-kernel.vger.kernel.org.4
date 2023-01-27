Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0516267E710
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjA0Nui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjA0Nug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:50:36 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF25511142
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674827435; x=1706363435;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1HoU09wxIsmJZMeT/Je08YK0drRTOVXFBoeOmomdWNc=;
  b=L9n4goxYbtiy7hZ8/Wa7KKScZV4SDVSTjZ6AOpmuoVHvU01UyrG4fc2L
   hW6Mtf+sWZP7a9FDXDdZ4YsPlnwNVEJGW6oZep+GYHXx+TQaNt8EMizvl
   +0UBSM6pY4sm/lukiPpJh9vSZOBo0CYnPvfCH/o6zGXfMIAaWAeOCPFiD
   zE+cBBmXEZnAQHRlG0c0axd8EsinXVi1TBWlYsF73CW+jwkODEL7pMvky
   iZTPxJQQQGvqYf4JEdukqQfRFD283eBs7rA6tLYGoryE7/ReHFyv9kjdJ
   ueUoagP3HQarHg+/6BtGeLQiZKJ32gCdv+mXAxoqBY5pCDA0+P8saJOyF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="325760611"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="325760611"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 05:50:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="656599660"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="656599660"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.191.130]) ([10.252.191.130])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 05:50:32 -0800
Message-ID: <b6b55688-1390-4e92-8184-770154a8955d@linux.intel.com>
Date:   Fri, 27 Jan 2023 21:50:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
        hch@lst.de, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] iommu: Decouple iommu_present() from bus ops
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <cover.1673978700.git.robin.murphy@arm.com>
 <1fb168b22cbbb5c24162d29d2a9aca339cda2c72.1673978700.git.robin.murphy@arm.com>
 <c96aaa6c-0f46-39dc-0c72-f38394e37cc3@linux.intel.com>
 <ce25dcdc-99a9-61ff-0cad-6c6cd9552680@arm.com> <Y9KRBRKdwSIRrvQw@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y9KRBRKdwSIRrvQw@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/26 22:41, Jason Gunthorpe wrote:
> On Thu, Jan 26, 2023 at 02:21:29PM +0000, Robin Murphy wrote:
> 
>> The "check" is inherent in the fact that it's been called at all. VFIO
>> noiommu*is*  an IOMMU driver in the sense that it provides a bare minimum of
>> IOMMU API functionality (i.e. creating groups), sufficient to support
>> (careful) usage by VFIO drivers. There would not seem to be a legitimate
>> reason for some*other*  driver to be specifically querying a device while it
>> is already bound to a VFIO driver (and thus may have a noiommu group).
> Yes, the devices that VFIO assigns to its internal groups never leak
> outside VFIO's control during their assignment - ie they are
> continuously bound to VFIO never another driver.
> 
> So no other driver can ever see the internal groups unless it is
> messing around with devices it is not bound to 😄

Fair enough. I was thinking that probably we could make it like below:

/**
  * device_iommu_mapped - Returns true when the device DMA is translated
  *                       by an IOMMU
  * @dev: Device to perform the check on
  */
static inline bool device_iommu_mapped(struct device *dev)
{
         return (dev->iommu && dev->iommu->iommu_dev);
}

The iommu probe device code guarantees that dev->iommu->iommu_dev is
valid only after the IOMMU driver's .probe_device returned successfully.

Any thoughts?

Best regards,
baolu
