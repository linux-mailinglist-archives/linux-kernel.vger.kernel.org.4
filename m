Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D5264D840
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiLOJIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLOJIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:08:10 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6404193D6;
        Thu, 15 Dec 2022 01:08:09 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7ED23327;
        Thu, 15 Dec 2022 10:08:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671095287;
        bh=bJa/unMKm/nUIxwQN3u2ip2UOt3TmdZbeRjwwhAM9jU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pwaunFcF3S715eWo7DL2jFmi4gVoett40YiqWvTKTvbOyZ+ZiMy0njEdu3Fr1ztbv
         4E9r519LoDm72PjXfwQJS2dcUpO5rUwaqbnORDUS/nH+SM0oy52FtgBSdP2ESQJCOl
         tJc0H8yjLM96Eu+eU04oL5gGc6GlBQkgybs6Jum0=
Date:   Thu, 15 Dec 2022 11:08:04 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Yunke Cao <yunkec@chromium.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Max Staudt <mstaudt@google.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v2] media: uvcvideo: Do not alloc dev->status
Message-ID: <Y5rj9GhQuyNbNnDw@pendragon.ideasonboard.com>
References: <20221214-uvc-status-alloc-v2-0-3f1cba6fc734@chromium.org>
 <Y5p1DVWXuYSzkRO4@google.com>
 <CANiDSCtQFR-CPNXu-hqM_11DogMTvdhK9xWy7cZyd7vwZAMBSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiDSCtQFR-CPNXu-hqM_11DogMTvdhK9xWy7cZyd7vwZAMBSQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Thu, Dec 15, 2022 at 08:59:14AM +0100, Ricardo Ribalda wrote:
> Hi Sergey
> 
> Thanks for looking into this
> 
> On Thu, 15 Dec 2022 at 02:15, Sergey Senozhatsky wrote:
> >
> > On (22/12/14 14:37), Ricardo Ribalda wrote:
> > [..]
> > > +struct uvc_status_streaming {
> > > +     u8      button;
> > > +} __packed;
> > > +
> > > +struct uvc_status_control {
> > > +     u8      bSelector;
> > > +     u8      bAttribute;
> > > +     u8      bValue[11];
> > > +} __packed;
> > > +
> > > +struct uvc_status {
> > > +     u8      bStatusType;
> > > +     u8      bOriginator;
> > > +     u8      bEvent;
> > > +     union {
> > > +             struct uvc_status_control control;
> > > +             struct uvc_status_streaming streaming;
> > > +     };
> > > +} __packed;
> > > +
> > >  struct uvc_device {
> > >       struct usb_device *udev;
> > >       struct usb_interface *intf;
> > > @@ -559,7 +579,7 @@ struct uvc_device {
> > >       /* Status Interrupt Endpoint */
> > >       struct usb_host_endpoint *int_ep;
> > >       struct urb *int_urb;
> > > -     u8 *status;
> > > +
> > >       struct input_dev *input;
> > >       char input_phys[64];
> > >
> > > @@ -572,6 +592,12 @@ struct uvc_device {
> > >       } async_ctrl;
> > >
> > >       struct uvc_entity *gpio_unit;
> > > +
> > > +     /*
> > > +      * Ensure that status is aligned, making it safe to use with
> > > +      * non-coherent DMA.
> > > +      */
> > > +     struct uvc_status status __aligned(ARCH_KMALLOC_MINALIGN);
> >
> >         ____cacheline_aligned ?
> >
> > I don't see anyone using ARCH_KMALLOC_MINALIGN except for slab.h
> 
> Seems like cacheline is not good enough:
> 
> https://github.com/torvalds/linux/commit/12c4efe3509b8018e76ea3ebda8227cb53bf5887
> https://lore.kernel.org/all/20220405135758.774016-1-catalin.marinas@arm.com/
> 
> and ARCH_KMALLOC_MINALIGN is what we have today and is working...
> 
> But yeah, the name for that define is not the nicest :)
> 
> I added Jonathan Cameron, on cc, as he had to deal with something
> similar for iio in case we are missing something

I'd like to get feedback on this from DMA and USB experts. Expanding the
CC list of the original patch would help (especially including the
linux-usb mailing list).

> ps: and I thought this was an easy change :P

-- 
Regards,

Laurent Pinchart
