Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338BF67D987
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjAZXTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjAZXTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:19:08 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21826A5F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674775147; x=1706311147;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DxlPrkYaIFKagw6UlcDQbNMx71f4Jcar7GKHOEvVQIw=;
  b=OaroDJLk4oOsWsaI7QPoboa2HmhVP4tQLx9RwFzj3fY4vw8zEvadNfaW
   yK4aSKVy96StvX5mWZgBwpJBe/UVbZqVbOIFgaKAq2rGmlh510UMhqeOw
   0HQWi0IahY5/2zKfdYT1N3QQOJ9XFVfUPBbOKK8I3k1A8vAxNAd7xeD4I
   2BJi0BkKyH/7saIEXtdQx14cor6o+4PKxyMGbveaMamKrZFSMEI4z4a1Z
   LWW9tmkF5aNKfgVBYyfYEppnfvKJWpV6Gb98C/bVnaY/8++SXH6KMh6Uz
   nvXxf5V9RXdk67dGwIk7w8QCb16cuXekv+GIdLy+4oMOT0ePEH4t5vbaU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="389357770"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="389357770"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 15:19:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="787022867"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="787022867"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 15:19:06 -0800
Date:   Thu, 26 Jan 2023 15:22:37 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, hch@lst.de, jgg@nvidia.com,
        baolu.lu@linux.intel.com, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 5/8] iommu: Switch __iommu_domain_alloc() to device
 ops
Message-ID: <20230126152237.2f8b681f@jacob-builder>
In-Reply-To: <23b51c84247cb36e96c242d3aef8ef555b6d05cd.1674753627.git.robin.murphy@arm.com>
References: <cover.1674753627.git.robin.murphy@arm.com>
        <23b51c84247cb36e96c242d3aef8ef555b6d05cd.1674753627.git.robin.murphy@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Thu, 26 Jan 2023 18:26:20 +0000, Robin Murphy <robin.murphy@arm.com>
wrote:

>  
> +static int __iommu_domain_alloc_dev(struct device *dev, void *data)
> +{
> +	struct device **alloc_dev = data;
> +
> +	if (!dev_iommu_ops_valid(dev))
> +		return 0;
> +
> +	WARN_ONCE(*alloc_dev && dev_iommu_ops(dev) !=
> dev_iommu_ops(*alloc_dev),
> +		"Multiple IOMMU drivers present, which the public IOMMU
> API can't fully support yet. You may still need to disable one or more to
> get the expected result here, sorry!\n"); +
> +	*alloc_dev = dev;
> +	return 0;
> +}
> +
>  struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
>  {
> -	return __iommu_domain_alloc(bus, IOMMU_DOMAIN_UNMANAGED);
> +	struct device *dev = NULL;
> +
> +	/* We always check the whole bus, so the return value isn't
> useful */
> +	bus_for_each_dev(bus, NULL, &dev, __iommu_domain_alloc_dev);
> +	if (!dev)
> +		return NULL;
Since __iommu_domain_alloc_dev() will always return 0, bus_for_each_dev()
will never breakout until the whole dev list is iterated over. If so, would
dev only record the last one? i.e. prior results get overwritten.  Maybe a
misunderstood the logic.

> +	return __iommu_domain_alloc(dev, IOMMU_DOMAIN_UNMANAGED);
>  }
>  EXPORT_SYMBOL_GPL(iommu_domain_alloc);

Thanks,

Jacob
