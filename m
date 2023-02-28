Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EAE6A5606
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjB1JmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjB1JmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:42:21 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20DB2CFE8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:42:19 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id n5so5269026pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LeXo4wlRPLjaFCDUlWd/vTm6oCQxlpO5FWsfhmVL4c=;
        b=jCF/GGa9lIkRMXEETq9mILXcYfSU+l7wJJCBS/zOo80F2sCHGtOCUJYzhpcVmI5iSJ
         7o4Mi57hybiDlC4/jTo4q0MnvArNeUPFnz3V3PHt6GJmPlMoFRQrdmP/iJ8HPv+TbrqM
         HZX1aD7DvYy12DY1TP+jsbMCyoUlAuLBXx5ocYH6kaYVzwm4gy7z7//J2vZ2rgdyHvzg
         kiFaAik8PxswTSDDlDNz3EMhlPwkHwLp20/eVb/vwa4yGijprJa61KLUTWsEB/EvKktr
         FQyCwFFElfzKeQYZ6tMam6/e35BV0dPnAblV6Dktp82JlmCJ3se/54OII1yIUvgNouLE
         mylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LeXo4wlRPLjaFCDUlWd/vTm6oCQxlpO5FWsfhmVL4c=;
        b=cgwCy1shfML8F6qVqDgLGnP6c1C6mkR7W3S5OyooZ9aiVMM9/dXx9VbKfmtAu762ke
         LsPC3Vn/jXgyUk9u7tszTiJwC2Hjd5PM7OSi6UQx846Bjo6nkkv1DpNx6NRPE5AN/IZB
         3VQxInJXkQxd5GTVlCQhcEvwSvfEJZV2yaadBgwJbDoLzdzN/rATHgpeEZL7fKWlmAqC
         daxzF1+IDSwejKg0jO146xLsBUu09gRVvAEmhhyXVrX6+edTF242Ll081/O4mCp7rMnf
         3ND5KHpo/MkN8cWiugvkh1isA+KWaIYcvV6elPR5T38znWpWoI6IA2zFEctUPaTDI1Nj
         Rh4w==
X-Gm-Message-State: AO0yUKVwGvs1twsf6FE67yi1+5RHVtsH46IhBjECdAe5qkibOXnm6pFJ
        GwlJs/1wXyO54etv67TVTed67qgamrq/HT0=
X-Google-Smtp-Source: AK7set8aNyyzTj9qxjcMFF4Vf7GHi0pJZ/mlBlA4cU1sVgDRWvMC7HsMR9n9VIATIYVeAZZ+GVHvag==
X-Received: by 2002:aa7:8428:0:b0:600:cc40:2589 with SMTP id q8-20020aa78428000000b00600cc402589mr1758849pfn.3.1677577339176;
        Tue, 28 Feb 2023 01:42:19 -0800 (PST)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id w3-20020aa78583000000b005abc30d9445sm5609518pfn.180.2023.02.28.01.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 01:42:18 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/11] vdpa: Add set_irq_affinity callback in vdpa_config_ops
Date:   Tue, 28 Feb 2023 17:41:02 +0800
Message-Id: <20230228094110.37-4-xieyongji@bytedance.com>
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

This introduces set_irq_affinity callback in
vdpa_config_ops so that vdpa device driver can
get the interrupt affinity hint from the virtio
device driver. The interrupt affinity hint would
be needed by the interrupt affinity spreading
mechanism.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/virtio/virtio_vdpa.c | 4 ++++
 include/linux/vdpa.h         | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index f72696b4c1c2..9eee8afabda8 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -282,9 +282,13 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
 	const struct vdpa_config_ops *ops = vdpa->config;
+	struct irq_affinity default_affd = { 0 };
 	struct vdpa_callback cb;
 	int i, err, queue_idx = 0;
 
+	if (ops->set_irq_affinity)
+		ops->set_irq_affinity(vdpa, desc ? desc : &default_affd);
+
 	for (i = 0; i < nvqs; ++i) {
 		if (!names[i]) {
 			vqs[i] = NULL;
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index d61f369f9cd6..10bd22387276 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -259,6 +259,13 @@ struct vdpa_map_file {
  *				@vdev: vdpa device
  *				@idx: virtqueue index
  *				Returns the irq affinity mask
+ * @set_irq_affinity:		Pass the irq affinity hint (best effort)
+ *				from the virtio device driver to vdpa
+ *				driver (optional).
+ *				Needed by the interrupt affinity spreading
+ *				mechanism.
+ *				@vdev: vdpa device
+ *				@desc: irq affinity hint
  * @set_group_asid:		Set address space identifier for a
  *				virtqueue group (optional)
  *				@vdev: vdpa device
@@ -353,6 +360,8 @@ struct vdpa_config_ops {
 			       const struct cpumask *cpu_mask);
 	const struct cpumask *(*get_vq_affinity)(struct vdpa_device *vdev,
 						 u16 idx);
+	void (*set_irq_affinity)(struct vdpa_device *vdev,
+				 struct irq_affinity *desc);
 
 	/* DMA ops */
 	int (*set_map)(struct vdpa_device *vdev, unsigned int asid,
-- 
2.20.1

