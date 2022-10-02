Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C255F2389
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 16:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJBORy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 10:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJBORv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 10:17:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA9D3ED4A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 07:17:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 856E760EAC
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 14:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E7DC433C1;
        Sun,  2 Oct 2022 14:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664720269;
        bh=O0dVpkklwl+/CmBu9T6X6qz9+BKjvm8jj7H5XyJIFtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hv36Au6oqRLpsEtoqNEzc96LyUd8otjN69WNWwMaVOA2KtRhKKR0U4f/B3zRswJDy
         yyBwBig/qpyA/eOrtxwCQD+p3Km+lpYHIfpIP4XEqI6eXXDVDXaJMn/cCyPGsfo5cZ
         flzQ6mTULmsdWPgbJIE9Kei2ak6XKy4CLFoF9yBo=
Date:   Sun, 2 Oct 2022 16:18:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     hackerzheng666@gmail.com, 1002992920@qq.com, airlied@linux.ie,
        alex000young@gmail.com, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        linux-kernel@vger.kernel.org, security@kernel.org,
        tvrtko.ursulin@linux.intel.com
Subject: Re: [PATCH] drm/i915/gvt: fix double free bug in split_2MB_gtt_entry
Message-ID: <Yzmds3DXu32EeSO5@kroah.com>
References: <CAJedcCzjWw6v5Nt42jsCStdpwHuz13D+q-CD=6ycVWBczY+4mg@mail.gmail.com>
 <20220928033340.1063949-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928033340.1063949-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 11:33:40AM +0800, Zheng Wang wrote:
> If intel_gvt_dma_map_guest_page failed, it will call
> ppgtt_invalidate_spt, which will finally free the spt.
> But the caller does not notice that, it will free spt again in error path.
> 
> Fix this by only freeing spt in ppgtt_invalidate_spt in good case.
> 
> Fixes: b901b252b6cf ("drm/i915/gvt: Add 2M huge gtt support")
> Reported-by: Zheng Wang <hackerzheng666@gmail.com>
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
>  drivers/gpu/drm/i915/gvt/gtt.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
> index ce0eb03709c3..550519f0acca 100644
> --- a/drivers/gpu/drm/i915/gvt/gtt.c
> +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> @@ -959,7 +959,7 @@ static inline int ppgtt_put_spt(struct intel_vgpu_ppgtt_spt *spt)
>  	return atomic_dec_return(&spt->refcount);
>  }
>  
> -static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt);
> +static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt, int is_error);

That is a horrible way to make an api (and it should be a bool too.)

Now every time you see this call in the code, you have to go look up
what the last parameter means.  Just make 2 functions, one that does the
"is error" thing, and one that does not, and that will be much easier to
maintain and understand for the next 10+ years.

thanks,

greg k-h
