Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136EC68B8E3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjBFJpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjBFJpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:45:17 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34F6EFA2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 01:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675676715; x=1707212715;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hPsWrNl0e4B6gbmEyflkO0IZqCRbH7g6geB8jiNZ3F8=;
  b=PVqqzTsL0wE6LRBn68NW4+QHI8zL5tlnalW9vBwRKExPzJgBqJFUOeJk
   tID7/UWPbCnVJ/ey96ZQUPZPmR7dhNVyV/gAU1ZWSC004FJ0+41z3yg+/
   6uVzp92pFgT+oW0ls/AtVp8GEfWV0Xdu/cesH5xZVUngx/XGMkY/3MkyL
   GEzFuseHvu5FZtdB/kB189Foa958QyZaDSr1KnEebc+NsUGRFbAKDsMKk
   RV7ZA+JTT5pIkU9zJ+5UmecDXUvaZsLo9yD5J5kX8oIxeIVzASd5w4gWW
   tf51mRZNuuTRga4uJyuTpddL0160vBbmn6rOkQSNlp9f6HnaMkFcaInrE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="317177733"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="317177733"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 01:45:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="666432858"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="666432858"
Received: from kgurski-mobl3.ger.corp.intel.com (HELO [10.213.203.226]) ([10.213.203.226])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 01:45:12 -0800
Message-ID: <d58fff32-edad-4a7f-7409-7e57593df3ed@linux.intel.com>
Date:   Mon, 6 Feb 2023 09:45:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drm/i915/gt: Avoid redundant pointer validity check
Content-Language: en-US
To:     Deepak R Varma <drv@mailo.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Matthew Auld <matthew.auld@intel.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
References: <Y91g081OauhQNxMe@ubun2204.myguest.virtualbox.org>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <Y91g081OauhQNxMe@ubun2204.myguest.virtualbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Adding Matt & Thomas as potential candidates to review.

Regards,

Tvrtko

On 03/02/2023 19:30, Deepak R Varma wrote:
> The macro definition of gen6_for_all_pdes() expands to a for loop such
> that it breaks when the page table is null. Hence there is no need to
> again test validity of the page table entry pointers in the pde list.
> This change is identified using itnull.cocci semantic patch.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> Please note: Proposed change is compile tested only.
> 
>   drivers/gpu/drm/i915/gt/gen6_ppgtt.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
> index 5aaacc53fa4c..787b9e6d9f59 100644
> --- a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
> +++ b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
> @@ -258,8 +258,7 @@ static void gen6_ppgtt_free_pd(struct gen6_ppgtt *ppgtt)
>   	u32 pde;
>   
>   	gen6_for_all_pdes(pt, pd, pde)
> -		if (pt)
> -			free_pt(&ppgtt->base.vm, pt);
> +		free_pt(&ppgtt->base.vm, pt);
>   }
>   
>   static void gen6_ppgtt_cleanup(struct i915_address_space *vm)
> @@ -304,7 +303,7 @@ static void pd_vma_unbind(struct i915_address_space *vm,
>   
>   	/* Free all no longer used page tables */
>   	gen6_for_all_pdes(pt, ppgtt->base.pd, pde) {
> -		if (!pt || atomic_read(&pt->used))
> +		if (atomic_read(&pt->used))
>   			continue;
>   
>   		free_pt(&ppgtt->base.vm, pt);
