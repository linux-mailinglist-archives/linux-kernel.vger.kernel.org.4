Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F063675482
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjATMb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjATMb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:31:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8B0BAA7F7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:31:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05EC31515;
        Fri, 20 Jan 2023 04:32:09 -0800 (PST)
Received: from [10.57.89.132] (unknown [10.57.89.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5DF73F8D6;
        Fri, 20 Jan 2023 04:31:25 -0800 (PST)
Message-ID: <4a065a3f-d189-711a-e351-73852ed00369@arm.com>
Date:   Fri, 20 Jan 2023 12:31:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 6/8] iommu: Retire bus ops
To:     Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org
Cc:     hch@lst.de, jgg@nvidia.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <cover.1673978700.git.robin.murphy@arm.com>
 <a2db51f8f417bbe0032e2c4231579f8c4ce9a089.1673978700.git.robin.murphy@arm.com>
 <d798bc7b-a87a-26b2-17e0-48e9c7715abc@linux.intel.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <d798bc7b-a87a-26b2-17e0-48e9c7715abc@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-20 00:27, Baolu Lu wrote:
> On 2023/1/20 3:18, Robin Murphy wrote:
>> +    /*
>> +     * For FDT-based systems and ACPI IORT/VIOT, drivers register IOMMU
>> +     * instances with non-NULL fwnodes, and client devices should 
>> have been
>> +     * identified with a fwspec by this point. For 
>> Intel/AMD/s390/PAMU we
>> +     * can assume a single active driver with global ops, and so grab 
>> those
>> +     * from any registered instance, cheekily co-opting the same 
>> mechanism.
>> +     */
>> +    fwspec = dev_iommu_fwspec_get(dev);
>> +    if (fwspec && fwspec->ops)
>> +        ops = fwspec->ops;
>> +    else
>> +        ops = iommu_ops_from_fwnode(NULL);
> 
> I'm imagining if Intel/AMD/s390 drivers need to give up global ops.
> Is there any way to allow them to make such conversion? I am just
> thinking about whether this is a hard limitation for these drivers.

Yes, they could perhaps bodge into the existing fwnode mechanism, or we 
could make bigger changes to adapt and generalise the whole 
instance-registration-token-lookup concept, or if the driver can resolve 
the correct instance for a device internally, then it could suffice to 
just have all its device ops share a single common .probe_device 
implementation that does the right thing.

The comment is merely noting the fact that we can get away without 
having to worry about those changes just yet, since all the drivers 
*are* currently still built around the hard constraint of a single set 
of device ops per bus.

Thanks,
Robin.
