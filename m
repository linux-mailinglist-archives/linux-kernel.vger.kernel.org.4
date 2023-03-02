Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12FA6A7EAD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjCBJuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjCBJto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:49:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B453ABC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 01:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677750526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p7N+1E5DGA3fl08/MkVUOzNTAgunnlolIcVRuXePLlY=;
        b=W0OkjllHPWjmnTD8dWEaZ6jwslLmfw4xk2aCTlGM/J3WCEpD2lZboG4PKIqBfSVEAOn1s1
        0ugzww5YOnDXtDkHoLYI/2CPpkfUPmHM9v69ASbt+uJAzrrcduTOgCK4DSQXeT2q6mn4v+
        UA3ujVDbfMxAdag3p0BLmzQMja1uop0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-bVT0aq0SOtWAcEmxA5u5ng-1; Thu, 02 Mar 2023 04:48:44 -0500
X-MC-Unique: bVT0aq0SOtWAcEmxA5u5ng-1
Received: by mail-wm1-f69.google.com with SMTP id az39-20020a05600c602700b003e97eb80524so1021303wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 01:48:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677750523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p7N+1E5DGA3fl08/MkVUOzNTAgunnlolIcVRuXePLlY=;
        b=wHMHoooySndPynEifHmBeOQRGQjeVvAiXSauv5a41rSk1BTDzYYQsFvdsYF6xwqoag
         t7G4A6leYeTB6qghv0Yxy44O02kjRu5S+86H95rPCQc6jMXcMxxHUpjN/pg7Fl1tHFi/
         GVF87NSkOPrqZvyqCP2eCYLWy9Ad7iK+QhAIiC3lsE3unDgMS91iiIwPgk3Hznu9riiB
         hLHxgz7wLgK/QyvWY6LpUx+vaocqcxv/nlHJF0B5J/RsFlVojW7+yRxm68BH8P6Sa1Mn
         JzrmHI9ZUQlz6xhwObodgsZ69xOUeh5TnwDPgrhjL3LFtFomu3sxYzUUGUGcA8nGAqfU
         8HyA==
X-Gm-Message-State: AO0yUKV0sEJIaWj4VpqqBJeFPNzmYL68CxeBfxIMLnChotO1slN7ZFeZ
        g0GL4Hkg+ywGv/8Prpe41i0os1hCeh/GUjy4PCKppjoVoHqOwtOVzM/Kdtb6YGIGXPHKOpcQb3i
        e6OyoA33YKc89FKoj6Wb0mD77
X-Received: by 2002:adf:f7ca:0:b0:2ca:c865:51b3 with SMTP id a10-20020adff7ca000000b002cac86551b3mr6860274wrq.12.1677750523190;
        Thu, 02 Mar 2023 01:48:43 -0800 (PST)
X-Google-Smtp-Source: AK7set/GZp3j5zzeEXt8/MDOyF0K1e3KRj5zkoXbShUyIVh62NUr4keMmltn9kmTDOdf0l7t8o5h1g==
X-Received: by 2002:adf:f7ca:0:b0:2ca:c865:51b3 with SMTP id a10-20020adff7ca000000b002cac86551b3mr6860257wrq.12.1677750522792;
        Thu, 02 Mar 2023 01:48:42 -0800 (PST)
Received: from redhat.com ([2.52.141.194])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d6a82000000b002c53cc7504csm15208871wru.78.2023.03.02.01.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 01:48:42 -0800 (PST)
Date:   Thu, 2 Mar 2023 04:48:38 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     rbradford@rivosinc.com, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] virtio-net: Fix probe of virtio-net on kvmtool
Message-ID: <20230302044806-mutt-send-email-mst@kernel.org>
References: <20230223-virtio-net-kvmtool-v3-1-e038660624de@rivosinc.com>
 <20230301093054-mutt-send-email-mst@kernel.org>
 <CACGkMEsG10CWigz+S6JgSVK8XfbpT=L=30hZ8LDvohtaanAiZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsG10CWigz+S6JgSVK8XfbpT=L=30hZ8LDvohtaanAiZQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 04:10:20PM +0800, Jason Wang wrote:
> On Wed, Mar 1, 2023 at 10:44 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Mar 01, 2023 at 01:59:52PM +0000, Rob Bradford via B4 Relay wrote:
> > > From: Rob Bradford <rbradford@rivosinc.com>
> > >
> > > Since the following commit virtio-net on kvmtool has printed a warning
> > > during the probe:
> > >
> > > commit dbcf24d153884439dad30484a0e3f02350692e4c
> > > Author: Jason Wang <jasowang@redhat.com>
> > > Date:   Tue Aug 17 16:06:59 2021 +0800
> > >
> > >     virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO
> > >
> > > [    1.865992] net eth0: Fail to set guest offload.
> > > [    1.872491] virtio_net virtio2 eth0: set_features() failed (-22); wanted 0x0000000000134829, left 0x0080000000134829
> > >
> > > This is because during the probing the underlying netdev device has
> > > identified that the netdev features on the device has changed and
> > > attempts to update the virtio-net offloads through the virtio-net
> > > control queue. kvmtool however does not have a control queue that supports
> > > offload changing (VIRTIO_NET_F_CTRL_GUEST_OFFLOADS is not advertised)
> > >
> > > The netdev features have changed due to validation checks in
> > > netdev_fix_features():
> > >
> > > if (!(features & NETIF_F_RXCSUM)) {
> > >       /* NETIF_F_GRO_HW implies doing RXCSUM since every packet
> > >        * successfully merged by hardware must also have the
> > >        * checksum verified by hardware.  If the user does not
> > >        * want to enable RXCSUM, logically, we should disable GRO_HW.
> > >        */
> > >       if (features & NETIF_F_GRO_HW) {
> > >               netdev_dbg(dev, "Dropping NETIF_F_GRO_HW since no RXCSUM feature.\n");
> > >               features &= ~NETIF_F_GRO_HW;
> > >       }
> > > }
> > >
> > > Since kvmtool does not advertise the VIRTIO_NET_F_GUEST_CSUM feature the
> > > NETIF_F_RXCSUM bit is not present and so the NETIF_F_GRO_HW bit is
> > > cleared. This results in the netdev features changing, which triggers
> > > the attempt to reprogram the virtio-net offloads which then fails.
> > >
> > > This commit prevents that set of netdev features from changing by
> > > preemptively applying the same validation and only setting
> > > NETIF_F_GRO_HW if NETIF_F_RXCSUM is set because the device supports both
> > > VIRTIO_NET_F_GUEST_CSUM and VIRTIO_NET_F_GUEST_TSO{4,6}
> > >
> > > Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> > > ---
> > > Changes in v3:
> > > - Identified root-cause of feature bit changing and updated conditions
> > >   check
> > > - Link to v2: https://lore.kernel.org/r/20230223-virtio-net-kvmtool-v2-1-8ec93511e67f@rivosinc.com
> > >
> > > Changes in v2:
> > > - Use parentheses to group logical OR of features
> > > - Link to v1:
> > >   https://lore.kernel.org/r/20230223-virtio-net-kvmtool-v1-1-fc23d29b9d7a@rivosinc.com
> > > ---
> > >  drivers/net/virtio_net.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 61e33e4dd0cd..2e7705142ca5 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -3778,11 +3778,13 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >                       dev->features |= dev->hw_features & NETIF_F_ALL_TSO;
> > >               /* (!csum && gso) case will be fixed by register_netdev() */
> > >       }
> > > -     if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_CSUM))
> > > +     if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_CSUM)) {
> > >               dev->features |= NETIF_F_RXCSUM;
> > > -     if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > > -         virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> > > -             dev->features |= NETIF_F_GRO_HW;
> > > +             /* This dependency is enforced by netdev_fix_features */
> > > +             if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > > +                 virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> > > +                     dev->features |= NETIF_F_GRO_HW;
> > > +     }
> > >       if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> > >               dev->hw_features |= NETIF_F_GRO_HW;
> 
> Should we move this also under the check of RXCSUM, otherwise we may
> end up the following case:
> 
> when CSUM is not negotiated but GUEST_OFFLOADS, can still try to
> enable-or-disable guest offloads? Or do we need to fail the probe in
> the case via virtnet_validate_features()?
> 
> > >
> >
> > I see. It is annoying that we are duplicating the logic from
> > netdev_fix_features here though :(
> > Maybe we should call netdev_update_features, in the callback check
> > the flags and decide what to set and what to clear?
> > Or export netdev_fix_features to modules?
> 
> There's a ndo_fix_features() that might be used here.
> 
> >
> >
> >
> > Also re-reading Documentation/networking/netdev-features.rst -
> >
> >  1. netdev->hw_features set contains features whose state may possibly
> >     be changed (enabled or disabled) for a particular device by user's
> >     request.  This set should be initialized in ndo_init callback and not
> >     changed later.
> >
> >  2. netdev->features set contains features which are currently enabled
> >     for a device.  This should be changed only by network core or in
> >     error paths of ndo_set_features callback.
> >
> >
> > is it then wrong that virtio sets NETIF_F_RXCSUM and NETIF_F_GRO_HW in
> > dev->features and not in dev->hw_features?
> 
> Looks not the core can try to enable and disable features according to
> the diff between features and hw_features
> 
> static inline netdev_features_t netdev_get_wanted_features(
>         struct net_device *dev)
> {
>         return (dev->features & ~dev->hw_features) | dev->wanted_features;
> }
> 
> Thanks

yes what we do work according to code.  So the documentation is wrong then?

> > We set it there because
> > without ctrl guest offload these can not be changed.
> > I suspect this is just a minor documentation bug yes? Maybe devices
> > where features can't be cleared are uncommon.
> >
> > Also:
> >         if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> >                 dev->hw_features |= NETIF_F_GRO_HW;
> >
> > but should we not set NETIF_F_RXCSUM there too?
> >
> >
> >
> > > ---
> > > base-commit: c39cea6f38eefe356d64d0bc1e1f2267e282cdd3
> > > change-id: 20230223-virtio-net-kvmtool-87f37515be22
> > >
> > > Best regards,
> > > --
> > > Rob Bradford <rbradford@rivosinc.com>
> >

