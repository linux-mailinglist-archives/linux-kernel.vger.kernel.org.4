Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D57D6672B7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjALM5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjALM4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:56:40 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E901B641D;
        Thu, 12 Jan 2023 04:56:39 -0800 (PST)
Received: from localhost (89-26-75-29.goll.dyn.salzburg-online.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9E63B6602DBA;
        Thu, 12 Jan 2023 12:56:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673528198;
        bh=8FFms7ZFvtbGRTeN4REh/YGhyU+oeFdqYWO/CK2KT8c=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=hXDggCyHhkjfeIswJAT/y/OZ3Uv10V8Cte6Wd/pyHY8rOY6dr9GSn0wpvJqTPLhAn
         huVgJgPug9zwf6cZosazKC86t1j54jjlPgFuIsy+QRuqZT1+iPX9piPWAJMlNjqjuG
         OScE+wYlc6cVvt/TBZahO964vjW3VE37MbhQ94bfU0QB+iyniOOy6KJEcIgZxSjqQK
         fotcKNvAIDnTYGKuQZXOYWdvsbeIDsUTfJ2+wAx0S2d8E1/NX8hW0NhtfMSaHK0Ur2
         Dao5hfPydn5QXY2ImcTCrAm24Q/K0DZKTPJECRS5W5DOD0MUySUoXpHHjb1QhUGGu/
         qieM9+NzZLXQg==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
Date:   Thu, 12 Jan 2023 13:56:18 +0100
Subject: [PATCH v2 03/12] staging: media: rkvdec: Helper for buffer queue busy check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230101-patch-series-v2-6-2-rc1-v2-3-fa1897efac14@collabora.com>
References: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com>
In-Reply-To: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        Jonas Karlman <jonas@kwiboo.se>,
        Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Collabora Kernel-domain <kernel@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673528186; l=2269;
 i=sebastian.fricke@collabora.com; s=linux-media; h=from:subject:message-id;
 bh=8FFms7ZFvtbGRTeN4REh/YGhyU+oeFdqYWO/CK2KT8c=;
 b=ub/wDdTpC9jeMsoCSRmmqPKTVKH8soQUtOakduE6Kmcgt/JvOwM+tMckRDcgsVcmdLW9umjznn05
 a7TSEWbUC2GDJJri/M43YYI86BB6vTZEyOuxzEaRrXkA+V76F2vz
X-Developer-Key: i=sebastian.fricke@collabora.com; a=ed25519;
 pk=pYXedPwrTtErcj7ERYeo/IpTrpe4QbJuEzSB52fslBg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a helper function, wrapping around getting a vb2 queue and
checking whether it is busy, to reduce the amount of code duplication in
the driver.

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 drivers/staging/media/rkvdec/rkvdec.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 7bab7586918c..c849f6c20279 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -27,6 +27,17 @@
 #include "rkvdec.h"
 #include "rkvdec-regs.h"
 
+static int rkvdec_queue_busy(struct rkvdec_ctx *ctx, enum v4l2_buf_type buf_type)
+{
+	struct vb2_queue *vq;
+
+	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, buf_type);
+	if (vb2_is_busy(vq))
+		return -EBUSY;
+	else
+		return 0;
+}
+
 static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct rkvdec_ctx *ctx = container_of(ctrl->handler, struct rkvdec_ctx, ctrl_hdl);
@@ -311,13 +322,10 @@ static int rkvdec_s_capture_fmt(struct file *file, void *priv,
 				struct v4l2_format *f)
 {
 	struct rkvdec_ctx *ctx = fh_to_rkvdec_ctx(priv);
-	struct vb2_queue *vq;
 	int ret;
 
 	/* Change not allowed if queue is busy */
-	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
-			     V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
-	if (vb2_is_busy(vq))
+	if (rkvdec_queue_busy(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) != 0)
 		return -EBUSY;
 
 	ret = rkvdec_try_capture_fmt(file, priv, f);
@@ -335,7 +343,7 @@ static int rkvdec_s_output_fmt(struct file *file, void *priv,
 	struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
 	const struct rkvdec_coded_fmt_desc *desc;
 	struct v4l2_format *cap_fmt;
-	struct vb2_queue *peer_vq, *vq;
+	struct vb2_queue *vq;
 	int ret;
 
 	/*
@@ -354,8 +362,7 @@ static int rkvdec_s_output_fmt(struct file *file, void *priv,
 	 * queue, we can't allow doing so when the CAPTURE queue has buffers
 	 * allocated.
 	 */
-	peer_vq = v4l2_m2m_get_vq(m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
-	if (vb2_is_busy(peer_vq))
+	if (rkvdec_queue_busy(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) != 0)
 		return -EBUSY;
 
 	ret = rkvdec_try_output_fmt(file, priv, f);

-- 
2.25.1
