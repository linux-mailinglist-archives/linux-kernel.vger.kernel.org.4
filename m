Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCE66C615A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjCWIKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjCWIKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:10:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D27359F4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679558996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EwNJuTQzZa68E+uwGkDROnOU0eGSdGgfEOhZyYP5hIQ=;
        b=DaOFgbufWeIOzCwQCDFrDF8wLLPGw7RpYkW/gSjSbcJ/7x8zmTbX3yp3RoesFY95MZf8hB
        kVhN9BK3Cky130hMqhS7i9FeMv/7RYTbnPkUggOPkVP7POx2IxjsrVXEUaGLapcGr2GrVW
        LnDosAniB+HYa6Qb8tqDygsI1ecllIk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-1-G2R9MPMTmc89Nz6PPJjQ-1; Thu, 23 Mar 2023 04:09:52 -0400
X-MC-Unique: 1-G2R9MPMTmc89Nz6PPJjQ-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-536a5a0b6e3so216630567b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679558991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwNJuTQzZa68E+uwGkDROnOU0eGSdGgfEOhZyYP5hIQ=;
        b=IoBNltKyPjZVEPitZctcRX4hAg7fqXq0GBSN72dQA9k5A2SWQFJA1ptSsg9CCC68Fk
         lNEST6E5esp5RWui0HzQPjJ0MC6uu6jTSC73jlcmBB+1coiZYwQ43KdYyFfyTHUSSjsu
         FZSTqLY13FT/IsyG781SlkRKiaAh8VwEddOpofPzMcFVZtGboX2NZ+3omNM2UfkQDbgm
         2pnhf4V6UhTC//felR+ioqL9rwgk23d7KG7NrjhQXNq7UXg1Hpl0CvTucN/BUFJ5/X28
         RocKPvTn3ECjn/PoyoEEChosT4t83xCw/BNGExDOr7RZh54FLIi85syZz9dFynvo8dcG
         w5VQ==
X-Gm-Message-State: AAQBX9fHA4PND6768EcHPWTMZ8FmvTy+v6uSglbBuYZ1bakD4NTE9oey
        aRKZc9Ht0NFGoU8s7MGd3gqVrwR/wwoYYNWha07OIXQQBt5PvNJKtiX3OEspHmKjTHemLQc9hwu
        vMCV3SdyZRpXC/3YeFAvS53JbszJyGGL7R2NfG4Wi
X-Received: by 2002:a25:81c5:0:b0:b6a:2590:6c63 with SMTP id n5-20020a2581c5000000b00b6a25906c63mr1540657ybm.2.1679558991059;
        Thu, 23 Mar 2023 01:09:51 -0700 (PDT)
X-Google-Smtp-Source: AKy350YEdA5g/M24d+xdNdb8u9nUwF+a4wIVM3Rn+E4/TIXzeIZaWYUzywXTk8fMMt/V8zCAMqGWFgu8zalgu1VOl+I=
X-Received: by 2002:a25:81c5:0:b0:b6a:2590:6c63 with SMTP id
 n5-20020a2581c5000000b00b6a25906c63mr1540638ybm.2.1679558990627; Thu, 23 Mar
 2023 01:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230321154228.182769-1-sgarzare@redhat.com> <20230321154228.182769-5-sgarzare@redhat.com>
In-Reply-To: <20230321154228.182769-5-sgarzare@redhat.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Thu, 23 Mar 2023 09:09:14 +0100
Message-ID: <CAJaqyWcCwwu1UJ968A=s30GCezjLcwWKDhCFMsQ2EcGGgkiz7g@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] vringh: support VA with iotlb
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, stefanha@redhat.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 4:43=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> vDPA supports the possibility to use user VA in the iotlb messages.
> So, let's add support for user VA in vringh to use it in the vDPA
> simulators.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>
> Notes:
>     v3:
>     - refactored avoiding code duplication [Eugenio]
>     v2:
>     - replace kmap_atomic() with kmap_local_page() [see previous patch]
>     - fix cast warnings when build with W=3D1 C=3D1
>
>  include/linux/vringh.h            |   5 +-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c |   2 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim.c  |   4 +-
>  drivers/vhost/vringh.c            | 153 +++++++++++++++++++++++-------
>  4 files changed, 127 insertions(+), 37 deletions(-)
>
> diff --git a/include/linux/vringh.h b/include/linux/vringh.h
> index 1991a02c6431..d39b9f2dcba0 100644
> --- a/include/linux/vringh.h
> +++ b/include/linux/vringh.h
> @@ -32,6 +32,9 @@ struct vringh {
>         /* Can we get away with weak barriers? */
>         bool weak_barriers;
>
> +       /* Use user's VA */
> +       bool use_va;
> +
>         /* Last available index we saw (ie. where we're up to). */
>         u16 last_avail_idx;
>
> @@ -279,7 +282,7 @@ void vringh_set_iotlb(struct vringh *vrh, struct vhos=
t_iotlb *iotlb,
>                       spinlock_t *iotlb_lock);
>
>  int vringh_init_iotlb(struct vringh *vrh, u64 features,
> -                     unsigned int num, bool weak_barriers,
> +                     unsigned int num, bool weak_barriers, bool use_va,
>                       struct vring_desc *desc,
>                       struct vring_avail *avail,
>                       struct vring_used *used);
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 520646ae7fa0..dfd0e000217b 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2537,7 +2537,7 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *mv=
dev)
>
>         if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ))
>                 err =3D vringh_init_iotlb(&cvq->vring, mvdev->actual_feat=
ures,
> -                                       MLX5_CVQ_MAX_ENT, false,
> +                                       MLX5_CVQ_MAX_ENT, false, false,
>                                         (struct vring_desc *)(uintptr_t)c=
vq->desc_addr,
>                                         (struct vring_avail *)(uintptr_t)=
cvq->driver_addr,
>                                         (struct vring_used *)(uintptr_t)c=
vq->device_addr);
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index eea23c630f7c..47cdf2a1f5b8 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -60,7 +60,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim=
, unsigned int idx)
>         struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[idx];
>         uint16_t last_avail_idx =3D vq->vring.last_avail_idx;
>
> -       vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, true,
> +       vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, true, f=
alse,
>                           (struct vring_desc *)(uintptr_t)vq->desc_addr,
>                           (struct vring_avail *)
>                           (uintptr_t)vq->driver_addr,
> @@ -92,7 +92,7 @@ static void vdpasim_vq_reset(struct vdpasim *vdpasim,
>         vq->cb =3D NULL;
>         vq->private =3D NULL;
>         vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_feature=
s,
> -                         VDPASIM_QUEUE_MAX, false, NULL, NULL, NULL);
> +                         VDPASIM_QUEUE_MAX, false, false, NULL, NULL, NU=
LL);
>
>         vq->vring.notify =3D NULL;
>  }
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 0ba3ef809e48..72c88519329a 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -1094,10 +1094,18 @@ EXPORT_SYMBOL(vringh_need_notify_kern);
>
>  #if IS_REACHABLE(CONFIG_VHOST_IOTLB)
>
> +struct iotlb_vec {
> +       union {
> +               struct iovec *iovec;
> +               struct bio_vec *bvec;
> +       } iov;
> +       size_t count;
> +       bool is_iovec;
> +};
> +
>  static int iotlb_translate(const struct vringh *vrh,
>                            u64 addr, u64 len, u64 *translated,
> -                          struct bio_vec iov[],
> -                          int iov_size, u32 perm)
> +                          struct iotlb_vec *ivec, u32 perm)
>  {
>         struct vhost_iotlb_map *map;
>         struct vhost_iotlb *iotlb =3D vrh->iotlb;
> @@ -1107,9 +1115,9 @@ static int iotlb_translate(const struct vringh *vrh=
,
>         spin_lock(vrh->iotlb_lock);
>
>         while (len > s) {
> -               u64 size, pa, pfn;
> +               u64 size;
>
> -               if (unlikely(ret >=3D iov_size)) {
> +               if (unlikely(ret >=3D ivec->count)) {
>                         ret =3D -ENOBUFS;
>                         break;
>                 }
> @@ -1124,10 +1132,22 @@ static int iotlb_translate(const struct vringh *v=
rh,
>                 }
>
>                 size =3D map->size - addr + map->start;
> -               pa =3D map->addr + addr - map->start;
> -               pfn =3D pa >> PAGE_SHIFT;
> -               bvec_set_page(&iov[ret], pfn_to_page(pfn), min(len - s, s=
ize),
> -                             pa & (PAGE_SIZE - 1));
> +               if (ivec->is_iovec) {
> +                       struct iovec *iovec =3D ivec->iov.iovec;
> +
> +                       iovec[ret].iov_len =3D min(len - s, size);
> +                       iovec[ret].iov_base =3D (void __user *)(unsigned =
long)

s/unsigned long/uintptr_t ?



> +                                             (map->addr + addr - map->st=
art);
> +               } else {
> +                       u64 pa =3D map->addr + addr - map->start;
> +                       u64 pfn =3D pa >> PAGE_SHIFT;
> +                       struct bio_vec *bvec =3D ivec->iov.bvec;
> +
> +                       bvec_set_page(&bvec[ret], pfn_to_page(pfn),
> +                                     min(len - s, size),
> +                                     pa & (PAGE_SIZE - 1));
> +               }
> +
>                 s +=3D size;
>                 addr +=3D size;
>                 ++ret;
> @@ -1141,26 +1161,42 @@ static int iotlb_translate(const struct vringh *v=
rh,
>         return ret;
>  }
>
> +#define IOTLB_IOV_SIZE 16

I'm fine with defining here, but maybe it is better to isolate the
change in a previous patch or reuse another well known macro?

Other looks good, and I agree with Jason's comments so even if the
macro declaration is not moved:

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> +
>  static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
>                                   void *src, size_t len)
>  {
> +       struct iotlb_vec ivec;
> +       union {
> +               struct iovec iovec[IOTLB_IOV_SIZE];
> +               struct bio_vec bvec[IOTLB_IOV_SIZE];
> +       } iov;
>         u64 total_translated =3D 0;
>
> +       ivec.iov.iovec =3D iov.iovec;
> +       ivec.count =3D IOTLB_IOV_SIZE;
> +       ivec.is_iovec =3D vrh->use_va;
> +
>         while (total_translated < len) {
> -               struct bio_vec iov[16];
>                 struct iov_iter iter;
>                 u64 translated;
>                 int ret;
>
>                 ret =3D iotlb_translate(vrh, (u64)(uintptr_t)src,
>                                       len - total_translated, &translated=
,
> -                                     iov, ARRAY_SIZE(iov), VHOST_MAP_RO)=
;
> +                                     &ivec, VHOST_MAP_RO);
>                 if (ret =3D=3D -ENOBUFS)
> -                       ret =3D ARRAY_SIZE(iov);
> +                       ret =3D IOTLB_IOV_SIZE;
>                 else if (ret < 0)
>                         return ret;
>
> -               iov_iter_bvec(&iter, ITER_SOURCE, iov, ret, translated);
> +               if (ivec.is_iovec) {
> +                       iov_iter_init(&iter, ITER_SOURCE, ivec.iov.iovec,=
 ret,
> +                                     translated);
> +               } else {
> +                       iov_iter_bvec(&iter, ITER_SOURCE, ivec.iov.bvec, =
ret,
> +                                     translated);
> +               }
>
>                 ret =3D copy_from_iter(dst, translated, &iter);
>                 if (ret < 0)
> @@ -1177,23 +1213,37 @@ static inline int copy_from_iotlb(const struct vr=
ingh *vrh, void *dst,
>  static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
>                                 void *src, size_t len)
>  {
> +       struct iotlb_vec ivec;
> +       union {
> +               struct iovec iovec[IOTLB_IOV_SIZE];
> +               struct bio_vec bvec[IOTLB_IOV_SIZE];
> +       } iov;
>         u64 total_translated =3D 0;
>
> +       ivec.iov.iovec =3D iov.iovec;
> +       ivec.count =3D IOTLB_IOV_SIZE;
> +       ivec.is_iovec =3D vrh->use_va;
> +
>         while (total_translated < len) {
> -               struct bio_vec iov[16];
>                 struct iov_iter iter;
>                 u64 translated;
>                 int ret;
>
>                 ret =3D iotlb_translate(vrh, (u64)(uintptr_t)dst,
>                                       len - total_translated, &translated=
,
> -                                     iov, ARRAY_SIZE(iov), VHOST_MAP_WO)=
;
> +                                     &ivec, VHOST_MAP_WO);
>                 if (ret =3D=3D -ENOBUFS)
> -                       ret =3D ARRAY_SIZE(iov);
> +                       ret =3D IOTLB_IOV_SIZE;
>                 else if (ret < 0)
>                         return ret;
>
> -               iov_iter_bvec(&iter, ITER_DEST, iov, ret, translated);
> +               if (ivec.is_iovec) {
> +                       iov_iter_init(&iter, ITER_DEST, ivec.iov.iovec, r=
et,
> +                                     translated);
> +               } else {
> +                       iov_iter_bvec(&iter, ITER_DEST, ivec.iov.bvec, re=
t,
> +                                     translated);
> +               }
>
>                 ret =3D copy_to_iter(src, translated, &iter);
>                 if (ret < 0)
> @@ -1210,20 +1260,37 @@ static inline int copy_to_iotlb(const struct vrin=
gh *vrh, void *dst,
>  static inline int getu16_iotlb(const struct vringh *vrh,
>                                u16 *val, const __virtio16 *p)
>  {
> -       struct bio_vec iov;
> -       void *kaddr, *from;
> +       struct iotlb_vec ivec;
> +       union {
> +               struct iovec iovec[1];
> +               struct bio_vec bvec[1];
> +       } iov;
> +       __virtio16 tmp;
>         int ret;
>
> +       ivec.iov.iovec =3D iov.iovec;
> +       ivec.count =3D 1;
> +       ivec.is_iovec =3D vrh->use_va;
> +
>         /* Atomic read is needed for getu16 */
> -       ret =3D iotlb_translate(vrh, (u64)(uintptr_t)p, sizeof(*p), NULL,
> -                             &iov, 1, VHOST_MAP_RO);
> +       ret =3D iotlb_translate(vrh, (u64)(uintptr_t)p, sizeof(*p),
> +                             NULL, &ivec, VHOST_MAP_RO);
>         if (ret < 0)
>                 return ret;
>
> -       kaddr =3D kmap_local_page(iov.bv_page);
> -       from =3D kaddr + iov.bv_offset;
> -       *val =3D vringh16_to_cpu(vrh, READ_ONCE(*(__virtio16 *)from));
> -       kunmap_local(kaddr);
> +       if (ivec.is_iovec) {
> +               ret =3D __get_user(tmp, (__virtio16 __user *)ivec.iov.iov=
ec[0].iov_base);
> +               if (ret)
> +                       return ret;
> +       } else {
> +               void *kaddr =3D kmap_local_page(ivec.iov.bvec[0].bv_page)=
;
> +               void *from =3D kaddr + ivec.iov.bvec[0].bv_offset;
> +
> +               tmp =3D READ_ONCE(*(__virtio16 *)from);
> +               kunmap_local(kaddr);
> +       }
> +
> +       *val =3D vringh16_to_cpu(vrh, tmp);
>
>         return 0;
>  }
> @@ -1231,20 +1298,37 @@ static inline int getu16_iotlb(const struct vring=
h *vrh,
>  static inline int putu16_iotlb(const struct vringh *vrh,
>                                __virtio16 *p, u16 val)
>  {
> -       struct bio_vec iov;
> -       void *kaddr, *to;
> +       struct iotlb_vec ivec;
> +       union {
> +               struct iovec iovec;
> +               struct bio_vec bvec;
> +       } iov;
> +       __virtio16 tmp;
>         int ret;
>
> +       ivec.iov.iovec =3D &iov.iovec;
> +       ivec.count =3D 1;
> +       ivec.is_iovec =3D vrh->use_va;
> +
>         /* Atomic write is needed for putu16 */
> -       ret =3D iotlb_translate(vrh, (u64)(uintptr_t)p, sizeof(*p), NULL,
> -                             &iov, 1, VHOST_MAP_WO);
> +       ret =3D iotlb_translate(vrh, (u64)(uintptr_t)p, sizeof(*p),
> +                             NULL, &ivec, VHOST_MAP_RO);
>         if (ret < 0)
>                 return ret;
>
> -       kaddr =3D kmap_local_page(iov.bv_page);
> -       to =3D kaddr + iov.bv_offset;
> -       WRITE_ONCE(*(__virtio16 *)to, cpu_to_vringh16(vrh, val));
> -       kunmap_local(kaddr);
> +       tmp =3D cpu_to_vringh16(vrh, val);
> +
> +       if (ivec.is_iovec) {
> +               ret =3D __put_user(tmp, (__virtio16 __user *)ivec.iov.iov=
ec[0].iov_base);
> +               if (ret)
> +                       return ret;
> +       } else {
> +               void *kaddr =3D kmap_local_page(ivec.iov.bvec[0].bv_page)=
;
> +               void *to =3D kaddr + ivec.iov.bvec[0].bv_offset;
> +
> +               WRITE_ONCE(*(__virtio16 *)to, tmp);
> +               kunmap_local(kaddr);
> +       }
>
>         return 0;
>  }
> @@ -1306,6 +1390,7 @@ static inline int putused_iotlb(const struct vringh=
 *vrh,
>   * @features: the feature bits for this ring.
>   * @num: the number of elements.
>   * @weak_barriers: true if we only need memory barriers, not I/O.
> + * @use_va: true if IOTLB contains user VA
>   * @desc: the userpace descriptor pointer.
>   * @avail: the userpace avail pointer.
>   * @used: the userpace used pointer.
> @@ -1313,11 +1398,13 @@ static inline int putused_iotlb(const struct vrin=
gh *vrh,
>   * Returns an error if num is invalid.
>   */
>  int vringh_init_iotlb(struct vringh *vrh, u64 features,
> -                     unsigned int num, bool weak_barriers,
> +                     unsigned int num, bool weak_barriers, bool use_va,
>                       struct vring_desc *desc,
>                       struct vring_avail *avail,
>                       struct vring_used *used)
>  {
> +       vrh->use_va =3D use_va;
> +
>         return vringh_init_kern(vrh, features, num, weak_barriers,
>                                 desc, avail, used);
>  }
> --
> 2.39.2
>

