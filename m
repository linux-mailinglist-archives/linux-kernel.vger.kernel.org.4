Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1646165E5D6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 08:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjAEHPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 02:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjAEHPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 02:15:32 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C23C5276E;
        Wed,  4 Jan 2023 23:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672902928; x=1704438928;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FBUtjr95t8Agi5j8hAHBpZDM7ThY2F/mQgfHkWT2GB4=;
  b=D64iTKeuqGq740uUx4IcYoU8EBrxRhq3meARSTWN1sn5KNJbg2ePVHs1
   ShcDkbKsOiJb0ydERN2yUgTMT8obFr1aeLl38Tl6SDdan3DAkA9LTJjfs
   e2Puhc5k0k2kLezDRHxgjyahQdjmGMmDv+5ec0LnK83qfcJ3aMloLBvO0
   nRKBkhuAWu5yfl223VWbVvDN8FwjdK7q34dMNqlzXW5Z0w72HQhSaVkeg
   opgHzbc5OlzPVDTkX6RHyBKN+fZoyje4pU3LI/egRF87HJuJX73BDjwAS
   FqtqJlzEQblhetgM/qcq+J5KuRRLcv1QlvVs+qxjBbeH1BNlHfrIJlaGP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="301831439"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="301831439"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 23:15:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="797815544"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="797815544"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.114]) ([10.254.211.114])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 23:15:23 -0800
Message-ID: <1b01a5ba-3cfa-c968-59d1-1399c1b8cc1d@linux.intel.com>
Date:   Thu, 5 Jan 2023 15:15:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v4 2/7] iommu: Allow .iotlb_sync_map to fail and handle
 s390's -ENOMEM return
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
References: <20230104120543.308933-1-schnelle@linux.ibm.com>
 <20230104120543.308933-3-schnelle@linux.ibm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230104120543.308933-3-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/4 20:05, Niklas Schnelle wrote:
> On s390 when using a paging hypervisor, .iotlb_sync_map is used to sync
> mappings by letting the hypervisor inspect the synced IOVA range and
> updating a shadow table. This however means that .iotlb_sync_map can
> fail as the hypervisor may run out of resources while doing the sync.
> This can be due to the hypervisor being unable to pin guest pages, due
> to a limit on mapped addresses such as vfio_iommu_type1.dma_entry_limit
> or lack of other resources. Either way such a failure to sync a mapping
> should result in a DMA_MAPPING_ERROR.
> 
> Now especially when running with batched IOTLB flushes for unmap it may
> be that some IOVAs have already been invalidated but not yet synced via
> .iotlb_sync_map. Thus if the hypervisor indicates running out of
> resources, first do a global flush allowing the hypervisor to free
> resources associated with these mappings as well a retry creating the
> new mappings and only if that also fails report this error to callers.
> 
> Signed-off-by: Niklas Schnelle<schnelle@linux.ibm.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

--
Best regards,
baolu
