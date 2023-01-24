Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430096794FD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjAXKQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjAXKQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:16:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720FE22A16
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674555328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NFgKaLWubEk/cRokgGdvBW4gpMpmZbK+meQJanVkKO8=;
        b=Uh5Igb4WRitkY7lAkMqFHRnS9HRBU63cZJ/8cfpQrOc3amso49QleCGhbpol89o/x3f2xg
        ep849bUx5BEyMsIodAoHYMjivyACKUexGeHoeTEai6nY/Nor033wRz41GHMTGDvJUd6xBb
        BN0J9MYJX50MKCzLrfRrGk8FIp5ajzA=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-296-IJTWha2LNEaO_GTYd7cy-g-1; Tue, 24 Jan 2023 05:15:26 -0500
X-MC-Unique: IJTWha2LNEaO_GTYd7cy-g-1
Received: by mail-vs1-f70.google.com with SMTP id bm10-20020a056102510a00b003d0c2bdc78aso3498113vsb.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:15:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFgKaLWubEk/cRokgGdvBW4gpMpmZbK+meQJanVkKO8=;
        b=3OHRYbNxZRLnPbz3xEVx1Sni7vrKkeguF1st5XwlPNuMzy/aQXGL7RT3omh0AREFc4
         TQzebKUpbSQPp1Ud7FmibW76NCNsCiYcK9243zCytxBZgK6J+OgwgHO5t3ql8kWe0V40
         KMjSg6WrRnpzZiUaZS0OhWVkojdHaurlup8LmenQVePyqxqVV/ETMKK3N16BycJWwYYV
         Xd2BKsGjikXbFJ64uapLvbunJccS/pk4P2Yb7t4P+8HdCwzcS2qJlriea8a2c+fE1555
         BTWBxkiHYre8a029hhl2AvnfH+SrgTisFg0fToOkwutM+ObGa7EMsKoMhxou4uhZgiE3
         Hddw==
X-Gm-Message-State: AFqh2kpAe1B0TESnBLOIF0FB8qw/KWwDk/ciyXSZo16rBPYI2I1rVVjJ
        +jS9Q49pbXzeT7Uj9qTya/jXI3ZbwBRxYZX9v67HwE9ej8paQBpJtrSUTqWjy/B4uow+N9Eq7GL
        FJI21lCg9f9577JYyFg5V/AfH
X-Received: by 2002:a05:6102:3e08:b0:3d0:d383:72b6 with SMTP id j8-20020a0561023e0800b003d0d38372b6mr16531972vsv.11.1674555326241;
        Tue, 24 Jan 2023 02:15:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXufWDfGyzlwj9ku95BLubbEIcCLMhu58PdSNVkjhU4LwXOgwCiaQKrtaMKVEBK2ZmpgsHg/Ag==
X-Received: by 2002:a05:6102:3e08:b0:3d0:d383:72b6 with SMTP id j8-20020a0561023e0800b003d0d38372b6mr16531967vsv.11.1674555325974;
        Tue, 24 Jan 2023 02:15:25 -0800 (PST)
Received: from redhat.com ([45.144.113.7])
        by smtp.gmail.com with ESMTPSA id i1-20020ab02481000000b004199ab0d752sm112004uan.16.2023.01.24.02.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 02:15:24 -0800 (PST)
Date:   Tue, 24 Jan 2023 05:15:17 -0500
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
Message-ID: <20230124024711-mutt-send-email-mst@kernel.org>
References: <20230123120022.2364889-1-lvivier@redhat.com>
 <20230123120022.2364889-2-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123120022.2364889-2-lvivier@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 01:00:22PM +0100, Laurent Vivier wrote:
> In virtnet_probe(), if the device doesn't provide a MAC address the
> driver assigns a random one.
> As we modify the MAC address we need to notify the device to allow it
> to update all the related information.
> 
> The problem can be seen with vDPA and mlx5_vdpa driver as it doesn't
> assign a MAC address by default. The virtio_net device uses a random
> MAC address (we can see it with "ip link"), but we can't ping a net
> namespace from another one using the virtio-vdpa device because the
> new MAC address has not been provided to the hardware.

And then what exactly happens? Does hardware drop the outgoing
or the incoming packets? Pls include in the commit log.

> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  drivers/net/virtio_net.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7723b2a49d8e..4bdc8286678b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3800,6 +3800,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		eth_hw_addr_set(dev, addr);
>  	} else {
>  		eth_hw_addr_random(dev);
> +		dev_info(&vdev->dev, "Assigned random MAC address %pM\n",
> +			 dev->dev_addr);
>  	}
>  
>  	/* Set up our device-specific information */
> @@ -3956,6 +3958,18 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	pr_debug("virtnet: registered device %s with %d RX and TX vq's\n",
>  		 dev->name, max_queue_pairs);
>  
> +	/* a random MAC address has been assigned, notify the device */
> +	if (!virtio_has_feature(vdev, VIRTIO_NET_F_MAC) &&
> +	    virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {

Maybe add a comment explaining that we don't fail probe if
VIRTIO_NET_F_CTRL_MAC_ADDR is not there because
many devices work fine without getting MAC explicitly.

> +		struct scatterlist sg;
> +
> +		sg_init_one(&sg, dev->dev_addr, dev->addr_len);
> +		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
> +					  VIRTIO_NET_CTRL_MAC_ADDR_SET, &sg)) {
> +			dev_warn(&vdev->dev, "Failed to update MAC address.\n");

Here, I'm not sure we want to proceed. Is it useful sometimes?
I note that we deny with virtnet_set_mac_address.

> +		}
> +	}
> +
>  	return 0;



Also, some code duplication with virtnet_set_mac_address here.

Also:
	When using the legacy interface, \field{mac} is driver-writable
	which provided a way for drivers to update the MAC without
	negotiating VIRTIO_NET_F_CTRL_MAC_ADDR.

How about factoring out code in virtnet_set_mac_address
and reusing that?


This will also handle corner cases such as VIRTIO_NET_F_STANDBY
which are not currently addressed.


>  free_unregister_netdev:
> -- 
> 2.39.0

