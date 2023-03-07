Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CD36ADA6B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjCGJcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjCGJcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:32:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F164FF09
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678181469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ROZo+Hm2nwaruvzp5tLmXfiaUhDZcP6CcaTEU4f9q20=;
        b=S+QR1ImOrGwQjLROwzTPinvPUwbWczYv+5HAS0pm3qLpbJ0Mtfzm9ESXsp8yv0yaJ17mwZ
        erR/qnq4Y/4+6N3ahnWqAd9eAsVV/r2qZolfAoW9TMxCGqlQ4qe0WeXqmftRnes8DJ/Fq6
        M2/mv0/meIN8aOtFdG1Z31ePSO02QWg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-oEPeaenHMWmgtO-m3cAMPQ-1; Tue, 07 Mar 2023 04:31:08 -0500
X-MC-Unique: oEPeaenHMWmgtO-m3cAMPQ-1
Received: by mail-wr1-f69.google.com with SMTP id 15-20020a056000156f00b002ca79db6d42so2030537wrz.18
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 01:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678181465;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ROZo+Hm2nwaruvzp5tLmXfiaUhDZcP6CcaTEU4f9q20=;
        b=AxrVCrDk4H3AiHZYpAtrqDQ4jp/DZkwcNXzd5UoQjKVU1/1hSpw5PmooxVKs+sMt7r
         HtqL5Rchrzlmu6ljp6Q40wpq5U9ZINT6LmhEyBzCaU0WyhYDPXFM/QHV/OgNMe3OAwmA
         dwVvnJMqXzjnaQIPb8/3+/SUjzmBHSzZBYGu66QJIgBTSXtDWOFaZlxxvns07ho0y8wJ
         0ctbM8wJe5e1t94+HQNrQNKHo5eii2Da+2wAg3HVxl+Ig4cxPG9ewfuEpshzbMKUzj2M
         CLro0sQTnE5Rmckk2SY0nUIgp5kBgAmFmOMStkeA7X9UtREkGXRrfdbM6vIT4TOCe0Wq
         RpoA==
X-Gm-Message-State: AO0yUKXeWKfuIVzLYm0Rv+rWbuNEheoByR5aywXZhd8Gh89V/3oijkCQ
        snnjfz4B+LXjjaohx3mvAIA/pTcJao5ejLzBGsjY9cgfBfIQPiQde6BnhN71fCZxpdcFuogqEcG
        tOb/4qo5NcgSJPZ5kcqmBUTZu
X-Received: by 2002:a05:600c:474f:b0:3df:deb5:6ff5 with SMTP id w15-20020a05600c474f00b003dfdeb56ff5mr12407882wmo.24.1678181465556;
        Tue, 07 Mar 2023 01:31:05 -0800 (PST)
X-Google-Smtp-Source: AK7set8nRlHuSVvS3Y2XSx89Qt+KslRCgHQzi54Bw407xKpxIWyRaTqJXGns7ik+zzvdl7UyrHzyXg==
X-Received: by 2002:a05:600c:474f:b0:3df:deb5:6ff5 with SMTP id w15-20020a05600c474f00b003dfdeb56ff5mr12407858wmo.24.1678181465188;
        Tue, 07 Mar 2023 01:31:05 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it. [82.57.51.170])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d594f000000b002c56046a3b5sm12073447wri.53.2023.03.07.01.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 01:31:04 -0800 (PST)
Date:   Tue, 7 Mar 2023 10:31:01 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        netdev@vger.kernel.org, stefanha@redhat.com,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v2 4/8] vringh: support VA with iotlb
Message-ID: <20230307093101.3nfxhadkyevszmyj@sgarzare-redhat>
References: <20230302113421.174582-1-sgarzare@redhat.com>
 <20230302113421.174582-5-sgarzare@redhat.com>
 <CAJaqyWdeEzKnYuX-c348vVg0PpUH4y-e1dSLhRvYem=MEDKE=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWdeEzKnYuX-c348vVg0PpUH4y-e1dSLhRvYem=MEDKE=Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 03:38:57PM +0100, Eugenio Perez Martin wrote:
>On Thu, Mar 2, 2023 at 12:35 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> vDPA supports the possibility to use user VA in the iotlb messages.
>> So, let's add support for user VA in vringh to use it in the vDPA
>> simulators.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>
>> Notes:
>>     v2:
>>     - replace kmap_atomic() with kmap_local_page() [see previous patch]
>>     - fix cast warnings when build with W=1 C=1
>>
>>  include/linux/vringh.h            |   5 +-
>>  drivers/vdpa/mlx5/net/mlx5_vnet.c |   2 +-
>>  drivers/vdpa/vdpa_sim/vdpa_sim.c  |   4 +-
>>  drivers/vhost/vringh.c            | 247 ++++++++++++++++++++++++------
>>  4 files changed, 205 insertions(+), 53 deletions(-)
>>
>> diff --git a/include/linux/vringh.h b/include/linux/vringh.h
>> index 1991a02c6431..d39b9f2dcba0 100644
>> --- a/include/linux/vringh.h
>> +++ b/include/linux/vringh.h
>> @@ -32,6 +32,9 @@ struct vringh {
>>         /* Can we get away with weak barriers? */
>>         bool weak_barriers;
>>
>> +       /* Use user's VA */
>> +       bool use_va;
>> +
>>         /* Last available index we saw (ie. where we're up to). */
>>         u16 last_avail_idx;
>>
>> @@ -279,7 +282,7 @@ void vringh_set_iotlb(struct vringh *vrh, struct vhost_iotlb *iotlb,
>>                       spinlock_t *iotlb_lock);
>>
>>  int vringh_init_iotlb(struct vringh *vrh, u64 features,
>> -                     unsigned int num, bool weak_barriers,
>> +                     unsigned int num, bool weak_barriers, bool use_va,
>>                       struct vring_desc *desc,
>>                       struct vring_avail *avail,
>>                       struct vring_used *used);
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index 3a0e721aef05..babc8dd171a6 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -2537,7 +2537,7 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
>>
>>         if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ))
>>                 err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
>> -                                       MLX5_CVQ_MAX_ENT, false,
>> +                                       MLX5_CVQ_MAX_ENT, false, false,
>>                                         (struct vring_desc *)(uintptr_t)cvq->desc_addr,
>>                                         (struct vring_avail *)(uintptr_t)cvq->driver_addr,
>>                                         (struct vring_used *)(uintptr_t)cvq->device_addr);
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> index 6a0a65814626..481eb156658b 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -60,7 +60,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
>>         struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>>         uint16_t last_avail_idx = vq->vring.last_avail_idx;
>>
>> -       vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, true,
>> +       vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, true, false,
>>                           (struct vring_desc *)(uintptr_t)vq->desc_addr,
>>                           (struct vring_avail *)
>>                           (uintptr_t)vq->driver_addr,
>> @@ -81,7 +81,7 @@ static void vdpasim_vq_reset(struct vdpasim *vdpasim,
>>         vq->cb = NULL;
>>         vq->private = NULL;
>>         vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
>> -                         VDPASIM_QUEUE_MAX, false, NULL, NULL, NULL);
>> +                         VDPASIM_QUEUE_MAX, false, false, NULL, NULL, NULL);
>>
>>         vq->vring.notify = NULL;
>>  }
>> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
>> index 0ba3ef809e48..61c79cea44ca 100644
>> --- a/drivers/vhost/vringh.c
>> +++ b/drivers/vhost/vringh.c
>> @@ -1094,15 +1094,99 @@ EXPORT_SYMBOL(vringh_need_notify_kern);
>>
>>  #if IS_REACHABLE(CONFIG_VHOST_IOTLB)
>>
>> -static int iotlb_translate(const struct vringh *vrh,
>> -                          u64 addr, u64 len, u64 *translated,
>> -                          struct bio_vec iov[],
>> -                          int iov_size, u32 perm)
>> +static int iotlb_translate_va(const struct vringh *vrh,
>> +                             u64 addr, u64 len, u64 *translated,
>> +                             struct iovec iov[],
>> +                             int iov_size, u32 perm)
>>  {
>>         struct vhost_iotlb_map *map;
>>         struct vhost_iotlb *iotlb = vrh->iotlb;
>> +       u64 s = 0, last = addr + len - 1;
>>         int ret = 0;
>> +
>> +       spin_lock(vrh->iotlb_lock);
>> +
>> +       while (len > s) {
>> +               u64 size;
>> +
>> +               if (unlikely(ret >= iov_size)) {
>> +                       ret = -ENOBUFS;
>> +                       break;
>> +               }
>> +
>> +               map = vhost_iotlb_itree_first(iotlb, addr, last);
>> +               if (!map || map->start > addr) {
>> +                       ret = -EINVAL;
>> +                       break;
>> +               } else if (!(map->perm & perm)) {
>> +                       ret = -EPERM;
>> +                       break;
>> +               }
>> +
>> +               size = map->size - addr + map->start;
>> +               iov[ret].iov_len = min(len - s, size);
>> +               iov[ret].iov_base = (void __user *)(unsigned long)
>> +                                   (map->addr + addr - map->start);
>> +               s += size;
>> +               addr += size;
>> +               ++ret;
>> +       }
>> +
>> +       spin_unlock(vrh->iotlb_lock);
>> +
>> +       if (translated)
>> +               *translated = min(len, s);
>> +
>> +       return ret;
>> +}
>
>It seems to me iotlb_translate_va and iotlb_translate_pa are very
>similar, their only difference is that the argument is that iov is
>iovec instead of bio_vec. And how to fill it, obviously.
>
>It would be great to merge both functions, only differing with a
>conditional on vrh->use_va, or generics, or similar. Or, if following
>the style of the rest of vringh code, to provide a callback to fill
>iovec (although I like conditional more).
>
>However I cannot think of an easy way to perform that without long
>macros or type erasure.

I agree and I tried, but then I got messed up and let it go.

But maybe with the callback it shouldn't be too messy, I can try it and
see what comes out :-)

>
>> +
>> +static inline int copy_from_va(const struct vringh *vrh, void *dst, void *src,
>> +                              u64 len, u64 *translated)
>> +{
>> +       struct iovec iov[16];
>> +       struct iov_iter iter;
>> +       int ret;
>> +
>> +       ret = iotlb_translate_va(vrh, (u64)(uintptr_t)src, len, translated, iov,
>> +                                ARRAY_SIZE(iov), VHOST_MAP_RO);
>> +       if (ret == -ENOBUFS)
>> +               ret = ARRAY_SIZE(iov);
>> +       else if (ret < 0)
>> +               return ret;
>> +
>> +       iov_iter_init(&iter, ITER_SOURCE, iov, ret, *translated);
>> +
>> +       return copy_from_iter(dst, *translated, &iter);
>
>Maybe a good baby step for DRY is to return the iov_iter in
>copy_from/to_va/pa here?

Good point! I'll try it.

>
>But I'm ok with this version too.
>
>Acked-by: Eugenio P�rez Martin <eperezma@redhat.com>

Thanks for the review!
Stefano

