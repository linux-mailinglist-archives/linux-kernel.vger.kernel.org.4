Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB70A6E1B80
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 07:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjDNFLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 01:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDNFLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:11:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21395524B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 22:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681448988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2rvMN6BRDbvRwSL10kciJszDIBa0dJCTVfq84Gv1b+Y=;
        b=hAWnbmFQACwj5bLRTmTJFdKUZByG45pDGL+C9SGp4LSeVM7s0Mf+GvxeJckypGL6vgYZWH
        myPy9yImJDxgXXdQpJwJn5QPEM7Guq41fnlwjFOMRTxUNxnhfSeSIb5lorEAnooIuv9Dav
        ZrIjoFtMwQC8ungRo5bmEnOZcJnmigg=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-118dsyg5NZKVZBABG8xzuw-1; Fri, 14 Apr 2023 01:09:47 -0400
X-MC-Unique: 118dsyg5NZKVZBABG8xzuw-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-187aef83ec8so537564fac.18
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 22:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681448987; x=1684040987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rvMN6BRDbvRwSL10kciJszDIBa0dJCTVfq84Gv1b+Y=;
        b=i8Zlxv4laasHvcZGUXNFvoUUKGJdvc8Y9+0jLmEYPI31zidlcatRKvfpM3pgWV0zcD
         VX8MEhBfkejdSz1rkTgQkE7HvyV6wD6PKV3vqCAhAfDx1UIlhYrZhYx+DI5xgdmdb9PF
         +9Vi9RXFgJQzOOVIamCOwQlGm+GZ5K9IK/jz7SpmuMBIe2wz/MBbTIitsvgtCWVEI7Ul
         TM1Ls7+MHhyTFV37XpgYKEkmavYWpWvP7G96+I0WSMWuU3zkKYYe5qmJED6Rxo+jBLAY
         JG+uALpNg0HTuXMHRh9boDvjw10pEGFPP2+hf7S/pxRlHgJ+AVDmvbeqYdRMWAgrJssu
         Js2A==
X-Gm-Message-State: AAQBX9dR1ZfMLcLHsOI5lb0dzWNbEWHh4wWQQmZ4bZJgjw2RuyASOKaC
        USVDBG5GCNdbyItrfI3Ed+k3M+cR5QkmKJxlAZEjiLRWaJAEiO4JfjgrnPYgcpPgznYmp4EeE2o
        dt+SqXEkgKYbWoOFDDF9GQ8QtPmRNVlmm+GxPdRMT
X-Received: by 2002:a05:6870:a115:b0:184:502f:e79d with SMTP id m21-20020a056870a11500b00184502fe79dmr2049624oae.9.1681448986792;
        Thu, 13 Apr 2023 22:09:46 -0700 (PDT)
X-Google-Smtp-Source: AKy350bsd7OBzzvfzTFbs2fVYsp7BQ1rLlRd8PA6YT7r6rA0syTXkc5b9ZbxhDpwEtYcJXENL6V+LGjZ2FFaZUTAIV4=
X-Received: by 2002:a05:6870:a115:b0:184:502f:e79d with SMTP id
 m21-20020a056870a11500b00184502fe79dmr2049615oae.9.1681448986551; Thu, 13 Apr
 2023 22:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230413064027.13267-1-jasowang@redhat.com> <20230413064027.13267-3-jasowang@redhat.com>
 <1681370820.0675354-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1681370820.0675354-2-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 14 Apr 2023 13:09:35 +0800
Message-ID: <CACGkMEuJuZKGMhVwFmD0ZMa7V7TdGu6qaXF24Gg67TzMbs8ANA@mail.gmail.com>
Subject: Re: [PATCH net-next V2 2/2] virtio-net: sleep instead of busy waiting
 for cvq command
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com,
        alvaro.karsz@solid-run.com, eperezma@redhat.com,
        david.marchand@redhat.com, mst@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 3:31=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 13 Apr 2023 14:40:27 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
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
> >  }
> > @@ -3672,7 +3678,7 @@ static int virtnet_find_vqs(struct virtnet_info *=
vi)
> >
> >       /* Parameters for control virtqueue, if any */
> >       if (vi->has_cvq) {
> > -             callbacks[total_vqs - 1] =3D NULL;
> > +             callbacks[total_vqs - 1] =3D virtnet_cvq_done;
>
> This depends the interrupt, right?

Not necessarily, we have ISR for at last PCI:

static irqreturn_t vp_interrupt(int irq, void *opaque)
{
        struct virtio_pci_device *vp_dev =3D opaque;
        u8 isr;

        /* reading the ISR has the effect of also clearing it so it's very
         * important to save off the value. */
        isr =3D ioread8(vp_dev->isr);
...
}

>
> I worry that there may be some devices that may not support interruption =
on cvq.

Is the device using INTX or MSI-X?

> Although this may not be in line with SPEC, it may cause problem on the d=
evices
> that can work normally at present.

Then the implementation is buggy, it might not work for drivers other
than Linux. Working around such buggy implementation is suboptimal.

Thanks

>
> Thanks.
>
>
> >               names[total_vqs - 1] =3D "control";
> >       }
> >
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
> >
>

