Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780E36A560F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjB1JnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjB1JnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:43:01 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55CB2CC6A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:42:30 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id v11so6244207plz.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUYWrtxJPMWqrVBSuRM8/ObKVuGrxJBlEB/bWz01tiQ=;
        b=Es0tXIpQ6ZSjbv3k9aP5Z4OWz5PL5qzw/4xKb63RJQIhAR3Hb+kg1h1q05xImDI0Of
         fZSwPTiIEGLjaX60iBkE37bvjMeKy6DVbt0v1TK2PD8gNbsFu8Qnz250ywc/Oa9RIYRA
         FgkrIPXUQspAN26+vu+ahfP1HcUuc5ezqIQRyq1rEVHvOoa9y8Q46eHT0iBFhWIRyxju
         uNrUPXc+19EZzB5TfIaHc0uurBmzt48n8ak6qs8Ypux0TZpshO/GVaOFk1t5daMBNno3
         3oHQjtvfHT57BPD9QGivd/fppis29De1CHA/4wJ+yQlSNPDF+TW6fQbBWWnEO4csR9dF
         F/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUYWrtxJPMWqrVBSuRM8/ObKVuGrxJBlEB/bWz01tiQ=;
        b=I+BP7v64nTD6GE6N8oWqflL0lvaWBlrx78mFBPEzt8FykaSb/FOL70ZbNGpG1/hTof
         Q0gJC9WJb84Kc+HvYxp5m0DhJ8zOtQfwlhUruLmAh+Rgdvjt2bbR0lPQ7KZYtGFJgP16
         v66AT22AQ6oEQ+MmHdqFtjefzNvX+xbTJYloOZ9ud9fFmb0QbIrqJ3A5QX52s5u3oGGw
         cYvSpWMUhDYmZRDVn64AGFb9nbDMr06foM14N8u2wfNtu34yvlHqs8967Fb/dsAuCWkz
         HOznWM8Pvfp5q6VtIG6zd28oZVUOvv/ePWwgSEtFbYTdxjprySzw/Ak9awrAeFa4Jt82
         PRFw==
X-Gm-Message-State: AO0yUKW0ZIliKIlyn2Kfc3uohuPAVUAgrFFEUXh3/qJ73+x8qnUfwU3o
        /x7y53G79Yq05zAkDHU9FiNE
X-Google-Smtp-Source: AK7set+CsMXxwRfnpjHDrrbMQmI4HxT0UuXcehhgf1a3fIyXnztPgZ0KrxjQncEHzry5tMsB8BjytQ==
X-Received: by 2002:a17:903:124d:b0:19c:a5dd:fadb with SMTP id u13-20020a170903124d00b0019ca5ddfadbmr2190908plh.54.1677577350310;
        Tue, 28 Feb 2023 01:42:30 -0800 (PST)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id ji10-20020a170903324a00b00194caf3e975sm6086982plb.208.2023.02.28.01.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 01:42:29 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/11] vduse: Support set/get_vq_affinity callbacks
Date:   Tue, 28 Feb 2023 17:41:05 +0800
Message-Id: <20230228094110.37-7-xieyongji@bytedance.com>
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

Since we already support irq callback affinity management,
let's implement the set/get_vq_affinity callbacks to make
it possible for the virtio device driver to change or be
aware of the affinity. This would make it possible for the
virtio-blk driver to build the blk-mq queues based on the
irq callback affinity.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index bde28a8692d5..e2988a1476e4 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -775,6 +775,23 @@ create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 	return masks;
 }
 
+static int vduse_vdpa_set_vq_affinity(struct vdpa_device *vdpa, u16 idx,
+				      const struct cpumask *cpu_mask)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+
+	cpumask_copy(&dev->vqs[idx]->irq_affinity, cpu_mask);
+	return 0;
+}
+
+static const struct cpumask *
+vduse_vdpa_get_vq_affinity(struct vdpa_device *vdpa, u16 idx)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+
+	return &dev->vqs[idx]->irq_affinity;
+}
+
 static void vduse_vdpa_set_irq_affinity(struct vdpa_device *vdpa,
 					struct irq_affinity *desc)
 {
@@ -841,6 +858,8 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
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

