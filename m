Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1193C729414
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240593AbjFIJD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240331AbjFIJDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:03:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF7DB9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686301427; x=1717837427;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=2PWm/0cQ42+zGqkyy6ebZ11SVlnNhp4ff28Vfl3WNXo=;
  b=HMLvgmfYcuTxXCsPFHak+b7vGZaPmUAtoF3DrnSVY1KRxlruwjpVUN8k
   yTuSXEJpzCLGVaPbPuCBej6Y5xD3RKEb/PivivG+CrBgQH6l7MbJf9ck5
   Mq8jlf9pcB7T0k/koD0vA9ig7bYjCEYYP6QhMU9D6HtI9fDJqHqjz9mJ4
   wo17eav0jX/4sIJYBvdVpYv1VQPWyntMrVjEbE+zoIT0u/EaEOOtJD0HB
   mCouzVuugCtECAmb0qrGLpKhj5sNFeG9i/79ngzsyQJkAtiUoYLCXW505
   /aqydULd0zMQE+PuWLiTVemwwEO55GqOm+qZSQpaCbY4QOEwhBTo9ffr1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="355045901"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="355045901"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 02:03:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="660700480"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="660700480"
Received: from skolhe-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.58.254])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 02:03:31 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Ralph Campbell <rcampbell@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH] drm/edid: Add quirk for OSVR HDK 2.0
In-Reply-To: <20230609014207.2759720-1-rcampbell@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230609014207.2759720-1-rcampbell@nvidia.com>
Date:   Fri, 09 Jun 2023 12:03:26 +0300
Message-ID: <87y1ktqa75.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jun 2023, Ralph Campbell <rcampbell@nvidia.com> wrote:
> The OSVR virtual reality headset HDK 2.0 uses a different EDID
> vendor and device identifier than the HDK 1.1 - 1.4 headsets.
> Add the HDK 2.0 vendor and device identifier to the quirks table so
> that window managers do not try to display the desktop screen on the
> headset display.

At some point in time we requested bugs to be filed about quirks, with
EDIDs attached, so we could look at them later, and maybe remove the
quirks.

The headset non-desktop thing started off as a quirk, but since then
we've added both Microsoft VSDB and DisplayID primary use as ways to
indicate this without quirks.

BR,
Jani.

>
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Tested-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
>  drivers/gpu/drm/drm_edid.c | 1 +
>  1 file changed, 1 insertion(+)
>
> I don't know how many of these VR headsets are still around but I have a
> working one and I saw and entry for HDK 1.x so I thought it would be good
> to add HDK 2.0.
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 0454da505687..3b8cc1fe05e8 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -230,6 +230,7 @@ static const struct edid_quirk {
>  
>  	/* OSVR HDK and HDK2 VR Headsets */
>  	EDID_QUIRK('S', 'V', 'R', 0x1019, EDID_QUIRK_NON_DESKTOP),
> +	EDID_QUIRK('A', 'O', 'U', 0x1111, EDID_QUIRK_NON_DESKTOP),
>  };
>  
>  /*

-- 
Jani Nikula, Intel Open Source Graphics Center
