Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA376FD4F1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 06:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbjEJEHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 00:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbjEJEH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 00:07:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0959E4EEE
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 21:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683691505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z4Nlt17NcD4TBcFZ5r4aDYoMl3ENzhd2Xf+fmrXbyX8=;
        b=MNfCso/Qcw2aAlUlJv8QWo11rGI4grGnpTcCvagmW5s6qPBIOlFNnWvx2IJMqt6a91L7qR
        eT/IflqObkv1AedinAwhbmZLGyKEo51U3K+Ce7Y02I/dX+9GkcTgeCzVMWvkx+secrCwsX
        NB74+mOMhcp+jQMGbyOwFaryqtldpoE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-t9SEApTJPVGefwkEukQmKA-1; Wed, 10 May 2023 00:05:03 -0400
X-MC-Unique: t9SEApTJPVGefwkEukQmKA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ac820107efso32264591fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 21:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683691502; x=1686283502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4Nlt17NcD4TBcFZ5r4aDYoMl3ENzhd2Xf+fmrXbyX8=;
        b=G0/kf/eDH62bSHAlFqnJv6maOykQALnjMtUqwnwbnbJqF38f+k/bw69Lw/vIKOCeqa
         /OpC8UH0eiRwLLczumra0CdBZeDOV5QzW0CQvUOcTZv5otFE2kg1d1DnznmFIB1G/UPu
         3C0MmG8oNC7MZJWGcfLekn9nmJvn+dXbJPg6HDEnDBoc4gJ6k/YE9UGm/yizefkg5GIB
         WAgKkkz81XuClvWb59OcoB4B/OJxLkIqUbWkK4fM2+TLT87nxlUNOIahn7BV//WGCyI6
         zO70aBycUVz+xzErv+s0PJCaZBBN7iF3VA9KZY57y6VJ5rWSb+vH3ezqGQa56s0Mm4l5
         salw==
X-Gm-Message-State: AC+VfDzNSYgnr9FY02bw8ORpIsp7xs/9+uAiRaxQOEYq21RXo4LO+Z8D
        F2aQigTFDrrgpwucAyCAAWuUEc2fr0ipJaDXPuSXcKKvMpfJctkvmZD+mIfi+bxXag3t9tqUkcL
        aFwu2pgbb2g97B62eaZmF5CBiCiNk9SBhSUAYaV7g
X-Received: by 2002:a2e:7e05:0:b0:2ad:ab12:e4ce with SMTP id z5-20020a2e7e05000000b002adab12e4cemr991261ljc.7.1683691502291;
        Tue, 09 May 2023 21:05:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ61XER0BbsIE0Oj6R89yWvvxieAfdCSEO/TD30qyT1tZYfhyh3/Juv1WLBew+wAMjjfqnfqCHSn34db0a4HYZo=
X-Received: by 2002:a2e:7e05:0:b0:2ad:ab12:e4ce with SMTP id
 z5-20020a2e7e05000000b002adab12e4cemr991257ljc.7.1683691501938; Tue, 09 May
 2023 21:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230510025437.377807-1-pizhenwei@bytedance.com>
 <1683689214.9647853-1-xuanzhuo@linux.alibaba.com> <20230509233907-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230509233907-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 10 May 2023 12:04:50 +0800
Message-ID: <CACGkMEujVhZrU2Wa3=-6DAgK5x8suC9EDxMxt5nN3Y1-LAVcUA@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: use u32 for virtio_max_dma_size
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        zhenwei pi <pizhenwei@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 11:44=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Wed, May 10, 2023 at 11:26:54AM +0800, Xuan Zhuo wrote:
> > On Wed, 10 May 2023 10:54:37 +0800, zhenwei pi <pizhenwei@bytedance.com=
> wrote:
> > > Both split ring and packed ring use 32bits to describe the length of
> > > a descriptor: see struct vring_desc and struct vring_packed_desc.
> > > This means the max segment size supported by virtio is U32_MAX.
> > >
> > > An example of virtio_max_dma_size in virtio_blk.c:
> > >   u32 v, max_size;
> > >
> > >   max_size =3D virtio_max_dma_size(vdev);  -> implicit convert
> > >   err =3D virtio_cread_feature(vdev, VIRTIO_BLK_F_SIZE_MAX,
> > >                              struct virtio_blk_config, size_max, &v);
> > >   max_size =3D min(max_size, v);
> > >
> > > There is a risk during implicit convert here, once virtio_max_dma_siz=
e
> > > returns 4G, max_size becomes 0.
> > >
> > > Fixes: e6d6dd6c875e ("virtio: Introduce virtio_max_dma_size()")
> > > Cc: Joerg Roedel <jroedel@suse.de>
> > > Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 12 ++++++++----
> > >  include/linux/virtio.h       |  2 +-
> > >  2 files changed, 9 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index c5310eaf8b46..55cfecf030a1 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -289,12 +289,16 @@ static bool vring_use_dma_api(const struct virt=
io_device *vdev)
> > >     return false;
> > >  }
> > >
> > > -size_t virtio_max_dma_size(const struct virtio_device *vdev)
> > > +u32 virtio_max_dma_size(const struct virtio_device *vdev)
> >
> >
> > LGTM
> >
> > But, should we change the parameter to vq, then use the dma_dev?
> >
> > @Jason
> >
> > Thanks.
> >
>
>
> that would be an unrelated rework.

Probably, but I think it's better to be done on top otherwise we may forget=
.

Thanks

>
> > >  {
> > > -   size_t max_segment_size =3D SIZE_MAX;
> > > +   u32 max_segment_size =3D U32_MAX;
> > >
> > > -   if (vring_use_dma_api(vdev))
> > > -           max_segment_size =3D dma_max_mapping_size(vdev->dev.paren=
t);
> > > +   if (vring_use_dma_api(vdev)) {
> > > +           size_t max_dma_size =3D dma_max_mapping_size(vdev->dev.pa=
rent);
> > > +
> > > +           if (max_dma_size < max_segment_size)
> > > +                   max_segment_size =3D max_dma_size;
> > > +   }
> > >
> > >     return max_segment_size;
> > >  }
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index b93238db94e3..1a605f408329 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -147,7 +147,7 @@ int virtio_device_restore(struct virtio_device *d=
ev);
> > >  #endif
> > >  void virtio_reset_device(struct virtio_device *dev);
> > >
> > > -size_t virtio_max_dma_size(const struct virtio_device *vdev);
> > > +u32 virtio_max_dma_size(const struct virtio_device *vdev);
> > >
> > >  #define virtio_device_for_each_vq(vdev, vq) \
> > >     list_for_each_entry(vq, &vdev->vqs, list)
> > > --
> > > 2.20.1
> > >
>

