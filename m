Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40286602721
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiJRIiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJRIiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:38:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4C19C7DF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666082290; x=1697618290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d4xVHWCp3WQNIGyJXoYLjNrxvXCMfEsO8t0kmydFxrI=;
  b=byZvNa7KdJhllvF8/L55vnOYBX6/4JsCqAkxnvMqApbMYNEhPM2u9wMX
   lktM6JtuT0eRl1nfH7vxElgtxAuGl8DUAFHgcaeephq55k8IUk+l2InMA
   sFW89bsXUaUzd+7ZcV3Z9Z1sHjSPCZwf+Y3sFFmX4/8m9/+56mZjK394w
   xOCXRYargdS3Hdw0gS1y9w+RG7HyRJRPArMWfDrbuZZSBK3tzN4W+vddE
   D0LLJ7rOoUCNx9aZ9qdASCHvIsDewKyUjInzu+se5XFYbrbzoy8U9xnOh
   Z3bUj2ApzQydpbpKoWdDFzEIe7421LMWwwAGfWAMgUqIAfmne0FAmQ9ak
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="332580434"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="332580434"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 01:38:10 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="753951118"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="753951118"
Received: from aboyhan-mobl1.ger.corp.intel.com (HELO sboeuf-mobl.home) ([10.252.26.192])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 01:38:08 -0700
From:   sebastien.boeuf@intel.com
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
        sebastien.boeuf@intel.com
Subject: [PATCH v4 3/4] vhost-vdpa: uAPI to resume the device
Date:   Tue, 18 Oct 2022 10:37:26 +0200
Message-Id: <e162ec99320f97b28b300ec12e5faa6342f2bfc8.1666082013.git.sebastien.boeuf@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666082013.git.sebastien.boeuf@intel.com>
References: <cover.1666082013.git.sebastien.boeuf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastien Boeuf <sebastien.boeuf@intel.com>

This new ioctl adds support for resuming the device from userspace.

This is required when trying to restore the device in a functioning
state after it's been suspended. It is already possible to reset a
suspended device, but that means the device must be reconfigured and
all the IOMMU/IOTLB mappings must be recreated. This new operation
allows the device to be resumed without going through a full reset.

This is particularly useful when trying to perform offline migration of
a virtual machine (also known as snapshot/restore) as it allows the VMM
to resume the virtual machine back to a running state after the snapshot
is performed.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
---
 drivers/vhost/vdpa.c       | 18 ++++++++++++++++++
 include/uapi/linux/vhost.h |  8 ++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 833617d00ef6..1db7bd39fb63 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -502,6 +502,21 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
 	return ops->suspend(vdpa);
 }
 
+/* After a successful return of this ioctl the device resumes processing
+ * virtqueue descriptors. The device becomes fully operational the same way it
+ * was before it was suspended.
+ */
+static long vhost_vdpa_resume(struct vhost_vdpa *v)
+{
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
+
+	if (!ops->resume)
+		return -EOPNOTSUPP;
+
+	return ops->resume(vdpa);
+}
+
 static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 				   void __user *argp)
 {
@@ -687,6 +702,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 	case VHOST_VDPA_SUSPEND:
 		r = vhost_vdpa_suspend(v);
 		break;
+	case VHOST_VDPA_RESUME:
+		r = vhost_vdpa_resume(v);
+		break;
 	default:
 		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
 		if (r == -ENOIOCTLCMD)
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index f9f115a7c75b..92e1b700b51c 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -180,4 +180,12 @@
  */
 #define VHOST_VDPA_SUSPEND		_IO(VHOST_VIRTIO, 0x7D)
 
+/* Resume a device so it can resume processing virtqueue requests
+ *
+ * After the return of this ioctl the device will have restored all the
+ * necessary states and it is fully operational to continue processing the
+ * virtqueue descriptors.
+ */
+#define VHOST_VDPA_RESUME		_IO(VHOST_VIRTIO, 0x7E)
+
 #endif
-- 
2.34.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 5 208 026.16 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

