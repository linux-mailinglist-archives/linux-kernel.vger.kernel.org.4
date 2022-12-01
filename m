Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8E763EB3D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiLAIgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLAIgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:36:31 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8456D949
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669883791; x=1701419791;
  h=message-id:date:mime-version:cc:from:to:references:
   subject:in-reply-to:content-transfer-encoding;
  bh=ASObx3YU40ta1bnwquNX450TvnchyRNCWB+x90kDyHQ=;
  b=dMPo2G1PWVee5gdsegeXHuSF6h8KKzWvKsiWqfzHYucDFjFjYwwU17OF
   8Zr/47fAz/SjkQhO1WjiULpoHbaEIYnTVAGTG90xlkCvwJR6+LKWZyVo6
   yVisTXSrLst7mm622njt2R6JC53eEICrSeKonqhSRdVLDMcHoNYaUuO2z
   KRoXv3egLbS+uJ3CcHUiSFZwEzRhwx4Mdv+wJOhfumOWsmUbgJsoq2yyU
   SxRNbrWsdHyFmpR/g0I3tCrGFuOg/jdZwkOB3ew1XvZicrdUuxQmRWX1y
   e+HLl+iaEavn0GiD6uSeEPDHaEP0RmGv0GArVT3I2mTtYqODU8vFMVSUI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="298994280"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="298994280"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 00:36:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="889645029"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="889645029"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.50]) ([10.254.214.50])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 00:36:27 -0800
Message-ID: <edbcfb02-0c20-5444-b2fa-34189faa923d@linux.intel.com>
Date:   Thu, 1 Dec 2022 16:36:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
References: <20221201040127.1962750-1-baolu.lu@linux.intel.com>
 <20221201040127.1962750-2-baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/4] iommu/vt-d: Add a fix for devices need extra dtlb
 flush
In-Reply-To: <20221201040127.1962750-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/1 12:01, Lu Baolu wrote:
> From: Jacob Pan<jacob.jun.pan@linux.intel.com>
> 
> QAT devices on Intel Sapphire Rapids and Emerald Rapids have a defect in
> address translation service (ATS). These devices may inadvertently issue
> ATS invalidation completion before posted writes initiated with
> translated address that utilized translations matching the invalidation
> address range, violating the invalidation completion ordering.
> 
> This patch adds an extra device TLB invalidation for the affected devices,
> it is needed to ensure no more posted writes with translated address
> following the invalidation completion. Therefore, the ordering is
> preserved and data-corruption is prevented.
> 
> Device TLBs are invalidated under the following six conditions:
> 1. Device driver does DMA API unmap IOVA
> 2. Device driver unbind a PASID from a process, sva_unbind_device()
> 3. PASID is torn down, after PASID cache is flushed. e.g. process
> exit_mmap() due to crash
> 4. Under SVA usage, called by mmu_notifier.invalidate_range() where
> VM has to free pages that were unmapped
> 5. userspace driver unmaps a DMA buffer
> 6. Cache invalidation in vSVA usage (upcoming)
> 
> For #1 and #2, device drivers are responsible for stopping DMA traffic
> before unmap/unbind. For #3, iommu driver gets mmu_notifier to
> invalidate TLB the same way as normal user unmap which will do an extra
> invalidation. The dTLB invalidation after PASID cache flush does not
> need an extra invalidation.
> 
> Therefore, we only need to deal with #4 and #5 in this patch. #1 is also
> covered by this patch due to common code path with #5.
> 
> Tested-by: Yuzhang Luo<yuzhang.luo@intel.com>
> Reviewed-by: Ashok Raj<ashok.raj@intel.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>

This missed cc stable tag.

Cc: stable@vger.kernel.org # v5.15+

Sorry for the inconvenience.

> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
> Link:https://lore.kernel.org/r/20221130062449.1360063-1-jacob.jun.pan@linux.intel.com
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.h |  4 +++
>   drivers/iommu/intel/iommu.c | 69 +++++++++++++++++++++++++++++++++++--
>   drivers/iommu/intel/svm.c   |  5 ++-
>   3 files changed, 75 insertions(+), 3 deletions(-)

Best regards,
baolu
