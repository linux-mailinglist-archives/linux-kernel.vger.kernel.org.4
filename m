Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8D465BE71
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237430AbjACKwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237193AbjACKvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:51:38 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765602FA
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672743097; x=1704279097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wwAlVm/7I8ndsWi60dF17HSTriSq8epoPrbPLSohnLw=;
  b=PpLoTiiAXvPV6Y0VKIgd581nm9AxugWU/N8sDhTYFo0TI/aIuE2wbShk
   ORfQmkUbA7DKmB/cFQYW9tvBGQi4AoPo11ezZAyzzEZrpxSHrJStaWjJx
   qKtD9zHglvyKLCFrlElVLMvLiWuHDQlPOMY/cmADgpT/43Wjh6VUrrIS1
   dDzYe1CbDVmttZApxjr1njzECMyoeM/gxCSbe2YIyyf5cZEEG/YnFlnMe
   ecSDYTUNqHvkWOCxEieiuUwDLXCv97W/0IAPeSE9qAuF/cYDngEYzZw1Y
   OwMRNepXuZF0OlYhHhQNGTuUiDVb4up5vf/i0y7jLVznumuwWhv6Sg4MQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="301318451"
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="301318451"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 02:51:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="604772689"
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="604772689"
Received: from isobansk-mobl1.ger.corp.intel.com (HELO sboeuf-mobl.home) ([10.252.24.246])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 02:51:35 -0800
From:   sebastien.boeuf@intel.com
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
        sebastien.boeuf@intel.com
Subject: [PATCH v6 2/4] vhost-vdpa: Introduce RESUME backend feature bit
Date:   Tue,  3 Jan 2023 11:51:06 +0100
Message-Id: <b18db236ba3d990cdb41278eb4703be9201d9514.1672742878.git.sebastien.boeuf@intel.com>
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

Userspace knows if the device can be resumed or not by checking this
feature bit.

It's only exposed if the vdpa driver backend implements the resume()
operation callback. Userspace trying to negotiate this feature when it
hasn't been exposed will result in an error.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
---
 drivers/vhost/vdpa.c             | 16 +++++++++++++++-
 include/uapi/linux/vhost_types.h |  2 ++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 166044642fd5..833617d00ef6 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -355,6 +355,14 @@ static bool vhost_vdpa_can_suspend(const struct vhost_vdpa *v)
 	return ops->suspend;
 }
 
+static bool vhost_vdpa_can_resume(const struct vhost_vdpa *v)
+{
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
+
+	return ops->resume;
+}
+
 static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)
 {
 	struct vdpa_device *vdpa = v->vdpa;
@@ -602,11 +610,15 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 		if (copy_from_user(&features, featurep, sizeof(features)))
 			return -EFAULT;
 		if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
-				 BIT_ULL(VHOST_BACKEND_F_SUSPEND)))
+				 BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
+				 BIT_ULL(VHOST_BACKEND_F_RESUME)))
 			return -EOPNOTSUPP;
 		if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
 		     !vhost_vdpa_can_suspend(v))
 			return -EOPNOTSUPP;
+		if ((features & BIT_ULL(VHOST_BACKEND_F_RESUME)) &&
+		     !vhost_vdpa_can_resume(v))
+			return -EOPNOTSUPP;
 		vhost_set_backend_features(&v->vdev, features);
 		return 0;
 	}
@@ -658,6 +670,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 		features = VHOST_VDPA_BACKEND_FEATURES;
 		if (vhost_vdpa_can_suspend(v))
 			features |= BIT_ULL(VHOST_BACKEND_F_SUSPEND);
+		if (vhost_vdpa_can_resume(v))
+			features |= BIT_ULL(VHOST_BACKEND_F_RESUME);
 		if (copy_to_user(featurep, &features, sizeof(features)))
 			r = -EFAULT;
 		break;
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index 53601ce2c20a..c5690a8992d8 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -163,5 +163,7 @@ struct vhost_vdpa_iova_range {
 #define VHOST_BACKEND_F_IOTLB_ASID  0x3
 /* Device can be suspended */
 #define VHOST_BACKEND_F_SUSPEND  0x4
+/* Device can be resumed */
+#define VHOST_BACKEND_F_RESUME  0x5
 
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

