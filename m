Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE90667678
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237383AbjALOcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236847AbjALObW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:31:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31FC5E09D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673533348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F/AVPewFoadGFAzU9enda46Kg7wI9ci0LM+wGYIMzIQ=;
        b=LhZcJRqXZCBwWT/FbJfF84KdkmKvfp8RsBLRYeWFTZSxIb1tjyp45ZzpDewjqj6HpUDflp
        CkRTLCOHWSZ7D7OK40k/UoPVt8lX7D1Vo8I5kopsDHaW41oDw+y/89TBY/XDb1PVrIDyJ1
        37IzMCk1j/0yASei1a0n/rf9AgJrBlk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-ji8upy0INVe9E7i5Mn-w2A-1; Thu, 12 Jan 2023 09:22:24 -0500
X-MC-Unique: ji8upy0INVe9E7i5Mn-w2A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12C1E38041DB;
        Thu, 12 Jan 2023 14:22:24 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.192.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 719B52166B29;
        Thu, 12 Jan 2023 14:22:22 +0000 (UTC)
From:   =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To:     mst@redhat.com, elic@nvidia.com
Cc:     linux-kernel@vger.kernel.org, parav@nvidia.com, lulu@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        sgarzare@redhat.com, si-wei.liu@oracle.com
Subject: [RFC 1/3] vdpa/mlx5: reset iotlb at dup_iotlb
Date:   Thu, 12 Jan 2023 15:22:16 +0100
Message-Id: <20230112142218.725622-2-eperezma@redhat.com>
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

Regular memory region changes already reset cvq iotlb at set_map.
However this is not true if CVQ and data VQs are in different ASID.

Clean the CVQ iotlb every time we hit dup_iotlb.

Fixes: 8fcd20c30704 ("vdpa/mlx5: Support different address spaces for control and data")
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/mlx5/core/mr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 0a1e0b0dc37e..ae34dcac9a3f 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -456,6 +456,8 @@ static int dup_iotlb(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *src)
 	u64 start = 0, last = ULLONG_MAX;
 	int err;
 
+	vhost_iotlb_reset(mvdev->cvq.iotlb);
+
 	if (!src) {
 		err = vhost_iotlb_add_range(mvdev->cvq.iotlb, start, last, start, VHOST_ACCESS_RW);
 		return err;
-- 
2.31.1

