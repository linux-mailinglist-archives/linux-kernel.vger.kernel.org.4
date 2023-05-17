Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6A9705C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 02:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjEQAvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 20:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEQAvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 20:51:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2B410DB
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 17:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684284644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fnUG3gCHSV8pX9AU0bIvLG+bCyI62wX6MiEqPgLszqc=;
        b=Cit6BjCuWxMSpfFW+zWRyrCuO3a4ZgCaNLjqr5EYAqUaYWqXA7XRetYQdDQe1FVUFuH5FT
        rIH3+drqIxVm0taexrHkn8gSBWaViITFLpjm6CM3l7yisGqaCrUgr+p8B6VNnZbsgO0M6o
        uQME4ZllSiY08mkG4Zdt5n0FxRx9L9k=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-ei8NbhmxPwy5EQq3PEVjtg-1; Tue, 16 May 2023 20:50:42 -0400
X-MC-Unique: ei8NbhmxPwy5EQq3PEVjtg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4f139de8c55so3987489e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 17:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684284641; x=1686876641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnUG3gCHSV8pX9AU0bIvLG+bCyI62wX6MiEqPgLszqc=;
        b=P6dm9K52Wq084Y39dpakQ4SVfFFyWa5xnAlgZaXXUME6n83ghdzItyGi8PGQEApvI3
         iWPq1PyO+La/Wkeov8prcoEShl2QA+cgPvjRp+Uvztf444MEG0Cj0nPBqHm3nIBO9zDI
         dW3IyzvpZy6uzGoIzP4GgJIvp1UQxrkWvwdNd9HYIeVIWiAJiTNU9Bgp3zlXzoATxQcZ
         ybr2aPE/c+Y/MuQPMRf8LwffCcsspjobFi1LDbwjAp89FzBhk9HyzM5/Q189JElwD1Ck
         BLDWZuiu4s4Hl7ZyE5q4X7WXGD2fRjsHrg+o9Lh3ie7YplxU9T6S2e/ChENScafQZPcs
         1qPg==
X-Gm-Message-State: AC+VfDwtpidekE1c4x1yjxmrFavLEztfNKpiZnx01PoFOxuz9NjJe/Qn
        rYGtrjutR5tiiLKk1MdAuzOWs49XBJ78z528gX3pimDzc8m8hCGonGEUdImEetsTgnOl0EJqvqt
        vgrzGrEgY9L2UsAMI80HBogTINGnVjg17ecJaDGEL
X-Received: by 2002:a05:6512:3c96:b0:4f0:ee3:848f with SMTP id h22-20020a0565123c9600b004f00ee3848fmr139130lfv.15.1684284640827;
        Tue, 16 May 2023 17:50:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5nvocPyqtz2w18jvJ0wQ4AoTYZDsKWUnk+PG33ZiW+Bm0B7nLwAw3MuqDn+seYoyIrrp7GFtqIyu0p+Uu+2hY=
X-Received: by 2002:a05:6512:3c96:b0:4f0:ee3:848f with SMTP id
 h22-20020a0565123c9600b004f00ee3848fmr139117lfv.15.1684284640530; Tue, 16 May
 2023 17:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230413064027.13267-1-jasowang@redhat.com> <20230413064027.13267-3-jasowang@redhat.com>
 <20230516165043-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230516165043-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 17 May 2023 08:50:29 +0800
Message-ID: <CACGkMEutCg7OkJQ7-fcfb0zO-cJS0RhtTPtSf+YGcn4m4ujtfg@mail.gmail.com>
Subject: Re: [PATCH net-next V2 2/2] virtio-net: sleep instead of busy waiting
 for cvq command
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com,
        alvaro.karsz@solid-run.com, eperezma@redhat.com,
        xuanzhuo@linux.alibaba.com, david.marchand@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 4:54=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Apr 13, 2023 at 02:40:27PM +0800, Jason Wang wrote:
> > We used to busy waiting on the cvq command this tends to be
> > problematic since there no way for to schedule another process which
> > may serve for the control virtqueue. This might be the case when the
> > control virtqueue is emulated by software. This patch switches to use
> > completion to allow the CPU to sleep instead of busy waiting for the
> > cvq command.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > Changes since V1:
> > - use completion for simplicity
> > - don't try to harden the CVQ command which requires more thought
> > Changes since RFC:
> > - break the device when timeout
> > - get buffer manually since the virtio core check more_used() instead
> > ---
> >  drivers/net/virtio_net.c | 21 ++++++++++++++-------
> >  1 file changed, 14 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 2e56bbf86894..d3eb8fd6c9dc 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/average.h>
> >  #include <linux/filter.h>
> >  #include <linux/kernel.h>
> > +#include <linux/completion.h>
> >  #include <net/route.h>
> >  #include <net/xdp.h>
> >  #include <net/net_failover.h>
> > @@ -295,6 +296,8 @@ struct virtnet_info {
> >
> >       /* failover when STANDBY feature enabled */
> >       struct failover *failover;
> > +
> > +     struct completion completion;
> >  };
> >
> >  struct padded_vnet_hdr {
> > @@ -1709,6 +1712,13 @@ static bool try_fill_recv(struct virtnet_info *v=
i, struct receive_queue *rq,
> >       return !oom;
> >  }
> >
> > +static void virtnet_cvq_done(struct virtqueue *cvq)
> > +{
> > +     struct virtnet_info *vi =3D cvq->vdev->priv;
> > +
> > +     complete(&vi->completion);
> > +}
> > +
> >  static void skb_recv_done(struct virtqueue *rvq)
> >  {
> >       struct virtnet_info *vi =3D rvq->vdev->priv;
> > @@ -2169,12 +2179,8 @@ static bool virtnet_send_command(struct virtnet_=
info *vi, u8 class, u8 cmd,
> >       if (unlikely(!virtqueue_kick(vi->cvq)))
> >               return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
> >
> > -     /* Spin for a response, the kick causes an ioport write, trapping
> > -      * into the hypervisor, so the request should be handled immediat=
ely.
> > -      */
> > -     while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > -            !virtqueue_is_broken(vi->cvq))
> > -             cpu_relax();
> > +     wait_for_completion(&vi->completion);
> > +     virtqueue_get_buf(vi->cvq, &tmp);
> >
> >       return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
>
> This seems to break surprise removal and other
> situations where vq gets broken since callbacks
> aren't usually invoked then.

Yes, so I think I can go back to the original idea by simply adding
cond_resched() here.

>
>
> >  }
> > @@ -3672,7 +3678,7 @@ static int virtnet_find_vqs(struct virtnet_info *=
vi)
> >
> >       /* Parameters for control virtqueue, if any */
> >       if (vi->has_cvq) {
> > -             callbacks[total_vqs - 1] =3D NULL;
> > +             callbacks[total_vqs - 1] =3D virtnet_cvq_done;
> >               names[total_vqs - 1] =3D "control";
> >       }
> >
>
> There is a cost to this, in that we are burning an extra MSI vector
> for the slow path cvq. if device has 3 vectors, suddenly we can't
> allocate vectors for rx and tx, big problem.
>
> So I'm afraid we need to pass a new flag that will share
> the config changed interrupt and cvq.

See above, it looks to me a simple cond_resched() is sufficient, then
we don't need a new vector.

Thanks

>
>
>
> > @@ -4122,6 +4128,7 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >       if (vi->has_rss || vi->has_rss_hash_report)
> >               virtnet_init_default_rss(vi);
> >
> > +     init_completion(&vi->completion);
> >       enable_rx_mode_work(vi);
> >
> >       /* serialize netdev register + virtio_device_ready() with ndo_ope=
n() */
> > --
> > 2.25.1
>

