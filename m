Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D819725707
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238579AbjFGIMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbjFGIMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:12:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882F295
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686125542; x=1717661542;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=MLXJN8f1wgeJvba3Z+b92UH3LzPWiFgfUtqTwlhYIpI=;
  b=CW+ZTq3VAR6TPPRA4o7DDToqUczr7xR2VpjhV6PWdugecT5IAEFVLFKq
   1Hxq40WXyCMPRnLKg+Dgq0L9nhFCfSzGPQs3j9p0ReluOSjoQDz7AM8M6
   mQL+jbIAF8avph4Vy3LBsJnLMskgQyNAnWHWfrLBJ3WOum02lHP+1xq+r
   Kpz1AygP25oatylBUck/iz6NFqQMWzLU0VUzVW+5msBw7r7alKLal6oLI
   jjq6XzRcIjQ7VZcbkZWDycew9JsnBrlTJ6GgQRVZFNddpxheQlA7LeTNX
   QNzbPkcn4swnfShHYPUPirgO8ELnOtDsazOtLwP4wowBhxo8MeXie120x
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="336544331"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="336544331"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 01:12:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="956122146"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="956122146"
Received: from nnesher-mobl.ger.corp.intel.com (HELO localhost) ([10.252.57.222])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 01:12:18 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Siddh Raman Pant <code@siddh.me>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Suraj Upadhyay <usuraj35@gmail.com>
Subject: Re: [PATCH v9 8/8] drm: Remove usage of deprecated DRM_DEBUG_KMS
In-Reply-To: <20230607035351.GD14101@pendragon.ideasonboard.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1686047727.git.code@siddh.me>
 <35bd95856a69f141640c27ea2b5e4073275032f7.1686047727.git.code@siddh.me>
 <20230606150419.GI5197@pendragon.ideasonboard.com>
 <87mt1ctgm7.fsf@intel.com>
 <20230607035351.GD14101@pendragon.ideasonboard.com>
Date:   Wed, 07 Jun 2023 11:12:16 +0300
Message-ID: <87jzwfu1wf.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jun 2023, Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:
> Hi Jani,
>
> On Wed, Jun 07, 2023 at 12:39:44AM +0300, Jani Nikula wrote:
>> On Tue, 06 Jun 2023, Laurent Pinchart wrote:
>> > On Tue, Jun 06, 2023 at 04:15:22PM +0530, Siddh Raman Pant wrote:
>> >> @@ -777,7 +793,7 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
>> >>  	int i, ret = 0;
>> >>  	bool *enabled;
>> >>  
>> >> -	DRM_DEBUG_KMS("\n");
>> >> +	drm_dbg_kms(dev, "\n");
>> >
>> > This message is pretty useless, it could be dropped on top of this
>> > series.
>> 
>> They do debug log the function being called.
>
> I overlooked the fact that ___drm_dbg() prints the caller's function
> name using __builtin_return_address(). It thus has marginally more value
> than I thought. Still, function tracing is best performed with ftrace().

I'm not going to argue this one too much, but it can be quite a step
getting a random bug reporter from providing dmesgs to running ftrace.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
