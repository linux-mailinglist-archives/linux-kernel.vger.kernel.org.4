Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E362637296
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 07:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiKXG40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 01:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiKXG4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:56:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6639C2A8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 22:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669272930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tejdroVaE+DmvJLuZIiydGkuFxW1u1MHaoKXEp3xDjQ=;
        b=COJcXF0u4mji+wx97QW0MuPYz2Qr5XaSfwLXdWQjTRZQAS1MB03c0opQBW8Bw3NsbAUrmv
        OebVKVcVH6HZivHw0WtsnrNJV8yh1PdED1tawTrLnAqoSrKYGd+0r8HXYFyo4Xhf8NoIDz
        R0EDWkToAAW77ON2y7ZmGvPWRENL1xA=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-26-xjKmdPcwO_at9Bt5jdY_sQ-1; Thu, 24 Nov 2022 01:55:29 -0500
X-MC-Unique: xjKmdPcwO_at9Bt5jdY_sQ-1
Received: by mail-vk1-f199.google.com with SMTP id c144-20020a1f1c96000000b003bc20c37566so290050vkc.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 22:55:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tejdroVaE+DmvJLuZIiydGkuFxW1u1MHaoKXEp3xDjQ=;
        b=ga5JotzhqZu2/7nRn3YhaNymKCQaLSefT42GnetwuZdLMl5f7d05WvDhY78lOQhQU7
         qCZKISF3uueUQuTP3HVNBUXhammmAVt2dlLmeqbnOzEXbUO5hxLjv+nNfMjnRmlTJS0C
         j+Fm8mYrMbejSC1vK6qy58srh2LhuowewDyFZ76pSps9qEvezSAd0+PekVss1XYrZsCQ
         rkQPb6PJ+Nskmg5EG9glm2yIiZLpZEECsQ0uEUiAZIVYseeR8GspuuJpwxLu3hqll4eN
         hSrjmz1uE/KMgkJqJ0wWi7PaWtwSxCgOQRoSxtz1WNfnvLYG/oOhV2KCHjRykLSnsTml
         SQVw==
X-Gm-Message-State: ANoB5pmbd28AMFvskDfrUUahZo5MMVTA4p90DsAGaieMmGXkM27SqDmZ
        CmONKcu6ObUeB8kEdlRwpRaXvmZCogE5pdGaphMPcuWKcKVFqW6vmqxCTO29q01S+z5vRTqJ7mS
        CPbWUrNSKfSHAPRJql6zKXw6CgL2n5e3NEmrJV7TZ
X-Received: by 2002:a1f:4317:0:b0:3b8:b112:5edb with SMTP id q23-20020a1f4317000000b003b8b1125edbmr17704851vka.39.1669272928582;
        Wed, 23 Nov 2022 22:55:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf53SDHGBIzjDGwRZ4+TwK4JBN+i5sgy+8RkRx7InaUNztD+CfDyYRDnJWkzVk4XOt/EYgkZHoLDm7IYR1p7O1Q=
X-Received: by 2002:a1f:4317:0:b0:3b8:b112:5edb with SMTP id
 q23-20020a1f4317000000b003b8b1125edbmr17704842vka.39.1669272928297; Wed, 23
 Nov 2022 22:55:28 -0800 (PST)
MIME-Version: 1.0
References: <20221124062309.2081720-1-lulu@redhat.com> <CACGkMEupFLwNFvGkU_vgDmhzY9K=b0KFC4BkWGVfO3s+GEWaKQ@mail.gmail.com>
In-Reply-To: <CACGkMEupFLwNFvGkU_vgDmhzY9K=b0KFC4BkWGVfO3s+GEWaKQ@mail.gmail.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Thu, 24 Nov 2022 14:54:52 +0800
Message-ID: <CACLfguVdprDi=KUPiBzoTQtRkL29z=e79ku+tMYC7AhpekeQKQ@mail.gmail.com>
Subject: Re: [PATCH] vhost_vdpa: fix the crash in unmap a large memory
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2022 at 14:34, Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, Nov 24, 2022 at 2:23 PM Cindy Lu <lulu@redhat.com> wrote:
> >
> > While testing in vIOMMU, sometimes guest will unmap very large memory,
> > which will cause the crash.
>
> Would you mind to post the calltrace?
>
Sure, Will add this, Thanks Jason

> > To fix this,Move the iommu_unmap to
> > vhost_vdpa_pa_unmap/vhost_vdpa_va_unmap and only unmap the memory
> > that saved in iotlb.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> Let's add a fixes tag which I believe should be the first commit that
> introduces vhost-vDPA. And let's cc stable as well.
>
sure, will do.
> > ---
> >  drivers/vhost/vdpa.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index 166044642fd5..c392979702cf 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -692,6 +692,8 @@ static void vhost_vdpa_pa_unmap(struct vhost_vdpa *v,
> >         struct vhost_iotlb_map *map;
> >         struct page *page;
> >         unsigned long pfn, pinned;
> > +       struct vdpa_device *vdpa = v->vdpa;
> > +       const struct vdpa_config_ops *ops = vdpa->config;
> >
> >         while ((map = vhost_iotlb_itree_first(iotlb, start, last)) != NULL) {
> >                 pinned = PFN_DOWN(map->size);
> > @@ -703,6 +705,8 @@ static void vhost_vdpa_pa_unmap(struct vhost_vdpa *v,
> >                         unpin_user_page(page);
> >                 }
> >                 atomic64_sub(PFN_DOWN(map->size), &dev->mm->pinned_vm);
> > +               if ((ops->dma_map == NULL) && (ops->set_map == NULL))
> > +                       iommu_unmap(v->domain, map->start, map->size);
> >                 vhost_iotlb_map_free(iotlb, map);
> >         }
> >  }
> > @@ -713,11 +717,15 @@ static void vhost_vdpa_va_unmap(struct vhost_vdpa *v,
> >  {
> >         struct vhost_iotlb_map *map;
> >         struct vdpa_map_file *map_file;
> > +       struct vdpa_device *vdpa = v->vdpa;
> > +       const struct vdpa_config_ops *ops = vdpa->config;
> >
> >         while ((map = vhost_iotlb_itree_first(iotlb, start, last)) != NULL) {
> >                 map_file = (struct vdpa_map_file *)map->opaque;
> >                 fput(map_file->file);
> >                 kfree(map_file);
> > +               if ((ops->dma_map == NULL) && (ops->set_map == NULL))
> > +                       iommu_unmap(v->domain, map->start, map->size);
>
> I wonder if it's better to move at least dma_map() here.
>
> Thanks
>
sure, will remove this , thanks will provide a new version soon
> >                 vhost_iotlb_map_free(iotlb, map);
> >         }
> >  }
> > @@ -805,8 +813,6 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v,
> >         } else if (ops->set_map) {
> >                 if (!v->in_batch)
> >                         ops->set_map(vdpa, asid, iotlb);
> > -       } else {
> > -               iommu_unmap(v->domain, iova, size);
> >         }
> >
> >         /* If we are in the middle of batch processing, delay the free
> > --
> > 2.34.3
> >
>

