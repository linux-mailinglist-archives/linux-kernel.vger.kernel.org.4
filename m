Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35F366767C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbjALOcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbjALOb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:31:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D0259300
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673533352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xS+WhDCpVAXfoHuOOZG8UbA19f02GKhB5mYWzIxAKis=;
        b=YurhqiEPS1qkTpy6H3O7DLRyIhjLkKXd7k5H6m/CcStTNwF8pFglFlhCK39yyoRLh4JDpm
        Snr9jwKkTFJwtq9tU1aZyy4DobraJpDiS0JarnHqDh1pQVSZXu1zlaFhUoklU/x1cVqGd+
        Y2FDhvwdKpDXc3SLe2gPbkN5ZKU4Qtc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-MofelG4rOpKRCjq502kgtQ-1; Thu, 12 Jan 2023 09:22:28 -0500
X-MC-Unique: MofelG4rOpKRCjq502kgtQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1B4F2805599;
        Thu, 12 Jan 2023 14:22:27 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.192.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4975B2166B29;
        Thu, 12 Jan 2023 14:22:26 +0000 (UTC)
From:   =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To:     mst@redhat.com, elic@nvidia.com
Cc:     linux-kernel@vger.kernel.org, parav@nvidia.com, lulu@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        sgarzare@redhat.com, si-wei.liu@oracle.com
Subject: [RFC 3/3] vdpa/mlx5: take iommu_lock at dup_iotlb
Date:   Thu, 12 Jan 2023 15:22:18 +0100
Message-Id: <20230112142218.725622-4-eperezma@redhat.com>
In-Reply-To: <20230112142218.725622-1-eperezma@redhat.com>
References: <20230112142218.725622-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both iommu changes and lookup are protected by mlx5_vdpa_net->reslock at
this moment, but:
* These iotlb changes / queries are not in the fast data path.
* reslock belongs to netdev, while dup_iotlb seems generic.
* It's located in a different file than the lock it needs to hold

Justifies the lock acquisition.

Fixes: 5262912ef3cf ("vdpa/mlx5: Add support for control VQ and MAC setting")
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/mlx5/core/mr.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 878ee94efa78..e9c8a7f8ee1d 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -454,13 +454,15 @@ static int dup_iotlb(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *src)
 {
 	struct vhost_iotlb_map *map;
 	u64 start = 0, last = ULLONG_MAX;
-	int err;
+	int err = 0;
+
+	spin_lock(&mvdev->cvq.iommu_lock);
 
 	vhost_iotlb_reset(mvdev->cvq.iotlb);
 
 	if (!src) {
 		err = vhost_iotlb_add_range(mvdev->cvq.iotlb, start, last, start, VHOST_ACCESS_RW);
-		return err;
+		goto out;
 	}
 
 	for (map = vhost_iotlb_itree_first(src, start, last); map;
@@ -468,9 +470,12 @@ static int dup_iotlb(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *src)
 		err = vhost_iotlb_add_range(mvdev->cvq.iotlb, map->start, map->last,
 					    map->addr, map->perm);
 		if (err)
-			return err;
+			goto out;
 	}
-	return 0;
+
+out:
+	spin_unlock(&mvdev->cvq.iommu_lock);
+	return err;
 }
 
 static void prune_iotlb(struct mlx5_vdpa_dev *mvdev)
-- 
2.31.1

