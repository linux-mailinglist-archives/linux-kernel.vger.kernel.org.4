Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7846A7C45
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 09:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCBILX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 03:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjCBILU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 03:11:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11772D149
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 00:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677744633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a4doVFCQ5KJmZV+lPvurw3orc9Atjymj2EsOoEfGZFo=;
        b=YHmZeeMn0+glyhJXXTg6YyNFWJnO11eWDxxCM4loTivkRwxX2G5RcRoW83RZm4AKp/eHTB
        qmKp+/lpLjCgiyigJLeem38pmuT6IiFLAGjEmrS2SwzgN4lbcRlBNu59j58ZJwY9G93CkU
        fV6siZzXvDyGwNqidsIdcpe1geSKXlY=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-vuRN8TStN7WrmHlRajlOMQ-1; Thu, 02 Mar 2023 03:10:32 -0500
X-MC-Unique: vuRN8TStN7WrmHlRajlOMQ-1
Received: by mail-ot1-f71.google.com with SMTP id m20-20020a05683026d400b006942d0ed1d1so1902040otu.18
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 00:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4doVFCQ5KJmZV+lPvurw3orc9Atjymj2EsOoEfGZFo=;
        b=k0yjqbzFOfh/Vqg74fsPt9ZQNxaRbm6v6hpuplHayAA4BV65RPsPZnnjPb9EDT6MOY
         MUA+xFSaf030orWIVLwQXErOqi8Rglizprk0c7NxjJ56q/2/2L7WXq0Iuv2IyBHDrXZQ
         /+qdnd5LdY10fIoBIOJ4aR+S4EW/ZGGY5mcKeJkQqCnK8i8zmXyLoje2NT5JU1xRu3ZQ
         hiiCQTRK51ie300gYb5IeApu/xaUpsCI4tdhSMLiMsSKgTFxdBWQm3k5YN3/+1UHjsqH
         0NCHUX3OP2eZWlKIXUhK/7UPHwSMYoOx+vET07dFCK+5ASu7zNNSIt/vDZZjfgNMKCIi
         lquA==
X-Gm-Message-State: AO0yUKWyRNaEgoVryOsqYJv1qO8bQx58SEwfw6l4kJ44KTSqRob9tvYj
        UIB4ANUBvyJunrgnI++uohL8IbIHdA6ecR6T7XbmUdqZQmUInJIQ39CBnf2S53ZPz2HdP/xPHr/
        mEPEwjk3BglT6EBa5HrgNSFYoZkntKNGurYWPKJ9L
X-Received: by 2002:a54:480c:0:b0:36e:f6f5:604c with SMTP id j12-20020a54480c000000b0036ef6f5604cmr2797467oij.9.1677744631915;
        Thu, 02 Mar 2023 00:10:31 -0800 (PST)
X-Google-Smtp-Source: AK7set+sj3fbXt8XiifY046sFFbf1plye0Fiy4DTIoY+gujjAl0FnNe8UJAkIsvsAya6Z4XPKOwpwLtdFB2CiXVSkd4=
X-Received: by 2002:a54:480c:0:b0:36e:f6f5:604c with SMTP id
 j12-20020a54480c000000b0036ef6f5604cmr2797460oij.9.1677744631216; Thu, 02 Mar
 2023 00:10:31 -0800 (PST)
MIME-Version: 1.0
References: <20230223-virtio-net-kvmtool-v3-1-e038660624de@rivosinc.com> <20230301093054-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230301093054-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 2 Mar 2023 16:10:20 +0800
Message-ID: <CACGkMEsG10CWigz+S6JgSVK8XfbpT=L=30hZ8LDvohtaanAiZQ@mail.gmail.com>
Subject: Re: [PATCH v3] virtio-net: Fix probe of virtio-net on kvmtool
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 10:44=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Mar 01, 2023 at 01:59:52PM +0000, Rob Bradford via B4 Relay wrote=
:
> > From: Rob Bradford <rbradford@rivosinc.com>
> >
> > Since the following commit virtio-net on kvmtool has printed a warning
> > during the probe:
> >
> > commit dbcf24d153884439dad30484a0e3f02350692e4c
> > Author: Jason Wang <jasowang@redhat.com>
> > Date:   Tue Aug 17 16:06:59 2021 +0800
> >
> >     virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO
> >
> > [    1.865992] net eth0: Fail to set guest offload.
> > [    1.872491] virtio_net virtio2 eth0: set_features() failed (-22); wa=
nted 0x0000000000134829, left 0x0080000000134829
> >
> > This is because during the probing the underlying netdev device has
> > identified that the netdev features on the device has changed and
> > attempts to update the virtio-net offloads through the virtio-net
> > control queue. kvmtool however does not have a control queue that suppo=
rts
> > offload changing (VIRTIO_NET_F_CTRL_GUEST_OFFLOADS is not advertised)
> >
> > The netdev features have changed due to validation checks in
> > netdev_fix_features():
> >
> > if (!(features & NETIF_F_RXCSUM)) {
> >       /* NETIF_F_GRO_HW implies doing RXCSUM since every packet
> >        * successfully merged by hardware must also have the
> >        * checksum verified by hardware.  If the user does not
> >        * want to enable RXCSUM, logically, we should disable GRO_HW.
> >        */
> >       if (features & NETIF_F_GRO_HW) {
> >               netdev_dbg(dev, "Dropping NETIF_F_GRO_HW since no RXCSUM =
feature.\n");
> >               features &=3D ~NETIF_F_GRO_HW;
> >       }
> > }
> >
> > Since kvmtool does not advertise the VIRTIO_NET_F_GUEST_CSUM feature th=
e
> > NETIF_F_RXCSUM bit is not present and so the NETIF_F_GRO_HW bit is
> > cleared. This results in the netdev features changing, which triggers
> > the attempt to reprogram the virtio-net offloads which then fails.
> >
> > This commit prevents that set of netdev features from changing by
> > preemptively applying the same validation and only setting
> > NETIF_F_GRO_HW if NETIF_F_RXCSUM is set because the device supports bot=
h
> > VIRTIO_NET_F_GUEST_CSUM and VIRTIO_NET_F_GUEST_TSO{4,6}
> >
> > Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> > ---
> > Changes in v3:
> > - Identified root-cause of feature bit changing and updated conditions
> >   check
> > - Link to v2: https://lore.kernel.org/r/20230223-virtio-net-kvmtool-v2-=
1-8ec93511e67f@rivosinc.com
> >
> > Changes in v2:
> > - Use parentheses to group logical OR of features
> > - Link to v1:
> >   https://lore.kernel.org/r/20230223-virtio-net-kvmtool-v1-1-fc23d29b9d=
7a@rivosinc.com
> > ---
> >  drivers/net/virtio_net.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 61e33e4dd0cd..2e7705142ca5 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3778,11 +3778,13 @@ static int virtnet_probe(struct virtio_device *=
vdev)
> >                       dev->features |=3D dev->hw_features & NETIF_F_ALL=
_TSO;
> >               /* (!csum && gso) case will be fixed by register_netdev()=
 */
> >       }
> > -     if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_CSUM))
> > +     if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_CSUM)) {
> >               dev->features |=3D NETIF_F_RXCSUM;
> > -     if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > -         virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> > -             dev->features |=3D NETIF_F_GRO_HW;
> > +             /* This dependency is enforced by netdev_fix_features */
> > +             if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > +                 virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> > +                     dev->features |=3D NETIF_F_GRO_HW;
> > +     }
> >       if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> >               dev->hw_features |=3D NETIF_F_GRO_HW;

Should we move this also under the check of RXCSUM, otherwise we may
end up the following case:

when CSUM is not negotiated but GUEST_OFFLOADS, can still try to
enable-or-disable guest offloads? Or do we need to fail the probe in
the case via virtnet_validate_features()?

> >
>
> I see. It is annoying that we are duplicating the logic from
> netdev_fix_features here though :(
> Maybe we should call netdev_update_features, in the callback check
> the flags and decide what to set and what to clear?
> Or export netdev_fix_features to modules?

There's a ndo_fix_features() that might be used here.

>
>
>
> Also re-reading Documentation/networking/netdev-features.rst -
>
>  1. netdev->hw_features set contains features whose state may possibly
>     be changed (enabled or disabled) for a particular device by user's
>     request.  This set should be initialized in ndo_init callback and not
>     changed later.
>
>  2. netdev->features set contains features which are currently enabled
>     for a device.  This should be changed only by network core or in
>     error paths of ndo_set_features callback.
>
>
> is it then wrong that virtio sets NETIF_F_RXCSUM and NETIF_F_GRO_HW in
> dev->features and not in dev->hw_features?

Looks not the core can try to enable and disable features according to
the diff between features and hw_features

static inline netdev_features_t netdev_get_wanted_features(
        struct net_device *dev)
{
        return (dev->features & ~dev->hw_features) | dev->wanted_features;
}

Thanks

> We set it there because
> without ctrl guest offload these can not be changed.
> I suspect this is just a minor documentation bug yes? Maybe devices
> where features can't be cleared are uncommon.
>
> Also:
>         if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
>                 dev->hw_features |=3D NETIF_F_GRO_HW;
>
> but should we not set NETIF_F_RXCSUM there too?
>
>
>
> > ---
> > base-commit: c39cea6f38eefe356d64d0bc1e1f2267e282cdd3
> > change-id: 20230223-virtio-net-kvmtool-87f37515be22
> >
> > Best regards,
> > --
> > Rob Bradford <rbradford@rivosinc.com>
>

