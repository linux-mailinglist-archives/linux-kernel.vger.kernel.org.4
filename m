Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91539652EBC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 10:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbiLUJlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 04:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiLUJlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:41:14 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DD9BF58
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 01:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671615673; x=1703151673;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ABf8vfI3IIw12ocR1zSeeiipTn1viEXhdkoDc2bJQ/g=;
  b=nyc72VlE1l+kMNCSYEypDAmWDPT//XZ9x2iLeaMaQ/Q6P3/A/Y4tKf5Z
   emi8xbrzah2Mb+LD9Ptz1h9n1aobz1bycQDscunYc5STIbLaUUNt2+n9i
   crzBl8kq4vRkkqTS1HPa38I/aW2HiYl4p3Hchz50m7URo+fl2vwV4Ho25
   v+NmSHlgv7x6AlP0cpBNBHpOlHdQv/bwQQpstoIBDLopkeBX6yM+IGSo+
   ykm+7GLGYzbj1mX1M4kdhRQZ031b2qt8cp1jETvCPAHnYTK9DjWf/bO/e
   QNhBStJ4/d3QDA3MbqutooTrX/W6YxqHcLmHJI8rXFBJ/lPdHh24bUA3/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="299509399"
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; 
   d="scan'208";a="299509399"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 01:41:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="644773486"
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; 
   d="scan'208";a="644773486"
Received: from jorgeblx-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.46.119])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 01:41:09 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Siddh Raman Pant <code@siddh.me>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 04/10] drm/print: Fix support for NULL as first argument
 of drm_dbg_*
In-Reply-To: <3ebf0d61ad5e82875a4493108602e62429306b14.1671566741.git.code@siddh.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1671566741.git.code@siddh.me>
 <3ebf0d61ad5e82875a4493108602e62429306b14.1671566741.git.code@siddh.me>
Date:   Wed, 21 Dec 2022 11:41:07 +0200
Message-ID: <87edst2ix8.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Dec 2022, Siddh Raman Pant <code@siddh.me> wrote:
> Comments say macros DRM_DEBUG_* are deprecated in favor of
> drm_dbg_*(NULL, ...), but they have broken support for it,
> as the macro will result in `(NULL) ? (NULL)->dev : NULL`.

What's wrong with that?

>
> Thus, fix them by casting input drm to a temporary struct ptr,
> with the same convention as in __DRM_DEFINE_DBG_RATELIMITED.
>
> Signed-off-by: Siddh Raman Pant <code@siddh.me>
> ---
>  include/drm/drm_print.h | 89 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 69 insertions(+), 20 deletions(-)
>
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index a44fb7ef257f..53702d830291 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -486,26 +486,75 @@ void __drm_dev_dbg(struct _ddebug *desc, const struct device *dev,
>  	__drm_printk((drm), err, _ratelimited, "*ERROR* " fmt, ##__VA_ARGS__)
>  
>  
> -#define drm_dbg_core(drm, fmt, ...)					\
> -	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_CORE, fmt, ##__VA_ARGS__)
> -#define drm_dbg_driver(drm, fmt, ...)						\
> -	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
> -#define drm_dbg_kms(drm, fmt, ...)					\
> -	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_KMS, fmt, ##__VA_ARGS__)
> -#define drm_dbg_prime(drm, fmt, ...)					\
> -	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_PRIME, fmt, ##__VA_ARGS__)
> -#define drm_dbg_atomic(drm, fmt, ...)					\
> -	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_ATOMIC, fmt, ##__VA_ARGS__)
> -#define drm_dbg_vbl(drm, fmt, ...)					\
> -	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_VBL, fmt, ##__VA_ARGS__)
> -#define drm_dbg_state(drm, fmt, ...)					\
> -	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_STATE, fmt, ##__VA_ARGS__)
> -#define drm_dbg_lease(drm, fmt, ...)					\
> -	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_LEASE, fmt, ##__VA_ARGS__)
> -#define drm_dbg_dp(drm, fmt, ...)					\
> -	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_DP, fmt, ##__VA_ARGS__)
> -#define drm_dbg_drmres(drm, fmt, ...)					\
> -	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_DRMRES, fmt, ##__VA_ARGS__)
> +#define drm_dbg_core(drm, fmt, ...)				\
> +({								\
> +	const struct drm_device *drm_ = (drm);			\
> +	drm_dev_dbg(drm_ ? drm_->dev : NULL, DRM_UT_CORE,	\
> +		    fmt, ##__VA_ARGS__);			\
> +})
> +
> +#define drm_dbg_driver(drm, fmt, ...)				\
> +({								\
> +	const struct drm_device *drm_ = (drm);			\
> +	drm_dev_dbg(drm_ ? drm_->dev : NULL, DRM_UT_DRIVER,	\
> +		    fmt, ##__VA_ARGS__);			\
> +})
> +
> +#define drm_dbg_kms(drm, fmt, ...)				\
> +({								\
> +	const struct drm_device *drm_ = (drm);			\
> +	drm_dev_dbg(drm_ ? drm_->dev : NULL, DRM_UT_KMS,	\
> +		    fmt, ##__VA_ARGS__);			\
> +})
> +
> +#define drm_dbg_prime(drm, fmt, ...)				\
> +({								\
> +	const struct drm_device *drm_ = (drm);			\
> +	drm_dev_dbg(drm_ ? drm_->dev : NULL, DRM_UT_PRIME,	\
> +		    fmt, ##__VA_ARGS__);			\
> +})
> +
> +#define drm_dbg_atomic(drm, fmt, ...)				\
> +({								\
> +	const struct drm_device *drm_ = (drm);			\
> +	drm_dev_dbg(drm_ ? drm_->dev : NULL, DRM_UT_ATOMIC,	\
> +		    fmt, ##__VA_ARGS__);			\
> +})
> +
> +#define drm_dbg_vbl(drm, fmt, ...)				\
> +({								\
> +	const struct drm_device *drm_ = (drm);			\
> +	drm_dev_dbg(drm_ ? drm_->dev : NULL, DRM_UT_VBL,	\
> +		    fmt, ##__VA_ARGS__);			\
> +})
> +
> +#define drm_dbg_state(drm, fmt, ...)				\
> +({								\
> +	const struct drm_device *drm_ = (drm);			\
> +	drm_dev_dbg(drm_ ? drm_->dev : NULL, DRM_UT_STATE,	\
> +		    fmt, ##__VA_ARGS__);			\
> +})
> +
> +#define drm_dbg_lease(drm, fmt, ...)				\
> +({								\
> +	const struct drm_device *drm_ = (drm);			\
> +	drm_dev_dbg(drm_ ? drm_->dev : NULL, DRM_UT_LEASE,	\
> +		    fmt, ##__VA_ARGS__);			\
> +})
> +
> +#define drm_dbg_dp(drm, fmt, ...)				\
> +({								\
> +	const struct drm_device *drm_ = (drm);			\
> +	drm_dev_dbg(drm_ ? drm_->dev : NULL, DRM_UT_DP,		\
> +		    fmt, ##__VA_ARGS__);			\
> +})
> +
> +#define drm_dbg_drmres(drm, fmt, ...)				\
> +({								\
> +	const struct drm_device *drm_ = (drm);			\
> +	drm_dev_dbg(drm_ ? drm_->dev : NULL, DRM_UT_DRMRES,	\
> +		    fmt, ##__VA_ARGS__);			\
> +})
>  
>  #define drm_dbg(drm, fmt, ...)	drm_dbg_driver(drm, fmt, ##__VA_ARGS__)

-- 
Jani Nikula, Intel Open Source Graphics Center
