Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5382E637253
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 07:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiKXGYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 01:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKXGYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:24:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E22F391F1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 22:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669270999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bH5r1DTPkPYQR0htLjtLo5pkCkq5AEtL+jOtp/FRJ5o=;
        b=Xv7RT1BlubWiT7yo30Bqn6HwUV5ZUpZ1N4k4EY4EzP3b6mUpZvxbg58v0cy/jgvb3uUOxR
        607Go4kD7ZnvNFbjrZPxrVsJCzmJRKxtpX2c8tLjgZ/vUakHGIVDFe9OL3N+hirkhMGD0R
        dugXRCQ74CoFD/WuW5ipaax6Kx5FrUc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-SqTPytWqMUmF7_aVyzjx5A-1; Thu, 24 Nov 2022 01:23:15 -0500
X-MC-Unique: SqTPytWqMUmF7_aVyzjx5A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7811E1C06ECB;
        Thu, 24 Nov 2022 06:23:15 +0000 (UTC)
Received: from server.redhat.com (ovpn-12-152.pek2.redhat.com [10.72.12.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EB3B40C206B;
        Thu, 24 Nov 2022 06:23:12 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, lulu@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vhost_vdpa: fix the crash in unmap a large memory
Date:   Thu, 24 Nov 2022 14:23:09 +0800
Message-Id: <20221124062309.2081720-1-lulu@redhat.com>
MIME-Version: 1.0
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

While testing in vIOMMU, sometimes guest will unmap very large memory,
which will cause the crash. To fix this,Move the iommu_unmap to
vhost_vdpa_pa_unmap/vhost_vdpa_va_unmap and only unmap the memory
that saved in iotlb.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vdpa.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 166044642fd5..c392979702cf 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -692,6 +692,8 @@ static void vhost_vdpa_pa_unmap(struct vhost_vdpa *v,
 	struct vhost_iotlb_map *map;
 	struct page *page;
 	unsigned long pfn, pinned;
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
 
 	while ((map = vhost_iotlb_itree_first(iotlb, start, last)) != NULL) {
 		pinned = PFN_DOWN(map->size);
@@ -703,6 +705,8 @@ static void vhost_vdpa_pa_unmap(struct vhost_vdpa *v,
 			unpin_user_page(page);
 		}
 		atomic64_sub(PFN_DOWN(map->size), &dev->mm->pinned_vm);
+		if ((ops->dma_map == NULL) && (ops->set_map == NULL))
+			iommu_unmap(v->domain, map->start, map->size);
 		vhost_iotlb_map_free(iotlb, map);
 	}
 }
@@ -713,11 +717,15 @@ static void vhost_vdpa_va_unmap(struct vhost_vdpa *v,
 {
 	struct vhost_iotlb_map *map;
 	struct vdpa_map_file *map_file;
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
 
 	while ((map = vhost_iotlb_itree_first(iotlb, start, last)) != NULL) {
 		map_file = (struct vdpa_map_file *)map->opaque;
 		fput(map_file->file);
 		kfree(map_file);
+		if ((ops->dma_map == NULL) && (ops->set_map == NULL))
+			iommu_unmap(v->domain, map->start, map->size);
 		vhost_iotlb_map_free(iotlb, map);
 	}
 }
@@ -805,8 +813,6 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v,
 	} else if (ops->set_map) {
 		if (!v->in_batch)
 			ops->set_map(vdpa, asid, iotlb);
-	} else {
-		iommu_unmap(v->domain, iova, size);
 	}
 
 	/* If we are in the middle of batch processing, delay the free
-- 
2.34.3

