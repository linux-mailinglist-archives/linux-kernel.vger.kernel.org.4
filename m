Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FBD7172D2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 03:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbjEaBGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 21:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjEaBGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 21:06:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CCDF3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 18:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685495115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2j4l3XHM0BpNQjJRPE5cLc+KJu+AMs2GEthMwgcmwP4=;
        b=Hv1Nbf3u2cRwry6+gy9mH9CezCNrtipfZ0iAMU4vt91b8pUsjByqKNVFhLO4kpZeHsa4G/
        QvjnGr2gU13Jn4b0lHMi5mDV0mtumjhHqJYacTqtGeGPotqKDVjMoUyZpE7YC2TnDc6rNG
        XHiDJb4HN0TBzxNabHlbeen0N+QHiek=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-KEQVMTbvNZWpojqYPCyaBA-1; Tue, 30 May 2023 21:05:14 -0400
X-MC-Unique: KEQVMTbvNZWpojqYPCyaBA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2af32c170c8so27606841fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 18:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685495112; x=1688087112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2j4l3XHM0BpNQjJRPE5cLc+KJu+AMs2GEthMwgcmwP4=;
        b=XTz81Qta4h8JYeCuDOUUqVlpIDnAHXqo8K8OXMWj7EkpCl7AFaq4hqhktixG4QqBkz
         O0ngklVVqJbIz5DV1bc70H9lbGouKHo8+FZl8erGzd45CQOg+6tZaCxEz84gF80MrrW2
         8vas0OGif14kmsK/1A3p4zkao3G+vuV39Wq1KWuPbXfi3G1A9tHTVBH664ofuyw1KLXr
         Z8mhKoQ//zGeAgbBgdatmfzD60UX6s3Ui2R7yeWe76pQZqwabafl31NBJaZx+cugix3N
         ybqil3Rpw9C8b1mCA5kckoJuKi/jeGCoDskS/T7J+FFm+pmUpBFdQJ5K1Bvc84HF1mcY
         79sw==
X-Gm-Message-State: AC+VfDzc64yRyGCZ2nLZS4hpLVNc4GGbBugMevbqIxutAEtUrtm5/YkM
        /BRiIbf/dLhHXbHYMOEV+7tBMakV2isvxF6CkmeoXNMInxzfahyjDBWI6JFwh1NeeGwcwwIw2j5
        Hmc5qeBRA7+dz5Qjfg75CH82X2tIPWMPfdzNQvzY/DTWKMmlv330qGA==
X-Received: by 2002:a2e:8782:0:b0:2ac:8efb:fc02 with SMTP id n2-20020a2e8782000000b002ac8efbfc02mr1714273lji.4.1685495112239;
        Tue, 30 May 2023 18:05:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4TXabbBOgUhE4RZSY2CRW7lTjo49hq8MtlG5xpist4w2/gHdk5BicpnMlMvLZDOYmbk4FxDfl4v5oG/kdY+Ck=
X-Received: by 2002:a2e:8782:0:b0:2ac:8efb:fc02 with SMTP id
 n2-20020a2e8782000000b002ac8efbfc02mr1714266lji.4.1685495111840; Tue, 30 May
 2023 18:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230526063041.18359-1-jasowang@redhat.com> <20230528033037-mutt-send-email-mst@kernel.org>
 <CACGkMEs9Ztavn2JyuUAb47Sk1fYHiXLLkQQPQR5Czhb2yu_R3w@mail.gmail.com> <20230529055729-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230529055729-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 31 May 2023 09:05:00 +0800
Message-ID: <CACGkMEsW1+BFtMoLg4c_FyxYTZJcSVh4BoEdJ-Q9_WGg_DcReA@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: validate used buffer length
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 6:03=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, May 29, 2023 at 09:18:10AM +0800, Jason Wang wrote:
> > On Sun, May 28, 2023 at 3:57=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Fri, May 26, 2023 at 02:30:41PM +0800, Jason Wang wrote:
> > > > This patch validate
> > >
> > > validates
> > >
> > > > the used buffer length provided by the device
> > > > before trying to use it.
> > >
> > > before returning it to caller
> > >
> > > > This is done by remembering the in buffer
> > > > length in a dedicated array during virtqueue_add(), then we can fai=
l
> > > > the virtqueue_get_buf() when we find the device is trying to give u=
s a
> > > > used buffer length which is greater than we stored before.
> > >
> > > than what we stored
> > >
> > > >
> > > > This validation is disable
> > >
> > > disabled
> > >
> > > > by default via module parameter to unbreak
> > > > some existing devices since some legacy devices are known to report
> > > > buggy used length.
> > > >
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >
> > > First I'm not merging this without more data about
> > > what is known to be broken and what is known to work well
> > > in the commit log. And how exactly do things work if used length
> > > is wrong?
> >
> > Assuming the device is malicious, it would be very hard to answer.
> > Auditing and fuzzing won't cover every case. Instead of trying to seek
> > the answer, we can simply make sure the used in buffer length is
> > validated then we know we're fine or not.
>
> To restate the question, you said above "some legacy devices are known
> to report buggy used length". If they report buggy length then how
> can things work?

The validation is disabled for legacy device (as stated in the changelog):

static bool vring_needs_used_validation(const struct virtio_device *vdev)
{
        /*
         * Several legacy devices are known to produce buggy used
         * length. In order to let driver work, we won't validate used
         * buffer length in this case.
         */
        if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
                return false;
        if (force_used_validation)
                return true;
        return false;
}

This seems to be what we've agreed in last version:

https://lore.kernel.org/all/CANLsYkxfhamUU0bb4j7y6N4_G9odKxLCjXxgXEx4SJ6_Kf=
+M2Q@mail.gmail.com/T/#m31f3b06f9032beec175c312dfa2532cb08b15c56

Thanks

>
> > > Second what's wrong with dma_desc_extra that we already maintain?
> > > Third motivation - it's part and parcel of the hardening effort yes?
> >
> > They are different. dma_desc_extra is for a descriptor ring, but this
> > is for a used ring. Technically we can go back to iterate on the
> > descriptor ring for a legal used in buffer length. But it will have
> > worse performance.
>
> I don't really understand. We already iterate when we unmap -
> all that is necessary is to subtract it from used length, if at
> the end of the process it is >0 then we know used length is too
> large.

Yes, but it is the job that is done in the driver level not the virtio
core. Validation in virtio core is still necessary since they're
working at different levels and it's hard to force the validation in
all drivers by codes. Last version introduces a
suppress_driver_validation to allow the driver to suppress the core
validation which seems not good, we need a way to force the
virtio_ring code to do validation before. Or such stuff could be added
on top since the validation is by default anyway.

Thanks

>
>
> > > I'd like to know the fate of VIRTIO_HARDEN_NOTIFICATION before
> > > we do more hardening. If it's irrevocably broken let's rip it out?
> >
> > So the plan is
> >
> > 1) finish used ring validation (this had been proposed, merged and
> > reverted before notification hardening)
> > 2) do notification hardening on top.
> >
> > So let's leave it as is and I will do a rework after we finalize the
> > used ring validation.
> >
> > Thanks
> >
> > >
> > >
> > > > ---
> > > > Changes since V4:
> > > > - drop the flat for driver to suppress the check
> > > > - validation is disabled by default
> > > > - don't do validation for legacy device
> > > > - rebase and support virtqueue resize
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 75 ++++++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 75 insertions(+)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_r=
ing.c
> > > > index 143f380baa1c..5b151605aaf8 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -15,6 +15,9 @@
> > > >  #include <linux/spinlock.h>
> > > >  #include <xen/xen.h>
> > > >
> > > > +static bool force_used_validation =3D false;
> > > > +module_param(force_used_validation, bool, 0444);
> > > > +
> > > >  #ifdef DEBUG
> > > >  /* For development, we want to crash whenever the ring is screwed.=
 */
> > > >  #define BAD_RING(_vq, fmt, args...)                          \
> > > > @@ -105,6 +108,9 @@ struct vring_virtqueue_split {
> > > >       struct vring_desc_state_split *desc_state;
> > > >       struct vring_desc_extra *desc_extra;
> > > >
> > > > +     /* Maximum in buffer length, NULL means no used validation */
> > > > +     u32 *buflen;
> > > > +
> > > >       /* DMA address and size information */
> > > >       dma_addr_t queue_dma_addr;
> > > >       size_t queue_size_in_bytes;
> > > > @@ -145,6 +151,9 @@ struct vring_virtqueue_packed {
> > > >       struct vring_desc_state_packed *desc_state;
> > > >       struct vring_desc_extra *desc_extra;
> > > >
> > > > +     /* Maximum in buffer length, NULL means no used validation */
> > > > +     u32 *buflen;
> > > > +
> > > >       /* DMA address and size information */
> > > >       dma_addr_t ring_dma_addr;
> > > >       dma_addr_t driver_event_dma_addr;
> > > > @@ -552,6 +561,7 @@ static inline int virtqueue_add_split(struct vi=
rtqueue *_vq,
> > > >       unsigned int i, n, avail, descs_used, prev, err_idx;
> > > >       int head;
> > > >       bool indirect;
> > > > +     u32 buflen =3D 0;
> > > >
> > > >       START_USE(vq);
> > > >
> > > > @@ -635,6 +645,7 @@ static inline int virtqueue_add_split(struct vi=
rtqueue *_vq,
> > > >                                                    VRING_DESC_F_NEX=
T |
> > > >                                                    VRING_DESC_F_WRI=
TE,
> > > >                                                    indirect);
> > > > +                     buflen +=3D sg->length;
> > > >               }
> > > >       }
> > > >       /* Last one doesn't continue. */
> > > > @@ -675,6 +686,10 @@ static inline int virtqueue_add_split(struct v=
irtqueue *_vq,
> > > >       else
> > > >               vq->split.desc_state[head].indir_desc =3D ctx;
> > > >
> > > > +     /* Store in buffer length if necessary */
> > > > +     if (vq->split.buflen)
> > > > +             vq->split.buflen[head] =3D buflen;
> > > > +
> > > >       /* Put entry in available array (but don't update avail->idx =
until they
> > > >        * do sync). */
> > > >       avail =3D vq->split.avail_idx_shadow & (vq->split.vring.num -=
 1);
> > > > @@ -861,6 +876,11 @@ static void *virtqueue_get_buf_ctx_split(struc=
t virtqueue *_vq,
> > > >               BAD_RING(vq, "id %u is not a head!\n", i);
> > > >               return NULL;
> > > >       }
> > > > +     if (vq->split.buflen && unlikely(*len > vq->split.buflen[i]))=
 {
> > > > +             BAD_RING(vq, "used len %d is larger than max in buffe=
r len %u\n",
> > > > +                     *len, vq->split.buflen[i]);
> > > > +             return NULL;
> > > > +     }
> > > >
> > > >       /* detach_buf_split clears data, so grab it now. */
> > > >       ret =3D vq->split.desc_state[i].data;
> > > > @@ -1085,10 +1105,25 @@ static void vring_free_split(struct vring_v=
irtqueue_split *vring_split,
> > > >                        vring_split->queue_dma_addr,
> > > >                        dma_dev);
> > > >
> > > > +     kfree(vring_split->buflen);
> > > >       kfree(vring_split->desc_state);
> > > >       kfree(vring_split->desc_extra);
> > > >  }
> > > >
> > > > +static bool vring_needs_used_validation(const struct virtio_device=
 *vdev)
> > > > +{
> > > > +     /*
> > > > +      * Several legacy devices are known to produce buggy used
> > > > +      * length. In order to let driver work, we won't validate use=
d
> > > > +      * buffer length in this case.
> > > > +      */
> > > > +     if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
> > > > +             return false;
> > > > +     if (force_used_validation)
> > > > +             return true;
> > > > +     return false;
> > > > +}
> > > > +
> > > >  static int vring_alloc_queue_split(struct vring_virtqueue_split *v=
ring_split,
> > > >                                  struct virtio_device *vdev,
> > > >                                  u32 num,
> > > > @@ -1137,7 +1172,19 @@ static int vring_alloc_queue_split(struct vr=
ing_virtqueue_split *vring_split,
> > > >       vring_split->vring_align =3D vring_align;
> > > >       vring_split->may_reduce_num =3D may_reduce_num;
> > > >
> > > > +     if (vring_needs_used_validation(vdev)) {
> > > > +             vring_split->buflen =3D
> > > > +                     kmalloc_array(num, sizeof(*vring_split->bufle=
n),
> > > > +                                   GFP_KERNEL);
> > > > +             if (!vring_split->buflen)
> > > > +                     goto err_buflen;
> > > > +     }
> > > > +
> > > >       return 0;
> > > > +
> > > > +err_buflen:
> > > > +     vring_free_split(vring_split, vdev, dma_dev);
> > > > +     return -ENOMEM;
> > > >  }
> > > >
> > > >  static struct virtqueue *vring_create_virtqueue_split(
> > > > @@ -1297,6 +1344,7 @@ static int virtqueue_add_indirect_packed(stru=
ct vring_virtqueue *vq,
> > > >       unsigned int i, n, err_idx;
> > > >       u16 head, id;
> > > >       dma_addr_t addr;
> > > > +     u32 buflen =3D 0;
> > > >
> > > >       head =3D vq->packed.next_avail_idx;
> > > >       desc =3D alloc_indirect_packed(total_sg, gfp);
> > > > @@ -1325,6 +1373,8 @@ static int virtqueue_add_indirect_packed(stru=
ct vring_virtqueue *vq,
> > > >                       desc[i].addr =3D cpu_to_le64(addr);
> > > >                       desc[i].len =3D cpu_to_le32(sg->length);
> > > >                       i++;
> > > > +                     if (n >=3D out_sgs)
> > > > +                             buflen +=3D sg->length;
> > > >               }
> > > >       }
> > > >
> > > > @@ -1379,6 +1429,10 @@ static int virtqueue_add_indirect_packed(str=
uct vring_virtqueue *vq,
> > > >       vq->packed.desc_state[id].last =3D id;
> > > >       vq->packed.desc_state[id].premapped =3D premapped;
> > > >
> > > > +     /* Store in buffer length if necessary */
> > > > +     if (vq->packed.buflen)
> > > > +             vq->packed.buflen[id] =3D buflen;
> > > > +
> > > >       vq->num_added +=3D 1;
> > > >
> > > >       pr_debug("Added buffer head %i to %p\n", head, vq);
> > > > @@ -1416,6 +1470,7 @@ static inline int virtqueue_add_packed(struct=
 virtqueue *_vq,
> > > >       __le16 head_flags, flags;
> > > >       u16 head, id, prev, curr, avail_used_flags;
> > > >       int err;
> > > > +     u32 buflen =3D 0;
> > > >
> > > >       START_USE(vq);
> > > >
> > > > @@ -1498,6 +1553,8 @@ static inline int virtqueue_add_packed(struct=
 virtqueue *_vq,
> > > >                                       1 << VRING_PACKED_DESC_F_AVAI=
L |
> > > >                                       1 << VRING_PACKED_DESC_F_USED=
;
> > > >                       }
> > > > +                     if (n >=3D out_sgs)
> > > > +                             buflen +=3D sg->length;
> > > >               }
> > > >       }
> > > >
> > > > @@ -1518,6 +1575,10 @@ static inline int virtqueue_add_packed(struc=
t virtqueue *_vq,
> > > >       vq->packed.desc_state[id].last =3D prev;
> > > >       vq->packed.desc_state[id].premapped =3D premapped;
> > > >
> > > > +     /* Store in buffer length if necessary */
> > > > +     if (vq->packed.buflen)
> > > > +             vq->packed.buflen[id] =3D buflen;
> > > > +
> > > >       /*
> > > >        * A driver MUST NOT make the first descriptor in the list
> > > >        * available before all subsequent descriptors comprising
> > > > @@ -1718,6 +1779,11 @@ static void *virtqueue_get_buf_ctx_packed(st=
ruct virtqueue *_vq,
> > > >               BAD_RING(vq, "id %u is not a head!\n", id);
> > > >               return NULL;
> > > >       }
> > > > +     if (vq->packed.buflen && unlikely(*len > vq->packed.buflen[id=
])) {
> > > > +             BAD_RING(vq, "used len %d is larger than max in buffe=
r len %u\n",
> > > > +                     *len, vq->packed.buflen[id]);
> > > > +             return NULL;
> > > > +     }
> > > >
> > > >       /* detach_buf_packed clears data, so grab it now. */
> > > >       ret =3D vq->packed.desc_state[id].data;
> > > > @@ -1937,6 +2003,7 @@ static void vring_free_packed(struct vring_vi=
rtqueue_packed *vring_packed,
> > > >                                vring_packed->device_event_dma_addr,
> > > >                                dma_dev);
> > > >
> > > > +     kfree(vring_packed->buflen);
> > > >       kfree(vring_packed->desc_state);
> > > >       kfree(vring_packed->desc_extra);
> > > >  }
> > > > @@ -1988,6 +2055,14 @@ static int vring_alloc_queue_packed(struct v=
ring_virtqueue_packed *vring_packed,
> > > >
> > > >       vring_packed->vring.num =3D num;
> > > >
> > > > +     if (vring_needs_used_validation(vdev)) {
> > > > +             vring_packed->buflen =3D
> > > > +                     kmalloc_array(num, sizeof(*vring_packed->bufl=
en),
> > > > +                                   GFP_KERNEL);
> > > > +             if (!vring_packed->buflen)
> > > > +                     goto err;
> > > > +     }
> > > > +
> > > >       return 0;
> > > >
> > > >  err:
> > > > --
> > > > 2.25.1
> > >
>

