Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC1E67D6CC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjAZUtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjAZUtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:49:39 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0AF171B;
        Thu, 26 Jan 2023 12:49:38 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F140B975;
        Thu, 26 Jan 2023 21:49:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674766177;
        bh=rN41aOWNI6OikK4Y1EV7H5icYuk6/XOyB8mR7h94T+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rZX2itZNzbJ3NbVEquvYOryK8/XgzZc908dZZ14G488wdDwL3WKLJ7nyWBlNMc5JA
         HLjfoJ3rvsOSBnbYqFFPQ9sOK6izHHgpf5q8qF7Zkbnbw2taX8TFp+bMZ1TlhtwSFe
         p8IhaXuSPCUUKAQUdKeyXaP2ZsZH4T/YcIuiq+SI=
Date:   Thu, 26 Jan 2023 22:49:29 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     yuji2.ishikawa@toshiba.co.jp
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org,
        nobuhiro1.iwamatsu@toshiba.co.jp, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rafael.j.wysocki@intel.com,
        broonie@kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/6] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver user interace
Message-ID: <Y9LnWfZb+v17+h+X@pendragon.ideasonboard.com>
References: <20230111022433.25950-1-yuji2.ishikawa@toshiba.co.jp>
 <20230111022433.25950-4-yuji2.ishikawa@toshiba.co.jp>
 <2b412539-2236-b41f-c777-bc9e9cf99d66@xs4all.nl>
 <Y8dFlFkVJS/6+Ib1@pendragon.ideasonboard.com>
 <TYAPR01MB620161823BA912502CEF0A5992CE9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TYAPR01MB620161823BA912502CEF0A5992CE9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ishikawa-san,

On Wed, Jan 25, 2023 at 10:20:27AM +0000, yuji2.ishikawa@toshiba.co.jp wrote:
> On Wednesday, January 18, 2023 10:04 AM, Laurent Pinchart wrote:
> > On Tue, Jan 17, 2023 at 12:47:10PM +0100, Hans Verkuil wrote:
> > > On 11/01/2023 03:24, Yuji Ishikawa wrote:
> > > > Add support to Video Input Interface on Toshiba Visconti ARM SoCs.
> > > > The interface device includes CSI2 Receiver, frame grabber, video
> > > > DMAC and image signal processor.
> > > > This patch provides the user interface layer.
> > > >
> > > > A driver instance provides three /dev/videoX device files; one for
> > > > RGB image capture, another one for optional RGB capture with
> > > > different parameters and the last one for RAW capture.
> > > >
> > > > Through the device files, the driver provides streaming (DMA-BUF) interface.
> > > > A userland application should feed DMA-BUF instances for capture buffers.
> > > >
> > > > The driver is based on media controller framework.
> > > > Its operations are roughly mapped to two subdrivers; one for ISP and
> > > > CSI2 receiver (yields 1 instance), the other for capture (yields 3
> > > > instances for each capture mode).
> > > >
> > > > Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> > > > ---
> > > > Changelog v2:
> > > > - Resend v1 because a patch exceeds size limit.
> > > >
> > > > Changelog v3:
> > > > - Adapted to media control framework
> > > > - Introduced ISP subdevice, capture device
> > > > - Remove private IOCTLs and add vendor specific V4L2 controls
> > > > - Change function name avoiding camelcase and uppercase letters
> > > >
> > > > Changelog v4:
> > > > - Split patches because the v3 patch exceeds size limit
> > > > - Stop using ID number to identify driver instance:
> > > >   - Use dynamically allocated structure to hold HW specific context,
> > > >     instead of static one.
> > > >   - Call HW layer functions with the context structure instead of ID
> > > > number
> > > > - Use pm_runtime to trigger initialization of HW
> > > >   along with open/close of device files.
> > > >
> > > > Changelog v5:
> > > > - Fix coding style problems in viif.c
> > > > ---
> > > >  drivers/media/platform/visconti/Makefile      |    1 +
> > > >  drivers/media/platform/visconti/viif.c        |  545 ++++++++
> > > >  drivers/media/platform/visconti/viif.h        |  203 +++
> > > >  .../media/platform/visconti/viif_capture.c    | 1201 +++++++++++++++++
> > > >  drivers/media/platform/visconti/viif_isp.c    |  846 ++++++++++++
> > > >  5 files changed, 2796 insertions(+)  create mode 100644
> > > > drivers/media/platform/visconti/viif.c
> > > >  create mode 100644 drivers/media/platform/visconti/viif.h
> > > >  create mode 100644 drivers/media/platform/visconti/viif_capture.c
> > > >  create mode 100644 drivers/media/platform/visconti/viif_isp.c
> > 
> > [snip]
> > 
> > > > +static int viif_s_edid(struct file *file, void *fh, struct
> > > > +v4l2_edid *edid) {
> > > > +	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
> > > > +	struct viif_subdev *viif_sd = viif_dev->sd;
> > > > +
> > > > +	return v4l2_subdev_call(viif_sd->v4l2_sd, pad, set_edid, edid); }
> > >
> > > Has this driver been tested with an HDMI receiver? If not, then I
> > > would recommend dropping support for it until you actually can
> > > test with such hardware.
> > >
> > > The DV_TIMINGS API is for HDMI/DVI/DisplayPort etc. interfaces, it's
> > > not meant for CSI and similar interfaces.
> > 
> > More than that, for MC-based drivers, the video node should *never* forward
> > ioctls to a connected subdev. The *only* valid calls to
> > v4l2_subdev_call() in this file are
> > 
> > - to video.s_stream() in the start and stop streaming handler
> > 
> > - to pad.g_fmt() when starting streaming to validate that the connected
> >   subdev outputs a format compatible with the format set on the video
> >   capture device
> > 
> > That's it, nothing else, all other calls to v4l2_subdev_call() must be dropped from
> > the implementation of the video_device.
> 
> Thank you for your comment. I understand the restriction.
> I'll remove following functions corresponding to ioctls.
> 
> * viif_enum_input
> * viif_g_selection
> * viif_s_selection
> * viif_dv_timings_cap
> * viif_enum_dv_timings
> * viif_g_dv_timings
> * viif_s_dv_timings
> * viif_query_dv_timings
> * viif_g_edid
> * viif_s_edid
> * viif_g_parm
> * viif_s_parm
> * viif_enum_framesizes

This one should stay, it should report the minimum and maximum sizes
supported by the video nodes, regardless of the configuration of the
connected subdev.

> * viif_enum_frameintervals
> 
> I can call subdevices directly if I need. Is it a correct understanding?

what do you mean exactly by calling subdevices directly ?

> As for viif_try_fmt_vid_cap and viif_s_fmt_vid_cap, 
> I'll remove pad.g_fmt() call which is for checking pixel format.
> The check will be moved to viif_capture_link_validate() validation
> routine triggered by a start streaming event.
> 
> > [snip]

-- 
Regards,

Laurent Pinchart
