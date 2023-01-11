Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769D1665E85
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbjAKOzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239340AbjAKOzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:55:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BD218693
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673448871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N9zj8YS42K6W3ZDXEsceRtMbLQi7qrgFDA+SwHIbrPQ=;
        b=c6iQxee2bXyNZvL59sJIPzQPvh/rfY2Yf1R+satzbTVOCrrMgD9Ew+42psQe9S2Foyqbxg
        s31sJ3//Sqhc0ND3pkbhQPQkrFOdhp2dGSYdLjotlXk7yl1W/5dy0ECH1QCMuvs6ungjw5
        aNj1+ofJdv4Fu2WNm4KfxtZbOQAHrwA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-178-zE7rStlfPICEXAdlVsokng-1; Wed, 11 Jan 2023 09:54:30 -0500
X-MC-Unique: zE7rStlfPICEXAdlVsokng-1
Received: by mail-wr1-f72.google.com with SMTP id s20-20020adfa294000000b002b81849101eso2753400wra.16
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:54:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9zj8YS42K6W3ZDXEsceRtMbLQi7qrgFDA+SwHIbrPQ=;
        b=tKVQlsS2eZlwnAS60fMGM5E93V6wBopXcIuOIEeNqaV/v0IClmS0NZMM2AYua14eSB
         AzA/azvHpYfcBtllhwbfqJg4oPfT9URwOgOiwue8bOwoFKLxl2OEaa/FWRSV59HoCobR
         jhGrejveNLyrWMcqxLwxQn6lNEg4HAT/QTs5QT+/Tw3gBWiEf+qlXes9Y4GT/l+4Fy3O
         YK0JQs6oKSY35eWKK9AYLk8QHU/1oDORLyrQhxelhosTuRU/cr6ZWiTvwqFVc0y1sYQq
         LCugriCgk5w2CG9M0QC0LNMYB5442ofDSclmX2kZ+bQuVB405qOB2bKkadgsgNzzOJSa
         ajCw==
X-Gm-Message-State: AFqh2kpfF99LR3u8prlepX400ANBVHZXP+LsOYSJ8Hr2A9vYibdEuDaz
        dipgWxfyeqqHwOW9X6TPRoxtheBRqb1Yxks5QELDl+XifZ5MERhczJgBavGJqu5n3lxB60hT/1j
        MunPUDb7bfO4T79Iqs3OpFZJT
X-Received: by 2002:a7b:c4da:0:b0:3d3:864a:1173 with SMTP id g26-20020a7bc4da000000b003d3864a1173mr51329741wmk.18.1673448869073;
        Wed, 11 Jan 2023 06:54:29 -0800 (PST)
X-Google-Smtp-Source: AMrXdXugP2HShBUlKleXpOI+5enT05JWsS9mPvd7PqH+kgMtgk8nScFe8RI29yJr1gjicowRsc/aKQ==
X-Received: by 2002:a7b:c4da:0:b0:3d3:864a:1173 with SMTP id g26-20020a7bc4da000000b003d3864a1173mr51329727wmk.18.1673448868824;
        Wed, 11 Jan 2023 06:54:28 -0800 (PST)
Received: from redhat.com ([2.52.157.155])
        by smtp.gmail.com with ESMTPSA id q1-20020a1ce901000000b003b3307fb98fsm17985240wmc.24.2023.01.11.06.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 06:54:28 -0800 (PST)
Date:   Wed, 11 Jan 2023 09:54:25 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "gdawar@amd.com" <gdawar@amd.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tanuj.kamde@amd.com" <tanuj.kamde@amd.com>
Subject: Re: [PATCH 1/5] virtio_ring: per virtqueue dma device
Message-ID: <20230111095358-mutt-send-email-mst@kernel.org>
References: <20230111062809.25020-1-jasowang@redhat.com>
 <20230111062809.25020-2-jasowang@redhat.com>
 <DM8PR12MB5400E61C7E968AC7604556EBABFC9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20230111085210-mutt-send-email-mst@kernel.org>
 <DM8PR12MB54008B92885A8971C4CFED0EABFC9@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR12MB54008B92885A8971C4CFED0EABFC9@DM8PR12MB5400.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 02:46:20PM +0000, Eli Cohen wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, 11 January 2023 15:53
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: Jason Wang <jasowang@redhat.com>; gdawar@amd.com;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > tanuj.kamde@amd.com
> > Subject: Re: [PATCH 1/5] virtio_ring: per virtqueue dma device
> > 
> > On Wed, Jan 11, 2023 at 01:32:20PM +0000, Eli Cohen wrote:
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Wednesday, 11 January 2023 8:28
> > > > To: mst@redhat.com; jasowang@redhat.com
> > > > Cc: Eli Cohen <elic@nvidia.com>; gdawar@amd.com;
> > > > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > > > tanuj.kamde@amd.com
> > > > Subject: [PATCH 1/5] virtio_ring: per virtqueue dma device
> > > >
> > > > This patch introduces a per virtqueue dma device. This will be used
> > > > for virtio devices whose virtqueue are backed by different underlayer
> > > > devices.
> > > >
> > > > One example is the vDPA that where the control virtqueue could be
> > > > implemented through software mediation.
> > > >
> > > > Some of the work are actually done before since the helper like
> > > > vring_dma_device(). This work left are:
> > > >
> > > > - Let vring_dma_device() return the per virtqueue dma device instead
> > > >   of the vdev's parent.
> > > > - Allow passing a dma_device when creating the virtqueue through a new
> > > >   helper, old vring creation helper will keep using vdev's parent.
> > > >
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 133 ++++++++++++++++++++++++-----------
> > > >  include/linux/virtio_ring.h  |  16 +++++
> > > >  2 files changed, 109 insertions(+), 40 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > index 723c4e29e1d3..41144b5246a8 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -202,6 +202,9 @@ struct vring_virtqueue {
> > > >  	/* DMA, allocation, and size information */
> > > >  	bool we_own_ring;
> > > >
> > > > +	/* Device used for doing DMA */
> > > > +	struct device *dma_dev;
> > > > +
> > > >  #ifdef DEBUG
> > > >  	/* They're supposed to lock for us. */
> > > >  	unsigned int in_use;
> > > > @@ -219,7 +222,8 @@ static struct virtqueue
> > > > *__vring_new_virtqueue(unsigned int index,
> > > >  					       bool context,
> > > >  					       bool (*notify)(struct virtqueue *),
> > > >  					       void (*callback)(struct virtqueue
> > > > *),
> > > > -					       const char *name);
> > > > +					       const char *name,
> > > > +					       struct device *dma_dev);
> > > >  static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
> > > >  static void vring_free(struct virtqueue *_vq);
> > > >
> > > > @@ -297,10 +301,11 @@ size_t virtio_max_dma_size(struct virtio_device
> > > > *vdev)
> > > >  EXPORT_SYMBOL_GPL(virtio_max_dma_size);
> > > >
> > > >  static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
> > > > -			      dma_addr_t *dma_handle, gfp_t flag)
> > > > +			       dma_addr_t *dma_handle, gfp_t flag,
> > > > +			       struct device *dma_dev)
> > > >  {
> > > >  	if (vring_use_dma_api(vdev)) {
> > > > -		return dma_alloc_coherent(vdev->dev.parent, size,
> > > > +		return dma_alloc_coherent(dma_dev, size,
> > > >  					  dma_handle, flag);
> > > >  	} else {
> > > >  		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
> > > > @@ -330,10 +335,11 @@ static void *vring_alloc_queue(struct
> > virtio_device
> > > > *vdev, size_t size,
> > > >  }
> > > >
> > > >  static void vring_free_queue(struct virtio_device *vdev, size_t size,
> > > > -			     void *queue, dma_addr_t dma_handle)
> > > > +			     void *queue, dma_addr_t dma_handle,
> > > > +			     struct device *dma_dev)
> > > >  {
> > > >  	if (vring_use_dma_api(vdev))
> > > > -		dma_free_coherent(vdev->dev.parent, size, queue,
> > > > dma_handle);
> > > > +		dma_free_coherent(dma_dev, size, queue, dma_handle);
> > > >  	else
> > > >  		free_pages_exact(queue, PAGE_ALIGN(size));
> > > >  }
> > > > @@ -341,11 +347,11 @@ static void vring_free_queue(struct
> > virtio_device
> > > > *vdev, size_t size,
> > > >  /*
> > > >   * The DMA ops on various arches are rather gnarly right now, and
> > > >   * making all of the arch DMA ops work on the vring device itself
> > > > - * is a mess.  For now, we use the parent device for DMA ops.
> > > > + * is a mess.
> > > >   */
> > > >  static inline struct device *vring_dma_dev(const struct vring_virtqueue
> > *vq)
> > > >  {
> > > > -	return vq->vq.vdev->dev.parent;
> > > > +	return vq->dma_dev;
> > > >  }
> > >
> > > How about getting rid of this function and just use vq->dma_dev?
> > 
> > Will make the patch even bigger than it is.
> 
> I can't see how this can happen. You get rid of the function and you lose overall 10 lines. What am I missing?

This is an existing function, if you drop it you need to refactor
more of the existing code. No?

> > If you do patch on top pls.
> 

