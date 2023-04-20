Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FF66E8922
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 06:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjDTEfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 00:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjDTEfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 00:35:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9784F40CD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 21:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681965260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06+jY2WKqPo86RHuMKHK8QGzTcFzztaHII/d8uwl6SA=;
        b=dHzkENLv9gtb2tQlO2jORZA3qZ+Uz1/+csTAgko8ee5jYGbi0J4E0D4IxaPit1wAwaU+di
        LFh5gcvopUEX1wvqT1adNhpIaov4B6lbte+U8OLDxHYhRvKOD4mviH95MYvDzPi43Cuy9N
        4bM26vkDBpBTPaUTxYTJfwlgxxEDcOc=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-inaA6FP1P9StagCzqHzwhQ-1; Thu, 20 Apr 2023 00:34:19 -0400
X-MC-Unique: inaA6FP1P9StagCzqHzwhQ-1
Received: by mail-oo1-f70.google.com with SMTP id x145-20020a4a4197000000b005461097c99eso42036ooa.17
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 21:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681965258; x=1684557258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06+jY2WKqPo86RHuMKHK8QGzTcFzztaHII/d8uwl6SA=;
        b=FA4SzGxMnePjvXrk189kGawcAODspRIcXF3pgSXhH5iZ3NfWdtjfEHPE1zmR15TjSM
         7IzhucMFur5moy7Bhamq6u2zy2TAiqFawq1b7vIspiE0RATQ2XRYJm2KKbDWoo3iHNrA
         YmIkM7f8r0mZtJJzkAcLRCnzMjoUw04pdpD1eDvpoBZeZafiwbnjtTNNyuW9Zn1saT3t
         NkCRGW/i+nxF0JrE5piGw1Sqd92sOKdEPIgCfhd8nuPC4azJBW7dS3iec8YTxpG7Fhab
         Kx3zP89V9WhktwbYo61NgPksLjKSXfxED9zlRx6LRysE16H3/wnZUX6YjlYAgM2IyBZq
         NWzg==
X-Gm-Message-State: AAQBX9cZfIxL0tk/AtrCwDoPV5AikbqBLh3ev7eNxXjgjhijKB+Y8ZA3
        3SAXcfE/YxGS5nIRtyfwwUYGIp/VruYHOB7jTrxWjg4g/Gmrnr8LjC8FCLOvaD5w0ih0Kn3V4Vj
        eozEedM5X6EHLsWH8kp3NIyzzNIdZa/EK6fItUaLd
X-Received: by 2002:a4a:528c:0:b0:546:645b:7f61 with SMTP id d134-20020a4a528c000000b00546645b7f61mr300311oob.4.1681965258338;
        Wed, 19 Apr 2023 21:34:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350YD284CqNILld+XSMSEBz3nzQ4d3US7QOWy0beso8yjDxZePaEXv/7wU5hBQK4fMwng5DxENIegnx4pWyrKcrI=
X-Received: by 2002:a4a:528c:0:b0:546:645b:7f61 with SMTP id
 d134-20020a4a528c000000b00546645b7f61mr300300oob.4.1681965258041; Wed, 19 Apr
 2023 21:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230419134329.346825-1-maxime.coquelin@redhat.com>
In-Reply-To: <20230419134329.346825-1-maxime.coquelin@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 20 Apr 2023 12:34:06 +0800
Message-ID: <CACGkMEuiHqPkqYk1ZG3RZXLjm+EM3bmR0v1T1yH-ADEazOwTMA@mail.gmail.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 9:43=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This small series enables virtio-net device type in VDUSE.
> With it, basic operation have been tested, both with
> virtio-vdpa and vhost-vdpa using DPDK Vhost library series
> adding VDUSE support [0] using split rings layout.
>
> Control queue support (and so multiqueue) has also been
> tested, but require a Kernel series from Jason Wang
> relaxing control queue polling [1] to function reliably.
>
> Other than that, we have identified a few gaps:
>
> 1. Reconnection:
>  a. VDUSE_VQ_GET_INFO ioctl() returns always 0 for avail
>     index, even after the virtqueue has already been
>     processed. Is that expected? I have tried instead to
>     get the driver's avail index directly from the avail
>     ring, but it does not seem reliable as I sometimes get
>     "id %u is not a head!\n" warnings. Also such solution
>     would not be possible with packed ring, as we need to
>     know the wrap counters values.

Looking at the codes, it only returns the value that is set via
set_vq_state(). I think it is expected to be called before the
datapath runs.

So when bound to virtio-vdpa, it is expected to return 0. But we need
to fix the packed virtqueue case, I wonder if we need to call
set_vq_state() explicitly in virtio-vdpa before starting the device.

When bound to vhost-vdpa, Qemu will call VHOST_SET_VRING_BASE which
will end up a call to set_vq_state(). Unfortunately, it doesn't
support packed ring which needs some extension.

>
>  b. Missing IOCTLs: it would be handy to have new IOCTLs to
>     query Virtio device status,

What's the use case of this ioctl? It looks to me userspace is
notified on each status change now:

static int vduse_dev_set_status(struct vduse_dev *dev, u8 status)
{
        struct vduse_dev_msg msg =3D { 0 };

        msg.req.type =3D VDUSE_SET_STATUS;
        msg.req.s.status =3D status;

        return vduse_dev_msg_sync(dev, &msg);
}

> and retrieve the config
>     space set at VDUSE_CREATE_DEV time.

In order to be safe, VDUSE avoids writable config space. Otherwise
drivers could block on config writing forever. That's why we don't do
it now.

We need to harden the config write before we can proceed to this I think.

>
> 2. VDUSE application as non-root:
>   We need to run the VDUSE application as non-root. There
>   is some race between the time the UDEV rule is applied
>   and the time the device starts being used. Discussing
>   with Jason, he suggested we may have a VDUSE daemon run
>   as root that would create the VDUSE device, manages its
>   rights and then pass its file descriptor to the VDUSE
>   app. However, with current IOCTLs, it means the VDUSE
>   daemon would need to know several information that
>   belongs to the VDUSE app implementing the device such
>   as supported Virtio features, config space, etc...
>   If we go that route, maybe we should have a control
>   IOCTL to create the device which would just pass the
>   device type. Then another device IOCTL to perform the
>   initialization. Would that make sense?

I think so. We can hear from others.

>
> 3. Coredump:
>   In order to be able to perform post-mortem analysis, DPDK
>   Vhost library marks pages used for vrings and descriptors
>   buffers as MADV_DODUMP using madvise(). However with
>   VDUSE it fails with -EINVAL. My understanding is that we
>   set VM_DONTEXPAND flag to the VMAs and madvise's
>   MADV_DODUMP fails if it is present. I'm not sure to
>   understand why madvise would prevent MADV_DODUMP if
>   VM_DONTEXPAND is set. Any thoughts?

Adding Peter who may know the answer.

Thanks

>
> [0]: https://patchwork.dpdk.org/project/dpdk/list/?series=3D27594&state=
=3D%2A&archive=3Dboth
> [1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0WvjG=
Rr3whU+QasUg@mail.gmail.com/T/
>
> Maxime Coquelin (2):
>   vduse: validate block features only with block devices
>   vduse: enable Virtio-net device type
>
>  drivers/vdpa/vdpa_user/vduse_dev.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> --
> 2.39.2
>

