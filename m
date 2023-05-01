Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4496F2DC3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjEADQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjEADN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:13:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B75D44B3;
        Sun, 30 Apr 2023 20:04:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 050BE61718;
        Mon,  1 May 2023 03:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7C2C433D2;
        Mon,  1 May 2023 03:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910294;
        bh=j/eYOcJ48Dk+7/VFR+zfwYCzCqmgLpY/BYjA6/xMe9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r6cFhwmsBu5BAC+2IfxQp8jhwsVcvBqeAV9eYtr3cbeJYqAYIvrcszA/YxLj6gWB7
         cTtlSkWxhgH+ppPK7aqf0UaMl/8QEDXHrzEF8v9ZuwNKHW2MSPhlT9B8GWp1GdL/2L
         hx6mZCbyCUZVME1Ry7/zsfztFol5S3BkTS3Y6IvQBEEOoBQLv0AKRDGEIC2/Jo1+rE
         JYYw7daEWqpL/o6zwfROm4cfIKS13pfWzT01hV1wrcEh4PPAncWoYq4aQ5NFqlJoZn
         4F78XybYiwcG3NfndTTvN576IKU+0LpmQQ0Qetiux7UZs3My/8rSFtu9J1yvRUtFvE
         P3oZNJqPjDAxA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     harperchen <harperchen1110@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, hverkuil@xs4all.nl,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 06/17] media: pci: tw68: Fix null-ptr-deref bug in buf prepare and finish
Date:   Sun, 30 Apr 2023 23:04:23 -0400
Message-Id: <20230501030435.3254695-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501030435.3254695-1-sashal@kernel.org>
References: <20230501030435.3254695-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: harperchen <harperchen1110@gmail.com>

[ Upstream commit 1634b7adcc5bef645b3666fdd564e5952a9e24e0 ]

When the driver calls tw68_risc_buffer() to prepare the buffer, the
function call dma_alloc_coherent may fail, resulting in a empty buffer
buf->cpu. Later when we free the buffer or access the buffer, null ptr
deref is triggered.

This bug is similar to the following one:
https://git.linuxtv.org/media_stage.git/commit/?id=2b064d91440b33fba5b452f2d1b31f13ae911d71.

We believe the bug can be also dynamically triggered from user side.
Similarly, we fix this by checking the return value of tw68_risc_buffer()
and the value of buf->cpu before buffer free.

Signed-off-by: harperchen <harperchen1110@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/tw68/tw68-video.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/media/pci/tw68/tw68-video.c b/drivers/media/pci/tw68/tw68-video.c
index fe94944d05317..0d1120abc6471 100644
--- a/drivers/media/pci/tw68/tw68-video.c
+++ b/drivers/media/pci/tw68/tw68-video.c
@@ -437,6 +437,7 @@ static void tw68_buf_queue(struct vb2_buffer *vb)
  */
 static int tw68_buf_prepare(struct vb2_buffer *vb)
 {
+	int ret;
 	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
 	struct vb2_queue *vq = vb->vb2_queue;
 	struct tw68_dev *dev = vb2_get_drv_priv(vq);
@@ -452,30 +453,30 @@ static int tw68_buf_prepare(struct vb2_buffer *vb)
 	bpl = (dev->width * dev->fmt->depth) >> 3;
 	switch (dev->field) {
 	case V4L2_FIELD_TOP:
-		tw68_risc_buffer(dev->pci, buf, dma->sgl,
+		ret = tw68_risc_buffer(dev->pci, buf, dma->sgl,
 				 0, UNSET, bpl, 0, dev->height);
 		break;
 	case V4L2_FIELD_BOTTOM:
-		tw68_risc_buffer(dev->pci, buf, dma->sgl,
+		ret = tw68_risc_buffer(dev->pci, buf, dma->sgl,
 				 UNSET, 0, bpl, 0, dev->height);
 		break;
 	case V4L2_FIELD_SEQ_TB:
-		tw68_risc_buffer(dev->pci, buf, dma->sgl,
+		ret = tw68_risc_buffer(dev->pci, buf, dma->sgl,
 				 0, bpl * (dev->height >> 1),
 				 bpl, 0, dev->height >> 1);
 		break;
 	case V4L2_FIELD_SEQ_BT:
-		tw68_risc_buffer(dev->pci, buf, dma->sgl,
+		ret = tw68_risc_buffer(dev->pci, buf, dma->sgl,
 				 bpl * (dev->height >> 1), 0,
 				 bpl, 0, dev->height >> 1);
 		break;
 	case V4L2_FIELD_INTERLACED:
 	default:
-		tw68_risc_buffer(dev->pci, buf, dma->sgl,
+		ret = tw68_risc_buffer(dev->pci, buf, dma->sgl,
 				 0, bpl, bpl, bpl, dev->height >> 1);
 		break;
 	}
-	return 0;
+	return ret;
 }
 
 static void tw68_buf_finish(struct vb2_buffer *vb)
@@ -485,7 +486,8 @@ static void tw68_buf_finish(struct vb2_buffer *vb)
 	struct tw68_dev *dev = vb2_get_drv_priv(vq);
 	struct tw68_buf *buf = container_of(vbuf, struct tw68_buf, vb);
 
-	dma_free_coherent(&dev->pci->dev, buf->size, buf->cpu, buf->dma);
+	if (buf->cpu)
+		dma_free_coherent(&dev->pci->dev, buf->size, buf->cpu, buf->dma);
 }
 
 static int tw68_start_streaming(struct vb2_queue *q, unsigned int count)
-- 
2.39.2

