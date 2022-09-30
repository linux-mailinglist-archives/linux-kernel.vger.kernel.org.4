Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974B75F02C4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 04:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiI3C3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 22:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiI3C3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 22:29:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03B711E957
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 19:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664504958; x=1696040958;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hdve1KlyAO6JRxScYXKJu8tB9KqUJZPyIUhA+f3vBxk=;
  b=TtqPykzyVjOL5iPxVCY2Pj32oa1rjJR71QjCXDRL+nWC9cZFmMPayXrD
   RW/8qjzXxVaCGavTXHBW1oSC14osYkZOSB2G6TYEYra0J4kbrfT/w5Dza
   iWCi24kHK4r4W7EIeE4P6YFGVcivE6UBZiDrYDPKFXQRhZWNBpXCNb+Wq
   FewZ7LxKdcJpGM4wt46lUPA7IIVTUUUmoDdAB19CXQyfhkEdFH0WngKT1
   neFfegVqYlbK1L1htj9keS880SJFTXwbMllYzvs6gtW2hBO3I1BAAN92w
   YJ844SWf2DTTnPZsVvhElz9RRbfdv2PHRk8Q5CN/SROUW+doL3RS82i3l
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="302997425"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="302997425"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 19:29:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="685106383"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="685106383"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 29 Sep 2022 19:29:16 -0700
Message-ID: <c1122131-6e93-2588-38a0-c404bc34f2c1@linux.intel.com>
Date:   Fri, 30 Sep 2022 10:23:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu/vt-d: Fix lockdep splat in intel_iommu_init()
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20220927053109.4053662-1-baolu.lu@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220927053109.4053662-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

A gentle ping. Any comments to this fix? It's better to work out a
feasible solution before the users keep complaining. :-)

Best regards,
baolu
