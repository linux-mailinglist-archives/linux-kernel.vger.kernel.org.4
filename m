Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CCF667346
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjALNgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjALNfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:35:45 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72683AA;
        Thu, 12 Jan 2023 05:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673530544; x=1705066544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oNiJ90LGl00pb49yEp738vhct4gabvwjdHf7jjXxjOM=;
  b=e9wlLod7D9qy4cjRagUGXfPnplw1TEiOdNWkWM9KLeleo/1hHJYvRASg
   lYAbQGLWG9n9yKEtrR1r7HLdF44kCyw3EZdn9co4mAFxq3wdevDTuoOe+
   JOgDCjYfTHn5fm1DEvZTYIAB7Bn1N+DV3cH2O4q607OnWscdR0JCckgWa
   tjv8IWmyG+qXYoMVtMhrYX4Jl4FCfWhGGCido1U2GF/D8Gya8N0Y11GGy
   R5WrsUuE/ISAVG/iu3hWFXt/tIGoSrcstggCof0QHTEFacWK5mCaubJbz
   o3mv1SSCSLPMpG9TwpBAH6NyCu6udQ46A4MjORYVqPZM6d6EQ4EaibVGu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10587"; a="311528000"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="311528000"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 05:35:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10587"; a="765623305"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="765623305"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 05:35:28 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 107B72021A;
        Thu, 12 Jan 2023 15:35:26 +0200 (EET)
Date:   Thu, 12 Jan 2023 13:35:26 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        niklas.soderlund+renesas@ragnatech.se,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        satish.nagireddy@getcruise.com, Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v16 06/20] media: subdev: Require code change to enable
 [GS]_ROUTING
Message-ID: <Y8AMns140Eq3S7ER@paasikivi.fi.intel.com>
References: <20221215121634.287100-1-tomi.valkeinen@ideasonboard.com>
 <20221215121634.287100-7-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215121634.287100-7-tomi.valkeinen@ideasonboard.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moi,

On Thu, Dec 15, 2022 at 02:16:20PM +0200, Tomi Valkeinen wrote:
> Streams API is an experimental feature. To use Streams API, the user
> needs to change a variable in v4l2-subdev.c and recompile the kernel.
> 
> This commit should be reverted when the Streams API is deemed ready for
> production use.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 61b429016a2f..c31b44800e39 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -23,6 +23,13 @@
>  #include <media/v4l2-fh.h>
>  #include <media/v4l2-ioctl.h>
>  
> +/*
> + * Streams API is an experimental feature. To use Streams API, set
> + * 'v4l2_subdev_enable_streams_api' to 1 below.
> + */
> +
> +static bool v4l2_subdev_enable_streams_api = 0;

Static variables shouldn't be explicitly assigned to zero. I'll address
this while applying.

> +
>  /*
>   * Maximum stream ID is 63 for now, as we use u64 bitmask to represent a set
>   * of streams.
> @@ -751,6 +758,9 @@ static long subdev_do_ioctl(struct file *file, unsigned int cmd, void *arg,
>  		struct v4l2_subdev_routing *routing = arg;
>  		struct v4l2_subdev_krouting *krouting;
>  
> +		if (!v4l2_subdev_enable_streams_api)
> +			return -ENOIOCTLCMD;
> +
>  		if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
>  			return -ENOIOCTLCMD;
>  
> @@ -778,6 +788,9 @@ static long subdev_do_ioctl(struct file *file, unsigned int cmd, void *arg,
>  		struct v4l2_subdev_krouting krouting = {};
>  		unsigned int i;
>  
> +		if (!v4l2_subdev_enable_streams_api)
> +			return -ENOIOCTLCMD;
> +
>  		if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
>  			return -ENOIOCTLCMD;
>  

-- 
Terveisin,

Sakari Ailus
