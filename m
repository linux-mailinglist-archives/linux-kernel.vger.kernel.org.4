Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE056E8997
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 07:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjDTFWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 01:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjDTFVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 01:21:35 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4222D7689
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 22:20:29 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-74ab718c344so74352585a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 22:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681968028; x=1684560028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KBz+fVq1jzb7gRw7Z5hg0hm+utuhzaIPUfRZZRnaGZs=;
        b=Zn1fh2HiZwgaOY6a9LLkSkmlquJBbM/fuCqBvVtzFSVvaq7H9UFDhCMbtg9v/x19Bo
         XGdjcAAL+sKKUHuqj6JvhdPsgkB5Z05hjCw9L/bOGUzxOTE2nw5hfPpeROHWiAnquJEH
         oMtAg0yBukVZmCq1SWrKuyW2GCBTx3z0G6GAkiOb4QWMVWx1S92RW01fTFhSHupFTT4o
         d7s54rVXrzaSINYMmrcSr5uO4KQq4b0UAzlIWDWb23tVPzpWkqMIjIQz5o+CouY3X6s0
         KGj3yuYTrR7ooad+5dmLGS5RhTayJB8MAyK7qyQnSoj+4ocCwj1cXLbPq4ZWEpBLjTmZ
         hZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681968028; x=1684560028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBz+fVq1jzb7gRw7Z5hg0hm+utuhzaIPUfRZZRnaGZs=;
        b=HDCEPqW3e1wOp05VDq4LziMkhrfsZLRCUrFweRiGfsFmHBIpCgDTKSmxF2wjL+21tN
         bLEhp0FWm6EI1KI+lZA7e1OIak31VPf3Xi1R6ADIfoBxpC+CX0ighrbBVhg5yXuoYYfS
         sWFv7vBTTeY+z+9Ss28KYbQDx46mBYVxgexLH8WT4xY/ioBRM/yN7VDHnksfxxJJoKzI
         Ge0CXFUcr2JNg6Y4W6wWsZQQ7r5DHPPPkwJ6d7PyWm7MHxPpKS54H0ckajEXroy5ACSB
         oPu62AFRAiXKtfIiS3I2ctWC4sCmMJT1D2F9oV2ZaXzfmDB/P7um6qo0L1EMHglctcwT
         +rUQ==
X-Gm-Message-State: AAQBX9dGdfx5SEy9fDWapdoypVUnmOz4b5cQ77uoOoT/NkGXNkfC8RqP
        nwyIuEVkKUSJxPbrdvmHyABc3p/b2bI=
X-Google-Smtp-Source: AKy350Yn08qYQWohtQ5FaHpUHoIZSVgC2flb9e5S7nQfzc3QQApWjO5ZI7aAFRu1w9lUdo6WZd7Iug==
X-Received: by 2002:a05:6214:20ab:b0:5dd:b986:b44 with SMTP id 11-20020a05621420ab00b005ddb9860b44mr285445qvd.6.1681968028102;
        Wed, 19 Apr 2023 22:20:28 -0700 (PDT)
Received: from entropy.pdl.local.cmu.edu (NAT1.PDL.CMU.EDU. [128.2.147.192])
        by smtp.gmail.com with ESMTPSA id c17-20020a0ce151000000b005ef5be4c2f7sm201892qvl.73.2023.04.19.22.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 22:20:27 -0700 (PDT)
From:   peili.dev@gmail.com
To:     linux-kernel@vger.kernel.org
Cc:     eperezma@redhat.com, Pei Li <peili@andrew.cmu.edu>
Subject: [RFC PATCH] Reduce vdpa initialization / startup overhead for ioctl()
Date:   Thu, 20 Apr 2023 01:20:26 -0400
Message-Id: <20230420052026.1883230-1-peili.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pei Li <peili@andrew.cmu.edu>

Signed-off-by: Pei Li <peili@andrew.cmu.edu>
---
 drivers/vhost/vdpa.c             | 77 +++++++++++++++++++++++++++++++-
 include/uapi/linux/vhost.h       |  7 +++
 include/uapi/linux/vhost_types.h |  1 +
 tools/include/uapi/linux/vhost.h |  6 +++
 4 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 7be9d9d8f01c..5419db1dfb7a 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -29,7 +29,8 @@ enum {
 	VHOST_VDPA_BACKEND_FEATURES =
 	(1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2) |
 	(1ULL << VHOST_BACKEND_F_IOTLB_BATCH) |
-	(1ULL << VHOST_BACKEND_F_IOTLB_ASID),
+	(1ULL << VHOST_BACKEND_F_IOTLB_ASID) |
+	(1ULL << VHOST_BACKEND_F_IOCTL_BATCH),
 };
 
 #define VHOST_VDPA_DEV_MAX (1U << MINORBITS)
@@ -521,6 +522,68 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
 	return ops->resume(vdpa);
 }
 
+static long vhost_vdpa_vring_ioctl_batch(struct vhost_vdpa *v, unsigned int cmd,
+				   void __user *argp)
+{
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
+	struct vhost_virtqueue *vq;
+	struct vhost_vring_state s;
+
+	u32 idx, num, i;
+	long r;
+
+	r = get_user(num, ((struct vhost_vring_state __user *)argp)->num);
+	if (r < 0) {
+		return r;
+	}
+
+	num = array_index_nospec(num, v->nvqs);
+
+	struct vhost_vring_state states[num + 1];
+
+	if (copy_from_user(&states, argp, sizeof(states)))
+		return -EFAULT;
+
+	switch (cmd) {
+	case VHOST_VDPA_SET_VRING_ENABLE_BATCH:
+		for (i = 1; i <= num; i++) {
+			i = array_index_nospec(i, num + 1);
+			idx = states[i].index;
+			if (idx >= v->nvqs)
+				return -ENOBUFS;
+
+			idx = array_index_nospec(idx, v->nvqs);
+
+			ops->set_vq_ready(vdpa, idx, 1);
+		}
+		return 0;
+	case VHOST_VDPA_GET_VRING_GROUP_BATCH:
+		if (!ops->get_vq_group)
+			return -EOPNOTSUPP;
+		
+		for (i = 1; i <= num; i++) {
+			i = array_index_nospec(i, num + 1);
+			idx = states[i].index;
+			if (idx >= v->nvqs)
+				return -ENOBUFS;
+			idx = array_index_nospec(idx, v->nvqs);
+			states[i].num = ops->get_vq_group(vdpa, idx);
+			if (states[i].num >= vdpa->ngroups)
+				return -EIO;
+		}
+
+		if (copy_to_user(argp, &states, sizeof(states)))
+			return -EFAULT;
+
+		return 0;
+	default:
+		r = ENOIOCTLCMD;
+	}
+
+	return r;
+}
+
 static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 				   void __user *argp)
 {
@@ -533,6 +596,13 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 	u32 idx;
 	long r;
 
+	switch (cmd) {
+		case VHOST_VDPA_SET_VRING_ENABLE_BATCH:
+		// fall through
+		case VHOST_VDPA_GET_VRING_GROUP_BATCH:
+			return vhost_vdpa_vring_ioctl_batch(v, cmd, argp);
+	}
+
 	r = get_user(idx, (u32 __user *)argp);
 	if (r < 0)
 		return r;
@@ -630,7 +700,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 			return -EFAULT;
 		if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
 				 BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
-				 BIT_ULL(VHOST_BACKEND_F_RESUME)))
+				 BIT_ULL(VHOST_BACKEND_F_RESUME) |
+				 BIT_ULL(VHOST_BACKEND_F_IOCTL_BATCH)))
 			return -EOPNOTSUPP;
 		if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
 		     !vhost_vdpa_can_suspend(v))
@@ -638,6 +709,7 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 		if ((features & BIT_ULL(VHOST_BACKEND_F_RESUME)) &&
 		     !vhost_vdpa_can_resume(v))
 			return -EOPNOTSUPP;
+
 		vhost_set_backend_features(&v->vdev, features);
 		return 0;
 	}
@@ -691,6 +763,7 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 			features |= BIT_ULL(VHOST_BACKEND_F_SUSPEND);
 		if (vhost_vdpa_can_resume(v))
 			features |= BIT_ULL(VHOST_BACKEND_F_RESUME);
+		features |= BIT_ULL(VHOST_BACKEND_F_IOCTL_BATCH);
 		if (copy_to_user(featurep, &features, sizeof(features)))
 			r = -EFAULT;
 		break;
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index 92e1b700b51c..edb8cc1b22c9 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -188,4 +188,11 @@
  */
 #define VHOST_VDPA_RESUME		_IO(VHOST_VIRTIO, 0x7E)
 
+
+#define VHOST_VDPA_SET_VRING_ENABLE_BATCH	_IOW(VHOST_VIRTIO, 0x7F, \
+					     struct vhost_vring_state)
+
+#define VHOST_VDPA_GET_VRING_GROUP_BATCH	_IOWR(VHOST_VIRTIO, 0x82, \
+					      struct vhost_vring_state)
+
 #endif
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index c5690a8992d8..ea232fbd436a 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -166,4 +166,5 @@ struct vhost_vdpa_iova_range {
 /* Device can be resumed */
 #define VHOST_BACKEND_F_RESUME  0x5
 
+#define VHOST_BACKEND_F_IOCTL_BATCH 0x6
 #endif
diff --git a/tools/include/uapi/linux/vhost.h b/tools/include/uapi/linux/vhost.h
index 92e1b700b51c..d0ce141688ba 100644
--- a/tools/include/uapi/linux/vhost.h
+++ b/tools/include/uapi/linux/vhost.h
@@ -188,4 +188,10 @@
  */
 #define VHOST_VDPA_RESUME		_IO(VHOST_VIRTIO, 0x7E)
 
+#define VHOST_VDPA_SET_VRING_ENABLE_BATCH	_IOW(VHOST_VIRTIO, 0x7F, \
+					     struct vhost_vring_state)
+
+#define VHOST_VDPA_GET_VRING_GROUP_BATCH	_IOWR(VHOST_VIRTIO, 0x82, \
+					      struct vhost_vring_state)
+
 #endif
-- 
2.25.1

