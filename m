Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE4B717462
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 05:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbjEaD3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 23:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbjEaD2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 23:28:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5342119A
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 20:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685503708; x=1717039708;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TYMzU74WAhBotOE3c77ui6pPmq/ocGmpdHVCBH4pbX4=;
  b=WAZEy6lqv2znn+7p+ZXnYekSC/VCcmAdL23eXG7aq+eN3YKZbq7Tx0H8
   cfnsRpQrHiZVHIxPDgMWDRkUO7gCd8YHMosuD4aiO77Shf8G2MZhea92y
   E2K2fGAlDGtra2Wdma0kudBlpQm/jnjzBgDDIZplZN4Nj9zo62sD7oGD2
   8c8xB16mWyLT0TLA6DQK9J0W8UvUltwqnocHWdpUrBu7ryf5OsfPZzWkp
   5aunGpyz6wktnskR/D4R4Unv/sG9YEjqCi2HoUUI8Jrkh+LWQiN+QqSeg
   xjQkJGEznR+Fn9MNb7IehtWIumPOFDYD4yHiIgXryN+zx6lfJaVjjOEmP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="339715115"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="339715115"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 20:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="831049681"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="831049681"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga004.jf.intel.com with ESMTP; 30 May 2023 20:27:49 -0700
Message-ID: <3e75f9de-4c67-93aa-9fb4-28da9849dd48@linux.intel.com>
Date:   Wed, 31 May 2023 11:26:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/vt-d: Use BUG_ON to check NULL value of 'table'
Content-Language: en-US
To:     Yanfei Xu <yanfei.xu@intel.com>, dwmw2@infradead.org,
        joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
References: <20230530092503.152926-1-yanfei.xu@intel.com>
 <20230530092503.152926-3-yanfei.xu@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230530092503.152926-3-yanfei.xu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 5:25 PM, Yanfei Xu wrote:
> Checking NULL value of 'table' variable deserves a BUG_ON as the
> following code will trigger a crash by dereferencing the NULL
> 'table' pointer. Crash in advance with BUG_ON to avoid WARN_ON
> plus NULL pointer dereferencing can simplify the crash log.
> 
> Signed-off-by: Yanfei Xu<yanfei.xu@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index e98f1b122b49..8aa3bfdb7f95 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1944,7 +1944,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
>   	if (sm_supported(iommu)) {
>   		unsigned long pds;
>   
> -		WARN_ON(!table);
> +		BUG_ON(!table);

BUG_ON() is not recommended. Perhaps,

		if (!table)
			-ENODEV;

?

Best regards,
baolu
