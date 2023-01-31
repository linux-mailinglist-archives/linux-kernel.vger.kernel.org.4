Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39AD683915
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjAaWKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjAaWK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:10:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F24B1710
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675202977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b+EInBavO8bUQmbkFuSQwUsNVOCGCJTbOtt6tsAhifI=;
        b=HeDM7iOZ2sQe5BEaxp/NSpE15JyY17OyQkkytebjzwyhGC4DBzxpIX0XVkNpuwut18CIZX
        FR+0RJT6J/RohVL8XeIMAdH0KuKi1z5L7crdMFY2uuB+X5IKlynaejKHRzDkWoe4kyqyaS
        yFIODFaJBkLFdPVP8koVCGkyNjbDhjw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-495-PyRjq9FPN7i8VGBr47szxQ-1; Tue, 31 Jan 2023 17:09:36 -0500
X-MC-Unique: PyRjq9FPN7i8VGBr47szxQ-1
Received: by mail-ed1-f71.google.com with SMTP id s3-20020a50ab03000000b0049ec3a108beso11451057edc.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:09:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+EInBavO8bUQmbkFuSQwUsNVOCGCJTbOtt6tsAhifI=;
        b=hWmStwhy4/sPGukvnWSzkoj32BiCc2By5lW2RV+aGopu8B6NUaiIapFcr3zJIrZkqZ
         /XrgAixHyuk7M4yqEn14YoSyuGiATwKvOFJ/9zfcmex1mT44QRjknsLj6mriXeWgtx+3
         3MDV1YvKOufBAzzeBZsjnHFuXhpzuD0BRHd1xG9SGCt9X9Xp5xM4kQ0BGFFpdRouIz8L
         RteH4QtWMVtVmxNKYUs+Z4iPNNm3ehE5gByKLyZ9sXUvtjjC6LCLT1zXWOwMhuUxpgqH
         ukwjzw6EkPGyXGaY5kXURnFNdcDRvqKBeKKSayiCPbm55feeIJArPqfK9qzIAUOEnPWb
         sfkw==
X-Gm-Message-State: AO0yUKVEqMGcy1o6gVSzzIRLfzSDcBAbpupTiPfOyHsYrKkpkllAyCBY
        3ed+ZbbDS8nhGIw8LhzCQVs3f7gvPTLRxartbICoHm6i4VggFKYwJ7cJljvG5e/0iiAzSslBI4x
        0UPEbHd6YT4+sLVAJ4sVxw7+J
X-Received: by 2002:a17:907:7e9e:b0:878:5c22:6e03 with SMTP id qb30-20020a1709077e9e00b008785c226e03mr6070816ejc.73.1675202975367;
        Tue, 31 Jan 2023 14:09:35 -0800 (PST)
X-Google-Smtp-Source: AK7set/umuCR+3IZE7Li+5UeArJ7g88Vg8CTJWN7CwjHLCAHc+Y5XBZ1wpIH1VghWcytadpuSByN2w==
X-Received: by 2002:a17:907:7e9e:b0:878:5c22:6e03 with SMTP id qb30-20020a1709077e9e00b008785c226e03mr6070806ejc.73.1675202975121;
        Tue, 31 Jan 2023 14:09:35 -0800 (PST)
Received: from redhat.com ([2.52.144.173])
        by smtp.gmail.com with ESMTPSA id d23-20020a1709063ed700b0088d0b51f056sm818204ejj.40.2023.01.31.14.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 14:09:34 -0800 (PST)
Date:   Tue, 31 Jan 2023 17:09:30 -0500
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
Subject: Re: [PATCH v3 1/2] virtio_net: disable VIRTIO_NET_F_STANDBY if
 VIRTIO_NET_F_MAC is not set
Message-ID: <20230131170923-mutt-send-email-mst@kernel.org>
References: <20230127204500.51930-1-lvivier@redhat.com>
 <20230127204500.51930-2-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127204500.51930-2-lvivier@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 09:44:59PM +0100, Laurent Vivier wrote:
> failover relies on the MAC address to pair the primary and the standby
> devices:
> 
>   "[...] the hypervisor needs to enable VIRTIO_NET_F_STANDBY
>    feature on the virtio-net interface and assign the same MAC address
>    to both virtio-net and VF interfaces."
> 
>   Documentation/networking/net_failover.rst
> 
> This patch disables the STANDBY feature if the MAC address is not
> provided by the hypervisor.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7723b2a49d8e..7d700f8e545a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3688,6 +3688,12 @@ static int virtnet_validate(struct virtio_device *vdev)
>  			__virtio_clear_bit(vdev, VIRTIO_NET_F_MTU);
>  	}
>  
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_STANDBY) &&
> +	    !virtio_has_feature(vdev, VIRTIO_NET_F_MAC)) {
> +		dev_warn(&vdev->dev, "device advertises feature VIRTIO_NET_F_STANDBY but not VIRTIO_NET_F_MAC, disabling standby");
> +		__virtio_clear_bit(vdev, VIRTIO_NET_F_STANDBY);
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.39.1

