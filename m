Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC0D665D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjAKNyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238657AbjAKNx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:53:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D202165C7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673445160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EVXd0+tTmNanAqtPTUXnzWMvK7HgkczZRyk87Gekezw=;
        b=ax7jTDmjXaevws4mYIClrQ+WypILTr5hR/x8vnS0TOywqMhghkaSL06vTeloqyrwqSTXZj
        eDt0H4Beeu8Cg3ndXv3DBt27l8fBhfOSng1jJr7Zs8ia7MUfYLKfvjA2zkqsDOcT8wi6Ri
        /TKTpuRG0oib3aWXhAj5eimh/4g4EyU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-437-S0O_Q73SONqZ_n6c7E_tVg-1; Wed, 11 Jan 2023 08:52:39 -0500
X-MC-Unique: S0O_Q73SONqZ_n6c7E_tVg-1
Received: by mail-wr1-f70.google.com with SMTP id u4-20020adfc644000000b002ad64393461so2711033wrg.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:52:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVXd0+tTmNanAqtPTUXnzWMvK7HgkczZRyk87Gekezw=;
        b=fhRFV1NBuf6mynxdUY+6ToCAfjoT/JMl/qofWsBKbBGbJLiHtil+efY002biesbB1B
         W8lYXh7UYWVwZxoOj1zM10VfZGxUpdlr8aXMnH2G0GrUHgvLoQ9cXmNI3gwMgptFb+PB
         A/z04wOlduRQHu+g86evyeHFLna+rrkDNB4Jkl7uXCo/hUUeGVq8/i38mkOYaQX7sRuU
         NttuZNDiPUxAlCfrDiXXmUtlG5kI8w5b6JxD8vsQzYUblZmAHEGR4Y0C40jceEqS4Nzb
         kP62FDpdoopms4RlFDYlLEvnNdJcdVLmY+0F4o9n7uSK7n5DoJBd5HzwmTiC2Xv4aegN
         OS0w==
X-Gm-Message-State: AFqh2krc14UZL1cG6K86Z9ulcWlcGHZZiLqFbfH+qMJkm+msXRNn5KnY
        ZGhM6Ho3UmNAdgGUgW52J6V+iJvUFk5gAWL+t4cJoPbDFsvSWu21HBpUtaaJhzW0N82gihdF85b
        cJSTTrEu8seztJIrSdpxLtHbY
X-Received: by 2002:a05:6000:910:b0:242:733b:af28 with SMTP id bz16-20020a056000091000b00242733baf28mr61561358wrb.5.1673445158339;
        Wed, 11 Jan 2023 05:52:38 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvZsLF5O5by/jN4b7/Dxocy8fV9SSbKWgBeKVV6PBIXB42ZP1FOxfklK2qKs3KZ6zIt+ghfMw==
X-Received: by 2002:a05:6000:910:b0:242:733b:af28 with SMTP id bz16-20020a056000091000b00242733baf28mr61561341wrb.5.1673445158119;
        Wed, 11 Jan 2023 05:52:38 -0800 (PST)
Received: from redhat.com ([2.52.157.155])
        by smtp.gmail.com with ESMTPSA id m10-20020adff38a000000b002bc83b85180sm5361050wro.114.2023.01.11.05.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 05:52:37 -0800 (PST)
Date:   Wed, 11 Jan 2023 08:52:34 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "gdawar@amd.com" <gdawar@amd.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tanuj.kamde@amd.com" <tanuj.kamde@amd.com>
Subject: Re: [PATCH 1/5] virtio_ring: per virtqueue dma device
Message-ID: <20230111085210-mutt-send-email-mst@kernel.org>
References: <20230111062809.25020-1-jasowang@redhat.com>
 <20230111062809.25020-2-jasowang@redhat.com>
 <DM8PR12MB5400E61C7E968AC7604556EBABFC9@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR12MB5400E61C7E968AC7604556EBABFC9@DM8PR12MB5400.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 01:32:20PM +0000, Eli Cohen wrote:
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, 11 January 2023 8:28
> > To: mst@redhat.com; jasowang@redhat.com
> > Cc: Eli Cohen <elic@nvidia.com>; gdawar@amd.com;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > tanuj.kamde@amd.com
> > Subject: [PATCH 1/5] virtio_ring: per virtqueue dma device
> > 
> > This patch introduces a per virtqueue dma device. This will be used
> > for virtio devices whose virtqueue are backed by different underlayer
> > devices.
> > 
> > One example is the vDPA that where the control virtqueue could be
> > implemented through software mediation.
> > 
> > Some of the work are actually done before since the helper like
> > vring_dma_device(). This work left are:
> > 
> > - Let vring_dma_device() return the per virtqueue dma device instead
> >   of the vdev's parent.
> > - Allow passing a dma_device when creating the virtqueue through a new
> >   helper, old vring creation helper will keep using vdev's parent.
> > 
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 133 ++++++++++++++++++++++++-----------
> >  include/linux/virtio_ring.h  |  16 +++++
> >  2 files changed, 109 insertions(+), 40 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 723c4e29e1d3..41144b5246a8 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -202,6 +202,9 @@ struct vring_virtqueue {
> >  	/* DMA, allocation, and size information */
> >  	bool we_own_ring;
> > 
> > +	/* Device used for doing DMA */
> > +	struct device *dma_dev;
> > +
> >  #ifdef DEBUG
> >  	/* They're supposed to lock for us. */
> >  	unsigned int in_use;
> > @@ -219,7 +222,8 @@ static struct virtqueue
> > *__vring_new_virtqueue(unsigned int index,
> >  					       bool context,
> >  					       bool (*notify)(struct virtqueue *),
> >  					       void (*callback)(struct virtqueue
> > *),
> > -					       const char *name);
> > +					       const char *name,
> > +					       struct device *dma_dev);
> >  static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
> >  static void vring_free(struct virtqueue *_vq);
> > 
> > @@ -297,10 +301,11 @@ size_t virtio_max_dma_size(struct virtio_device
> > *vdev)
> >  EXPORT_SYMBOL_GPL(virtio_max_dma_size);
> > 
> >  static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
> > -			      dma_addr_t *dma_handle, gfp_t flag)
> > +			       dma_addr_t *dma_handle, gfp_t flag,
> > +			       struct device *dma_dev)
> >  {
> >  	if (vring_use_dma_api(vdev)) {
> > -		return dma_alloc_coherent(vdev->dev.parent, size,
> > +		return dma_alloc_coherent(dma_dev, size,
> >  					  dma_handle, flag);
> >  	} else {
> >  		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
> > @@ -330,10 +335,11 @@ static void *vring_alloc_queue(struct virtio_device
> > *vdev, size_t size,
> >  }
> > 
> >  static void vring_free_queue(struct virtio_device *vdev, size_t size,
> > -			     void *queue, dma_addr_t dma_handle)
> > +			     void *queue, dma_addr_t dma_handle,
> > +			     struct device *dma_dev)
> >  {
> >  	if (vring_use_dma_api(vdev))
> > -		dma_free_coherent(vdev->dev.parent, size, queue,
> > dma_handle);
> > +		dma_free_coherent(dma_dev, size, queue, dma_handle);
> >  	else
> >  		free_pages_exact(queue, PAGE_ALIGN(size));
> >  }
> > @@ -341,11 +347,11 @@ static void vring_free_queue(struct virtio_device
> > *vdev, size_t size,
> >  /*
> >   * The DMA ops on various arches are rather gnarly right now, and
> >   * making all of the arch DMA ops work on the vring device itself
> > - * is a mess.  For now, we use the parent device for DMA ops.
> > + * is a mess.
> >   */
> >  static inline struct device *vring_dma_dev(const struct vring_virtqueue *vq)
> >  {
> > -	return vq->vq.vdev->dev.parent;
> > +	return vq->dma_dev;
> >  }
> 
> How about getting rid of this function and just use vq->dma_dev?

Will make the patch even bigger than it is.
If you do patch on top pls.

