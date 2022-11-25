Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C84D63822F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 02:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiKYBuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 20:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKYBuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 20:50:12 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8363A382;
        Thu, 24 Nov 2022 17:50:11 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id ED57B4D5;
        Fri, 25 Nov 2022 02:50:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669341009;
        bh=9m9VpgU4N/iB30ablYStr4T8l/N4LwY4oyZK9aJc3Zw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cRVxBE26zLS9aVU2qaGwdrrRSRnrHqpp+YGCMH4NuQUfvyQ7ozcm4wXZhe9jrKU/X
         QBBlYzwYOCaC4sn1Z1CdUDOx7vjLh2o6faZf1VcaX+1ker7DVj6/C4Jd95OuhiH8oH
         zKJOooTAUCZY3zi5XnhQ3kpOLq5XcEZghMlqVm9I=
Date:   Fri, 25 Nov 2022 03:49:52 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Naushir Patuck <naush@raspberrypi.com>,
        David Plowman <david.plowman@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>
Subject: Re: [PATCH 03/14] media: videobuf2: Allow exporting of a struct
 dmabuf
Message-ID: <Y4AfQLE7eh2gLZJl@pendragon.ideasonboard.com>
References: <20221121214722.22563-1-umang.jain@ideasonboard.com>
 <20221121214722.22563-4-umang.jain@ideasonboard.com>
 <Y3wHKfeNB6Fv9Xpo@pendragon.ideasonboard.com>
 <CAPY8ntAtbnUqhJRd7+bWLRUz+K=1Hnd33XwSR930hPVfc7EPPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPY8ntAtbnUqhJRd7+bWLRUz+K=1Hnd33XwSR930hPVfc7EPPg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Tue, Nov 22, 2022 at 11:35:31AM +0000, Dave Stevenson wrote:
> On Mon, 21 Nov 2022 at 23:18, Laurent Pinchart wrote:
> > On Tue, Nov 22, 2022 at 03:17:11AM +0530, Umang Jain wrote:
> > > From: Dave Stevenson <dave.stevenson@raspberrypi.org>
> > >
> > > videobuf2 only allowed exporting a dmabuf as a file descriptor,
> > > but there are instances where having the struct dma_buf is
> > > useful within the kernel.
> > >
> > > Split the current implementation into two, one step which
> > > exports a struct dma_buf, and the second which converts that
> > > into an fd.
> > >
> > > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
> > > Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> > > ---
> > >  .../media/common/videobuf2/videobuf2-core.c   | 36 +++++++++++++------
> > >  include/media/videobuf2-core.h                | 15 ++++++++
> > >  2 files changed, 40 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> > > index ab9697f3b5f1..32b26737cac4 100644
> > > --- a/drivers/media/common/videobuf2/videobuf2-core.c
> > > +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> > > @@ -2184,49 +2184,49 @@ static int __find_plane_by_offset(struct vb2_queue *q, unsigned long off,
> > >       return -EINVAL;
> > >  }
> > >
> > > -int vb2_core_expbuf(struct vb2_queue *q, int *fd, unsigned int type,
> > > -             unsigned int index, unsigned int plane, unsigned int flags)
> > > +struct dma_buf *vb2_core_expbuf_dmabuf(struct vb2_queue *q, unsigned int type,
> > > +                                    unsigned int index, unsigned int plane,
> > > +                                    unsigned int flags)
> >
> > This function is used in the ISP driver, in bcm2835_isp_buf_prepare(),
> > for MMAP buffers, and as far as I can tell, its only purpose is to
> > create a dma_buf instance to then be imported in
> > vchiq_mmal_submit_buffer() with a call to vc_sm_cma_import_dmabuf().
> > That sounds like a very complicated set of operations, and quite
> > inefficient :-(
> 
> Are you saying that dmabufs are not the preferred route for sharing
> buffers between kernel subsystems? What are you suggesting instead?
> 
> If the VPU (firmware) has a handle to the buffer then we need to
> manage the lifetime such that it is not freed until the VPU has
> released it. That is handled for you with dmabufs, therefore why
> reinvent the wheel?

When we go through userspace, dmabuf is certainly the way to go. Here,
we need to share buffer information between two drivers that are
specific to the platform, so we could avoid going through so many layers
by using a custom abstraction. However, that would require additional
development, and probably reinventing the wheel to some extent, so it's
probably not worth it.

I'd like to explore if we could avoid creating a second dmabuf in
vc_sm_cma_import_dmabuf_internal() to make all this a bit more
lightweight. Let's discuss it in replies to patch 01/14.

> > >  {
> > >       struct vb2_buffer *vb = NULL;
> > >       struct vb2_plane *vb_plane;
> > > -     int ret;
> > >       struct dma_buf *dbuf;
> > >
> > >       if (q->memory != VB2_MEMORY_MMAP) {
> > >               dprintk(q, 1, "queue is not currently set up for mmap\n");
> > > -             return -EINVAL;
> > > +             return ERR_PTR(-EINVAL);
> > >       }
> > >
> > >       if (!q->mem_ops->get_dmabuf) {
> > >               dprintk(q, 1, "queue does not support DMA buffer exporting\n");
> > > -             return -EINVAL;
> > > +             return ERR_PTR(-EINVAL);
> > >       }
> > >
> > >       if (flags & ~(O_CLOEXEC | O_ACCMODE)) {
> > >               dprintk(q, 1, "queue does support only O_CLOEXEC and access mode flags\n");
> > > -             return -EINVAL;
> > > +             return ERR_PTR(-EINVAL);
> > >       }
> > >
> > >       if (type != q->type) {
> > >               dprintk(q, 1, "invalid buffer type\n");
> > > -             return -EINVAL;
> > > +             return ERR_PTR(-EINVAL);
> > >       }
> > >
> > >       if (index >= q->num_buffers) {
> > >               dprintk(q, 1, "buffer index out of range\n");
> > > -             return -EINVAL;
> > > +             return ERR_PTR(-EINVAL);
> > >       }
> > >
> > >       vb = q->bufs[index];
> > >
> > >       if (plane >= vb->num_planes) {
> > >               dprintk(q, 1, "buffer plane out of range\n");
> > > -             return -EINVAL;
> > > +             return ERR_PTR(-EINVAL);
> > >       }
> > >
> > >       if (vb2_fileio_is_active(q)) {
> > >               dprintk(q, 1, "expbuf: file io in progress\n");
> > > -             return -EBUSY;
> > > +             return ERR_PTR(-EBUSY);
> > >       }
> > >
> > >       vb_plane = &vb->planes[plane];
> > > @@ -2238,9 +2238,23 @@ int vb2_core_expbuf(struct vb2_queue *q, int *fd, unsigned int type,
> > >       if (IS_ERR_OR_NULL(dbuf)) {
> > >               dprintk(q, 1, "failed to export buffer %d, plane %d\n",
> > >                       index, plane);
> > > -             return -EINVAL;
> > > +             return ERR_PTR(-EINVAL);
> > >       }
> > >
> > > +     return dbuf;
> > > +}
> > > +EXPORT_SYMBOL_GPL(vb2_core_expbuf_dmabuf);
> > > +
> > > +int vb2_core_expbuf(struct vb2_queue *q, int *fd, unsigned int type,
> > > +                 unsigned int index, unsigned int plane, unsigned int flags)
> > > +{
> > > +     struct dma_buf *dbuf;
> > > +     int ret;
> > > +
> > > +     dbuf = vb2_core_expbuf_dmabuf(q, type, index, plane, flags);
> > > +     if (IS_ERR(dbuf))
> > > +             return PTR_ERR(dbuf);
> > > +
> > >       ret = dma_buf_fd(dbuf, flags & ~O_ACCMODE);
> > >       if (ret < 0) {
> > >               dprintk(q, 3, "buffer %d, plane %d failed to export (%d)\n",
> > > diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> > > index 3253bd2f6fee..33629ed2b64f 100644
> > > --- a/include/media/videobuf2-core.h
> > > +++ b/include/media/videobuf2-core.h
> > > @@ -911,6 +911,21 @@ int vb2_core_streamon(struct vb2_queue *q, unsigned int type);
> > >   */
> > >  int vb2_core_streamoff(struct vb2_queue *q, unsigned int type);
> > >
> > > +/**
> > > + * vb2_core_expbuf_dmabuf() - Export a buffer as a dma_buf structure
> > > + * @q:         videobuf2 queue
> > > + * @type:      buffer type
> > > + * @index:     id number of the buffer
> > > + * @plane:     index of the plane to be exported, 0 for single plane queues
> > > + * @flags:     flags for newly created file, currently only O_CLOEXEC is
> > > + *             supported, refer to manual of open syscall for more details
> > > + *
> > > + * Return: Returns the dmabuf pointer
> > > + */
> > > +struct dma_buf *vb2_core_expbuf_dmabuf(struct vb2_queue *q, unsigned int type,
> > > +                                    unsigned int index, unsigned int plane,
> > > +                                    unsigned int flags);
> > > +
> > >  /**
> > >   * vb2_core_expbuf() - Export a buffer as a file descriptor.
> > >   * @q:               pointer to &struct vb2_queue with videobuf2 queue.

-- 
Regards,

Laurent Pinchart
