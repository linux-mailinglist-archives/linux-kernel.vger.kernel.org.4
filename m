Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8CA68B4E6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 05:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjBFEeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 23:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBFEeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 23:34:14 -0500
Received: from kozue.soulik.info (kozue.soulik.info [IPv6:2001:19f0:7000:8404:5054:ff:fe75:428f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1FE19F02;
        Sun,  5 Feb 2023 20:34:02 -0800 (PST)
Received: from misaki.sumomo.pri (unknown [192.168.0.134])
        by kozue.soulik.info (Postfix) with ESMTPA id 9F426100DAB;
        Mon,  6 Feb 2023 13:33:48 +0900 (JST)
From:   ayaka <ayaka@soulik.info>
To:     linux-media@vger.kernel.org
Cc:     randy.li@synaptics.com, Brian.Starkey@arm.com,
        boris.brezillon@collabora.com, frkoenig@chromium.org,
        hans.verkuil@cisco.com, hiroh@chromium.org, hverkuil@xs4all.nl,
        kernel@collabora.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        narmstrong@baylibre.com, nicolas@ndufresne.ca, sakari.ailus@iki.fi,
        stanimir.varbanov@linaro.org, tfiga@chromium.org,
        Helen Koike <helen.koike@collabora.com>
Subject: [PATCH v7 4/9] media: videobuf2-v4l2: reorganize flags handling
Date:   Mon,  6 Feb 2023 12:33:03 +0800
Message-Id: <20230206043308.28365-5-ayaka@soulik.info>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206043308.28365-1-ayaka@soulik.info>
References: <20230206043308.28365-1-ayaka@soulik.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helen Koike <helen.koike@collabora.com>

Reorganize flags handling to be easily reuseble when Ext functions get
added.
No logic is changed, just moving around code.

- Two new functions:
	v4l2_clear_buffer_flags()
	vb2_fill_vb2_v4l2_buffer_flags()
- set_buffer_cache_hints() receives a pointer to flags instead of the
  v4l2_buffer object, making it undependent of this struct.

Signed-off-by: Helen Koike <helen.koike@collabora.com>

---
Changes in v7:
- Refresh and rebase

Changes in v6:
- New patch
---
 .../media/common/videobuf2/videobuf2-v4l2.c   | 176 ++++++++++--------
 1 file changed, 97 insertions(+), 79 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index 1f5d235a8441..eb158de7d14a 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -173,6 +173,43 @@ static void vb2_warn_zero_bytesused(struct vb2_buffer *vb)
 		pr_warn("use the actual size instead.\n");
 }
 
+static void
+vb2_fill_vb2_v4l2_buffer_flags(struct vb2_buffer *vb,
+			       u32 type, u32 field, u32 flags)
+{
+	struct vb2_queue *q = vb->vb2_queue;
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+
+	/* Zero flags that we handle */
+	vbuf->flags = flags & ~V4L2_BUFFER_MASK_FLAGS;
+	if (!vb->vb2_queue->copy_timestamp || V4L2_TYPE_IS_CAPTURE(type)) {
+		/*
+		 * Non-COPY timestamps and non-OUTPUT queues will get
+		 * their timestamp and timestamp source flags from the
+		 * queue.
+		 */
+		vbuf->flags &= ~V4L2_BUF_FLAG_TSTAMP_SRC_MASK;
+	}
+
+	if (V4L2_TYPE_IS_OUTPUT(type)) {
+		/*
+		 * For output buffers mask out the timecode flag:
+		 * this will be handled later in vb2_qbuf().
+		 * The 'field' is valid metadata for this output buffer
+		 * and so that needs to be copied here.
+		 */
+		vbuf->flags &= ~V4L2_BUF_FLAG_TIMECODE;
+		vbuf->field = field;
+		if (!(q->subsystem_flags & VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF))
+			vbuf->flags &= ~V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF;
+	} else {
+		/* Zero any output buffer flags as this is a capture buffer */
+		vbuf->flags &= ~V4L2_BUFFER_OUT_FLAGS;
+		/* Zero last flag, this is a signal from driver to userspace */
+		vbuf->flags &= ~V4L2_BUF_FLAG_LAST;
+	}
+}
+
 static int vb2_fill_vb2_v4l2_buffer(struct vb2_buffer *vb, struct v4l2_buffer *b)
 {
 	struct vb2_queue *q = vb->vb2_queue;
@@ -309,41 +346,14 @@ static int vb2_fill_vb2_v4l2_buffer(struct vb2_buffer *vb, struct v4l2_buffer *b
 
 	}
 
-	/* Zero flags that we handle */
-	vbuf->flags = b->flags & ~V4L2_BUFFER_MASK_FLAGS;
-	if (!vb->vb2_queue->copy_timestamp || V4L2_TYPE_IS_CAPTURE(b->type)) {
-		/*
-		 * Non-COPY timestamps and non-OUTPUT queues will get
-		 * their timestamp and timestamp source flags from the
-		 * queue.
-		 */
-		vbuf->flags &= ~V4L2_BUF_FLAG_TSTAMP_SRC_MASK;
-	}
-
-	if (V4L2_TYPE_IS_OUTPUT(b->type)) {
-		/*
-		 * For output buffers mask out the timecode flag:
-		 * this will be handled later in vb2_qbuf().
-		 * The 'field' is valid metadata for this output buffer
-		 * and so that needs to be copied here.
-		 */
-		vbuf->flags &= ~V4L2_BUF_FLAG_TIMECODE;
-		vbuf->field = b->field;
-		if (!(q->subsystem_flags & VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF))
-			vbuf->flags &= ~V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF;
-	} else {
-		/* Zero any output buffer flags as this is a capture buffer */
-		vbuf->flags &= ~V4L2_BUFFER_OUT_FLAGS;
-		/* Zero last flag, this is a signal from driver to userspace */
-		vbuf->flags &= ~V4L2_BUF_FLAG_LAST;
-	}
+	vb2_fill_vb2_v4l2_buffer_flags(vb, b->type, b->field, b->flags);
 
 	return 0;
 }
 
 static void set_buffer_cache_hints(struct vb2_queue *q,
 				   struct vb2_buffer *vb,
-				   struct v4l2_buffer *b)
+				   u32 *flags)
 {
 	if (!vb2_queue_allows_cache_hints(q)) {
 		/*
@@ -351,15 +361,15 @@ static void set_buffer_cache_hints(struct vb2_queue *q,
 		 * space hints. That's to indicate to userspace that these
 		 * flags won't work.
 		 */
-		b->flags &= ~V4L2_BUF_FLAG_NO_CACHE_INVALIDATE;
-		b->flags &= ~V4L2_BUF_FLAG_NO_CACHE_CLEAN;
+		*flags &= ~V4L2_BUF_FLAG_NO_CACHE_INVALIDATE;
+		*flags &= ~V4L2_BUF_FLAG_NO_CACHE_CLEAN;
 		return;
 	}
 
-	if (b->flags & V4L2_BUF_FLAG_NO_CACHE_INVALIDATE)
+	if (*flags & V4L2_BUF_FLAG_NO_CACHE_INVALIDATE)
 		vb->skip_cache_sync_on_finish = 1;
 
-	if (b->flags & V4L2_BUF_FLAG_NO_CACHE_CLEAN)
+	if (*flags & V4L2_BUF_FLAG_NO_CACHE_CLEAN)
 		vb->skip_cache_sync_on_prepare = 1;
 }
 
@@ -407,7 +417,7 @@ static int vb2_queue_or_prepare_buf(struct vb2_queue *q, struct media_device *md
 	}
 
 	if (!vb->prepared) {
-		set_buffer_cache_hints(q, vb, b);
+		set_buffer_cache_hints(q, vb, &b->flags);
 		/* Copy relevant information provided by the userspace */
 		memset(vbuf->planes, 0,
 		       sizeof(vbuf->planes[0]) * vb->num_planes);
@@ -485,6 +495,58 @@ static int vb2_queue_or_prepare_buf(struct vb2_queue *q, struct media_device *md
 	return 0;
 }
 
+/*
+ * Clear any buffer state related flags.
+ */
+static void v4l2_clear_buffer_flags(struct vb2_buffer *vb, u32 *flags,
+				    struct vb2_queue *q,
+				    struct vb2_v4l2_buffer *vbuf,
+				    u32* request_fd)
+{
+	*flags &= ~V4L2_BUFFER_MASK_FLAGS;
+	*flags |= q->timestamp_flags & V4L2_BUF_FLAG_TIMESTAMP_MASK;
+	if (!q->copy_timestamp) {
+		/*
+		 * For non-COPY timestamps, drop timestamp source bits
+		 * and obtain the timestamp source from the queue.
+		 */
+		*flags &= ~V4L2_BUF_FLAG_TSTAMP_SRC_MASK;
+		*flags |= q->timestamp_flags & V4L2_BUF_FLAG_TSTAMP_SRC_MASK;
+	}
+
+	switch (vb->state) {
+	case VB2_BUF_STATE_QUEUED:
+	case VB2_BUF_STATE_ACTIVE:
+		*flags |= V4L2_BUF_FLAG_QUEUED;
+		break;
+	case VB2_BUF_STATE_IN_REQUEST:
+		*flags |= V4L2_BUF_FLAG_IN_REQUEST;
+		break;
+	case VB2_BUF_STATE_ERROR:
+		*flags |= V4L2_BUF_FLAG_ERROR;
+		fallthrough;
+	case VB2_BUF_STATE_DONE:
+		*flags |= V4L2_BUF_FLAG_DONE;
+		break;
+	case VB2_BUF_STATE_PREPARING:
+	case VB2_BUF_STATE_DEQUEUED:
+		/* nothing */
+		break;
+	}
+
+	if ((vb->state == VB2_BUF_STATE_DEQUEUED ||
+	     vb->state == VB2_BUF_STATE_IN_REQUEST) &&
+	    vb->synced && vb->prepared)
+		*flags |= V4L2_BUF_FLAG_PREPARED;
+
+	if (vb2_buffer_in_use(q, vb))
+		*flags |= V4L2_BUF_FLAG_MAPPED;
+	if (vbuf->request_fd >= 0) {
+		*flags |= V4L2_BUF_FLAG_REQUEST_FD;
+		*request_fd = vbuf->request_fd;
+	}
+}
+
 /*
  * __fill_v4l2_buffer() - fill in a struct v4l2_buffer with information to be
  * returned to userspace
@@ -546,51 +608,7 @@ static void __fill_v4l2_buffer(struct vb2_buffer *vb, void *pb)
 			b->m.fd = vb->planes[0].m.fd;
 	}
 
-	/*
-	 * Clear any buffer state related flags.
-	 */
-	b->flags &= ~V4L2_BUFFER_MASK_FLAGS;
-	b->flags |= q->timestamp_flags & V4L2_BUF_FLAG_TIMESTAMP_MASK;
-	if (!q->copy_timestamp) {
-		/*
-		 * For non-COPY timestamps, drop timestamp source bits
-		 * and obtain the timestamp source from the queue.
-		 */
-		b->flags &= ~V4L2_BUF_FLAG_TSTAMP_SRC_MASK;
-		b->flags |= q->timestamp_flags & V4L2_BUF_FLAG_TSTAMP_SRC_MASK;
-	}
-
-	switch (vb->state) {
-	case VB2_BUF_STATE_QUEUED:
-	case VB2_BUF_STATE_ACTIVE:
-		b->flags |= V4L2_BUF_FLAG_QUEUED;
-		break;
-	case VB2_BUF_STATE_IN_REQUEST:
-		b->flags |= V4L2_BUF_FLAG_IN_REQUEST;
-		break;
-	case VB2_BUF_STATE_ERROR:
-		b->flags |= V4L2_BUF_FLAG_ERROR;
-		fallthrough;
-	case VB2_BUF_STATE_DONE:
-		b->flags |= V4L2_BUF_FLAG_DONE;
-		break;
-	case VB2_BUF_STATE_PREPARING:
-	case VB2_BUF_STATE_DEQUEUED:
-		/* nothing */
-		break;
-	}
-
-	if ((vb->state == VB2_BUF_STATE_DEQUEUED ||
-	     vb->state == VB2_BUF_STATE_IN_REQUEST) &&
-	    vb->synced && vb->prepared)
-		b->flags |= V4L2_BUF_FLAG_PREPARED;
-
-	if (vb2_buffer_in_use(q, vb))
-		b->flags |= V4L2_BUF_FLAG_MAPPED;
-	if (vbuf->request_fd >= 0) {
-		b->flags |= V4L2_BUF_FLAG_REQUEST_FD;
-		b->request_fd = vbuf->request_fd;
-	}
+	v4l2_clear_buffer_flags(vb, &b->flags, q, vbuf, &b->request_fd);
 }
 
 /*
-- 
2.17.1

