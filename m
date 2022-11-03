Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4192E617E6A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiKCNvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiKCNvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:51:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD08B1F0;
        Thu,  3 Nov 2022 06:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667483469; x=1699019469;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=MdJs6GJxG+5C4y1kNW92hXKl7i8pmS2mGPoi5urTFW0=;
  b=gYYukWFSCIP2WEt2GE4LLlQX0WK5PL94cpE6ME0vqcpKuy29OXmlI3td
   M6DHb4T8tptA8vbhty8leC1VQR7fJHi3qVFXQP1teynuXBpL/x01uESob
   eKDvqhRoJozew6erezuQJt39cFU0akKukROFphPCWxf0OQXjDutYTu1//
   njMwx+I4ghwQIPpJQj6Y804jlym0cDwQusedPTIvaIy5GmH01YhodWTOz
   1IDm8pExUSKZNuYdgcwLDi7aU6X+VmwveY5mYXjvkqrKEE5uUkt4ytqt2
   xRS9cRgHxaf30FG6mVOtheXyOKnx9RHvdWUtg8D/NlTz5l8jeC7nV4/oM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="371786827"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="371786827"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 06:51:08 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="667972012"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="667972012"
Received: from jnikula-mobl4.fi.intel.com (HELO localhost) ([10.237.66.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 06:51:05 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/edid: make a couple of read-only arrays static const
In-Reply-To: <20221103133730.80940-1-colin.i.king@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20221103133730.80940-1-colin.i.king@gmail.com>
Date:   Thu, 03 Nov 2022 15:51:01 +0200
Message-ID: <87o7tob0ze.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Nov 2022, Colin Ian King <colin.i.king@gmail.com> wrote:
> Don't populate two read-only arrays on the stack but instead make
> them static const . Also makes the object code a little smaller.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/drm_edid.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 4671dc23abe0..50d488cc840e 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -3916,8 +3916,8 @@ static int drm_cvt_modes(struct drm_connector *connector,
>  	struct drm_display_mode *newmode;
>  	struct drm_device *dev = connector->dev;
>  	const struct cvt_timing *cvt;
> -	const int rates[] = { 60, 85, 75, 60, 50 };
> -	const u8 empty[3] = { 0, 0, 0 };
> +	static const int rates[] = { 60, 85, 75, 60, 50 };
> +	static const u8 empty[3] = { 0, 0, 0 };

The change is fine per se, but I think this whole array is silly. Could
be removed with:

-		if (!memcmp(cvt->code, empty, 3))
+		if (!memchr_inv(cvt->code, 0, sizeof(cvt->code)))


BR,
Jani.

PS. I also note that rates[0] is never used, but that's another story,
maybe a bug.


>  
>  	for (i = 0; i < 4; i++) {
>  		int width, height;

-- 
Jani Nikula, Intel Open Source Graphics Center
