Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6022D64EE12
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiLPPpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiLPPpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:45:21 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 9BFCB50D6B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:45:20 -0800 (PST)
Received: (qmail 997666 invoked by uid 1000); 16 Dec 2022 10:45:19 -0500
Date:   Fri, 16 Dec 2022 10:45:19 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Max Staudt <mstaudt@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Yunke Cao <yunkec@chromium.org>,
        Christoph Hellwig <hch@lst.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v3 0/2] media: uvcvideo: Code cleanup for dev->status
Message-ID: <Y5ySj1+mGK/ioI/q@rowland.harvard.edu>
References: <20221214-uvc-status-alloc-v3-0-9a67616cc549@chromium.org>
 <Y5s+kuxCAtS8Eixj@rowland.harvard.edu>
 <CANiDSCudMRATbHU4=hyjiVhwLr6zQubXPzzpYtXCxdMPsZFcuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCudMRATbHU4=hyjiVhwLr6zQubXPzzpYtXCxdMPsZFcuw@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 09:55:09AM +0100, Ricardo Ribalda wrote:
> Hi Alan
> 
> On Thu, 15 Dec 2022 at 16:34, Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Thu, Dec 15, 2022 at 11:57:17AM +0100, Ricardo Ribalda wrote:
> > > There is no need to make a kzalloc just for 16 bytes. Let's embed the data
> > > into the main data structure.
> > >
> > > Now that we are at it, lets remove all the castings and open coding of
> > > offsets for it.
> > >
> > > [Christoph, do you think dma wise we are violating any non written rules? :) thanks]
> >
> > There _is_ a rule, and it is not exactly unwritten.  The kerneldoc for
> > the transfer_buffer member of struct urb says:
> >
> >         This buffer must be suitable for DMA; allocate it with
> >         kmalloc() or equivalent.
> >
> > Which in general means that the buffer must not be part of a larger
> > structure -- not unless the driver can guarantee that the structure will
> > _never_ be accessed while a USB transfer to/from the buffer is taking
> > place.
> >
> 
> Thanks a lot for the clarification. I was mainly looking at the kerneldoc from:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/usb.h#n1687
> 
> and I could not see any reference to the DMA requirements.
> 
> Mind if I send a patch to add a reference there?

Not at all.  But if you change the documentation for usb_fill_int_urb() 
then you should also change it for usb_fill_control_urb() and 
usb_fill_bulk_urb().

Alan Stern

> > There are examples all over the USB subsystem where buffers as small as
> > one or two bytes get kmalloc'ed in order to obey this rule.  16 bytes is
> > certainly big enough that you shouldn't worry about it being allocated
> > separately.
> >
> Yep, we should keep it malloced. Thanks a lot for looking into this :)
> 
> 
> > Alan Stern
> 
> 
> 
> -- 
> Ricardo Ribalda
