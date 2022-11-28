Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB09A63A2D6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiK1IYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiK1IYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:24:03 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885AEB56;
        Mon, 28 Nov 2022 00:24:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DBA85CE0B64;
        Mon, 28 Nov 2022 08:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC284C433D6;
        Mon, 28 Nov 2022 08:23:57 +0000 (UTC)
Message-ID: <9d559d56-b042-9955-f7d1-20c50c2c8e03@xs4all.nl>
Date:   Mon, 28 Nov 2022 09:23:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH RESEND] media: videobuf2: revert "get_userptr: buffers are
 always writable"
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Hirokazu Honda <hiroh@chromium.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 707947247e95 ("media: videobuf2-vmalloc: get_userptr: buffers are
always writable") caused problems in a corner case (passing read-only
shmem memory as a userptr). So revert this patch.

The original problem for which that commit was originally made is
something that I could not reproduce after reverting it. So just go
back to the way it was for many years, and if problems arise in
the future, then another approach should be taken to resolve it.

This patch is based on a patch from Hirokazu.

Fixes: 707947247e95 ("media: videobuf2-vmalloc: get_userptr: buffers are always writable")
Signed-off-by: Hirokazu Honda <hiroh@chromium.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
CCed also to Andrew, linux-mm and linux-kernel. This patch is meant to be
first in David Hildenbrand's 'remove FOLL_FORCE' series to ensure that it
will be easy to backport this fix to older kernels without introducing new
merge conflicts.

Hans
---
 drivers/media/common/videobuf2/frame_vector.c         | 10 +++++++---
 drivers/media/common/videobuf2/videobuf2-dma-contig.c |  3 ++-
 drivers/media/common/videobuf2/videobuf2-dma-sg.c     |  4 +++-
 drivers/media/common/videobuf2/videobuf2-memops.c     |  6 ++++--
 drivers/media/common/videobuf2/videobuf2-vmalloc.c    |  4 +++-
 include/media/frame_vector.h                          |  2 +-
 include/media/videobuf2-memops.h                      |  3 ++-
 7 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/media/common/videobuf2/frame_vector.c b/drivers/media/common/videobuf2/frame_vector.c
index 542dde9d2609..aad72640f055 100644
--- a/drivers/media/common/videobuf2/frame_vector.c
+++ b/drivers/media/common/videobuf2/frame_vector.c
@@ -14,6 +14,7 @@
  * get_vaddr_frames() - map virtual addresses to pfns
  * @start:	starting user address
  * @nr_frames:	number of pages / pfns from start to map
+ * @write:	the mapped address has write permission
  * @vec:	structure which receives pages / pfns of the addresses mapped.
  *		It should have space for at least nr_frames entries.
  *
@@ -32,7 +33,7 @@
  *
  * This function takes care of grabbing mmap_lock as necessary.
  */
-int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
+int get_vaddr_frames(unsigned long start, unsigned int nr_frames, bool write,
 		     struct frame_vector *vec)
 {
 	struct mm_struct *mm = current->mm;
@@ -40,6 +41,7 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
 	int ret_pin_user_pages_fast = 0;
 	int ret = 0;
 	int err;
+	unsigned int gup_flags = FOLL_FORCE | FOLL_LONGTERM;

 	if (nr_frames == 0)
 		return 0;
@@ -49,8 +51,10 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,

 	start = untagged_addr(start);

-	ret = pin_user_pages_fast(start, nr_frames,
-				  FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
+	if (write)
+		gup_flags |= FOLL_WRITE;
+
+	ret = pin_user_pages_fast(start, nr_frames, gup_flags,
 				  (struct page **)(vec->ptrs));
 	if (ret > 0) {
 		vec->got_ref = true;
diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
index 678b359717c4..8e55468cb60d 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
@@ -603,7 +603,8 @@ static void *vb2_dc_get_userptr(struct vb2_buffer *vb, struct device *dev,
 	buf->vb = vb;

 	offset = lower_32_bits(offset_in_page(vaddr));
-	vec = vb2_create_framevec(vaddr, size);
+	vec = vb2_create_framevec(vaddr, size, buf->dma_dir == DMA_FROM_DEVICE ||
+					       buf->dma_dir == DMA_BIDIRECTIONAL);
 	if (IS_ERR(vec)) {
 		ret = PTR_ERR(vec);
 		goto fail_buf;
diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index fa69158a65b1..099693e42bc6 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -241,7 +241,9 @@ static void *vb2_dma_sg_get_userptr(struct vb2_buffer *vb, struct device *dev,
 	buf->size = size;
 	buf->dma_sgt = &buf->sg_table;
 	buf->vb = vb;
-	vec = vb2_create_framevec(vaddr, size);
+	vec = vb2_create_framevec(vaddr, size,
+				  buf->dma_dir == DMA_FROM_DEVICE ||
+				  buf->dma_dir == DMA_BIDIRECTIONAL);
 	if (IS_ERR(vec))
 		goto userptr_fail_pfnvec;
 	buf->vec = vec;
diff --git a/drivers/media/common/videobuf2/videobuf2-memops.c b/drivers/media/common/videobuf2/videobuf2-memops.c
index 9dd6c27162f4..f9a4ec44422e 100644
--- a/drivers/media/common/videobuf2/videobuf2-memops.c
+++ b/drivers/media/common/videobuf2/videobuf2-memops.c
@@ -26,6 +26,7 @@
  * vb2_create_framevec() - map virtual addresses to pfns
  * @start:	Virtual user address where we start mapping
  * @length:	Length of a range to map
+ * @write:	Should we map for writing into the area
  *
  * This function allocates and fills in a vector with pfns corresponding to
  * virtual address range passed in arguments. If pfns have corresponding pages,
@@ -34,7 +35,8 @@
  * failure. Returned vector needs to be freed via vb2_destroy_pfnvec().
  */
 struct frame_vector *vb2_create_framevec(unsigned long start,
-					 unsigned long length)
+					 unsigned long length,
+					 bool write)
 {
 	int ret;
 	unsigned long first, last;
@@ -47,7 +49,7 @@ struct frame_vector *vb2_create_framevec(unsigned long start,
 	vec = frame_vector_create(nr);
 	if (!vec)
 		return ERR_PTR(-ENOMEM);
-	ret = get_vaddr_frames(start & PAGE_MASK, nr, vec);
+	ret = get_vaddr_frames(start & PAGE_MASK, nr, write, vec);
 	if (ret < 0)
 		goto out_destroy;
 	/* We accept only complete set of PFNs */
diff --git a/drivers/media/common/videobuf2/videobuf2-vmalloc.c b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
index 948152f1596b..67d0b89e701b 100644
--- a/drivers/media/common/videobuf2/videobuf2-vmalloc.c
+++ b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
@@ -85,7 +85,9 @@ static void *vb2_vmalloc_get_userptr(struct vb2_buffer *vb, struct device *dev,
 	buf->dma_dir = vb->vb2_queue->dma_dir;
 	offset = vaddr & ~PAGE_MASK;
 	buf->size = size;
-	vec = vb2_create_framevec(vaddr, size);
+	vec = vb2_create_framevec(vaddr, size,
+				  buf->dma_dir == DMA_FROM_DEVICE ||
+				  buf->dma_dir == DMA_BIDIRECTIONAL);
 	if (IS_ERR(vec)) {
 		ret = PTR_ERR(vec);
 		goto fail_pfnvec_create;
diff --git a/include/media/frame_vector.h b/include/media/frame_vector.h
index bfed1710dc24..541c71a2c7be 100644
--- a/include/media/frame_vector.h
+++ b/include/media/frame_vector.h
@@ -16,7 +16,7 @@ struct frame_vector {
 struct frame_vector *frame_vector_create(unsigned int nr_frames);
 void frame_vector_destroy(struct frame_vector *vec);
 int get_vaddr_frames(unsigned long start, unsigned int nr_pfns,
-		     struct frame_vector *vec);
+		     bool write, struct frame_vector *vec);
 void put_vaddr_frames(struct frame_vector *vec);
 int frame_vector_to_pages(struct frame_vector *vec);
 void frame_vector_to_pfns(struct frame_vector *vec);
diff --git a/include/media/videobuf2-memops.h b/include/media/videobuf2-memops.h
index cd4a46331531..4b5b84f93538 100644
--- a/include/media/videobuf2-memops.h
+++ b/include/media/videobuf2-memops.h
@@ -34,7 +34,8 @@ struct vb2_vmarea_handler {
 extern const struct vm_operations_struct vb2_common_vm_ops;

 struct frame_vector *vb2_create_framevec(unsigned long start,
-					 unsigned long length);
+					 unsigned long length,
+					 bool write);
 void vb2_destroy_framevec(struct frame_vector *vec);

 #endif
-- 
2.35.1

