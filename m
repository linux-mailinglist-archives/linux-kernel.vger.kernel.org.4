Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB066C65AE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjCWKur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjCWKtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:49:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9D61BAF9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679568403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rExxsengfbWONJGQeEdkqPhkeejLlUTKZmIp0X4adI8=;
        b=Iv4zQFfXJHT6aX8b7QjlhYB4Y+llVLnukcPltCfAEmE32WdHKyWQeSk/+b+R6Hi8Pkw9YO
        bw2VKS2mw0Or5W0MOTcLW0YDreg84rNCAAfSXdqikkz89MAvI6/dYLhgcxNTuHXToixU6J
        M3aLD7G0B/GlJLA9vkn+VvHMNgqs8S8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-1eocj0KXOGO5DMrcRlTQZw-1; Thu, 23 Mar 2023 06:46:42 -0400
X-MC-Unique: 1eocj0KXOGO5DMrcRlTQZw-1
Received: by mail-wm1-f71.google.com with SMTP id d11-20020a05600c34cb00b003ee89ce8cc3so684415wmq.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679568401;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rExxsengfbWONJGQeEdkqPhkeejLlUTKZmIp0X4adI8=;
        b=QAzFfi/dfiOJhluV2zEXBewfw1Kamh/TjkP8tn0PuCD8F2bxpXLpmtfedOAqLKOU+T
         BrsZKol9+Op4Kd6kwN71pTaEyWphK7rh+RAqITFl2lgnJJdww/MP2ye+mQgQTJcfbVAa
         Nd+gakrVw7s9jbLIniR9/U6WHF/PnwEWoIm8qulwJ0WM6xjvToHkdzBuayDISazE6Ea+
         6p7j/T5EvAypT5vh/dFtCLQrJtPWg5657LHL7eqsIpsri8QxG57DGQbCOWNzTxliuOyI
         qFJqARpHdKBF47GUmPcjxuDTli8juu0lTQ8+Io7NdBEfqOa1IuehLG6FJmk8ZM18plHD
         wxlw==
X-Gm-Message-State: AO0yUKX1uwcaz8NG5DX7WhIBkVgkZC5qArcUKYjz54vFZulyPT8Hav27
        sa4wGWbKPkhxuOWUww1Xsnp60Rs2cv2InOiJcWxDlfBeF1hiZxLt+uhY0wFjEMwkE4wXibj1mvt
        rVsjCLuEqfnDRwViNAjKAfZI7
X-Received: by 2002:a05:600c:a0c:b0:3ee:90fa:aedf with SMTP id z12-20020a05600c0a0c00b003ee90faaedfmr816427wmp.11.1679568401290;
        Thu, 23 Mar 2023 03:46:41 -0700 (PDT)
X-Google-Smtp-Source: AK7set+DA2e9f9uehfwtsWMqbAlf9hkuL0RebTl4dj8zwyHxcAqQAUK0eho1w6250F8uA0ED6fpCWA==
X-Received: by 2002:a05:600c:a0c:b0:3ee:90fa:aedf with SMTP id z12-20020a05600c0a0c00b003ee90faaedfmr816415wmp.11.1679568400957;
        Thu, 23 Mar 2023 03:46:40 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it. [82.53.134.98])
        by smtp.gmail.com with ESMTPSA id t16-20020a7bc3d0000000b003ed1f6878a5sm1535271wmj.5.2023.03.23.03.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:46:40 -0700 (PDT)
Date:   Thu, 23 Mar 2023 11:46:38 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, stefanha@redhat.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] vringh: support VA with iotlb
Message-ID: <20230323104638.67hbwwbk7ayp4psq@sgarzare-redhat>
References: <20230321154228.182769-1-sgarzare@redhat.com>
 <20230321154228.182769-5-sgarzare@redhat.com>
 <CAJaqyWcCwwu1UJ968A=s30GCezjLcwWKDhCFMsQ2EcGGgkiz7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWcCwwu1UJ968A=s30GCezjLcwWKDhCFMsQ2EcGGgkiz7g@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 09:09:14AM +0100, Eugenio Perez Martin wrote:
>On Tue, Mar 21, 2023 at 4:43 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> vDPA supports the possibility to use user VA in the iotlb messages.
>> So, let's add support for user VA in vringh to use it in the vDPA
>> simulators.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>
>> Notes:
>>     v3:
>>     - refactored avoiding code duplication [Eugenio]
>>     v2:
>>     - replace kmap_atomic() with kmap_local_page() [see previous patch]
>>     - fix cast warnings when build with W=1 C=1
>>
>>  include/linux/vringh.h            |   5 +-
>>  drivers/vdpa/mlx5/net/mlx5_vnet.c |   2 +-
>>  drivers/vdpa/vdpa_sim/vdpa_sim.c  |   4 +-
>>  drivers/vhost/vringh.c            | 153 +++++++++++++++++++++++-------
>>  4 files changed, 127 insertions(+), 37 deletions(-)
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
>> index 520646ae7fa0..dfd0e000217b 100644
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
>> index eea23c630f7c..47cdf2a1f5b8 100644
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
>> @@ -92,7 +92,7 @@ static void vdpasim_vq_reset(struct vdpasim *vdpasim,
>>         vq->cb = NULL;
>>         vq->private = NULL;
>>         vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
>> -                         VDPASIM_QUEUE_MAX, false, NULL, NULL, NULL);
>> +                         VDPASIM_QUEUE_MAX, false, false, NULL, NULL, NULL);
>>
>>         vq->vring.notify = NULL;
>>  }
>> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
>> index 0ba3ef809e48..72c88519329a 100644
>> --- a/drivers/vhost/vringh.c
>> +++ b/drivers/vhost/vringh.c
>> @@ -1094,10 +1094,18 @@ EXPORT_SYMBOL(vringh_need_notify_kern);
>>
>>  #if IS_REACHABLE(CONFIG_VHOST_IOTLB)
>>
>> +struct iotlb_vec {
>> +       union {
>> +               struct iovec *iovec;
>> +               struct bio_vec *bvec;
>> +       } iov;
>> +       size_t count;
>> +       bool is_iovec;
>> +};
>> +
>>  static int iotlb_translate(const struct vringh *vrh,
>>                            u64 addr, u64 len, u64 *translated,
>> -                          struct bio_vec iov[],
>> -                          int iov_size, u32 perm)
>> +                          struct iotlb_vec *ivec, u32 perm)
>>  {
>>         struct vhost_iotlb_map *map;
>>         struct vhost_iotlb *iotlb = vrh->iotlb;
>> @@ -1107,9 +1115,9 @@ static int iotlb_translate(const struct vringh *vrh,
>>         spin_lock(vrh->iotlb_lock);
>>
>>         while (len > s) {
>> -               u64 size, pa, pfn;
>> +               u64 size;
>>
>> -               if (unlikely(ret >= iov_size)) {
>> +               if (unlikely(ret >= ivec->count)) {
>>                         ret = -ENOBUFS;
>>                         break;
>>                 }
>> @@ -1124,10 +1132,22 @@ static int iotlb_translate(const struct vringh *vrh,
>>                 }
>>
>>                 size = map->size - addr + map->start;
>> -               pa = map->addr + addr - map->start;
>> -               pfn = pa >> PAGE_SHIFT;
>> -               bvec_set_page(&iov[ret], pfn_to_page(pfn), min(len - s, size),
>> -                             pa & (PAGE_SIZE - 1));
>> +               if (ivec->is_iovec) {
>> +                       struct iovec *iovec = ivec->iov.iovec;
>> +
>> +                       iovec[ret].iov_len = min(len - s, size);
>> +                       iovec[ret].iov_base = (void __user *)(unsigned long)
>
>s/unsigned long/uintptr_t ?
>

yep, good catch!

As I wrote to Jason, I think I'll take it out of the if and just declare 
an uintptr_t variable, since I'm using it also in the else branch.

>
>
>> +                                             (map->addr + addr - map->start);
>> +               } else {
>> +                       u64 pa = map->addr + addr - map->start;
>> +                       u64 pfn = pa >> PAGE_SHIFT;
>> +                       struct bio_vec *bvec = ivec->iov.bvec;
>> +
>> +                       bvec_set_page(&bvec[ret], pfn_to_page(pfn),
>> +                                     min(len - s, size),
>> +                                     pa & (PAGE_SIZE - 1));
>> +               }
>> +
>>                 s += size;
>>                 addr += size;
>>                 ++ret;
>> @@ -1141,26 +1161,42 @@ static int iotlb_translate(const struct vringh *vrh,
>>         return ret;
>>  }
>>
>> +#define IOTLB_IOV_SIZE 16
>
>I'm fine with defining here, but maybe it is better to isolate the
>change in a previous patch or reuse another well known macro?

Yep, good point!

Do you have any well known macro to suggest?

>
>Other looks good, and I agree with Jason's comments so even if the
>macro declaration is not moved:
>
>Acked-by: Eugenio Pérez <eperezma@redhat.com>

Thanks,
Stefano

