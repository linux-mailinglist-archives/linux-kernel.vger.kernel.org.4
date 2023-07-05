Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B1374832D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 13:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjGELqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 07:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjGELqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 07:46:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57461736
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 04:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688557511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qsSjD1XIc1/jKyhDNjcqV8yyQFT6uszClHQCkBLneM8=;
        b=BnF9ZFzbevN1mqHtczbQePgHRQW/McbuzdvHyCP/vnx3WNOj3WLi1PFXWkNOr/VOvA1u0A
        l+vv76ORV0Z+gUXly7Bf2YDykrhIoRdWQ9wyTISyebldFqD9oOGtRhBsVlWaW0fBNnAHu7
        XyUrzhKj3iSdadT0HfyrEB8Cs/f2Xv0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-_b8qkYa1MdyJVekOnvtR3A-1; Wed, 05 Jul 2023 07:45:10 -0400
X-MC-Unique: _b8qkYa1MdyJVekOnvtR3A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA7BE1C08DAA;
        Wed,  5 Jul 2023 11:45:09 +0000 (UTC)
Received: from max-t490s.redhat.com (unknown [10.39.208.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA6E140C6CCD;
        Wed,  5 Jul 2023 11:45:07 +0000 (UTC)
From:   Maxime Coquelin <maxime.coquelin@redhat.com>
To:     xieyongji@bytedance.com, jasowang@redhat.com, mst@redhat.com,
        david.marchand@redhat.com, lulu@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH] vduse: Use proper spinlock for IRQ injection
Date:   Wed,  5 Jul 2023 13:45:05 +0200
Message-ID: <20230705114505.63274-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IRQ injection work used spin_lock_irq() to protect the
scheduling of the softirq, but spin_lock_bh() should be
used.

With spin_lock_irq(), we noticed delay of more than 6
seconds between the time a NAPI polling work is scheduled
and the time it is executed.

Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
Cc: xieyongji@bytedance.com

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index dc38ed21319d..df7869537ef1 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -935,10 +935,10 @@ static void vduse_dev_irq_inject(struct work_struct *work)
 {
 	struct vduse_dev *dev = container_of(work, struct vduse_dev, inject);
 
-	spin_lock_irq(&dev->irq_lock);
+	spin_lock_bh(&dev->irq_lock);
 	if (dev->config_cb.callback)
 		dev->config_cb.callback(dev->config_cb.private);
-	spin_unlock_irq(&dev->irq_lock);
+	spin_unlock_bh(&dev->irq_lock);
 }
 
 static void vduse_vq_irq_inject(struct work_struct *work)
@@ -946,10 +946,10 @@ static void vduse_vq_irq_inject(struct work_struct *work)
 	struct vduse_virtqueue *vq = container_of(work,
 					struct vduse_virtqueue, inject);
 
-	spin_lock_irq(&vq->irq_lock);
+	spin_lock_bh(&vq->irq_lock);
 	if (vq->ready && vq->cb.callback)
 		vq->cb.callback(vq->cb.private);
-	spin_unlock_irq(&vq->irq_lock);
+	spin_unlock_bh(&vq->irq_lock);
 }
 
 static bool vduse_vq_signal_irqfd(struct vduse_virtqueue *vq)
-- 
2.41.0

