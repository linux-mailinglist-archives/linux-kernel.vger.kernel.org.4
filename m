Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A9067E2B9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjA0LJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjA0LI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:08:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D4C126FD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674817689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CKPEQeD05U6KFCAYtgfxbXNA3n/pe6PkgZWvP+2Uf2k=;
        b=Z/afB6xntG4PsNmG+MnNr7ri2/UqOheTxJ9MHkpQ36VKlYSbb1Cc6rAxM7ziuhxOAf+ZvS
        FhiAaMeRoRR8/k4YBR8xtwKNMXnbPy1Xk445k4jrPbMCRYH0IpaPT1AUW/5E8JdWbuFYsw
        ikrzZrufRaKR3tF/sOsCs0xREMVSUA8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-414-eok-VtXjNFm8bbGwInhgyw-1; Fri, 27 Jan 2023 06:08:08 -0500
X-MC-Unique: eok-VtXjNFm8bbGwInhgyw-1
Received: by mail-ej1-f72.google.com with SMTP id hr22-20020a1709073f9600b0086ffb73ac1cso3229138ejc.23
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:08:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKPEQeD05U6KFCAYtgfxbXNA3n/pe6PkgZWvP+2Uf2k=;
        b=YWz3fGjlBJXfR2O0qbHRSoAp1QNAwJR5g0QgRUA2gilxYfPFp41nbrYF1b/X91uCi8
         6anWrzxUlByCYCBgfUThztnjewpSmLzp3CUT8RcTWopgQHZlBRPtBBPUMP6aCzAd/g5a
         SL4kqqSXNX2aWVhA9zRHziCrAjrQfpPSsx45n0xW6A63D29TqIN7qM18Z8EnrDqXm72H
         JQgXJU98qdRTTv3dwPHty3zV6lS0T+gsz4TTHvC/rtvtkHlVskYlKo9xc5yR1Rbo8oPK
         RIA5zlbX4VQ9uYVde4t0M1Bvc6cumTCELiTuliBv8XrnEmLL3FoSRzpNvjIataxajRGN
         R57w==
X-Gm-Message-State: AFqh2kpCoQ3NMX1xAJnf7TVxa0fDSyH9795JY3m5rxH0D0P2thc4kfIP
        Jbpgv/Rx/0h/1lIqUJZtYP535wxmHfDc6orXQa4Ew7qNHxL1O9o0IL0aRbLtHiOIAT+kySZQilP
        ZApRXAdOK/y7SjehmtNIXw/YX
X-Received: by 2002:a17:907:8a07:b0:7c1:5ee1:4c57 with SMTP id sc7-20020a1709078a0700b007c15ee14c57mr48312984ejc.8.1674817686731;
        Fri, 27 Jan 2023 03:08:06 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtEZ9qSwCeJX4118ylH95WPKVKjIFX0j4DWxndoYOi4bwRVWxwjupfV2ZGS4Sf/mhJEOQy+Mg==
X-Received: by 2002:a17:907:8a07:b0:7c1:5ee1:4c57 with SMTP id sc7-20020a1709078a0700b007c15ee14c57mr48312963ejc.8.1674817686493;
        Fri, 27 Jan 2023 03:08:06 -0800 (PST)
Received: from redhat.com ([2.52.137.69])
        by smtp.gmail.com with ESMTPSA id m5-20020aa7c485000000b0049e19136c22sm2120592edq.95.2023.01.27.03.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:08:05 -0800 (PST)
Date:   Fri, 27 Jan 2023 06:08:01 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        Eli Cohen <elic@nvidia.com>, Cindy Lu <lulu@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH v2 1/1] virtio_net: notify MAC address change on device
 initialization
Message-ID: <20230127060453-mutt-send-email-mst@kernel.org>
References: <20230123120022.2364889-1-lvivier@redhat.com>
 <20230123120022.2364889-2-lvivier@redhat.com>
 <20230124024711-mutt-send-email-mst@kernel.org>
 <971beeaf-5e68-eb4a-1ceb-63a5ffa74aff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <971beeaf-5e68-eb4a-1ceb-63a5ffa74aff@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 12:04:24PM +0100, Laurent Vivier wrote:
> On 1/24/23 11:15, Michael S. Tsirkin wrote:
> > On Mon, Jan 23, 2023 at 01:00:22PM +0100, Laurent Vivier wrote:
> > > In virtnet_probe(), if the device doesn't provide a MAC address the
> > > driver assigns a random one.
> > > As we modify the MAC address we need to notify the device to allow it
> > > to update all the related information.
> > > 
> > > The problem can be seen with vDPA and mlx5_vdpa driver as it doesn't
> > > assign a MAC address by default. The virtio_net device uses a random
> > > MAC address (we can see it with "ip link"), but we can't ping a net
> > > namespace from another one using the virtio-vdpa device because the
> > > new MAC address has not been provided to the hardware.
> > 
> > And then what exactly happens? Does hardware drop the outgoing
> > or the incoming packets? Pls include in the commit log.
> 
> I don't know. There is nothing in the kernel logs.
> 
> The ping error is: "Destination Host Unreachable"
> 
> I found the problem with the mlx5 driver as in "it doesn't work when MAC
> address is not set"...
> 
> Perhaps Eli can explain what happens when the MAC address is not set?
> 
> > 
> > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > > ---
> > >   drivers/net/virtio_net.c | 14 ++++++++++++++
> > >   1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 7723b2a49d8e..4bdc8286678b 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -3800,6 +3800,8 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >   		eth_hw_addr_set(dev, addr);
> > >   	} else {
> > >   		eth_hw_addr_random(dev);
> > > +		dev_info(&vdev->dev, "Assigned random MAC address %pM\n",
> > > +			 dev->dev_addr);
> > >   	}
> > >   	/* Set up our device-specific information */
> > > @@ -3956,6 +3958,18 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >   	pr_debug("virtnet: registered device %s with %d RX and TX vq's\n",
> > >   		 dev->name, max_queue_pairs);
> > > +	/* a random MAC address has been assigned, notify the device */
> > > +	if (!virtio_has_feature(vdev, VIRTIO_NET_F_MAC) &&
> > > +	    virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
> > 
> > Maybe add a comment explaining that we don't fail probe if
> > VIRTIO_NET_F_CTRL_MAC_ADDR is not there because
> > many devices work fine without getting MAC explicitly.
> 
> OK
> 
> > 
> > > +		struct scatterlist sg;
> > > +
> > > +		sg_init_one(&sg, dev->dev_addr, dev->addr_len);
> > > +		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
> > > +					  VIRTIO_NET_CTRL_MAC_ADDR_SET, &sg)) {
> > > +			dev_warn(&vdev->dev, "Failed to update MAC address.\n");
> > 
> > Here, I'm not sure we want to proceed. Is it useful sometimes?
> 
> I think reporting an error is always useful, but I can remove that if you prefer.

No the question was whether we should fail probe not
whether we print the warning.


> > I note that we deny with virtnet_set_mac_address.
> > 
> > > +		}
> > > +	}
> > > +
> > >   	return 0;
> > 
> > 
> > 
> > Also, some code duplication with virtnet_set_mac_address here.
> > 
> > Also:
> > 	When using the legacy interface, \field{mac} is driver-writable
> > 	which provided a way for drivers to update the MAC without
> > 	negotiating VIRTIO_NET_F_CTRL_MAC_ADDR.
> > 
> > How about factoring out code in virtnet_set_mac_address
> > and reusing that?
> > 
> 
> In fact, we can write in the field only if we have VIRTIO_NET_F_MAC
> (according to virtnet_set_mac_address(), and this code is executed only if
> we do not have VIRTIO_NET_F_MAC. So I think it's better not factoring the
> code as we have only the control queue case to manage.
> 
> > This will also handle corner cases such as VIRTIO_NET_F_STANDBY
> > which are not currently addressed.
> 
> F_STANDBY is only enabled when virtio-net device MAC address is equal to the
> VFIO device MAC address, I don't think it can be enabled when the MAC
> address is randomly assigned (in this case it has already failed in
> net_failover_create(), as it has been called using the random mac address),
> it's why I didn't check for it.

But the spec did not say there's a dependency :(.
My point is what should we do if there's F_STANDBY but no MAC?
Maybe add a separate patch clearing F_STANDBY in this case?

> > 
> > 
> > >   free_unregister_netdev:
> > > -- 
> > > 2.39.0
> > 
> 
> Thanks,
> Laurent

