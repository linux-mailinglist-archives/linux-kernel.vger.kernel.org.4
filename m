Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B41B61F5D1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbiKGOYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiKGOYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:24:15 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C5123E95;
        Mon,  7 Nov 2022 06:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667830763; x=1699366763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/luAN7OA0doORJetnI5tF2uTnMhfUCA9gIxuQ14Fh70=;
  b=mTZ9Wg1W2OzIk9Zdip1gk4ATiIv2PytebL+mLrCAfZviaxVTRP9R28jA
   7W9HuQQEQ/t/x1gTwteuYBSgFb3E3Z1e3xcILcw7DEcspwiu3cpUAGU7q
   mtbxacwjRIKGoVdtRD2199VkacXmqaleDfCRxzHKsAGNz9n+gG1fbRbF7
   ZANbCy9BEUMCyRmjIWWovXrJYtCUhl0fPxc3XAEr3jduwviRW2vzhMq97
   YDRV3kVK5D+5grqlgabQQcO6pa4ioDMogS1TZM0SEVA/rvkb2yAw8YVGy
   ouU3pnzMQI8Pvjxbz35CXWHep+45HyO9+SmnCpu9VmGTGYbfhKaaJrPR8
   g==;
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="198727476"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Nov 2022 07:18:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 7 Nov 2022 07:18:39 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 7 Nov 2022 07:18:37 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <jacopo@jmondi.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-staging@lists.linux.dev>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v12 5/6] media: microchip: microchip-isc: move media_pipeline_* to (un)prepare cb
Date:   Mon, 7 Nov 2022 16:18:17 +0200
Message-ID: <20221107141818.104937-6-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107141818.104937-1-eugen.hristev@microchip.com>
References: <20221107141818.104937-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the media_pipeline_start/stop calls from start/stop streaming to
the new prepare_streaming and unprepare_streaming callbacks.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 .../platform/microchip/microchip-isc-base.c   | 27 ++++++++++++-------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index 28749a09b0c3..e2994d48f10c 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -328,6 +328,13 @@ static int isc_configure(struct isc_device *isc)
 	return isc_update_profile(isc);
 }
 
+static int isc_prepare_streaming(struct vb2_queue *vq)
+{
+	struct isc_device *isc = vb2_get_drv_priv(vq);
+
+	return media_pipeline_start(isc->video_dev.entity.pads, &isc->mpipe);
+}
+
 static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
 {
 	struct isc_device *isc = vb2_get_drv_priv(vq);
@@ -336,10 +343,6 @@ static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
 	unsigned long flags;
 	int ret;
 
-	ret = media_pipeline_start(isc->video_dev.entity.pads, &isc->mpipe);
-	if (ret)
-		goto err_pipeline_start;
-
 	/* Enable stream on the sub device */
 	ret = v4l2_subdev_call(isc->current_subdev->sd, video, s_stream, 1);
 	if (ret && ret != -ENOIOCTLCMD) {
@@ -389,9 +392,6 @@ static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
 	v4l2_subdev_call(isc->current_subdev->sd, video, s_stream, 0);
 
 err_start_stream:
-	media_pipeline_stop(isc->video_dev.entity.pads);
-
-err_pipeline_start:
 	spin_lock_irqsave(&isc->dma_queue_lock, flags);
 	list_for_each_entry(buf, &isc->dma_queue, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
@@ -401,6 +401,14 @@ static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
 	return ret;
 }
 
+static void isc_unprepare_streaming(struct vb2_queue *vq)
+{
+	struct isc_device *isc = vb2_get_drv_priv(vq);
+
+	/* Stop media pipeline */
+	media_pipeline_stop(isc->video_dev.entity.pads);
+}
+
 static void isc_stop_streaming(struct vb2_queue *vq)
 {
 	struct isc_device *isc = vb2_get_drv_priv(vq);
@@ -430,9 +438,6 @@ static void isc_stop_streaming(struct vb2_queue *vq)
 	if (ret && ret != -ENOIOCTLCMD)
 		v4l2_err(&isc->v4l2_dev, "stream off failed in subdev\n");
 
-	/* Stop media pipeline */
-	media_pipeline_stop(isc->video_dev.entity.pads);
-
 	/* Release all active buffers */
 	spin_lock_irqsave(&isc->dma_queue_lock, flags);
 	if (unlikely(isc->cur_frm)) {
@@ -472,6 +477,8 @@ static const struct vb2_ops isc_vb2_ops = {
 	.start_streaming	= isc_start_streaming,
 	.stop_streaming		= isc_stop_streaming,
 	.buf_queue		= isc_buffer_queue,
+	.prepare_streaming	= isc_prepare_streaming,
+	.unprepare_streaming	= isc_unprepare_streaming,
 };
 
 static int isc_querycap(struct file *file, void *priv,
-- 
2.25.1

