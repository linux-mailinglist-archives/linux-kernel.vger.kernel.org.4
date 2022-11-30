Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3F763CC41
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 01:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiK3AIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 19:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiK3AIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 19:08:45 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5134042F52
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 16:08:44 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 6so14543440pgm.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 16:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1uNcYpPMrI5BUKS+4cI51gDVBMIA/yEg/AUAY95wTKw=;
        b=e/AzuKdsYAHWb3FkvHU4t2hkVxTQgkWyNmOJcccAWQKcQNHjzJPNvB3Cnkq5ORn7v1
         OsHP3UW2UdgIK3u6lfFonG9+MPSdES8+DKsxsJPDdmjmHwN6YlezNNl7FvGJAi8fMrZn
         4fJdUwmF2yZArXNGkx+dWVyyK3xIOBDOzhL5Ew3IMw4uEHbVj2zk7Z13XXR3bEfkorbp
         qQDO9pjAjjvgEVIuu8rcP3lfePEHPerKjqj81D3U8onXLsYHRz83qDSCS14MLk2AKWOW
         bviWwz9juRxi2LQopPz3D3oAFbJnPjsNq0Ulu+AwV5JXmvYfPF8FtdDda6iSN+vZYyH3
         NR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1uNcYpPMrI5BUKS+4cI51gDVBMIA/yEg/AUAY95wTKw=;
        b=iH/313v0GtkdsViOehNP4ivc29R4qZmOUNzB69z14rbDxu5VkDWfYAjJqZPGmkmbim
         ra37U+sqL9rI+xIG06i0iuyUyYeevH7R+i5pJkD9UCieuN5FasNNbkmYUsHTjRkxckxJ
         lMhNo11+pTHv2h7X6LnXzW6kV5pY1Cz/Ii3wOS0SPAZ7BiIgGNw8pmPCubDqSoTJgsR2
         2a1eRBcLeuqBuktOqKfRFJrr10J8DhjHtblO3hGOcu3ArX1GNLjpsGBOnLR/jUoFDtQp
         fJSOCayilFHVSiFxzbNFWuyTb3BWhPDNlfBXlRJHmcNqF6P8Z1mJZ4Tbmad9whosgFmK
         xSsg==
X-Gm-Message-State: ANoB5pnMHYzs3mXOExoqDuqHfj/FAatJ8Y270A0z49AfBKkSElZOsd33
        bXuDcZu1YsydTuLUvTk1m7U=
X-Google-Smtp-Source: AA0mqf6wrXy3pUVubbhsCKYanMOJSCDsa/HXBw7jsyjID2CJl9LuFqBBXRKBhg86aaf6OtYN8bcpSA==
X-Received: by 2002:a05:6a00:1812:b0:575:19b6:dfe9 with SMTP id y18-20020a056a00181200b0057519b6dfe9mr14574544pfa.16.1669766923741;
        Tue, 29 Nov 2022 16:08:43 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id x8-20020aa78f08000000b005745eb7ecc3sm38261pfr.209.2022.11.29.16.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 16:08:43 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm/virtio: Spiff out cmd queue/response traces
Date:   Tue, 29 Nov 2022 16:08:41 -0800
Message-Id: <20221130000841.318037-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.38.1
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

From: Rob Clark <robdclark@chromium.org>

Add a sequence # for more easily matching up cmd/resp, and the # of free
slots in the virtqueue to more easily see starvation issues.

v2: Fix handling of string fields as well

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  3 +++
 drivers/gpu/drm/virtio/virtgpu_trace.h | 26 +++++++++++++++-----------
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 13 ++++++++++---
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 9b98470593b0..cdc208d9238c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -166,6 +166,8 @@ struct virtio_gpu_vbuffer {
 
 	struct virtio_gpu_object_array *objs;
 	struct list_head list;
+
+	uint32_t seqno;
 };
 
 struct virtio_gpu_output {
@@ -195,6 +197,7 @@ struct virtio_gpu_queue {
 	spinlock_t qlock;
 	wait_queue_head_t ack_queue;
 	struct work_struct dequeue_work;
+	uint32_t seqno;
 };
 
 struct virtio_gpu_drv_capset {
diff --git a/drivers/gpu/drm/virtio/virtgpu_trace.h b/drivers/gpu/drm/virtio/virtgpu_trace.h
index 711ecc2bd241..031bc77689d5 100644
--- a/drivers/gpu/drm/virtio/virtgpu_trace.h
+++ b/drivers/gpu/drm/virtio/virtgpu_trace.h
@@ -9,40 +9,44 @@
 #define TRACE_INCLUDE_FILE virtgpu_trace
 
 DECLARE_EVENT_CLASS(virtio_gpu_cmd,
-	TP_PROTO(struct virtqueue *vq, struct virtio_gpu_ctrl_hdr *hdr),
-	TP_ARGS(vq, hdr),
+	TP_PROTO(struct virtqueue *vq, struct virtio_gpu_ctrl_hdr *hdr, u32 seqno),
+	TP_ARGS(vq, hdr, seqno),
 	TP_STRUCT__entry(
 			 __field(int, dev)
 			 __field(unsigned int, vq)
-			 __field(const char *, name)
+			 __string(name, vq->name)
 			 __field(u32, type)
 			 __field(u32, flags)
 			 __field(u64, fence_id)
 			 __field(u32, ctx_id)
+			 __field(u32, num_free)
+			 __field(u32, seqno)
 			 ),
 	TP_fast_assign(
 		       __entry->dev = vq->vdev->index;
 		       __entry->vq = vq->index;
-		       __entry->name = vq->name;
+		       __assign_str(name, vq->name);
 		       __entry->type = le32_to_cpu(hdr->type);
 		       __entry->flags = le32_to_cpu(hdr->flags);
 		       __entry->fence_id = le64_to_cpu(hdr->fence_id);
 		       __entry->ctx_id = le32_to_cpu(hdr->ctx_id);
+		       __entry->num_free = vq->num_free;
+		       __entry->seqno = seqno;
 		       ),
-	TP_printk("vdev=%d vq=%u name=%s type=0x%x flags=0x%x fence_id=%llu ctx_id=%u",
-		  __entry->dev, __entry->vq, __entry->name,
+	TP_printk("vdev=%d vq=%u name=%s type=0x%x flags=0x%x fence_id=%llu ctx_id=%u num_free=%u seqno=%u",
+		  __entry->dev, __entry->vq, __get_str(name),
 		  __entry->type, __entry->flags, __entry->fence_id,
-		  __entry->ctx_id)
+		  __entry->ctx_id, __entry->num_free, __entry->seqno)
 );
 
 DEFINE_EVENT(virtio_gpu_cmd, virtio_gpu_cmd_queue,
-	TP_PROTO(struct virtqueue *vq, struct virtio_gpu_ctrl_hdr *hdr),
-	TP_ARGS(vq, hdr)
+	TP_PROTO(struct virtqueue *vq, struct virtio_gpu_ctrl_hdr *hdr, u32 seqno),
+	TP_ARGS(vq, hdr, seqno)
 );
 
 DEFINE_EVENT(virtio_gpu_cmd, virtio_gpu_cmd_response,
-	TP_PROTO(struct virtqueue *vq, struct virtio_gpu_ctrl_hdr *hdr),
-	TP_ARGS(vq, hdr)
+	TP_PROTO(struct virtqueue *vq, struct virtio_gpu_ctrl_hdr *hdr, u32 seqno),
+	TP_ARGS(vq, hdr, seqno)
 );
 
 #endif
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 9ff8660b50ad..a04a9b20896d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -215,7 +215,7 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work)
 	list_for_each_entry(entry, &reclaim_list, list) {
 		resp = (struct virtio_gpu_ctrl_hdr *)entry->resp_buf;
 
-		trace_virtio_gpu_cmd_response(vgdev->ctrlq.vq, resp);
+		trace_virtio_gpu_cmd_response(vgdev->ctrlq.vq, resp, entry->seqno);
 
 		if (resp->type != cpu_to_le32(VIRTIO_GPU_RESP_OK_NODATA)) {
 			if (le32_to_cpu(resp->type) >= VIRTIO_GPU_RESP_ERR_UNSPEC) {
@@ -261,6 +261,10 @@ void virtio_gpu_dequeue_cursor_func(struct work_struct *work)
 	spin_unlock(&vgdev->cursorq.qlock);
 
 	list_for_each_entry_safe(entry, tmp, &reclaim_list, list) {
+		struct virtio_gpu_ctrl_hdr *resp =
+			(struct virtio_gpu_ctrl_hdr *)entry->resp_buf;
+
+		trace_virtio_gpu_cmd_response(vgdev->cursorq.vq, resp, entry->seqno);
 		list_del(&entry->list);
 		free_vbuf(vgdev, entry);
 	}
@@ -353,7 +357,8 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 	ret = virtqueue_add_sgs(vq, sgs, outcnt, incnt, vbuf, GFP_ATOMIC);
 	WARN_ON(ret);
 
-	trace_virtio_gpu_cmd_queue(vq, virtio_gpu_vbuf_ctrl_hdr(vbuf));
+	vbuf->seqno = ++vgdev->ctrlq.seqno;
+	trace_virtio_gpu_cmd_queue(vq, virtio_gpu_vbuf_ctrl_hdr(vbuf), vbuf->seqno);
 
 	atomic_inc(&vgdev->pending_commands);
 
@@ -465,8 +470,10 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 		spin_lock(&vgdev->cursorq.qlock);
 		goto retry;
 	} else {
+		vbuf->seqno = ++vgdev->cursorq.seqno;
 		trace_virtio_gpu_cmd_queue(vq,
-			virtio_gpu_vbuf_ctrl_hdr(vbuf));
+			virtio_gpu_vbuf_ctrl_hdr(vbuf),
+			vbuf->seqno);
 
 		notify = virtqueue_kick_prepare(vq);
 	}
-- 
2.38.1

