Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F410E74600E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjGCPrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGCPrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:47:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FD1C2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688399185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1NZ1ljPvaJ3lSN+5NzJxss1L8wbkM12/fOlYD41I+hs=;
        b=PtTctG/1ez7VXREMouolHSd2PlD6Se30N7Op8DdJPfxgP5bBxBJzvcIVFov6OwZnLzcfnC
        4m07LnGtsvLHbgS2y/RgfnruLPqzaPRu9JR+/ZWrUPw+aLXVDzh3l0DnUmgZbZxk7JFbWU
        d4a3vNk7sFXUPRDMF3bEAuHkMrSFy7c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-VKdiPzkJPaWf69V_Z3t0Ig-1; Mon, 03 Jul 2023 11:46:24 -0400
X-MC-Unique: VKdiPzkJPaWf69V_Z3t0Ig-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30e4943ca7fso2301800f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 08:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688399183; x=1690991183;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1NZ1ljPvaJ3lSN+5NzJxss1L8wbkM12/fOlYD41I+hs=;
        b=YBqMyoJ1d48QidvRvbd1FoV4RTX9jlnoEA0ouBkV/k33ZIUhFbZz1UkguEymtiioW9
         0q7LK8di1pMBoUsuvdedjIRv3nwK7DziisVXnvSrgwNAPFRu1YvdscWe0COg5hPRU/n1
         D7nDN1f3b4EKJ9Eh8qRQVHjObrhekrWMR2X2XW/j6Xim8yJqk5jY+9B3dFah2GiMkYzL
         m4OdGdcYGW2MKKL4FxcApFaOpyLRg9DCf4DoK5djGp09V6UGVtr2NK50L+jzrj/Lkv+o
         nBg7I2xIYXOTOgq3tcs6UB/YW8nsJ/M014p+AcNq7JMd2wz1fQCpugjY550X0a5OTVRh
         SYsQ==
X-Gm-Message-State: ABy/qLayG3EGCyX7u5t10F0vjp0Jxj2tOoZLoAPCnsLt1piCqbkXURz8
        H5iATg61/V92ZJ/FVTd/GzsLWOeWp6fs7pRyEzBS2IWppoEjHUFbfMHCdY1VjL37DACxE3ofxYx
        E1wKMDtIzGZ//nyLsi+nqTdzk
X-Received: by 2002:a5d:6b51:0:b0:314:2ff2:b051 with SMTP id x17-20020a5d6b51000000b003142ff2b051mr4571363wrw.41.1688399183196;
        Mon, 03 Jul 2023 08:46:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGx6h38T6vXWijoWHBefYK9XvHRwTUZinS5fxcyNS70iY6BvXvn5QbTff33EKlYWUaKf1dIJA==
X-Received: by 2002:a5d:6b51:0:b0:314:2ff2:b051 with SMTP id x17-20020a5d6b51000000b003142ff2b051mr4571342wrw.41.1688399182846;
        Mon, 03 Jul 2023 08:46:22 -0700 (PDT)
Received: from redhat.com ([2.52.13.33])
        by smtp.gmail.com with ESMTPSA id c13-20020adfe74d000000b0030ae499da59sm10816007wrn.111.2023.07.03.08.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 08:46:22 -0700 (PDT)
Date:   Mon, 3 Jul 2023 11:46:18 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>,
        virtualization@lists.linux-foundation.org, leiyang@redhat.com,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] mlx5_vdpa: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
Message-ID: <20230703110241-mutt-send-email-mst@kernel.org>
References: <20230703142514.363256-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230703142514.363256-1-eperezma@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 04:25:14PM +0200, Eugenio Pérez wrote:
> Offer this backend feature as mlx5 is compatible with it. It allows it
> to do live migration with CVQ, dynamically switching between passthrough
> and shadow virtqueue.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>

Same comment.

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 9138ef2fb2c8..5f309a16b9dc 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -7,6 +7,7 @@
>  #include <uapi/linux/virtio_net.h>
>  #include <uapi/linux/virtio_ids.h>
>  #include <uapi/linux/vdpa.h>
> +#include <uapi/linux/vhost_types.h>
>  #include <linux/virtio_config.h>
>  #include <linux/auxiliary_bus.h>
>  #include <linux/mlx5/cq.h>
> @@ -2499,6 +2500,11 @@ static void unregister_link_notifier(struct mlx5_vdpa_net *ndev)
>  		flush_workqueue(ndev->mvdev.wq);
>  }
>  
> +static u64 mlx5_vdpa_get_backend_features(const struct vdpa_device *vdpa)
> +{
> +	return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
> +}
> +
>  static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
>  {
>  	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> @@ -3140,6 +3146,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
>  	.get_vq_align = mlx5_vdpa_get_vq_align,
>  	.get_vq_group = mlx5_vdpa_get_vq_group,
>  	.get_device_features = mlx5_vdpa_get_device_features,
> +	.get_backend_features = mlx5_vdpa_get_backend_features,
>  	.set_driver_features = mlx5_vdpa_set_driver_features,
>  	.get_driver_features = mlx5_vdpa_get_driver_features,
>  	.set_config_cb = mlx5_vdpa_set_config_cb,
> -- 
> 2.39.3

