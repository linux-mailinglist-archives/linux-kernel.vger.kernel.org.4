Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6EB5FFC0D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 23:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiJOVfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 17:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJOVfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 17:35:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6671706E;
        Sat, 15 Oct 2022 14:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665869719; x=1697405719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sJcP+LbO0ZLDOWu1LF79CWq8dOfjS9dwwRttTrWwSNw=;
  b=XaqeQIDZ/ihXkzrD8k0ff6bxTccR/3OYWTufjjTMkVc8qMSeUEaUIpSx
   7n3flrT5m6u3DdV1gOrI2ZRP+Afr+KCU/ADDRDsvROi+QehK8uExfhqT1
   dT0vMcd8SRZEA1mN9jXWw801KsktnRL/ngrt4J/YMstMJ5/ISvcc7z53I
   YzmaHkiFiKqbsraA/bgwb/HYWj7OCjm/Cx0ZCxk754nRzJrPhQbIT00ia
   ASKPd4gEPzttgee/Nt+Bm5rygkNxor3u2sD0BQKbVeQeLj//aEvE9nffN
   JoZRIVFrQAq21k93wUt9pL/HCxoCOyGLQxCDhSNoT+lTMCf0aWx6/Vcbe
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10501"; a="304317422"
X-IronPort-AV: E=Sophos;i="5.95,188,1661842800"; 
   d="scan'208";a="304317422"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2022 14:35:18 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10501"; a="578973906"
X-IronPort-AV: E=Sophos;i="5.95,188,1661842800"; 
   d="scan'208";a="578973906"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2022 14:35:15 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 808AF20244;
        Sun, 16 Oct 2022 00:35:12 +0300 (EEST)
Date:   Sat, 15 Oct 2022 21:35:12 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 4/5] media: i2c: ov5645: Return zero for s_stream(0)
Message-ID: <Y0snkMEp9WqGtzom@paasikivi.fi.intel.com>
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221014183459.181567-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y0pSYfw+VDxXv85b@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0pSYfw+VDxXv85b@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Sat, Oct 15, 2022 at 09:25:37AM +0300, Laurent Pinchart wrote:
> Hi Prabhakar,
> 
> Thank you for the patch.
> 
> On Fri, Oct 14, 2022 at 07:34:58PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > 
> > Always return zero while stopping the stream as the caller will ignore the
> > return value.
> > 
> > This patch drops checking the return value of ov5645_write_reg() and
> > continues further in the code path while stopping stream. The user anyway
> > gets an error message in case ov5645_write_reg() fails.
> 
> Continuing all the way to pm_runtime_put() is fine, but I don't think
> the function should return 0. It's not up to the driver to decide if a
> failure would be useful to signal to the caller or not.

If the function returns an error when disabling streaming, what is the
expected power state of the device after this?

The contract between the caller and the callee is that the state is not
changed if there is an error. This is a special case as very few callers
check the return value for streamoff operation and those that do generally
just print something. I've never seen a caller trying to prevent streaming
off in this case, for instance.

Of course we could document that streaming off always counts as succeeded
(e.g. decreasing device's runtime PM usage_count) while it could return an
informational error code. But I wonder if anyone would ever benefit from
that somehow. :-)

> 
> > Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2
> > * New patch
> > ---
> >  drivers/media/i2c/ov5645.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
> > index a0b9d0c43b78..b3825294aaf1 100644
> > --- a/drivers/media/i2c/ov5645.c
> > +++ b/drivers/media/i2c/ov5645.c
> > @@ -995,14 +995,11 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
> >  		if (ret < 0)
> >  			goto err_rpm_put;
> >  	} else {
> > -		ret = ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x40);
> > -		if (ret < 0)
> > -			return ret;
> > +		ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x40);
> > +
> > +		ov5645_write_reg(ov5645, OV5645_SYSTEM_CTRL0,
> > +				 OV5645_SYSTEM_CTRL0_STOP);
> >  
> > -		ret = ov5645_write_reg(ov5645, OV5645_SYSTEM_CTRL0,
> > -				       OV5645_SYSTEM_CTRL0_STOP);
> > -		if (ret < 0)
> > -			return ret;
> >  		pm_runtime_put(ov5645->dev);
> >  	}
> >  
> 

-- 
Regards,

Sakari Ailus
