Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CDB65BE72
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237441AbjACKwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237304AbjACKvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:51:42 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784FB2AE1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672743101; x=1704279101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wpp2BiRmPtCrq2dRBOAMounsOwKlI+2jikZIpNAzISg=;
  b=P9+4tBXnraxk6gOQE34Ei6+MCf4EUe6dmRVgVf0LcBe8DiWMvMeD0qlx
   zUxxTF0e5sZsLB3Jd139wpn0Gic6Zf+ObMqIeSHPpB8tOOrm7lYOvXPfD
   KfvqYliwPrD+awOebQwWYFkL3kXfNEDej+ybREW3a8H0mBVVKurq+UA5r
   qxvUh5WFJPdqXdTnJyOmJ20OKv8wkigFMiKBFE7bBWP8ZqUZ7e1JvxuNn
   lA0gYI2xhUvSFNUgHkdgbjwcE8FNxPOr/adHAhBjpM7Bdrx0yAZJ1zdvX
   772Um0xuvbJqDbEXfgD7ZHj7tT4b105v2cfkOKJwpWFo7Bxbd2giy6+WB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="301318463"
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="301318463"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 02:51:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="604772706"
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="604772706"
Received: from isobansk-mobl1.ger.corp.intel.com (HELO sboeuf-mobl.home) ([10.252.24.246])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 02:51:39 -0800
From:   sebastien.boeuf@intel.com
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
        sebastien.boeuf@intel.com
Subject: [PATCH v6 3/4] vhost-vdpa: uAPI to resume the device
Date:   Tue,  3 Jan 2023 11:51:07 +0100
Message-Id: <73b75fb87d25cff59768b4955a81fe7ffe5b4770.1672742878.git.sebastien.boeuf@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1672742878.git.sebastien.boeuf@intel.com>
References: <cover.1672742878.git.sebastien.boeuf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
2.37.2

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

