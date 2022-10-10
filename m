Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291C05F9AA7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 10:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiJJIHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 04:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiJJIHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 04:07:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982B6E002;
        Mon, 10 Oct 2022 01:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665389269; x=1696925269;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=frgAyct9AHtbbmWOIu5eUWwwqKJA8S6suGXKhPXwyEE=;
  b=EUhtlla2oN8mTWKVSSj33v1IPqFnOTKoevbvg1xcKJ1+RlKBZCAztji8
   hOF9k/RWf1DIMP/J9H7dzpobCxN/fKG6+748cu/1+1sGiwa6910C09jY8
   VXg5ONU5eMhd6LVAxfjrDV6u33Xclp6JLRyCo+MqVWQQxkxNkKO3+Qh3w
   VowdIvgX9CW/r1RjcShfsGQDmucSrLKO4acB6Wa01hsBv/hhXGZTxmKv/
   5D2ls/9ebc7NOSTWPgaspvQqM/P38Cg3f+i+jwRLx5UciqkHhIk2PXE2a
   H9J6sW/dT/yskBF+lwl0NsV0Q4VdThbdvkmsQBZ28yp+YqAv65sDvuMZk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="287407518"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="287407518"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 01:07:48 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="871019949"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="871019949"
Received: from liammurp-mobl1.ger.corp.intel.com (HELO [10.213.197.233]) ([10.213.197.233])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 01:07:46 -0700
Message-ID: <732c7a7d-2851-4ac0-cd7a-6f9a2f3df50a@linux.intel.com>
Date:   Mon, 10 Oct 2022 09:07:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] drm/i915/gem: remove redundant assignments to variable
 ret
To:     Colin Ian King <colin.i.king@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221007194745.2749277-1-colin.i.king@gmail.com>
Content-Language: en-US
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20221007194745.2749277-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/10/2022 20:47, Colin Ian King wrote:
> The variable ret is being assigned with a value that is never read
> both before and after a while-loop. The variable is being re-assigned
> inside the while-loop and afterwards on the call to the function
> i915_gem_object_lock_interruptible. Remove the redundants assignments.
> 
> Cleans up clang scan-build warnings:
> 
> warning: Although the value stored to 'ret' is used in the
> enclosing expression, the value is never actually read
> from 'ret' [deadcode.DeadStores]
> 
> warning: Value stored to 'ret' is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> index d4398948f016..b7e24476a0fd 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> @@ -292,7 +292,7 @@ int i915_gem_object_userptr_submit_init(struct drm_i915_gem_object *obj)
>   	if (!i915_gem_object_is_readonly(obj))
>   		gup_flags |= FOLL_WRITE;
>   
> -	pinned = ret = 0;
> +	pinned = 0;
>   	while (pinned < num_pages) {
>   		ret = pin_user_pages_fast(obj->userptr.ptr + pinned * PAGE_SIZE,
>   					  num_pages - pinned, gup_flags,
> @@ -302,7 +302,6 @@ int i915_gem_object_userptr_submit_init(struct drm_i915_gem_object *obj)
>   
>   		pinned += ret;
>   	}
> -	ret = 0;
>   
>   	ret = i915_gem_object_lock_interruptible(obj, NULL);
>   	if (ret)

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Thanks for the cleanup, will merge.

Regards,

Tvrtko
