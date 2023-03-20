Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501436C0CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjCTJA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjCTJAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:00:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA4C22DE2;
        Mon, 20 Mar 2023 02:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679302843; x=1710838843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y23nGeC8XGjSZ/6/uDVln0o7535QhkIE8p+eamnfZBM=;
  b=mSextLij9IQoc7HnITMp+74CNLsFss3XjSc4RpxWBGCkJftYcBaZlpkj
   XK26Ok8xI9BhxtovYV7i0ID0EAPhGTjusqEflQIDAUtMOo2/kyS3Pkp2/
   +15+SB8jeU9YevssswqG3WRBziBGAX34lWluDbqp8ETzOrOMK0wAa44Gr
   Op8ecpjfb0aSGTwjxL1kOZeGEQ+8E+Yd0Wpbhd/AIBU0C21Oln4zBOvND
   yp4sCmYxKCuadd8wK6QzGNrgRHndccEyC8mrOpQdLU8KtjsJtXGIP3OP3
   CLdSTTOYM6iF8Dz2kXvDMUohPVtkp88WR4eCvWpGf3Pt5oa1OOL47VAVn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="319011047"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="319011047"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 02:00:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="770119631"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="770119631"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 02:00:39 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 25BC4122400;
        Mon, 20 Mar 2023 11:00:36 +0200 (EET)
Date:   Mon, 20 Mar 2023 11:00:36 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-kernel@vger.kernel.org,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v2] media: i2c: ov5640: Implement get_mbus_config
Message-ID: <ZBggtBU1TjlvVNCS@kekkonen.localdomain>
References: <20230306063649.7387-1-marcel@ziswiler.com>
 <ZBBk+h3EMSsacZ6v@valkosipuli.retiisi.eu>
 <ZBBpUAhis8L5Dtuz@francesco-nb.int.toradex.com>
 <ZBBsgW75Gc2FmuQ0@valkosipuli.retiisi.eu>
 <ZBBvmjUZIn/g0/Nv@francesco-nb.int.toradex.com>
 <20230320084844.tdjiv6kaxcosiwm2@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320084844.tdjiv6kaxcosiwm2@uno.localdomain>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Mon, Mar 20, 2023 at 09:48:44AM +0100, Jacopo Mondi wrote:
> Hello
> 
> On Tue, Mar 14, 2023 at 01:59:06PM +0100, Francesco Dolcini wrote:
> > +Marco
> >
> > On Tue, Mar 14, 2023 at 02:45:53PM +0200, Sakari Ailus wrote:
> > > On Tue, Mar 14, 2023 at 01:32:16PM +0100, Francesco Dolcini wrote:
> > > > On Tue, Mar 14, 2023 at 02:13:46PM +0200, Sakari Ailus wrote:
> > > > > On Mon, Mar 06, 2023 at 07:36:49AM +0100, Marcel Ziswiler wrote:
> > > > > > From: Aishwarya Kothari <aishwarya.kothari@toradex.com>
> > > > > >
> > > > > > Implement the introduced get_mbus_config operation to report the
> > > > > > config of the MIPI CSI-2, BT.656 and Parallel interface.
> > > > > >
> > > > > > Signed-off-by: Aishwarya Kothari <aishwarya.kothari@toradex.com>
> > > > > > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > > >
> > > > > What's the reasoning for this patch?
> > > >
> > > > Without this it's not possible to use it on i.MX6,
> > > > drivers/staging/media/imx/imx6-mipi-csi2.c requires it, some more
> > > > details from Jacopo here [0].
> > > >
> > > > Everything used to work fine up to v5.18, after that kernel version
> > > > various changes broke it [1][2] (I assume you are pretty much aware of
> > > > the history here, you commented on a few emails).
> > > >
> > > > [0] https://lore.kernel.org/all/20230128100611.7ulsfqqqgscg54gy@uno.localdomain/
> > > > [1] https://lore.kernel.org/all/081cc2d3-1f3a-6c14-6dc7-53f976be7b2b@gmail.com/
> > > > [2] https://lore.kernel.org/all/cacfe146-101b-35b3-5f66-1a1cabfd342f@gmail.com/
> > > >
> > > > > Drivers that don't have e.g. dynamic lane configuration shouldn't need to
> > > > > implement get_mbus_config.
> > >
> > > Not even for staging drivers. The driver should be fixed to get that
> > > information from the endpoint instead.
> >
> > This seems exactly the opposite of what commit
> > 7318abface48 ("media: imx: Use get_mbus_config instead of parsing upstream DT endpoints")
> > did.
> >
> > Given that I am somehow confused, but I am not that familiar with this
> > subsystem, so I guess this is expected :-). Can someone provide some
> > additional hint here?
> >
> 
> As per my understanding, the i.MX6 IPU CSI driver connects to the
> CSI-2 receiver and/or two video muxes. One figure's worth a thousands
> words: "Figure 19-1. CSI2IPU gasket connectivity" of the IMX6DQRM TRM.

I don't have that document.

> 
> So the local endpoint might not provide the required information on
> the bus configuration as it connects to a video-mux.
> 
> That's why the imx_media_pipeline_subdev() helper is used in
> csi_get_upstream_mbus_config().
> 
> My gut feeling is that it would be better to always call
> get_mbus_config() on the next subdev (the mux or the CSI-2 rx) and
> there parse the local endpoint as it's the mux or the CSI-2 rx that
> connect to the actual source.

Isn't this still a different endpoint in DT? I understand you have a single
pad with two links?

-- 
Kind regards,

Sakari Ailus
