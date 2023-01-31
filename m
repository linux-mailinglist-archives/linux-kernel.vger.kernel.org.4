Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DF8682BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjAaLl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjAaLlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:41:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9EDCDF8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675165267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t0pVvL03jcaCFyRgspQVvHakK5COVOMI25MafnyLE2I=;
        b=ELEul7R1rw11PjtZC2u/j+I3qJ2L2GKnGbg5xoVlkti23gaBLRLWs7oDpGgDZIKRAWecj3
        Xl+EW85hKjSL4cQp/fn2uIzxzDt5hoI/Y0gBi9OgZlymPjvG3xDUvzw2aF4nNFsF5Eb6TU
        EzBN9JL7OfqeyoALsg094mm0cvqC4dw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-621-Kz-1z_JMOP6rXqx3b4FD2w-1; Tue, 31 Jan 2023 06:41:06 -0500
X-MC-Unique: Kz-1z_JMOP6rXqx3b4FD2w-1
Received: by mail-qv1-f71.google.com with SMTP id j7-20020a0cf507000000b0053b538958d5so3944096qvm.18
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:41:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t0pVvL03jcaCFyRgspQVvHakK5COVOMI25MafnyLE2I=;
        b=D5OVHrwTBHxfs1H2bs35HBROKxTIVeRdicBw/eqXBMkqBOilbtxETKAwVrABfi/6Dl
         SWLfkKsUpj4upMh0gJDdjnkuNU+sdmcy6JfVZTfjJMGr+C/3LwrtUdY283Y+oG9s2u0f
         BZa8hFbTamX/KPH7Z2tbyBKmhAmzw26NzIz4ifLr1evv9qGcz69fQm1AEs+hiQqhcZt5
         GosGaFa3FvdYzMD/ZCkC2SuGt9AKOkDxHnC2LHurBwRhJSu+tNfwnmXCvDosspS9LcYm
         AXtuFNc7Jd8WOCQ+8/BsSDmZxvfrjpNKoyF6U/W7G2jnrPum620TdFAFGQ6+e70QRxlW
         z2yA==
X-Gm-Message-State: AO0yUKXOd9v1WMJ3kX1AWpFjEV2rj+kb3mUsYXbs//gdU2CPFYHUgTmU
        iouda9fzb8zR8tLLwfwbQP2P+yRtJmrZy7VFwPsH4IDdSiDuut4KB7OGfYfARtu2NAZOhm8EQJu
        dpy6jdaouZtYbzkSG7IZRaV6i
X-Received: by 2002:a0c:9130:0:b0:53a:6000:e4ae with SMTP id q45-20020a0c9130000000b0053a6000e4aemr6168970qvq.4.1675165265541;
        Tue, 31 Jan 2023 03:41:05 -0800 (PST)
X-Google-Smtp-Source: AK7set9f6OCpGakG2JgTMvzK1B61y13TQZr3Nc5Q8YgVjyNptfDGsEnb3nyJlrcbvN1U9e8uqZwy4Q==
X-Received: by 2002:a0c:9130:0:b0:53a:6000:e4ae with SMTP id q45-20020a0c9130000000b0053a6000e4aemr6168932qvq.4.1675165265060;
        Tue, 31 Jan 2023 03:41:05 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-113-28.dyn.eolo.it. [146.241.113.28])
        by smtp.gmail.com with ESMTPSA id p74-20020a37424d000000b0071a5dbcafbfsm6948896qka.29.2023.01.31.03.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 03:41:04 -0800 (PST)
Message-ID: <7c996ac279a6a2fa527906c3e91219ceb64e93fc.camel@redhat.com>
Subject: Re: [PATCH v3 2/2] virtio_net: notify MAC address change on device
 initialization
From:   Paolo Abeni <pabeni@redhat.com>
To:     Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        Cindy Lu <lulu@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
        Parav Pandit <parav@nvidia.com>
Date:   Tue, 31 Jan 2023 12:41:00 +0100
In-Reply-To: <8bb17aed-d643-2e33-472a-9f237e26e4d1@redhat.com>
References: <20230127204500.51930-1-lvivier@redhat.com>
         <20230127204500.51930-3-lvivier@redhat.com>
         <949500bd10077989eb21bd41d6bb1a0de296f9d8.camel@redhat.com>
         <8bb17aed-d643-2e33-472a-9f237e26e4d1@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-01-31 at 10:32 +0100, Laurent Vivier wrote:
> On 1/31/23 10:01, Paolo Abeni wrote:
> > On Fri, 2023-01-27 at 21:45 +0100, Laurent Vivier wrote:
> > > In virtnet_probe(), if the device doesn't provide a MAC address the
> > > driver assigns a random one.
> > > As we modify the MAC address we need to notify the device to allow it
> > > to update all the related information.
> > >=20
> > > The problem can be seen with vDPA and mlx5_vdpa driver as it doesn't
> > > assign a MAC address by default. The virtio_net device uses a random
> > > MAC address (we can see it with "ip link"), but we can't ping a net
> > > namespace from another one using the virtio-vdpa device because the
> > > new MAC address has not been provided to the hardware:
> > > RX packets are dropped since they don't go through the receive filter=
s,
> > > TX packets go through unaffected.
> > >=20
> > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > > ---
> > >   drivers/net/virtio_net.c | 20 ++++++++++++++++++++
> > >   1 file changed, 20 insertions(+)
> > >=20
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 7d700f8e545a..704a05f1c279 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -3806,6 +3806,8 @@ static int virtnet_probe(struct virtio_device *=
vdev)
> > >   		eth_hw_addr_set(dev, addr);
> > >   	} else {
> > >   		eth_hw_addr_random(dev);
> > > +		dev_info(&vdev->dev, "Assigned random MAC address %pM\n",
> > > +			 dev->dev_addr);
> > >   	}
> > >  =20
> > >   	/* Set up our device-specific information */
> > > @@ -3933,6 +3935,24 @@ static int virtnet_probe(struct virtio_device =
*vdev)
> > >  =20
> > >   	virtio_device_ready(vdev);
> > >  =20
> > > +	/* a random MAC address has been assigned, notify the device.
> > > +	 * We don't fail probe if VIRTIO_NET_F_CTRL_MAC_ADDR is not there
> > > +	 * because many devices work fine without getting MAC explicitly
> > > +	 */
> > > +	if (!virtio_has_feature(vdev, VIRTIO_NET_F_MAC) &&
> > > +	    virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
> > > +		struct scatterlist sg;
> > > +
> > > +		sg_init_one(&sg, dev->dev_addr, dev->addr_len);
> > > +		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
> > > +					  VIRTIO_NET_CTRL_MAC_ADDR_SET, &sg)) {
> > > +			pr_debug("virtio_net: setting MAC address failed\n");
> > > +			rtnl_unlock();
> > > +			err =3D -EINVAL;
> > > +			goto free_unregister_netdev;
> >=20
> > Since the above is still dealing with device initialization, would it
> > make sense moving such init step before registering the netdevice?
>=20
> It depends if we can send the command using the control command queue or =
not.
> I don't think we can use a vq before virtio_device_ready().

Sounds reasonable. @Michael: do you have any additional comments?

Thanks!

Paolo

