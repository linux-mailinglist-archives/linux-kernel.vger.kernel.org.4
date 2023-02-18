Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EDB69B887
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 08:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjBRHkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 02:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjBRHkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 02:40:16 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286D453EFA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 23:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676706016; x=1708242016;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0lqf4J+VI4yq86gG+IpxFE/VI8GvARVOsFnagP1Homs=;
  b=BPBreerEE5aqlvAN37x/NWL27xFY0aTTRNlPzhqAzPOIJ/kcsrX/0OMr
   DA2GLUsLgbNADb8LNkUTR06JcOhphZmfRBTpBCxOXJ2SiuIVUS9ny3TMv
   Hgg7uptu/ir5brrjR83W+PKh7bcyUdD3ocuwQ9rs/3Z8o90t263CXSOdi
   ip5yKE+aSAycXXua7ADfRvfkgc+IQN1TL9g4tOgN+7yaTMr0syH3RBXBH
   Zi6rTi1yS9X4fR5/1LvruUSHDqe6Eauhi1BuSWPNelB9MKCM9sqZbAahr
   5vDSG3IOIYX28HdK4Jv0U5n+kD/cjGxGg/j4aFAnYs3n+pnLlgM1RhWP3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="320264162"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="320264162"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 23:40:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="648318768"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="648318768"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 17 Feb 2023 23:40:13 -0800
Message-ID: <4406e741-2706-b554-a728-36286ec3e507@linux.intel.com>
Date:   Sat, 18 Feb 2023 15:31:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] iommu: Extend changing default domain to normal
 group
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20230217094736.159005-1-baolu.lu@linux.intel.com>
 <Y++hqGY3qg7EKZLY@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y++hqGY3qg7EKZLY@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/23 11:47 PM, Jason Gunthorpe wrote:
> On Fri, Feb 17, 2023 at 05:47:30PM +0800, Lu Baolu wrote:
>> The IOMMU group sysfs interface allows users to change the default
>> domain of a group. The current implementation uses device_lock() to make
>> sure that the devices in the group are not bound to any driver and won't
>> be bound during the process of changing the default domain. In order to
>> avoid a possible deadlock caused by lock order of device_lock and
>> group->mutex, it limits the functionality to singleton groups only.
>>
>> The recently implemented DMA ownership framework can be applied here to
>> replace device_lock(). In addition, use group->mutex to ensure that the
>> iommu ops of the devices is always valid during the process of changing
>> default domain.
>>
>> With above replacement and enhancement, the device_lock() could be
>> removed and the singleton-group-only limitation could be removed.
>>
>> The whole series is also available on github:
>> https://github.com/LuBaolu/intel-iommu/commits/iommu-sysfs-default-domain-extension-v2
>>
>> This series is on top of below series from Robin,
>> https://lore.kernel.org/linux-iommu/cover.1674753627.git.robin.murphy@arm.com/
>>
>> Please help to review and suggest.
> Given the overall situation, I think my suggestion to use
> arm_iommu_release_device() might be more short term practical.

Yes. Fair enough.

Best regards,
baolu
