Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B235F6249
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiJFIG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiJFIG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:06:56 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5522A406
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:06:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VRPuuLR_1665043580;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VRPuuLR_1665043580)
          by smtp.aliyun-inc.com;
          Thu, 06 Oct 2022 16:06:51 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] virtio_ring: remove unnecessary variables in virtqueue_add_packed
Date:   Thu,  6 Oct 2022 16:06:20 +0800
Message-Id: <1665043580-10009-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Song <liusong@linux.alibaba.com>

Unlike "virtqueue_add_split", "descs_used" will only be equal
to "total_sg" in the context of "virtqueue_add_packed", so it
can be removed to reduce unnecessary operations.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 2e7689b..2f5b900 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1353,7 +1353,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
-	unsigned int i, n, c, descs_used, err_idx;
+	unsigned int i, n, c, err_idx;
 	__le16 head_flags, flags;
 	u16 head, id, prev, curr, avail_used_flags;
 	int err;
@@ -1390,11 +1390,10 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 
 	desc = vq->packed.vring.desc;
 	i = head;
-	descs_used = total_sg;
 
-	if (unlikely(vq->vq.num_free < descs_used)) {
+	if (unlikely(vq->vq.num_free < total_sg)) {
 		pr_debug("Can't add buf len %i - avail = %i\n",
-			 descs_used, vq->vq.num_free);
+			 total_sg, vq->vq.num_free);
 		END_USE(vq);
 		return -ENOSPC;
 	}
@@ -1445,14 +1444,14 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 		vq->packed.avail_wrap_counter ^= 1;
 
 	/* We're using some buffers from the free list. */
-	vq->vq.num_free -= descs_used;
+	vq->vq.num_free -= total_sg;
 
 	/* Update free pointer */
 	vq->packed.next_avail_idx = i;
 	vq->free_head = curr;
 
 	/* Store token. */
-	vq->packed.desc_state[id].num = descs_used;
+	vq->packed.desc_state[id].num = total_sg;
 	vq->packed.desc_state[id].data = data;
 	vq->packed.desc_state[id].indir_desc = ctx;
 	vq->packed.desc_state[id].last = prev;
@@ -1464,7 +1463,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	 */
 	virtio_wmb(vq->weak_barriers);
 	vq->packed.vring.desc[head].flags = head_flags;
-	vq->num_added += descs_used;
+	vq->num_added += total_sg;
 
 	pr_debug("Added buffer head %i to %p\n", head, vq);
 	END_USE(vq);
-- 
1.8.3.1

