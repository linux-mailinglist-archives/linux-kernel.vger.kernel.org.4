Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF3F7483DF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjGEMLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjGEMLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:11:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E6AE7B;
        Wed,  5 Jul 2023 05:11:06 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:cbfb:e358:222c:d8c1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C70E46606FB9;
        Wed,  5 Jul 2023 13:11:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688559065;
        bh=4t2lobqp8kQ9itIXbwNWZqHC/Q0azCKlo/t/UJDorIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LEmEAehcgOitfNWcWRYVJdfGx0pc0f9BhQazshQG/W/yVdfKm8mY07DYOmxDvHn5g
         M/o/fM5CvcYF7g2eQcXnM6XeEc1Y/sQ6xlqJMT3zQqwo1aBznc8naFV1RncX9rksll
         I0BtfV0GXwdeWJFtN+yqzBu5TA5v/ujd+ZELX2QZpF8o2fksvWBPJD9Zo9BT/kg9/E
         WplfMLY2z3eJ+jvrIr4YhOZfJdBT/MkhcqXedsMpsVS5cfkq6F+OnzB1O0ufQUYBkA
         Q8JEMF2MtqJhJRqE38Ie5DBPFN/vW0QdgFLW4I+B7BQ89F1n+LSvT94gqN7Y9iZWMu
         o/aphTAaI+fxQ==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v4 03/10] media: videobuf2: Rework offset 'cookie' encoding pattern
Date:   Wed,  5 Jul 2023 14:10:49 +0200
Message-Id: <20230705121056.37017-4-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230705121056.37017-1-benjamin.gaignard@collabora.com>
References: <20230705121056.37017-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change how offset 'cookie' field value is computed to make possible
to use more buffers.
With this encoding pattern we know the maximum number that a queue
could store so we can check ing at queue init time.
It also make easier and faster to find buffer and plane from using
the offset field.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/common/videobuf2/videobuf2-core.c   | 63 +++++++++----------
 1 file changed, 29 insertions(+), 34 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 77e69b01d88d..70e36389b704 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -31,6 +31,10 @@
 
 #include <trace/events/vb2.h>
 
+#define PLANE_INDEX_SHIFT	3
+#define PLANE_INDEX_MASK	0x7
+#define MAX_BUFFERS		0xffff
+
 static int debug;
 module_param(debug, int, 0644);
 
@@ -358,29 +362,23 @@ static void __setup_offsets(struct vb2_buffer *vb)
 	unsigned int plane;
 	unsigned long off = 0;
 
-	if (vb->index) {
-		struct vb2_buffer *prev;
-		struct vb2_plane *p;
-
-		prev = vb2_get_buffer(q, vb->index - 1);
-		if (!prev) {
-			dprintk(q, 1, "can't find the requested buffer\n");
-			return;
-		}
-
-		p = &prev->planes[prev->num_planes - 1];
-
-		off = PAGE_ALIGN(p->m.offset + p->length);
-	}
+	/*
+	 * Offsets cookies value have the following constraints:
+	 * - a buffer could have up to 8 planes.
+	 * - v4l2 mem2mem use bit 30 to distinguish between source and destination buffers.
+	 * - must be page aligned
+	 * That led to this bit mapping:
+	 * |30                |29        15|14       12|11 0|
+	 * |DST_QUEUE_OFF_BASE|buffer index|plane index| 0  |
+	 * where there is 16 bits to store buffer index.
+	 */
+	off = vb->index << (PLANE_INDEX_SHIFT + PAGE_SHIFT);
 
 	for (plane = 0; plane < vb->num_planes; ++plane) {
-		vb->planes[plane].m.offset = off;
+		vb->planes[plane].m.offset = off + (plane << PAGE_SHIFT);
 
 		dprintk(q, 3, "buffer %d, plane %d offset 0x%08lx\n",
 				vb->index, plane, off);
-
-		off += vb->planes[plane].length;
-		off = PAGE_ALIGN(off);
 	}
 }
 
@@ -2294,24 +2292,18 @@ static int __find_plane_by_offset(struct vb2_queue *q, unsigned long off,
 		return -EBUSY;
 	}
 
-	/*
-	 * Go over all buffers and their planes, comparing the given offset
-	 * with an offset assigned to each plane. If a match is found,
-	 * return its buffer and plane numbers.
-	 */
-	for (buffer = 0; buffer < q->num_buffers; ++buffer) {
-		vb = vb2_get_buffer(q, buffer);
+	/* Get buffer and plane from the offset */
+	buffer = (off >> (PLANE_INDEX_SHIFT + PAGE_SHIFT)) & MAX_BUFFERS;
+	plane = (off >> PAGE_SHIFT) & PLANE_INDEX_MASK;
 
-		if (!vb)
-			continue;
+	vb = vb2_get_buffer(q, buffer);
+	if (!vb)
+		return -EINVAL;
 
-		for (plane = 0; plane < vb->num_planes; ++plane) {
-			if (vb->planes[plane].m.offset == off) {
-				*_buffer = buffer;
-				*_plane = plane;
-				return 0;
-			}
-		}
+	if (vb->planes[plane].m.offset == off) {
+		*_buffer = buffer;
+		*_plane = plane;
+		return 0;
 	}
 
 	return -EINVAL;
@@ -2552,6 +2544,9 @@ int vb2_core_queue_init(struct vb2_queue *q)
 	if (!q->max_allowed_buffers)
 		q->max_allowed_buffers = VB2_MAX_FRAME;
 
+	/* The maximum is limited by offset cookie encoding pattern */
+	q->max_allowed_buffers = min_t(unsigned int, q->max_allowed_buffers, MAX_BUFFERS);
+
 	q->bufs = kcalloc(q->max_allowed_buffers, sizeof(*q->bufs), GFP_KERNEL);
 
 	if (q->buf_struct_size == 0)
-- 
2.39.2

