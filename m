Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DEA740A94
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjF1IHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52113 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232381AbjF1ICI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687939278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vm8YdVuG5g/R4Upgn7ExptiiekTMB39MDE6nGXwwg5I=;
        b=VjQCD5ww+atNz7E0gkOSJimMS+f4FzL+KHIZTPOn5kqIvhrMthos20OyL1sKlV6XApFywx
        kn1BpotXG/445D5kwN32zmafAcJpRRr9gBfQh/GWnuyFUCK63OEjaxzYXrAOYBkEh6+XSB
        aUHF86FmaT9lQrcGcFIQ9vO88WUA8Ls=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-wEAlpELWNdCfebbpAG2Kmg-1; Wed, 28 Jun 2023 02:59:39 -0400
X-MC-Unique: wEAlpELWNdCfebbpAG2Kmg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 379003C025C7;
        Wed, 28 Jun 2023 06:59:39 +0000 (UTC)
Received: from server.redhat.com (ovpn-13-142.pek2.redhat.com [10.72.13.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A62E0492B02;
        Wed, 28 Jun 2023 06:59:35 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        maxime.coquelin@redhat.com, xieyongji@bytedance.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [RFC 3/4] vduse: Add the function for get/free the mapp pages
Date:   Wed, 28 Jun 2023 14:59:18 +0800
Message-Id: <20230628065919.54042-4-lulu@redhat.com>
In-Reply-To: <20230628065919.54042-1-lulu@redhat.com>
References: <20230628065919.54042-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Your Name <you@example.com>

Add the function for get/free pages, ad this info
will saved in dev->reconnect_info

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 35 ++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 1b833bf0ae37..3df1256eccb4 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1313,6 +1313,35 @@ static struct vduse_dev *vduse_dev_get_from_minor(int minor)
 	return dev;
 }
 
+int vduse_get_vq_reconnnect(struct vduse_dev *dev, u16 idx)
+{
+	struct vdpa_reconnect_info *area;
+	void *addr = (void *)get_zeroed_page(GFP_KERNEL);
+
+	area = &dev->reconnect_info[idx];
+
+	area->addr = virt_to_phys(addr);
+	area->vaddr = (unsigned long)addr;
+	area->size = PAGE_SIZE;
+	area->index = idx;
+
+	return 0;
+}
+
+int vduse_free_vq_reconnnect(struct vduse_dev *dev, u16 idx)
+{
+	struct vdpa_reconnect_info *area;
+
+	area = &dev->reconnect_info[idx];
+	if ((area->size == PAGE_SIZE) && (area->addr != NULL)) {
+		free_page(area->vaddr);
+		area->size = 0;
+		area->addr = 0;
+		area->vaddr = 0;
+	}
+
+	return 0;
+}
 
 static vm_fault_t vduse_vm_fault(struct vm_fault *vmf)
 {
@@ -1446,6 +1475,10 @@ static int vduse_destroy_dev(char *name)
 		mutex_unlock(&dev->lock);
 		return -EBUSY;
 	}
+	for (int i = 0; i < dev->vq_num; i++) {
+
+		vduse_free_vq_reconnnect(dev, i);
+	}
 	dev->connected = true;
 	mutex_unlock(&dev->lock);
 
@@ -1583,6 +1616,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 		INIT_WORK(&dev->vqs[i].kick, vduse_vq_kick_work);
 		spin_lock_init(&dev->vqs[i].kick_lock);
 		spin_lock_init(&dev->vqs[i].irq_lock);
+
+		vduse_get_vq_reconnnect(dev, i);
 	}
 
 	ret = idr_alloc(&vduse_idr, dev, 1, VDUSE_DEV_MAX, GFP_KERNEL);
-- 
2.34.3

