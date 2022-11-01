Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F066614615
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 09:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiKAI5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 04:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiKAI5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 04:57:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D54A186F3;
        Tue,  1 Nov 2022 01:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667293061; x=1698829061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=msnEZkv3YQ45VUNdt3VQyEvi87+GNc4MrWptBr/Uq0I=;
  b=mz7L7Ruf5CToUEAY8QuwOSVAYGKh7zSKoqvXwHU++JKoSipgEzog7scb
   dzLQ2HiNLN81gCWmTi7Kh682HHioxZ9uZmohIrMWiYOuILl1FmjvzxW3Q
   J7CpkQnSPvVkcmEUIW8WWrT13SXDdpwwNjOpbh2W8d4dKSAHuRN3hKrpr
   U4tWaEMSQVj5rOxB/obheVexWOepe3mu+oRtZRBHtxcxTW3VmWhzwVdz1
   f796HbFX9PoSIvu6g0155m9sPa9qKeE2vg5b31KQYqrwqoNPCOacBpoID
   UqvNLJUOoMS+zOaDuC7SdBrteZfdJAinEhQS+q3qQ+K6EyF+B7tr5MOo8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="309095587"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="309095587"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 01:57:41 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="697337066"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="697337066"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 01:57:37 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id B8EF220207;
        Tue,  1 Nov 2022 10:57:34 +0200 (EET)
Date:   Tue, 1 Nov 2022 08:57:34 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 4/4] media: platform: Add Renesas RZ/G2L CRU driver
Message-ID: <Y2Dffvzr24FCG1Lw@paasikivi.fi.intel.com>
References: <20221027103104.74576-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221027103104.74576-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y1qCbUoLrR6qlQwa@paasikivi.fi.intel.com>
 <CA+V-a8seroka4YkyCnSYa2KMPDWMG1Zk8tyiqRntdPUQnc+nrA@mail.gmail.com>
 <Y1vJbJfFjV9jRNzz@paasikivi.fi.intel.com>
 <CA+V-a8tONhJ1_x3T7+6n7tu=xyFBZfsqT2v3iUGd2Jy5_NuZCg@mail.gmail.com>
 <Y1+FFD4/XCY8HyYa@paasikivi.fi.intel.com>
 <CA+V-a8sKb4em07S5bYfe9RsgBnp3WDhf6bHu38LfuB2g+iJYZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8sKb4em07S5bYfe9RsgBnp3WDhf6bHu38LfuB2g+iJYZg@mail.gmail.com>
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Mon, Oct 31, 2022 at 12:40:28PM +0000, Lad, Prabhakar wrote:
> Hi Sakari,
> 
> On Mon, Oct 31, 2022 at 8:19 AM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Prabhakar,
> >
> > On Sun, Oct 30, 2022 at 10:32:43PM +0000, Lad, Prabhakar wrote:
> > > Hi Sakari,
> > >
> > > On Fri, Oct 28, 2022 at 1:22 PM Sakari Ailus
> > > <sakari.ailus@linux.intel.com> wrote:
> > > >
> > > > Hi Prabhakar,
> > > >
> > > > On Thu, Oct 27, 2022 at 08:04:40PM +0100, Lad, Prabhakar wrote:
> > > > ...
> > > > > > > +static int rzg2l_cru_ip_s_stream(struct v4l2_subdev *sd, int enable)
> > > > > > > +{
> > > > > > > +     struct rzg2l_cru_dev *cru;
> > > > > > > +     int ret;
> > > > > > > +
> > > > > > > +     cru = v4l2_get_subdevdata(sd);
> > > > > > > +
> > > > > > > +     if (!cru->is_csi)
> > > > > > > +             return -EINVAL;
> > > > > > > +
> > > > > > > +     ret = v4l2_subdev_call(cru->ip.remote, video, s_stream, enable);
> > > > > >
> > > > > > It's up to the driver how call pre_streamon() and post_streamoff(), as long
> > > > > > as it takes place on both sides of s_stream().
> > > > > >
> > > > > > In other words, as it seems your device doesn't need anything special, you
> > > > > > could waive implemeting the callbacks yourself and call pre_streamon() and
> > > > > > post_streamoff() here.
> > > > > >
> > > > > Here the cru->ip.remote = CSI, in the rzg2l_cru_set_stream(1) where we
> > > > > are calling pre_streamon()/post_streamoff() callbacks the subdev is
> > > > > CRU-IP. So the calls from rzg2l_cru_set_stream() land into
> > > > > rzg2l_cru_ip_pre_streamon() and rzg2l_cru_ip_post_streamoff() which
> > > > > are calling pre_streamon/post_streamoff for the CSI subdev.
> > > >
> > > > Again, you should call the source sub-device's pre_streamon and
> > > > post_streamoff from the s_stream handler (not from
> > > > rzg2l_cru_ip_pre_streamon or rzg2l_cru_ip_post_streamoff).
> > > >
> > > > Starting streaming takes place link by link. This allows a driver to omit
> > > > implementing pre_streamon and post_streamon callbacks if it doesn't need
> > > > them.
> > > >
> > > Thank you for the explanation that makes sense now to me.
> > >
> > > Now with this approach the initialization sequence of CSI + CRU won't
> > > align as per the HW manual. Unfortunately I'll have to switch back on
> > > exporting the functions. I hope that's okay?
> >
> > It is not.
> >
> > What exactly would you like to do that you can't with the
> > pre_streamon/post_streamoff callbacks called from s_stream?
> >
> The initialization sequence for MIPI CSI [0]. As per [0] we need to
> initialize the CSI2 dphy first then setup the AXI (part of CRU driver)
> and then later MIPI CSI2 link (part of csi driver) and lastly turn on
> clock and link (in the cru driver).
> 
> So as per the current implementation we have the below:
> 1] CRU IP subdev is calling pre_stream for the CSI2 subdev in its
> pre_stream on callback - This is where the CSI2 DPHY is initialized
> 2] Later in the flow we initialize the AXI part - ie part of
> rzg2l_cru_set_stream
> 3] We call s_stream in rzg2l_cru_set_stream - This lands into CSI2
> subdev to initialize the MIPI CSI2 Link
> 4] In the rzg2l_cru_set_stream we setup up the vclk and enable link reception
> 
> [0] https://ibb.co/QpHNkLh

How is this changed by calling the pre_streamon/post_streamoff callbacks
from s_stream? I understand the pipeline device-wise is:

	... -> CSI-2 -> CRU

I wonder if it would be faster to discuss this on #linux-media.

-- 
Kind regards,

Sakari Ailus
