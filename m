Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2169C62E2DE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240634AbiKQRUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240009AbiKQRTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:19:44 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DCB30F70;
        Thu, 17 Nov 2022 09:19:43 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ft34so6656086ejc.12;
        Thu, 17 Nov 2022 09:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vQyLviGauL30ZeO1VGGTeRWRAcWIrY0ASAZn99FKrKk=;
        b=fy3Tzc3SpdWc06CoKx7g1QwwPHkHOB52LAGG2x0xRXgBBRgB+lhzB4dijn+MMgvCeo
         +5REjnoYlMAIGg9muDOehuGTyb3yMonp7FWDWMeDx+kccf8/GI9w7Gb37iOlCByty0Io
         gAEBG+4wDRyCNpGARhe8IWVrC34XHmo8N2d/bzPgnmD/e573rG5YdA0eYNnJM9TNaP0J
         7TqYmvcQfO0ReBOxz+w820/rvEZB03wQ6CleZceh6xToQnloUYi5RF3I6CHeY/Y9q/ws
         SCeMehGPWjpATVnss7nV36hcQp+q6iM8X81Uuqd8taY5/ezLJqtp5750TZJKQHOhUNAP
         X7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQyLviGauL30ZeO1VGGTeRWRAcWIrY0ASAZn99FKrKk=;
        b=wN+VCoHt/PQMFMWODTY+KttQV0pjPT6o61I7BDRhyLLcfr4w7AVUfBCBmTCe2yxxeE
         39Xkr+QWiVkTatybCaB6lDIjwJG6gn40r5Ndaqti2E7BGICPRiEaFBRfMPZeVZV0O/8F
         pUB8CpunFwEgzag8Tz8h7uyWuATo+wOb57yInYeMUQvZ4G+pBXbhwfYI/QKGl8K2a1Mv
         L5nF9Kg9EcWWT41j8Z8G7hqFtBvgM5EUIxpGeku7+8TLvG6bSrM9y10nQB5Lfh5Bh8TO
         p+5lYpED+Uwbvsr/G9ycR/Y/1Itr5DuPvTYvx7HLUojv3uH1LLb0JiY3JjUYNAvAYWeO
         YEiQ==
X-Gm-Message-State: ANoB5pk5jedR1/uIsIOMTQWv0EaLCMqz9vGK+DK0R3wu0Nn6up6bR+Jo
        QeHPwpOFY3+fI5i7XGYlPFA=
X-Google-Smtp-Source: AA0mqf5kyd7O9Z2bUni4KE4HeakSPUmYiLtDLsMAABeqNZzbxLcNduSMzaOOHwW1pVRI0s/KYpzEVQ==
X-Received: by 2002:a17:906:1585:b0:7ad:84c7:502d with SMTP id k5-20020a170906158500b007ad84c7502dmr2879660ejd.177.1668705582464;
        Thu, 17 Nov 2022 09:19:42 -0800 (PST)
Received: from localhost.localdomain (user-5-173-65-115.play-internet.pl. [5.173.65.115])
        by smtp.googlemail.com with ESMTPSA id h5-20020a0564020e8500b00458a03203b1sm777561eda.31.2022.11.17.09.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 09:19:42 -0800 (PST)
From:   Lukasz Wiecaszek <lukasz.wiecaszek@googlemail.com>
X-Google-Original-From: Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] udmabuf: add vmap and vunmap methods to udmabuf_ops
Date:   Thu, 17 Nov 2022 18:18:09 +0100
Message-Id: <20221117171810.75637-1-lukasz.wiecaszek@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>
---
v1: https://lore.kernel.org/linux-media/202211120352.G7WPASoP-lkp@intel.com/T/#t
v2: https://lore.kernel.org/linux-media/20221114052944.GA7264@thinkpad-p72/T/#t
v3: https://lore.kernel.org/linux-media/4f92e95f-a0dc-4eac-4c08-0df85de78ae7@collabora.com/T/#t
v4: https://lore.kernel.org/linux-media/970e798d-ea26-5e1e-ace8-7915a866f7c7@collabora.com/T/#t

v4 -> v5: Added Acked-by and Reviewed-by to the commit message
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

