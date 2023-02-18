Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953D469B885
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 08:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjBRHhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 02:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjBRHhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 02:37:42 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151945036A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 23:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676705861; x=1708241861;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=inj2gVLK0zTYbq3Gm49QFqzGYuoayHVDzf1AK/76ut4=;
  b=fUJj4nvDu+qf31Q5ljU9Y7hS9Q221uMhEc25txVynWKz2/jrXL/biiEx
   0AvuKAUdXW3WYHsCytKGCRpkCH2L3pIYlBOQMSu62aMspE6vDeN8UreVa
   G7hziTWSLja958KQcJ2eZP4WmPXF6Ez2A0+9KmvgNIQBCCmvMmoNFAagH
   Vwa5EnznEQx1LYiBBtBBgs2gqiG5wAuqon3wrCHfIWJS9au2tx8pqpsWj
   qaO59d/zGrPAt+PY1YoGSvuivU8nq0D/ik+VUzurbvx5S2ANHB42wslg+
   e6ETYu6jpRlVT3p/QFkdgTzqoAgTXTROJgSZqseswKecBlNbVQVhUohrm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="394635452"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="394635452"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 23:37:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="999704344"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="999704344"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga005.fm.intel.com with ESMTP; 17 Feb 2023 23:37:38 -0800
Message-ID: <71646179-0da1-8136-f60c-9b31f9c7da6d@linux.intel.com>
Date:   Sat, 18 Feb 2023 15:29:12 +0800
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
Subject: Re: [PATCH v2 3/6] iommu: Same critical region for device release and
 removal
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20230217094736.159005-1-baolu.lu@linux.intel.com>
 <20230217094736.159005-4-baolu.lu@linux.intel.com>
 <Y++f8UmMK4AvrwBF@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y++f8UmMK4AvrwBF@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/23 11:40 PM, Jason Gunthorpe wrote:
> On Fri, Feb 17, 2023 at 05:47:33PM +0800, Lu Baolu wrote:
>> In a non-driver context, it is crucial to ensure the consistency of a
>> device's iommu ops. Otherwise, it may result in a situation where a
>> device is released but it's iommu ops are still used.
>>
>> Put the ops->release_device and __iommu_group_remove_device() in a some
>> group->mutext critical region, so that, as long as group->mutex is held
>> and the device is in its group's device list, its iommu ops are always
>> consistent.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/iommu.c | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 6247883991e2..093692308b80 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -101,6 +101,10 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
>>   static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
>>   static ssize_t iommu_group_store_type(struct iommu_group *group,
>>   				      const char *buf, size_t count);
>> +static struct group_device *
>> +__iommu_group_remove_device(struct iommu_group *group, struct device *dev);
>> +static void __iommu_group_release_device(struct iommu_group *group,
>> +					 struct group_device *grp_dev);
> Seems like a hunk is missing from this patch?

Did you mean below block of change? If so, I will add it in the next
version.

+
+	/*
+	 * If the group has become empty then ownership must have been released,
+	 * and the current domain must be set back to NULL or the default
+	 * domain.
+	 */
+	if (list_empty(&group->devices))
+		WARN_ON(group->owner_cnt ||
+			group->domain != group->default_domain);
+
+	/*
+	 * release_device() must stop using any attached domain on the device.
+	 * If there are still other devices in the group they are not effected
+	 * by this callback.
+	 *
+	 * The IOMMU driver must set the device to either an identity or
+	 * blocking translation and stop using any domain pointer, as it is
+	 * going to be freed.
+	 */
  	if (ops->release_device)
  		ops->release_device(dev);
+	mutex_unlock(&group->mutex);

By the way, can I add you signed-off-by when I use the code you posted
in the discussion thread?

Best regards,
baolu
