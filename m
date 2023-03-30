Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2536CF94A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 04:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjC3Cx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 22:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjC3Cxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 22:53:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6AB558E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 19:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680144792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4EttenRniTRAyINUwSML9x3PTSCdJCbF0TO8TjTN+xs=;
        b=gBpaSOJQqsngR0X/qJLFzwvIGrEtI/Ja3NUQiL1GwOKoe1c2vMoBUOwbpFhAzc1WSlLgng
        gJ+27iMdzu/L7EPDD9iA8v4W4gH709Vb/rTO3Os14t6XIE7USZDWB8Xy2L90JSIFvze49s
        W7Cu/AmdxbR3Jp/PIzRY389TPb4kZY4=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-KJynNWfQPC-3qvAfTgPzEQ-1; Wed, 29 Mar 2023 22:53:11 -0400
X-MC-Unique: KJynNWfQPC-3qvAfTgPzEQ-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-17afa2c993cso9153265fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 19:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680144790; x=1682736790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EttenRniTRAyINUwSML9x3PTSCdJCbF0TO8TjTN+xs=;
        b=kvqxON+KNWn0D9iEjMDukO36nXuItaz1ZeAe2CnyASaOSgbG/WTcI2yD++EfqgH9G0
         SdSYQCvnRxVTwicLJ6+qDV91gJ2XIs0VPXwpCdUcbnUY7xUxfzOsIGAVMosy3LWq6zuE
         fwGTv3EH/NuZ7cpARvAD4A1OVZKEqd5Ug8gp5FDszGNKzt8V5S7qPxS24SaWQIIpmbDp
         ZuaS88RvadV8grdX7nOebbS1g9fAoWkKvQLuvLCSjsVd4EftSeNXaAisbaRfQ4wtsSYq
         0XCkxPSMGucZHWnNR/smg3WAi1IMLEFfW1x5e84NDpHgslcj4FZ5iI20F/iUbphmU1kO
         jqTg==
X-Gm-Message-State: AAQBX9ciIs5y0OVZ5uhY//OXfAoQfADu3a8dRPjAigs7ZuRCqTUGsPtC
        1D5JF3ubpIJ3hC6cz67WRpzyfE1VjuccYcA4+3YKc9Y2THP0NtIFbwYCKQtPX23CfXlxgLyrqmh
        TdDQlE4yOXYJU0evSZkMprb2YsS6O8ah6ZfOaoUqX
X-Received: by 2002:a05:6870:57:b0:17e:e396:cce0 with SMTP id 23-20020a056870005700b0017ee396cce0mr6851493oaz.9.1680144790273;
        Wed, 29 Mar 2023 19:53:10 -0700 (PDT)
X-Google-Smtp-Source: AK7set8UUvgXLVS4RNtlEVzPx32NNTiSwrPsINzV6q6kl81yuAE/AN5EYtWhZ17cOZYMiPtWzpTj9lN3OUvG01gAERw=
X-Received: by 2002:a05:6870:57:b0:17e:e396:cce0 with SMTP id
 23-20020a056870005700b0017ee396cce0mr6851485oaz.9.1680144789951; Wed, 29 Mar
 2023 19:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230325105633.58592-1-huangjie.albert@bytedance.com>
 <ZCJNTBQLZeyLBKKB@codewreck.org> <CACGkMEt29t9CK2Muiuyb1s6p2AzgcMiD_z0NVFn1d+KEqBydug@mail.gmail.com>
 <CABKxMyPwuRb6p-oHxcQDhRtJv04=NDWvosNAp=epgvdrfCeveg@mail.gmail.com>
 <CACGkMEuukvjXBTDX2K9YLYmpHsqK96AiMK39gbm3+f_+kUydMQ@mail.gmail.com> <20230329013722-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230329013722-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 30 Mar 2023 10:52:58 +0800
Message-ID: <CACGkMEthD126t16LFjFkggtXb5u7n0-mRj+noGNu26R2zjKmGA@mail.gmail.com>
Subject: Re: [External] Re: 9p regression (Was: [PATCH v2] virtio_ring: don't
 update event idx on get_buf)
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
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

On Wed, Mar 29, 2023 at 1:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Mar 28, 2023 at 11:39:59AM +0800, Jason Wang wrote:
> > On Tue, Mar 28, 2023 at 11:09=E2=80=AFAM =E9=BB=84=E6=9D=B0 <huangjie.a=
lbert@bytedance.com> wrote:
> > >
> > > Jason Wang <jasowang@redhat.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=BA=8C 10:59=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On Tue, Mar 28, 2023 at 10:13=E2=80=AFAM Dominique Martinet
> > > > <asmadeus@codewreck.org> wrote:
> > > > >
> > > > > Hi Michael, Albert,
> > > > >
> > > > > Albert Huang wrote on Sat, Mar 25, 2023 at 06:56:33PM +0800:
> > > > > > in virtio_net, if we disable the napi_tx, when we triger a tx i=
nterrupt,
> > > > > > the vq->event_triggered will be set to true. It will no longer =
be set to
> > > > > > false. Unless we explicitly call virtqueue_enable_cb_delayed or
> > > > > > virtqueue_enable_cb_prepare.
> > > > >
> > > > > This patch (commited as 35395770f803 ("virtio_ring: don't update =
event
> > > > > idx on get_buf") in next-20230327 apparently breaks 9p, as report=
ed by
> > > > > Luis in https://lkml.kernel.org/r/ZCI+7Wg5OclSlE8c@bombadil.infra=
dead.org
> > > > >
> > > > > I've just hit had a look at recent patches[1] and reverted this t=
o test
> > > > > and I can mount again, so I'm pretty sure this is the culprit, bu=
t I
> > > > > didn't look at the content at all yet so cannot advise further.
> > > > > It might very well be that we need some extra handling for 9p
> > > > > specifically that can be added separately if required.
> > > > >
> > > > > [1] git log 0ec57cfa721fbd36b4c4c0d9ccc5d78a78f7fa35..HEAD driver=
s/virtio/
> > > > >
> > > > >
> > > > > This can be reproduced with a simple mount, run qemu with some -v=
irtfs
> > > > > argument and `mount -t 9p -o debug=3D65535 tag mountpoint` will h=
ang after
> > > > > these messages:
> > > > > 9pnet: -- p9_virtio_request (83): 9p debug: virtio request
> > > > > 9pnet: -- p9_virtio_request (83): virtio request kicked
> > > > >
> > > > > So I suspect we're just not getting a callback.
> > > >
> > > > I think so. The patch assumes the driver will call
> > > > virtqueue_disable/enable_cb() which is not the case of the 9p drive=
r.
> > > >
> > > > So after the first interrupt, event_triggered will be set to true f=
orever.
> > > >
> > > > Thanks
> > > >
> > >
> > > Hi: Wang
> > >
> > > Yes,  This patch assumes that all virtio-related drivers will call
> > > virtqueue_disable/enable_cb().
> > > Thank you for raising this issue.
> > >
> > > It seems that napi_tx is only related to virtue_net. I'm thinking if
> > > we need to refactor
> > > napi_tx instead of implementing it inside virtio_ring.
> >
> > We can hear from others.
> >
> > I think it's better not to workaround virtio_ring issues in a specific
> > driver. It might just add more hacks. We should correctly set
> > VRING_AVAIL_F_NO_INTERRUPT,
> >
> > Do you think the following might work (not even a compile test)?
>
>
> ok but:
>
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index 41144b5246a8..12f4efb6dc54 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -852,16 +852,16 @@ static void virtqueue_disable_cb_split(struct
> > virtqueue *_vq)
> >  {
> >         struct vring_virtqueue *vq =3D to_vvq(_vq);
> >
> > -       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT=
)) {
> > -               vq->split.avail_flags_shadow |=3D VRING_AVAIL_F_NO_INTE=
RRUPT;
> > -               if (vq->event)
> > -                       /* TODO: this is a hack. Figure out a cleaner
> > value to write. */
> > -                       vring_used_event(&vq->split.vring) =3D 0x0;
> > -               else
> > -                       vq->split.vring.avail->flags =3D
> > -                               cpu_to_virtio16(_vq->vdev,
> > -                                               vq->split.avail_flags_s=
hadow);
> > -       }
> > +       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT=
))
> > +               vq->split.avail_flags_shadow |=3D VRING_AVAIL_F_NO_INTE=
RRUPT;
> > +
> > +       if (vq->event && !vq->event_triggered)
> > +               /* TODO: this is a hack. Figure out a cleaner value to =
write. */
> > +               vring_used_event(&vq->split.vring) =3D 0x0;
> > +       else
> > +               vq->split.vring.avail->flags =3D
> > +                       cpu_to_virtio16(_vq->vdev,
> > +                                       vq->split.avail_flags_shadow);
> >  }
> >
> >  static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue=
 *_vq)
> > @@ -1697,8 +1697,10 @@ static void virtqueue_disable_cb_packed(struct
> > virtqueue *_vq)
> >  {
> >         struct vring_virtqueue *vq =3D to_vvq(_vq);
> >
> > -       if (vq->packed.event_flags_shadow !=3D VRING_PACKED_EVENT_FLAG_=
DISABLE) {
> > +       if (!(vq->packed.event_flags_shadow & VRING_PACKED_EVENT_FLAG_D=
ISABLE))
> >                 vq->packed.event_flags_shadow =3D VRING_PACKED_EVENT_FL=
AG_DISABLE;
> > +
> > +       if (vq->event_triggered)
>
> I don't get this one. if event_triggered why do you still want to
> write into driver flags? it won't trigger again anytime soon.

Should be a typo.

>
> >                 vq->packed.vring.driver->flags =3D
> >                         cpu_to_le16(vq->packed.event_flags_shadow);
> >         }
> > @@ -2330,12 +2332,6 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
> >  {
> >         struct vring_virtqueue *vq =3D to_vvq(_vq);
> >
> > -       /* If device triggered an event already it won't trigger one ag=
ain:
> > -        * no need to disable.
> > -        */
> > -       if (vq->event_triggered)
> > -               return;
> > -
> >         if (vq->packed_ring)
> >                 virtqueue_disable_cb_packed(_vq);
> >         else
> >
> > Thanks
>
> I think I prefer Huang Albert's other patch - are you ok with it?

Yes.

Thanks

>
> > >
> > > Thanks
> > >
> > > > >
> > > > >
> > > > > I'll have a closer look after work, but any advice meanwhile will=
 be
> > > > > appreciated!
> > > > > (I'm sure Luis would also like a temporary drop from -next until
> > > > > this is figured out, but I'll leave this up to you)
> > > > >
> > > > >
> > > > > >
> > > > > > If we disable the napi_tx, it will only be called when the tx r=
ing
> > > > > > buffer is relatively small.
> > > > > >
> > > > > > Because event_triggered is true. Therefore, VRING_AVAIL_F_NO_IN=
TERRUPT or
> > > > > > VRING_PACKED_EVENT_FLAG_DISABLE will not be set. So we update
> > > > > > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->=
off_wrap
> > > > > > every time we call virtqueue_get_buf_ctx. This will bring more =
interruptions.
> > > > > >
> > > > > > To summarize:
> > > > > > 1) event_triggered was set to true in vring_interrupt()
> > > > > > 2) after this nothing will happen for virtqueue_disable_cb() so
> > > > > >    VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
> > > > > > 3) virtqueue_get_buf_ctx_split() will still think the cb is ena=
bled
> > > > > >    then it tries to publish new event
> > > > > >
> > > > > > To fix, if event_triggered is set to true, do not update
> > > > > > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->=
off_wrap
> > > > > >
> > > > > > Tested with iperf:
> > > > > > iperf3 tcp stream:
> > > > > > vm1 -----------------> vm2
> > > > > > vm2 just receives tcp data stream from vm1, and sends the ack t=
o vm1,
> > > > > > there are many tx interrupts in vm2.
> > > > > > but without event_triggered there are just a few tx interrupts.
> > > > > >
> > > > > > Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> > > > > > Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> > > > > > Message-Id: <20230321085953.24949-1-huangjie.albert@bytedance.c=
om>
> > > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > > ---
> > > > > >  drivers/virtio/virtio_ring.c | 6 ++++--
> > > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virt=
io_ring.c
> > > > > > index cbeeea1b0439..1c36fa477966 100644
> > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > @@ -914,7 +914,8 @@ static void *virtqueue_get_buf_ctx_split(st=
ruct virtqueue *_vq,
> > > > > >       /* If we expect an interrupt for the next entry, tell hos=
t
> > > > > >        * by writing event index and flush out the write before
> > > > > >        * the read in the next get_buf call. */
> > > > > > -     if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INT=
ERRUPT))
> > > > > > +     if (unlikely(!(vq->split.avail_flags_shadow & VRING_AVAIL=
_F_NO_INTERRUPT) &&
> > > > > > +                  !vq->event_triggered))
> > > > > >               virtio_store_mb(vq->weak_barriers,
> > > > > >                               &vring_used_event(&vq->split.vrin=
g),
> > > > > >                               cpu_to_virtio16(_vq->vdev, vq->la=
st_used_idx));
> > > > > > @@ -1744,7 +1745,8 @@ static void *virtqueue_get_buf_ctx_packed=
(struct virtqueue *_vq,
> > > > > >        * by writing event index and flush out the write before
> > > > > >        * the read in the next get_buf call.
> > > > > >        */
> > > > > > -     if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED_EVE=
NT_FLAG_DESC)
> > > > > > +     if (unlikely(vq->packed.event_flags_shadow =3D=3D VRING_P=
ACKED_EVENT_FLAG_DESC &&
> > > > > > +                  !vq->event_triggered))
> > > > > >               virtio_store_mb(vq->weak_barriers,
> > > > > >                               &vq->packed.vring.driver->off_wra=
p,
> > > > > >                               cpu_to_le16(vq->last_used_idx));
> > > > >
> > > >
> > >
>

