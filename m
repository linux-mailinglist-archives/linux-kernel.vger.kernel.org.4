Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96087117ED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbjEYUOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjEYUOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:14:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302769B
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:14:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE4E464A61
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 20:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6894CC433D2;
        Thu, 25 May 2023 20:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685045682;
        bh=c9RYj0+T+0idw1Qy78csQBqrvbedfd4wjKYCGYBBYrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q1esTd0qvQJc7TabmbiYhEBwa0xNKAeKW7a84pfVHnWhu/iA29rxP1T9hxs59SbsX
         eUk+QNURpIP86mhVgJ4oEo0KOALxuVfwQjbVXuzv0VEILEnClglckuNPQlH4U89aQr
         KNRuq/zeefVuy3pkin9GdjC4JvGbRuPulhBLk+u25Xzfr7xveS4YsIgknyTVIHJjew
         EYr3l206f7r3O/V+3LaWNHJQfIX6j7CiMn4L3D/nrGJ3UDeWG9Qzw38YxudMhoF90W
         EMOPCgOC+stBd2u4eMe4LVwNqTNF6uH+2IuI2Lk1sZwoCsZ8aySOoW2/sOLKv0rK0z
         J+4mVPPhfua3A==
Date:   Thu, 25 May 2023 13:14:39 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Felix.Kuehling@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, ndesaulniers@google.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] drm/amdkfd: remove unused function
 get_reserved_sdma_queues_bitmap
Message-ID: <20230525201439.GA2741545@dev-arch.thelio-3990X>
References: <20230525200759.3214525-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525200759.3214525-1-trix@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 04:07:59PM -0400, Tom Rix wrote:
> clang with W=1 reports
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device_queue_manager.c:122:24: error:
>   unused function 'get_reserved_sdma_queues_bitmap' [-Werror,-Wunused-function]
> static inline uint64_t get_reserved_sdma_queues_bitmap(struct device_queue_manager *dqm)
>                        ^
> This function is not used so remove it.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Caused by commit 09a95a85cf3e ("drm/amdkfd: Update SDMA queue management
for GFX9.4.3") it seems.

You can actually go a step farther and remove the
reserved_sdma_queues_bitmap member from 'struct kfd_device_info' because
it is now only assigned, never read.

$ git grep reserved_sdma_queues_bitmap next-20230525
next:20230525:drivers/gpu/drm/amd/amdkfd/kfd_device.c:        kfd->device_info.reserved_sdma_queues_bitmap = 0xFULL;
next:20230525:drivers/gpu/drm/amd/amdkfd/kfd_device.c:        kfd->device_info.reserved_sdma_queues_bitmap = 0x3ULL;
next:20230525:drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:static inline uint64_t get_reserved_sdma_queues_bitmap(struct device_queue_manager *dqm)
next:20230525:drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:    return dqm->dev->kfd->device_info.reserved_sdma_queues_bitmap;
next:20230525:drivers/gpu/drm/amd/amdkfd/kfd_priv.h:    uint64_t reserved_sdma_queues_bitmap;

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 493b4b66f180..2fbd0a96424f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -119,11 +119,6 @@ unsigned int get_num_xgmi_sdma_queues(struct device_queue_manager *dqm)
>  		dqm->dev->kfd->device_info.num_sdma_queues_per_engine;
>  }
>  
> -static inline uint64_t get_reserved_sdma_queues_bitmap(struct device_queue_manager *dqm)
> -{
> -	return dqm->dev->kfd->device_info.reserved_sdma_queues_bitmap;
> -}
> -
>  static void init_sdma_bitmaps(struct device_queue_manager *dqm)
>  {
>  	bitmap_zero(dqm->sdma_bitmap, KFD_MAX_SDMA_QUEUES);
> -- 
> 2.27.0
> 
