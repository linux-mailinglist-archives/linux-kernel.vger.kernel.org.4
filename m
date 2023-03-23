Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E5C6C5EE7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjCWFcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjCWFcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:32:01 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9635C31BCD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:23 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id kq3so8919736plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679549482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcDeLFrXedHSKuPyT2iyCEdMTIpqJ+T19wOg244Ts4I=;
        b=W9SSFngkB1ECAtiQ37iuP109gTcmletw6vq+zRxp/NRGzpExnhGsK4kPrjj1ak5b4L
         aeyffW2TlZUySj70RZs94gUF8zv5FdUiHpxw15qAr9fH0T05eV+3IiKo4jC8gWqa8YLa
         C8kTUg6jzQNubyAjSltIJFxWsVlc+4h+aIUvW50QX7Q25sCZj/FO5DpLggKQ0Zelmlj4
         JLQavFZ9OYxOYqJK22eDQHcjDTrs3xbkJBLEkNO5E/KweCY+9fTUSkHmbs7CRWVKEo5f
         3nf9rgKyv8tVgNS3os7wQGnVJgwRKAuN0q0f6TRupP3UlA9jIH0YdL7GfJhPp4ZuNSxJ
         b4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679549482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcDeLFrXedHSKuPyT2iyCEdMTIpqJ+T19wOg244Ts4I=;
        b=z4VQNziPIDW33eFUuzDtYlXG+WSqYSiipwuqznLducSuUjMk4McuIZewSbgwZd/rrE
         G/T4CpQ+x2mKVJAr9tpd/IKAr4psGCpLwztnVYLfs7r3gtlV1Ex6YmAOJwVZfG1Rw4EI
         OigHIfQmSNSE1JdokNDZvtFL9V03qo/nAYb9u4QwlwciC138xPCJQPbcSgzc94PjBeKc
         dNA9ZsXqSDLP0n1Hdo8Ly7Hq/F5hrM41rD12cF6A9cxFYcS9lhA5JK6cCNG76fdque4r
         d0Cs/j8zaqsDdiZDKmY4JoeEbbM4evWOIxqYSnQUSup2MZhdt+p5tk55EpNGQ/0cJtfe
         Sszw==
X-Gm-Message-State: AO0yUKUTkt/zlsu4GqS79O+BUW7Ky9YOBFjjqs5w6Kr2spcas13yYWyL
        HDsJznXSu2rWIGjBY6X6MBSaiN+OJM/LUK5A2A==
X-Google-Smtp-Source: AK7set9KoMFWejw0t85RtGlQlLYW/5xOSmETgUY/U6P6XwnLX9ftzVzlJwYDeP8nlrUp5808h9g2CQ==
X-Received: by 2002:a17:90b:1e42:b0:23d:39e0:13b with SMTP id pi2-20020a17090b1e4200b0023d39e0013bmr6254179pjb.43.1679549482181;
        Wed, 22 Mar 2023 22:31:22 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id d9-20020a17090a6a4900b0023c8a23005asm431804pjm.49.2023.03.22.22.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 22:31:22 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/11] virtio-vdpa: Support interrupt affinity spreading mechanism
Date:   Thu, 23 Mar 2023 13:30:35 +0800
Message-Id: <20230323053043.35-4-xieyongji@bytedance.com>
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

To support interrupt affinity spreading mechanism,
this makes use of group_cpus_evenly() to create
an irq callback affinity mask for each virtqueue
of vdpa device. Then we will unify set_vq_affinity
callback to pass the affinity to the vdpa device driver.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/virtio/virtio_vdpa.c | 68 ++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index f72696b4c1c2..f3826f42b704 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/uuid.h>
+#include <linux/group_cpus.h>
 #include <linux/virtio.h>
 #include <linux/vdpa.h>
 #include <linux/virtio_config.h>
@@ -272,6 +273,66 @@ static void virtio_vdpa_del_vqs(struct virtio_device *vdev)
 		virtio_vdpa_del_vq(vq);
 }
 
+static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
+{
+	affd->nr_sets = 1;
+	affd->set_size[0] = affvecs;
+}
+
+static struct cpumask *
+create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
+{
+	unsigned int affvecs = 0, curvec, usedvecs, i;
+	struct cpumask *masks = NULL;
+
+	if (nvecs > affd->pre_vectors + affd->post_vectors)
+		affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
+
+	if (!affd->calc_sets)
+		affd->calc_sets = default_calc_sets;
+
+	affd->calc_sets(affd, affvecs);
+
+	if (!affvecs)
+		return NULL;
+
+	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
+	if (!masks)
+		return NULL;
+
+	/* Fill out vectors at the beginning that don't need affinity */
+	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
+		cpumask_setall(&masks[curvec]);
+
+	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
+		unsigned int this_vecs = affd->set_size[i];
+		int j;
+		struct cpumask *result = group_cpus_evenly(this_vecs);
+
+		if (!result) {
+			kfree(masks);
+			return NULL;
+		}
+
+		for (j = 0; j < this_vecs; j++)
+			cpumask_copy(&masks[curvec + j], &result[j]);
+		kfree(result);
+
+		curvec += this_vecs;
+		usedvecs += this_vecs;
+	}
+
+	/* Fill out vectors at the end that don't need affinity */
+	if (usedvecs >= affvecs)
+		curvec = affd->pre_vectors + affvecs;
+	else
+		curvec = affd->pre_vectors + usedvecs;
+	for (; curvec < nvecs; curvec++)
+		cpumask_setall(&masks[curvec]);
+
+	return masks;
+}
+
 static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 				struct virtqueue *vqs[],
 				vq_callback_t *callbacks[],
@@ -282,9 +343,15 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
 	const struct vdpa_config_ops *ops = vdpa->config;
+	struct irq_affinity default_affd = { 0 };
+	struct cpumask *masks;
 	struct vdpa_callback cb;
 	int i, err, queue_idx = 0;
 
+	masks = create_affinity_masks(nvqs, desc ? desc : &default_affd);
+	if (!masks)
+		return -ENOMEM;
+
 	for (i = 0; i < nvqs; ++i) {
 		if (!names[i]) {
 			vqs[i] = NULL;
@@ -298,6 +365,7 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 			err = PTR_ERR(vqs[i]);
 			goto err_setup_vq;
 		}
+		ops->set_vq_affinity(vdpa, i, &masks[i]);
 	}
 
 	cb.callback = virtio_vdpa_config_cb;
-- 
2.20.1

