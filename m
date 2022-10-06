Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817405F6E25
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiJFTXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiJFTWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:22:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9A21144C4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 12:22:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 262C161A94
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 19:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57FCC433D7;
        Thu,  6 Oct 2022 19:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665084154;
        bh=YsMh0kWe/OOR+5QG3loglTlzXYtyV8KBcvp4A3mJk5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BVJCPliSRQiCQnT7Nl1mNjkmwplBTP4CTh/QWA/r38FtWwVGbWjuoeyTvGbaEt5Ep
         sRnDdxkefmR3TRQULCPjSOp+KRIx0SdZjsp+ZUwI/6z1SIREquHhn84iNiUWZ/igTz
         lmi1YCbk/hJYZpNCJxUCJML1iHEdri22IlDOWvrI=
Date:   Thu, 6 Oct 2022 21:23:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     1002992920@qq.com, airlied@linux.ie, alex000young@gmail.com,
        dri-devel@lists.freedesktop.org, hackerzheng666@gmail.com,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        linux-kernel@vger.kernel.org, security@kernel.org,
        tvrtko.ursulin@linux.intel.com
Subject: Re: [PATCH v2] drm/i915/gvt: fix double free bug in
 split_2MB_gtt_entry
Message-ID: <Yz8rIxV7bVCcfZb0@kroah.com>
References: <20220928033340.1063949-1-zyytlz.wz@163.com>
 <20221006165845.1735393-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006165845.1735393-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 12:58:45AM +0800, Zheng Wang wrote:
> If intel_gvt_dma_map_guest_page failed, it will call
> ppgtt_invalidate_spt, which will finally free the spt.
> But the caller does not notice that, it will free spt again in error path.
> 
> Fix this by spliting invalidate and free in ppgtt_invalidate_spt.
> Only free spt when in good case.
> 
> Reported-by: Zheng Wang <hackerzheng666@gmail.com>
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
> v2:
> - split initial function into two api function suggested by Greg
> 
> v1: https://lore.kernel.org/all/20220928033340.1063949-1-zyytlz.wz@163.com/
> ---
>  drivers/gpu/drm/i915/gvt/gtt.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
> index ce0eb03709c3..55d8e1419302 100644
> --- a/drivers/gpu/drm/i915/gvt/gtt.c
> +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> @@ -959,6 +959,7 @@ static inline int ppgtt_put_spt(struct intel_vgpu_ppgtt_spt *spt)
>  	return atomic_dec_return(&spt->refcount);
>  }
>  
> +static int  ppgtt_invalidate_and_free_spt(struct intel_vgpu_ppgtt_spt *spt);

Odd extra space after the 'int', why?

