Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27507481B6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGEKFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjGEKFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:05:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B8F171C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 03:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688551483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iud4Ecey6anqNBpQug6H+pW6me9r94dCbe9UYyq8Yto=;
        b=B8AXedT2FhAn9fTu4danjXDYDK8/nU+Ww7maoB+f4r+KBiderbs/1EqqP0VeNeiRclCnrk
        KQYd4ZOglhWedmt1cd2y2ZTORdWQFRoRt19pYoKknWIUhDJWOrQvuwDZ2GKSHelVkFGkA2
        dJj4lfSMpti1uRudEA3mwuec+BW7O7A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-gWa3ah60PhGhuzMFrxk5RQ-1; Wed, 05 Jul 2023 06:04:40 -0400
X-MC-Unique: gWa3ah60PhGhuzMFrxk5RQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A45F2A5957D;
        Wed,  5 Jul 2023 10:04:40 +0000 (UTC)
Received: from max-t490s.redhat.com (unknown [10.39.208.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BE904021523;
        Wed,  5 Jul 2023 10:04:37 +0000 (UTC)
From:   Maxime Coquelin <maxime.coquelin@redhat.com>
To:     xieyongji@bytedance.com, jasowang@redhat.com, mst@redhat.com,
        david.marchand@redhat.com, lulu@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v3 2/3] vduse: enable Virtio-net device type
Date:   Wed,  5 Jul 2023 12:04:29 +0200
Message-ID: <20230705100430.61927-3-maxime.coquelin@redhat.com>
In-Reply-To: <20230705100430.61927-1-maxime.coquelin@redhat.com>
References: <20230705100430.61927-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds Virtio-net device type to the supported
devices types. Initialization fails if the device does
not support VIRTIO_F_VERSION_1 feature, in order to
guarantee the configuration space is read-only.

Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index ff9fdd6783fe..1271c9796517 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -142,6 +142,7 @@ static struct workqueue_struct *vduse_irq_bound_wq;
 
 static u32 allowed_device_id[] = {
 	VIRTIO_ID_BLOCK,
+	VIRTIO_ID_NET,
 };
 
 static inline struct vduse_dev *vdpa_to_vduse(struct vdpa_device *vdpa)
@@ -1672,6 +1673,10 @@ static bool features_is_valid(struct vduse_dev_config *config)
 			(config->features & (1ULL << VIRTIO_BLK_F_CONFIG_WCE)))
 		return false;
 
+	if ((config->device_id == VIRTIO_ID_NET) &&
+			!(config->features & (1ULL << VIRTIO_F_VERSION_1)))
+		return false;
+
 	return true;
 }
 
@@ -2027,6 +2032,7 @@ static const struct vdpa_mgmtdev_ops vdpa_dev_mgmtdev_ops = {
 
 static struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_BLOCK, VIRTIO_DEV_ANY_ID },
+	{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
 	{ 0 },
 };
 
-- 
2.41.0

