Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBDB64DA9C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiLOLps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiLOLpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:45:46 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922956548;
        Thu, 15 Dec 2022 03:45:44 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NXr23480jz6J6FM;
        Thu, 15 Dec 2022 19:42:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 11:45:41 +0000
Date:   Thu, 15 Dec 2022 11:45:40 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Ricardo Ribalda <ribalda@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Yunke Cao <yunkec@chromium.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Max Staudt" <mstaudt@google.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2] media: uvcvideo: Do not alloc dev->status
Message-ID: <20221215114540.00001f9f@Huawei.com>
In-Reply-To: <Y5rkzAESkLt/u6kP@pendragon.ideasonboard.com>
References: <20221214-uvc-status-alloc-v2-0-3f1cba6fc734@chromium.org>
        <Y5p1DVWXuYSzkRO4@google.com>
        <CANiDSCtQFR-CPNXu-hqM_11DogMTvdhK9xWy7cZyd7vwZAMBSQ@mail.gmail.com>
        <Y5rj9GhQuyNbNnDw@pendragon.ideasonboard.com>
        <Y5rkzAESkLt/u6kP@pendragon.ideasonboard.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2022 11:11:40 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> Hi Ricardo,
> 
> On Thu, Dec 15, 2022 at 11:08:05AM +0200, Laurent Pinchart wrote:
> > On Thu, Dec 15, 2022 at 08:59:14AM +0100, Ricardo Ribalda wrote:  
> > > On Thu, 15 Dec 2022 at 02:15, Sergey Senozhatsky wrote:  
> > > >
> > > > On (22/12/14 14:37), Ricardo Ribalda wrote:
> > > > [..]  
> > > > > +struct uvc_status_streaming {
> > > > > +     u8      button;
> > > > > +} __packed;
> > > > > +
> > > > > +struct uvc_status_control {
> > > > > +     u8      bSelector;
> > > > > +     u8      bAttribute;
> > > > > +     u8      bValue[11];
> > > > > +} __packed;
> > > > > +
> > > > > +struct uvc_status {
> > > > > +     u8      bStatusType;
> > > > > +     u8      bOriginator;
> > > > > +     u8      bEvent;
> > > > > +     union {
> > > > > +             struct uvc_status_control control;
> > > > > +             struct uvc_status_streaming streaming;
> > > > > +     };
> > > > > +} __packed;
> > > > > +
> > > > >  struct uvc_device {
> > > > >       struct usb_device *udev;
> > > > >       struct usb_interface *intf;
> > > > > @@ -559,7 +579,7 @@ struct uvc_device {
> > > > >       /* Status Interrupt Endpoint */
> > > > >       struct usb_host_endpoint *int_ep;
> > > > >       struct urb *int_urb;
> > > > > -     u8 *status;
> > > > > +
> > > > >       struct input_dev *input;
> > > > >       char input_phys[64];
> > > > >
> > > > > @@ -572,6 +592,12 @@ struct uvc_device {
> > > > >       } async_ctrl;
> > > > >
> > > > >       struct uvc_entity *gpio_unit;
> > > > > +
> > > > > +     /*
> > > > > +      * Ensure that status is aligned, making it safe to use with
> > > > > +      * non-coherent DMA.
> > > > > +      */
> > > > > +     struct uvc_status status __aligned(ARCH_KMALLOC_MINALIGN);  
> > > >
> > > >         ____cacheline_aligned ?
> > > >
> > > > I don't see anyone using ARCH_KMALLOC_MINALIGN except for slab.h  
> > > 
> > > Seems like cacheline is not good enough:
> > > 
> > > https://github.com/torvalds/linux/commit/12c4efe3509b8018e76ea3ebda8227cb53bf5887
> > > https://lore.kernel.org/all/20220405135758.774016-1-catalin.marinas@arm.com/
> > > 
> > > and ARCH_KMALLOC_MINALIGN is what we have today and is working...
> > > 
> > > But yeah, the name for that define is not the nicest :)
> > > 
> > > I added Jonathan Cameron, on cc, as he had to deal with something
> > > similar for iio in case we are missing something  
> > 
> > I'd like to get feedback on this from DMA and USB experts. Expanding the
> > CC list of the original patch would help (especially including the
> > linux-usb mailing list).  
> 
> Also, do we need the allocation change ? It doesn't seem to simplify the
> code that much, neither in terms of lines of code
> 
> >  2 files changed, 48 insertions(+), 49 deletions(-)  
> 
> nor in terms of complexity. Maybe we could keep the union and offsetof
> changes, and drop the allocation change ? In any case, those are two
> different changes, so I'd split them in two patches at least.
> 
> > > ps: and I thought this was an easy change :P  
> 
+CC Catalin who is driving effort to change what we should do here to avoid
wasting space on systems where ARCH_KMALLOC_MINALIGN is currently 128 bytes.

I don't know the precise requirements for this particular allocation, but
if it's about ensuring the data doesn't share a cacheline with anything else in
the structure then the problem is that ____cacheline_aligned is the
size of a line in the L1 cache.  It's not uncommon for microarchitectures to have
a larger cacheline size for L3 and above.  Most of the time that doesn't
matter as they maintain correct coherence (all the ARM servers are fine
I think - ours has 128 byte cachelines in L3, Fujitsu have parts with
256 byte cachelines in L3), but guess what, there are Qualcomm(?) parts where the
L1 cacheline is 64 bytes, but the l3 cacheline is 128 bytes and don't
deal with the hardware coherence issues. For those we need to ensure that
a DMA safe buffer is in it's own 128 byte cacheline, but ___cacheline_aligned
on arm64 only does 64 bytes.  Currently ARCH_KMALLOC_MINALIGN enforces the
larger guarantee and is available on all architectures unlike
ARCH_DMA_MINALIGN which is not yet.

Catalin is working to replace this, so the required guarantees may change,
but we still need something backportable.

When I sent a bunch of fixes for Input Dmitry asked for a general
___dma_minalign (naming to be bikeshedded) define.  So far there are a few
subsystems carrying their own local equivalent (IIO moved to
IIO_DMA_MINALIGN define) in the interests of reducing the pain of
changing this in future. A central definition is another option.

Jonathan

 
