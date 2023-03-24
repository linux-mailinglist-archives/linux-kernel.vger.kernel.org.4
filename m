Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590426C818B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjCXPkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjCXPkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:40:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFD62129A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679672392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VVAueuORiKGKOw5iPuuD3Ux7+pQ6EAyahLBg2nxd2sw=;
        b=YWo9+qSWC35TJKScyq4XNA3nwz4tA3j0eBwXR9yRaBIs9mIV8QKoGfB6dmACMeqZUsbd80
        itYYNY34xA9HTguN4jnMDyc4+sznBX2HGSAAEv+EFW32DlVwNts+SOBHNynMdmacjRhSlr
        onApVaCIYGStztqhDwXBCWGp6dj4urw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-V9q7yx27NRm6NqALrbIlxQ-1; Fri, 24 Mar 2023 11:39:51 -0400
X-MC-Unique: V9q7yx27NRm6NqALrbIlxQ-1
Received: by mail-ed1-f72.google.com with SMTP id es16-20020a056402381000b004fa3e04c882so3747410edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679672390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVAueuORiKGKOw5iPuuD3Ux7+pQ6EAyahLBg2nxd2sw=;
        b=chOujcUm/QGzDHyadtCBglYLWuEo4Zx2tT70nwuSpk2yjOYjHfFDQBiDpGUBN+y1dT
         7Ru7HAJogcKS0o1dLb1W2YhhiO8r6Zm5R9J1kbhgP0HXlNnM61Cu4b6tVNhLyXSrUSv0
         44Yx1lvnzUY5bPNlpzk6IoL9JspLTt5yL1/1A2EE4V6vTNb975f1LiOliDW/PACAtnTD
         q/UUwA7vVz0UmTmG5UxWZ26Z6QpurnSX7nr3RaSZQoAxmDOyQBrXLf4OBAPJvjTrI2DH
         1aPCU6lURROUn3lWEWO2LRekb7Q4yGFS2NA8UbMjgXEqefF+eh+kNCk9IIEJhHgiZchD
         8m1Q==
X-Gm-Message-State: AAQBX9eaSjWSPw3Qj2cIpOo4zF/M/cERndd0FciThBpRRZN/H9MKfk3c
        63LtAYNbJ2rooJ9OQ8jWmtBxw6SRvcgF+Ei9Dzhi0JgfkstD0LULNDicWsP3suAWowUJjxz6Kch
        fCwq0X8+KY9KE33SDt8y5abPh
X-Received: by 2002:a17:906:3850:b0:92f:13b9:d498 with SMTP id w16-20020a170906385000b0092f13b9d498mr3253853ejc.36.1679672389913;
        Fri, 24 Mar 2023 08:39:49 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZS/Tv/2sZYKBNsok47ghj98jKMPgUDCYS3M35Ue86ZuX6HibK2LvWo/dM7n1M7/gbQt5E3Dg==
X-Received: by 2002:a17:906:3850:b0:92f:13b9:d498 with SMTP id w16-20020a170906385000b0092f13b9d498mr3253829ejc.36.1679672389708;
        Fri, 24 Mar 2023 08:39:49 -0700 (PDT)
Received: from localhost.localdomain (host-82-53-134-98.retail.telecomitalia.it. [82.53.134.98])
        by smtp.gmail.com with ESMTPSA id sd24-20020a170906ce3800b00931024e96c5sm10571246ejb.99.2023.03.24.08.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 08:39:48 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        Jason Wang <jasowang@redhat.com>, eperezma@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, stefanha@redhat.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 7/9] vdpa_sim: use kthread worker
Date:   Fri, 24 Mar 2023 16:39:40 +0100
Message-Id: <20230324153940.47710-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324153607.46836-1-sgarzare@redhat.com>
References: <20230324153607.46836-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's use our own kthread to run device jobs.
This allows us more flexibility, especially we can attach the kthread
to the user address space when vDPA uses user's VA.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

Notes:
    v3:
    - fix `dev` not initialized in the error path [Simon Horman]

 drivers/vdpa/vdpa_sim/vdpa_sim.h |  3 ++-
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 19 +++++++++++++------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index acee20faaf6a..ce83f9130a5d 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -57,7 +57,8 @@ struct vdpasim_dev_attr {
 struct vdpasim {
 	struct vdpa_device vdpa;
 	struct vdpasim_virtqueue *vqs;
-	struct work_struct work;
+	struct kthread_worker *worker;
+	struct kthread_work work;
 	struct vdpasim_dev_attr dev_attr;
 	/* spinlock to synchronize virtqueue state */
 	spinlock_t lock;
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 2df5227e0b62..bd9f9054de94 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -11,8 +11,8 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/kthread.h>
 #include <linux/slab.h>
-#include <linux/sched.h>
 #include <linux/dma-map-ops.h>
 #include <linux/vringh.h>
 #include <linux/vdpa.h>
@@ -127,7 +127,7 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
 static const struct vdpa_config_ops vdpasim_config_ops;
 static const struct vdpa_config_ops vdpasim_batch_config_ops;
 
-static void vdpasim_work_fn(struct work_struct *work)
+static void vdpasim_work_fn(struct kthread_work *work)
 {
 	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
 
@@ -170,11 +170,17 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 
 	vdpasim = vdpa_to_sim(vdpa);
 	vdpasim->dev_attr = *dev_attr;
-	INIT_WORK(&vdpasim->work, vdpasim_work_fn);
+	dev = &vdpasim->vdpa.dev;
+
+	kthread_init_work(&vdpasim->work, vdpasim_work_fn);
+	vdpasim->worker = kthread_create_worker(0, "vDPA sim worker: %s",
+						dev_attr->name);
+	if (IS_ERR(vdpasim->worker))
+		goto err_iommu;
+
 	spin_lock_init(&vdpasim->lock);
 	spin_lock_init(&vdpasim->iommu_lock);
 
-	dev = &vdpasim->vdpa.dev;
 	dev->dma_mask = &dev->coherent_dma_mask;
 	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
 		goto err_iommu;
@@ -223,7 +229,7 @@ EXPORT_SYMBOL_GPL(vdpasim_create);
 
 void vdpasim_schedule_work(struct vdpasim *vdpasim)
 {
-	schedule_work(&vdpasim->work);
+	kthread_queue_work(vdpasim->worker, &vdpasim->work);
 }
 EXPORT_SYMBOL_GPL(vdpasim_schedule_work);
 
@@ -623,7 +629,8 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 	int i;
 
-	cancel_work_sync(&vdpasim->work);
+	kthread_cancel_work_sync(&vdpasim->work);
+	kthread_destroy_worker(vdpasim->worker);
 
 	for (i = 0; i < vdpasim->dev_attr.nvqs; i++) {
 		vringh_kiov_cleanup(&vdpasim->vqs[i].out_iov);
-- 
2.39.2

