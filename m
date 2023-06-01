Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90496719005
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 03:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjFAB2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 21:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjFAB2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 21:28:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F6212F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 18:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685582844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uXCu9Z2wRxrXdCLjrFqtw+Pc6jnHmSDNhIHMLD9aB2Q=;
        b=QXlORUAtH5F8j9VJj7MUSwI+8vln6QwIgCAZ4lmshmA4eobNkEEV0z05ZkzxRP4wc5nOvo
        +un5drM4fuv5/04iYeOS9iZMOOPpmpynTadzPIFOTfT4zQ1oCOWCo54HreKT3/tAM06aJV
        FsKGNbMaWVwSVgZiAtYKJGkDebC0sBE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-c7535LHkOgmkxQEZ1NHl0g-1; Wed, 31 May 2023 21:27:22 -0400
X-MC-Unique: c7535LHkOgmkxQEZ1NHl0g-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2af8a985ab2so2127741fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 18:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685582841; x=1688174841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXCu9Z2wRxrXdCLjrFqtw+Pc6jnHmSDNhIHMLD9aB2Q=;
        b=S63/n+C73ZBDkOd2qiHAEa2f1Y++G3L8oNdQb0GJX4Ly6+Mpxo6DLiZBwhagPXshMj
         epmpTEKEqGn7OZFN7f0ZQg/qVYnp8It9CnIVZDB5lmrOtnF7954KM833X8PmpWHbnU6z
         HPbTV9bM/fqjM7FnEEedd/Tyvec0dnBOXekatul3FSWM2GQb2gTddyavLJ7jKuUdRFxv
         0QO8AqP3bApmcoxH3PWs6KOYHCc452JZsmyB8TUKce7rpCpbc9nh3IKTpI+1ZDjGrNWS
         aMzd6ZPbBMSxMB5iy3fADSEs1hOdB/TwfMv3qpGQyie11zrLN69f44bCLpPeD9wreWBS
         XsyQ==
X-Gm-Message-State: AC+VfDwQozPvQZDVAT2jy6Pc+k+MIfVmCKekYAbEGLL5IQ1NZOcAT2ig
        FsglSvU4TRBX6MEduhDQ++C3bQ07tHZn2JC1/h5HhLYNRxhDX6oRWP8CHQDptLcQWXtPc6E0h+Q
        xg7VG+fVO0Gz3cn+XfladYYzktxaqqPdkUr0mrZ+NgfQ6cVAwNEo=
X-Received: by 2002:a2e:8255:0:b0:2ad:a9c0:1236 with SMTP id j21-20020a2e8255000000b002ada9c01236mr3640333ljh.6.1685582840753;
        Wed, 31 May 2023 18:27:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6+AsQyrWZ4QhV01P3lN1wU7DjAsi65W65x0eXbKxrO3zSpa9JNj+Jtnafxsiv7PGJbTZVmx7hQvu8VbIgc7Zg=
X-Received: by 2002:a2e:8255:0:b0:2ad:a9c0:1236 with SMTP id
 j21-20020a2e8255000000b002ada9c01236mr3640321ljh.6.1685582840325; Wed, 31 May
 2023 18:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230526063041.18359-1-jasowang@redhat.com> <20230528033037-mutt-send-email-mst@kernel.org>
 <CACGkMEs9Ztavn2JyuUAb47Sk1fYHiXLLkQQPQR5Czhb2yu_R3w@mail.gmail.com>
 <20230529055729-mutt-send-email-mst@kernel.org> <CACGkMEsW1+BFtMoLg4c_FyxYTZJcSVh4BoEdJ-Q9_WGg_DcReA@mail.gmail.com>
 <20230531014326-mutt-send-email-mst@kernel.org> <CACGkMEvok6HjBK_ZMR4EYzWxpJQVeh++EMErnHjJ6cu9m3R-1A@mail.gmail.com>
 <CACGkMEuDWL30J7D8v+xLCvvspRBoz8X7q23FymBVRm9bT1pVUQ@mail.gmail.com> <20230531062108-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230531062108-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 1 Jun 2023 09:27:08 +0800
Message-ID: <CACGkMEvE=e1tRFScbzija=oUMqznqMDs7jQKCie9ya1NehwnVA@mail.gmail.com>
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

On Wed, May 31, 2023 at 6:25=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, May 31, 2023 at 04:26:38PM +0800, Jason Wang wrote:
> > On Wed, May 31, 2023 at 3:36=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Wed, May 31, 2023 at 1:50=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Wed, May 31, 2023 at 09:05:00AM +0800, Jason Wang wrote:
> > > > > On Mon, May 29, 2023 at 6:03=E2=80=AFPM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
> > > > > >
> > > > > > On Mon, May 29, 2023 at 09:18:10AM +0800, Jason Wang wrote:
> > > > > > > On Sun, May 28, 2023 at 3:57=E2=80=AFPM Michael S. Tsirkin <m=
st@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, May 26, 2023 at 02:30:41PM +0800, Jason Wang wrote:
> > > > > > > > > This patch validate
> > > > > > > >
> > > > > > > > validates
> > > > > > > >
> > > > > > > > > the used buffer length provided by the device
> > > > > > > > > before trying to use it.
> > > > > > > >
> > > > > > > > before returning it to caller
> > > > > > > >
> > > > > > > > > This is done by remembering the in buffer
> > > > > > > > > length in a dedicated array during virtqueue_add(), then =
we can fail
> > > > > > > > > the virtqueue_get_buf() when we find the device is trying=
 to give us a
> > > > > > > > > used buffer length which is greater than we stored before=
.
> > > > > > > >
> > > > > > > > than what we stored
> > > > > > > >
> > > > > > > > >
> > > > > > > > > This validation is disable
> > > > > > > >
> > > > > > > > disabled
> > > > > > > >
> > > > > > > > > by default via module parameter to unbreak
> > > > > > > > > some existing devices since some legacy devices are known=
 to report
> > > > > > > > > buggy used length.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > >
> > > > > > > > First I'm not merging this without more data about
> > > > > > > > what is known to be broken and what is known to work well
> > > > > > > > in the commit log. And how exactly do things work if used l=
ength
> > > > > > > > is wrong?
> > > > > > >
> > > > > > > Assuming the device is malicious, it would be very hard to an=
swer.
> > > > > > > Auditing and fuzzing won't cover every case. Instead of tryin=
g to seek
> > > > > > > the answer, we can simply make sure the used in buffer length=
 is
> > > > > > > validated then we know we're fine or not.
> > > > > >
> > > > > > To restate the question, you said above "some legacy devices ar=
e known
> > > > > > to report buggy used length". If they report buggy length then =
how
> > > > > > can things work?
> > > > >
> > > > > The validation is disabled for legacy device (as stated in the ch=
angelog):
> > > > >
> > > > > static bool vring_needs_used_validation(const struct virtio_devic=
e *vdev)
> > > > > {
> > > > >         /*
> > > > >          * Several legacy devices are known to produce buggy used
> > > > >          * length. In order to let driver work, we won't validate=
 used
> > > > >          * buffer length in this case.
> > > > >          */
> > > > >         if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
> > > > >                 return false;
> > > > >         if (force_used_validation)
> > > > >                 return true;
> > > > >         return false;
> > > > > }
> > > > >
> > > > > This seems to be what we've agreed in last version:
> > > > >
> > > > > https://lore.kernel.org/all/CANLsYkxfhamUU0bb4j7y6N4_G9odKxLCjXxg=
XEx4SJ6_Kf+M2Q@mail.gmail.com/T/#m31f3b06f9032beec175c312dfa2532cb08b15c56
> > > > >
> > > > > Thanks
> > > > >
> > > >
> > > > I don't get it. You wrote:
> > > >
> > > >         This validation is disable
> > > >         by default via module parameter to unbreak
> > > >         some existing devices since some legacy devices are known t=
o report
> > > >         buggy used length.
> > > >
> > > > which devices?
> > >
> > > legacy rpmsg and vsock device (before 49d8c5ffad07) at least.
> > >
> > > > why do you need a module parameter?
> > >
> > > If we enable it unconditionally for modern devices, it may break some
> > > buggy moden device (vsock without a fix as an example).
> > >
> > > >
> > > >
> > > > > >
> > > > > > > > Second what's wrong with dma_desc_extra that we already mai=
ntain?
> > > > > > > > Third motivation - it's part and parcel of the hardening ef=
fort yes?
> > > > > > >
> > > > > > > They are different. dma_desc_extra is for a descriptor ring, =
but this
> > > > > > > is for a used ring. Technically we can go back to iterate on =
the
> > > > > > > descriptor ring for a legal used in buffer length. But it wil=
l have
> > > > > > > worse performance.
> > > > > >
> > > > > > I don't really understand. We already iterate when we unmap -
> > > > > > all that is necessary is to subtract it from used length, if at
> > > > > > the end of the process it is >0 then we know used length is too
> > > > > > large.
> > > > >
> > > > > Yes, but it is the job that is done in the driver level not the v=
irtio
> > > > > core.
> > > >
> > > > What job?
> > >
> > > I meant the driver can do the validation since it has the knowledge o=
f
> > > the buffer length if it wants.
> > >
> > > > unmap is done in detach_buf_split and detach_buf_packed respectivel=
y.
> > > > vring_desc_extra isn't even visible outside drivers/virtio/virtio_r=
ing.c
> > >
> > > desc_extra doesn't contain buffer length for the case of indirect
> > > descriptors. So we need to iterate in the descriptors when it looks
> > > expensive if we don't need unmap.
> > >
> > > Thanks
> > >
> > > >
> > > > For drivers that do unmap at driver level - I guess they can do
> > > > validation there too.
> > > >
> > > > > Validation in virtio core is still necessary since they're
> > > > > working at different levels and it's hard to force the validation=
 in
> > > > > all drivers by codes. Last version introduces a
> > > > > suppress_driver_validation to allow the driver to suppress the co=
re
> > > > > validation which seems not good, we need a way to force the
> > > > > virtio_ring code to do validation before.
> > > >
> > > > Why do we? If driver validates length virtio_ring does not need to
> > > > validate.
> >
> > To be more safe, there's no guarantee that there's no bug in the driver=
.
>
> Extra options increase testing matrix size so - there be bugs.
> We need to make these decisions for (most) users.

In some cases the requirement is conflict:

1) for "legacy users", the requirement is not to break existing setups
2) for confidential users, the requirement is to detect and fail early
instead of trying to mitigate silently

If we are trying to go in the middle (for example, doing a cap) it may
end up with a result that can satisfy neither:

1) it might still break in some drivers and setups like legacy, then
we need an option to disable it
2) it won't satisfy the users that ask for security

If we had an option, the management layer can choose to provision
VM/guests with the good kernel command line then we are fine.

>
> > >  If driver does not use length virtio_ring does not need to
> > > > validate.
> >
> > This could be done on top assuming the validation is disabled by
> > default. But if the administrator wants to have belt and braces we
> > need to leave an option for them.
> >
> > Thanks
>
> No, we don't regress then fix on top.

I'm not sure I understand here. It would be very hard to say there
won't be regression for any new codes, especially virtio had already
supported several different types of devices and drivers.

> As for mod parameter I am not impressed -
> no one's going to have the time or inclination to do the requisite
> testing to know whether the module parameter is safe.

Actually, that's one advantage, most of the users don't care so the
validation is just suppressed for them. Otherwise they might get
surprised after upgrading. This is what I learnt from the past
hardening effort like this and the IRQ hardening.

For the rest like confidential vendors, they need to test and make
sure such kernel command line were provisioned to the VM.

Thanks

>
> > > core can provide this service for the gazillion non
> > > > performance critical drivers that just want to keep things simple,
> > > > but the 4-5 critical ones can do their own validation if they want =
to.
> > > >
> > > > > Or such stuff could be added
> > > > > on top since the validation is by default anyway.
> > > > >
> > > > > Thanks
> > > >
> > > >
> > > >
> > > > > >
> > > > > >
> > > > > > > > I'd like to know the fate of VIRTIO_HARDEN_NOTIFICATION bef=
ore
> > > > > > > > we do more hardening. If it's irrevocably broken let's rip =
it out?
> > > > > > >
> > > > > > > So the plan is
> > > > > > >
> > > > > > > 1) finish used ring validation (this had been proposed, merge=
d and
> > > > > > > reverted before notification hardening)
> > > > > > > 2) do notification hardening on top.
> > > > > > >
> > > > > > > So let's leave it as is and I will do a rework after we final=
ize the
> > > > > > > used ring validation.
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > > ---
> > > > > > > > > Changes since V4:
> > > > > > > > > - drop the flat for driver to suppress the check
> > > > > > > > > - validation is disabled by default
> > > > > > > > > - don't do validation for legacy device
> > > > > > > > > - rebase and support virtqueue resize
> > > > > > > > > ---
> > > > > > > > >  drivers/virtio/virtio_ring.c | 75 ++++++++++++++++++++++=
++++++++++++++
> > > > > > > > >  1 file changed, 75 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virti=
o/virtio_ring.c
> > > > > > > > > index 143f380baa1c..5b151605aaf8 100644
> > > > > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > > > > @@ -15,6 +15,9 @@
> > > > > > > > >  #include <linux/spinlock.h>
> > > > > > > > >  #include <xen/xen.h>
> > > > > > > > >
> > > > > > > > > +static bool force_used_validation =3D false;
> > > > > > > > > +module_param(force_used_validation, bool, 0444);
> > > > > > > > > +
> > > > > > > > >  #ifdef DEBUG
> > > > > > > > >  /* For development, we want to crash whenever the ring i=
s screwed. */
> > > > > > > > >  #define BAD_RING(_vq, fmt, args...)                     =
     \
> > > > > > > > > @@ -105,6 +108,9 @@ struct vring_virtqueue_split {
> > > > > > > > >       struct vring_desc_state_split *desc_state;
> > > > > > > > >       struct vring_desc_extra *desc_extra;
> > > > > > > > >
> > > > > > > > > +     /* Maximum in buffer length, NULL means no used val=
idation */
> > > > > > > > > +     u32 *buflen;
> > > > > > > > > +
> > > > > > > > >       /* DMA address and size information */
> > > > > > > > >       dma_addr_t queue_dma_addr;
> > > > > > > > >       size_t queue_size_in_bytes;
> > > > > > > > > @@ -145,6 +151,9 @@ struct vring_virtqueue_packed {
> > > > > > > > >       struct vring_desc_state_packed *desc_state;
> > > > > > > > >       struct vring_desc_extra *desc_extra;
> > > > > > > > >
> > > > > > > > > +     /* Maximum in buffer length, NULL means no used val=
idation */
> > > > > > > > > +     u32 *buflen;
> > > > > > > > > +
> > > > > > > > >       /* DMA address and size information */
> > > > > > > > >       dma_addr_t ring_dma_addr;
> > > > > > > > >       dma_addr_t driver_event_dma_addr;
> > > > > > > > > @@ -552,6 +561,7 @@ static inline int virtqueue_add_split=
(struct virtqueue *_vq,
> > > > > > > > >       unsigned int i, n, avail, descs_used, prev, err_idx=
;
> > > > > > > > >       int head;
> > > > > > > > >       bool indirect;
> > > > > > > > > +     u32 buflen =3D 0;
> > > > > > > > >
> > > > > > > > >       START_USE(vq);
> > > > > > > > >
> > > > > > > > > @@ -635,6 +645,7 @@ static inline int virtqueue_add_split=
(struct virtqueue *_vq,
> > > > > > > > >                                                    VRING_=
DESC_F_NEXT |
> > > > > > > > >                                                    VRING_=
DESC_F_WRITE,
> > > > > > > > >                                                    indire=
ct);
> > > > > > > > > +                     buflen +=3D sg->length;
> > > > > > > > >               }
> > > > > > > > >       }
> > > > > > > > >       /* Last one doesn't continue. */
> > > > > > > > > @@ -675,6 +686,10 @@ static inline int virtqueue_add_spli=
t(struct virtqueue *_vq,
> > > > > > > > >       else
> > > > > > > > >               vq->split.desc_state[head].indir_desc =3D c=
tx;
> > > > > > > > >
> > > > > > > > > +     /* Store in buffer length if necessary */
> > > > > > > > > +     if (vq->split.buflen)
> > > > > > > > > +             vq->split.buflen[head] =3D buflen;
> > > > > > > > > +
> > > > > > > > >       /* Put entry in available array (but don't update a=
vail->idx until they
> > > > > > > > >        * do sync). */
> > > > > > > > >       avail =3D vq->split.avail_idx_shadow & (vq->split.v=
ring.num - 1);
> > > > > > > > > @@ -861,6 +876,11 @@ static void *virtqueue_get_buf_ctx_s=
plit(struct virtqueue *_vq,
> > > > > > > > >               BAD_RING(vq, "id %u is not a head!\n", i);
> > > > > > > > >               return NULL;
> > > > > > > > >       }
> > > > > > > > > +     if (vq->split.buflen && unlikely(*len > vq->split.b=
uflen[i])) {
> > > > > > > > > +             BAD_RING(vq, "used len %d is larger than ma=
x in buffer len %u\n",
> > > > > > > > > +                     *len, vq->split.buflen[i]);
> > > > > > > > > +             return NULL;
> > > > > > > > > +     }
> > > > > > > > >
> > > > > > > > >       /* detach_buf_split clears data, so grab it now. */
> > > > > > > > >       ret =3D vq->split.desc_state[i].data;
> > > > > > > > > @@ -1085,10 +1105,25 @@ static void vring_free_split(stru=
ct vring_virtqueue_split *vring_split,
> > > > > > > > >                        vring_split->queue_dma_addr,
> > > > > > > > >                        dma_dev);
> > > > > > > > >
> > > > > > > > > +     kfree(vring_split->buflen);
> > > > > > > > >       kfree(vring_split->desc_state);
> > > > > > > > >       kfree(vring_split->desc_extra);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static bool vring_needs_used_validation(const struct vir=
tio_device *vdev)
> > > > > > > > > +{
> > > > > > > > > +     /*
> > > > > > > > > +      * Several legacy devices are known to produce bugg=
y used
> > > > > > > > > +      * length. In order to let driver work, we won't va=
lidate used
> > > > > > > > > +      * buffer length in this case.
> > > > > > > > > +      */
> > > > > > > > > +     if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
> > > > > > > > > +             return false;
> > > > > > > > > +     if (force_used_validation)
> > > > > > > > > +             return true;
> > > > > > > > > +     return false;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  static int vring_alloc_queue_split(struct vring_virtqueu=
e_split *vring_split,
> > > > > > > > >                                  struct virtio_device *vd=
ev,
> > > > > > > > >                                  u32 num,
> > > > > > > > > @@ -1137,7 +1172,19 @@ static int vring_alloc_queue_split=
(struct vring_virtqueue_split *vring_split,
> > > > > > > > >       vring_split->vring_align =3D vring_align;
> > > > > > > > >       vring_split->may_reduce_num =3D may_reduce_num;
> > > > > > > > >
> > > > > > > > > +     if (vring_needs_used_validation(vdev)) {
> > > > > > > > > +             vring_split->buflen =3D
> > > > > > > > > +                     kmalloc_array(num, sizeof(*vring_sp=
lit->buflen),
> > > > > > > > > +                                   GFP_KERNEL);
> > > > > > > > > +             if (!vring_split->buflen)
> > > > > > > > > +                     goto err_buflen;
> > > > > > > > > +     }
> > > > > > > > > +
> > > > > > > > >       return 0;
> > > > > > > > > +
> > > > > > > > > +err_buflen:
> > > > > > > > > +     vring_free_split(vring_split, vdev, dma_dev);
> > > > > > > > > +     return -ENOMEM;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > >  static struct virtqueue *vring_create_virtqueue_split(
> > > > > > > > > @@ -1297,6 +1344,7 @@ static int virtqueue_add_indirect_p=
acked(struct vring_virtqueue *vq,
> > > > > > > > >       unsigned int i, n, err_idx;
> > > > > > > > >       u16 head, id;
> > > > > > > > >       dma_addr_t addr;
> > > > > > > > > +     u32 buflen =3D 0;
> > > > > > > > >
> > > > > > > > >       head =3D vq->packed.next_avail_idx;
> > > > > > > > >       desc =3D alloc_indirect_packed(total_sg, gfp);
> > > > > > > > > @@ -1325,6 +1373,8 @@ static int virtqueue_add_indirect_p=
acked(struct vring_virtqueue *vq,
> > > > > > > > >                       desc[i].addr =3D cpu_to_le64(addr);
> > > > > > > > >                       desc[i].len =3D cpu_to_le32(sg->len=
gth);
> > > > > > > > >                       i++;
> > > > > > > > > +                     if (n >=3D out_sgs)
> > > > > > > > > +                             buflen +=3D sg->length;
> > > > > > > > >               }
> > > > > > > > >       }
> > > > > > > > >
> > > > > > > > > @@ -1379,6 +1429,10 @@ static int virtqueue_add_indirect_=
packed(struct vring_virtqueue *vq,
> > > > > > > > >       vq->packed.desc_state[id].last =3D id;
> > > > > > > > >       vq->packed.desc_state[id].premapped =3D premapped;
> > > > > > > > >
> > > > > > > > > +     /* Store in buffer length if necessary */
> > > > > > > > > +     if (vq->packed.buflen)
> > > > > > > > > +             vq->packed.buflen[id] =3D buflen;
> > > > > > > > > +
> > > > > > > > >       vq->num_added +=3D 1;
> > > > > > > > >
> > > > > > > > >       pr_debug("Added buffer head %i to %p\n", head, vq);
> > > > > > > > > @@ -1416,6 +1470,7 @@ static inline int virtqueue_add_pac=
ked(struct virtqueue *_vq,
> > > > > > > > >       __le16 head_flags, flags;
> > > > > > > > >       u16 head, id, prev, curr, avail_used_flags;
> > > > > > > > >       int err;
> > > > > > > > > +     u32 buflen =3D 0;
> > > > > > > > >
> > > > > > > > >       START_USE(vq);
> > > > > > > > >
> > > > > > > > > @@ -1498,6 +1553,8 @@ static inline int virtqueue_add_pac=
ked(struct virtqueue *_vq,
> > > > > > > > >                                       1 << VRING_PACKED_D=
ESC_F_AVAIL |
> > > > > > > > >                                       1 << VRING_PACKED_D=
ESC_F_USED;
> > > > > > > > >                       }
> > > > > > > > > +                     if (n >=3D out_sgs)
> > > > > > > > > +                             buflen +=3D sg->length;
> > > > > > > > >               }
> > > > > > > > >       }
> > > > > > > > >
> > > > > > > > > @@ -1518,6 +1575,10 @@ static inline int virtqueue_add_pa=
cked(struct virtqueue *_vq,
> > > > > > > > >       vq->packed.desc_state[id].last =3D prev;
> > > > > > > > >       vq->packed.desc_state[id].premapped =3D premapped;
> > > > > > > > >
> > > > > > > > > +     /* Store in buffer length if necessary */
> > > > > > > > > +     if (vq->packed.buflen)
> > > > > > > > > +             vq->packed.buflen[id] =3D buflen;
> > > > > > > > > +
> > > > > > > > >       /*
> > > > > > > > >        * A driver MUST NOT make the first descriptor in t=
he list
> > > > > > > > >        * available before all subsequent descriptors comp=
rising
> > > > > > > > > @@ -1718,6 +1779,11 @@ static void *virtqueue_get_buf_ctx=
_packed(struct virtqueue *_vq,
> > > > > > > > >               BAD_RING(vq, "id %u is not a head!\n", id);
> > > > > > > > >               return NULL;
> > > > > > > > >       }
> > > > > > > > > +     if (vq->packed.buflen && unlikely(*len > vq->packed=
.buflen[id])) {
> > > > > > > > > +             BAD_RING(vq, "used len %d is larger than ma=
x in buffer len %u\n",
> > > > > > > > > +                     *len, vq->packed.buflen[id]);
> > > > > > > > > +             return NULL;
> > > > > > > > > +     }
> > > > > > > > >
> > > > > > > > >       /* detach_buf_packed clears data, so grab it now. *=
/
> > > > > > > > >       ret =3D vq->packed.desc_state[id].data;
> > > > > > > > > @@ -1937,6 +2003,7 @@ static void vring_free_packed(struc=
t vring_virtqueue_packed *vring_packed,
> > > > > > > > >                                vring_packed->device_event=
_dma_addr,
> > > > > > > > >                                dma_dev);
> > > > > > > > >
> > > > > > > > > +     kfree(vring_packed->buflen);
> > > > > > > > >       kfree(vring_packed->desc_state);
> > > > > > > > >       kfree(vring_packed->desc_extra);
> > > > > > > > >  }
> > > > > > > > > @@ -1988,6 +2055,14 @@ static int vring_alloc_queue_packe=
d(struct vring_virtqueue_packed *vring_packed,
> > > > > > > > >
> > > > > > > > >       vring_packed->vring.num =3D num;
> > > > > > > > >
> > > > > > > > > +     if (vring_needs_used_validation(vdev)) {
> > > > > > > > > +             vring_packed->buflen =3D
> > > > > > > > > +                     kmalloc_array(num, sizeof(*vring_pa=
cked->buflen),
> > > > > > > > > +                                   GFP_KERNEL);
> > > > > > > > > +             if (!vring_packed->buflen)
> > > > > > > > > +                     goto err;
> > > > > > > > > +     }
> > > > > > > > > +
> > > > > > > > >       return 0;
> > > > > > > > >
> > > > > > > > >  err:
> > > > > > > > > --
> > > > > > > > > 2.25.1
> > > > > > > >
> > > > > >
> > > >
>

