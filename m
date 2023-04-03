Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50AA6D4D80
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjDCQX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjDCQXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:23:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3837E9
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680539026; x=1712075026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KKOoqArtLJbI+AYxzGdM3VB9YLMZqitlFjI+Y4NeHVM=;
  b=kt7fVBcy39DnmNJpFb1OqiO0Js52CHdNLZL03ykZfSfd2KjjlLHmDetx
   lnOOub/WJG8xHl/jGj01VWbe4gkytQuggND5xTDlVgKK2eeysPaUTCmXh
   Z9eweTA5l2xOLf+Qu8Fkw3kYHMZdxTWr9bDv8Tj8qKdtiLam0ptveI1CI
   /nO9GgguG9reYwAPMPkOU+kVCmUQ3AYhiBvVxLSW2UVQAqUBppyRNrBOA
   bYRIyvxk+Tr8fLykBsb7mebtlwu4pcgUw/n1F8MpBc9RfwEy8o/VQAq3v
   za0aZSzEsUFTKyqHm0620pFB9hMRHh6EhtEQAgv0ovSBivHqdhauSYOX/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="340677125"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="340677125"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 09:23:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="829622393"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="829622393"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.70])
  by fmsmga001.fm.intel.com with SMTP; 03 Apr 2023 09:23:43 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 03 Apr 2023 19:23:43 +0300
Date:   Mon, 3 Apr 2023 19:23:42 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/vblank: Simplify drm_dev_has_vblank()
Message-ID: <ZCr9jrhTyGuZA+Qt@intel.com>
References: <20230403160735.1211468-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230403160735.1211468-1-robdclark@gmail.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 09:07:35AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> What does vblank have to do with num_crtcs?  Well, this was technically
> correct, but you'd have to go look at where num_crtcs is initialized to
> understand why.  Lets just replace it with the simpler and more obvious
> check.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/drm_vblank.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 877e2067534f..ad34c235d853 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -575,7 +575,7 @@ EXPORT_SYMBOL(drm_vblank_init);
>   */
>  bool drm_dev_has_vblank(const struct drm_device *dev)
>  {
> -	return dev->num_crtcs != 0;
> +	return !!dev->vblank;

The compiler knows how to turn things into a boolean.

Or I guess if we want to be a bit more explicit we could
write this as
 return dev->vblank != NULL;
but IIRC that will make checkpatch complain because of
someone's personal taste.

>  }
>  EXPORT_SYMBOL(drm_dev_has_vblank);
>  
> -- 
> 2.39.2

-- 
Ville Syrjälä
Intel
