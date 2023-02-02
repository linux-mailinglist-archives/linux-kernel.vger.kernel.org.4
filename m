Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DFA6876DF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 08:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjBBH6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 02:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjBBH63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 02:58:29 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83901F5FC;
        Wed,  1 Feb 2023 23:58:26 -0800 (PST)
Received: from pendragon.ideasonboard.com (unknown [193.209.96.36])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7AE4C505;
        Thu,  2 Feb 2023 08:58:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1675324704;
        bh=TPXyTsAxi3Eo2385J/LyFlYwaQqXZ8xrTsSSsObyBQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KrHWJCPwK4yDOulHuYzcwPsKkn0YAxFv4dJlEUW2czUGUhVh/vsWfPNw8hNjVP7KX
         YfakdiUZ1yOg+NEXWhCT+4pUUwVacX+IupR2F3xwLpUaSVazINIV0OWijUwHhPavr8
         gaj3ZkRef3DVRYcF0W1yLYQDVNezYRcxcE3GEqoo=
Date:   Thu, 2 Feb 2023 09:58:22 +0200
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
Message-ID: <Y9ttHiKSI8HR4ndQ@pendragon.ideasonboard.com>
References: <20230111022433.25950-1-yuji2.ishikawa@toshiba.co.jp>
 <20230111022433.25950-4-yuji2.ishikawa@toshiba.co.jp>
 <2b412539-2236-b41f-c777-bc9e9cf99d66@xs4all.nl>
 <Y8dFlFkVJS/6+Ib1@pendragon.ideasonboard.com>
 <TYAPR01MB620161823BA912502CEF0A5992CE9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
 <Y9LnWfZb+v17+h+X@pendragon.ideasonboard.com>
 <TYAPR01MB6201A88B85E74C3EA3481BD092D69@TYAPR01MB6201.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TYAPR01MB6201A88B85E74C3EA3481BD092D69@TYAPR01MB6201.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ishikawa-san,

On Thu, Feb 02, 2023 at 04:52:56AM +0000, yuji2.ishikawa@toshiba.co.jp wrote:
> On Friday, January 27, 2023 5:49 AM, Laurent Pinchart wrote:
> > On Wed, Jan 25, 2023 at 10:20:27AM +0000, yuji2.ishikawa@toshiba.co.jp wrote:
> > > On Wednesday, January 18, 2023 10:04 AM, Laurent Pinchart wrote:
> > > > On Tue, Jan 17, 2023 at 12:47:10PM +0100, Hans Verkuil wrote:
> > > > > On 11/01/2023 03:24, Yuji Ishikawa wrote:
> > > > > > Add support to Video Input Interface on Toshiba Visconti ARM SoCs.
> > > > > > The interface device includes CSI2 Receiver, frame grabber,
> > > > > > video DMAC and image signal processor.
> > > > > > This patch provides the user interface layer.
> > > > > >
> > > > > > A driver instance provides three /dev/videoX device files; one
> > > > > > for RGB image capture, another one for optional RGB capture with
> > > > > > different parameters and the last one for RAW capture.
> > > > > >
> > > > > > Through the device files, the driver provides streaming (DMA-BUF) interface.
> > > > > > A userland application should feed DMA-BUF instances for capture buffers.
> > > > > >
> > > > > > The driver is based on media controller framework.
> > > > > > Its operations are roughly mapped to two subdrivers; one for ISP
> > > > > > and
> > > > > > CSI2 receiver (yields 1 instance), the other for capture (yields
> > > > > > 3 instances for each capture mode).
> > > > > >
> > > > > > Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> > > > > > ---
> > > > > > Changelog v2:
> > > > > > - Resend v1 because a patch exceeds size limit.
> > > > > >
> > > > > > Changelog v3:
> > > > > > - Adapted to media control framework
> > > > > > - Introduced ISP subdevice, capture device
> > > > > > - Remove private IOCTLs and add vendor specific V4L2 controls
> > > > > > - Change function name avoiding camelcase and uppercase letters
> > > > > >
> > > > > > Changelog v4:
> > > > > > - Split patches because the v3 patch exceeds size limit
> > > > > > - Stop using ID number to identify driver instance:
> > > > > >   - Use dynamically allocated structure to hold HW specific context,
> > > > > >     instead of static one.
> > > > > >   - Call HW layer functions with the context structure instead of ID number
> > > > > > - Use pm_runtime to trigger initialization of HW
> > > > > >   along with open/close of device files.
> > > > > >
> > > > > > Changelog v5:
> > > > > > - Fix coding style problems in viif.c
> > > > > > ---
> > > > > >  drivers/media/platform/visconti/Makefile      |    1 +
> > > > > >  drivers/media/platform/visconti/viif.c        |  545 ++++++++
> > > > > >  drivers/media/platform/visconti/viif.h        |  203 +++
> > > > > >  .../media/platform/visconti/viif_capture.c    | 1201 +++++++++++++++++
> > > > > >  drivers/media/platform/visconti/viif_isp.c    |  846 ++++++++++++
> > > > > >  5 files changed, 2796 insertions(+)  create mode 100644
> > > > > > drivers/media/platform/visconti/viif.c
> > > > > >  create mode 100644 drivers/media/platform/visconti/viif.h
> > > > > >  create mode 100644
> > > > > > drivers/media/platform/visconti/viif_capture.c
> > > > > >  create mode 100644 drivers/media/platform/visconti/viif_isp.c
> > > >
> > > > [snip]
> > > >
> > > > > > +static int viif_s_edid(struct file *file, void *fh, struct
> > > > > > +v4l2_edid *edid) {
> > > > > > +	struct viif_device *viif_dev = video_drvdata_to_capdev(file)->viif_dev;
> > > > > > +	struct viif_subdev *viif_sd = viif_dev->sd;
> > > > > > +
> > > > > > +	return v4l2_subdev_call(viif_sd->v4l2_sd, pad, set_edid,
> > > > > > +edid); }
> > > > >
> > > > > Has this driver been tested with an HDMI receiver? If not, then I
> > > > > would recommend dropping support for it until you actually can
> > > > > test with such hardware.
> > > > >
> > > > > The DV_TIMINGS API is for HDMI/DVI/DisplayPort etc. interfaces,
> > > > > it's not meant for CSI and similar interfaces.
> > > >
> > > > More than that, for MC-based drivers, the video node should *never*
> > > > forward ioctls to a connected subdev. The *only* valid calls to
> > > > v4l2_subdev_call() in this file are
> > > >
> > > > - to video.s_stream() in the start and stop streaming handler
> > > >
> > > > - to pad.g_fmt() when starting streaming to validate that the connected
> > > >   subdev outputs a format compatible with the format set on the video
> > > >   capture device
> > > >
> > > > That's it, nothing else, all other calls to v4l2_subdev_call() must
> > > > be dropped from the implementation of the video_device.
> > >
> > > Thank you for your comment. I understand the restriction.
> > > I'll remove following functions corresponding to ioctls.
> > >
> > > * viif_enum_input
> > > * viif_g_selection
> > > * viif_s_selection
> > > * viif_dv_timings_cap
> > > * viif_enum_dv_timings
> > > * viif_g_dv_timings
> > > * viif_s_dv_timings
> > > * viif_query_dv_timings
> > > * viif_g_edid
> > > * viif_s_edid
> > > * viif_g_parm
> > > * viif_s_parm
> > > * viif_enum_framesizes
> > 
> > This one should stay, it should report the minimum and maximum sizes
> > supported by the video nodes, regardless of the configuration of the connected
> > subdev.
> 
> I'll keep it.
> 
> > > * viif_enum_frameintervals
> > >
> > > I can call subdevices directly if I need. Is it a correct understanding?
> > 
> > what do you mean exactly by calling subdevices directly ?
> 
> I meant userland can configure subdevices with /dev/v4l-subdev.

Ah yes absolutely, userspace will configure the subdevs.

> > > As for viif_try_fmt_vid_cap and viif_s_fmt_vid_cap, I'll remove
> > > pad.g_fmt() call which is for checking pixel format.
> > > The check will be moved to viif_capture_link_validate() validation
> > > routine triggered by a start streaming event.
> > >
> > > > [snip]

-- 
Regards,

Laurent Pinchart
