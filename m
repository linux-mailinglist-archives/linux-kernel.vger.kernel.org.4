Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7C77006EF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240972AbjELLgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241002AbjELLge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:36:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919E2D05E
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683891345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j18moFQtAZJOXAEp0m2FgLJK8fZ33JwPBzg3lwc/CJE=;
        b=a9mM06xte0O46XHwgrS0fuclFVakFry3L9looip9QRNM7oGmR3zPT1o8xHJPVReyD5/nZ+
        Pwmn/gF1rjQNHCAVMrMYgBpq/Ac/SxdC268rG9mdDD+IEi7CPTaTfhHjKzHwoOJFSRBxut
        v9GWrJdd5vk9lPr4If6jtJYgk+GmCY0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-JT90t_kVNO2p3chHUun2iA-1; Fri, 12 May 2023 07:35:44 -0400
X-MC-Unique: JT90t_kVNO2p3chHUun2iA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f42bcef2acso17999775e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683891342; x=1686483342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j18moFQtAZJOXAEp0m2FgLJK8fZ33JwPBzg3lwc/CJE=;
        b=du4tgxtGudZW91D+gepC8kOClhc5SNalXdgFfr41gE1fYZNHdgJFQQLSlKKdtip77r
         GP1b4OZYbF7cDUTQSx2GbfBSenWbA9zHEf4ZHVaPIZUsWQGoxharasORz2mNljnyicAE
         ouXFP80f4dGGcerBd+fvLeycm37ZV+tbtAq7KtH7KtnQ+4Mis10M2NSw/j8wqjP9T/ek
         ITh/MlDULe3h41mGzfDR6WCusSMvNUDLQqB/l3GKirD6C5CYl/bLzFKJYh6WtMZn3EdK
         hTJhrFXdxq31Si7u1RzmzKoA5qXl2u11bB+ZKxqVPwCQSW23GdXwjfOON7BnTc/KaPrF
         cuLg==
X-Gm-Message-State: AC+VfDyxUyI2wp27nF3Kv3c+b6J6cBF4Yhlw9bsrDqUAvr4h91RKbJq6
        pRb9dE71t3FiVZeAMpzK2wLZ+Y/SnHBax4TyFQbZPv0xxayE4gwZ5btOEuSgbNE9qKiUhn2Q9KO
        4wlZdPU9rkm9nQoMwHMuujJmxglKXGZni
X-Received: by 2002:a05:600c:2049:b0:3f4:1a97:ab09 with SMTP id p9-20020a05600c204900b003f41a97ab09mr13430044wmg.25.1683891342403;
        Fri, 12 May 2023 04:35:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6YB4LXWmzvSc+5lRdqj+LiZFKU35Efug5kWk4jSDBQmNqs3qd3YKp0Pv/Uo3j0j/ZndKbByw==
X-Received: by 2002:a05:600c:2049:b0:3f4:1a97:ab09 with SMTP id p9-20020a05600c204900b003f41a97ab09mr13430031wmg.25.1683891342071;
        Fri, 12 May 2023 04:35:42 -0700 (PDT)
Received: from redhat.com ([31.187.78.61])
        by smtp.gmail.com with ESMTPSA id j15-20020a05600c1c0f00b003f1738d0d13sm15639639wms.1.2023.05.12.04.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 04:35:41 -0700 (PDT)
Date:   Fri, 12 May 2023 07:35:37 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     stefanha@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH 1/2] virtio: abstract virtqueue related methods
Message-ID: <20230512072819-mutt-send-email-mst@kernel.org>
References: <20230512094618.433707-1-pizhenwei@bytedance.com>
 <20230512094618.433707-2-pizhenwei@bytedance.com>
 <20230512064305-mutt-send-email-mst@kernel.org>
 <37a5e7dc-160d-51d2-7631-196ad9e21da7@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37a5e7dc-160d-51d2-7631-196ad9e21da7@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 07:09:40PM +0800, zhenwei pi wrote:
> On 5/12/23 18:46, Michael S. Tsirkin wrote:
> > On Fri, May 12, 2023 at 05:46:17PM +0800, zhenwei pi wrote:
> > > There is already a virtqueue abstract structure in virtio subsystem
> > > (see struct virtqueue in include/linux/virtio.h), however the vring
> > > based virtqueue is used only in the past years, the virtqueue related
> > > methods mix much with vring(just look like the codes, virtqueue_xxx
> > > functions are implemented in virtio_ring.c).
> > > 
> > > Abstract virtqueue related methods(see struct virtqueue_ops), and
> > > separate virtqueue_xxx symbols from vring. This allows a non-vring
> > > based transport in the future. With this change, the following symbols
> > > are exported from virtio.ko instead of virtio_ring.ko:
> > >    virtqueue_add_sgs
> > >    virtqueue_add_outbuf
> > >    virtqueue_add_inbuf
> > >    virtqueue_add_inbuf_ctx
> > >    virtqueue_kick_prepare
> > >    virtqueue_notify
> > >    virtqueue_kick
> > >    virtqueue_enable_cb_prepare
> > >    virtqueue_enable_cb
> > >    virtqueue_enable_cb_delayed
> > >    virtqueue_disable_cb
> > >    virtqueue_poll
> > >    virtqueue_get_buf_ctx
> > >    virtqueue_get_buf
> > >    virtqueue_detach_unused_buf
> > >    virtqueue_get_vring_size
> > >    virtqueue_resize
> > >    virtqueue_is_broken
> > >    virtio_break_device
> > >    __virtio_unbreak_device
> > > 
> > > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > > Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> > > ---
> > >   drivers/virtio/virtio.c      | 362 +++++++++++++++++++++++++++++++++++
> > >   drivers/virtio/virtio_ring.c | 282 +++++----------------------
> > >   include/linux/virtio.h       |  29 +++
> > >   3 files changed, 443 insertions(+), 230 deletions(-)
> > > 
> > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > index 3893dc29eb26..8d8715a10f26 100644
> > > --- a/drivers/virtio/virtio.c
> > > +++ b/drivers/virtio/virtio.c
> > > @@ -553,6 +553,368 @@ int virtio_device_restore(struct virtio_device *dev)
> > >   EXPORT_SYMBOL_GPL(virtio_device_restore);
> > >   #endif
> > > +/**
> > > + * virtqueue_add_sgs - expose buffers to other end
> > > + * @vq: the struct virtqueue we're talking about.
> > > + * @sgs: array of terminated scatterlists.
> > > + * @out_sgs: the number of scatterlists readable by other side
> > > + * @in_sgs: the number of scatterlists which are writable (after readable ones)
> > > + * @data: the token identifying the buffer.
> > > + * @gfp: how to do memory allocations (if necessary).
> > > + *
> > > + * Caller must ensure we don't call this with other virtqueue operations
> > > + * at the same time (except where noted).
> > > + *
> > > + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> > > + */
> > > +int virtqueue_add_sgs(struct virtqueue *vq, struct scatterlist *sgs[],
> > > +		      unsigned int out_sgs, unsigned int in_sgs,
> > > +		      void *data, gfp_t gfp)
> > > +{
> > > +	unsigned int i, total_sg = 0;
> > > +
> > > +	/* Count them first. */
> > > +	for (i = 0; i < out_sgs + in_sgs; i++) {
> > > +		struct scatterlist *sg;
> > > +
> > > +		for (sg = sgs[i]; sg; sg = sg_next(sg))
> > > +			total_sg++;
> > > +	}
> > > +	return vq->ops->add_sgs(vq, sgs, total_sg, out_sgs, in_sgs,
> > > +				data, NULL, gfp);
> > > +}
> > > +EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
> > 
> > 
> > Hmm this kind of indirection on data path is going to be costly
> > performance-wise especially when retpolines are in place.
> > 
> > Any data on this?
> > 
> 
> Hi,
> 
> 1, What about moving these functions into virtio.h and declare them as
> static inline?

This will do nothing to remove indirection.

> 2, what about moving method fields into struct virtqueue?

This gets rid of one level of indirection but the big problem
is indirect function call due to retpolines, this remains.


> Then we have struct like:
> struct virtqueue {
> 	struct list_head list;
> 	...
> 	void *priv;
> 
> 	/* virtqueue specific operations */
>         int (*add_sgs)(struct virtqueue *vq, struct scatterlist *sgs[],
>                        unsigned int total_sg,
>                        unsigned int out_sgs, unsigned int in_sgs,
>                        void *data, void *ctx, gfp_t gfp);
> 	...
> }
> 
> and functions like:
> static inline int virtqueue_add_sgs(...)
> {
>         unsigned int i, total_sg = 0;
> 
>         /* Count them first. */
>         for (i = 0; i < out_sgs + in_sgs; i++) {
>                 struct scatterlist *sg;
> 
>                 for (sg = sgs[i]; sg; sg = sg_next(sg))
>                         total_sg++;
>         }
>         return vq->add_sgs(vq, sgs, total_sg, out_sgs, in_sgs,
>                            data, NULL, gfp);
> }

Maybe a flag in vq: 
	bool abstract; /* use ops to add/get bufs and kick */
and then
	if (unlikely(vq->abstract))
		 return vq->ops->add_sgs(vq, sgs, total_sg, out_sgs, in_sgs,
				    	 data, NULL, gfp);

transport then just sets the ops if it wants abstract vqs,
and core then skips the vring.


> If [1] is acceptable, we can also reduce changes in patch 'tools/virtio:
> implement virtqueue in test'.

Yea that one shouldn't be there.

> -- 
> zhenwei pi

