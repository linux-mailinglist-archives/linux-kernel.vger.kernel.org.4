Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE626531D2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiLUNb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiLUNbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:31:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723E2261C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 05:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671629433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p11WT9SHFSvh+pLhF3giJuzfy7F8C5mDBl42ACj58zk=;
        b=YGO8QxnVsNA/b6SSBUYBjmhyCaBL/i2DpXMDebIWPU+a8kbX04A18Fz87/9P+f32IQ3OHy
        iPCgfxluhmk+uaEEcTaZsVohdohZLIajVHPbl8W3+9QfEuS1Bdt6CHmBu11H6SVqfaXred
        X14AG5f2zb9BXNVVh6VbQC+iA1dYaSw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-284-QrwWdjjGNe-q25bkLjVnUw-1; Wed, 21 Dec 2022 08:30:32 -0500
X-MC-Unique: QrwWdjjGNe-q25bkLjVnUw-1
Received: by mail-wm1-f70.google.com with SMTP id v192-20020a1cacc9000000b003d21fa95c38so5795490wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 05:30:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p11WT9SHFSvh+pLhF3giJuzfy7F8C5mDBl42ACj58zk=;
        b=5aHbX0723QvKrYqQK3XJuFnTkzqEBzqqxtVNRKYDGAmMWuQ3vvsPkpChodKx/8CwF8
         7yCiBvBIpVYvxWYxUGE5h1iHZY6W4wIdy9DCZeKc4L8MswRjd5AzIcvnKbMOH56GzMaa
         ssVVHI4lkCagRqZBQhcP+EzQL5eR8dXQYD1EVe6L+q1yvprtJ6lSs1dLdohC0bkCQKpy
         TBlAGttcRY5ahQ0GjJx1luLtqV9jVwqoe3WoClyPPoe8xZ9NMHEgbJ7xLq8PNAQnrCh2
         AaDCy6aI2JJfZlDjbAaGH0uEnFISDdk9DKurDmrSBLJKVKaBmf6xKzs2vvoxxuVKcEti
         UdFA==
X-Gm-Message-State: AFqh2krF5ZUaiHL2UZFlsm6CrXFucPhXSLRjrnUirGZ5aorq5o2uP9bF
        vOSziqVxQ01YZfdC+6T3uVVu5rGZqAZL1kKSWVO2kIRVoHBtfCky+6Lr5UkdgKBRpVj8zVrXDY5
        w+7IBjzhvxXqG6SlQ3jBD6tZ3
X-Received: by 2002:a05:600c:1ca3:b0:3d3:591a:bfda with SMTP id k35-20020a05600c1ca300b003d3591abfdamr4424476wms.27.1671629431181;
        Wed, 21 Dec 2022 05:30:31 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsULzzA9YymQGBk+iu3JSiAAOfBNlbM51hkbQHaxtaZYduUmpvhXY78qauYUuCi2nQrLl/7Lg==
X-Received: by 2002:a05:600c:1ca3:b0:3d3:591a:bfda with SMTP id k35-20020a05600c1ca300b003d3591abfdamr4424463wms.27.1671629430942;
        Wed, 21 Dec 2022 05:30:30 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it. [87.11.6.51])
        by smtp.gmail.com with ESMTPSA id b19-20020a05600c4e1300b003a3170a7af9sm2437071wmq.4.2022.12.21.05.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 05:30:30 -0800 (PST)
Date:   Wed, 21 Dec 2022 14:30:26 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] vdpasim: customize allocation size
Message-ID: <20221221133026.s56fitht7dx4n3lo@sgarzare-redhat>
References: <20221221061652.15202-1-jasowang@redhat.com>
 <20221221061652.15202-3-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221221061652.15202-3-jasowang@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 02:16:50PM +0800, Jason Wang wrote:
>Allow individual simulator to customize the allocation size.
>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c     | 8 ++++++--
> drivers/vdpa/vdpa_sim/vdpa_sim.h     | 1 +
> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 1 +
> drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 1 +
> 4 files changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index 757afef86ba0..55aaa023a6e2 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -253,7 +253,10 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> 	struct vdpa_device *vdpa;
> 	struct vdpasim *vdpasim;
> 	struct device *dev;
>-	int i, ret = -ENOMEM;
>+	int i, ret = -EINVAL;
>+
>+	if (!dev_attr->alloc_size)
>+		goto err_alloc;
>
> 	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> 		if (config->device_features &
>@@ -268,9 +271,10 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> 	else
> 		ops = &vdpasim_config_ops;
>
>+	ret = -ENOMEM;
> 	vdpa = __vdpa_alloc_device(NULL, ops,
> 				   dev_attr->ngroups, dev_attr->nas,
>-				   sizeof(struct vdpasim),
>+				   dev_attr->alloc_size,
> 				   dev_attr->name, false);
> 	if (IS_ERR(vdpa)) {
> 		ret = PTR_ERR(vdpa);
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>index 0e78737dcc16..51c070a543f1 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>@@ -37,6 +37,7 @@ struct vdpasim_dev_attr {
> 	struct vdpa_mgmt_dev *mgmt_dev;
> 	const char *name;
> 	u64 supported_features;
>+	size_t alloc_size;
> 	size_t config_size;
> 	size_t buffer_size;
> 	int nvqs;
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>index c6db1a1baf76..4f7c35f59aa5 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>@@ -378,6 +378,7 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> 	dev_attr.nvqs = VDPASIM_BLK_VQ_NUM;
> 	dev_attr.ngroups = VDPASIM_BLK_GROUP_NUM;
> 	dev_attr.nas = VDPASIM_BLK_AS_NUM;
>+	dev_attr.alloc_size = sizeof(struct vdpasim);
> 	dev_attr.config_size = sizeof(struct virtio_blk_config);
> 	dev_attr.get_config = vdpasim_blk_get_config;
> 	dev_attr.work_fn = vdpasim_blk_work;
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>index c3cb225ea469..20cd5cdff919 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>@@ -249,6 +249,7 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> 	dev_attr.nvqs = VDPASIM_NET_VQ_NUM;
> 	dev_attr.ngroups = VDPASIM_NET_GROUP_NUM;
> 	dev_attr.nas = VDPASIM_NET_AS_NUM;
>+	dev_attr.alloc_size = sizeof(struct vdpasim);
> 	dev_attr.config_size = sizeof(struct virtio_net_config);
> 	dev_attr.get_config = vdpasim_net_get_config;
> 	dev_attr.work_fn = vdpasim_net_work;
>-- 
>2.25.1
>

