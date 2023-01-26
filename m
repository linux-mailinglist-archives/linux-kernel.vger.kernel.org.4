Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9955167CAFB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 13:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbjAZMhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 07:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbjAZMhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:37:23 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CB562255
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674736642; x=1706272642;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gNkZHnd+mp9cULtlgxTaYrVrrdRpmAHB5afLfEYVqcY=;
  b=fqdhSfYsX8prjmwGLVnXaRAD0xAdWN0UOVRflgj0suiRJcShL696njP/
   NLRS8+60rTBIeaAzMbY66thSMPeDrKwdyme9JdxPRrb/oD9uQfx1bLvRx
   jMCdML+dIQ+AaWplW82i3jTTUTtir01eWWV/BnKHveqn+cEzP6UT/i13X
   SwGhig9HKJQ6SF3ciPDqpT89XsA/lz7eMU9rcLQXVtnmeB6QlCbfJBY1d
   v8T2SYoSH8zN4M4LiQF4P20oRe3OIsf7ShwlQ3aS++hVnHLZ6fNSZoKSU
   EFxZnHCzgWfiK8QyVeYqLCjS1OwyjrFAHnFNRwFiFoDYhgBg83kpuJgDc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="354098643"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="354098643"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 04:37:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="991618106"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="991618106"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.191.66]) ([10.252.191.66])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 04:37:20 -0800
Message-ID: <31e5007b-8151-4ec6-9b63-a64a5888d2a9@linux.intel.com>
Date:   Thu, 26 Jan 2023 20:37:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, hch@lst.de, jgg@nvidia.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6/8] iommu: Retire bus ops
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1673978700.git.robin.murphy@arm.com>
 <a2db51f8f417bbe0032e2c4231579f8c4ce9a089.1673978700.git.robin.murphy@arm.com>
 <d798bc7b-a87a-26b2-17e0-48e9c7715abc@linux.intel.com>
 <4a065a3f-d189-711a-e351-73852ed00369@arm.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <4a065a3f-d189-711a-e351-73852ed00369@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/20 20:31, Robin Murphy wrote:
> On 2023-01-20 00:27, Baolu Lu wrote:
>> On 2023/1/20 3:18, Robin Murphy wrote:
>>> +    /*
>>> +     * For FDT-based systems and ACPI IORT/VIOT, drivers register IOMMU
>>> +     * instances with non-NULL fwnodes, and client devices should 
>>> have been
>>> +     * identified with a fwspec by this point. For 
>>> Intel/AMD/s390/PAMU we
>>> +     * can assume a single active driver with global ops, and so 
>>> grab those
>>> +     * from any registered instance, cheekily co-opting the same 
>>> mechanism.
>>> +     */
>>> +    fwspec = dev_iommu_fwspec_get(dev);
>>> +    if (fwspec && fwspec->ops)
>>> +        ops = fwspec->ops;
>>> +    else
>>> +        ops = iommu_ops_from_fwnode(NULL);
>>
>> I'm imagining if Intel/AMD/s390 drivers need to give up global ops.
>> Is there any way to allow them to make such conversion? I am just
>> thinking about whether this is a hard limitation for these drivers.
> 
> Yes, they could perhaps bodge into the existing fwnode mechanism, or we 
> could make bigger changes to adapt and generalise the whole 
> instance-registration-token-lookup concept, or if the driver can resolve 
> the correct instance for a device internally, then it could suffice to 
> just have all its device ops share a single common .probe_device 
> implementation that does the right thing.

Yes. Sharing a common .probe_device entry and let the IOMMU driver
connect the device and its iommu ops is a feasible solution. Thanks!

> 
> The comment is merely noting the fact that we can get away without 
> having to worry about those changes just yet, since all the drivers 
> *are* currently still built around the hard constraint of a single set 
> of device ops per bus.

Yes. Fair enough.

--
Best regards,
baolu

