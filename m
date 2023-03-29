Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43C76CD1AF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 07:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjC2Ffu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 01:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjC2Ffo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 01:35:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F2C35AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 22:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680068058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TKYnXvCYab97RG66lZ81YPSbP8j646tw3OvcwjSJJ4U=;
        b=DKiR7Ibh3wj8n6e/b/qIEsmQJfa2wLr5IYD4yA0OsYd1AajPG1bFlLQjPDKf4EPS8Q83M3
        7m+sPRlOdPefjRyouFiRLI4FToYTXvJbGJDXXlMFY3ZcYxkjDPKaGb8dE7JJBJSWY3foLI
        jf7jyrs8Mp4+0PHvVVEmr9wXikUoJAo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-IU8Bsm6XP7aIJUOkB0juIQ-1; Wed, 29 Mar 2023 01:34:16 -0400
X-MC-Unique: IU8Bsm6XP7aIJUOkB0juIQ-1
Received: by mail-wm1-f69.google.com with SMTP id z20-20020a05600c0a1400b003edcff41678so638695wmp.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 22:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680068056;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKYnXvCYab97RG66lZ81YPSbP8j646tw3OvcwjSJJ4U=;
        b=PpSEslEEVWHjLinfer/HlgOY/lHo13hLT2LzScGQz4HEGj1CZjhGtsPP4T/9CMttQD
         Qy637BjhoA3Uq6v90u+7qBgZJXC4bziInKMgUY6mXtnfUQ0DoKCL2eB6VmQjJGcIuStr
         UnLQ9odj20B9Mh31uNlc4qQsxgp9QkkbwlSlpNHq8QgFMc52wKUSi0fDW1LLMfTyguIq
         eYnBmjoiuCoaj1h0ZH7/nA037vz8Ag4Dg/EXU/Kq/NLxUAfAGbxYVrDDvjYdBf97tVWQ
         7/tLNqaVok7vIDt6y8eTgXTd6UVRd/TH+aR/tYRRGcGqpNU3/NuMV/AHN0kBqED8ih2s
         kq+g==
X-Gm-Message-State: AAQBX9cvUEKCZpr2g05AfFD0DUmV/fS8UwdEOnOPqQp0UnbADVea3dYM
        +y0etyCfXS1Du/heO3TQwvHHKK+kayiQkMdx+0yxU3GXVAVS3HArNT0yJF5wmO8Q1CzRBXy1ffz
        p4GVZz6oAlqNdj/i2rfixtjW/
X-Received: by 2002:a5d:570d:0:b0:2d8:1aff:813 with SMTP id a13-20020a5d570d000000b002d81aff0813mr13128447wrv.43.1680068055645;
        Tue, 28 Mar 2023 22:34:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZXpaB1zzOrJRIrcFRm8e9P+85wO5jiKmHj4ONTexa4CS8h/FuQoFUC20/bE8USu/IjPBFshA==
X-Received: by 2002:a5d:570d:0:b0:2d8:1aff:813 with SMTP id a13-20020a5d570d000000b002d81aff0813mr13128432wrv.43.1680068055292;
        Tue, 28 Mar 2023 22:34:15 -0700 (PDT)
Received: from redhat.com ([2.52.18.165])
        by smtp.gmail.com with ESMTPSA id j10-20020adff00a000000b002d1bfe3269esm29182858wro.59.2023.03.28.22.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 22:34:14 -0700 (PDT)
Date:   Wed, 29 Mar 2023 01:34:11 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     =?utf-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [External] Re: 9p regression (Was: [PATCH v2] virtio_ring: don't
 update event idx on get_buf)
Message-ID: <20230329012908-mutt-send-email-mst@kernel.org>
References: <20230325105633.58592-1-huangjie.albert@bytedance.com>
 <ZCJNTBQLZeyLBKKB@codewreck.org>
 <CACGkMEt29t9CK2Muiuyb1s6p2AzgcMiD_z0NVFn1d+KEqBydug@mail.gmail.com>
 <CABKxMyPwuRb6p-oHxcQDhRtJv04=NDWvosNAp=epgvdrfCeveg@mail.gmail.com>
 <CACGkMEuukvjXBTDX2K9YLYmpHsqK96AiMK39gbm3+f_+kUydMQ@mail.gmail.com>
 <CABKxMyN0598wA6wHv5GkZC14znwp=OPo7u71_BizJfR+gUx4_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABKxMyN0598wA6wHv5GkZC14znwp=OPo7u71_BizJfR+gUx4_w@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 05:09:19PM +0800, 黄杰 wrote:
> Jason Wang <jasowang@redhat.com> 于2023年3月28日周二 11:40写道：
> >
> > On Tue, Mar 28, 2023 at 11:09 AM 黄杰 <huangjie.albert@bytedance.com> wrote:
> > >
> > > Jason Wang <jasowang@redhat.com> 于2023年3月28日周二 10:59写道：
> > > >
> > > > On Tue, Mar 28, 2023 at 10:13 AM Dominique Martinet
> > > > <asmadeus@codewreck.org> wrote:
> > > > >
> > > > > Hi Michael, Albert,
> > > > >
> > > > > Albert Huang wrote on Sat, Mar 25, 2023 at 06:56:33PM +0800:
> > > > > > in virtio_net, if we disable the napi_tx, when we triger a tx interrupt,
> > > > > > the vq->event_triggered will be set to true. It will no longer be set to
> > > > > > false. Unless we explicitly call virtqueue_enable_cb_delayed or
> > > > > > virtqueue_enable_cb_prepare.
> > > > >
> > > > > This patch (commited as 35395770f803 ("virtio_ring: don't update event
> > > > > idx on get_buf") in next-20230327 apparently breaks 9p, as reported by
> > > > > Luis in https://lkml.kernel.org/r/ZCI+7Wg5OclSlE8c@bombadil.infradead.org
> > > > >
> > > > > I've just hit had a look at recent patches[1] and reverted this to test
> > > > > and I can mount again, so I'm pretty sure this is the culprit, but I
> > > > > didn't look at the content at all yet so cannot advise further.
> > > > > It might very well be that we need some extra handling for 9p
> > > > > specifically that can be added separately if required.
> > > > >
> > > > > [1] git log 0ec57cfa721fbd36b4c4c0d9ccc5d78a78f7fa35..HEAD drivers/virtio/
> > > > >
> > > > >
> > > > > This can be reproduced with a simple mount, run qemu with some -virtfs
> > > > > argument and `mount -t 9p -o debug=65535 tag mountpoint` will hang after
> > > > > these messages:
> > > > > 9pnet: -- p9_virtio_request (83): 9p debug: virtio request
> > > > > 9pnet: -- p9_virtio_request (83): virtio request kicked
> > > > >
> > > > > So I suspect we're just not getting a callback.
> > > >
> > > > I think so. The patch assumes the driver will call
> > > > virtqueue_disable/enable_cb() which is not the case of the 9p driver.
> > > >
> > > > So after the first interrupt, event_triggered will be set to true forever.
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
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 41144b5246a8..12f4efb6dc54 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -852,16 +852,16 @@ static void virtqueue_disable_cb_split(struct
> > virtqueue *_vq)
> >  {
> >         struct vring_virtqueue *vq = to_vvq(_vq);
> >
> > -       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
> > -               vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> > -               if (vq->event)
> > -                       /* TODO: this is a hack. Figure out a cleaner
> > value to write. */
> > -                       vring_used_event(&vq->split.vring) = 0x0;
> > -               else
> > -                       vq->split.vring.avail->flags =
> > -                               cpu_to_virtio16(_vq->vdev,
> > -                                               vq->split.avail_flags_shadow);
> > -       }
> > +       if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> > +               vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> > +
> > +       if (vq->event && !vq->event_triggered)
> > +               /* TODO: this is a hack. Figure out a cleaner value to write. */
> > +               vring_used_event(&vq->split.vring) = 0x0;
> > +       else
> > +               vq->split.vring.avail->flags =
> > +                       cpu_to_virtio16(_vq->vdev,
> > +                                       vq->split.avail_flags_shadow);
> >  }
> >
> >  static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
> > @@ -1697,8 +1697,10 @@ static void virtqueue_disable_cb_packed(struct
> > virtqueue *_vq)
> >  {
> >         struct vring_virtqueue *vq = to_vvq(_vq);
> >
> > -       if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE) {
> > +       if (!(vq->packed.event_flags_shadow & VRING_PACKED_EVENT_FLAG_DISABLE))
> >                 vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
> > +
> > +       if (vq->event_triggered)
> >                 vq->packed.vring.driver->flags =
> >                         cpu_to_le16(vq->packed.event_flags_shadow);
> >         }
> > @@ -2330,12 +2332,6 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
> >  {
> >         struct vring_virtqueue *vq = to_vvq(_vq);
> >
> > -       /* If device triggered an event already it won't trigger one again:
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
> >
> 
> Hi, This patch seems to address the issue I initially raised and also
> avoids the problem with virtio-9P.
> 
> but maybe this is a better choice:
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 307e139cb11d..6784d155c781 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -812,6 +812,10 @@ static void virtqueue_disable_cb_split(struct
> virtqueue *_vq)
> 
>         if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
>                 vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> +
> +               if (vq->event_triggered)
> +                       return;
> +
>                 if (vq->event)
>                         /* TODO: this is a hack. Figure out a cleaner
> value to write. */
>                         vring_used_event(&vq->split.vring) = 0x0;
> @@ -1546,6 +1550,10 @@ static void virtqueue_disable_cb_packed(struct
> virtqueue *_vq)
> 
>         if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE) {
>                 vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
> +
> +               if (vq->event_triggered)
> +                       return;
> +
>                 vq->packed.vring.driver->flags =
>                         cpu_to_le16(vq->packed.event_flags_shadow);
>         }
> @@ -2063,12 +2071,6 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
>  {
>         struct vring_virtqueue *vq = to_vvq(_vq);
> 
> -       /* If device triggered an event already it won't trigger one again:
> -        * no need to disable.
> -        */
> -       if (vq->event_triggered)
> -               return;
> -
>         if (vq->packed_ring)
>                 virtqueue_disable_cb_packed(_vq);
>         else
> 
> Does Michael have any other suggestions?
> 
> Thanks.

Oh I finally understand I think. The issue is with event index
enabled. interrupt fires once, we set event index to 0x0.
since shadow is not set then we never update it again.

I agree, your patch is a good fix, just please copy the comment
you are removing to the two places where we check event_triggered now.
I dropped patch v2 from my tree and please post v3
with this fixup squashed.

Thanks a lot!



Apropos if we fixed all drivers to call disable/enable_cb
explicitly we could remove branch on data path, but it's a lot of work
and it's easy to miss some drivers.



> > >
> > > Thanks
> > >
> > > > >
> > > > >
> > > > > I'll have a closer look after work, but any advice meanwhile will be
> > > > > appreciated!
> > > > > (I'm sure Luis would also like a temporary drop from -next until
> > > > > this is figured out, but I'll leave this up to you)
> > > > >
> > > > >
> > > > > >
> > > > > > If we disable the napi_tx, it will only be called when the tx ring
> > > > > > buffer is relatively small.
> > > > > >
> > > > > > Because event_triggered is true. Therefore, VRING_AVAIL_F_NO_INTERRUPT or
> > > > > > VRING_PACKED_EVENT_FLAG_DISABLE will not be set. So we update
> > > > > > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> > > > > > every time we call virtqueue_get_buf_ctx. This will bring more interruptions.
> > > > > >
> > > > > > To summarize:
> > > > > > 1) event_triggered was set to true in vring_interrupt()
> > > > > > 2) after this nothing will happen for virtqueue_disable_cb() so
> > > > > >    VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
> > > > > > 3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
> > > > > >    then it tries to publish new event
> > > > > >
> > > > > > To fix, if event_triggered is set to true, do not update
> > > > > > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> > > > > >
> > > > > > Tested with iperf:
> > > > > > iperf3 tcp stream:
> > > > > > vm1 -----------------> vm2
> > > > > > vm2 just receives tcp data stream from vm1, and sends the ack to vm1,
> > > > > > there are many tx interrupts in vm2.
> > > > > > but without event_triggered there are just a few tx interrupts.
> > > > > >
> > > > > > Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> > > > > > Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> > > > > > Message-Id: <20230321085953.24949-1-huangjie.albert@bytedance.com>
> > > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > > ---
> > > > > >  drivers/virtio/virtio_ring.c | 6 ++++--
> > > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > index cbeeea1b0439..1c36fa477966 100644
> > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > @@ -914,7 +914,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> > > > > >       /* If we expect an interrupt for the next entry, tell host
> > > > > >        * by writing event index and flush out the write before
> > > > > >        * the read in the next get_buf call. */
> > > > > > -     if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> > > > > > +     if (unlikely(!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) &&
> > > > > > +                  !vq->event_triggered))
> > > > > >               virtio_store_mb(vq->weak_barriers,
> > > > > >                               &vring_used_event(&vq->split.vring),
> > > > > >                               cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
> > > > > > @@ -1744,7 +1745,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> > > > > >        * by writing event index and flush out the write before
> > > > > >        * the read in the next get_buf call.
> > > > > >        */
> > > > > > -     if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
> > > > > > +     if (unlikely(vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC &&
> > > > > > +                  !vq->event_triggered))
> > > > > >               virtio_store_mb(vq->weak_barriers,
> > > > > >                               &vq->packed.vring.driver->off_wrap,
> > > > > >                               cpu_to_le16(vq->last_used_idx));
> > > > >
> > > >
> > >
> >

