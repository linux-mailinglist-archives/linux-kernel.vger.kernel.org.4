Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959F265CD8E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 08:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbjADHVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 02:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjADHVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 02:21:09 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A95FF04;
        Tue,  3 Jan 2023 23:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672816865; x=1704352865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7liNCCRrFXPCHaux0+GTNz9npfiWKG1pQ2+rp8wmVNs=;
  b=R33U12flHIz+tCCfIIq60q/CoZEjObvGqxf3tobC85T/Iq4MogR8l0Zt
   43bCb1KA033W3mhlEJVXVyYKfb+xctFhVBwydCJqtkZCB0fKBo4cC711p
   rW3DdufaVP7Gvnsz6umNwHsOs/trfn5VFVjX0pVXMEwq/fna5r+oYPoJS
   4X+BWbMDXYoNhVxSCHr6USUSk9r/hOiX94obHhLyvE2Pg8rew+urKvR0x
   b/EXXU9ICFlzLJpr9oI26w6HAGdEmKrYVILI2YD0U7SQEE0gNF1hqecKr
   9+aI5ZdrXPtGOVNU/gV0xaqUqHhH2xSnnwyH1Fr+XoDRAF2RFRp+jFilN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="302234725"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="302234725"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 23:21:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="687447285"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="687447285"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 23:21:02 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 18480202DD;
        Wed,  4 Jan 2023 09:21:00 +0200 (EET)
Date:   Wed, 4 Jan 2023 07:21:00 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Robert Mader <robert.mader@collabora.com>,
        linux-kernel@vger.kernel.org, nicholas@rothemail.net,
        javierm@redhat.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: i2c: imx258: Parse and register properties
Message-ID: <Y7Uo3JlOoGJAoorz@paasikivi.fi.intel.com>
References: <20221225154234.378555-1-robert.mader@collabora.com>
 <20230102140631.hadlh3stozecnzpj@uno.localdomain>
 <20f405f3-0a82-5d2f-2b0d-ce0d510b5098@collabora.com>
 <20230103171624.qx6hm2exs3d5lg53@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230103171624.qx6hm2exs3d5lg53@uno.localdomain>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo, Robert,

On Tue, Jan 03, 2023 at 06:16:24PM +0100, Jacopo Mondi wrote:
> Hi Robert
> 
> On Tue, Jan 03, 2023 at 03:11:44PM +0100, Robert Mader wrote:
> > On 02.01.23 15:06, Jacopo Mondi wrote:
> > > Hi Robert
> > >
> > > On Sun, Dec 25, 2022 at 04:42:34PM +0100, Robert Mader wrote:
> > > > Analogous to e.g. the imx219. This enables propagating
> > > > V4L2_CID_CAMERA_SENSOR_ROTATION values so that libcamera
> > > > can detect the correct rotation from the device tree
> > > > and propagate it further to e.g. Pipewire.
> > > >
> > > > Signed-off-by: Robert Mader <robert.mader@collabora.com>
> > > > ---
> > > >   drivers/media/i2c/imx258.c | 13 ++++++++++++-
> > > >   1 file changed, 12 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
> > > > index eab5fc1ee2f7..85819043d1e3 100644
> > > > --- a/drivers/media/i2c/imx258.c
> > > > +++ b/drivers/media/i2c/imx258.c
> > > > @@ -9,6 +9,7 @@
> > > >   #include <linux/pm_runtime.h>
> > > >   #include <media/v4l2-ctrls.h>
> > > >   #include <media/v4l2-device.h>
> > > > +#include <media/v4l2-fwnode.h>
> > > >   #include <asm/unaligned.h>
> > > >
> > > >   #define IMX258_REG_VALUE_08BIT		1
> > > > @@ -1149,6 +1150,7 @@ static int imx258_init_controls(struct imx258 *imx258)
> > > >   {
> > > >   	struct i2c_client *client = v4l2_get_subdevdata(&imx258->sd);
> > > >   	struct v4l2_ctrl_handler *ctrl_hdlr;
> > > > +	struct v4l2_fwnode_device_properties props;
> > > Might be nicer to move this one line up
> >
> >  Can you say what's your reasoning? I personally slightly prefer
> > alphabetical order, but no strong opinion :)
> >
> 
> I've often been instructed to try to respect the inverse-xmas-tree

I'd advise the same, unless there are other reasons to arrange the lines
differently.

-- 
Kind regards,

Sakari Ailus
