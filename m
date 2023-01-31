Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97673683913
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjAaWKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjAaWKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:10:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C0D4ED8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675202964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ip7LN5t2XMU2RXyA57wD+YKH27SGyN1LXlfzY7WmEN8=;
        b=BBPnF6mUKfEMJL6UjX1e/+uBJhALsdaDmdfOLNsa52j1/NLx7g52EExXheUokucWRlj5na
        He/j07cArZm/mR5xZEsYMXbJFOt9M8V5Q1/+QDwpfFGrpUAN0+Mf8F8e1OBUcWLtGpXH8c
        tmPRvw978qJqopQOGbWJp1IWdcCRztQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-132-fSU2vE1QNYe7kmpYA-a5LQ-1; Tue, 31 Jan 2023 17:09:21 -0500
X-MC-Unique: fSU2vE1QNYe7kmpYA-a5LQ-1
Received: by mail-ed1-f71.google.com with SMTP id g14-20020a056402090e00b0046790cd9082so11528577edz.21
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ip7LN5t2XMU2RXyA57wD+YKH27SGyN1LXlfzY7WmEN8=;
        b=ZWK3jVsU4zI3paxI29c3+WYETbO3zpYviJNxXni6C/o6fhQZoJ1l6XfQykglSsg7wa
         82GMaHD931YNd3bDshgRpSpjLHNSw3sBAYuOcuYjGNqIfVlBhlQ80wWIAEb9fLFH1HKc
         cvF4ylLasImNaNkQGocHhlh70W9oZ9u5BNEmAtEb/TbV4TY6snSlYFtcd6VuPQwQ6cWk
         Y7WCs7zCIDFFpHo7Sv3cc0MGVdcgoU08OZVHKxJedUGCJLs1SCzlXXflHv6+7PBrdjF/
         gLgaEPeymCvG2zPhO5kcEMs5mBh/YKB4oso2smKLtKCJ8v8jHXu8x2cjseIjaeQ0RR5q
         chJg==
X-Gm-Message-State: AO0yUKWclKFaDzbewC+H86SzgFTQro1eIlx7+gfOkoXyzSa+PFIgw360
        xXZUvoM9q1xBq3ej03OUHxPEh/Yx5olu73XjmHedWM0kQzYOSg+UViqcbs1qrlZG4zs+ajKyKyx
        exx+aYzC+BRqfNFfXBwydMEdQ
X-Received: by 2002:a05:6402:202e:b0:4a2:449a:9498 with SMTP id ay14-20020a056402202e00b004a2449a9498mr10759868edb.31.1675202960757;
        Tue, 31 Jan 2023 14:09:20 -0800 (PST)
X-Google-Smtp-Source: AK7set8v8HniRH4JSAGTfryw69wu0KZFyBxDDgNcZStsKTfdJjHe3oeQBGrcGyuRfy7DNSiGzKJRUQ==
X-Received: by 2002:a05:6402:202e:b0:4a2:449a:9498 with SMTP id ay14-20020a056402202e00b004a2449a9498mr10759855edb.31.1675202960506;
        Tue, 31 Jan 2023 14:09:20 -0800 (PST)
Received: from redhat.com ([2.52.144.173])
        by smtp.gmail.com with ESMTPSA id a66-20020a509ec8000000b00482e0c55e2bsm889495edf.93.2023.01.31.14.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 14:09:19 -0800 (PST)
Date:   Tue, 31 Jan 2023 17:09:15 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        Cindy Lu <lulu@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
        Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH v3 2/2] virtio_net: notify MAC address change on device
 initialization
Message-ID: <20230131170908-mutt-send-email-mst@kernel.org>
References: <20230127204500.51930-1-lvivier@redhat.com>
 <20230127204500.51930-3-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127204500.51930-3-lvivier@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 09:45:00PM +0100, Laurent Vivier wrote:
> In virtnet_probe(), if the device doesn't provide a MAC address the
> driver assigns a random one.
> As we modify the MAC address we need to notify the device to allow it
> to update all the related information.
> 
> The problem can be seen with vDPA and mlx5_vdpa driver as it doesn't
> assign a MAC address by default. The virtio_net device uses a random
> MAC address (we can see it with "ip link"), but we can't ping a net
> namespace from another one using the virtio-vdpa device because the
> new MAC address has not been provided to the hardware:
> RX packets are dropped since they don't go through the receive filters,
> TX packets go through unaffected.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7d700f8e545a..704a05f1c279 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3806,6 +3806,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		eth_hw_addr_set(dev, addr);
>  	} else {
>  		eth_hw_addr_random(dev);
> +		dev_info(&vdev->dev, "Assigned random MAC address %pM\n",
> +			 dev->dev_addr);
>  	}
>  
>  	/* Set up our device-specific information */
> @@ -3933,6 +3935,24 @@ static int virtnet_probe(struct virtio_device *vdev)
>  
>  	virtio_device_ready(vdev);
>  
> +	/* a random MAC address has been assigned, notify the device.
> +	 * We don't fail probe if VIRTIO_NET_F_CTRL_MAC_ADDR is not there
> +	 * because many devices work fine without getting MAC explicitly
> +	 */
> +	if (!virtio_has_feature(vdev, VIRTIO_NET_F_MAC) &&
> +	    virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
> +		struct scatterlist sg;
> +
> +		sg_init_one(&sg, dev->dev_addr, dev->addr_len);
> +		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
> +					  VIRTIO_NET_CTRL_MAC_ADDR_SET, &sg)) {
> +			pr_debug("virtio_net: setting MAC address failed\n");
> +			rtnl_unlock();
> +			err = -EINVAL;
> +			goto free_unregister_netdev;
> +		}
> +	}
> +
>  	rtnl_unlock();
>  
>  	err = virtnet_cpu_notif_add(vi);
> -- 
> 2.39.1

