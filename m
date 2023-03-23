Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7B46C5EED
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjCWFdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjCWFc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:32:27 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB19431E3D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:33 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso903257pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679549491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GCcooak9WK1xh4TRDY1XJvbDD37iAfzUGzKvOhf7XM=;
        b=P8Dro5H8Ds+eHTQPRptLcDET6KgNFGOLOsOaZgHItGzVIwsDQbEDQHhqVh23D00GXH
         HnzW7+BQkt71sZwJ/XlUBHjudQ94Mwd5jv9FwG4Dmcs1fS1hbZXb+1v6DqiU5o/A/yBt
         9/uPwzL79/8g3AADp/fbvuLKnxCGZ7kJbDa4LJAJuTQDjI4beHCDDRg58firhEcJVtyJ
         bBsPYaUy2sHGBA6PRnDm86gUQ1ftjUweQi+YfoNvKZz2TEMMmfZ+OlFsJbGcwL2IfbKf
         8+4Rwmt0Tk6LOuVkwAiUQvyulo+njqjFRmiZaIHYLrUmmDoBhDvaJ95JoMKqf5dvc28r
         1GGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679549491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GCcooak9WK1xh4TRDY1XJvbDD37iAfzUGzKvOhf7XM=;
        b=2gyxE7/3GL6TMop3MRKyo/fGmsjU4r+dOeGiXx9tl9odyyTLL6HqwAQTh0M2Uf4Rft
         YpHMo7Ftt4irezvn51gLDfODmFN/oUCo7Lj5B8qzAe5qzkzumwkOTyMZiYzayFDe2L4b
         Ig+ZnhpjVUTUZw6z8OiCyFcDvF+NS/bD2exHLRsqZix5HrQUrnPC73hrpWXIyU5eprJf
         gcrOqY3VHiYC6TFWAUtsj0NsWM6ub7O6NmtGolqW8PQtiF8Qw+SLMU8E6fl4B/FiPpzD
         JMEpZQke8T4Y6NLUE1NURgmHN3RqDmEbbaQP9QUdKOscg4Dkzork9ZpdkLEjDNPO6cvd
         SOKw==
X-Gm-Message-State: AO0yUKWVY1cvFQTNT3bnIz6dQQHNxn/3WpheG79ouyIlbkqWyeIMZUAK
        cFwHhuYowOTIg6LRg+hQWl3R
X-Google-Smtp-Source: AK7set/6XQF+8Wx9RZlJm3BKSLcUa4wyM5K0hXKEzwrokT2uWkzO9ZY85hvnvevshWHRow+QA6C6iw==
X-Received: by 2002:a05:6a20:6048:b0:d7:4339:fad9 with SMTP id s8-20020a056a20604800b000d74339fad9mr1864404pza.7.1679549491654;
        Wed, 22 Mar 2023 22:31:31 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id x5-20020aa784c5000000b006262520ac59sm10741817pfn.127.2023.03.22.22.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 22:31:31 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/11] vduse: Support get_vq_affinity callback
Date:   Thu, 23 Mar 2023 13:30:38 +0800
Message-Id: <20230323053043.35-7-xieyongji@bytedance.com>
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

This implements get_vq_affinity callback so that
the virtio-blk driver can build the blk-mq queues
based on the irq callback affinity.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 45aa8703c4b5..cefabd0dab9c 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -722,6 +722,14 @@ static int vduse_vdpa_set_vq_affinity(struct vdpa_device *vdpa, u16 idx,
 	return 0;
 }
 
+static const struct cpumask *
+vduse_vdpa_get_vq_affinity(struct vdpa_device *vdpa, u16 idx)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+
+	return &dev->vqs[idx]->irq_affinity;
+}
+
 static int vduse_vdpa_set_map(struct vdpa_device *vdpa,
 				unsigned int asid,
 				struct vhost_iotlb *iotlb)
@@ -773,6 +781,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.set_config		= vduse_vdpa_set_config,
 	.get_generation		= vduse_vdpa_get_generation,
 	.set_vq_affinity	= vduse_vdpa_set_vq_affinity,
+	.get_vq_affinity	= vduse_vdpa_get_vq_affinity,
 	.reset			= vduse_vdpa_reset,
 	.set_map		= vduse_vdpa_set_map,
 	.free			= vduse_vdpa_free,
-- 
2.20.1

