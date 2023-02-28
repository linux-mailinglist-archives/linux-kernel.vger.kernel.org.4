Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44246A560B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjB1Jmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjB1Jmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:42:43 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DCC2D140
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:42:16 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id bh1so9740923plb.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43XkzLpWZVinLMc6qbysNTMc1WeQ5tARy2ulZHhS0yc=;
        b=OnIaS9R0UH4qWdL4l1OHkEdbUQV4LfcylF1rlRaJBO8Ks+LLgfX5lMXhpXOcgSxvTK
         5fhOnk4BFkUvtamOmAaK8iO/aUReCim2zcyr5CIqFvfxKZhKSchItfK+QzSt3Mqul9U7
         2z6bbK/bOpXqdidNHsDAV2ZxNHXR8aXMhgBfuXDSOcyUlMZV4uuvVzZGOxaoKodcsxgj
         6sT+Min8zS6xY0vJXUYv5yvBAtEO45plqfro7nvIt6sHFLDCe5PuLangDy0p8EHpq45n
         057ojK75FIon17rtVgMPjB4gcMzinWNzTVqG71VkvhLu9QjwBvdVRwYKgAlaYyhvPraF
         m/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43XkzLpWZVinLMc6qbysNTMc1WeQ5tARy2ulZHhS0yc=;
        b=BGSeR8KXqr3dzJn2a1WyoCz6FlK2LY8uDYRv9cMik4dceSEkNo3+AA/tnGPgS35tU0
         JHiWj7QT+pH0MtcnG2Zlcn27oLza45/WT8b9dxQTeGRhEOdD6dMo2HFHfdJEKuD1egZZ
         0ZLOi1BGNfp/nsm1i+97K+WouiaTKDf3HZ5U9AnnnkJJwZAQj9vTAsQ0EwQzcc8paYze
         JvfH6xxZnaran/IXKxXA6kAcFCCkFvBZEZc9qCD6N16ao/5I77HDbyfj3h3nbwlTNr93
         mUkAjmf1FMCEoX01qKHv/mzF81sSpdO6wzcZAZsHD0LkWWLL//Ubj1HDw7FuGLZIvEyX
         R2zA==
X-Gm-Message-State: AO0yUKXvvXDiERBprCeekg/Vm733kMoGUTEVhsX/+h13nMcnkRq4i6ai
        xFwhJcaCy5hbR8Bc6k2mh/KV
X-Google-Smtp-Source: AK7set/yNW1VZ/u49W8Z+8V2zMpN8qjFOJ8xhFYg4XwxkuqbHEW18Pzu/sqtedB4kVIqsJhptc/Dsg==
X-Received: by 2002:a05:6a20:7aa7:b0:cc:120c:b259 with SMTP id u39-20020a056a207aa700b000cc120cb259mr2046843pzh.39.1677577335520;
        Tue, 28 Feb 2023 01:42:15 -0800 (PST)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id y21-20020a63b515000000b00502e48db9aesm5346378pge.53.2023.02.28.01.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 01:42:15 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/11] vdpa: Add set/get_vq_affinity callbacks in vdpa_config_ops
Date:   Tue, 28 Feb 2023 17:41:01 +0800
Message-Id: <20230228094110.37-3-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230228094110.37-1-xieyongji@bytedance.com>
References: <20230228094110.37-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces set/get_vq_affinity callbacks in
vdpa_config_ops to support interrupt affinity
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
index 43f59ef10cc9..d61f369f9cd6 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -250,6 +250,15 @@ struct vdpa_map_file {
  *				@vdev: vdpa device
  *				Returns the iova range supported by
  *				the device.
+ * @set_vq_affinity:		Set the irq affinity of virtqueue (optional)
+ *				@vdev: vdpa device
+ *				@idx: virtqueue index
+ *				@cpu_mask: irq affinity mask
+ *				Returns integer: success (0) or error (< 0)
+ * @get_vq_affinity:		Get the irq affinity of virtqueue (optional)
+ *				@vdev: vdpa device
+ *				@idx: virtqueue index
+ *				Returns the irq affinity mask
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

