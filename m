Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5497E627D93
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbiKNMVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbiKNMUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:20:52 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A2C23383
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668428450; x=1699964450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rvPmNzCoa8n8SixsXezw6M9E+Ll3YuySZ4TJDTq+LLk=;
  b=iFqkOSzqKWaB3eqIebDkIQi3YhNm55JSM/bW8068GAS04dL0+Jla9SFv
   wqrYj87vBB0Yfmx80/4BivrOILvmeDGSBQiS6OOI7xnPWPvDQUFLSxuA7
   HvA/v3XFVmrs3Lja2NlbnSAfXqUp4aiAMhSIxDSC8b9QVj9Z6MkHwT6Fe
   +iKVDCnrdWjdpX76BWXKeWWmZJyq4IQnsMxckKhYt08yyc5UngHnJEDlI
   SS2bL+xC8MWdBJAstPWJLPs+lVgKVIeW0+WQgl5HfMyITOskfPHqLa3gy
   8skceTjX4H/lCVK5wMw2Ep0vPmD5DUs5emt7Uvzjifz5usWOgqqfndknt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="398245648"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="398245648"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 04:20:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="616291804"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="616291804"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.191])
  by orsmga006.jf.intel.com with SMTP; 14 Nov 2022 04:20:46 -0800
Received: by stinkbox (sSMTP sendmail emulation); Mon, 14 Nov 2022 14:20:45 +0200
Date:   Mon, 14 Nov 2022 14:20:45 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        daniel.vetter@ffwll.ch, linux@rasmusvillemoes.dk,
        seanpaul@chromium.org, joe@perches.com
Subject: Re: [Intel-gfx] [PATCH 1/7] drm: mark drm.debug-on-dyndbg as BROKEN
 for now
Message-ID: <Y3IynYl3Ejb6NTAd@intel.com>
References: <20220912052852.1123868-1-jim.cromie@gmail.com>
 <20221111221715.563020-1-jim.cromie@gmail.com>
 <20221111221715.563020-2-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221111221715.563020-2-jim.cromie@gmail.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 03:17:09PM -0700, Jim Cromie wrote:
> drm.debug-on-dyndbg has a regression, due to a chicken-egg
> initialization problem:
> 
> 1- modprobe i915
>    i915 needs drm.ko, which is loaded 1st
> 
> 2- "modprobe drm drm.debug=0x1ff" (virtual/implied)
>    drm.debug is set post-initialization, from boot-args etc
> 
> 3- `modprobe i915` finishes
> 
> W/O drm.debug-on-dyndbg that just works, because all drm_dbg*
> callsites use drm_debug_enabled() to check __drm_debug & DEM_UT_<CAT>
> before printing.
> 
> But the whole point of drm.debug-on-dyndbg is to avoid that runtime
> test, by enabling (at post-modinit) a static-key at each callsite in
> the just-loaded module.
> 
> And since drm.ko is loaded before all dependent modules, none are
> "just-loaded", and no drm.debug callsites are present yet, except
> those in drm.ko itself.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  drivers/gpu/drm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 34f5a092c99e..0d1e59e6bb7e 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -54,6 +54,7 @@ config DRM_DEBUG_MM
>  config DRM_USE_DYNAMIC_DEBUG
>  	bool "use dynamic debug to implement drm.debug"
>  	default y

Could you switch to 'default n' as well? i915 CI actually enables
BROKEN so that we can test some more experimental stuff which is
hidden behind BROKEN for normal users.

> +	depends on BROKEN	# chicken-egg initial enable problem
>  	depends on DRM
>  	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
>  	depends on JUMP_LABEL
> -- 
> 2.38.1

-- 
Ville Syrjälä
Intel
