Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BCE682E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjAaNoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjAaNoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:44:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978D4B45A
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675172592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FjK9CwJ0qU9dRcgLTPDubY9KveWkyLemzeLHtogsBVU=;
        b=SY/ds4gej2PC4logJqkoKKq4zA9cIUZajTYyMOmMB74eN/kFSJhZ2OgyncSs4UcEoS7ewN
        L/WhZhvpJw+8jZpC4GIhDnVn8CoMaMQr0Cd41nfRkJrAguyEa5EkvxIDKc8Pqnp6vwN4Qm
        1jp8G66XA2LAdzUkG40HT9WL7TBsbcI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-183-RGVgMFpyNq2-rTQljEJncw-1; Tue, 31 Jan 2023 08:43:09 -0500
X-MC-Unique: RGVgMFpyNq2-rTQljEJncw-1
Received: by mail-wm1-f69.google.com with SMTP id h18-20020a05600c351200b003dc25fc1849so8675730wmq.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:43:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjK9CwJ0qU9dRcgLTPDubY9KveWkyLemzeLHtogsBVU=;
        b=6Rqh0/BUPN/7Tp0Nao9rQKXWaxD9IY5pFkZRyePmuqJ7Gvm9WHdrrceBo8YoNpAXdJ
         N2aQiZUhhnQtq5T2w7W0VSbaRMwnaLQ34iuR7XwiA7fcS++cwTTwbBXHmtKJ+hRN2H7Z
         q/R/52nBUZ4lXI3fDnzoAp/JbrTlU4ejFYlsfESf/V//h/+tG2acN4fmUvhN1GKkvoBf
         OIN46b1yEmSCgU2m6IHX1iBptjJ/1DC+4+sDEU+4bOkSvc2hg2aQ3P+/FsXilfun4lH4
         Y/MXWoOPYpJQ4cRXBQMq5WfuA62E8weMb7FupyJgQllhyxVpN+SXcu4JFhZnKiaEjG/h
         xBVQ==
X-Gm-Message-State: AO0yUKVlgVH8Z9A8sTdLkp05IdZqSs9OjB15IAj8L3Il47fXdGY4puWM
        oFTGJ7gP0/9N9bWfHBU7dzTsD8ePFm9EjonpjScm9yhBGwpabrV90BTVZ6dWoGryyPDcAVdjjNs
        GDFaSuRwlzZ/YcgmttDnQhMoG
X-Received: by 2002:a5d:6186:0:b0:2c1:28dc:1566 with SMTP id j6-20020a5d6186000000b002c128dc1566mr2925921wru.41.1675172588152;
        Tue, 31 Jan 2023 05:43:08 -0800 (PST)
X-Google-Smtp-Source: AK7set+p39CqWABw+L+6uLvyXB/Xo6TtwQky3aHV0sHHTMfoOt2nrNUb+4VicVe08niov9+PPvP6YQ==
X-Received: by 2002:a5d:6186:0:b0:2c1:28dc:1566 with SMTP id j6-20020a5d6186000000b002c128dc1566mr2925898wru.41.1675172587836;
        Tue, 31 Jan 2023 05:43:07 -0800 (PST)
Received: from redhat.com ([2.52.144.173])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d50c6000000b002bfc24e1c55sm14824129wrt.78.2023.01.31.05.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:43:07 -0800 (PST)
Date:   Tue, 31 Jan 2023 08:43:03 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        Cindy Lu <lulu@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
        Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH v3 2/2] virtio_net: notify MAC address change on device
 initialization
Message-ID: <20230131084213-mutt-send-email-mst@kernel.org>
References: <20230127204500.51930-1-lvivier@redhat.com>
 <20230127204500.51930-3-lvivier@redhat.com>
 <949500bd10077989eb21bd41d6bb1a0de296f9d8.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <949500bd10077989eb21bd41d6bb1a0de296f9d8.camel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 10:01:53AM +0100, Paolo Abeni wrote:
> On Fri, 2023-01-27 at 21:45 +0100, Laurent Vivier wrote:
> > In virtnet_probe(), if the device doesn't provide a MAC address the
> > driver assigns a random one.
> > As we modify the MAC address we need to notify the device to allow it
> > to update all the related information.
> > 
> > The problem can be seen with vDPA and mlx5_vdpa driver as it doesn't
> > assign a MAC address by default. The virtio_net device uses a random
> > MAC address (we can see it with "ip link"), but we can't ping a net
> > namespace from another one using the virtio-vdpa device because the
> > new MAC address has not been provided to the hardware:
> > RX packets are dropped since they don't go through the receive filters,
> > TX packets go through unaffected.
> > 
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 7d700f8e545a..704a05f1c279 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3806,6 +3806,8 @@ static int virtnet_probe(struct virtio_device *vdev)
> >  		eth_hw_addr_set(dev, addr);
> >  	} else {
> >  		eth_hw_addr_random(dev);
> > +		dev_info(&vdev->dev, "Assigned random MAC address %pM\n",
> > +			 dev->dev_addr);
> >  	}
> >  
> >  	/* Set up our device-specific information */
> > @@ -3933,6 +3935,24 @@ static int virtnet_probe(struct virtio_device *vdev)
> >  
> >  	virtio_device_ready(vdev);
> >  
> > +	/* a random MAC address has been assigned, notify the device.
> > +	 * We don't fail probe if VIRTIO_NET_F_CTRL_MAC_ADDR is not there
> > +	 * because many devices work fine without getting MAC explicitly
> > +	 */
> > +	if (!virtio_has_feature(vdev, VIRTIO_NET_F_MAC) &&
> > +	    virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
> > +		struct scatterlist sg;
> > +
> > +		sg_init_one(&sg, dev->dev_addr, dev->addr_len);
> > +		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
> > +					  VIRTIO_NET_CTRL_MAC_ADDR_SET, &sg)) {
> > +			pr_debug("virtio_net: setting MAC address failed\n");
> > +			rtnl_unlock();
> > +			err = -EINVAL;
> > +			goto free_unregister_netdev;
> 
> Since the above is still dealing with device initialization, would it
> make sense moving such init step before registering the netdevice? 
> 
> Cheers,
> 
> Paolo

We can't really, device has to be ready otherwise
we can't send commands to it.

-- 
MST

