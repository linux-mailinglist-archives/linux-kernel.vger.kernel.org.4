Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAED6424E6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiLEInn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiLEIn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:43:27 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4523D325
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:43:25 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id q71so9883250pgq.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 00:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mAG9ZtAvBDFdb0SpXtfph5IH524mZezmsFZvVnWTx0=;
        b=3ggGlnsPSSzVuGmzDLhfsID4px8RBvDXR2MtBTOUlUUj+nCEjs70qvGqG3x5w0ts3u
         AQ6FvDHuPvipUoEIf0aylox+818HjRRusAEnuFl99yMt44Qq/SLVsN3dSXe1NmJHB04e
         soIc0XL2qW/t20srzEP34qPTmhxqaBzDJqs/WVfPlkfvkiceBVjygmxEO9W/H4y25jfl
         LK+wsBEcW1TBfZQqpQ9/EL2brHmauZML+SjAJnMRla5BiPbwVluKEBdFWSHdea8rQvMo
         yvarPiCsKVFzMkVx1uWeInbTXP3xBkoZtN1o9dtTERWPToRV+o9zkmXhX/ifXA4QSYLr
         3HSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mAG9ZtAvBDFdb0SpXtfph5IH524mZezmsFZvVnWTx0=;
        b=RjK9qznifVyENsku0Gs+f+KBRt2pbLp35GOfgB96JFx+NSEOcpPA7V+Jfr3srzz168
         3H3uJfb50uEcnNqgErriJUYzYqbh7xYmy402FoInSg1/zUdLGKV32w5XYgwUuVepnAtO
         WGIWzpNwvXKJj1zXv1634j2zW9ENBaD7Kk3ehTtWfHh0XBbpVnhzJrt5Q3pDpstRHY3d
         7Qpms9wTL5jJ6tAolbYWM67W0LtZxHNfqoVafdZsqOui1hRl6FySes4gALBgKhN1cwKh
         0YZ2b/mby9Uvi1ZXQRAgM2KJaprInIx9SjpFjXjfTQyiXTm4pVxVR7pw/0PJ7cx5QiUc
         D/aA==
X-Gm-Message-State: ANoB5pmShh6hN+ml/qsKBwKSDo0QwWRxN3T1HXnV3z+LsrN3cij56Bkq
        hAUJIVDqxBpg627Pt2JAhBha
X-Google-Smtp-Source: AA0mqf7q2GlqA5L5+fyFtAGUCFRfGXRO95HJvlxgZuvoBPdQGa7Lh8LVQw2toHBWdsLaeYc3EOuNYw==
X-Received: by 2002:a62:6247:0:b0:56b:eda9:f47a with SMTP id w68-20020a626247000000b0056beda9f47amr65941135pfb.84.1670229804801;
        Mon, 05 Dec 2022 00:43:24 -0800 (PST)
Received: from localhost ([101.229.232.206])
        by smtp.gmail.com with ESMTPSA id 72-20020a62154b000000b0056283e2bdbdsm3851669pfv.138.2022.12.05.00.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 00:43:24 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/11] vdpa: Add set/get_vq_affinity callbacks in vdpa_config_ops
Date:   Mon,  5 Dec 2022 16:41:18 +0800
Message-Id: <20221205084127.535-3-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221205084127.535-1-xieyongji@bytedance.com>
References: <20221205084127.535-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces set/get_vq_affinity callbacks in
vdpa_config_ops to support interrupt affinity
management for vdpa device drivers.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/virtio/virtio_vdpa.c | 28 ++++++++++++++++++++++++++++
 include/linux/vdpa.h         | 13 +++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 9670cc79371d..08084b49e5a1 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -330,6 +330,32 @@ static const char *virtio_vdpa_bus_name(struct virtio_device *vdev)
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
@@ -342,6 +368,8 @@ static const struct virtio_config_ops virtio_vdpa_config_ops = {
 	.get_features	= virtio_vdpa_get_features,
 	.finalize_features = virtio_vdpa_finalize_features,
 	.bus_name	= virtio_vdpa_bus_name,
+	.set_vq_affinity = virtio_vdpa_set_vq_affinity,
+	.get_vq_affinity = virtio_vdpa_get_vq_affinity,
 };
 
 static void virtio_vdpa_release_dev(struct device *_d)
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 6d0f5e4e82c2..0ff6c9363356 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -247,6 +247,15 @@ struct vdpa_map_file {
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
@@ -331,6 +340,10 @@ struct vdpa_config_ops {
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

