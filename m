Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBD5642554
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 10:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiLEJEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 04:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiLEJDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:03:19 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B9CBF70
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 01:02:55 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so2201768pjj.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 01:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OshPsK9iOwiWj6ej55hHDAz7FEiazePp8poCkCFNGxA=;
        b=68OaXWJDpO+ve8DUgOhH/3nWT7HjsJAD5UDl3Z+88p6a5Vim4LqU1I2tSIIwxP8fgj
         1fkb9Q8lYcK2DuDZMQO1dwegp5qlvIqCfvwMsbQvubp+K5E7EDWHXEyo7UsaL1X9eVg3
         oq4vPdFpyQX4lQiu2ABhqckhKOoKHF5+UPgwbAqOvgpu3SoEV3GzdloDSxeHlJePZIp4
         02JJ+j2kb/s9r6Kz0EFxeJII6nBQnMP2cjglR5mURMsjMRI4o4lQ6aL76i7+Tr6tqays
         B9WYsOelbTKR74i51N6FQ8RxLMrjHDaLkobY6/PmmpOcbsGsRwvaWJqxP3xtvMqsPEHF
         nuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OshPsK9iOwiWj6ej55hHDAz7FEiazePp8poCkCFNGxA=;
        b=hGxb5tMaDyXyEb7T4SGEYZFUAvDAMiPx3us31fHHMjlxTxHP37wZeDVGJlFrmFH6TX
         MQZxZxl4uF51htLobfEEX3d8+DBUAewQuIqJhac9MhM0rEkyZRU/ylnga8AmA2xJkA/D
         e1dn+6IqFh076+fcv69S4Q7vAT5uKicN7juvBgCx3nRGlfHuXrYOEskTAg9xKMpULD1i
         dnlQrpuVXDJKRZc62ur284C8GCt/Hdil8hmph3405EOgGSH0kFg/Vxi/27iKH81U4OTu
         71FfJnaz/1FghRjRumS2hflIuITWSc3LnuOw9IC7BrWpX9oxZsOeoCm788+mDopr6ksY
         4oaQ==
X-Gm-Message-State: ANoB5plGe5IqFmQPA+5eFGwoMhiQCGj8H8uKFg/T+QwpAcz5vmzhc3ID
        WU0QDEXPZVBFexl/eBPC04NvgNF5Ok0UWxs=
X-Google-Smtp-Source: AA0mqf72VAPsmqpNlw0GpgEheshxiF4peHF0Sjawo3s6vYAsN/f39Vy+Enqbrl/uXdCafFVUMRlVeA==
X-Received: by 2002:a17:90a:6408:b0:219:a82a:97f3 with SMTP id g8-20020a17090a640800b00219a82a97f3mr10420293pjj.95.1670230974969;
        Mon, 05 Dec 2022 01:02:54 -0800 (PST)
Received: from localhost ([101.229.232.206])
        by smtp.gmail.com with ESMTPSA id z5-20020aa79585000000b005764a143be3sm6022700pfj.103.2022.12.05.01.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 01:02:54 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/11] vduse: Support set/get_vq_affinity callbacks
Date:   Mon,  5 Dec 2022 17:02:39 +0800
Message-Id: <20221205090243.791-1-xieyongji@bytedance.com>
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

Since we already support irq callback affinity management,
let's implement the set/get_vq_affinity callbacks to make
it possible for the virtio device driver to change or be
aware of the affinity. This would make it possible for the
virtio-blk driver to build the blk-mq queues based on the
irq callback affinity.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 90c2896039d9..6507a78abc9d 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -739,6 +739,28 @@ static void vduse_vq_update_effective_cpu(struct vduse_virtqueue *vq)
 	spin_unlock(&vq->irq_affinity_lock);
 }
 
+static int vduse_vdpa_set_vq_affinity(struct vdpa_device *vdpa, u16 idx,
+				      const struct cpumask *cpu_mask)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+
+	cpumask_copy(&dev->vqs[idx]->irq_affinity, cpu_mask);
+	vduse_vq_update_effective_cpu(dev->vqs[idx]);
+
+	return 0;
+}
+
+static const struct cpumask *
+vduse_vdpa_get_vq_affinity(struct vdpa_device *vdpa, u16 idx)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+
+	if (dev->vqs[idx]->irq_effective_cpu == -1)
+		return NULL;
+
+	return &dev->vqs[idx]->irq_affinity;
+}
+
 static void vduse_vdpa_set_irq_affinity(struct vdpa_device *vdpa,
 					struct irq_affinity *desc)
 {
@@ -807,6 +829,8 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.get_config		= vduse_vdpa_get_config,
 	.set_config		= vduse_vdpa_set_config,
 	.get_generation		= vduse_vdpa_get_generation,
+	.set_vq_affinity	= vduse_vdpa_set_vq_affinity,
+	.get_vq_affinity	= vduse_vdpa_get_vq_affinity,
 	.set_irq_affinity	= vduse_vdpa_set_irq_affinity,
 	.reset			= vduse_vdpa_reset,
 	.set_map		= vduse_vdpa_set_map,
-- 
2.20.1

