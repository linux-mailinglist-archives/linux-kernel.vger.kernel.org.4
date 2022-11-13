Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0590627024
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 16:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbiKMPHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 10:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiKMPH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 10:07:29 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641BBCE19;
        Sun, 13 Nov 2022 07:07:27 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id a29so15424777lfj.9;
        Sun, 13 Nov 2022 07:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=umo/xdUlQSYAVDNNJIA7iJ7EdK6y2kGfWONuMRbs/TA=;
        b=e9lTnIlyKgsqjF+MrXGgxFYkfUbeoadmoDhRaLkeApmUoQyroEV1yTWy4iBDU1GumZ
         62VNSeshYUqjvZZbIHfhXRtyMracJ8xvEOAczV4BS+SEd1pi2iigs1dHU9Wxb7YtmCLx
         xjGJM9yQZtIv/IbvoNb5hKb2yBGm3fJMxDNLcE68BXXRZQr1yfj5gAME1iZDEz+89it6
         GrCDPrM3HbifmuqJMEfb3MKlY9t+1IJrgG+fqEJIVXBe424P41VyQoxGToyLhgwYCFNH
         Syk3lZzZGTXghlpw64V8xD+ing6+wBvllMX82FHDHhzDUF7YjizxP5TBsHt7LGylUMwG
         l97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umo/xdUlQSYAVDNNJIA7iJ7EdK6y2kGfWONuMRbs/TA=;
        b=pZrD6CxrZwzUiQpC125o/md6Y9DyUf6Uxgt6ttmV10BROj+aOwZxpMqOOsSUTI80IM
         TYC/kZXSijkdR4m1dQK2sJ0RkWlmF1QgZ/027XhcGo/n0TLOpjbBGMxf04YCLYRzQ5gK
         TG6y1yNEWCsjKRroNLjmPUQG6CPxz6T5u8NDmcOLMa57vgIGlZ603ZKKipy2LcS8PFXj
         tw0xD9ajRnaMFaDV9PWsD6tK7bGpismHOBGHL5tJf5yIXjPUx7id1u2KUoEBe/V6LmVG
         yFkx26CFpR1aLBTzVEAotT37XKnNA9NmS33xmzXPy1GqOvEO+gpdJflGXAGjQugdMV18
         MfZg==
X-Gm-Message-State: ANoB5pnKI1xFUhx9/HV5NAHmZMGxtAPeKfaDVvW3vWkiRapHflrVwtn8
        LdnPSIW101AGrp2IN+ImcqU=
X-Google-Smtp-Source: AA0mqf4TUvlSQjy+LPxsa8mUnyhfgrZ2+hMCJe8GBO7bMH6joUroCaeCl6wu7cYoNIms96wVInnnWw==
X-Received: by 2002:a05:6512:2305:b0:4b1:8698:9f3e with SMTP id o5-20020a056512230500b004b186989f3emr2911401lfu.421.1668352045590;
        Sun, 13 Nov 2022 07:07:25 -0800 (PST)
Received: from localhost.localdomain (185-48-128-212.net.cybernetwmw.com. [185.48.128.212])
        by smtp.googlemail.com with ESMTPSA id j26-20020ac2455a000000b004979ec19387sm1397753lfm.305.2022.11.13.07.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 07:07:25 -0800 (PST)
From:   Lukasz Wiecaszek <lukasz.wiecaszek@googlemail.com>
X-Google-Original-From: Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] udmabuf: add vmap method to udmabuf_ops
Date:   Sun, 13 Nov 2022 16:05:11 +0100
Message-Id: <20221113150511.8878-1-lukasz.wiecaszek@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reason behind that patch is associated with videobuf2 subsystem
(or more genrally with v4l2 framework) and user created
dma buffers (udmabuf). In some circumstances
when dealing with V4L2_MEMORY_DMABUF buffers videobuf2 subsystem
wants to use dma_buf_vmap() method on the attached dma buffer.
As udmabuf does not have .vmap operation implemented,
such dma_buf_vmap() natually fails.

videobuf2_common: [cap-000000003473b2f1] __vb2_queue_alloc: allocated 3 buffers, 1 plane(s) each
videobuf2_common: [cap-000000003473b2f1] __prepare_dmabuf: buffer for plane 0 changed
videobuf2_common: [cap-000000003473b2f1] __prepare_dmabuf: failed to map dmabuf for plane 0
videobuf2_common: [cap-000000003473b2f1] __buf_prepare: buffer preparation failed: -14

The patch itself seems to be strighforward.
It adds implementation of .vmap method to 'struct dma_buf_ops udmabuf_ops'.
.vmap method itself uses vm_map_ram() to map pages linearly
into the kernel virtual address space (only if such mapping
hasn't been created yet).

Signed-off-by: Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
---
v1: https://lore.kernel.org/linux-media/202211120352.G7WPASoP-lkp@intel.com/T/#t

v1 -> v2: Patch prepared and tested against 6.1.0-rc2+

 drivers/dma-buf/udmabuf.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 2bcdb935a3ac..2ca0e3639360 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -12,6 +12,8 @@
 #include <linux/slab.h>
 #include <linux/udmabuf.h>
 #include <linux/hugetlb.h>
+#include <linux/vmalloc.h>
+#include <linux/iosys-map.h>
 
 static int list_limit = 1024;
 module_param(list_limit, int, 0644);
@@ -26,6 +28,7 @@ struct udmabuf {
 	struct page **pages;
 	struct sg_table *sg;
 	struct miscdevice *device;
+	void *vaddr;
 };
 
 static vm_fault_t udmabuf_vm_fault(struct vm_fault *vmf)
@@ -57,6 +60,21 @@ static int mmap_udmabuf(struct dma_buf *buf, struct vm_area_struct *vma)
 	return 0;
 }
 
+static int vmap_udmabuf(struct dma_buf *buf, struct iosys_map *map)
+{
+	struct udmabuf *ubuf = buf->priv;
+
+	if (!ubuf->vaddr) {
+		ubuf->vaddr = vm_map_ram(ubuf->pages, ubuf->pagecount, -1);
+		if (!ubuf->vaddr)
+			return -EINVAL;
+	}
+
+	iosys_map_set_vaddr(map, ubuf->vaddr);
+
+	return 0;
+}
+
 static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 				     enum dma_data_direction direction)
 {
@@ -159,6 +177,7 @@ static const struct dma_buf_ops udmabuf_ops = {
 	.unmap_dma_buf	   = unmap_udmabuf,
 	.release	   = release_udmabuf,
 	.mmap		   = mmap_udmabuf,
+	.vmap		   = vmap_udmabuf,
 	.begin_cpu_access  = begin_cpu_udmabuf,
 	.end_cpu_access    = end_cpu_udmabuf,
 };
-- 
2.25.1

