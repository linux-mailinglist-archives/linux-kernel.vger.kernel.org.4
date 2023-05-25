Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FF7710E72
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241488AbjEYOfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239180AbjEYOfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:35:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29BA191
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:35:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C7AA64644
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 14:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648AFC433EF;
        Thu, 25 May 2023 14:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685025345;
        bh=aPHW1firYZUPUYQjts4gcUsLZLZZc2+q5rRUj5KNoeY=;
        h=From:Date:Subject:To:Cc:From;
        b=ZzK+Ec/gkEIK3sm56v3nU249RDSxZTEkleji+bbG8IROwHx7x+skMJzU5m15KOwgI
         /MM5VsUogeK7xVBowmRb8mGAsx8ue2Dpctm/XV8tlb/msPuMxRT8MTj/EsPuiS7EhR
         WXXZyuEmA68OH5shf5WT5Dy7n/RRhuuUkpKF5bsfUF7eYjiqjp8nj4vKmLjumUFbZ/
         AgsS2a+OFnTmAkLtiCvpo+xUxbai4YvJ7th8ro7TVJ2Ax+5K3frN1jTVj5JtWlm2iZ
         XZChEXtTefPJ/18b6ANlfgKTFVd3/4HigYuGf3MhEV/WUUiYNrK8IMlF4FtE9yilv7
         cJi5Eum/P4gPQ==
From:   Simon Horman <horms@kernel.org>
Date:   Thu, 25 May 2023 16:35:42 +0200
Subject: [PATCH v3] virtio: Add missing documentation for structure fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-virtio-kdoc-v3-1-e2681ed7a425@kernel.org>
X-B4-Tracking: v=1; b=H4sIAD1yb2QC/32NywrCMBBFf6VkbSSZvl35H+IiSadtaElkUoNS+
 u+m3Qni8lw4564sIFkM7JKtjDDaYL1LkJ8yZkblBuS2S8xAQC5KKXi0tFjPp84b3rVVhU3d17l
 AlgytAnJNypkxOe45z2l8EPb2dVzc7olHGxZP7+Mxyn39HY+SS96Blg0UqlWgrxOSw/nsaWB7K
 MIfGZIsTalAoC5Mj1/ytm0fReexevkAAAA=
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing documentation for the vqs_list_lock field of struct virtio_device,
and the validate field of struct virtio_driver.

./scripts/kernel-doc says:

 .../virtio.h:131: warning: Function parameter or member 'vqs_list_lock' not described in 'virtio_device'
 .../virtio.h:192: warning: Function parameter or member 'validate' not described in 'virtio_driver'
 2 warnings as Errors

No functional changes intended.

Signed-off-by: Simon Horman <horms@kernel.org>
---
Changes in v3:
- As suggested by Stefano Garzarella
  + Drop inline comment for @vqs_list_lock which is now covered by Kdoc
  + Add "Returns 0 or -errno." to @validate Kdoc
- Link to v2: https://lore.kernel.org/r/20230510-virtio-kdoc-v2-1-1c5a20eb4cfe@kernel.org

Changes in v2:
- As suggested by Michael S. Tsirkin
  + @validate is not called on probe
  + @validate does validates config space
  + embarrassingly, validate was misspelt
- Link to v1: https://lore.kernel.org/r/20230510-virtio-kdoc-v1-1-d2b1824a9a2b@kernel.org
---
 include/linux/virtio.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index b93238db94e3..de6041deee37 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -103,6 +103,7 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
  * @config_enabled: configuration change reporting enabled
  * @config_change_pending: configuration change reported while disabled
  * @config_lock: protects configuration change reporting
+ * @vqs_list_lock: protects @vqs.
  * @dev: underlying device.
  * @id: the device type identification (used to match it with a driver).
  * @config: the configuration ops for this device.
@@ -117,7 +118,7 @@ struct virtio_device {
 	bool config_enabled;
 	bool config_change_pending;
 	spinlock_t config_lock;
-	spinlock_t vqs_list_lock; /* Protects VQs list access */
+	spinlock_t vqs_list_lock;
 	struct device dev;
 	struct virtio_device_id id;
 	const struct virtio_config_ops *config;
@@ -160,6 +161,8 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev);
  * @feature_table_size: number of entries in the feature table array.
  * @feature_table_legacy: same as feature_table but when working in legacy mode.
  * @feature_table_size_legacy: number of entries in feature table legacy array.
+ * @validate: the function to call to validate features and config space.
+ *            Returns 0 or -errno.
  * @probe: the function to call when a device is found.  Returns 0 or -errno.
  * @scan: optional function to call after successful probe; intended
  *    for virtio-scsi to invoke a scan.

