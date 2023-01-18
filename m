Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABD0670F9C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjARBKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjARBJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:09:50 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DD03E081;
        Tue, 17 Jan 2023 17:04:22 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3244010B;
        Wed, 18 Jan 2023 02:04:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674003860;
        bh=8dYvO7RCDj5YepsmKT3DATpCzMC+EsJ6lY6n3joXjiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iEJF85dTwRd2SKEz/INYvREepJ+tbVFmoIACgIBCALIyeTE0k3msphA9l5MGxlt54
         bqJC3z6fGU2OHGd2ga2j3dWCBhtoTXcpmFzTZRDOW3bgVjOxyhvOVjjyuk9aHFN0TX
         I5J7eP2KdsurHJZb8/MlvI9K8z2+FxyYNCyWKB/o=
Date:   Wed, 18 Jan 2023 03:04:20 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Brown <broonie@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/6] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver user interace
Message-ID: <Y8dFlFkVJS/6+Ib1@pendragon.ideasonboard.com>
References: <20230111022433.25950-1-yuji2.ishikawa@toshiba.co.jp>
 <20230111022433.25950-4-yuji2.ishikawa@toshiba.co.jp>
 <2b412539-2236-b41f-c777-bc9e9cf99d66@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b412539-2236-b41f-c777-bc9e9cf99d66@xs4all.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jan 17, 2023 at 12:47:10PM +0100, Hans Verkuil wrote:
> More comments below:
> 
> On 11/01/2023 03:24, Yuji Ishikawa wrote:
> > Add support to Video Input Interface on Toshiba Visconti ARM SoCs.
> > The interface device includes CSI2 Receiver,
> > frame grabber, video DMAC and image signal processor.
> > This patch provides the user interface layer.
> > 
> > A driver instance provides three /dev/videoX device files;
> > one for RGB image capture, another one for optional RGB capture
> > with different parameters and the last one for RAW capture.
> > 
> > Through the device files, the driver provides streaming (DMA-BUF) interface.
> > A userland application should feed DMA-BUF instances for capture buffers.
> > 
> > The driver is based on media controller framework.
> > Its operations are roughly mapped to two subdrivers;
> > one for ISP and CSI2 receiver (yields 1 instance),
> > the other for capture (yields 3 instances for each capture mode).
> > 
> > Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> > ---
> > Changelog v2:
> > - Resend v1 because a patch exceeds size limit.
> > 
> > Changelog v3:
> > - Adapted to media control framework
> > - Introduced ISP subdevice, capture device
> > - Remove private IOCTLs and add vendor specific V4L2 controls
> > - Change function name avoiding camelcase and uppercase letters
> > 
> > Changelog v4:
> > - Split patches because the v3 patch exceeds size limit 
> > - Stop using ID number to identify driver instance:
> >   - Use dynamically allocated structure to hold HW specific context,
> >     instead of static one.
> >   - Call HW layer functions with the context structure instead of ID number
> > - Use pm_runtime to trigger initialization of HW
> >   along with open/close of device files.
> > 
> > Changelog v5:
> > - Fix coding style problems in viif.c
> > ---
> >  drivers/media/platform/visconti/Makefile      |    1 +
> >  drivers/media/platform/visconti/viif.c        |  545 ++++++++
> >  drivers/media/platform/visconti/viif.h        |  203 +++
> >  .../media/platform/visconti/viif_capture.c    | 1201 +++++++++++++++++
> >  drivers/media/platform/visconti/viif_isp.c    |  846 ++++++++++++
> >  5 files changed, 2796 insertions(+)
> >  create mode 100644 drivers/media/platform/visconti/viif.c
> >  create mode 100644 drivers/media/platform/visconti/viif.h
> >  create mode 100644 drivers/media/platform/visconti/viif_capture.c
> >  create mode 100644 drivers/media/platform/visconti/viif_isp.c

[snip]

> > +static int viif_s_edid(struct file *file, void *fh, struct v4l2_edid *edid)
> > +{
> > +	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
> > +	struct viif_subdev *viif_sd = viif_dev->sd;
> > +
> > +	return v4l2_subdev_call(viif_sd->v4l2_sd, pad, set_edid, edid);
> > +}
> 
> Has this driver been tested with an HDMI receiver? If not, then I would recommend
> dropping support for it until you actually can test with such hardware.
> 
> The DV_TIMINGS API is for HDMI/DVI/DisplayPort etc. interfaces, it's not meant
> for CSI and similar interfaces.

More than that, for MC-based drivers, the video node should *never*
forward ioctls to a connected subdev. The *only* valid calls to
v4l2_subdev_call() in this file are

- to video.s_stream() in the start and stop streaming handler

- to pad.g_fmt() when starting streaming to validate that the connected
  subdev outputs a format compatible with the format set on the video
  capture device

That's it, nothing else, all other calls to v4l2_subdev_call() must be
dropped from the implementation of the video_device.

[snip]

-- 
Regards,

Laurent Pinchart
