Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB42C6EA35C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 07:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjDUFwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 01:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbjDUFwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 01:52:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3001BF3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 22:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682056315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5I7evANVAfJwuk/ANSR7cqv4R/exMlo0YUcDm4ZAsZk=;
        b=UtxCWy8koms1qCGcMDK9fq4UEboxvZwC4G+44dKwwH8HP9mjQmvj0O3OBdbvhHzmy6QCBv
        QztgHpLY532/EggarORuBZly/Me9hxOImipg8hBYUFHp11Dxh2TsFOeKvf0F6yWVx+nTSa
        tC6pLmGKCrG+rQ2AXTupP/NFQU+kVmw=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-1ZYTnbiIPByVyxnr6-gRhg-1; Fri, 21 Apr 2023 01:51:53 -0400
X-MC-Unique: 1ZYTnbiIPByVyxnr6-gRhg-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-38bedafc58dso591253b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 22:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682056313; x=1684648313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5I7evANVAfJwuk/ANSR7cqv4R/exMlo0YUcDm4ZAsZk=;
        b=fw7jnSKbZurRplW+FYAqtNg4T5fiwg8APlEt403whaf2mi23dWW0AqKCoX5pqnByeG
         40KB8iO0BBntFYRO360IamUC+SNJ2kHXOkcwbosBHyUTsh1UhLXVleXSEc3vuam0S+53
         R1z7M1xnSKGtfJVg5zSDlgJg+1da9bef+PWZKZ3wNeTjnywmIEoZjd+MYhWdEnzNmZSV
         OF8LukSd3RcaW8CUM7MtvB/Wv2ri/trlMDstcJXN5NnerNsxG6c4QPunQyvqC0OFa0/h
         7JutvCoR7TsMvoPvlk3Rkzx4QqDINtJ/PcpZJGyU8YZ9JXY9ca0owo7Bs4zVPZmHzGvu
         GvrQ==
X-Gm-Message-State: AAQBX9fm/ecT6zgMFfWPkDruWzs7gtZ5g0Q0x8NcDhConzv/9EF16E0H
        Pu5T8gBBjhFEClWKMdRMQB8VfZJKpZp0M4wxCxZCr3NQu2vur3jZj0kTNHqratBgdLBgNg60qB/
        q48ntXJqZFAiyfS1asPSTam4IiDwb4D26L92l2XnG
X-Received: by 2002:a05:6808:16ab:b0:38c:17a7:5b7b with SMTP id bb43-20020a05680816ab00b0038c17a75b7bmr2056929oib.19.1682056313004;
        Thu, 20 Apr 2023 22:51:53 -0700 (PDT)
X-Google-Smtp-Source: AKy350bchGp1g3M4Oxp2OMGsAtahE5jQNn822SVg525TzI2VQbnv6N9KJLpXdXFbYWo5pLOIS/diFH+MGlS5GPILS4Q=
X-Received: by 2002:a05:6808:16ab:b0:38c:17a7:5b7b with SMTP id
 bb43-20020a05680816ab00b0038c17a75b7bmr2056923oib.19.1682056312733; Thu, 20
 Apr 2023 22:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230419134329.346825-1-maxime.coquelin@redhat.com>
 <CACGkMEuiHqPkqYk1ZG3RZXLjm+EM3bmR0v1T1yH-ADEazOwTMA@mail.gmail.com> <d7530c13-f1a1-311e-7d5e-8e65f3bc2e50@redhat.com>
In-Reply-To: <d7530c13-f1a1-311e-7d5e-8e65f3bc2e50@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 21 Apr 2023 13:51:41 +0800
Message-ID: <CACGkMEuWpHokhwvJ5cF41_C=ezqFhoOyUOposdZ5+==A642OmQ@mail.gmail.com>
Subject: Re: [RFC 0/2] vduse: add support for networking devices
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     xieyongji@bytedance.com, mst@redhat.com, david.marchand@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 10:16=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
>
>
> On 4/20/23 06:34, Jason Wang wrote:
> > On Wed, Apr 19, 2023 at 9:43=E2=80=AFPM Maxime Coquelin
> > <maxime.coquelin@redhat.com> wrote:
> >>
> >> This small series enables virtio-net device type in VDUSE.
> >> With it, basic operation have been tested, both with
> >> virtio-vdpa and vhost-vdpa using DPDK Vhost library series
> >> adding VDUSE support [0] using split rings layout.
> >>
> >> Control queue support (and so multiqueue) has also been
> >> tested, but require a Kernel series from Jason Wang
> >> relaxing control queue polling [1] to function reliably.
> >>
> >> Other than that, we have identified a few gaps:
> >>
> >> 1. Reconnection:
> >>   a. VDUSE_VQ_GET_INFO ioctl() returns always 0 for avail
> >>      index, even after the virtqueue has already been
> >>      processed. Is that expected? I have tried instead to
> >>      get the driver's avail index directly from the avail
> >>      ring, but it does not seem reliable as I sometimes get
> >>      "id %u is not a head!\n" warnings. Also such solution
> >>      would not be possible with packed ring, as we need to
> >>      know the wrap counters values.
> >
> > Looking at the codes, it only returns the value that is set via
> > set_vq_state(). I think it is expected to be called before the
> > datapath runs.
> >
> > So when bound to virtio-vdpa, it is expected to return 0. But we need
> > to fix the packed virtqueue case, I wonder if we need to call
> > set_vq_state() explicitly in virtio-vdpa before starting the device.
> >
> > When bound to vhost-vdpa, Qemu will call VHOST_SET_VRING_BASE which
> > will end up a call to set_vq_state(). Unfortunately, it doesn't
> > support packed ring which needs some extension.
> >
> >>
> >>   b. Missing IOCTLs: it would be handy to have new IOCTLs to
> >>      query Virtio device status,
> >
> > What's the use case of this ioctl? It looks to me userspace is
> > notified on each status change now:
> >
> > static int vduse_dev_set_status(struct vduse_dev *dev, u8 status)
> > {
> >          struct vduse_dev_msg msg =3D { 0 };
> >
> >          msg.req.type =3D VDUSE_SET_STATUS;
> >          msg.req.s.status =3D status;
> >
> >          return vduse_dev_msg_sync(dev, &msg);
> > }
>
> The idea was to be able to query the status at reconnect time, and
> neither having to assume its value nor having to store its value in a
> file (the status could change while the VDUSE application is stopped,
> but maybe it would receive the notification at reconnect).

I see.

>
> I will prototype using a tmpfs file to save needed information, and see
> if it works.

It might work but then the API is not self contained. Maybe it's
better to have a dedicated ioctl.

>
> >> and retrieve the config
> >>      space set at VDUSE_CREATE_DEV time.
> >
> > In order to be safe, VDUSE avoids writable config space. Otherwise
> > drivers could block on config writing forever. That's why we don't do
> > it now.
>
> The idea was not to make the config space writable, but just to be able
> to fetch what was filled at VDUSE_CREATE_DEV time.
>
> With the tmpfs file, we can avoid doing that and just save the config
> space there.

Same as the case for status.

Thanks

>
> > We need to harden the config write before we can proceed to this I thin=
k.
> >
> >>
> >> 2. VDUSE application as non-root:
> >>    We need to run the VDUSE application as non-root. There
> >>    is some race between the time the UDEV rule is applied
> >>    and the time the device starts being used. Discussing
> >>    with Jason, he suggested we may have a VDUSE daemon run
> >>    as root that would create the VDUSE device, manages its
> >>    rights and then pass its file descriptor to the VDUSE
> >>    app. However, with current IOCTLs, it means the VDUSE
> >>    daemon would need to know several information that
> >>    belongs to the VDUSE app implementing the device such
> >>    as supported Virtio features, config space, etc...
> >>    If we go that route, maybe we should have a control
> >>    IOCTL to create the device which would just pass the
> >>    device type. Then another device IOCTL to perform the
> >>    initialization. Would that make sense?
> >
> > I think so. We can hear from others.
> >
> >>
> >> 3. Coredump:
> >>    In order to be able to perform post-mortem analysis, DPDK
> >>    Vhost library marks pages used for vrings and descriptors
> >>    buffers as MADV_DODUMP using madvise(). However with
> >>    VDUSE it fails with -EINVAL. My understanding is that we
> >>    set VM_DONTEXPAND flag to the VMAs and madvise's
> >>    MADV_DODUMP fails if it is present. I'm not sure to
> >>    understand why madvise would prevent MADV_DODUMP if
> >>    VM_DONTEXPAND is set. Any thoughts?
> >
> > Adding Peter who may know the answer.
>
> Thanks!
> Maxime
>
> > Thanks
> >
> >>
> >> [0]: https://patchwork.dpdk.org/project/dpdk/list/?series=3D27594&stat=
e=3D%2A&archive=3Dboth
> >> [1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0W=
vjGRr3whU+QasUg@mail.gmail.com/T/
> >>
> >> Maxime Coquelin (2):
> >>    vduse: validate block features only with block devices
> >>    vduse: enable Virtio-net device type
> >>
> >>   drivers/vdpa/vdpa_user/vduse_dev.c | 11 +++++++----
> >>   1 file changed, 7 insertions(+), 4 deletions(-)
> >>
> >> --
> >> 2.39.2
> >>
> >
>

