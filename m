Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCA26CA54E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjC0NNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0NNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:13:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324811723
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679922795; x=1711458795;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w8rgy9mcJpK8NOnPbbrloY7Pu/LqKtIL9MDTbxKuZFs=;
  b=F3C6Nde1A2K0OZoWGgFMPdgvgrRAQuv8SpXZGWJf19gC5S6mkM7rHWki
   8OH9A7iak4EjL/4vQTc0QCqIwgSF8AokMJIAOv9q6tloSpH0t1yXcyjyP
   OgT2ymzY+MIRSUZdZqcXpnBOEFaqOrB4KdnaNEiV9IVZbiwDrIVWDJUH7
   8vtY5P+R0pQbjwzxFVer6PQpDEUujEeGp4WYJg9BkoZ7PkKggvXab5nTR
   ildaupTERx5mT+QbL3j2kxnGG/X2uFU3S0AaVN/kDUE8FVCKVhc8NESf3
   QA3o97N6qLanSTXwafBp8XXXrRKwZe+pODADw3TGJLEyXy7wVxW6wUngJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="340284320"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="340284320"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 06:13:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="827033186"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="827033186"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.213.166]) ([10.254.213.166])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 06:13:12 -0700
Message-ID: <ad57d47e-3f54-0e63-5cef-d786dab5535c@linux.intel.com>
Date:   Mon, 27 Mar 2023 21:13:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Remove unnecessary locking in
 intel_irq_remapping_alloc()
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20230314051836.23817-1-baolu.lu@linux.intel.com>
 <ZCGJn3QWhQl4F1dI@nvidia.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZCGJn3QWhQl4F1dI@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/27 20:18, Jason Gunthorpe wrote:
> On Tue, Mar 14, 2023 at 01:18:36PM +0800, Lu Baolu wrote:
>> The global rwsem dmar_global_lock was introduced by commit 3a5670e8ac932
>> ("iommu/vt-d: Introduce a rwsem to protect global data structures"). It
>> is used to protect DMAR related global data from DMAR hotplug operations.
>>
>> Using dmar_global_lock in intel_irq_remapping_alloc() is unnecessary as
>> the DMAR global data structures are not touched there. Remove it to avoid
>> below lockdep warning.
> 
> Tested-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Solves my splat too
> 
> Let's send this to -rc please

Thank you for the testing. I will queue it for Joerg this week.

Best regards,
baolu

