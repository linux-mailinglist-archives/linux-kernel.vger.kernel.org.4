Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F47665499
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 07:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbjAKG30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 01:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjAKG3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 01:29:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1B31037
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 22:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673418504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cbAm8flGGw3yRsNW/jjO4z0Hil6iXxWlmJZ59AWjhnY=;
        b=XMYpcmG1e93/lDGG7bcnBox7RoXmAVw8ADwZoyZ6AYFZf8Zw0W8lXLjRnfvzdUuHNXiYh5
        +tfMW/ZO0zMInpsKqsALiSlI0s+DN85UY/t4RMOb3/e/um+WbVTRwPRg3TyiXWLGBU8u3/
        bkvNkB81QiCx8auE79o3QHg3wfGRk9E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-MDkulyrMMU-BWvdrLZyqjw-1; Wed, 11 Jan 2023 01:28:22 -0500
X-MC-Unique: MDkulyrMMU-BWvdrLZyqjw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60FF6811E6E;
        Wed, 11 Jan 2023 06:28:22 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-175.pek2.redhat.com [10.72.13.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 648AA4078903;
        Wed, 11 Jan 2023 06:28:19 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     elic@nvidia.com, gdawar@amd.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, tanuj.kamde@amd.com
Subject: [PATCH 2/5] vdpa: introduce get_vq_dma_device()
Date:   Wed, 11 Jan 2023 14:28:06 +0800
Message-Id: <20230111062809.25020-3-jasowang@redhat.com>
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

This patch introduces a new method to query the dma device that is use
for a specific virtqueue.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/vdpa.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 6d0f5e4e82c2..3ec13aee35f5 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -282,6 +282,11 @@ struct vdpa_map_file {
  *				@iova: iova to be unmapped
  *				@size: size of the area
  *				Returns integer: success (0) or error (< 0)
+ * @get_vq_dma_dev:		Get the dma device for a specific
+ *				virtqueue (optional)
+ *				@vdev: vdpa device
+ *				@idx: virtqueue index
+ *				Returns pointer to structure device or error (NULL)
  * @free:			Free resources that belongs to vDPA (optional)
  *				@vdev: vdpa device
  */
@@ -341,6 +346,7 @@ struct vdpa_config_ops {
 			 u64 iova, u64 size);
 	int (*set_group_asid)(struct vdpa_device *vdev, unsigned int group,
 			      unsigned int asid);
+	struct device *(*get_vq_dma_dev)(struct vdpa_device *vdev, u16 idx);
 
 	/* Free device resources */
 	void (*free)(struct vdpa_device *vdev);
-- 
2.25.1

