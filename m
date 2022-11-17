Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4F362D273
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 06:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbiKQFAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 00:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKQFAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:00:12 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7D0326EC;
        Wed, 16 Nov 2022 21:00:10 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id t4so538487wmj.5;
        Wed, 16 Nov 2022 21:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a0T3rjzlpFW1dw7fmW7g8x4Gy61zgYU1JKH4cxrgdu0=;
        b=JY4NfYAIbFCUofUSLplovnKa/5072s2jFLYAMFlFQTFUbXFj+lybMXgGHevupGBX7p
         QaVDIl/1Y2+6v9KgYyGo6gU/j0kak1gX8EHWtw8/22y1EJlPQ84PglSV4mSujDZPqPfE
         bp3FcH5y1InMVpXhOZp7npliwhHmefhHL9noUixdN5Sxh1zcfHcs4Ndrddj8P1q1gfC+
         SZn3/z4rgmLG2ve4UMuQKtujwgYniEUEo4KGPjXNrROT68k7dYpw7KdSh8Blzxu9QjMn
         OkZWoM17fmFmuMiE1wkw+1FKoBbY4E9MJROa6sEbJkaC9L+ADXsgWz84KfEITl3HmSqP
         iojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0T3rjzlpFW1dw7fmW7g8x4Gy61zgYU1JKH4cxrgdu0=;
        b=GhNr99AFOY4XTOZ1e57jfv0v220NmM3W0t8lKFPc/0/SSk3qPJDPJfIi6WI2tTNnGn
         cfQOuLigs1v52iwPep1A8Cp6E+M9f2dfRtf9+5wKotcS+2LoEQqjTCfx1AMDW2tworVE
         TtqV3LKL2LawMYyz31UfSSVBDVC5lYLL74PrQV4a5NmNPaF6OwEXyjOWgTMtcs4vUEDT
         EQlr55HpKNv2q2NeEwJmqbZS6OcyYZEFn6pExCujCjtXMQAuf2bD+oOTJ5sum+OWcaVw
         IpUN7jZi6C1Em/6Sg/Bo3WC4IarfbC+FSiCN89rGS+xBktoBAGHnIL5M2BZnBDGDeeRu
         JNsw==
X-Gm-Message-State: ANoB5pmlZcR9FuagEhByEKzolon0pW5H0UurUpZ90GcsRHeMpnom8TuW
        yFPS5BMfTD5wlYzLul7M0Rk=
X-Google-Smtp-Source: AA0mqf7zt8lCXlLCEU+O4UjtV2JiwlMTevqkPDwcLnqmw94gQJiXUrNyAhJ3EkaPswdWgtv9ry3OPw==
X-Received: by 2002:a05:600c:5010:b0:3cf:b067:416c with SMTP id n16-20020a05600c501000b003cfb067416cmr4064198wmr.134.1668661209301;
        Wed, 16 Nov 2022 21:00:09 -0800 (PST)
Received: from localhost.localdomain (user-5-173-65-115.play-internet.pl. [5.173.65.115])
        by smtp.googlemail.com with ESMTPSA id q10-20020adff94a000000b0022cc6b8df5esm16512143wrr.7.2022.11.16.21.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 21:00:08 -0800 (PST)
From:   Lukasz Wiecaszek <lukasz.wiecaszek@googlemail.com>
X-Google-Original-From: Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] udmabuf: add vmap and vunmap methods to udmabuf_ops
Date:   Thu, 17 Nov 2022 05:58:41 +0100
Message-Id: <20221117045842.27161-1-lukasz.wiecaszek@gmail.com>
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

videobuf2_common: __vb2_queue_alloc: allocated 3 buffers, 1 plane(s) each
videobuf2_common: __prepare_dmabuf: buffer for plane 0 changed
videobuf2_common: __prepare_dmabuf: failed to map dmabuf for plane 0
videobuf2_common: __buf_prepare: buffer preparation failed: -14

The patch itself seems to be strighforward.
It adds implementation of .vmap and .vunmap methods
to 'struct dma_buf_ops udmabuf_ops'.
.vmap method itself uses vm_map_ram() to map pages linearly
into the kernel virtual address space.
.vunmap removes mapping created earlier by .vmap.
All locking and 'vmapping counting' is done in dma_buf.c
so it seems to be redundant/unnecessary in .vmap/.vunmap.

Signed-off-by: Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>
---
v1: https://lore.kernel.org/linux-media/202211120352.G7WPASoP-lkp@intel.com/T/#t
v2: https://lore.kernel.org/linux-media/20221114052944.GA7264@thinkpad-p72/T/#t
v3: https://lore.kernel.org/linux-media/4f92e95f-a0dc-4eac-4c08-0df85de78ae7@collabora.com/T/#t

v3 -> v4: Removed line/info 'reported by kernel test robot'
v2 -> v3: Added .vunmap to 'struct dma_buf_ops udmabuf_ops'
v1 -> v2: Patch prepared and tested against 6.1.0-rc2+

 drivers/dma-buf/udmabuf.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 283816fbd72f..740d6e426ee9 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -13,6 +13,8 @@
 #include <linux/slab.h>
 #include <linux/udmabuf.h>
 #include <linux/hugetlb.h>
+#include <linux/vmalloc.h>
+#include <linux/iosys-map.h>
 
 static int list_limit = 1024;
 module_param(list_limit, int, 0644);
@@ -60,6 +62,30 @@ static int mmap_udmabuf(struct dma_buf *buf, struct vm_area_struct *vma)
 	return 0;
 }
 
+static int vmap_udmabuf(struct dma_buf *buf, struct iosys_map *map)
+{
+	struct udmabuf *ubuf = buf->priv;
+	void *vaddr;
+
+	dma_resv_assert_held(buf->resv);
+
+	vaddr = vm_map_ram(ubuf->pages, ubuf->pagecount, -1);
+	if (!vaddr)
+		return -EINVAL;
+
+	iosys_map_set_vaddr(map, vaddr);
+	return 0;
+}
+
+static void vunmap_udmabuf(struct dma_buf *buf, struct iosys_map *map)
+{
+	struct udmabuf *ubuf = buf->priv;
+
+	dma_resv_assert_held(buf->resv);
+
+	vm_unmap_ram(map->vaddr, ubuf->pagecount);
+}
+
 static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 				     enum dma_data_direction direction)
 {
@@ -162,6 +188,8 @@ static const struct dma_buf_ops udmabuf_ops = {
 	.unmap_dma_buf	   = unmap_udmabuf,
 	.release	   = release_udmabuf,
 	.mmap		   = mmap_udmabuf,
+	.vmap		   = vmap_udmabuf,
+	.vunmap		   = vunmap_udmabuf,
 	.begin_cpu_access  = begin_cpu_udmabuf,
 	.end_cpu_access    = end_cpu_udmabuf,
 };
-- 
2.25.1

