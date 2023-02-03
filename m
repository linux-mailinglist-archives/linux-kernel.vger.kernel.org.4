Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED026894BA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjBCKFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbjBCKEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:04:52 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA837AB8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 02:04:35 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id q9so3294718pgq.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 02:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvkPNyoI21L1O1ZXqnPivyYsybrN0iSYwKMSsS9iBxY=;
        b=TqjFeV9NPabsrfxavmrb7rr4cepsXNVmar2XDnjWglQ4DpUZOEWO0vbof2f6/PWByH
         TWPQ6ZPNP6HE8OHwVXgsN4cLeRU45MuHFl7+sXcxz/goXguLdPUp5EaQdczVZii0TnRU
         56+g060uaBaRC/sQePmL3oY2BIg34qhXBIIWyRDe2ZJzg3OPQbZuMcuHyZJUj2ri7cf0
         yuNBhzZootgd4cpgTrxv8MnVNn8cRif/DT/a2lN1/C7YIzMTvlQpeAyQHnRCn1WWpJru
         oR0UGu6lSvrN2WUAygdOHInk27VqgNpQPc+kJQyzjoYfNXIN4ID5G5JP2aK3zvTaHo0A
         1yeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvkPNyoI21L1O1ZXqnPivyYsybrN0iSYwKMSsS9iBxY=;
        b=qHqCX1XutwcNs5Ohp7h9zJ+A7z/tVBq/fmOgIIoC/tQ9WmvrlRxFU3z0APxAYMriN8
         g1z/NFRLHGgl4ZQ8JJ/Yg1c57kLO1RMQ/FVQBUwtPGj8ieG5x0WgiU3V2qiyoTL2b2LD
         95JJkur8ZuymJrHKC2aZU2+SvEEOgrbBUlFgBUA3NdMLwdIXvcDwKespvLLSYuJOISwU
         vayPZf/U6/sDsDPXAF7dhMNhOjsfqnxMqahrwoXQsmMVw2bdvrQAoSM1QGIdfpwIPT1o
         flQ/h1Z+8BIpES4AcIEd9/wL5H3QgZFRPK7Rc9ByU1FIPCO5juuZJEij4nNe6hYAkBx7
         2NKg==
X-Gm-Message-State: AO0yUKXHZAmmn3pjKXaASjss2NZiBTfYYfd+qYZnfDWUpIMeWdys/FT3
        AAg+i3hR9PPVArAqlAp+/03KLA==
X-Google-Smtp-Source: AK7set+mf9v1p9GMNQBqGbUdP6b8/Tyam+p9edVCarZOEBqKLwxUJFvaDV8vt4ESUw73/JkS5RjeOw==
X-Received: by 2002:a05:6a00:23d6:b0:593:d111:a071 with SMTP id g22-20020a056a0023d600b00593d111a071mr10889148pfc.9.1675418674729;
        Fri, 03 Feb 2023 02:04:34 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id d3-20020aa797a3000000b0058d8f23af26sm1278885pfq.157.2023.02.03.02.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 02:04:34 -0800 (PST)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Shunsuke Mie <mie@igel.co.jp>, Frank Li <Frank.Li@nxp.com>,
        Jon Mason <jdmason@kudzu.us>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Takanari Hayama <taki@igel.co.jp>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 2/4] virtio_ring: remove const from vring getter
Date:   Fri,  3 Feb 2023 19:04:16 +0900
Message-Id: <20230203100418.2981144-3-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230203100418.2981144-1-mie@igel.co.jp>
References: <20230203100418.2981144-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some method to manage the virto ring in Linux kernel. e.g. vhost
and vringh. Remove const from the getter in order to control vring with
other APIs, such as vringh.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
Signed-off-by: Takanari Hayama <taki@igel.co.jp>
---
 drivers/virtio/virtio_ring.c | 2 +-
 include/linux/virtio.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 2e7689bb933b..aa0c455d402b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2857,7 +2857,7 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
 EXPORT_SYMBOL_GPL(virtqueue_get_used_addr);
 
 /* Only available for split ring */
-const struct vring *virtqueue_get_vring(struct virtqueue *vq)
+struct vring *virtqueue_get_vring(struct virtqueue *vq)
 {
 	return &to_vvq(vq)->split.vring;
 }
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index dcab9c7e8784..83530b7bc2e9 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -88,7 +88,7 @@ unsigned int virtqueue_get_vring_size(struct virtqueue *vq);
 
 bool virtqueue_is_broken(struct virtqueue *vq);
 
-const struct vring *virtqueue_get_vring(struct virtqueue *vq);
+struct vring *virtqueue_get_vring(struct virtqueue *vq);
 dma_addr_t virtqueue_get_desc_addr(struct virtqueue *vq);
 dma_addr_t virtqueue_get_avail_addr(struct virtqueue *vq);
 dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
-- 
2.25.1

