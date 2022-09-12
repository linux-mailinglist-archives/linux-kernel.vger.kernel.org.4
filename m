Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D863C5B55B8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiILIIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiILIId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:08:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC6F2B24B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662970111; x=1694506111;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=s7Jug/OnMCFhyd1q5xTwD79VDV4Ia8xhw4W5pOzqF7Q=;
  b=ethQGijyqTohSm8m8ZEA7E4M8X2FtWC2R9X1m1iBUIK7W4rqzlkvMf6T
   vmC3MEsc/6IN2Sljtcu86DmsaMXPJnopB9yWBkFQAYuwgMNLjJMiLO7tY
   E09LuuCTsOp1z1TGexyGipC/7L+ZZrgNZL3OeGbKMKDYQxLMObonR8IDK
   tQ2l/TaL4XQiZJ/cmy/rWWHm+4SNAS0zmZUYFpk5KQzy6ea2ewXuNgNN9
   QLyp3AVQpF2S6V9WiHFKSkiCosgei7p9dUyJ+rhdW1jVSeAv2rjwzJFhL
   MJwlyp2gvMwW7fMZPQ9Fw/fBi8y1XIHfHWBl2hg5TqfaO71IxA5ztHdZU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="296545692"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="296545692"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 01:08:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="646358310"
Received: from abijaz-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.140])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 01:08:24 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Hamza Mahfooz <someguy@effective-light.com>,
        linux-kernel@vger.kernel.org
Cc:     Hamza Mahfooz <someguy@effective-light.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Allen Chen <allen.chen@ite.com.tw>,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Hermes Wu <hermes.wu@ite.com.tw>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] drm/bridge: it6505: use drm_debug_enabled() in
 it6505_debug_print()
In-Reply-To: <20220910224816.15058-1-someguy@effective-light.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220910224816.15058-1-someguy@effective-light.com>
Date:   Mon, 12 Sep 2022 11:08:19 +0300
Message-ID: <875yht6mmk.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Sep 2022, Hamza Mahfooz <someguy@effective-light.com> wrote:
> As made mention of in commit 9f0ac028410f ("drm/print: rename drm_debug
> to __drm_debug to discourage use"), we shouldn't explicitly refer to
> __drm_debug in this context. So, use drm_debug_enabled() instead.
>
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index 4b673c4792d7..875f87c576cb 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -554,7 +554,7 @@ static void it6505_debug_print(struct it6505 *it6505, unsigned int reg,
>  	struct device *dev = &it6505->client->dev;
>  	int val;
>  
> -	if (likely(!(__drm_debug & DRM_UT_DRIVER)))
> +	if (!drm_debug_enabled(DRM_UT_DRIVER))
>  		return;
>  
>  	val = it6505_read(it6505, reg);

-- 
Jani Nikula, Intel Open Source Graphics Center
