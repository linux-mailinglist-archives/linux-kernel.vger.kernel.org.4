Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E8B602724
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiJRIi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiJRIiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:38:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059A69F758
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666082296; x=1697618296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3EV55upffRiHWnrQrH8wPJ3mud3btZU1zYuiKkySMH4=;
  b=NqK807Jl1koTGxZZ6e1xouzcUHtBoAq0IRB3USz2a8t7oP8sBOrXc0tx
   Xw1QrNpUXHJZIVM+xSD0BOJhwWcOUQYprRZh7+3kSBrp9vUUDHAbkQwuy
   CkNT0KyQO/73P9x14rf2tvpNL/4fWZmwQqf9RJD1T93/sPQX7mvmxne2d
   VmjSBfTEt+a6Zeg6GtT29v9tWQFBuwz6XUFyfD/xXO1i4VzNpDMORL5v9
   rOYsd3nJzX3UQV+dKGGdzzB3wtX5RSSf3gR77zxJhuNgQR7t/Y9WYBdl4
   DsCFmEoAe39gUODgzUnuql8uM0XbT/KgYsJuh8ylWeWtOXOH0RIMaQVeb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="307125543"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="307125543"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 01:38:04 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="753951077"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="753951077"
Received: from aboyhan-mobl1.ger.corp.intel.com (HELO sboeuf-mobl.home) ([10.252.26.192])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 01:38:02 -0700
From:   sebastien.boeuf@intel.com
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
        sebastien.boeuf@intel.com
Subject: [PATCH v4 2/4] vhost-vdpa: Introduce RESUME backend feature bit
Date:   Tue, 18 Oct 2022 10:37:25 +0200
Message-Id: <2b70c4e3c811d0f769399b0bdc0dae52853ac8c4.1666082013.git.sebastien.boeuf@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666082013.git.sebastien.boeuf@intel.com>
References: <cover.1666082013.git.sebastien.boeuf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

