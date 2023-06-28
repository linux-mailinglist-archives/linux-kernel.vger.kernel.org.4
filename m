Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709CB740BA6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbjF1IhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:37:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:39906 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234476AbjF1Idw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687941232; x=1719477232;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=BXkseK/7Ha+I5qFw0bg5W7x6wKpug2h9qv3tmbroptE=;
  b=dY5fQYXUHKNGtQw6TWceHifBgT75dJByEOaXUlDkWKUmjgk0KIINYcBz
   N6sdV8ZzZxARUPiygb6IEe+4lpuTw5owiBBaRhiTBsBSsEW7APfPCE7il
   h6Kl5ff2tDq52bCcepW/u7QmoEOqCTQ19H8jRCrI0YJeFFSNRRDToUcaB
   pXit2FjkbGBrl637j6NZsyFOhxrkRLp01Bj566CkCJdqMzswzXL7osPqp
   ZffZG9hhJ7moGfSj1lseJPMpTFfWeaTVVszGwnm+L8XOmzC2NSw8S9jE8
   y9jp9LR4wtRjpeLE2oB5JqDCzbsbCw7xVsaOQKPtNqnE/CJyQIVhfqwQJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="360637123"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="360637123"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 01:25:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="840980913"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="840980913"
Received: from lzhiguno-mobl.ger.corp.intel.com (HELO localhost) ([10.252.63.165])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 01:25:44 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/edid: make read-only const array static
In-Reply-To: <20230627170109.751829-1-colin.i.king@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230627170109.751829-1-colin.i.king@gmail.com>
Date:   Wed, 28 Jun 2023 11:25:26 +0300
Message-ID: <87ttusro21.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2023, Colin Ian King <colin.i.king@gmail.com> wrote:
> Don't populate the const array on the stack, instead make it static.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks, pushed to drm-misc-next.

> ---
>  drivers/gpu/drm/drm_edid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index e0dbd9140726..39b13417b749 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -3962,7 +3962,7 @@ static int drm_cvt_modes(struct drm_connector *connector,
>  	struct drm_display_mode *newmode;
>  	struct drm_device *dev = connector->dev;
>  	const struct cvt_timing *cvt;
> -	const int rates[] = { 60, 85, 75, 60, 50 };
> +	static const int rates[] = { 60, 85, 75, 60, 50 };
>  	const u8 empty[3] = { 0, 0, 0 };

Side note, this could be removed by replacing

	if (!memcmp(cvt->code, empty, 3))

with

	if (!memchr_inv(cvt->code, 0, 3))

or even

	if (!cvt->code[0] && !cvt->code[1] && !cvt->code[2])

BR,
Jani.

>  
>  	for (i = 0; i < 4; i++) {

-- 
Jani Nikula, Intel Open Source Graphics Center
