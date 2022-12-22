Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A959653B80
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 06:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiLVFDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 00:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbiLVFDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 00:03:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7821021892
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 21:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671685325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KJgJpF5xZkDorw1tYw0inGkzyUnI/sANbAPj2wEvpBo=;
        b=MzUVcbkwVu3Nr2coIuA1osSrMvDxBzUFrdlJHVhgE17N12ffIvNSNYBbcx64R/djtiSLZP
        PXKdvdO0LEXKSt4TJJK5QlWW/B+P496whrwskfcVsW1m0v5mVSTmmZGV4jNbWUc1J/1M1K
        Kg2aIrU9VDmgLzIMNDkCIRghjXRiMLY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-TcewQ6ufOUC3BWHDQLMJNg-1; Thu, 22 Dec 2022 00:01:07 -0500
X-MC-Unique: TcewQ6ufOUC3BWHDQLMJNg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A593E858F09;
        Thu, 22 Dec 2022 05:01:06 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-15.pek2.redhat.com [10.72.13.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1679F40C2004;
        Thu, 22 Dec 2022 05:01:03 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     sgarzare@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/4] vdpasim: customize allocation size
Date:   Thu, 22 Dec 2022 13:00:50 +0800
Message-Id: <20221222050052.20785-3-jasowang@redhat.com>
In-Reply-To: <20221222050052.20785-1-jasowang@redhat.com>
References: <20221222050052.20785-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow individual simulator to customize the allocation size.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 8 ++++++--
 drivers/vdpa/vdpa_sim/vdpa_sim.h     | 1 +
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 1 +
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 1 +
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 757afef86ba0..55aaa023a6e2 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -253,7 +253,10 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 	struct vdpa_device *vdpa;
 	struct vdpasim *vdpasim;
 	struct device *dev;
-	int i, ret = -ENOMEM;
+	int i, ret = -EINVAL;
+
+	if (!dev_attr->alloc_size)
+		goto err_alloc;
 
 	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
 		if (config->device_features &
@@ -268,9 +271,10 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 	else
 		ops = &vdpasim_config_ops;
 
+	ret = -ENOMEM;
 	vdpa = __vdpa_alloc_device(NULL, ops,
 				   dev_attr->ngroups, dev_attr->nas,
-				   sizeof(struct vdpasim),
+				   dev_attr->alloc_size,
 				   dev_attr->name, false);
 	if (IS_ERR(vdpa)) {
 		ret = PTR_ERR(vdpa);
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index 0e78737dcc16..51c070a543f1 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -37,6 +37,7 @@ struct vdpasim_dev_attr {
 	struct vdpa_mgmt_dev *mgmt_dev;
 	const char *name;
 	u64 supported_features;
+	size_t alloc_size;
 	size_t config_size;
 	size_t buffer_size;
 	int nvqs;
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index c6db1a1baf76..4f7c35f59aa5 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -378,6 +378,7 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	dev_attr.nvqs = VDPASIM_BLK_VQ_NUM;
 	dev_attr.ngroups = VDPASIM_BLK_GROUP_NUM;
 	dev_attr.nas = VDPASIM_BLK_AS_NUM;
+	dev_attr.alloc_size = sizeof(struct vdpasim);
 	dev_attr.config_size = sizeof(struct virtio_blk_config);
 	dev_attr.get_config = vdpasim_blk_get_config;
 	dev_attr.work_fn = vdpasim_blk_work;
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index c3cb225ea469..20cd5cdff919 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -249,6 +249,7 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	dev_attr.nvqs = VDPASIM_NET_VQ_NUM;
 	dev_attr.ngroups = VDPASIM_NET_GROUP_NUM;
 	dev_attr.nas = VDPASIM_NET_AS_NUM;
+	dev_attr.alloc_size = sizeof(struct vdpasim);
 	dev_attr.config_size = sizeof(struct virtio_net_config);
 	dev_attr.get_config = vdpasim_net_get_config;
 	dev_attr.work_fn = vdpasim_net_work;
-- 
2.25.1

