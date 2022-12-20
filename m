Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF3E651BCA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiLTHhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiLTHhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:37:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52552F027;
        Mon, 19 Dec 2022 23:37:36 -0800 (PST)
Received: from localhost.localdomain (unknown [213.194.155.136])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 69AD76601810;
        Tue, 20 Dec 2022 07:37:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671521854;
        bh=A7n0VSq8cd0ak7dktr+xYbXSUP6klaKvgvHdAFhnEWQ=;
        h=From:To:Cc:Subject:Date:From;
        b=nHIVtLA7sGGmGpRU+qFlf0MltTc+ydchH+x82IqnCS8C+M3MsZKAfGsNnk6eK0Ct+
         4qJDCU8w/Ows0fwOAO5Inq46XiGY0NXJBsb1Ty3Pyi5w8cIQl9MjZlCtjmd+JS5VpA
         Nyfe078iV4QT+BYI3KU1M4JVqRPQBC6bbmzkNArG2PBrDOsZ5yAqmaQKlm6dV3ExDN
         rqoYpGGwy8K6cIwTKyUIArBsVq73eLdBcBv1MNlSCLK+xr1hC8+ohngqko9ZRIg40h
         sxyRZN5IF7WAgJQ35VvjLnt13qNGTLhibRbKn+Q2o/9QW7ZpV1xM+3OKFgG/3Ufvof
         bLt8jxGxSlW6A==
From:   =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     mst@redhat.com
Cc:     sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel@collabora.com
Subject: [PATCH] virtio: fix virtio_config_ops kerneldocs
Date:   Tue, 20 Dec 2022 08:37:09 +0100
Message-Id: <20221220073709.2687151-1-ricardo.canuelo@collabora.com>
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

Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
---
 include/linux/virtio_config.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 4b517649cfe8..f9a33062c089 100644
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
@@ -68,8 +70,8 @@ struct virtio_shm_region {
  * @finalize_features: confirm what device features we'll be using.
  *	vdev: the virtio_device
  *	This sends the driver feature bits to the device: it can change
- *	the dev->feature bits if it wants.
- * Note: despite the name this can be called any number of times.
+ *	the dev->feature bits if it wants. Note: despite the name this
+ *	can be called any number of times.
  *	Returns 0 on success or error status
  * @bus_name: return the bus name associated with the device (optional)
  *	vdev: the virtio_device
@@ -91,7 +93,6 @@ struct virtio_shm_region {
  *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
  *	set.
  */
-typedef void vq_callback_t(struct virtqueue *);
 struct virtio_config_ops {
 	void (*get)(struct virtio_device *vdev, unsigned offset,
 		    void *buf, unsigned len);
-- 
2.25.1

