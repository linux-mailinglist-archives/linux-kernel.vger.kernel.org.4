Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A4F717456
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 05:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjEaDZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 23:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbjEaDZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 23:25:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08149E5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 20:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685503530; x=1717039530;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QQrEqT8+bf3tGQW2J4Pg2sSRavsqwg+fUSfflAreoXI=;
  b=gPemL4LeI5TtF9vS908/vnwCKY2Y1RqMFaH3vIAG0rAaBQTWVGU3VR+K
   qNXiO9FRlIzr/BvI+mqMlqATJU2dtjLlSZkVs1S0OtfjuTXyNsrQ+2153
   nIqwTxU+qeoGp1gSmP2u0hJBYDMhh8eF7cLmjdJScjYJahO29SuC+3N7W
   KCbXc5BEykQ7YvJvIszB2EhLJrRNx+7HPj3dEUEOPC+2YMrz/RmIm1nFA
   BS4P3pLkqYBG6j0RWZ8dzExQ/b7rXZ5CO68SjCGkDjD5kqS7C0vPgQ96j
   9nVNcv6/S3WNVg0mvZ01PqeDQONokopsfCGF6C9G6lwM7Qg7rDIvzJ0ft
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="353967292"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="353967292"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 20:25:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="1036852593"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="1036852593"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 30 May 2023 20:25:27 -0700
Message-ID: <3d7ce5c1-c248-a14a-2dc4-79449da9aa43@linux.intel.com>
Date:   Wed, 31 May 2023 11:24:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/vt-d: Remove the dead code in init_iommu_hw()
Content-Language: en-US
To:     Yanfei Xu <yanfei.xu@intel.com>, dwmw2@infradead.org,
        joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
References: <20230530092503.152926-1-yanfei.xu@intel.com>
 <20230530092503.152926-2-yanfei.xu@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230530092503.152926-2-yanfei.xu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 5:25 PM, Yanfei Xu wrote:
> After 'commit 2a41ccee2fdc ("iommu/vt-d: Change
> iommu_enable/disable_translation to return void")', init_iommu_hw() only
> returns 0. If statement for return value of this function is meaningless.
> Hence change init_iommu_hw() to return viod and remove the dead code of
> if statement in init_iommu_hw()
> 
> Signed-off-by: Yanfei Xu<yanfei.xu@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 8096273b034c..e98f1b122b49 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2963,7 +2963,7 @@ static void __init init_no_remapping_devices(void)
>   }
>   
>   #ifdef CONFIG_SUSPEND
> -static int init_iommu_hw(void)
> +static void init_iommu_hw(void)
>   {
>   	struct dmar_drhd_unit *drhd;
>   	struct intel_iommu *iommu = NULL;
> @@ -2988,8 +2988,6 @@ static int init_iommu_hw(void)
>   		iommu_enable_translation(iommu);
>   		iommu_disable_protect_mem_regions(iommu);
>   	}
> -
> -	return 0;

2966 static int init_iommu_hw(void)
2967 {
2968         struct dmar_drhd_unit *drhd;
2969         struct intel_iommu *iommu = NULL;
2970
2971         for_each_active_iommu(iommu, drhd)
2972                 if (iommu->qi)
2973                         dmar_reenable_qi(iommu);

dmar_reenable_qi() still possibly returns an error number. It's better
to pass this error number to the caller of init_iommu_hw()?

2974
2975         for_each_iommu(iommu, drhd) {
2976                 if (drhd->ignored) {

Best regards,
baolu
