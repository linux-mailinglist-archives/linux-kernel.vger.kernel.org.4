Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3BD633B95
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbiKVLk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiKVLjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:39:51 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402325D6B2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 03:35:48 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id s10so10712784ioa.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 03:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Weuvsj9Ph1lxw8aHlC9F8s8S70wYA+EI0s4JK82WZpo=;
        b=SG70hc5F0o9EuDoI9bLz5Dfer2Q3CDA0Wi9uHtgdyghw9TLwsNkMTxDgc/TOJzUC+x
         he2wW6JLQ0ouUqsrWKsm0YjHYNSXHkssD5q+Dj5hTBgaq+YJ+dDsbF9LKUosIqQuaVxz
         k8z4if7TjMi/eZJXH3mp4+GEYNakIyltJcRBOSRNb1X3aQOhLIxfBU1vNUyLG02tadPp
         PT65TdDAH7deRrtmlkrXcDqsi5QIDgs/vEtDrwF4H432lv5OP0m6dKsfEXbNg73JEtEN
         d1hOq0FIUldofK7PbDxkvepK7iM5w+xaEgSvdzuh03EvYEhN8ElQOJUPGwdhKthHJQq1
         LmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Weuvsj9Ph1lxw8aHlC9F8s8S70wYA+EI0s4JK82WZpo=;
        b=x7YfKj35NhmLviIXIylXPZMqf/6A0N/m9/zWoZWZ4V0g6JlTz2ZROYnCo77cNx9oPU
         qj6syyD96WFHKklWeL+dWsV5ZN8QJ3n/HrXsrXiAGb0KyxSJd6o/iZzFt4sTPD28ORk0
         i6/A4X9WR5mph4uaIHwCLLsNhArcxZterkE8r38n5WpLushoCxnklJQDHCfCsbE2H1zs
         LzI81S+30Y6CZH564SQSnAODdv8V9dwS1Vzjv4dI4N5ZOgrBOfgcETtSId1R8gUfDpLc
         brUHL79UmbEajt/idKRFehf0tMh0JGqh1FL43Np29gfve8dDrSeeY12GT3abq3AGFWrR
         /60Q==
X-Gm-Message-State: ANoB5pnzw0PC54mPwElVW2G7dOXh6m5Bw3rUhMidPfYww8BfFnwQVwPQ
        gXBV7vlcoRDrEmDjPlhbZBNTUhubjE1rwOBbjYGrew==
X-Google-Smtp-Source: AA0mqf5cKFaxMU39VgUo7JRFFXTv0Cyxe45k89SDohlm5M2uJI0q9fvnmrkz8wehsFuY/Fccm//Ja7pEUw7xwcTS4JE=
X-Received: by 2002:a05:6602:e:b0:6d6:d016:b56a with SMTP id
 b14-20020a056602000e00b006d6d016b56amr4052778ioa.204.1669116947650; Tue, 22
 Nov 2022 03:35:47 -0800 (PST)
MIME-Version: 1.0
References: <20221121214722.22563-1-umang.jain@ideasonboard.com>
 <20221121214722.22563-4-umang.jain@ideasonboard.com> <Y3wHKfeNB6Fv9Xpo@pendragon.ideasonboard.com>
In-Reply-To: <Y3wHKfeNB6Fv9Xpo@pendragon.ideasonboard.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 22 Nov 2022 11:35:31 +0000
Message-ID: <CAPY8ntAtbnUqhJRd7+bWLRUz+K=1Hnd33XwSR930hPVfc7EPPg@mail.gmail.com>
Subject: Re: [PATCH 03/14] media: videobuf2: Allow exporting of a struct dmabuf
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022 at 23:18, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Umang and Dave,
>
> Thank you for the patch.
>
> On Tue, Nov 22, 2022 at 03:17:11AM +0530, Umang Jain wrote:
> > From: Dave Stevenson <dave.stevenson@raspberrypi.org>
> >
> > videobuf2 only allowed exporting a dmabuf as a file descriptor,
> > but there are instances where having the struct dma_buf is
> > useful within the kernel.
> >
> > Split the current implementation into two, one step which
> > exports a struct dma_buf, and the second which converts that
> > into an fd.
> >
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
> > Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> > ---
> >  .../media/common/videobuf2/videobuf2-core.c   | 36 +++++++++++++------
> >  include/media/videobuf2-core.h                | 15 ++++++++
> >  2 files changed, 40 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> > index ab9697f3b5f1..32b26737cac4 100644
> > --- a/drivers/media/common/videobuf2/videobuf2-core.c
> > +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> > @@ -2184,49 +2184,49 @@ static int __find_plane_by_offset(struct vb2_queue *q, unsigned long off,
> >       return -EINVAL;
> >  }
> >
> > -int vb2_core_expbuf(struct vb2_queue *q, int *fd, unsigned int type,
> > -             unsigned int index, unsigned int plane, unsigned int flags)
> > +struct dma_buf *vb2_core_expbuf_dmabuf(struct vb2_queue *q, unsigned int type,
> > +                                    unsigned int index, unsigned int plane,
> > +                                    unsigned int flags)
>
> This function is used in the ISP driver, in bcm2835_isp_buf_prepare(),
> for MMAP buffers, and as far as I can tell, its only purpose is to
> create a dma_buf instance to then be imported in
> vchiq_mmal_submit_buffer() with a call to vc_sm_cma_import_dmabuf().
> That sounds like a very complicated set of operations, and quite
> inefficient :-(

Are you saying that dmabufs are not the preferred route for sharing
buffers between kernel subsystems? What are you suggesting instead?

If the VPU (firmware) has a handle to the buffer then we need to
manage the lifetime such that it is not freed until the VPU has
released it. That is handled for you with dmabufs, therefore why
reinvent the wheel?

  Dave

> >  {
> >       struct vb2_buffer *vb = NULL;
> >       struct vb2_plane *vb_plane;
> > -     int ret;
> >       struct dma_buf *dbuf;
> >
> >       if (q->memory != VB2_MEMORY_MMAP) {
> >               dprintk(q, 1, "queue is not currently set up for mmap\n");
> > -             return -EINVAL;
> > +             return ERR_PTR(-EINVAL);
> >       }
> >
> >       if (!q->mem_ops->get_dmabuf) {
> >               dprintk(q, 1, "queue does not support DMA buffer exporting\n");
> > -             return -EINVAL;
> > +             return ERR_PTR(-EINVAL);
> >       }
> >
> >       if (flags & ~(O_CLOEXEC | O_ACCMODE)) {
> >               dprintk(q, 1, "queue does support only O_CLOEXEC and access mode flags\n");
> > -             return -EINVAL;
> > +             return ERR_PTR(-EINVAL);
> >       }
> >
> >       if (type != q->type) {
> >               dprintk(q, 1, "invalid buffer type\n");
> > -             return -EINVAL;
> > +             return ERR_PTR(-EINVAL);
> >       }
> >
> >       if (index >= q->num_buffers) {
> >               dprintk(q, 1, "buffer index out of range\n");
> > -             return -EINVAL;
> > +             return ERR_PTR(-EINVAL);
> >       }
> >
> >       vb = q->bufs[index];
> >
> >       if (plane >= vb->num_planes) {
> >               dprintk(q, 1, "buffer plane out of range\n");
> > -             return -EINVAL;
> > +             return ERR_PTR(-EINVAL);
> >       }
> >
> >       if (vb2_fileio_is_active(q)) {
> >               dprintk(q, 1, "expbuf: file io in progress\n");
> > -             return -EBUSY;
> > +             return ERR_PTR(-EBUSY);
> >       }
> >
> >       vb_plane = &vb->planes[plane];
> > @@ -2238,9 +2238,23 @@ int vb2_core_expbuf(struct vb2_queue *q, int *fd, unsigned int type,
> >       if (IS_ERR_OR_NULL(dbuf)) {
> >               dprintk(q, 1, "failed to export buffer %d, plane %d\n",
> >                       index, plane);
> > -             return -EINVAL;
> > +             return ERR_PTR(-EINVAL);
> >       }
> >
> > +     return dbuf;
> > +}
> > +EXPORT_SYMBOL_GPL(vb2_core_expbuf_dmabuf);
> > +
> > +int vb2_core_expbuf(struct vb2_queue *q, int *fd, unsigned int type,
> > +                 unsigned int index, unsigned int plane, unsigned int flags)
> > +{
> > +     struct dma_buf *dbuf;
> > +     int ret;
> > +
> > +     dbuf = vb2_core_expbuf_dmabuf(q, type, index, plane, flags);
> > +     if (IS_ERR(dbuf))
> > +             return PTR_ERR(dbuf);
> > +
> >       ret = dma_buf_fd(dbuf, flags & ~O_ACCMODE);
> >       if (ret < 0) {
> >               dprintk(q, 3, "buffer %d, plane %d failed to export (%d)\n",
> > diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> > index 3253bd2f6fee..33629ed2b64f 100644
> > --- a/include/media/videobuf2-core.h
> > +++ b/include/media/videobuf2-core.h
> > @@ -911,6 +911,21 @@ int vb2_core_streamon(struct vb2_queue *q, unsigned int type);
> >   */
> >  int vb2_core_streamoff(struct vb2_queue *q, unsigned int type);
> >
> > +/**
> > + * vb2_core_expbuf_dmabuf() - Export a buffer as a dma_buf structure
> > + * @q:         videobuf2 queue
> > + * @type:      buffer type
> > + * @index:     id number of the buffer
> > + * @plane:     index of the plane to be exported, 0 for single plane queues
> > + * @flags:     flags for newly created file, currently only O_CLOEXEC is
> > + *             supported, refer to manual of open syscall for more details
> > + *
> > + * Return: Returns the dmabuf pointer
> > + */
> > +struct dma_buf *vb2_core_expbuf_dmabuf(struct vb2_queue *q, unsigned int type,
> > +                                    unsigned int index, unsigned int plane,
> > +                                    unsigned int flags);
> > +
> >  /**
> >   * vb2_core_expbuf() - Export a buffer as a file descriptor.
> >   * @q:               pointer to &struct vb2_queue with videobuf2 queue.
>
> --
> Regards,
>
> Laurent Pinchart
