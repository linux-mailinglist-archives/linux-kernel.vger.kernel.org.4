Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FEC67F5ED
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 09:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjA1INJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 03:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjA1ING (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 03:13:06 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0592886A
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 00:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674893585; x=1706429585;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uax4L7qvxMAgmGQzQYdiiNaZPSv/p+L14aW9R/QRqz4=;
  b=OnHyMAjhIzYjuU0q8ekdlSWjWfoo+bqRV3MPIXXbVvXBglIGIPpOpMT2
   yIIdkNhmPY68o0cJXB9P2jXT5Nwy8hLIJh6bKWZKnJ87iuGRBLx51rDw0
   DunU1xQWH0exIEbnNVn1943TVPzjfVJgaNVkJgtoV+D8hQLqK9Jy0zqYM
   GpVqANdsWyvscf8nEif7Nn50UEzzaaOV/vC6EW3SxcxbjaiEYNnf/ofZ8
   NteHmeY6bEZhXQsGUlCpPzYz80nc9NVRq6fcEsGgULYnR97XGn8LRzxFs
   nsmq0gX0fSkU6w5xvgit8hy71JmtbXL9sGFLK8qeC2VhdpT8TlmSc4ZiS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="413495521"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="413495521"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 00:13:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="992338744"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="992338744"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.186.212]) ([10.252.186.212])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 00:12:55 -0800
Message-ID: <e5e68be8-7f64-c19c-ab0d-13e6f2fcbf33@linux.intel.com>
Date:   Sat, 28 Jan 2023 16:12:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, hch@lst.de, jgg@nvidia.com
Subject: Re: [PATCH v2 4/8] iommu: Factor out some helpers
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1674753627.git.robin.murphy@arm.com>
 <959a1e8d598c0a82f94123e017cafb273784f848.1674753627.git.robin.murphy@arm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <959a1e8d598c0a82f94123e017cafb273784f848.1674753627.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/27 2:26, Robin Murphy wrote:
> The pattern for picking the first device out of the group list is
> repeated a few times now, so it's clearly worth factoring out to hide
> the group_device detail from places that don't need to know. Similarly,
> the safety check for dev_iommu_ops() at public interfaces starts looking
> a bit repetitive, and might not be completely obvious at first glance,
> so let's factor that out for clarity as well, in preparation for more
> uses of both.
> 
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
