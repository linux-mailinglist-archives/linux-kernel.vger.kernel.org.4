Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B054666075
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbjAKQ3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239722AbjAKQ2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:28:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A663B37523
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673454370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wtEIkYjmLZsEiOQrIC2X2XBPeBjTa7fz4qIHCcwmF9c=;
        b=OcxfzFWxgtBSuxk98SEs1tjttlZDjxDoDoxmMQmBCOGK2AfTbtK86CSCZKGO0SirZmqJqu
        Iv0SwaLyPBxxWKHzrTN5ao2E/7czV5Z021iQo44hTqR1nzqL6Rg92o4V9DEAn1djEfl/xB
        TaeGYQNvakNimIg8z/3+vVz+uZ8idko=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-546-SZHk0AxaPWmVzR5Mwx72pQ-1; Wed, 11 Jan 2023 11:26:09 -0500
X-MC-Unique: SZHk0AxaPWmVzR5Mwx72pQ-1
Received: by mail-ed1-f72.google.com with SMTP id z3-20020a05640235c300b0048ed61c1394so10335924edc.18
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:26:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtEIkYjmLZsEiOQrIC2X2XBPeBjTa7fz4qIHCcwmF9c=;
        b=kfD2XYq89wyJrXJbx9q5BPZpiJJAwTCVmQ7rlzphO/ipgLu+mONK2cJnKhvCDZtqBt
         M8vfqulmF0NrS0j1C/AakCVa5t8UTUEs9Ynddouv9vnnFFRiUv/bVuDiR9wEt74AD7Pw
         XfzPhOKFogB6IZr1U2e/LHADoxHjW385DkdyCnZSnCO5MtSG/gxy0ZR5lD2WCchxGs4O
         +mGfttAqZsm8LA1lu5zbMgqxWvbk4nkcGwLkCzXMWy9yxQxRGEZoOzl0tY3BOf3YQhiD
         lR9yIxBSWeXXzsNyeplEObHp4ekrbl4kkeaowNzdTEkU/QpCA9sQUV1F+k5WHpA/A73e
         31jw==
X-Gm-Message-State: AFqh2kqDTUhnOg2TR/ztIv2izaBHyG6Dtk2xqcPmgrsC3Y03vYFzffU3
        G2qpyue1q9ChsGZdxmgxjELFOW20trI05rq8fIgglBdJyk+QJzSi/t1hAbLzGpY+wIPsgTWrsoj
        43k4MYLa9kI87TQBWYtDdehaX
X-Received: by 2002:aa7:d0c9:0:b0:498:d121:6e00 with SMTP id u9-20020aa7d0c9000000b00498d1216e00mr13325454edo.35.1673454368397;
        Wed, 11 Jan 2023 08:26:08 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtxM349cHuByHfYfwlhKliS60TqAwJqWGnKs7P1TQQQjs1c9z9H5hekBTG2DcqcKN3DEIbLDg==
X-Received: by 2002:aa7:d0c9:0:b0:498:d121:6e00 with SMTP id u9-20020aa7d0c9000000b00498d1216e00mr13325446edo.35.1673454368201;
        Wed, 11 Jan 2023 08:26:08 -0800 (PST)
Received: from redhat.com ([109.253.181.221])
        by smtp.gmail.com with ESMTPSA id ec11-20020a0564020d4b00b004948dc3d150sm6203670edb.88.2023.01.11.08.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 08:26:07 -0800 (PST)
Date:   Wed, 11 Jan 2023 11:26:02 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "gdawar@amd.com" <gdawar@amd.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tanuj.kamde@amd.com" <tanuj.kamde@amd.com>
Subject: Re: [PATCH 1/5] virtio_ring: per virtqueue dma device
Message-ID: <20230111112541-mutt-send-email-mst@kernel.org>
References: <20230111062809.25020-1-jasowang@redhat.com>
 <20230111062809.25020-2-jasowang@redhat.com>
 <DM8PR12MB5400E61C7E968AC7604556EBABFC9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20230111085210-mutt-send-email-mst@kernel.org>
 <DM8PR12MB54008B92885A8971C4CFED0EABFC9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20230111095358-mutt-send-email-mst@kernel.org>
 <DM8PR12MB54005A89EB05BF46AD7D2DFEABFC9@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR12MB54005A89EB05BF46AD7D2DFEABFC9@DM8PR12MB5400.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 02:58:21PM +0000, Eli Cohen wrote:
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, 11 January 2023 16:54
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: Jason Wang <jasowang@redhat.com>; gdawar@amd.com;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > tanuj.kamde@amd.com
> > Subject: Re: [PATCH 1/5] virtio_ring: per virtqueue dma device
> > 
> > On Wed, Jan 11, 2023 at 02:46:20PM +0000, Eli Cohen wrote:
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Wednesday, 11 January 2023 15:53
> > > > To: Eli Cohen <elic@nvidia.com>
> > > > Cc: Jason Wang <jasowang@redhat.com>; gdawar@amd.com;
> > > > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > > > tanuj.kamde@amd.com
> > > > Subject: Re: [PATCH 1/5] virtio_ring: per virtqueue dma device
> > > >
> > > > On Wed, Jan 11, 2023 at 01:32:20PM +0000, Eli Cohen wrote:
> > > > > > From: Jason Wang <jasowang@redhat.com>
> > > > > > Sent: Wednesday, 11 January 2023 8:28
> > > > > > To: mst@redhat.com; jasowang@redhat.com
> > > > > > Cc: Eli Cohen <elic@nvidia.com>; gdawar@amd.com;
> > > > > > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > > > > > tanuj.kamde@amd.com
> > > > > > Subject: [PATCH 1/5] virtio_ring: per virtqueue dma device
> > > > > >
> > > > > > This patch introduces a per virtqueue dma device. This will be used
> > > > > > for virtio devices whose virtqueue are backed by different underlayer
> > > > > > devices.
> > > > > >
> > > > > > One example is the vDPA that where the control virtqueue could be
> > > > > > implemented through software mediation.
> > > > > >
> > > > > > Some of the work are actually done before since the helper like
> > > > > > vring_dma_device(). This work left are:
> > > > > >
> > > > > > - Let vring_dma_device() return the per virtqueue dma device instead
> > > > > >   of the vdev's parent.
> > > > > > - Allow passing a dma_device when creating the virtqueue through a
> > new
> > > > > >   helper, old vring creation helper will keep using vdev's parent.
> > > > > >
> > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > ---
> > > > > >  drivers/virtio/virtio_ring.c | 133 ++++++++++++++++++++++++-----------
> > > > > >  include/linux/virtio_ring.h  |  16 +++++
> > > > > >  2 files changed, 109 insertions(+), 40 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > index 723c4e29e1d3..41144b5246a8 100644
> > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > @@ -202,6 +202,9 @@ struct vring_virtqueue {
> > > > > >  	/* DMA, allocation, and size information */
> > > > > >  	bool we_own_ring;
> > > > > >
> > > > > > +	/* Device used for doing DMA */
> > > > > > +	struct device *dma_dev;
> > > > > > +
> > > > > >  #ifdef DEBUG
> > > > > >  	/* They're supposed to lock for us. */
> > > > > >  	unsigned int in_use;
> > > > > > @@ -219,7 +222,8 @@ static struct virtqueue
> > > > > > *__vring_new_virtqueue(unsigned int index,
> > > > > >  					       bool context,
> > > > > >  					       bool (*notify)(struct virtqueue *),
> > > > > >  					       void (*callback)(struct virtqueue
> > > > > > *),
> > > > > > -					       const char *name);
> > > > > > +					       const char *name,
> > > > > > +					       struct device *dma_dev);
> > > > > >  static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int
> > num);
> > > > > >  static void vring_free(struct virtqueue *_vq);
> > > > > >
> > > > > > @@ -297,10 +301,11 @@ size_t virtio_max_dma_size(struct
> > virtio_device
> > > > > > *vdev)
> > > > > >  EXPORT_SYMBOL_GPL(virtio_max_dma_size);
> > > > > >
> > > > > >  static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
> > > > > > -			      dma_addr_t *dma_handle, gfp_t flag)
> > > > > > +			       dma_addr_t *dma_handle, gfp_t flag,
> > > > > > +			       struct device *dma_dev)
> > > > > >  {
> > > > > >  	if (vring_use_dma_api(vdev)) {
> > > > > > -		return dma_alloc_coherent(vdev->dev.parent, size,
> > > > > > +		return dma_alloc_coherent(dma_dev, size,
> > > > > >  					  dma_handle, flag);
> > > > > >  	} else {
> > > > > >  		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
> > > > > > @@ -330,10 +335,11 @@ static void *vring_alloc_queue(struct
> > > > virtio_device
> > > > > > *vdev, size_t size,
> > > > > >  }
> > > > > >
> > > > > >  static void vring_free_queue(struct virtio_device *vdev, size_t size,
> > > > > > -			     void *queue, dma_addr_t dma_handle)
> > > > > > +			     void *queue, dma_addr_t dma_handle,
> > > > > > +			     struct device *dma_dev)
> > > > > >  {
> > > > > >  	if (vring_use_dma_api(vdev))
> > > > > > -		dma_free_coherent(vdev->dev.parent, size, queue,
> > > > > > dma_handle);
> > > > > > +		dma_free_coherent(dma_dev, size, queue,
> > dma_handle);
> > > > > >  	else
> > > > > >  		free_pages_exact(queue, PAGE_ALIGN(size));
> > > > > >  }
> > > > > > @@ -341,11 +347,11 @@ static void vring_free_queue(struct
> > > > virtio_device
> > > > > > *vdev, size_t size,
> > > > > >  /*
> > > > > >   * The DMA ops on various arches are rather gnarly right now, and
> > > > > >   * making all of the arch DMA ops work on the vring device itself
> > > > > > - * is a mess.  For now, we use the parent device for DMA ops.
> > > > > > + * is a mess.
> > > > > >   */
> > > > > >  static inline struct device *vring_dma_dev(const struct
> > vring_virtqueue
> > > > *vq)
> > > > > >  {
> > > > > > -	return vq->vq.vdev->dev.parent;
> > > > > > +	return vq->dma_dev;
> > > > > >  }
> > > > >
> > > > > How about getting rid of this function and just use vq->dma_dev?
> > > >
> > > > Will make the patch even bigger than it is.
> > >
> > > I can't see how this can happen. You get rid of the function and you lose
> > overall 10 lines. What am I missing?
> > 
> > This is an existing function, if you drop it you need to refactor
> > more of the existing code. No?
> It's static function in the file that is used whenever you need the dma device.

my point is if we remove it we need to change all it's callers.

> > > > If you do patch on top pls.
> > >
> 

