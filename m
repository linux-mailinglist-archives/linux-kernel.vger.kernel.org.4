Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F965E9D07
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbiIZJLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbiIZJLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:11:40 -0400
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C2F3B948
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:11:38 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id VKM00133;
        Mon, 26 Sep 2022 17:11:33 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2507.12; Mon, 26 Sep 2022 17:11:31 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] virtio_ring: remove unnecessary to_vvq() call
Date:   Mon, 26 Sep 2022 05:11:30 -0400
Message-ID: <20220926091130.9244-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   2022926171133d6dd2f1451e4b2b3042fc445a84fcdfb
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It passes '_vq' to vring_free(), which still calls to_vvq()
to get 'vq', let's directly pass 'vq'. It can avoid
unnecessary call of to_vvq() in hot path.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/virtio/virtio_ring.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 8974c34b40fd..d6d77bf58802 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -221,7 +221,7 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 					       void (*callback)(struct virtqueue *),
 					       const char *name);
 static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
-static void vring_free(struct virtqueue *_vq);
+static void vring_free(struct vring_virtqueue *vq);
 
 /*
  * Helpers.
@@ -1140,7 +1140,7 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
 	if (err)
 		goto err_state_extra;
 
-	vring_free(&vq->vq);
+	vring_free(vq);
 
 	virtqueue_vring_init_split(&vring_split, vq);
 
@@ -2059,7 +2059,7 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
 	if (err)
 		goto err_state_extra;
 
-	vring_free(&vq->vq);
+	vring_free(vq);
 
 	virtqueue_vring_init_packed(&vring_packed, !!vq->vq.callback);
 
@@ -2649,10 +2649,8 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 }
 EXPORT_SYMBOL_GPL(vring_new_virtqueue);
 
-static void vring_free(struct virtqueue *_vq)
+static void vring_free(struct vring_virtqueue *vq)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
-
 	if (vq->we_own_ring) {
 		if (vq->packed_ring) {
 			vring_free_queue(vq->vq.vdev,
@@ -2693,7 +2691,7 @@ void vring_del_virtqueue(struct virtqueue *_vq)
 	list_del(&_vq->list);
 	spin_unlock(&vq->vq.vdev->vqs_list_lock);
 
-	vring_free(_vq);
+	vring_free(vq);
 
 	kfree(vq);
 }
-- 
2.27.0

