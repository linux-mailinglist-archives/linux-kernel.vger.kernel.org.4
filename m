Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383066CABBB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjC0RTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjC0RTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8984835A9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 10:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679937529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ubqrrysriR6ooyEAZSZJ2qRop495K3eTRpiST4S6wI0=;
        b=SBk1OD5UuYE2gQzhzY3i3iqMDF5QLzJztoXZSuNsLkQjSW3ipIFxhOLTpdHXlIDt/7qcQM
        rM9pUD2qfpljfs/P/O13mXYAmzx5KjoV0sBq8DubyS5LSCdf/2uYyb3QWp/vMOHbCEAwrE
        pQdlKk5OLB3Qt70DNmqwJkodOyAFZ+0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-Zxf88Py9NNOVhKmao8hfOg-1; Mon, 27 Mar 2023 13:18:48 -0400
X-MC-Unique: Zxf88Py9NNOVhKmao8hfOg-1
Received: by mail-yb1-f199.google.com with SMTP id g187-20020a2520c4000000b00b74680a7904so9294254ybg.15
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 10:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679937527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubqrrysriR6ooyEAZSZJ2qRop495K3eTRpiST4S6wI0=;
        b=ga1rLubGPLYGd2LedCo4iL9IqIWXg/MJYzbtZAyXyBDoXRx9eGbCrrN6MyHt8gMs1s
         1cOVagd2xdCmHpCKEcsthK4jsQhekuRL+E6TyEKHjNcqNvZjDtRIViFCcn8zCS13m8D6
         P2SeS+5o/yWnXj0wmQO4xG/RCOFdJEl2amrfkGO0HN8yzoGKIccTtXA47eJ9vEEeKvNc
         jQcmDOuR6m/jPPqVvh14ll2Ig1mwtnhGvY/lXSGrTaOBqDXqCI1MOQ2GunKetdzIfPNi
         S2h00vtZ9i7Vi3cEyKcl5AAt/GDLVb5zMnNHkyI1gPRTlcRxfQlVPofMVHFx5CWUoQ3O
         i4og==
X-Gm-Message-State: AAQBX9ekMEzbEjB8zwXwP/TgCN4nliDFnW2LSJDAC/1YwvyiSZQ1ogKk
        1h1fOenke7e9UtXqz1kWNuTIDgzG3UErZgqsr4YRhwnH5sOk0TL2SNc7CJzWaQEVH+Yi0OeU/RO
        zCI1v47tc+X3WvdrQr4zfds0gaIaJW1BNDz3cec3C
X-Received: by 2002:a81:ad5d:0:b0:540:e744:13ae with SMTP id l29-20020a81ad5d000000b00540e74413aemr4681779ywk.3.1679937527481;
        Mon, 27 Mar 2023 10:18:47 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yd7McE8XOBG2bQacJRvvlLa/Vo8/drmrjv9gNxqEJ3S/Gvy+CHn6mTiR/Xm4rI5eQGHVGdmIE/X42Kumj2Cjs=
X-Received: by 2002:a81:ad5d:0:b0:540:e744:13ae with SMTP id
 l29-20020a81ad5d000000b00540e74413aemr4681759ywk.3.1679937527087; Mon, 27 Mar
 2023 10:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230324153607.46836-1-sgarzare@redhat.com> <20230324153919.47633-1-sgarzare@redhat.com>
In-Reply-To: <20230324153919.47633-1-sgarzare@redhat.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Mon, 27 Mar 2023 19:18:10 +0200
Message-ID: <CAJaqyWdng_m95nruPAA8ALBz82g1ZpU9ox2xJuS_qCJ0ueZoPQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] vringh: support VA with iotlb
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, kvm@vger.kernel.org, stefanha@redhat.com,
        "Michael S. Tsirkin" <mst@redhat.com>
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

On Fri, Mar 24, 2023 at 4:39=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> vDPA supports the possibility to use user VA in the iotlb messages.
> So, let's add support for user VA in vringh to use it in the vDPA
> simulators.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
>
> Notes:
>     v4:
>     - used uintptr_t for `io_addr` [Eugenio]
>     - added `io_addr` and `io_len` variables in iotlb_translate
>     - avoided overflow doing `map->addr - map->start + addr` [Jason]
>     - removed `is_iovec` field from struct iotlb_vec [Jason]
>     - added vringh_init_iotlb_va() [Jason]
>     v3:
>     - refactored avoiding code duplication [Eugenio]
>     v2:
>     - replace kmap_atomic() with kmap_local_page() [see previous patch]
>     - fix cast warnings when build with W=3D1 C=3D1
>
>  include/linux/vringh.h |   9 +++
>  drivers/vhost/vringh.c | 171 +++++++++++++++++++++++++++++++++--------
>  2 files changed, 148 insertions(+), 32 deletions(-)
>
> diff --git a/include/linux/vringh.h b/include/linux/vringh.h
> index 1991a02c6431..b4edfadf5479 100644
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
> @@ -284,6 +287,12 @@ int vringh_init_iotlb(struct vringh *vrh, u64 featur=
es,
>                       struct vring_avail *avail,
>                       struct vring_used *used);
>
> +int vringh_init_iotlb_va(struct vringh *vrh, u64 features,
> +                        unsigned int num, bool weak_barriers,
> +                        struct vring_desc *desc,
> +                        struct vring_avail *avail,
> +                        struct vring_used *used);
> +
>  int vringh_getdesc_iotlb(struct vringh *vrh,
>                          struct vringh_kiov *riov,
>                          struct vringh_kiov *wiov,
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 4aee230f7622..771c2aba8aac 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -1094,10 +1094,17 @@ EXPORT_SYMBOL(vringh_need_notify_kern);
>
>  #if IS_REACHABLE(CONFIG_VHOST_IOTLB)
>
> +struct iotlb_vec {
> +       union {
> +               struct iovec *iovec;
> +               struct bio_vec *bvec;
> +       } iov;
> +       size_t count;
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
> @@ -1107,9 +1114,11 @@ static int iotlb_translate(const struct vringh *vr=
h,
>         spin_lock(vrh->iotlb_lock);
>
>         while (len > s) {
> -               u64 size, pa, pfn;
> +               uintptr_t io_addr;
> +               size_t io_len;
> +               u64 size;
>
> -               if (unlikely(ret >=3D iov_size)) {
> +               if (unlikely(ret >=3D ivec->count)) {
>                         ret =3D -ENOBUFS;
>                         break;
>                 }
> @@ -1124,10 +1133,22 @@ static int iotlb_translate(const struct vringh *v=
rh,
>                 }
>
>                 size =3D map->size - addr + map->start;
> -               pa =3D map->addr + addr - map->start;
> -               pfn =3D pa >> PAGE_SHIFT;
> -               bvec_set_page(&iov[ret], pfn_to_page(pfn), min(len - s, s=
ize),
> -                             pa & (PAGE_SIZE - 1));
> +               io_len =3D min(len - s, size);
> +               io_addr =3D map->addr - map->start + addr;
> +
> +               if (vrh->use_va) {
> +                       struct iovec *iovec =3D ivec->iov.iovec;
> +
> +                       iovec[ret].iov_len =3D io_len;
> +                       iovec[ret].iov_base =3D (void __user *)io_addr;
> +               } else {
> +                       u64 pfn =3D io_addr >> PAGE_SHIFT;
> +                       struct bio_vec *bvec =3D ivec->iov.bvec;
> +
> +                       bvec_set_page(&bvec[ret], pfn_to_page(pfn), io_le=
n,
> +                                     io_addr & (PAGE_SIZE - 1));
> +               }
> +
>                 s +=3D size;
>                 addr +=3D size;
>                 ++ret;
> @@ -1146,23 +1167,36 @@ static int iotlb_translate(const struct vringh *v=
rh,
>  static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
>                                   void *src, size_t len)
>  {
> +       struct iotlb_vec ivec;
> +       union {
> +               struct iovec iovec[IOTLB_IOV_STRIDE];
> +               struct bio_vec bvec[IOTLB_IOV_STRIDE];
> +       } iov;
>         u64 total_translated =3D 0;
>
> +       ivec.iov.iovec =3D iov.iovec;
> +       ivec.count =3D IOTLB_IOV_STRIDE;
> +
>         while (total_translated < len) {
> -               struct bio_vec iov[IOTLB_IOV_STRIDE];
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
> +                       ret =3D IOTLB_IOV_STRIDE;
>                 else if (ret < 0)
>                         return ret;
>
> -               iov_iter_bvec(&iter, ITER_SOURCE, iov, ret, translated);
> +               if (vrh->use_va) {
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
> @@ -1179,23 +1213,36 @@ static inline int copy_from_iotlb(const struct vr=
ingh *vrh, void *dst,
>  static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
>                                 void *src, size_t len)
>  {
> +       struct iotlb_vec ivec;
> +       union {
> +               struct iovec iovec[IOTLB_IOV_STRIDE];
> +               struct bio_vec bvec[IOTLB_IOV_STRIDE];
> +       } iov;
>         u64 total_translated =3D 0;
>
> +       ivec.iov.iovec =3D iov.iovec;
> +       ivec.count =3D IOTLB_IOV_STRIDE;
> +
>         while (total_translated < len) {
> -               struct bio_vec iov[IOTLB_IOV_STRIDE];
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
> +                       ret =3D IOTLB_IOV_STRIDE;
>                 else if (ret < 0)
>                         return ret;
>
> -               iov_iter_bvec(&iter, ITER_DEST, iov, ret, translated);
> +               if (vrh->use_va) {
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
> @@ -1212,20 +1259,36 @@ static inline int copy_to_iotlb(const struct vrin=
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
> +       if (vrh->use_va) {
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
> @@ -1233,20 +1296,36 @@ static inline int getu16_iotlb(const struct vring=
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
> +       if (vrh->use_va) {
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
> @@ -1320,11 +1399,39 @@ int vringh_init_iotlb(struct vringh *vrh, u64 fea=
tures,
>                       struct vring_avail *avail,
>                       struct vring_used *used)
>  {
> +       vrh->use_va =3D false;
> +
>         return vringh_init_kern(vrh, features, num, weak_barriers,
>                                 desc, avail, used);
>  }
>  EXPORT_SYMBOL(vringh_init_iotlb);
>
> +/**
> + * vringh_init_iotlb_va - initialize a vringh for a ring with IOTLB cont=
aining
> + *                        user VA.
> + * @vrh: the vringh to initialize.
> + * @features: the feature bits for this ring.
> + * @num: the number of elements.
> + * @weak_barriers: true if we only need memory barriers, not I/O.
> + * @desc: the userpace descriptor pointer.
> + * @avail: the userpace avail pointer.
> + * @used: the userpace used pointer.
> + *
> + * Returns an error if num is invalid.
> + */
> +int vringh_init_iotlb_va(struct vringh *vrh, u64 features,
> +                        unsigned int num, bool weak_barriers,
> +                        struct vring_desc *desc,
> +                        struct vring_avail *avail,
> +                        struct vring_used *used)
> +{
> +       vrh->use_va =3D true;
> +
> +       return vringh_init_kern(vrh, features, num, weak_barriers,
> +                               desc, avail, used);
> +}
> +EXPORT_SYMBOL(vringh_init_iotlb_va);
> +
>  /**
>   * vringh_set_iotlb - initialize a vringh for a ring with IOTLB.
>   * @vrh: the vring
> --
> 2.39.2
>

