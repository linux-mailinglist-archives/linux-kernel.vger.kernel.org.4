Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0E76C2EEE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjCUK3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCUK30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:29:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176B77D9A;
        Tue, 21 Mar 2023 03:29:19 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:f5ef:1040:e3c1:3d00])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E27B666030E9;
        Tue, 21 Mar 2023 10:29:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679394552;
        bh=B0Rfbtcd7Lj6Gt4LwrxhZy0EbZHQ5j8h6KrandWni6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U7ybreOdVzDSiHTzKZh1y3KSBMBFwimkHYkkSq/PYEu0qP70tXr1PdbsOoPEhW08E
         kmw3KFdN7WwfDalciAutik2Q9MFIgEV1NQjlMXlZHzuhAyAo6gV4ShLd7mWg6yeaup
         6UETgFv2/3RzfMQLjjAbvlG+AT8E+hRBLjKjiDlSAielO9/FuAtP2bO5wfcBltixR8
         SdNTY2r/6XhkgpE9msAKGD0zYVu2+PTelJ9U7tDefT0uw2xhOl4LDfjWyu596D5HwH
         cDVPmRoAxZuuWFGu2KO/PMoXC7aGxYj0qBzN1lAKFerJkURxEIzJRYJNQbwVmMt+PW
         wdP9KV3p8RI0Q==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        ming.qian@nxp.com, shijie.qin@nxp.com, eagle.zhou@nxp.com,
        bin.liu@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, tiffany.lin@mediatek.com,
        andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        daniel.almeida@collabora.com, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, jernel@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2 6/8] media: v4l2: Add mem2mem helpers for DELETE_BUF ioctl
Date:   Tue, 21 Mar 2023 11:28:53 +0100
Message-Id: <20230321102855.346732-7-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321102855.346732-1-benjamin.gaignard@collabora.com>
References: <20230321102855.346732-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create v4l2-mem2mem helpers for VIDIOC_DELETE_BUF ioctl.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/v4l2-core/v4l2-mem2mem.c | 20 ++++++++++++++++++++
 include/media/v4l2-mem2mem.h           | 12 ++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index 0cc30397fbad..42f51ca25379 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -831,6 +831,17 @@ int v4l2_m2m_prepare_buf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
 }
 EXPORT_SYMBOL_GPL(v4l2_m2m_prepare_buf);
 
+int v4l2_m2m_delete_buf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
+			struct v4l2_buffer *buf)
+{
+	struct vb2_queue *vq;
+
+	vq = v4l2_m2m_get_vq(m2m_ctx, buf->type);
+
+	return vb2_delete_buf(vq, buf);
+}
+EXPORT_SYMBOL_GPL(v4l2_m2m_delete_buf);
+
 int v4l2_m2m_create_bufs(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
 			 struct v4l2_create_buffers *create)
 {
@@ -1377,6 +1388,15 @@ int v4l2_m2m_ioctl_create_bufs(struct file *file, void *priv,
 }
 EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_create_bufs);
 
+int v4l2_m2m_ioctl_delete_buf(struct file *file, void *priv,
+			      struct v4l2_buffer *buf)
+{
+	struct v4l2_fh *fh = file->private_data;
+
+	return v4l2_m2m_delete_buf(file, fh->m2m_ctx, buf);
+}
+EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_delete_buf);
+
 int v4l2_m2m_ioctl_querybuf(struct file *file, void *priv,
 				struct v4l2_buffer *buf)
 {
diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
index bb9de6a899e0..96f1b1f3b840 100644
--- a/include/media/v4l2-mem2mem.h
+++ b/include/media/v4l2-mem2mem.h
@@ -381,6 +381,16 @@ int v4l2_m2m_dqbuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
 int v4l2_m2m_prepare_buf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
 			 struct v4l2_buffer *buf);
 
+/**
+ * v4l2_m2m_delete_buf() - delete buffer from the queue
+ *
+ * @file: pointer to struct &file
+ * @m2m_ctx: m2m context assigned to the instance given by struct &v4l2_m2m_ctx
+ * @buf: pointer to struct &v4l2_buffer
+ */
+int v4l2_m2m_delete_buf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
+			struct v4l2_buffer *buf);
+
 /**
  * v4l2_m2m_create_bufs() - create a source or destination buffer, depending
  * on the type
@@ -846,6 +856,8 @@ int v4l2_m2m_ioctl_reqbufs(struct file *file, void *priv,
 				struct v4l2_requestbuffers *rb);
 int v4l2_m2m_ioctl_create_bufs(struct file *file, void *fh,
 				struct v4l2_create_buffers *create);
+int v4l2_m2m_ioctl_delete_buf(struct file *file, void *priv,
+				struct v4l2_buffer *buf);
 int v4l2_m2m_ioctl_querybuf(struct file *file, void *fh,
 				struct v4l2_buffer *buf);
 int v4l2_m2m_ioctl_expbuf(struct file *file, void *fh,
-- 
2.34.1

