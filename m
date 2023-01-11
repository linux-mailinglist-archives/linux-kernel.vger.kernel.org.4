Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1036665498
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 07:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbjAKG3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 01:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjAKG3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 01:29:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C9C6376
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 22:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673418511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hZckiIF9GKaRv3ubvyyEtlLgDTx5PNnpA2vEzhFHbOU=;
        b=LuPlvOY0KuHe/Vt3AEb7etGK1dFN1k0m5nOX4eBUbH5bUYXL7LhjgHYlAz1zOUzD7TXNm3
        Hz21ZiF/hx5Cbd3rCXpynQsm6av74XxT85BY9s7YbxpHWAadb3Ti265xzt7r4gyokeAAsi
        GpIjywyKoaxHBPjvXTZNu5ftobA214k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-KCRmC12MPgyLAFenQKKLJw-1; Wed, 11 Jan 2023 01:28:28 -0500
X-MC-Unique: KCRmC12MPgyLAFenQKKLJw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DCD187B2A0;
        Wed, 11 Jan 2023 06:28:27 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-175.pek2.redhat.com [10.72.13.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90A174078903;
        Wed, 11 Jan 2023 06:28:22 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     elic@nvidia.com, gdawar@amd.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, tanuj.kamde@amd.com
Subject: [PATCH 3/5] virtio-vdpa: support per vq dma device
Date:   Wed, 11 Jan 2023 14:28:07 +0800
Message-Id: <20230111062809.25020-4-jasowang@redhat.com>
In-Reply-To: <20230111062809.25020-1-jasowang@redhat.com>
References: <20230111062809.25020-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

