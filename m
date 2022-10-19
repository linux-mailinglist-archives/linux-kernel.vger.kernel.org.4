Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4326F603755
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 03:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJSBAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 21:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJSBAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 21:00:42 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C930CC823F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 18:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666141241; x=1697677241;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aDVSrblbxjUrl9rBex0zEUaGNmL3cagKEcM5NrBCtus=;
  b=ZE/U56Q5e8C1KldrGq/kbwQVClHZTtiidkOINXaxM8zCSsYLCF6ipd8q
   BPyAq6gvlAyZIw7ODMc9pS1D2pZRHcX1ePPvqdQGabzN7BrOTstYuxCs5
   2WstApJ22ekdT+qkRtNAICodIb/2q5AsAhspR7MLfwfwuoxf0gFRk3wtY
   WXzEgNkMnFC108b44BE9LXKFgDb2D4B/zaZQhDwSvkFmWOZDtxmyWSleg
   QGJBVwDNTMVDrppIkoZkntRHL2V4Oo7ci2TZu/7NvIXgsdtU8OuI9elZe
   pPLSmsIsvfLEjTZMDnGUG45dqk1VQLgdn/yfj5iiEdlDMfLoipbqAbNYN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="307960244"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="307960244"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 18:00:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="660079123"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="660079123"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 18 Oct 2022 18:00:39 -0700
Message-ID: <a732a2c7-c5d7-53f1-1abc-f9907384ef71@linux.intel.com>
Date:   Wed, 19 Oct 2022 08:54:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] iommu/vt-d: Clean up si_domain in the init_dmars()
 error path
Content-Language: en-US
To:     Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20221010065608.281860-1-jsnitsel@redhat.com>
 <20221010144842.308890-1-jsnitsel@redhat.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20221010144842.308890-1-jsnitsel@redhat.com>
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

On 10/10/22 10:48 PM, Jerry Snitselaar wrote:
> A splat from kmem_cache_destroy() was seen with a kernel prior to
> commit ee2653bbe89d ("iommu/vt-d: Remove domain and devinfo mempool")
> when there was a failure in init_dmars(), because the iommu_domain
> cache still had objects. While the mempool code is now gone, there
> still is a leak of the si_domain memory if init_dmars() fails. So
> clean up si_domain in the init_dmars() error path.
> 
> Cc: Lu Baolu<baolu.lu@linux.intel.com>
> Cc: Joerg Roedel<joro@8bytes.org>
> Cc: Will Deacon<will@kernel.org>
> Cc: Robin Murphy<robin.murphy@arm.com>
> Fixes: 86080ccc223a ("iommu/vt-d: Allocate si_domain in init_dmars()")
> Signed-off-by: Jerry Snitselaar<jsnitsel@redhat.com>

Thanks for the patch. It has been queued for v6.1.

https://lore.kernel.org/linux-iommu/20221019004447.4563-1-baolu.lu@linux.intel.com/

Best regards,
baolu
