Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859F76E06C8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 08:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjDMGKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 02:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDMGKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 02:10:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5E06A4D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 23:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681366226; x=1712902226;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=pr4JMmzrY9/O4gH96CYZvtQO5gVEJvmjkeQFkOuJ8iE=;
  b=akLno7talUivVJMlV9ViBFckQ6PWUzK/d3I9zum/60jzcthC5FSS6+mP
   FNBSC+On7YNUruXg6AExUeZqeMWvkxbwSE7JQ39P/zOPoQERjpYZXE5kJ
   bYSUOF1BbaRZysboxam+SjFbpNAY1lwkKe0f5SHqLB1DdO0uhVj9Gd5vx
   trowwewPkBWekX0m/1VaIvIrvqSle8+nXvkokJy5GPW2WuIK0/gTkROlm
   mcj9jlLnrxwkcQQYQXU25jC/hCaQO0QIKoWz1+fBeqxjwZr6+TnxK68/B
   tYcwKJFPEdTd7raeWrAjCoHaw4H7hKr0uHHCL+j10fPO47Mf5c1PXNF3l
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="324453754"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="324453754"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 23:10:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="758554353"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="758554353"
Received: from lzygo-mobl.ger.corp.intel.com (HELO [10.213.3.63]) ([10.213.3.63])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 23:10:08 -0700
Message-ID: <71ba4962-14fd-887f-1d40-31089dd1cf50@intel.com>
Date:   Thu, 13 Apr 2023 08:10:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/i915: Fix memory leaks in i915 selftests
Content-Language: en-US
To:     Cong Liu <liucong2@kylinos.cn>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230413031349.9026-1-liucong2@kylinos.cn>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230413031349.9026-1-liucong2@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.04.2023 05:13, Cong Liu wrote:
> Fixes: c3bfba9a2225 ("drm/i915: Check for integer truncation on scatterlist creation")
>
> Signed-off-by: Cong Liu <liucong2@kylinos.cn>
> ---

Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Regards
Andrzej
>   drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
> index 5361ce70d3f2..154801f1c468 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
> @@ -69,8 +69,10 @@ static int fake_get_pages(struct drm_i915_gem_object *obj)
>   
>   	rem = round_up(obj->base.size, BIT(31)) >> 31;
>   	/* restricted by sg_alloc_table */
> -	if (overflows_type(rem, unsigned int))
> +	if (overflows_type(rem, unsigned int)) {
> +		kfree(pages);
>   		return -E2BIG;
> +	}
>   
>   	if (sg_alloc_table(pages, rem, GFP)) {
>   		kfree(pages);

