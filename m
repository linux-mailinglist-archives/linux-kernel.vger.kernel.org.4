Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D82F73FB36
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjF0LiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjF0LiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:38:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D67826BA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687865843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fm78avJkH6pYdzAlud14BVCLEgTOcTb6h7jlCJ92I3M=;
        b=Yp96n2ZkbvqBMzgSHRl2sbs37jI2DjZ2C1yh/3BLBlzIdpa9tC1/5PejbTYkFtLwKxWSrL
        UAOfDINokQJvD8TQCr9yasmQuq2zjw9yOSkDC+vykKHltCFIMLYkOg+aU/fWMjiKd4+3b9
        pJ3vCHwHYfHeHcnZMaYu7lwJDwUlgpU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-lIxHzTeIN4O5vdJSe9EULw-1; Tue, 27 Jun 2023 07:37:22 -0400
X-MC-Unique: lIxHzTeIN4O5vdJSe9EULw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 996481C06ED1;
        Tue, 27 Jun 2023 11:37:21 +0000 (UTC)
Received: from max-t490s.redhat.com (unknown [10.39.208.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2A20F5CC7;
        Tue, 27 Jun 2023 11:37:18 +0000 (UTC)
From:   Maxime Coquelin <maxime.coquelin@redhat.com>
To:     xieyongji@bytedance.com, jasowang@redhat.com, mst@redhat.com,
        david.marchand@redhat.com, lulu@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v1 1/2] vduse: validate block features only with block devices
Date:   Tue, 27 Jun 2023 13:36:51 +0200
Message-ID: <20230627113652.65283-2-maxime.coquelin@redhat.com>
In-Reply-To: <20230627113652.65283-1-maxime.coquelin@redhat.com>
References: <20230627113652.65283-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is preliminary work to enable network device
type support to VDUSE.

As VIRTIO_BLK_F_CONFIG_WCE shares the same value as
VIRTIO_NET_F_HOST_TSO4, we need to restrict its check
to Virtio-blk device type.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 5f5c21674fdc..c1c2f4c711ae 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1658,13 +1658,14 @@ static bool device_is_allowed(u32 device_id)
 	return false;
 }
 
-static bool features_is_valid(u64 features)
+static bool features_is_valid(struct vduse_dev_config *config)
 {
-	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
+	if (!(config->features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
 		return false;
 
 	/* Now we only support read-only configuration space */
-	if (features & (1ULL << VIRTIO_BLK_F_CONFIG_WCE))
+	if ((config->device_id == VIRTIO_ID_BLOCK) &&
+			(config->features & (1ULL << VIRTIO_BLK_F_CONFIG_WCE)))
 		return false;
 
 	return true;
@@ -1691,7 +1692,7 @@ static bool vduse_validate_config(struct vduse_dev_config *config)
 	if (!device_is_allowed(config->device_id))
 		return false;
 
-	if (!features_is_valid(config->features))
+	if (!features_is_valid(config))
 		return false;
 
 	return true;
-- 
2.41.0

