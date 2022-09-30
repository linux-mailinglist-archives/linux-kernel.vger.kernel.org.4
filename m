Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139B45F0636
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiI3IEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiI3IEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:04:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFCE6463
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 01:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664525087; x=1696061087;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oFjiQiA1mW1s4pr3Dw779NT4rP7m0ZzZZ2KjXZ98jn4=;
  b=YXj3x1PVrocPKEGz5l6fZFmraCaO3eD7V8EhyJleLLhkWScyDPCTaUmM
   lWTHeXhCJHL6JNlYE6NdMHcv7HRxm8zYJd5Wp7nTY8Gx6Cj6h+bP+AltK
   Zht4wtgw3I2FpdYzHx0qzmW+UsJ2vbLW3+4usVaMgsRisgN9GW/o2Amfr
   U7idiAkOQsWlCRCEhlt9IGZG3Owhyi0exDe3cDNIFQOtQnaxf4K+O9gbR
   NmIO3KNmaWb3n59wl7g4IjKEMmWijebkhEyvlWW3brgExBtVzERG2hwKv
   56m26Ds0/A5GVvgNMu/lo/dgTQjNCojqbYogj6sNonnjizb0PMuz5Dpij
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="328514744"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="328514744"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 01:04:46 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="655876135"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="655876135"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.178]) ([10.254.215.178])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 01:04:43 -0700
Message-ID: <badfd899-aab1-9f47-9053-e05c6bedd668@linux.intel.com>
Date:   Fri, 30 Sep 2022 16:04:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: remove useless parameter in iommu_bus_init().
Content-Language: en-US
To:     Yu Zhang <yu.c.zhang@linux.intel.com>, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com
References: <20220930070202.105663-1-yu.c.zhang@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220930070202.105663-1-yu.c.zhang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/30 15:02, Yu Zhang wrote:
> Parameter 'ops' is no longer used by iommu_bus_init(), after
> commit 8cec63e52966 ("iommu: Remove iommu_callback_data").
> 
> So just remove it.
> 
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> ---
>   drivers/iommu/iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3a808146b50f..bedda1e0f016 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1775,7 +1775,7 @@ int bus_iommu_probe(struct bus_type *bus)
>   	return ret;
>   }
>   
> -static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
> +static int iommu_bus_init(struct bus_type *bus)
>   {
>   	struct notifier_block *nb;
>   	int err;
> @@ -1836,7 +1836,7 @@ int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops)
>   	bus->iommu_ops = ops;
>   
>   	/* Do IOMMU specific setup for this bus-type */
> -	err = iommu_bus_init(bus, ops);
> +	err = iommu_bus_init(bus);
>   	if (err)
>   		bus->iommu_ops = NULL;
>   

bus_set_iommu() has been retired. All patches are just queued in
linux-next and will show up in v6.1-rc1.

Best regards,
baolu
