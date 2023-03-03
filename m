Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAA16A9AA9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjCCPaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjCCPaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:30:19 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825D5196A8;
        Fri,  3 Mar 2023 07:30:18 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id bn17so1697241pgb.10;
        Fri, 03 Mar 2023 07:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677857418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x7FH0x3wKw8tSFnT1jwUdGZKJEQTjsmRqp1L4UYPmVc=;
        b=FUNH/phLXhgaObVW8HbZuU4RQowNZc9XMlbVXlWHxSYOCy3fgxe5JRYSbYEAdP8s5O
         7i/XWHGCuZjCbDitDSFpEH38EYXln8lTHuUKAW1ccTfuyQnbry9sl+MuL1WOxoQvkA1/
         lBqErH0TIN/Kr/dkCKmYuN9b8VTHP04hZzxNlQ0PKsdEjanw23aOUqczfWof46VLC18O
         hiRqxyKBNWsnAxbROpagqBPdebW5YZCrTvH6hcwiq2fDw3/7Uvyl54V04oZnKAehi1Ki
         F5YXV1krH5iH8xEN9ujtCmof2GyB9emlXy9ig1GY3kvIBgvnzFKdEsimwgKbETHChznp
         yZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677857418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7FH0x3wKw8tSFnT1jwUdGZKJEQTjsmRqp1L4UYPmVc=;
        b=xNppXf6+4yrfAbNo/aRIybl5XRxfpTTwIqHD8lHxwdAnu9Y8w71ECwiCV3S+MmEjvR
         VMCHuuXuCJePKlW1YamuhgYZgWjgoAcwPfvuslkZv6SsaRdrMmTBwE7Ak5xR5Uzq7IF4
         z+KY2BZqNPt+kKnMg2rII7udB9wHO6d9NjdoWQnQBW+a32GgAroCHpHTDzn97tu/jNlb
         p7MurzNSl97ZtgbVIjy8SAPbkjVcODNW28EofUXKZ8Nvsnr42jUm5DTnBVgCBNYY/ebk
         WIvexQEIBCXx6+v/72fTprDRety9MJMi9lWoQu2R6LFEmaDu+z+NYJxIKLwj1XOEZTyy
         eT/w==
X-Gm-Message-State: AO0yUKXvCTXvtH0Y6hshD5+ccKL7Jz64uSbNNy4wvEhoho/mV2OFgGPx
        ShNAOmraKjiB+E1NERoksNE=
X-Google-Smtp-Source: AK7set+d8nrKEtSDWCfuBXPGPq+26S/xdssgwSAdA+x0717jj6dmCABTboFbgXgZghWtaNHi/CGJWg==
X-Received: by 2002:a62:1a8d:0:b0:5dc:ecea:fc8b with SMTP id a135-20020a621a8d000000b005dceceafc8bmr1926889pfa.29.1677857417961;
        Fri, 03 Mar 2023 07:30:17 -0800 (PST)
Received: from chcpu13.cse.ust.hk (191host119.mobilenet.cse.ust.hk. [143.89.191.119])
        by smtp.gmail.com with ESMTPSA id s15-20020a62e70f000000b0056d7cc80ea4sm1758953pfh.110.2023.03.03.07.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 07:30:17 -0800 (PST)
From:   harperchen <harperchen1110@gmail.com>
To:     hverkuil@xs4all.nl
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, harperchen <harperchen1110@gmail.com>
Subject: [PATCH] media: pci: tw68: Fix null-ptr-deref bug in buf prepare and finish
Date:   Fri,  3 Mar 2023 15:30:11 +0000
Message-Id: <20230303153011.1461692-1-harperchen1110@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/media/pci/tw68/tw68-video.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/media/pci/tw68/tw68-video.c b/drivers/media/pci/tw68/tw68-video.c
index 0cbc5b038073..773a18702d36 100644
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
2.25.1

