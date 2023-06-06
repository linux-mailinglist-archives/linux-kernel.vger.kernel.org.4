Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAF972453C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbjFFOFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbjFFOFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:05:23 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEA110CC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:05:18 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126253223039.31.openmobile.ne.jp [126.253.223.39])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DDA14AB;
        Tue,  6 Jun 2023 16:04:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1686060290;
        bh=Aaq/KoXC/ySwqQ0dnFsaUJNQb07dBEPZkJPfJbEBotw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s/dilhGw0TFAFDBC4ITGPQAgGjVw0Q9x/mkAzQa5mjZ0UaJO7uS1nKyxeKd1t4Jjw
         ZI6LqUMa7nxrWB+7H79My9LS8UKv2xnXVHtEzUDzJ8tanjotlRk0KQSDBE+f0ftqoM
         eKoEqqvhRjEZsni9splZWBf1nrNQatNcBvXUX4EQ=
Date:   Tue, 6 Jun 2023 17:05:12 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Suraj Upadhyay <usuraj35@gmail.com>
Subject: Re: [PATCH v9 2/8] drm/print: Fix and add support for NULL as first
 argument in drm_* macros
Message-ID: <20230606140512.GA5197@pendragon.ideasonboard.com>
References: <cover.1686047727.git.code@siddh.me>
 <ae42791195a788bb77b3f9c2b87bca5d4e78cf83.1686047727.git.code@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae42791195a788bb77b3f9c2b87bca5d4e78cf83.1686047727.git.code@siddh.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Siddh,

Thank you for the patch.

On Tue, Jun 06, 2023 at 04:15:16PM +0530, Siddh Raman Pant wrote:
> Comments say macros DRM_DEBUG_* are deprecated in favor of
> drm_dbg_*(NULL, ...), but they have broken support for it,
> as the macro will result in `(NULL) ? (NULL)->dev : NULL`.

What's the problem there ?

> Thus, fix them by separating logic to get dev ptr in a new
> function, which will return the dev ptr if arg is not NULL.
> Use it in drm_dbg_*, and also in __DRM_DEFINE_DBG_RATELIMITED,
> where a similar (but correct) NULL check was in place.
> 
> Also, add support for NULL in __drm_printk, so that all the
> drm_* macros will hence support NULL as the first argument.
> This also means that deprecation comments mentioning pr_()*
> can now be changed to the drm equivalents.
> 
> Signed-off-by: Siddh Raman Pant <code@siddh.me>
> ---
>  include/drm/drm_print.h | 79 +++++++++++++++++++++++++++--------------
>  1 file changed, 52 insertions(+), 27 deletions(-)
> 
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index a93a387f8a1a..4b8532cf2ae6 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -34,6 +34,7 @@
>  #include <linux/dynamic_debug.h>
>  
>  #include <drm/drm.h>
> +#include <drm/drm_device.h>
>  
>  /* Do *not* use outside of drm_print.[ch]! */
>  extern unsigned long __drm_debug;
> @@ -451,9 +452,32 @@ void __drm_dev_dbg(struct _ddebug *desc, const struct device *dev,
>   * Prefer drm_device based logging over device or prink based logging.
>   */
>  
> +/* Helpers for struct drm_device based logging. */
> +
> +/**
> + * __drm_dev_ptr - Helper function to get drm->dev pointer.
> + * @drm: struct drm_device pointer.
> + *
> + * RETURNS:
> + * The struct device pointer (NULL if @drm is NULL).
> + */
> +static inline struct device *__drm_dev_ptr(const struct drm_device *drm)
> +{
> +	if (drm)
> +		return drm->dev;
> +
> +	return NULL;
> +}
> +
>  /* Helper for struct drm_device based logging. */
>  #define __drm_printk(drm, level, type, fmt, ...)			\
> -	dev_##level##type((drm)->dev, "[drm] " fmt, ##__VA_ARGS__)
> +({									\
> +	struct device *__dev_ = __drm_dev_ptr(drm);			\
> +	if (__dev_)							\
> +		dev_##level##type(__dev_, "[drm] " fmt, ##__VA_ARGS__);	\
> +	else								\
> +		pr_##level##type("[drm] " fmt, ##__VA_ARGS__);		\

If I recall correctly, dev_*() handle a NULL dev pointer just fine. Do
we need to manually fall back to pr_*() ?

> +})
>  
>  
>  #define drm_info(drm, fmt, ...)					\
> @@ -487,25 +511,25 @@ void __drm_dev_dbg(struct _ddebug *desc, const struct device *dev,
>  
>  
>  #define drm_dbg_core(drm, fmt, ...)					\
> -	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_CORE, fmt, ##__VA_ARGS__)
> -#define drm_dbg_driver(drm, fmt, ...)						\
> -	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
> +	drm_dev_dbg(__drm_dev_ptr(drm), DRM_UT_CORE, fmt, ##__VA_ARGS__)
> +#define drm_dbg_driver(drm, fmt, ...)					\
> +	drm_dev_dbg(__drm_dev_ptr(drm), DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
>  #define drm_dbg_kms(drm, fmt, ...)					\
> -	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_KMS, fmt, ##__VA_ARGS__)
> +	drm_dev_dbg(__drm_dev_ptr(drm), DRM_UT_KMS, fmt, ##__VA_ARGS__)
>  #define drm_dbg_prime(drm, fmt, ...)					\
> -	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_PRIME, fmt, ##__VA_ARGS__)
> +	drm_dev_dbg(__drm_dev_ptr(drm), DRM_UT_PRIME, fmt, ##__VA_ARGS__)
>  #define drm_dbg_atomic(drm, fmt, ...)					\
> -	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_ATOMIC, fmt, ##__VA_ARGS__)
> +	drm_dev_dbg(__drm_dev_ptr(drm), DRM_UT_ATOMIC, fmt, ##__VA_ARGS__)
>  #define drm_dbg_vbl(drm, fmt, ...)					\
> -	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_VBL, fmt, ##__VA_ARGS__)
> +	drm_dev_dbg(__drm_dev_ptr(drm), DRM_UT_VBL, fmt, ##__VA_ARGS__)
>  #define drm_dbg_state(drm, fmt, ...)					\
> -	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_STATE, fmt, ##__VA_ARGS__)
> +	drm_dev_dbg(__drm_dev_ptr(drm), DRM_UT_STATE, fmt, ##__VA_ARGS__)
>  #define drm_dbg_lease(drm, fmt, ...)					\
> -	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_LEASE, fmt, ##__VA_ARGS__)
> +	drm_dev_dbg(__drm_dev_ptr(drm), DRM_UT_LEASE, fmt, ##__VA_ARGS__)
>  #define drm_dbg_dp(drm, fmt, ...)					\
> -	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_DP, fmt, ##__VA_ARGS__)
> +	drm_dev_dbg(__drm_dev_ptr(drm), DRM_UT_DP, fmt, ##__VA_ARGS__)
>  #define drm_dbg_drmres(drm, fmt, ...)					\
> -	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_DRMRES, fmt, ##__VA_ARGS__)
> +	drm_dev_dbg(__drm_dev_ptr(drm), DRM_UT_DRMRES, fmt, ##__VA_ARGS__)
>  
>  #define drm_dbg(drm, fmt, ...)	drm_dbg_driver(drm, fmt, ##__VA_ARGS__)
>  
> @@ -533,31 +557,31 @@ void __drm_err(const char *format, ...);
>  #define _DRM_PRINTK(once, level, fmt, ...)				\
>  	printk##once(KERN_##level "[" DRM_NAME "] " fmt, ##__VA_ARGS__)
>  
> -/* NOTE: this is deprecated in favor of pr_info(). */
> +/* NOTE: this is deprecated in favor of drm_info(NULL, ...). */
>  #define DRM_INFO(fmt, ...)						\
>  	_DRM_PRINTK(, INFO, fmt, ##__VA_ARGS__)
> -/* NOTE: this is deprecated in favor of pr_notice(). */
> +/* NOTE: this is deprecated in favor of drm_notice(NULL, ...). */
>  #define DRM_NOTE(fmt, ...)						\
>  	_DRM_PRINTK(, NOTICE, fmt, ##__VA_ARGS__)
> -/* NOTE: this is deprecated in favor of pr_warn(). */
> +/* NOTE: this is deprecated in favor of drm_warn(NULL, ...). */
>  #define DRM_WARN(fmt, ...)						\
>  	_DRM_PRINTK(, WARNING, fmt, ##__VA_ARGS__)
>  
> -/* NOTE: this is deprecated in favor of pr_info_once(). */
> +/* NOTE: this is deprecated in favor of drm_info_once(NULL, ...). */
>  #define DRM_INFO_ONCE(fmt, ...)						\
>  	_DRM_PRINTK(_once, INFO, fmt, ##__VA_ARGS__)
> -/* NOTE: this is deprecated in favor of pr_notice_once(). */
> +/* NOTE: this is deprecated in favor of drm_notice_once(NULL, ...). */
>  #define DRM_NOTE_ONCE(fmt, ...)						\
>  	_DRM_PRINTK(_once, NOTICE, fmt, ##__VA_ARGS__)
> -/* NOTE: this is deprecated in favor of pr_warn_once(). */
> +/* NOTE: this is deprecated in favor of drm_warn_once(NULL, ...). */
>  #define DRM_WARN_ONCE(fmt, ...)						\
>  	_DRM_PRINTK(_once, WARNING, fmt, ##__VA_ARGS__)
>  
> -/* NOTE: this is deprecated in favor of pr_err(). */
> +/* NOTE: this is deprecated in favor of drm_err(NULL, ...). */
>  #define DRM_ERROR(fmt, ...)						\
>  	__drm_err(fmt, ##__VA_ARGS__)
>  
> -/* NOTE: this is deprecated in favor of pr_err_ratelimited(). */
> +/* NOTE: this is deprecated in favor of drm_err_ratelimited(NULL, ...). */
>  #define DRM_ERROR_RATELIMITED(fmt, ...)					\
>  	DRM_DEV_ERROR_RATELIMITED(NULL, fmt, ##__VA_ARGS__)
>  
> @@ -593,13 +617,14 @@ void __drm_err(const char *format, ...);
>  #define DRM_DEBUG_DP(fmt, ...)						\
>  	__drm_dbg(DRM_UT_DP, fmt, ## __VA_ARGS__)
>  
> -#define __DRM_DEFINE_DBG_RATELIMITED(category, drm, fmt, ...)					\
> -({												\
> -	static DEFINE_RATELIMIT_STATE(rs_, DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);\
> -	const struct drm_device *drm_ = (drm);							\
> -												\
> -	if (drm_debug_enabled(DRM_UT_ ## category) && __ratelimit(&rs_))			\
> -		drm_dev_printk(drm_ ? drm_->dev : NULL, KERN_DEBUG, fmt, ## __VA_ARGS__);	\
> +#define __DRM_DEFINE_DBG_RATELIMITED(category, drm, fmt, ...)		\
> +({									\
> +	static DEFINE_RATELIMIT_STATE(rs_, DEFAULT_RATELIMIT_INTERVAL,	\
> +				      DEFAULT_RATELIMIT_BURST);		\
> +									\
> +	if (drm_debug_enabled(DRM_UT_ ## category) && __ratelimit(&rs_))\
> +		drm_dev_printk(__drm_dev_ptr(drm), KERN_DEBUG,		\
> +			       fmt, ## __VA_ARGS__);			\
>  })
>  
>  #define drm_dbg_kms_ratelimited(drm, fmt, ...) \

-- 
Regards,

Laurent Pinchart
