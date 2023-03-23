Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD65F6C5EEB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjCWFcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjCWFcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:32:23 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246D82BF12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:21 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o11so21336423ple.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679549479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihxW9QIYwW7geYYIsi25taexnQY98X1VOl5aytZk5u4=;
        b=kIURKCtRiCNlA/czcj4Vbbn/aPsD7HY6PBQRckQpSqqq6tcuS8WO695O85xiYDI7IN
         mj7F/qgUN6n/E4wc+SBODKr2dmT6S0Mxa6W6VLKt+s0eEF+lZkTQOyBVOT0F0s3DWh48
         OAfvD8YdDYpxZ0m5mG39Suz/wYhEJcgo88I8+odM8Cr8qlmKUH63CnuPgiMCzWsVS5ap
         ghhRHepFPg99tHTLSyjPQHFnCFcjbbPBJ0V8+fd86fp4ep5JDV6PpOZV6G//DkAFLYAt
         lV3qsnaZk9q8KMlbZbmRM7g+gpjuhaG0dZ3CkhJLEkwk5CKYb8yc0jvlPmAVEMPhc9BP
         CmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679549479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihxW9QIYwW7geYYIsi25taexnQY98X1VOl5aytZk5u4=;
        b=MCQStOKVHhqb845bUs5DKMXQLdSeyV70EZGg/hYcgesVvwJ30mhlCIRLnt0vdWzBMU
         pKSVYClU1ZJqTq3GG+CN3DhJGNPodikKzzUy+WUwt1k1f/Ai3lS0zrmZ3+idzeVyZw4H
         vIXbBNnH5cVdRebsdOH4JX6Mf7ZjXnnOaUASKuvU0ECP8U7R3lIdQYSG9DGQYjNn4b/B
         MZ8IaCAcgVQvnl0dPWp9XZQC1oUeUe39QT+EYsJC9xX61DOofksncCVP1A7IEZeRv/uZ
         8e7Uw3o0+Wli/5oskood/k4Vmx8Cym5lv1o8O4DSKv05eZzUVAq3qBGs5Z+Xh0eoP1Bf
         vLWA==
X-Gm-Message-State: AO0yUKULMXD87+KTt/T6BM6EiXdJmYbGW9qkt8VT0Wkbfqwh2RRT5E18
        Hx3aPa8RMaIj1wQfcS+TI29ATZSbFZMw5b+VGQ==
X-Google-Smtp-Source: AK7set/rK1IzdrgpYvMrOwIGj0imNxvmORDT1PEdqXmLYJZSB+GB946artKH/vVbtgf7Sl8zcspYaQ==
X-Received: by 2002:a05:6a20:ba87:b0:d9:949e:a72 with SMTP id fb7-20020a056a20ba8700b000d9949e0a72mr1560552pzb.60.1679549479099;
        Wed, 22 Mar 2023 22:31:19 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id p14-20020a62ab0e000000b0062505afff9fsm10953459pff.126.2023.03.22.22.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 22:31:18 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/11] vdpa: Add set/get_vq_affinity callbacks in vdpa_config_ops
Date:   Thu, 23 Mar 2023 13:30:34 +0800
Message-Id: <20230323053043.35-3-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230323053043.35-1-xieyongji@bytedance.com>
References: <20230323053043.35-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces set/get_vq_affinity callbacks in
vdpa_config_ops to support virtqueue affinity
management for vdpa device drivers.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_vdpa.c | 28 ++++++++++++++++++++++++++++
 include/linux/vdpa.h         | 13 +++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index d7f5af62ddaa..f72696b4c1c2 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -337,6 +337,32 @@ static const char *virtio_vdpa_bus_name(struct virtio_device *vdev)
 	return dev_name(&vdpa->dev);
 }
 
+static int virtio_vdpa_set_vq_affinity(struct virtqueue *vq,
+				       const struct cpumask *cpu_mask)
+{
+	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vq->vdev);
+	struct vdpa_device *vdpa = vd_dev->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
+	unsigned int index = vq->index;
+
+	if (ops->set_vq_affinity)
+		return ops->set_vq_affinity(vdpa, index, cpu_mask);
+
+	return 0;
+}
+
+static const struct cpumask *
+virtio_vdpa_get_vq_affinity(struct virtio_device *vdev, int index)
+{
+	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
+	const struct vdpa_config_ops *ops = vdpa->config;
+
+	if (ops->get_vq_affinity)
+		return ops->get_vq_affinity(vdpa, index);
+
+	return NULL;
+}
+
 static const struct virtio_config_ops virtio_vdpa_config_ops = {
 	.get		= virtio_vdpa_get,
 	.set		= virtio_vdpa_set,
@@ -349,6 +375,8 @@ static const struct virtio_config_ops virtio_vdpa_config_ops = {
 	.get_features	= virtio_vdpa_get_features,
 	.finalize_features = virtio_vdpa_finalize_features,
 	.bus_name	= virtio_vdpa_bus_name,
+	.set_vq_affinity = virtio_vdpa_set_vq_affinity,
+	.get_vq_affinity = virtio_vdpa_get_vq_affinity,
 };
 
 static void virtio_vdpa_release_dev(struct device *_d)
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 43f59ef10cc9..e52c9a37999c 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -250,6 +250,15 @@ struct vdpa_map_file {
  *				@vdev: vdpa device
  *				Returns the iova range supported by
  *				the device.
+ * @set_vq_affinity:		Set the affinity of virtqueue (optional)
+ *				@vdev: vdpa device
+ *				@idx: virtqueue index
+ *				@cpu_mask: the affinity mask
+ *				Returns integer: success (0) or error (< 0)
+ * @get_vq_affinity:		Get the affinity of virtqueue (optional)
+ *				@vdev: vdpa device
+ *				@idx: virtqueue index
+ *				Returns the affinity mask
  * @set_group_asid:		Set address space identifier for a
  *				virtqueue group (optional)
  *				@vdev: vdpa device
@@ -340,6 +349,10 @@ struct vdpa_config_ops {
 			   const void *buf, unsigned int len);
 	u32 (*get_generation)(struct vdpa_device *vdev);
 	struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
+	int (*set_vq_affinity)(struct vdpa_device *vdev, u16 idx,
+			       const struct cpumask *cpu_mask);
+	const struct cpumask *(*get_vq_affinity)(struct vdpa_device *vdev,
+						 u16 idx);
 
 	/* DMA ops */
 	int (*set_map)(struct vdpa_device *vdev, unsigned int asid,
-- 
2.20.1

