Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0CB6FD4F2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 06:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbjEJEID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 00:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjEJEHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 00:07:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321A5268A
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 21:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683691622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gUMwiiMo+uImtVa1NMnxeZGa2c1vgyzXNYzjiq0BCYA=;
        b=SWY0uqYmeRQGzWUhqi4VtQYgJeFTPxD1sgBa4CqdFJJD/iKFZ29oiXTnHGwg5zTZh21tLf
        ityJXvJNnesxoOB3uqS8uRsZLJX6G76SPCflNBPeiNSXqUxUI3bLhfpEXKeC+8flYY/ttR
        8Hup7HVnv0nHe5zveLoQKGAGopDBOpU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-Yp6Rftc2NN--iDDc1gJ9dQ-1; Wed, 10 May 2023 00:07:00 -0400
X-MC-Unique: Yp6Rftc2NN--iDDc1gJ9dQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-965cd056598so746275566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 21:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683691620; x=1686283620;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gUMwiiMo+uImtVa1NMnxeZGa2c1vgyzXNYzjiq0BCYA=;
        b=CNDgFZdmqrw2gegfMNdta/VZ/PmFowqlfSeJyvz/N3hneHvyavXsQJxPVXrazXPqod
         XgjLGT8pXYieVCTrCRdWVl0f8NHvODRFV2BCzUcUKjAl0FQ5GhtHv9gO3/PHLhFn9zUD
         l7500rZtwDl6HN5F9Q34BYPmp2IKq5qjsniQFl4Ec2P23/GKTs8fFANe12B7vUHOBWCL
         mKdiJiUsiUICieh/zJYazrT4ntS6hEiSS2EoRU3WplVpYeYDnEiBnIibrr+KrxMTlhxe
         WNbYdrTsx5Rh+gWN2OB8BO+/fjZB2gnvJmppt1tRDAoPv+XTToMghN3KhtWW0J3oTFlB
         RHHg==
X-Gm-Message-State: AC+VfDyxkNA2nH5ZxzPlpVx3vN5EFMXrcr2QOKNF5/XGZ0GAfTtCpg/j
        XIZSQpNLU6F+J0WH1kve2/SplcbXUm7pvy4BLgoAeMRRw/LJkgYfv/AUbWuWwlQdFSdlhaR+OJC
        9PoiDEguOzGfGqwsJGKTdg21v
X-Received: by 2002:a17:906:974b:b0:957:943e:7416 with SMTP id o11-20020a170906974b00b00957943e7416mr16092527ejy.15.1683691619889;
        Tue, 09 May 2023 21:06:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ASWwnTtQgH66opLJjp20JjkoXCAaF1TMqwqlbANYYaPhCUcoC3US8+hYl0Ip1aqx4KRzvaA==
X-Received: by 2002:a17:906:974b:b0:957:943e:7416 with SMTP id o11-20020a170906974b00b00957943e7416mr16092513ejy.15.1683691619610;
        Tue, 09 May 2023 21:06:59 -0700 (PDT)
Received: from redhat.com ([176.119.195.36])
        by smtp.gmail.com with ESMTPSA id hx8-20020a170906846800b00965e839f56bsm2088336ejc.182.2023.05.09.21.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 21:06:59 -0700 (PDT)
Date:   Wed, 10 May 2023 00:06:54 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        zhenwei pi <pizhenwei@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] virtio_ring: use u32 for virtio_max_dma_size
Message-ID: <20230510000603-mutt-send-email-mst@kernel.org>
References: <20230510025437.377807-1-pizhenwei@bytedance.com>
 <1683689214.9647853-1-xuanzhuo@linux.alibaba.com>
 <20230509233907-mutt-send-email-mst@kernel.org>
 <CACGkMEujVhZrU2Wa3=-6DAgK5x8suC9EDxMxt5nN3Y1-LAVcUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEujVhZrU2Wa3=-6DAgK5x8suC9EDxMxt5nN3Y1-LAVcUA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 12:04:50PM +0800, Jason Wang wrote:
> On Wed, May 10, 2023 at 11:44 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, May 10, 2023 at 11:26:54AM +0800, Xuan Zhuo wrote:
> > > On Wed, 10 May 2023 10:54:37 +0800, zhenwei pi <pizhenwei@bytedance.com> wrote:
> > > > Both split ring and packed ring use 32bits to describe the length of
> > > > a descriptor: see struct vring_desc and struct vring_packed_desc.
> > > > This means the max segment size supported by virtio is U32_MAX.
> > > >
> > > > An example of virtio_max_dma_size in virtio_blk.c:
> > > >   u32 v, max_size;
> > > >
> > > >   max_size = virtio_max_dma_size(vdev);  -> implicit convert
> > > >   err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SIZE_MAX,
> > > >                              struct virtio_blk_config, size_max, &v);
> > > >   max_size = min(max_size, v);
> > > >
> > > > There is a risk during implicit convert here, once virtio_max_dma_size
> > > > returns 4G, max_size becomes 0.
> > > >
> > > > Fixes: e6d6dd6c875e ("virtio: Introduce virtio_max_dma_size()")
> > > > Cc: Joerg Roedel <jroedel@suse.de>
> > > > Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 12 ++++++++----
> > > >  include/linux/virtio.h       |  2 +-
> > > >  2 files changed, 9 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > index c5310eaf8b46..55cfecf030a1 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -289,12 +289,16 @@ static bool vring_use_dma_api(const struct virtio_device *vdev)
> > > >     return false;
> > > >  }
> > > >
> > > > -size_t virtio_max_dma_size(const struct virtio_device *vdev)
> > > > +u32 virtio_max_dma_size(const struct virtio_device *vdev)
> > >
> > >
> > > LGTM
> > >
> > > But, should we change the parameter to vq, then use the dma_dev?
> > >
> > > @Jason
> > >
> > > Thanks.
> > >
> >
> >
> > that would be an unrelated rework.
> 
> Probably, but I think it's better to be done on top otherwise we may forget.
> 
> Thanks

Just to make things clear I'm merging fixes for this
release but cleanups belong in the next one.

> >
> > > >  {
> > > > -   size_t max_segment_size = SIZE_MAX;
> > > > +   u32 max_segment_size = U32_MAX;
> > > >
> > > > -   if (vring_use_dma_api(vdev))
> > > > -           max_segment_size = dma_max_mapping_size(vdev->dev.parent);
> > > > +   if (vring_use_dma_api(vdev)) {
> > > > +           size_t max_dma_size = dma_max_mapping_size(vdev->dev.parent);
> > > > +
> > > > +           if (max_dma_size < max_segment_size)
> > > > +                   max_segment_size = max_dma_size;
> > > > +   }
> > > >
> > > >     return max_segment_size;
> > > >  }
> > > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > > index b93238db94e3..1a605f408329 100644
> > > > --- a/include/linux/virtio.h
> > > > +++ b/include/linux/virtio.h
> > > > @@ -147,7 +147,7 @@ int virtio_device_restore(struct virtio_device *dev);
> > > >  #endif
> > > >  void virtio_reset_device(struct virtio_device *dev);
> > > >
> > > > -size_t virtio_max_dma_size(const struct virtio_device *vdev);
> > > > +u32 virtio_max_dma_size(const struct virtio_device *vdev);
> > > >
> > > >  #define virtio_device_for_each_vq(vdev, vq) \
> > > >     list_for_each_entry(vq, &vdev->vqs, list)
> > > > --
> > > > 2.20.1
> > > >
> >

