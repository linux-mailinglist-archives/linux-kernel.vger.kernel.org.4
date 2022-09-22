Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FDA5E60EA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiIVLZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiIVLZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:25:17 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F744A6C3F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 04:25:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQSkvRx_1663845886;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VQSkvRx_1663845886)
          by smtp.aliyun-inc.com;
          Thu, 22 Sep 2022 19:25:13 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     jean-philippe@linaro.org, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com
Cc:     virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] iommu/virtio: __viommu_sync_req is no need to return a value
Date:   Thu, 22 Sep 2022 19:24:46 +0800
Message-Id: <1663845886-11341-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Song <liusong@linux.alibaba.com>

In "__viommu_sync_req", 0 is always returned as the only return value, no
return value is needed for this case, and the processes and functions
involved are adjusted accordingly.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 drivers/iommu/virtio-iommu.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index b7c2280..fde5661 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -151,7 +151,7 @@ static off_t viommu_get_write_desc_offset(struct viommu_dev *viommu,
  * Wait for all added requests to complete. When this function returns, all
  * requests that were in-flight at the time of the call have completed.
  */
-static int __viommu_sync_req(struct viommu_dev *viommu)
+static void __viommu_sync_req(struct viommu_dev *viommu)
 {
 	unsigned int len;
 	size_t write_len;
@@ -180,22 +180,15 @@ static int __viommu_sync_req(struct viommu_dev *viommu)
 		list_del(&req->list);
 		kfree(req);
 	}
-
-	return 0;
 }
 
-static int viommu_sync_req(struct viommu_dev *viommu)
+static void viommu_sync_req(struct viommu_dev *viommu)
 {
-	int ret;
 	unsigned long flags;
 
 	spin_lock_irqsave(&viommu->request_lock, flags);
-	ret = __viommu_sync_req(viommu);
-	if (ret)
-		dev_dbg(viommu->dev, "could not sync requests (%d)\n", ret);
+	__viommu_sync_req(viommu);
 	spin_unlock_irqrestore(&viommu->request_lock, flags);
-
-	return ret;
 }
 
 /*
@@ -247,8 +240,8 @@ static int __viommu_add_req(struct viommu_dev *viommu, void *buf, size_t len,
 	ret = virtqueue_add_sgs(vq, sg, 1, 1, req, GFP_ATOMIC);
 	if (ret == -ENOSPC) {
 		/* If the queue is full, sync and retry */
-		if (!__viommu_sync_req(viommu))
-			ret = virtqueue_add_sgs(vq, sg, 1, 1, req, GFP_ATOMIC);
+		__viommu_sync_req(viommu);
+		ret = virtqueue_add_sgs(vq, sg, 1, 1, req, GFP_ATOMIC);
 	}
 	if (ret)
 		goto err_free;
@@ -293,11 +286,7 @@ static int viommu_send_req_sync(struct viommu_dev *viommu, void *buf,
 		goto out_unlock;
 	}
 
-	ret = __viommu_sync_req(viommu);
-	if (ret) {
-		dev_dbg(viommu->dev, "could not sync requests (%d)\n", ret);
-		/* Fall-through (get the actual request status) */
-	}
+	__viommu_sync_req(viommu);
 
 	ret = viommu_get_req_errno(buf, len);
 out_unlock:
-- 
1.8.3.1

