Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273326CBA28
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjC1JKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjC1JJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:09:59 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931A64ED1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:09:32 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id q16so14857098lfe.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679994571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0FJY5p1XKwPzYvLnkNi9oo0lek3cMv6F0ETbdlGKMA=;
        b=j1e9efDnhizqRWx6+6IgWT5o6+XnOTpMVf7F8qoMPpQLH0TfhEyIxZ6EJyT+t6d6ap
         2FD9NVU/Uge5R8ozLdxLmyrRWt9YkQoWNk9Cd83aa1oqYT94wRBIY3aI6JX3UJMT166h
         n2TgAwvaRXz3w7A3++nQMTvUYIZFT/Lytx6Id+tABatsQ050voPh8B+zTyv2M77Tjt9n
         Nl4O6zSBEcDNKhVqoGgsIQfPhPJiu8JJwdC3tj54qXElAJ9WH2WxoFNq3ijR1GP6jGeX
         vWrk72qq4BpPZBRHKYMye/deg0o9bZHE+4k8NnT5azEst8MI//mTHkmvlNNPypSLO3I3
         af+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679994571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0FJY5p1XKwPzYvLnkNi9oo0lek3cMv6F0ETbdlGKMA=;
        b=V6ET+DualfpJWov3IBk7QjWVaxob4vKkSz0SmBS8Y3/GQ/r96QTAmNQ7OLMQrEb5CA
         joYg2UBHnoIlp+rJk+3SA3q//9ZnSiY+ZUGHQX2r+zUzkYlJsw12hXp+Yq1zVm03b98b
         SH08PlpHWMcav7rMI5z+X2trvEpWRzzzu3yg1EaHWpJfBuDrokqOwlw+4gA6erGj1NIQ
         G0A6kxgLcQIdkHnARz3mP0Mv0LBlLPjCSVShLnn0Dihf7GblRbDYJQF5sK3lEttbx2IL
         1tViPvP+SD2K5Yx7noNImOwKNRnIX5nq9k0k3YSlsBWEqWQcWnS4rEB3AK46EuqzEW1W
         vmTg==
X-Gm-Message-State: AAQBX9eo5BTm1bVsqkexWFNPy4bUEMg7HQ+jjiXwxY9oFUDGIcT299dP
        Wt6wT36wsHLE170BRZla5Re9bwlc4Y9vvGsJd33z4w==
X-Google-Smtp-Source: AKy350b5Ot50K6CwCRqsdiiYL9iVdbRBVgRwvGLUqJoERAqtVyx7WTUf9fgauZ2PAQ9QMrKdHYYeB/yKZOQwca4y3SM=
X-Received: by 2002:a05:6512:4c2:b0:4e9:c027:5be6 with SMTP id
 w2-20020a05651204c200b004e9c0275be6mr4386630lfq.12.1679994570678; Tue, 28 Mar
 2023 02:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230325105633.58592-1-huangjie.albert@bytedance.com>
 <ZCJNTBQLZeyLBKKB@codewreck.org> <CACGkMEt29t9CK2Muiuyb1s6p2AzgcMiD_z0NVFn1d+KEqBydug@mail.gmail.com>
 <CABKxMyPwuRb6p-oHxcQDhRtJv04=NDWvosNAp=epgvdrfCeveg@mail.gmail.com> <CACGkMEuukvjXBTDX2K9YLYmpHsqK96AiMK39gbm3+f_+kUydMQ@mail.gmail.com>
In-Reply-To: <CACGkMEuukvjXBTDX2K9YLYmpHsqK96AiMK39gbm3+f_+kUydMQ@mail.gmail.com>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Tue, 28 Mar 2023 17:09:19 +0800
Message-ID: <CABKxMyN0598wA6wHv5GkZC14znwp=OPo7u71_BizJfR+gUx4_w@mail.gmail.com>
Subject: Re: [External] Re: 9p regression (Was: [PATCH v2] virtio_ring: don't
 update event idx on get_buf)
To:     Jason Wang <jasowang@redhat.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Wang <jasowang@redhat.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8828=E6=97=
=A5=E5=91=A8=E4=BA=8C 11:40=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Mar 28, 2023 at 11:09=E2=80=AFAM =E9=BB=84=E6=9D=B0 <huangjie.alb=
ert@bytedance.com> wrote:
> >
> > Jason Wang <jasowang@redhat.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=BA=8C 10:59=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Tue, Mar 28, 2023 at 10:13=E2=80=AFAM Dominique Martinet
> > > <asmadeus@codewreck.org> wrote:
> > > >
> > > > Hi Michael, Albert,
> > > >
> > > > Albert Huang wrote on Sat, Mar 25, 2023 at 06:56:33PM +0800:
> > > > > in virtio_net, if we disable the napi_tx, when we triger a tx int=
errupt,
> > > > > the vq->event_triggered will be set to true. It will no longer be=
 set to
> > > > > false. Unless we explicitly call virtqueue_enable_cb_delayed or
> > > > > virtqueue_enable_cb_prepare.
> > > >
> > > > This patch (commited as 35395770f803 ("virtio_ring: don't update ev=
ent
> > > > idx on get_buf") in next-20230327 apparently breaks 9p, as reported=
 by
> > > > Luis in https://lkml.kernel.org/r/ZCI+7Wg5OclSlE8c@bombadil.infrade=
ad.org
> > > >
> > > > I've just hit had a look at recent patches[1] and reverted this to =
test
> > > > and I can mount again, so I'm pretty sure this is the culprit, but =
I
> > > > didn't look at the content at all yet so cannot advise further.
> > > > It might very well be that we need some extra handling for 9p
> > > > specifically that can be added separately if required.
> > > >
> > > > [1] git log 0ec57cfa721fbd36b4c4c0d9ccc5d78a78f7fa35..HEAD drivers/=
virtio/
> > > >
> > > >
> > > > This can be reproduced with a simple mount, run qemu with some -vir=
tfs
> > > > argument and `mount -t 9p -o debug=3D65535 tag mountpoint` will han=
g after
> > > > these messages:
> > > > 9pnet: -- p9_virtio_request (83): 9p debug: virtio request
> > > > 9pnet: -- p9_virtio_request (83): virtio request kicked
> > > >
> > > > So I suspect we're just not getting a callback.
> > >
> > > I think so. The patch assumes the driver will call
> > > virtqueue_disable/enable_cb() which is not the case of the 9p driver.
> > >
> > > So after the first interrupt, event_triggered will be set to true for=
ever.
> > >
> > > Thanks
> > >
> >
> > Hi: Wang
> >
> > Yes,  This patch assumes that all virtio-related drivers will call
> > virtqueue_disable/enable_cb().
> > Thank you for raising this issue.
> >
> > It seems that napi_tx is only related to virtue_net. I'm thinking if
> > we need to refactor
> > napi_tx instead of implementing it inside virtio_ring.
>
> We can hear from others.
>
> I think it's better not to workaround virtio_ring issues in a specific
> driver. It might just add more hacks. We should correctly set
> VRING_AVAIL_F_NO_INTERRUPT,
>
> Do you think the following might work (not even a compile test)?
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 41144b5246a8..12f4efb6dc54 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -852,16 +852,16 @@ static void virtqueue_disable_cb_split(struct
> virtqueue *_vq)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))=
 {
> -               vq->split.avail_flags_shadow |=3D VRING_AVAIL_F_NO_INTERR=
UPT;
> -               if (vq->event)
> -                       /* TODO: this is a hack. Figure out a cleaner
> value to write. */
> -                       vring_used_event(&vq->split.vring) =3D 0x0;
> -               else
> -                       vq->split.vring.avail->flags =3D
> -                               cpu_to_virtio16(_vq->vdev,
> -                                               vq->split.avail_flags_sha=
dow);
> -       }
> +       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> +               vq->split.avail_flags_shadow |=3D VRING_AVAIL_F_NO_INTERR=
UPT;
> +
> +       if (vq->event && !vq->event_triggered)
> +               /* TODO: this is a hack. Figure out a cleaner value to wr=
ite. */
> +               vring_used_event(&vq->split.vring) =3D 0x0;
> +       else
> +               vq->split.vring.avail->flags =3D
> +                       cpu_to_virtio16(_vq->vdev,
> +                                       vq->split.avail_flags_shadow);
>  }
>
>  static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *=
_vq)
> @@ -1697,8 +1697,10 @@ static void virtqueue_disable_cb_packed(struct
> virtqueue *_vq)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       if (vq->packed.event_flags_shadow !=3D VRING_PACKED_EVENT_FLAG_DI=
SABLE) {
> +       if (!(vq->packed.event_flags_shadow & VRING_PACKED_EVENT_FLAG_DIS=
ABLE))
>                 vq->packed.event_flags_shadow =3D VRING_PACKED_EVENT_FLAG=
_DISABLE;
> +
> +       if (vq->event_triggered)
>                 vq->packed.vring.driver->flags =3D
>                         cpu_to_le16(vq->packed.event_flags_shadow);
>         }
> @@ -2330,12 +2332,6 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       /* If device triggered an event already it won't trigger one agai=
n:
> -        * no need to disable.
> -        */
> -       if (vq->event_triggered)
> -               return;
> -
>         if (vq->packed_ring)
>                 virtqueue_disable_cb_packed(_vq);
>         else
>
> Thanks
>

Hi, This patch seems to address the issue I initially raised and also
avoids the problem with virtio-9P.

but maybe this is a better choice:

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 307e139cb11d..6784d155c781 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -812,6 +812,10 @@ static void virtqueue_disable_cb_split(struct
virtqueue *_vq)

        if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
                vq->split.avail_flags_shadow |=3D VRING_AVAIL_F_NO_INTERRUP=
T;
+
+               if (vq->event_triggered)
+                       return;
+
                if (vq->event)
                        /* TODO: this is a hack. Figure out a cleaner
value to write. */
                        vring_used_event(&vq->split.vring) =3D 0x0;
@@ -1546,6 +1550,10 @@ static void virtqueue_disable_cb_packed(struct
virtqueue *_vq)

        if (vq->packed.event_flags_shadow !=3D VRING_PACKED_EVENT_FLAG_DISA=
BLE) {
                vq->packed.event_flags_shadow =3D VRING_PACKED_EVENT_FLAG_D=
ISABLE;
+
+               if (vq->event_triggered)
+                       return;
+
                vq->packed.vring.driver->flags =3D
                        cpu_to_le16(vq->packed.event_flags_shadow);
        }
@@ -2063,12 +2071,6 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
 {
        struct vring_virtqueue *vq =3D to_vvq(_vq);

-       /* If device triggered an event already it won't trigger one again:
-        * no need to disable.
-        */
-       if (vq->event_triggered)
-               return;
-
        if (vq->packed_ring)
                virtqueue_disable_cb_packed(_vq);
        else

Does Michael have any other suggestions?

Thanks.

> >
> > Thanks
> >
> > > >
> > > >
> > > > I'll have a closer look after work, but any advice meanwhile will b=
e
> > > > appreciated!
> > > > (I'm sure Luis would also like a temporary drop from -next until
> > > > this is figured out, but I'll leave this up to you)
> > > >
> > > >
> > > > >
> > > > > If we disable the napi_tx, it will only be called when the tx rin=
g
> > > > > buffer is relatively small.
> > > > >
> > > > > Because event_triggered is true. Therefore, VRING_AVAIL_F_NO_INTE=
RRUPT or
> > > > > VRING_PACKED_EVENT_FLAG_DISABLE will not be set. So we update
> > > > > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->of=
f_wrap
> > > > > every time we call virtqueue_get_buf_ctx. This will bring more in=
terruptions.
> > > > >
> > > > > To summarize:
> > > > > 1) event_triggered was set to true in vring_interrupt()
> > > > > 2) after this nothing will happen for virtqueue_disable_cb() so
> > > > >    VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
> > > > > 3) virtqueue_get_buf_ctx_split() will still think the cb is enabl=
ed
> > > > >    then it tries to publish new event
> > > > >
> > > > > To fix, if event_triggered is set to true, do not update
> > > > > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->of=
f_wrap
> > > > >
> > > > > Tested with iperf:
> > > > > iperf3 tcp stream:
> > > > > vm1 -----------------> vm2
> > > > > vm2 just receives tcp data stream from vm1, and sends the ack to =
vm1,
> > > > > there are many tx interrupts in vm2.
> > > > > but without event_triggered there are just a few tx interrupts.
> > > > >
> > > > > Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> > > > > Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> > > > > Message-Id: <20230321085953.24949-1-huangjie.albert@bytedance.com=
>
> > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > ---
> > > > >  drivers/virtio/virtio_ring.c | 6 ++++--
> > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio=
_ring.c
> > > > > index cbeeea1b0439..1c36fa477966 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -914,7 +914,8 @@ static void *virtqueue_get_buf_ctx_split(stru=
ct virtqueue *_vq,
> > > > >       /* If we expect an interrupt for the next entry, tell host
> > > > >        * by writing event index and flush out the write before
> > > > >        * the read in the next get_buf call. */
> > > > > -     if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTER=
RUPT))
> > > > > +     if (unlikely(!(vq->split.avail_flags_shadow & VRING_AVAIL_F=
_NO_INTERRUPT) &&
> > > > > +                  !vq->event_triggered))
> > > > >               virtio_store_mb(vq->weak_barriers,
> > > > >                               &vring_used_event(&vq->split.vring)=
,
> > > > >                               cpu_to_virtio16(_vq->vdev, vq->last=
_used_idx));
> > > > > @@ -1744,7 +1745,8 @@ static void *virtqueue_get_buf_ctx_packed(s=
truct virtqueue *_vq,
> > > > >        * by writing event index and flush out the write before
> > > > >        * the read in the next get_buf call.
> > > > >        */
> > > > > -     if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED_EVENT=
_FLAG_DESC)
> > > > > +     if (unlikely(vq->packed.event_flags_shadow =3D=3D VRING_PAC=
KED_EVENT_FLAG_DESC &&
> > > > > +                  !vq->event_triggered))
> > > > >               virtio_store_mb(vq->weak_barriers,
> > > > >                               &vq->packed.vring.driver->off_wrap,
> > > > >                               cpu_to_le16(vq->last_used_idx));
> > > >
> > >
> >
>
