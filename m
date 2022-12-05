Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013586426F2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiLEKvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiLEKvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:51:01 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2F712AEC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 02:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670237460; x=1701773460;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ZtQiyBckUqwzejPR2GfLMw1fO1ZsEeVGuEaG9PLVtdI=;
  b=N/oB47w+D3XnGphv8r+02MIiwrur+pA2vncxnGPeY5TnnRzynGA7HV+y
   R+BtqkFyEL+0VdazbmKx5ag0s6BNW8Fw0EZbLyEisaVDhFlsdVh/3GcKd
   95JSoeH9rQnUT54bq25Zyw1t8u/CyB2AVE2k0Iu9gxe8geymUqw/sRXxq
   k01DNaaGeps2Z7BtLnRtvY3El3CF2LrRHrHEQl7K1AROrIu2H++JZVs9n
   TA2a0z9VN3Km5teMe+R9iBamh8EkNEJgZg2W7JgTs7h3W2LjUez4gWRdx
   L9PfW3ekRl2eet719tnFxXuvae8EyHi1B5uhFj/K+xYQX0zwqhuR3ZHEg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="315021580"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="315021580"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 02:51:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="623461396"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="623461396"
Received: from akramiss-mobl1.amr.corp.intel.com (HELO localhost) ([10.252.54.203])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 02:50:56 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     ye.xingchen@zte.com.cn, joonas.lahtinen@linux.intel.com
Cc:     rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: use sysfs_emit() to instead of scnprintf()
In-Reply-To: <202212011053265568903@zte.com.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <202212011053265568903@zte.com.cn>
Date:   Mon, 05 Dec 2022 12:50:53 +0200
Message-ID: <878rjm2kfm.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Dec 2022, <ye.xingchen@zte.com.cn> wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Replace the open-code with sysfs_emit() to simplify the code.

I was going to push this, but noticed the function has a third
scnprintf(), and the last two play together with count. It would be
confusing to have a mix of sysfs_emit() and scnprintf(). The third one
can't be blindly converted to sysfs_emit() because it writes at an
offset not aligned by PAGE_SIZE.

So I'm not taking this.

BR,
Jani.

>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/gpu/drm/i915/i915_mitigations.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_mitigations.c b/drivers/gpu/drm/i915/i915_mitigations.c
> index def7302ef7fe..2b7aaaefb3a9 100644
> --- a/drivers/gpu/drm/i915/i915_mitigations.c
> +++ b/drivers/gpu/drm/i915/i915_mitigations.c
> @@ -102,10 +102,10 @@ static int mitigations_get(char *buffer, const struct kernel_param *kp)
>  	bool enable;
>
>  	if (!local)
> -		return scnprintf(buffer, PAGE_SIZE, "%s\n", "off");
> +		return sysfs_emit(buffer, "%s\n", "off");
>
>  	if (local & BIT(BITS_PER_LONG - 1)) {
> -		count = scnprintf(buffer, PAGE_SIZE, "%s,", "auto");
> +		count = sysfs_emit(buffer, "%s,", "auto");
>  		enable = false;
>  	} else {
>  		enable = true;

-- 
Jani Nikula, Intel Open Source Graphics Center
