Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AB56A3A08
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 05:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjB0EN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 23:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjB0ENN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 23:13:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65A6113C8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677471137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bF6aiagdS4QYKhUwnh5wvwibqsaVZLVPjb91E7IR+3w=;
        b=aqpZw07LQpP7CMvPCj5XN0x3njFB+IhjsYsMq7yXdy0jJKIpSytBURPHM0lIR6SmO2Qryn
        6rMlxvebbTytKlEgUHvFE0r2MINIq8feLa8xl4DC/NKd6kwOdnHOD9xg1XiC4fgWAN8hZ/
        eJ3FPSOBEryg3xUBmv9SQ/O8DA0hobY=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-492-Qsn7XYw5M2-11aYPnICuYQ-1; Sun, 26 Feb 2023 23:12:15 -0500
X-MC-Unique: Qsn7XYw5M2-11aYPnICuYQ-1
Received: by mail-ot1-f72.google.com with SMTP id t9-20020a9d7f89000000b00693c3bb8cc1so3091938otp.17
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bF6aiagdS4QYKhUwnh5wvwibqsaVZLVPjb91E7IR+3w=;
        b=2UBWOl93WbPWj/9uV6CBbCnWJf6eztd94VWU8Ds7QHOlcXLoQdlR+QW/2MrOwgqrA0
         YbGZ0RpsfOUXNQ+VIx7+Q3R1YwngXA7H7qWHCsl4dETEITTi1wK9ZBmeT/heN/XqM+wW
         C7cULtcehRADF3HC+OsEdKEmQurBIU8IihvJKBUiNET367TqkuWMVpPGC9hqNl+SHqap
         NLZL+B1RXTjkmiHpPuc1ZO15fBV+tQ2JXuzDj83/2jp266vvipAYBjgi6KR9llw5ucWR
         CsGIWh8YS1Ag65CMJELDk/rSbT0Mu5wmxl3X5mpF/kMKmOp7hBMfxwLfuUXyaJE7QtOM
         WZOw==
X-Gm-Message-State: AO0yUKU8B3kChR6ZtWwHQgW6WtO5qFLMeiNYpqxfpq+B608l6xBhGlnj
        yicEEyIDDS4A7mCp3lCmbNxD7PP2jWNijq1BzenLbcAqll68MK7UpuNcAUt+CkFk1lujFE/iyUb
        g/oFeSgkSTqAHdkMA4DbEBTSegwoxJGJTdRyb4rOu
X-Received: by 2002:aca:170c:0:b0:37f:ab56:ff42 with SMTP id j12-20020aca170c000000b0037fab56ff42mr3473925oii.9.1677471135098;
        Sun, 26 Feb 2023 20:12:15 -0800 (PST)
X-Google-Smtp-Source: AK7set/s+nbucOcz9b2Oq/7thNtMbK8QBjD/2uF5c2KiU21IMrI5QTglUfGm3DOphwmfmZOT3QQigLJlfH4Zl+n1WLc=
X-Received: by 2002:aca:170c:0:b0:37f:ab56:ff42 with SMTP id
 j12-20020aca170c000000b0037fab56ff42mr3473919oii.9.1677471134909; Sun, 26 Feb
 2023 20:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20230223-virtio-net-kvmtool-v2-1-8ec93511e67f@rivosinc.com> <20230224031932-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230224031932-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 27 Feb 2023 12:12:03 +0800
Message-ID: <CACGkMEs8f6akn62UKGUC=N=+MMRdLuGrzC7OpOps5_Ug6h933g@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-net: Fix probe of virtio-net on kvmtool
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     rbradford@rivosinc.com, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Feb 24, 2023 at 4:25=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Feb 23, 2023 at 07:38:25PM +0000, Rob Bradford via B4 Relay wrote=
:
> > From: Rob Bradford <rbradford@rivosinc.com>
> >
> > kvmtool does not support the VIRTIO_NET_F_CTRL_GUEST_OFFLOADS feature
> > but does advertise the VIRTIO_NET_F_GUEST_TSO{4,6} features. Check that
> > the VIRTIO_NET_F_CTRL_GUEST_OFFLOADS feature is present before setting
> > the NETIF_F_GRO_HW feature bit as otherwise an attempt will be made to
> > program the virtio-net device using the ctrl queue which will fail.
> >
> > This resolves the following error when running on kvmtool:
> >
> > [    1.865992] net eth0: Fail to set guest offload.
> > [    1.872491] virtio_net virtio2 eth0: set_features() failed (-22); wa=
nted 0x0000000000134829, left 0x0080000000134829
> >
> > Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> > ---
> > Changes in v2:
> > - Use parentheses to group logical OR of features
> > - Link to v1:
> >   https://lore.kernel.org/r/20230223-virtio-net-kvmtool-v1-1-fc23d29b9d=
7a@rivosinc.com
> > ---
> >  drivers/net/virtio_net.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 61e33e4dd0cd..f8341d1a4ccd 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3780,10 +3780,9 @@ static int virtnet_probe(struct virtio_device *v=
dev)
> >       }
> >       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_CSUM))
> >               dev->features |=3D NETIF_F_RXCSUM;
> > -     if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > -         virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> > -             dev->features |=3D NETIF_F_GRO_HW;
> > -     if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> > +     if ((virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > +         virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6)) &&
> > +         virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> >               dev->hw_features |=3D NETIF_F_GRO_HW;
>
> This will disable GRO/LRO on kvmtool completely causing a significant
> performance regression.
>
> Jason, isn't this what
>         commit dbcf24d153884439dad30484a0e3f02350692e4c
>         Author: Jason Wang <jasowang@redhat.com>
>         Date:   Tue Aug 17 16:06:59 2021 +0800
>
>             virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO
>
> was supposed to address?
>

Yes, I've asked a similar question in another thread.

>
> And apropos this:
>
>     Fix this by using NETIF_F_GRO_HW instead. Though the spec does not
>     guarantee packets to be re-segmented as the original ones,
>     we can add that to the spec, possibly with a flag for devices to
>     differentiate between GRO and LRO.
>
> this never happened. What's the plan exactly?

It's in the backlog, but I'm out of bandwidth for doing that now.

Thanks

>
>
>
>
> >       dev->vlan_features =3D dev->features;
> >
> > ---
> > base-commit: c39cea6f38eefe356d64d0bc1e1f2267e282cdd3
> > change-id: 20230223-virtio-net-kvmtool-87f37515be22
> >
> > Best regards,
> > --
> > Rob Bradford <rbradford@rivosinc.com>
>

