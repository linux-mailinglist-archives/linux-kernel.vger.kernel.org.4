Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D203651FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 12:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiLTLaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 06:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbiLTLaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 06:30:05 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577AF18E1A;
        Tue, 20 Dec 2022 03:30:02 -0800 (PST)
Received: from localhost.localdomain (unknown [213.194.155.136])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 642A06602C60;
        Tue, 20 Dec 2022 11:30:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671535800;
        bh=LYORg+Xtzpeisr24t7s3wezJiYVuhF+cisQOQWpxxQ4=;
        h=From:To:Cc:Subject:Date:From;
        b=QdyQgHDTxvQzC2Lluc+13pCJW681PHpw4PnPNOCqiwN2pYQRUktcyq2PodBpTu89B
         2eME0Gfg7Y800IlPxdbf7e0i3UkUlTmZORz3WaYnrVCpHwuShGyYlqQ+eb23o+IgkF
         4CcLPLhjcK88fXTr85XhZbMdK1qPVGfKpmSpKT1Cc4lUEWef+YXYa2IQrvwodC6je6
         DvXCrYoum9gs1oMQBdW10zAdYtB6TN5Lx73YaS7Qary51Y8lBcPuqJi/CeS/hPkqTG
         NdHnu/0j0SC7+pHd0kYY2mHaP89g1UxTjaF0UxOUor+x/oVjWHDds2Wyt9HU1dpdgg
         Wj4L9GuhQkNtA==
From:   =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     mst@redhat.com
Cc:     sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel@collabora.com
Subject: [PATCH v3] virtio: fix virtio_config_ops kerneldocs
Date:   Tue, 20 Dec 2022 12:29:43 +0100
Message-Id: <20221220112943.2727137-1-ricardo.canuelo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes two warning messages when building htmldocs:

    warning: duplicate section name 'Note'
    warning: expecting prototype for virtio_config_ops().
             Prototype was for vq_callback_t() instead

Link: https://lore.kernel.org/linux-next/20221220105956.4786852d@canb.auug.org.au/
Fixes: 333723e8bc393d ("docs: driver-api: virtio: virtio on Linux")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com> 
---
Changes in v3:
  - Added a Fixes tag referencing the commit that revealed the warning
    messages (suggested by Bagas Sanjaya and Michael S. Tsirkin)

Changes in v2:
  - Reword the "Note" comment in the kerneldoc so that it doesn't look
    like a kerneldoc "Note" section (suggested by AngeloGioacchino Del
    Regno)
  - Link, Reported-by and Reviewed-by tags added (suggested by Bagas
    Sanjaya)

 include/linux/virtio_config.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 4b517649cfe8..2b3438de2c4d 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -16,8 +16,10 @@ struct virtio_shm_region {
 	u64 len;
 };
 
+typedef void vq_callback_t(struct virtqueue *);
+
 /**
- * virtio_config_ops - operations for configuring a virtio device
+ * struct virtio_config_ops - operations for configuring a virtio device
  * Note: Do not assume that a transport implements all of the operations
  *       getting/setting a value as a simple read/write! Generally speaking,
  *       any of @get/@set, @get_status/@set_status, or @get_features/
@@ -69,7 +71,8 @@ struct virtio_shm_region {
  *	vdev: the virtio_device
  *	This sends the driver feature bits to the device: it can change
  *	the dev->feature bits if it wants.
- * Note: despite the name this can be called any number of times.
+ *	Note that despite the name this	can be called any number of
+ *	times.
  *	Returns 0 on success or error status
  * @bus_name: return the bus name associated with the device (optional)
  *	vdev: the virtio_device
@@ -91,7 +94,6 @@ struct virtio_shm_region {
  *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
  *	set.
  */
-typedef void vq_callback_t(struct virtqueue *);
 struct virtio_config_ops {
 	void (*get)(struct virtio_device *vdev, unsigned offset,
 		    void *buf, unsigned len);
-- 
2.25.1

