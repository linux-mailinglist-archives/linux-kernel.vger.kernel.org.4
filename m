Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F9A5F439C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJDMxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJDMx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:53:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF1C42AC2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 05:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664887800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JJvrLZKz0phQwFOn8zjOvRDgek7efPzkS0daCUrrFmc=;
        b=Q9vFXtCa8i6E+j2TxlkN+YCCveCSNDplbRKo7h/xss5BQ7p7fLTicHjmLE3gF1OV8J4iXk
        nFAQcfx7DyFQ6dQqrwiQdPWJaW3B0MD0imlGpN4jHelEJOy4y5YyUQgIT/+qQBMbaqAqkt
        asYHKF3ilEoP4jAfBtVrdFekWWYnoLE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-32-EZODzIWRNAO1YtujBoc3XA-1; Tue, 04 Oct 2022 08:46:33 -0400
X-MC-Unique: EZODzIWRNAO1YtujBoc3XA-1
Received: by mail-wm1-f71.google.com with SMTP id c2-20020a1c3502000000b003b535aacc0bso10844844wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 05:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JJvrLZKz0phQwFOn8zjOvRDgek7efPzkS0daCUrrFmc=;
        b=cjfGmPvvsMrBv4pWyDMN9Kux/zl1XlQbSHECkqA2TxMGrgq82dtPpXyAgl2uaxNwGW
         Q0F//HvV7Tifh9IDGqQMzJuKD4PzSguH8P9VsuGHjFnlyWoG82YXNznqzrEKf/1jtC5z
         u6V4/frRDH7Wwe8gCd0MqgdmySBZJokhT8S5pZZLUqwJQF563Rsl1pKn29TxlyxBQQxX
         eM8OQa4FvjvsM5SqJsQ+gTtKWbBXRQFBigpL0BOmQUktWBMwv5VjYxWWd6rQwPQH2R82
         Y7bT5EsV88aeT79DWLlOsXme7JUYTTzfxYguKNk5ym8yPJDRmYx2PWMa/DBscAyUGbxE
         FCGg==
X-Gm-Message-State: ACrzQf2h/J4wuYZiwP8C58AR4MXd0pR5Xl1cteE6+4IjOaBGzTeNuoz0
        0zplX+VpdiHEb4RWRWjPTGIwaFWlCQEOXBYyrvN0f1Z75vqDhVMM1fnhy+Su9gyU4jGFj26PGk5
        LfmcfjQHKS6fSfyZeRvxhtV++
X-Received: by 2002:a1c:cc0e:0:b0:3b4:fda3:c808 with SMTP id h14-20020a1ccc0e000000b003b4fda3c808mr9618074wmb.146.1664887592204;
        Tue, 04 Oct 2022 05:46:32 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM51E0gqiu5xGN8S9QHKYQamo7K0r0vQ71EXRG9rAv/r6jmXMF09GeYKvE5nbQP5TWLg+iOPGw==
X-Received: by 2002:a1c:cc0e:0:b0:3b4:fda3:c808 with SMTP id h14-20020a1ccc0e000000b003b4fda3c808mr9618057wmb.146.1664887591991;
        Tue, 04 Oct 2022 05:46:31 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-222.retail.telecomitalia.it. [79.46.200.222])
        by smtp.gmail.com with ESMTPSA id n189-20020a1ca4c6000000b003a8434530bbsm569911wme.13.2022.10.04.05.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 05:46:27 -0700 (PDT)
Date:   Tue, 4 Oct 2022 14:46:22 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, elic@nvidia.com, si-wei.liu@oracle.com,
        parav@nvidia.com, wuzongyong@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, eperezma@redhat.com,
        lingshan.zhu@intel.com, gdawar@xilinx.com, lulu@redhat.com,
        xieyongji@bytedance.com
Subject: Re: [PATCH V3 2/3] vdpa_sim_net: support feature provisioning
Message-ID: <20221004124622.75w7zt2pfvy5oph3@sgarzare-redhat>
References: <20220927074810.28627-1-jasowang@redhat.com>
 <20220927074810.28627-3-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220927074810.28627-3-jasowang@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:48:09PM +0800, Jason Wang wrote:
>This patch implements features provisioning for vdpa_sim_net.
>
>1) validating the provisioned features to be a subset of the parent
>   features.
>2) clearing the features that is not wanted by the userspace
>
>For example:
>
># vdpa mgmtdev show
>vdpasim_net:
>  supported_classes net
>  max_supported_vqs 3
>  dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
>
>1) provision vDPA device with all features that are supported by the
>   net simulator
>
># vdpa dev add name dev1 mgmtdev vdpasim_net
># vdpa dev config show
>dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
>  negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
>
>2) provision vDPA device with a subset of the features
>
># vdpa dev add name dev1 mgmtdev vdpasim_net device_features 0x300020000
># vdpa dev config show
>dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
>  negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
>
>Reviewed-by: Eli Cohen <elic@nvidia.com>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c     | 12 +++++++++++-
> drivers/vdpa/vdpa_sim/vdpa_sim.h     |  3 ++-
> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  2 +-
> drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  5 +++--
> 4 files changed, 17 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index 225b7f5d8be3..b071f0d842fb 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -18,6 +18,7 @@
> #include <linux/vdpa.h>
> #include <linux/vhost_iotlb.h>
> #include <linux/iova.h>
>+#include <uapi/linux/vdpa.h>
>
> #include "vdpa_sim.h"
>
>@@ -245,13 +246,22 @@ static const struct dma_map_ops vdpasim_dma_ops = {
> static const struct vdpa_config_ops vdpasim_config_ops;
> static const struct vdpa_config_ops vdpasim_batch_config_ops;
>
>-struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
>+struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
>+			       const struct vdpa_dev_set_config *config)
> {
> 	const struct vdpa_config_ops *ops;
> 	struct vdpasim *vdpasim;
> 	struct device *dev;
> 	int i, ret = -ENOMEM;
>
>+	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
>+		if (config->device_features &
>+		    ~dev_attr->supported_features)
>+			return ERR_PTR(-EINVAL);
>+		dev_attr->supported_features =
>+			config->device_features;
>+	}
>+
> 	if (batch_mapping)
> 		ops = &vdpasim_batch_config_ops;
> 	else
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>index 061986f30911..0e78737dcc16 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>@@ -71,7 +71,8 @@ struct vdpasim {
> 	spinlock_t iommu_lock;
> };
>
>-struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr);
>+struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr,
>+			       const struct vdpa_dev_set_config *config);
>
> /* TODO: cross-endian support */
> static inline bool vdpasim_is_little_endian(struct vdpasim *vdpasim)
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>index c8bfea3b7db2..c6db1a1baf76 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>@@ -383,7 +383,7 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> 	dev_attr.work_fn = vdpasim_blk_work;
> 	dev_attr.buffer_size = VDPASIM_BLK_CAPACITY << SECTOR_SHIFT;
>
>-	simdev = vdpasim_create(&dev_attr);
>+	simdev = vdpasim_create(&dev_attr, config);
> 	if (IS_ERR(simdev))
> 		return PTR_ERR(simdev);
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>index 886449e88502..c3cb225ea469 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>@@ -254,7 +254,7 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> 	dev_attr.work_fn = vdpasim_net_work;
> 	dev_attr.buffer_size = PAGE_SIZE;
>
>-	simdev = vdpasim_create(&dev_attr);
>+	simdev = vdpasim_create(&dev_attr, config);
> 	if (IS_ERR(simdev))
> 		return PTR_ERR(simdev);
>
>@@ -294,7 +294,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
> 	.id_table = id_table,
> 	.ops = &vdpasim_net_mgmtdev_ops,
> 	.config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
>-			     1 << VDPA_ATTR_DEV_NET_CFG_MTU),
>+			     1 << VDPA_ATTR_DEV_NET_CFG_MTU |
>+		             1 << VDPA_ATTR_DEV_FEATURES),
> 	.max_supported_vqs = VDPASIM_NET_VQ_NUM,
> 	.supported_features = VDPASIM_NET_FEATURES,
> };
>-- 
>2.25.1
>

Fine for me:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

I'll send a followup to enable VDPA_ATTR_DEV_FEATURES in vdpa_sim_blk 
and test it.

Thanks,
Stefano

