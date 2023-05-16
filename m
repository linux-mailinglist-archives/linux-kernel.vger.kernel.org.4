Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A62B704392
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 04:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjEPCp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 22:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjEPCps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 22:45:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC02E79
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 19:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684205101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XOtiAl8xEr+yF4q9V8Mv37+Ez0ZSu8GNo6YwcqTW6us=;
        b=Gw9Zi2/3+NGj81lys1lZQI6w8XKhBOYypG+G9p1LvgjNMQgYsBW2zXp7gmSPPD0r6qmUn+
        fQtfZw8Ct+oeID3aP8rX2jd5mEyDksdEHuXQRh/4d43BrGcJBAXaOhrXf5+vgRrkT4qsx0
        VSu4QhKgXwx/FLrBb0+6svG8IUEm2b4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-z3cGHSxmPn6qY1jIksCalQ-1; Mon, 15 May 2023 22:44:58 -0400
X-MC-Unique: z3cGHSxmPn6qY1jIksCalQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4edc5526c5fso7701910e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 19:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684205097; x=1686797097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOtiAl8xEr+yF4q9V8Mv37+Ez0ZSu8GNo6YwcqTW6us=;
        b=EwAK9jIvVVGfwqVjOy4zupspt6UoYBAo++3Eq2qfHeneH7oTy9/VUdliFY24kv7Ik/
         7uzH8texNzRiR4tARzxtjdh6ZXv9z9R7bUQgjIVLFJoFcFO45u0B1XLESYlvc/40fWdm
         saUPnraZF7y8Be96o5NZJnJISDZyIC7wkCLXPiuODHLW4Kjuq7hBQzVuWcZZXjDKiQX1
         xWEbMYk0mx5R6iKN2g1lib6RnQAJ4HTncpMxQyzuJwmK/Lh5DNIxV1FmqtPf7vNTdAP3
         ra1XUbmPnzYMPSjm/vyoCMwLd4N3L6oiH9DMySxoVeYZB5GT3AMejuVl5GyEL9KDponX
         sA8Q==
X-Gm-Message-State: AC+VfDwCnY/L2kd47gt8RUE3wj1BIZJ02+fxl/2ACf6QpP+A2fX2BKCM
        JitNvJeWh2vyaJC+Iawu2rCWMukMG4k7y+sdECbG0ZwnIce6UJp8wAM0FfeZ1bg4YUhzJ5j3B2H
        SBdiAlzDn2fNd+ja4hhrhfXEwIAapTsOj0x6iZVpv
X-Received: by 2002:a05:6512:4ce:b0:4f1:4d8c:1d21 with SMTP id w14-20020a05651204ce00b004f14d8c1d21mr7882543lfq.61.1684205096828;
        Mon, 15 May 2023 19:44:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6SX3NNInS5JM11CnSdd/RQUe4EjlvNV3aF41mBtFpvesjIsE4L2Uy2YEav+fOPTOaHB91hUPwXs99PQU4gbws=
X-Received: by 2002:a05:6512:4ce:b0:4f1:4d8c:1d21 with SMTP id
 w14-20020a05651204ce00b004f14d8c1d21mr7882521lfq.61.1684205096498; Mon, 15
 May 2023 19:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230413064027.13267-1-jasowang@redhat.com> <20230413064027.13267-2-jasowang@redhat.com>
 <20230413121525-mutt-send-email-mst@kernel.org> <CACGkMEunn1Z3n8yjVaWLqdV502yjaCBSAb_LO4KsB0nuxXmV8A@mail.gmail.com>
 <20230414031947-mutt-send-email-mst@kernel.org> <CACGkMEtutGn0CoJhoPHbzPuqoCLb4OCT6a_vB_WPV=MhwY0DXg@mail.gmail.com>
 <20230510012951-mutt-send-email-mst@kernel.org> <CACGkMEszPydzw_MOUOVJKBBW_8iYn66i_9OFvLDoZMH34hMx=w@mail.gmail.com>
 <20230515004422-mutt-send-email-mst@kernel.org> <CACGkMEv+Q2UoBarNOzKSrc3O=Wb2_73O2j9cZXFdAiLBm1qY-Q@mail.gmail.com>
 <20230515061455-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230515061455-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 16 May 2023 10:44:45 +0800
Message-ID: <CACGkMEt8QkK1PnTrRUjDbyJheBurdibr4--Es8P0Y9NZM659pQ@mail.gmail.com>
Subject: Re: [PATCH net-next V2 1/2] virtio-net: convert rx mode setting to
 use workqueue
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com,
        alvaro.karsz@solid-run.com, eperezma@redhat.com,
        xuanzhuo@linux.alibaba.com, david.marchand@redhat.com,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 6:17=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, May 15, 2023 at 01:13:33PM +0800, Jason Wang wrote:
> > On Mon, May 15, 2023 at 12:45=E2=80=AFPM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Mon, May 15, 2023 at 09:05:54AM +0800, Jason Wang wrote:
> > > > On Wed, May 10, 2023 at 1:33=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Mon, Apr 17, 2023 at 11:40:58AM +0800, Jason Wang wrote:
> > > > > > On Fri, Apr 14, 2023 at 3:21=E2=80=AFPM Michael S. Tsirkin <mst=
@redhat.com> wrote:
> > > > > > >
> > > > > > > On Fri, Apr 14, 2023 at 01:04:15PM +0800, Jason Wang wrote:
> > > > > > > > Forget to cc netdev, adding.
> > > > > > > >
> > > > > > > > On Fri, Apr 14, 2023 at 12:25=E2=80=AFAM Michael S. Tsirkin=
 <mst@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Apr 13, 2023 at 02:40:26PM +0800, Jason Wang wrot=
e:
> > > > > > > > > > This patch convert rx mode setting to be done in a work=
queue, this is
> > > > > > > > > > a must for allow to sleep when waiting for the cvq comm=
and to
> > > > > > > > > > response since current code is executed under addr spin=
 lock.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > >
> > > > > > > > > I don't like this frankly. This means that setting RX mod=
e which would
> > > > > > > > > previously be reliable, now becomes unreliable.
> > > > > > > >
> > > > > > > > It is "unreliable" by design:
> > > > > > > >
> > > > > > > >       void                    (*ndo_set_rx_mode)(struct net=
_device *dev);
> > > > > > > >
> > > > > > > > > - first of all configuration is no longer immediate
> > > > > > > >
> > > > > > > > Is immediate a hard requirement? I can see a workqueue is u=
sed at least:
> > > > > > > >
> > > > > > > > mlx5e, ipoib, efx, ...
> > > > > > > >
> > > > > > > > >   and there is no way for driver to find out when
> > > > > > > > >   it actually took effect
> > > > > > > >
> > > > > > > > But we know rx mode is best effort e.g it doesn't support v=
host and we
> > > > > > > > survive from this for years.
> > > > > > > >
> > > > > > > > > - second, if device fails command, this is also not
> > > > > > > > >   propagated to driver, again no way for driver to find o=
ut
> > > > > > > > >
> > > > > > > > > VDUSE needs to be fixed to do tricks to fix this
> > > > > > > > > without breaking normal drivers.
> > > > > > > >
> > > > > > > > It's not specific to VDUSE. For example, when using virtio-=
net in the
> > > > > > > > UP environment with any software cvq (like mlx5 via vDPA or=
 cma
> > > > > > > > transport).
> > > > > > > >
> > > > > > > > Thanks
> > > > > > >
> > > > > > > Hmm. Can we differentiate between these use-cases?
> > > > > >
> > > > > > It doesn't look easy since we are drivers for virtio bus. Under=
layer
> > > > > > details were hidden from virtio-net.
> > > > > >
> > > > > > Or do you have any ideas on this?
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > I don't know, pass some kind of flag in struct virtqueue?
> > > > >         "bool slow; /* This vq can be very slow sometimes. Don't =
wait for it! */"
> > > > >
> > > > > ?
> > > > >
> > > >
> > > > So if it's slow, sleep, otherwise poll?
> > > >
> > > > I feel setting this flag might be tricky, since the driver doesn't
> > > > know whether or not it's really slow. E.g smartNIC vendor may allow
> > > > virtio-net emulation over PCI.
> > > >
> > > > Thanks
> > >
> > > driver will have the choice, depending on whether
> > > vq is deterministic or not.
> >
> > Ok, but the problem is, such booleans are only useful for virtio ring
> > codes. But in this case, virtio-net knows what to do for cvq. So I'm
> > not sure who the user is.
> >
> > Thanks
>
> Circling back, what exactly does the architecture you are trying
> to fix look like? Who is going to introduce unbounded latency?
> The hypervisor?

Hypervisor is one of the possible reason, we have many more:

Hardware device that provides virtio-pci emulation.
Userspace devices like VDUSE.

> If so do we not maybe want a new feature bit
> that documents this? Hypervisor then can detect old guests
> that spin and decide what to do, e.g. prioritise cvq more,
> or fail FEATURES_OK.

We suffer from this for bare metal as well.

But a question is what's wrong with the approach that is used in this
patch? I've answered that set_rx_mode is not reliable, so it should be
fine to use workqueue. Except for this, any other thing that worries
you?

Thanks

>
> > >
> > >
> > > > > --
> > > > > MST
> > > > >
> > >
>

