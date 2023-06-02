Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623B4720469
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbjFBO0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbjFBOZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:25:33 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F5C19B;
        Fri,  2 Jun 2023 07:25:32 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126156168104.26.openmobile.ne.jp [126.156.168.104])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 07FF96E0;
        Fri,  2 Jun 2023 16:25:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685715907;
        bh=EqzFhYvzdMcIMHi1qwsYpn3DK/kCREwpbRjiJXwDcF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=njvcF75+Etd5OPKQxM13PuReuXtkK2/Ro3ozPhfutjZC3/g8gQFWEmwJwOI2small
         6WU2iAfCCFfSD4Muh8pdEQoBEaYbO217hsypteWqwyQwUXt033CEuavsQjpx6yQx+R
         Sy/BMA2U/PLAmM5Ux/bRPTnfu74oIJ9gULMQccqs=
Date:   Fri, 2 Jun 2023 17:25:28 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dmitry Perchanov <dmitry.perchanov@intel.com>
Cc:     linux-media@vger.kernel.org, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, evgeni.raikhel@intel.com,
        demisrael@gmail.com, sakari.ailus@iki.fi
Subject: Re: [PATCH v3] media: uvcvideo: Enable Intel RealSense metadata for
 devices.
Message-ID: <20230602142528.GE24855@pendragon.ideasonboard.com>
References: <5587a4f1a0a7f3e2bd0ce886bb4ee3bcbf8f522a.camel@intel.com>
 <20230420103143.GB11005@pendragon.ideasonboard.com>
 <50e54f3d3eaaaff95f31d79ddd731731bfc054ae.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50e54f3d3eaaaff95f31d79ddd731731bfc054ae.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Thu, Jun 01, 2023 at 05:03:06PM +0300, Dmitry Perchanov wrote:
> Bump.
> All questions are answered.

I've applied the patch to my tree.

> On Thu, 2023-04-20 at 13:31 +0300, Laurent Pinchart wrote:
> > Hi Dmitry,
> > 
> > Thank you for the patch.
> > 
> > On Thu, Apr 20, 2023 at 12:06:55PM +0300, Dmitry Perchanov wrote:
> > > Intel RealSense UVC Depth cameras produce metadata in a
> > > vendor-specific format that is already supported by the uvcvideo driver.
> > > Enable handling of this metadata for 7 additional RealSense devices.
> > > 
> > > Co-developed-by: Yu MENG <yu1.meng@intel.com>
> > > Co-developed-by: Evgeni Raikhel <evgeni.raikhel@intel.com>
> > > Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > I will wait for the answer to Sakari's question before merging this
> > though.
> > 
> > > ---
> > >  drivers/media/usb/uvc/uvc_driver.c | 63 ++++++++++++++++++++++++++++++
> > >  1 file changed, 63 insertions(+)
> > > 
> > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > index 7aefa76a42b3..f69573e2de96 100644
> > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > @@ -3014,6 +3014,33 @@ static const struct usb_device_id uvc_ids[] = {
> > >  	  .bInterfaceSubClass	= 1,
> > >  	  .bInterfaceProtocol	= 0,
> > >  	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
> > > +	/* Intel D410/ASR depth camera */
> > > +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> > > +				| USB_DEVICE_ID_MATCH_INT_INFO,
> > > +	  .idVendor		= 0x8086,
> > > +	  .idProduct		= 0x0ad2,
> > > +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> > > +	  .bInterfaceSubClass	= 1,
> > > +	  .bInterfaceProtocol	= 0,
> > > +	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > > +	/* Intel D415/ASRC depth camera */
> > > +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> > > +				| USB_DEVICE_ID_MATCH_INT_INFO,
> > > +	  .idVendor		= 0x8086,
> > > +	  .idProduct		= 0x0ad3,
> > > +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> > > +	  .bInterfaceSubClass	= 1,
> > > +	  .bInterfaceProtocol	= 0,
> > > +	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > > +	/* Intel D430/AWG depth camera */
> > > +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> > > +				| USB_DEVICE_ID_MATCH_INT_INFO,
> > > +	  .idVendor		= 0x8086,
> > > +	  .idProduct		= 0x0ad4,
> > > +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> > > +	  .bInterfaceSubClass	= 1,
> > > +	  .bInterfaceProtocol	= 0,
> > > +	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > >  	/* Intel RealSense D4M */
> > >  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> > >  				| USB_DEVICE_ID_MATCH_INT_INFO,
> > > @@ -3023,6 +3050,42 @@ static const struct usb_device_id uvc_ids[] = {
> > >  	  .bInterfaceSubClass	= 1,
> > >  	  .bInterfaceProtocol	= 0,
> > >  	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > > +	/* Intel D435/AWGC depth camera */
> > > +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> > > +				| USB_DEVICE_ID_MATCH_INT_INFO,
> > > +	  .idVendor		= 0x8086,
> > > +	  .idProduct		= 0x0b07,
> > > +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> > > +	  .bInterfaceSubClass	= 1,
> > > +	  .bInterfaceProtocol	= 0,
> > > +	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > > +	/* Intel D435i depth camera */
> > > +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> > > +				| USB_DEVICE_ID_MATCH_INT_INFO,
> > > +	  .idVendor		= 0x8086,
> > > +	  .idProduct		= 0x0b3a,
> > > +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> > > +	  .bInterfaceSubClass	= 1,
> > > +	  .bInterfaceProtocol	= 0,
> > > +	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > > +	/* Intel D405 Depth Camera */
> > > +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> > > +				| USB_DEVICE_ID_MATCH_INT_INFO,
> > > +	  .idVendor		= 0x8086,
> > > +	  .idProduct		= 0x0b5b,
> > > +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> > > +	  .bInterfaceSubClass	= 1,
> > > +	  .bInterfaceProtocol	= 0,
> > > +	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > > +	/* Intel D455 Depth Camera */
> > > +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> > > +				| USB_DEVICE_ID_MATCH_INT_INFO,
> > > +	  .idVendor		= 0x8086,
> > > +	  .idProduct		= 0x0b5c,
> > > +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> > > +	  .bInterfaceSubClass	= 1,
> > > +	  .bInterfaceProtocol	= 0,
> > > +	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> > >  	/* Generic USB Video Class */
> > >  	{ USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_UNDEFINED) },
> > >  	{ USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_15) },

-- 
Regards,

Laurent Pinchart
