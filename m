Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81898732D49
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343670AbjFPKR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245369AbjFPKRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:17:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFDB170E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 03:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686910656; x=1718446656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p9l3rC4lvWmIcDE6S4P319s7+1UjqTQtD/uy17dtOa4=;
  b=JDfCEv9x87ZHFbDf6wLDpEgYDlNqH2qEEqsB+42JnZZCzSmA2NYC/3ml
   E01yIn3A+o0pqKk6/4J8KqgOvVx0VifuqSEupe1JAoWHLCp3W36YCHxEf
   rqdmG08CEyj8kwa9IetAoATj3JCdRiH7+Ebh/V4u95goIzoEe3V4dCI96
   18nx4jv8vFJ1h65HyUZD/ARktzw61WaU/tV6vkgiyAydxTtIEw1q2EB+P
   BjsrFjNvuxrTV2nDLhuw/bKRyL5GhZjkbSZ+sFi1XQ4rZGwcFjEoZ8XVT
   xI2+JY0a8P4CpEEbZDXw8bOQVlP7cP0Po8YJmJS4cArr2CX+Xg92r4fIJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="445560375"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="445560375"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 03:16:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="742618866"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="742618866"
Received: from vyashin-mobl1.ger.corp.intel.com (HELO intel.com) ([10.252.36.124])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 03:16:53 -0700
Date:   Fri, 16 Jun 2023 12:16:49 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Matt Roper <matthew.d.roper@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        Anshuman Gupta <anshuman.gupta@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: make i915_drm_client_fdinfo() reference
 conditional again
Message-ID: <ZIw2kdx9+DCmUZUV@ashyti-mobl2.lan>
References: <20230616093158.3568480-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616093158.3568480-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, Jun 16, 2023 at 11:31:47AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The function is only defined if CONFIG_PROC_FS is enabled:
> 
> ld.lld: error: undefined symbol: i915_drm_client_fdinfo
> >>> referenced by i915_driver.c
> >>>               drivers/gpu/drm/i915/i915_driver.o:(i915_drm_driver) in archive vmlinux.a
> 
> Use the PTR_IF() helper to make the reference NULL otherwise.
> 
> Fixes: e894b724c316d ("drm/i915: Use the fdinfo helper")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/i915/i915_driver.c     | 2 +-
>  drivers/gpu/drm/i915/i915_drm_client.h | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
> index 75cbc43b326dd..0ad0c5885ec27 100644
> --- a/drivers/gpu/drm/i915/i915_driver.c
> +++ b/drivers/gpu/drm/i915/i915_driver.c
> @@ -1816,7 +1816,7 @@ static const struct drm_driver i915_drm_driver = {
>  	.open = i915_driver_open,
>  	.lastclose = i915_driver_lastclose,
>  	.postclose = i915_driver_postclose,
> -	.show_fdinfo = i915_drm_client_fdinfo,
> +	.show_fdinfo = PTR_IF(IS_ENABLED(CONFIG_PROC_FS), i915_drm_client_fdinfo),
>  
>  	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>  	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> diff --git a/drivers/gpu/drm/i915/i915_drm_client.h b/drivers/gpu/drm/i915/i915_drm_client.h
> index 4c18b99e10a4e..67816c912bca1 100644
> --- a/drivers/gpu/drm/i915/i915_drm_client.h
> +++ b/drivers/gpu/drm/i915/i915_drm_client.h
> @@ -47,8 +47,6 @@ static inline void i915_drm_client_put(struct i915_drm_client *client)
>  
>  struct i915_drm_client *i915_drm_client_alloc(void);
>  
> -#ifdef CONFIG_PROC_FS
>  void i915_drm_client_fdinfo(struct drm_printer *p, struct drm_file *file);
> -#endif

nice! This is becoming the new trend now.

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com> 

Andi
