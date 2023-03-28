Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7456CCBB8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 22:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjC1U6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 16:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjC1U6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:58:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C8126A0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 13:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680037082; x=1711573082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BfVPOYVp2pmPvssW/9f7r7P90C48/4ru1Ch9FixAMO8=;
  b=GEeDnHCtmCLB+IcFmJ5iNzmg0jlCE5IVH49qZzMMnsr23NyM1RZEWu4c
   5k9bCxWoCrXlLiUG2kYvJg9rYCLz0e/ai/o28dglarNkru1Zc1jWbJZDQ
   zqFDzyhUH8Pi/oeZdNlHsCJ52iDzz5WCzRKcOZeg/CXOEP4oyzJyAzJcv
   +mXWi2Z3mY9XXLiL7aOge8QVML06RqDyZC91cYEAJtJf/POa2EbnEGBHt
   1wHWxPXYs4qGZseuLmyxChvW7vDE7DOf0t3Jh6ZbWEKAx1KQi31g5dP+J
   d+0SO7PIfjEbHAAt4V4omkGQ6G7qu/E0EWvhfoo9Xy+a3BsUwfTUP7t9c
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="426964409"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="426964409"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 13:58:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="634197652"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="634197652"
Received: from fhannebi-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.50.224])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 13:57:58 -0700
Date:   Tue, 28 Mar 2023 22:57:32 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Min Li <lm0963hack@gmail.com>
Cc:     jani.nikula@linux.intel.com, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        daniel@ffwll.ch, rodrigo.vivi@intel.com, airlied@gmail.com
Subject: Re: [Intel-gfx] [PATCH 1/1] drm/i915: fix race condition UAF in
 i915_perf_add_config_ioctl
Message-ID: <ZCNUvAiPt8BlQ1nc@ashyti-mobl2.lan>
References: <20230328093627.5067-1-lm0963hack@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328093627.5067-1-lm0963hack@gmail.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Min,

On Tue, Mar 28, 2023 at 05:36:27PM +0800, Min Li wrote:
> Userspace can guess the id value and try to race oa_config object creation
> with config remove, resulting in a use-after-free if we dereference the
> object after unlocking the metrics_lock.  For that reason, unlocking the
> metrics_lock must be done after we are done dereferencing the object.
> 
> Signed-off-by: Min Li <lm0963hack@gmail.com>

Thank you for your patch!

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Andi

> ---
>  drivers/gpu/drm/i915/i915_perf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
> index 824a34ec0b83..93748ca2c5da 100644
> --- a/drivers/gpu/drm/i915/i915_perf.c
> +++ b/drivers/gpu/drm/i915/i915_perf.c
> @@ -4634,13 +4634,13 @@ int i915_perf_add_config_ioctl(struct drm_device *dev, void *data,
>  		err = oa_config->id;
>  		goto sysfs_err;
>  	}
> -
> -	mutex_unlock(&perf->metrics_lock);
> +	id = oa_config->id;
>  
>  	drm_dbg(&perf->i915->drm,
>  		"Added config %s id=%i\n", oa_config->uuid, oa_config->id);
> +	mutex_unlock(&perf->metrics_lock);
>  
> -	return oa_config->id;
> +	return id;
>  
>  sysfs_err:
>  	mutex_unlock(&perf->metrics_lock);
> -- 
> 2.25.1
