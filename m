Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F396731AB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 07:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjASGQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 01:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjASGQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 01:16:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0BEE3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 22:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674108949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bCPNv1jA64AAqs6kIoQB13LtER9mryXWXv7FUgbd/1w=;
        b=dgTpjS9ILGDldWi5dptAH8ElphiNNHDpys8rhkbQDnp4/AUVBo+7v0CqD369pIDFwdGHIA
        hCrqzwW3umfCAAumFVnvo3BTRwdf9atmcujHAmPt9Q1TSiVsohd5YK76mT66f6jABDZFo0
        MwYolitof/xVHWriYDx4THlA7MNbCBQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-B1gWfFU9MPStkjrxEx4H-g-1; Thu, 19 Jan 2023 01:15:45 -0500
X-MC-Unique: B1gWfFU9MPStkjrxEx4H-g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 942498A0100;
        Thu, 19 Jan 2023 06:15:45 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-97.pek2.redhat.com [10.72.13.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31C881121315;
        Thu, 19 Jan 2023 06:15:41 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     elic@nvidia.com, gdawar@amd.com, tanuj.kamde@amd.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH V2 3/5] virtio-vdpa: support per vq dma device
Date:   Thu, 19 Jan 2023 14:15:23 +0800
Message-Id: <20230119061525.75068-4-jasowang@redhat.com>
In-Reply-To: <20230119061525.75068-1-jasowang@redhat.com>
References: <20230119061525.75068-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the support of per vq dma device for virito-vDPA. vDPA
parents then are allowed to use different DMA devices. This is useful
for the parents that have software or emulated virtqueues.

Reviewed-by: Eli Cohen <elic@nvidia.com>
Tested-by: Eli Cohen <elic@nvidia.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_vdpa.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 9670cc79371d..d7f5af62ddaa 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -135,6 +135,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 {
 	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
+	struct device *dma_dev;
 	const struct vdpa_config_ops *ops = vdpa->config;
 	struct virtio_vdpa_vq_info *info;
 	struct vdpa_callback cb;
@@ -175,9 +176,15 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 
 	/* Create the vring */
 	align = ops->get_vq_align(vdpa);
-	vq = vring_create_virtqueue(index, max_num, align, vdev,
-				    true, may_reduce_num, ctx,
-				    virtio_vdpa_notify, callback, name);
+
+	if (ops->get_vq_dma_dev)
+		dma_dev = ops->get_vq_dma_dev(vdpa, index);
+	else
+		dma_dev = vdpa_get_dma_dev(vdpa);
+	vq = vring_create_virtqueue_dma(index, max_num, align, vdev,
+					true, may_reduce_num, ctx,
+					virtio_vdpa_notify, callback,
+					name, dma_dev);
 	if (!vq) {
 		err = -ENOMEM;
 		goto error_new_virtqueue;
-- 
2.25.1

