Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F34A7483F0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjGEMLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjGEMLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:11:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFCC1705;
        Wed,  5 Jul 2023 05:11:09 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:cbfb:e358:222c:d8c1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6F0ED6606FB7;
        Wed,  5 Jul 2023 13:11:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688559068;
        bh=JcQEQsRyFFpDQxqYrZw61Z4R27rfAC7WB2mYLyxvgng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Od5IoMVHyjnUQu6XuiF3koimeEcsO4HL11T/zxvqv6HMPwJrs0if+0aP0cBiV/b/i
         lPb7/coEXu5NFRm9ShC/MOVVqHD0Rt9nTKQ0foPn5EJ7FeZDRphCnhwfCATQFHCTkQ
         O7KzkxgmjRGNB8S2fea9GyAq1zdF7tfVhrO2cm+T10b0mJYDf6O3OEGrhrruT+IRgb
         Nue8K0e/6VgQwZE7MoIvS0fkj7nrx9jW3OTsz+i6Iwhq+JDV04BPlQ/fJU+DQ6uaTg
         0ERSrVylKcxxYlTcL9LYwCfxHSB779SDPSVz4B2Ct93fgq12vaOrTAEeZd2MOcGz8/
         6bL9oe1tWTpAA==
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
Subject: [PATCH v4 10/10] media: v4l2: Add mem2mem helpers for DELETE_BUFS ioctl
Date:   Wed,  5 Jul 2023 14:10:56 +0200
Message-Id: <20230705121056.37017-11-benjamin.gaignard@collabora.com>
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

Create v4l2-mem2mem helpers for VIDIOC_DELETE_BUFS ioctl.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/platform/verisilicon/hantro_v4l2.c  |  1 +
 drivers/media/test-drivers/vim2m.c            |  1 +
 drivers/media/v4l2-core/v4l2-mem2mem.c        | 20 +++++++++++++++++++
 include/media/v4l2-mem2mem.h                  | 12 +++++++++++
 4 files changed, 34 insertions(+)

diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 08ec5e9cc739..6b8d3908a4f7 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -720,6 +720,7 @@ const struct v4l2_ioctl_ops hantro_ioctl_ops = {
 	.vidioc_dqbuf = v4l2_m2m_ioctl_dqbuf,
 	.vidioc_prepare_buf = v4l2_m2m_ioctl_prepare_buf,
 	.vidioc_create_bufs = v4l2_m2m_ioctl_create_bufs,
+	.vidioc_delete_bufs = v4l2_m2m_ioctl_delete_bufs,
 	.vidioc_expbuf = v4l2_m2m_ioctl_expbuf,
 
 	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
diff --git a/drivers/media/test-drivers/vim2m.c b/drivers/media/test-drivers/vim2m.c
index 3e3b424b4860..3014b8ee13d0 100644
--- a/drivers/media/test-drivers/vim2m.c
+++ b/drivers/media/test-drivers/vim2m.c
@@ -960,6 +960,7 @@ static const struct v4l2_ioctl_ops vim2m_ioctl_ops = {
 	.vidioc_dqbuf		= v4l2_m2m_ioctl_dqbuf,
 	.vidioc_prepare_buf	= v4l2_m2m_ioctl_prepare_buf,
 	.vidioc_create_bufs	= v4l2_m2m_ioctl_create_bufs,
+	.vidioc_delete_buf	= v4l2_m2m_ioctl_delete_buf,
 	.vidioc_expbuf		= v4l2_m2m_ioctl_expbuf,
 
 	.vidioc_streamon	= v4l2_m2m_ioctl_streamon,
diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index 0cc30397fbad..d1d59943680f 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -831,6 +831,17 @@ int v4l2_m2m_prepare_buf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
 }
 EXPORT_SYMBOL_GPL(v4l2_m2m_prepare_buf);
 
+int v4l2_m2m_delete_bufs(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
+			 struct v4l2_delete_buffers *d)
+{
+	struct vb2_queue *vq;
+
+	vq = v4l2_m2m_get_vq(m2m_ctx, d->type);
+
+	return vb2_delete_bufs(vq, d);
+}
+EXPORT_SYMBOL_GPL(v4l2_m2m_delete_bufs);
+
 int v4l2_m2m_create_bufs(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
 			 struct v4l2_create_buffers *create)
 {
@@ -1377,6 +1388,15 @@ int v4l2_m2m_ioctl_create_bufs(struct file *file, void *priv,
 }
 EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_create_bufs);
 
+int v4l2_m2m_ioctl_delete_bufs(struct file *file, void *priv,
+			       struct v4l2_delete_buffers *d)
+{
+	struct v4l2_fh *fh = file->private_data;
+
+	return v4l2_m2m_delete_bufs(file, fh->m2m_ctx, d);
+}
+EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_delete_bufs);
+
 int v4l2_m2m_ioctl_querybuf(struct file *file, void *priv,
 				struct v4l2_buffer *buf)
 {
diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
index bb9de6a899e0..95b9e1be09f8 100644
--- a/include/media/v4l2-mem2mem.h
+++ b/include/media/v4l2-mem2mem.h
@@ -381,6 +381,16 @@ int v4l2_m2m_dqbuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
 int v4l2_m2m_prepare_buf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
 			 struct v4l2_buffer *buf);
 
+/**
+ * v4l2_m2m_delete_bufs() - delete buffers from the queue
+ *
+ * @file: pointer to struct &file
+ * @m2m_ctx: m2m context assigned to the instance given by struct &v4l2_m2m_ctx
+ * @d: pointer to struct &v4l2_delete_buffers
+ */
+int v4l2_m2m_delete_bufs(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
+			 struct v4l2_delete_buffers *d);
+
 /**
  * v4l2_m2m_create_bufs() - create a source or destination buffer, depending
  * on the type
@@ -846,6 +856,8 @@ int v4l2_m2m_ioctl_reqbufs(struct file *file, void *priv,
 				struct v4l2_requestbuffers *rb);
 int v4l2_m2m_ioctl_create_bufs(struct file *file, void *fh,
 				struct v4l2_create_buffers *create);
+int v4l2_m2m_ioctl_delete_bufs(struct file *file, void *priv,
+			       struct v4l2_delete_buffers *d);
 int v4l2_m2m_ioctl_querybuf(struct file *file, void *fh,
 				struct v4l2_buffer *buf);
 int v4l2_m2m_ioctl_expbuf(struct file *file, void *fh,
-- 
2.39.2

