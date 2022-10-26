Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6684E60E429
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbiJZPJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbiJZPJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:09:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7D81285DA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666796960; x=1698332960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3EV55upffRiHWnrQrH8wPJ3mud3btZU1zYuiKkySMH4=;
  b=PD4M2O9MM8eLHQ3R6TBD6j2P5fr1ErBOLT/9zfXaqvjMQHzXE0xU5VJ6
   ZCLb5O+ogX9zC50GD5bwPSlIAVHRQuxXpJ5y6ziRCzjwms/2EHH8i07Yt
   P9BWFgzI4+LazK8A6ZwCaBXhOiaBAmcohTIKGP9GKXEmzwSh/vm1bLPyW
   w61RHyZs8pozJaqSSOZcD0WAKJvepjBTzFUqttUTJFSZNQCb6WyF512gR
   D2v/D8iiF3iSxv8aeZidHysZcCA3FF21BejBycnz6nhCCuxOczAC9zGp7
   dVV4+6kYA223Ke7Y07uShVPlrQJXHK0U6MS2CpfZZk09MWEa5kJOeZn8r
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="372178672"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="372178672"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 08:08:57 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="961252449"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="961252449"
Received: from briansim-mobl.ger.corp.intel.com (HELO sboeuf-mobl.home) ([10.252.29.107])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 08:08:55 -0700
From:   sebastien.boeuf@intel.com
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
        sebastien.boeuf@intel.com
Subject: [PATCH v5 2/4] vhost-vdpa: Introduce RESUME backend feature bit
Date:   Wed, 26 Oct 2022 17:08:36 +0200
Message-Id: <bba8957be029e711e83a48234e9b4172ca5d076d.1666796792.git.sebastien.boeuf@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666796792.git.sebastien.boeuf@intel.com>
References: <cover.1666796792.git.sebastien.boeuf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
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

