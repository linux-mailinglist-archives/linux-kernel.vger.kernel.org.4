Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05236FF4E9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238411AbjEKOtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238368AbjEKOtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:49:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AC51436A
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:47:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2032464E42
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 14:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE80C433EF;
        Thu, 11 May 2023 14:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683816390;
        bh=+9uPDOuex5Pk0HKKJGTnib7+gzd+5ickAG9rMoNd+Qk=;
        h=From:Date:Subject:To:Cc:From;
        b=MCZIDs9FBojHg/rSBxXqFvBvIiz+6UakOAWbRCwfL9kByAs8wqRca6vRMdu5Y7yNJ
         PzsmJ7g5F7zkMlPZK8BEFaoNoCvTLdJ6TEOskyfz8tNitbT5JIv40R89gTDHyp1BuH
         Hww0EbkHYID+hE9L5YOnoOeFh66UALb20QPz4vgTuUnDyFn59tymrXdwQKIpHEUPaQ
         dnc48UvmnuxKJkaxE5RQdaNSmg+h94FYfP2NEhKe84f0hMfkJWQthIS1lwJg+2PxwE
         csWhOdFI0kroXCjvYK0c/6jzqOqKpK4RTlM3xr8G0Hq5KBSTrwlm8gAnoMKzIx8ixc
         mntexLsIAHjQw==
From:   Simon Horman <horms@kernel.org>
Date:   Thu, 11 May 2023 16:46:22 +0200
Subject: [PATCH v2] virtio: Add missing documentation for structure fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-virtio-kdoc-v2-1-1c5a20eb4cfe@kernel.org>
X-B4-Tracking: v=1; b=H4sIAL3/XGQC/22Nyw6CMBBFf4V07Zi2KA9X/odh0dIBJpDWTLHRE
 P7dytrlOcm9ZxMRmTCKW7EJxkSRgs+gT4XoJ+NHBHKZhZa6lFclIRGvFGB2oQfXVhU29VCXEkV
 eWBMRLBvfT3njX8uS5ZNxoPeReHSZJ4pr4M9RTOpn/58nBQqctqrRF9Mabe8zssflHHgU3b7vX
 75fMWW8AAAA
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
Changes in v2:
- As suggested by Michael S. Tsirkin
  + @validate is not called on probe
  + @validate does validates config space
  + embarrassingly, validate was misspelt
- Link to v1: https://lore.kernel.org/r/20230510-virtio-kdoc-v1-1-d2b1824a9a2b@kernel.org
---
 include/linux/virtio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index b93238db94e3..3abe8e9c8090 100644
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
@@ -160,6 +161,7 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev);
  * @feature_table_size: number of entries in the feature table array.
  * @feature_table_legacy: same as feature_table but when working in legacy mode.
  * @feature_table_size_legacy: number of entries in feature table legacy array.
+ * @validate: the function to call to validate features and config space
  * @probe: the function to call when a device is found.  Returns 0 or -errno.
  * @scan: optional function to call after successful probe; intended
  *    for virtio-scsi to invoke a scan.

