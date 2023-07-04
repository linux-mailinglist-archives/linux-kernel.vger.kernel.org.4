Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D03F746E61
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjGDKR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjGDKRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:17:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFEBF1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 03:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688465787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bzKWcWNbdy1eikXjeDKW4tKRnjZxY0mHx4cUe+wcPOU=;
        b=M4YHIOoHmLszfUO3nXc0MlEfRngiI8qu410EEKu8vaOwmtCiSdJuyc6wcqHA1oroATQZCz
        kNtBTL+2R8ZLXpq8+YOEvpfi7giBcVvY9+A7RpQefXXXeGYUnFUl3/l18+waKPxSnTnt56
        jJzR1v64y22DH/WH5cyKfBDdWHXEj/Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-vzAKsQTEOcyHmLMcYOmtpg-1; Tue, 04 Jul 2023 06:16:26 -0400
X-MC-Unique: vzAKsQTEOcyHmLMcYOmtpg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fbb0fdd060so32876095e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 03:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688465785; x=1691057785;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bzKWcWNbdy1eikXjeDKW4tKRnjZxY0mHx4cUe+wcPOU=;
        b=H9XQyRrwmuF4aHrVDO2PnjOwp2B4IcrWUNrqYrhviMUqYfhTDvgI3LlNUlZsWO1VUJ
         nMSL5zFvqM+XTuBD3BUi3OWTm8vEnqgius59FiYo/9g87EQATyDub50ig2cH96tSJNDj
         rihrCvFlZzRmZBsD/sC9sq1y9jtXcTkob1wF64b15MLVspaxa75EgRwYe1o4EKY4md7i
         iTxNPCrWHLSluID3wPZc7igAMa57Pq3/iRORpdtKG9dGh4GfdTDcEZmNWS/u+QkulXJq
         1nzMdWgV2VUk/sSDOAj5EZElOE+lQXR//mFen7HYf8z+s8x/sctw1npsCz8P64SKqUl9
         enKQ==
X-Gm-Message-State: AC+VfDyanCrtIK9w9SS+Usw4st0EP4NYj3l3Q98eThMpa0hzyOTsuj3N
        0p8fjKXgrog4KUQBZNKd9XBtNneUnLP9NbsnBM1kO+Nv1F7VU05YbZ9kj+lg10aBqYTJny3MWBo
        s9a5xRduZrLkf/zY39f/w7tep
X-Received: by 2002:a05:600c:224c:b0:3fb:a5a0:6199 with SMTP id a12-20020a05600c224c00b003fba5a06199mr11644660wmm.14.1688465785729;
        Tue, 04 Jul 2023 03:16:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ48SCmk7KFv2iokhJjmfb1gPMTBckEl/OtlE7ovaKXJ62b8bGF9Sm/mxfTBvSpRedzKtf6n0Q==
X-Received: by 2002:a05:600c:224c:b0:3fb:a5a0:6199 with SMTP id a12-20020a05600c224c00b003fba5a06199mr11644649wmm.14.1688465785442;
        Tue, 04 Jul 2023 03:16:25 -0700 (PDT)
Received: from redhat.com ([2.52.13.33])
        by smtp.gmail.com with ESMTPSA id a10-20020a1cf00a000000b003f8fb02c413sm29765719wmb.8.2023.07.04.03.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 03:16:24 -0700 (PDT)
Date:   Tue, 4 Jul 2023 06:16:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        linux-kernel@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>,
        virtualization@lists.linux-foundation.org, leiyang@redhat.com,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] mlx5_vdpa: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
Message-ID: <20230704061356-mutt-send-email-mst@kernel.org>
References: <20230703142514.363256-1-eperezma@redhat.com>
 <20230703110241-mutt-send-email-mst@kernel.org>
 <ba5099b8-f72c-f267-41a7-d0ee18680796@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba5099b8-f72c-f267-41a7-d0ee18680796@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 05:26:02PM -0700, Si-Wei Liu wrote:
> 
> 
> On 7/3/2023 8:46 AM, Michael S. Tsirkin wrote:
> > On Mon, Jul 03, 2023 at 04:25:14PM +0200, Eugenio Pérez wrote:
> > > Offer this backend feature as mlx5 is compatible with it. It allows it
> > > to do live migration with CVQ, dynamically switching between passthrough
> > > and shadow virtqueue.
> > > 
> > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > Same comment.
> to which?
> 
> -Siwei

VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is too narrow a use-case to commit to it
as a kernel/userspace ABI: what if one wants to start rings in some
other specific order?
As was discussed on list, a better promise is not to access ring
until the 1st kick. vdpa can then do a kick when it wants
the device to start accessing rings.

> > 
> > > ---
> > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 9138ef2fb2c8..5f309a16b9dc 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -7,6 +7,7 @@
> > >   #include <uapi/linux/virtio_net.h>
> > >   #include <uapi/linux/virtio_ids.h>
> > >   #include <uapi/linux/vdpa.h>
> > > +#include <uapi/linux/vhost_types.h>
> > >   #include <linux/virtio_config.h>
> > >   #include <linux/auxiliary_bus.h>
> > >   #include <linux/mlx5/cq.h>
> > > @@ -2499,6 +2500,11 @@ static void unregister_link_notifier(struct mlx5_vdpa_net *ndev)
> > >   		flush_workqueue(ndev->mvdev.wq);
> > >   }
> > > +static u64 mlx5_vdpa_get_backend_features(const struct vdpa_device *vdpa)
> > > +{
> > > +	return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
> > > +}
> > > +
> > >   static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
> > >   {
> > >   	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > > @@ -3140,6 +3146,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
> > >   	.get_vq_align = mlx5_vdpa_get_vq_align,
> > >   	.get_vq_group = mlx5_vdpa_get_vq_group,
> > >   	.get_device_features = mlx5_vdpa_get_device_features,
> > > +	.get_backend_features = mlx5_vdpa_get_backend_features,
> > >   	.set_driver_features = mlx5_vdpa_set_driver_features,
> > >   	.get_driver_features = mlx5_vdpa_get_driver_features,
> > >   	.set_config_cb = mlx5_vdpa_set_config_cb,
> > > -- 
> > > 2.39.3

