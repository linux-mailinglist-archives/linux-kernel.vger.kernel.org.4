Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BB37108C4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240283AbjEYJX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239720AbjEYJXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:23:04 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76928A9
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685006583; x=1716542583;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=/GppYPfESLOi0JHBQPIuFHQkEMrivIc3fjf4d77i7TU=;
  b=kGo48ofxkaUO5mqPSxIhhhE9jfUnePxRmbLSmW1h6U0ilmXX8GNPMP77
   4EUBGjpcQTWOFEHQzrahYoCHa9FZAQmJOOsvbc8AiW53vImwsrrT3ncRS
   NRTMqKR9WpI21Mxd7/4s2iCek6u5h4JjLVYJI9HDDpH26hdihT7KIHVzs
   0kZYGmIGjx+N2k69AL791spIkFtRaa6nt+nKFIyJURKhoWtQnvqttTorU
   NlrpcS2lL437G7IBo1X9SogmKAybH2ceRcIIqEulm5OMcO7EpwhbCGHmL
   d1PpFLSv2AIYBWdfaU+sPbbcpApvlboyTHOsh9A5ttCJmskwG2irThEi5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="338412461"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="338412461"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 02:23:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="951383409"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="951383409"
Received: from emontau-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.42.201])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 02:22:59 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [RESEND PATCH] drm/i915: constify pointers to hwmon_channel_info
In-Reply-To: <20230511175446.282041-1-krzysztof.kozlowski@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230511175446.282041-1-krzysztof.kozlowski@linaro.org>
Date:   Thu, 25 May 2023 12:22:57 +0300
Message-ID: <87a5xskbny.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> Statically allocated array of pointers to hwmon_channel_info can be made
> const for safety.

Btw if you want to further make things const, the compound literals
defined by HWMON_CHANNEL_INFO() still end up mutable, even if they're
only referenced inline using a const pointer. If possible, would be nice
to add const there too.

BR,
Jani.

>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/gpu/drm/i915/i915_hwmon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_hwmon.c b/drivers/gpu/drm/i915/i915_hwmon.c
> index 8e7dccc8d3a0..e99e8c97ef01 100644
> --- a/drivers/gpu/drm/i915/i915_hwmon.c
> +++ b/drivers/gpu/drm/i915/i915_hwmon.c
> @@ -267,7 +267,7 @@ static const struct attribute_group *hwm_groups[] = {
>  	NULL
>  };
>  
> -static const struct hwmon_channel_info *hwm_info[] = {
> +static const struct hwmon_channel_info * const hwm_info[] = {
>  	HWMON_CHANNEL_INFO(in, HWMON_I_INPUT),
>  	HWMON_CHANNEL_INFO(power, HWMON_P_MAX | HWMON_P_RATED_MAX | HWMON_P_CRIT),
>  	HWMON_CHANNEL_INFO(energy, HWMON_E_INPUT),
> @@ -275,7 +275,7 @@ static const struct hwmon_channel_info *hwm_info[] = {
>  	NULL
>  };
>  
> -static const struct hwmon_channel_info *hwm_gt_info[] = {
> +static const struct hwmon_channel_info * const hwm_gt_info[] = {
>  	HWMON_CHANNEL_INFO(energy, HWMON_E_INPUT),
>  	NULL
>  };

-- 
Jani Nikula, Intel Open Source Graphics Center
