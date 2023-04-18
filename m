Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C2F6E5C70
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjDRIsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjDRIr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:47:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A923C1E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681807667; x=1713343667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nIqUHM4VZSEHuLUoyJ0ioNxn0jbGNhDyuLATbHCITwo=;
  b=OU6W88+hZ8BrJI4AefeGpqlvfvyCQUTnoIQaEJm/FWjWo3bflHSyrLgu
   njZqMN+ppInh1qzoLF4UxKG3iDXYptLva8wmNiA/vs9aZGfF2JuSf5i4X
   kG46fY2+nOw/1fjL8VL2BG88/a1RZFmr2npOuDHIyUN/WqIVHcgc1wzaU
   YoaJ/68h8eGAInw57eQfBDqdzTTVKgokTxcQUmfJGif11SNmsRkZt9rA9
   KY8No7xo9gfG4B9cDzeIBcaVD0VyEJ5zCHm8Jz9adUko2SJxsnd6kScKy
   9+CRXnUxAT1SwSwkxf8RGApvKzwPMd+NqnddoDrMsbTKkgIOyK2VTuVGT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="346961091"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="346961091"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 01:47:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="668433010"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="668433010"
Received: from ashfaqur-mobl1.ger.corp.intel.com (HELO intel.com) ([10.251.213.178])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 01:47:43 -0700
Date:   Tue, 18 Apr 2023 10:47:18 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Daniil Dulov <d.dulov@aladdin.ru>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        lvc-project@linuxtesting.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Oak Zeng <ozeng@amd.com>,
        Christian =?iso-8859-15?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Fix potential deallocation of previously
 deallocated memory.
Message-ID: <ZD5ZFoEk92MNQpqD@ashyti-mobl2.lan>
References: <20230418065521.453001-1-d.dulov@aladdin.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418065521.453001-1-d.dulov@aladdin.ru>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniil,

On Mon, Apr 17, 2023 at 11:55:21PM -0700, Daniil Dulov wrote:
> Pointer mqd_mem_obj can be deallocated in kfd_gtt_sa_allocate().
> The function then returns non-zero value, which causes the second deallocation.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: d1f8f0d17d40 ("drm/amdkfd: Move non-sdma mqd allocation out of init_mqd")
> Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 3b6f5963180d..bce11c5b07d6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -119,7 +119,8 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_dev *kfd,
>  	}
>  
>  	if (retval) {
> -		kfree(mqd_mem_obj);
> +		if (mqd_mem_obj)
> +			kfree(mqd_mem_obj);

I think this is not needed. kfree() returns immediately if
mqd_mem_obj is NULL.

Andi

>  		return NULL;
>  	}
>  
> -- 
> 2.25.1
