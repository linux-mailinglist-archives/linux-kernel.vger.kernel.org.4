Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7A2603748
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 02:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiJSAzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 20:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiJSAzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 20:55:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233D7CA893
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 17:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666140949; x=1697676949;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VeJU0AZOxxlPIjiKFRtl8GqedRXYSUZSRdBVzt7wm9Q=;
  b=Go68Vip5TgbpMWS1OCZastD5N+0PTjtT/ylB0qZQt/BEAPxeyqEYzjZl
   o1c9cK/PXYbvSw3KdJJ20254kc+ZRE2tWObK0gQmBBrgNdwdqeRP53ddr
   pTEVu8Rxz/lhQxlMGq8/xcNoV6QENvWJOWnNWbrgi6QJ/aXxBTWk6Ll8l
   ReGxq1+KTuyeOQYBG0St+U+oi+zv8Tg9vUOtS7C7vdBR9MzepSsXPpVYK
   K7JGzmPZjelNfZr8upk4cq69IPDORfwfrY+M/+cVswiTlzKvtHpYaRQ2V
   ZfeVZwISIKMZtVnP9uBg5x3Pys/OaqI22byVq4PILhgZhOrkxRJNr4hiI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="293668693"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="293668693"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 17:55:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="660077816"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="660077816"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 18 Oct 2022 17:55:46 -0700
Message-ID: <e0901d59-ab0a-fb05-221a-8376e741e22b@linux.intel.com>
Date:   Wed, 19 Oct 2022 08:49:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu/vt-d: Fix lockdep splat in intel_iommu_init()
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20220927053109.4053662-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220927053109.4053662-1-baolu.lu@linux.intel.com>
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

On 9/27/22 1:31 PM, Lu Baolu wrote:
> Hi folks,
> 
> As commit c919739ce472 ("iommu/vt-d: Handle race between registration
> and device probe") highlights, a lockdep splat issue happens after
> moving iommu probing device process into iommu_device_register().
> 
> This is due to a conflict that get_resv_regions wants hold the
> dmar_global_lock, but it's also possible to be called from within a
> section where intel_iommu_init() already holds the lock.
> 
> Historically, before commit 5f64ce5411b46 ("iommu/vt-d: Duplicate
> iommu_resv_region objects per device list"), the rcu_lock is used in
> get_resv_regions. This commit converted it to dmar_global_lock in order
> to allowing sleeping in iommu_alloc_resv_region().
> 
> This aims to fix the lockdep issue by making iommu_alloc_resv_region()
> available in critical section and rolling dmar_global_lock back to rcu
> lock in get_resv_regions of the Intel IOMMU driver.
> 
> Best regards,
> baolu
> 
> Lu Baolu (2):
>    iommu: Add gfp parameter to iommu_alloc_resv_region
>    iommu/vt-d: Use rcu_lock in get_resv_regions

Patches has been queued for v6.1.

https://lore.kernel.org/linux-iommu/20221019004447.4563-1-baolu.lu@linux.intel.com/

Best regards,
baolu
