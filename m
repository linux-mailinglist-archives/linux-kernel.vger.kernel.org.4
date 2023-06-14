Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2038072FFE9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244954AbjFNNWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244955AbjFNNWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:22:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CBA1FC4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686748949; x=1718284949;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=krZlgUF812lZ1Msg1luNdv0RZ6yxrI7AK5Nw8giEATI=;
  b=C4tJIhV0VCe4TfWi1AwrH0pLBrKS7JAJc6wzGrVZnb+2N83Gn4nUS/G2
   q9YzV0myxKR31BOY4EVZ/Llh6FFN3MnIevi97NKniYJuY8fz10zhmi+5P
   rc8uAAHZyyTLM+IPb8jJrJU4dEbF30isJMCTEiVsUKHj9SCi8ZBOCpm1d
   ZN6toUbni0DDY7s4LhpDcRZ8LjByNBXL0zry8zWrUSmajyJ1mGWcLj7N9
   9wLbCeT38xwQAH10a09DqDfkkXuK2UnPsNqtkMfee0vbGyge0axeXwpl0
   gc8rAkhKMQJ0D3WLtgJU8JrfRmuqRjy7ZAen20/f+ddSPe15XSkzVox3U
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="444977887"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="444977887"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 06:22:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="801899074"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="801899074"
Received: from sobyrne-mobl1.ger.corp.intel.com (HELO [10.213.224.182]) ([10.213.224.182])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 06:22:25 -0700
Message-ID: <bebd57fc-7135-dc97-701e-54cb9c2955c0@linux.intel.com>
Date:   Wed, 14 Jun 2023 14:22:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/i915: Call page_address() on page acquired with
 GFP_KERNEL flag
Content-Language: en-US
To:     Sumitra Sharma <sumitraartsy@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, Fabio <fmdefrancesco@gmail.com>,
        Deepak R Varma <drv@mailo.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Matthew Auld <matthew.auld@intel.com>
References: <20230614123556.GA381200@sumitra.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20230614123556.GA381200@sumitra.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/06/2023 13:35, Sumitra Sharma wrote:
> Pages allocated with GFP_KERNEL cannot come from Highmem.
> That is why there is no need to call kmap() on them.

Are you sure it is GFP_KERNEL backed and not tmpfs? I am not sure myself 
so let me copy Matt and Thomas if they happen to know off hand.

Regards,

Tvrtko

> Therefore, don't call kmap() on the page coming from
> vma_res->bi.pages using for_each_sgt_page() in
> i915_vma_coredump_create().
> 
> Use a plain page_address() to get the kernel address instead.
> 
> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> ---
>   drivers/gpu/drm/i915/i915_gpu_error.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
> index f020c0086fbc..6f51cb4fc55c 100644
> --- a/drivers/gpu/drm/i915/i915_gpu_error.c
> +++ b/drivers/gpu/drm/i915/i915_gpu_error.c
> @@ -1164,9 +1164,8 @@ i915_vma_coredump_create(const struct intel_gt *gt,
>   
>   			drm_clflush_pages(&page, 1);
>   
> -			s = kmap(page);
> +			s = page_address(page);
>   			ret = compress_page(compress, s, dst, false);
> -			kunmap(page);
>   
>   			drm_clflush_pages(&page, 1);
>   
