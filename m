Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892D263C6A0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbiK2Rno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbiK2Rnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:43:41 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CE55E3C4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:43:39 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y17so6246607plp.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iXCWILef2PDcL9sLeguo1E8rwfZJ6oNabKhO5H8Gxiw=;
        b=ZjD8MZVqQwGAMlT9t2izaMXVJU8jMqvIKuBePdb/fltwaex9aK3k0K8d5CtmYAz0oZ
         Gd4jdz46JxqNygZsNz6S4b+QNLWJye/YbdS0LdoNT8mqHc1Nfrum+jrRPAx5EIqux9IG
         Pc0zyGudAO5hqgWlNNl9liAX3ezO7n3sVyZn8OubwAHBVY/zjwi7+d+l9akgFsHSKrxl
         TKW7OZ1VTC05I96JDWw5aNhktRLGiDUci7iS/qPAwwJqoI8odrJQxdry9ItLS98eUfI5
         AmORBuSvMHZGSR6s67R/CqdEg+nXn2EJPRgmCMWl6tjFhqN6Bxg7Doz/yJAVbVcoSnMT
         d8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXCWILef2PDcL9sLeguo1E8rwfZJ6oNabKhO5H8Gxiw=;
        b=gPuCHgLuqqlISTBbjYWqCoR/jtue0VFepwb/XYkFV+ubTtFpb8kc54o7BcJ6x7q9+Q
         lBCYmcGR2QMyJYIzCdGORTQDLCqS+c6wvSBs2HdIa+dxJiQ38vGI/f+mnfS1RixxsAnX
         kCslZb+Ar3UhdoARzDsm0zI4ZDLA28AzGE+lA7ExZtBXKu+6UtlY08Zi7zvP8exGJzuV
         UjOjQCEY3WW1iOgfFmcer8f/Yo4eyvDPeWNYNuI+UqutWTK+r+dPBBpW02NYqhz32tDp
         dxLjZHlq6caPM76RBlDTRk9Wuq9z1uUzSxgaT5ERXcYdxgOSPq3rvPHpfEDIrh+9ASPG
         zPDg==
X-Gm-Message-State: ANoB5pl8h1q7iGeByHFMDcci8Tcm2xCfeoT0GBBBiDVmD1lgDmjcIz4m
        TNN5LTUlvYu4mcQS3AyDQUA=
X-Google-Smtp-Source: AA0mqf7+2AEstG2zQZWqQIE3UtBcDlP+tNxEcHG7VqwJTz3I0h+3H54yM8gaQDgA2qDzQbmuZ1wi+g==
X-Received: by 2002:a17:90b:2690:b0:213:f2c9:ce71 with SMTP id pl16-20020a17090b269000b00213f2c9ce71mr60558650pjb.62.1669743819324;
        Tue, 29 Nov 2022 09:43:39 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id x29-20020aa78f1d000000b00575a578a717sm1522947pfr.206.2022.11.29.09.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 09:43:38 -0800 (PST)
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
Subject: [PATCH] drm/virtio: Spiff out cmd queue/response traces
Date:   Tue, 29 Nov 2022 09:43:30 -0800
Message-Id: <20221129174330.262751-1-robdclark@gmail.com>
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

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  3 +++
 drivers/gpu/drm/virtio/virtgpu_trace.h | 20 ++++++++++++--------
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 13 ++++++++++---
 3 files changed, 25 insertions(+), 11 deletions(-)

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
index 711ecc2bd241..087e860a66f7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_trace.h
+++ b/drivers/gpu/drm/virtio/virtgpu_trace.h
@@ -9,8 +9,8 @@
 #define TRACE_INCLUDE_FILE virtgpu_trace
 
 DECLARE_EVENT_CLASS(virtio_gpu_cmd,
-	TP_PROTO(struct virtqueue *vq, struct virtio_gpu_ctrl_hdr *hdr),
-	TP_ARGS(vq, hdr),
+	TP_PROTO(struct virtqueue *vq, struct virtio_gpu_ctrl_hdr *hdr, u32 seqno),
+	TP_ARGS(vq, hdr, seqno),
 	TP_STRUCT__entry(
 			 __field(int, dev)
 			 __field(unsigned int, vq)
@@ -19,6 +19,8 @@ DECLARE_EVENT_CLASS(virtio_gpu_cmd,
 			 __field(u32, flags)
 			 __field(u64, fence_id)
 			 __field(u32, ctx_id)
+			 __field(u32, num_free)
+			 __field(u32, seqno)
 			 ),
 	TP_fast_assign(
 		       __entry->dev = vq->vdev->index;
@@ -28,21 +30,23 @@ DECLARE_EVENT_CLASS(virtio_gpu_cmd,
 		       __entry->flags = le32_to_cpu(hdr->flags);
 		       __entry->fence_id = le64_to_cpu(hdr->fence_id);
 		       __entry->ctx_id = le32_to_cpu(hdr->ctx_id);
+		       __entry->num_free = vq->num_free;
+		       __entry->seqno = seqno;
 		       ),
-	TP_printk("vdev=%d vq=%u name=%s type=0x%x flags=0x%x fence_id=%llu ctx_id=%u",
+	TP_printk("vdev=%d vq=%u name=%s type=0x%x flags=0x%x fence_id=%llu ctx_id=%u num_free=%u seqno=%u",
 		  __entry->dev, __entry->vq, __entry->name,
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

