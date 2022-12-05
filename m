Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C4E6424E8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiLEInz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiLEIno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:43:44 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE7BF6D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:43:43 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id jl24so10153412plb.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 00:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cO+KU63uNOWhYuRIkuFEXhxzLMtKvTfecVGe+9pJx48=;
        b=DhvH+PirhSMpFBT0JD9NNMmsymRnTivAVV2txwqvLAmz2gZL/tiC09x3ysYplVGVOr
         rLr3wHTZr0W1MUAL/AegwzZ5IlETMRfuV0hrxpx0sP6rP+s5uOovAtJSDNF/cBLfjR3D
         k1lqXE1PeD0Pa6oMjZNUyNwMxF4xnJEFazUNyF++JBJabk1UeQc6D/AWxqpcxTWzBkNG
         07VLm2boc8fgX9OBw9QbFTAko0AnFCqUi4x07j3nIhWvwit8y5AG45Uar+IlTEzKLCtR
         2fqFmUk6M0OtrWZLw4fZuiZx2SnskerlOnQiLdZEeTU4FB8m6gXGti/S6LQeeu5nNdR1
         54dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cO+KU63uNOWhYuRIkuFEXhxzLMtKvTfecVGe+9pJx48=;
        b=D15HZuRRhDygMmjdQzXBAyJewfHwJIjVkKlHGbX2yo2CaOQanAeRkXNCu+K98IkHiu
         3GT2zEbZIO+mzN/HdFIesJ8EYjI7piy8zjcjPgXGWNSBmiesqT2MMA4DgNu5E9ZRqHxv
         7vz5SV/x3reALf5Cpjsk74YVMuspnoOskUSxz+SMYj6a5Zimpl2sVPTFXSOawmU6FIPf
         mq4UJnA/AG5Db44tzVhHwQqjb3qI0DSKqWnvgGHkiHHUdIwqjp4IXb24rEd53V6842y1
         tLOHKtE+BHWjx7ZuX6DKIrPagz+60M/BuxrEH0nn4S+CY3odD7AEe4U2fqzRYyAdZA0U
         l+Jg==
X-Gm-Message-State: ANoB5ploLnkbUsFBS3/OePDpAOPep4aFxfDmhdmRDPNuG3r/TL9F0sN4
        dgx7e5WqWjYicS3kXjzGuaBw
X-Google-Smtp-Source: AA0mqf7u05sKp5pD6WT353+KEy/rhM2wKKmfYNlvyz/rWZoDChWw8jJnNBx0cfF8d10/6/F7skJwJg==
X-Received: by 2002:a17:90b:2503:b0:219:baef:3d0 with SMTP id ns3-20020a17090b250300b00219baef03d0mr7903735pjb.95.1670229823405;
        Mon, 05 Dec 2022 00:43:43 -0800 (PST)
Received: from localhost ([101.229.232.206])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902d2c600b0017c19d7c89bsm10005499plc.269.2022.12.05.00.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 00:43:43 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/11] vdpa: Add set_irq_affinity callback in vdpa_config_ops
Date:   Mon,  5 Dec 2022 16:41:19 +0800
Message-Id: <20221205084127.535-4-xieyongji@bytedance.com>
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

This introduces set_irq_affinity callback in
vdpa_config_ops so that vdpa device driver can
get the interrupt affinity hint from the virtio
device driver. The interrupt affinity hint would
be needed by the interrupt affinity spreading
mechanism.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/virtio/virtio_vdpa.c | 4 ++++
 include/linux/vdpa.h         | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 08084b49e5a1..4731e4616ee0 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -275,9 +275,13 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
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
index 0ff6c9363356..482ff7d0206f 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -256,6 +256,12 @@ struct vdpa_map_file {
  *				@vdev: vdpa device
  *				@idx: virtqueue index
  *				Returns the irq affinity mask
+ * @set_irq_affinity:		Pass the irq affinity hint from the virtio
+ *				device driver to vdpa driver (optional).
+ *				Needed by the interrupt affinity spreading
+ *				mechanism.
+ *				@vdev: vdpa device
+ *				@desc: irq affinity hint
  * @set_group_asid:		Set address space identifier for a
  *				virtqueue group (optional)
  *				@vdev: vdpa device
@@ -344,6 +350,8 @@ struct vdpa_config_ops {
 			       const struct cpumask *cpu_mask);
 	const struct cpumask *(*get_vq_affinity)(struct vdpa_device *vdev,
 						 u16 idx);
+	void (*set_irq_affinity)(struct vdpa_device *vdev,
+				 struct irq_affinity *desc);
 
 	/* DMA ops */
 	int (*set_map)(struct vdpa_device *vdev, unsigned int asid,
-- 
2.20.1

