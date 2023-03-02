Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C896A826A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjCBMj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCBMjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:39:22 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA3515541;
        Thu,  2 Mar 2023 04:39:13 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p6so16538658plf.0;
        Thu, 02 Mar 2023 04:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677760753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+LXlqIeNp8LEupB8hKVZMY8i9ZwtQRmL/aw5lsfFuKU=;
        b=VIaN60ZkgYiUYRl03IfK7KUvb5pOpEQ95QxUoFaxXLGl58dE+V5v/+D90jOyLrN6iF
         uwmRjTccr+mNAWQPMtyi5XKZZhQBYmP4RQ/Y41Oy/ftk4g6wqAv76QzrKKHtCtIq3Whi
         iDSTRdqC1CzTUvqFMWzj0mRu0/+LxSpJrBiiJaLNrxXFDy68HJKcI5bhHq6m9+WDLJuJ
         oEjH2iWE4iWlq3CBal4xIamHSt5wquBsFzD/POr05zlv6lqJbRWCmYlbX3ofBNprdjtm
         2sVnmGCCv3rAU635CaEGWskTcjxC8PIZvlDQI5i6jO8OQV2QhHjmzlc1AaZ74CDl4f2P
         8vaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677760753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+LXlqIeNp8LEupB8hKVZMY8i9ZwtQRmL/aw5lsfFuKU=;
        b=Lfr2mn1PmD3FJ68NM4F8C5GHOsuFE5EM0RZtC1JxC9zU+tU61UM7GJDqNUadycAqeE
         MDWNyUQbrlQHnawEEV//TFkRQmYvb5ZOXj9DOalUzZ/OGP+cu8igjXbDd0OFeHbKwNJX
         XgPhvplreBEiV2lY41xcyVUB6cdaJ9Y9wIN9kpiAB6RulXKBWW900Z458hUQxI6Bj8xe
         5AD7YEHvrkAX8iBcAHbUMB3xTIqvDtfDNxmTLEPto/gbZHeWeOV08Adugt9AxK2Velsi
         8xW/Q5byvOrR+bkE5+uLO+iSOBVIREYoP6Kl0Z9AgNHLFFPYGkM4VqKUAGOizEbxhx2H
         X1Ag==
X-Gm-Message-State: AO0yUKVTTjI7DztC7FVivrHglTOzeKc+Pm+pjefkuJCCswYvWoOWMJzH
        UBEnLdW8C2VCogfjz0la6mZpA9N6qm4ZBw==
X-Google-Smtp-Source: AK7set/A8EbzED/MWzofxxiKkcgIO7/nyw90AJEsO4XYL6NG/5MAWINHprbSrqjRiHdbW+W9O7Tq/Q==
X-Received: by 2002:a17:902:db04:b0:19d:f7e:9864 with SMTP id m4-20020a170902db0400b0019d0f7e9864mr12108322plx.57.1677760753284;
        Thu, 02 Mar 2023 04:39:13 -0800 (PST)
Received: from chcpu13.cse.ust.hk (191host119.mobilenet.cse.ust.hk. [143.89.191.119])
        by smtp.gmail.com with ESMTPSA id v8-20020a170902b7c800b001948ff5cc32sm10236881plz.215.2023.03.02.04.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 04:39:13 -0800 (PST)
From:   harperchen <harperchen1110@gmail.com>
To:     mchehab@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, daniel.lee.kruse@proton.me,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        harperchen <harperchen1110@gmail.com>
Subject: [PATCH] media: cx23885: Fix a null-ptr-deref bug in buffer_prepare() and buffer_finish()
Date:   Thu,  2 Mar 2023 12:39:05 +0000
Message-Id: <20230302123905.762755-1-harperchen1110@gmail.com>
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

When the driver calls cx23885_risc_buffer() to prepare the buffer, the
function call dma_alloc_coherent may fail, resulting in a empty buffer
risc->cpu. Later when we free the buffer or access the buffer, null ptr
deref is triggered.

This bug is similar to the following one:
https://git.linuxtv.org/media_stage.git/commit/?id=2b064d91440b33fba5b452f2d1b31f13ae911d71.

We believe the bug can be also dynamically triggered from user side.
Similarly, we fix this by checking the return value of cx23885_risc_buffer()
and the value of risc->cpu before buffer free.

Signed-off-by: harperchen <harperchen1110@gmail.com>
---
 drivers/media/pci/cx23885/cx23885-core.c  |  4 +++-
 drivers/media/pci/cx23885/cx23885-video.c | 13 +++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/media/pci/cx23885/cx23885-core.c b/drivers/media/pci/cx23885/cx23885-core.c
index 9232a966bcab..2ce2914576cf 100644
--- a/drivers/media/pci/cx23885/cx23885-core.c
+++ b/drivers/media/pci/cx23885/cx23885-core.c
@@ -1325,7 +1325,9 @@ void cx23885_free_buffer(struct cx23885_dev *dev, struct cx23885_buffer *buf)
 {
 	struct cx23885_riscmem *risc = &buf->risc;
 
-	dma_free_coherent(&dev->pci->dev, risc->size, risc->cpu, risc->dma);
+	if (risc->cpu)
+		dma_free_coherent(&dev->pci->dev, risc->size, risc->cpu, risc->dma);
+	memset(risc, 0, sizeof(*risc));
 }
 
 static void cx23885_tsport_reg_dump(struct cx23885_tsport *port)
diff --git a/drivers/media/pci/cx23885/cx23885-video.c b/drivers/media/pci/cx23885/cx23885-video.c
index 3d03f5e95786..671fc0588e43 100644
--- a/drivers/media/pci/cx23885/cx23885-video.c
+++ b/drivers/media/pci/cx23885/cx23885-video.c
@@ -342,6 +342,7 @@ static int queue_setup(struct vb2_queue *q,
 
 static int buffer_prepare(struct vb2_buffer *vb)
 {
+	int ret;
 	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
 	struct cx23885_dev *dev = vb->vb2_queue->drv_priv;
 	struct cx23885_buffer *buf =
@@ -358,12 +359,12 @@ static int buffer_prepare(struct vb2_buffer *vb)
 
 	switch (dev->field) {
 	case V4L2_FIELD_TOP:
-		cx23885_risc_buffer(dev->pci, &buf->risc,
+		ret = cx23885_risc_buffer(dev->pci, &buf->risc,
 				sgt->sgl, 0, UNSET,
 				buf->bpl, 0, dev->height);
 		break;
 	case V4L2_FIELD_BOTTOM:
-		cx23885_risc_buffer(dev->pci, &buf->risc,
+		ret = cx23885_risc_buffer(dev->pci, &buf->risc,
 				sgt->sgl, UNSET, 0,
 				buf->bpl, 0, dev->height);
 		break;
@@ -391,21 +392,21 @@ static int buffer_prepare(struct vb2_buffer *vb)
 			line0_offset = 0;
 			line1_offset = buf->bpl;
 		}
-		cx23885_risc_buffer(dev->pci, &buf->risc,
+		ret = cx23885_risc_buffer(dev->pci, &buf->risc,
 				sgt->sgl, line0_offset,
 				line1_offset,
 				buf->bpl, buf->bpl,
 				dev->height >> 1);
 		break;
 	case V4L2_FIELD_SEQ_TB:
-		cx23885_risc_buffer(dev->pci, &buf->risc,
+		ret = cx23885_risc_buffer(dev->pci, &buf->risc,
 				sgt->sgl,
 				0, buf->bpl * (dev->height >> 1),
 				buf->bpl, 0,
 				dev->height >> 1);
 		break;
 	case V4L2_FIELD_SEQ_BT:
-		cx23885_risc_buffer(dev->pci, &buf->risc,
+		ret = cx23885_risc_buffer(dev->pci, &buf->risc,
 				sgt->sgl,
 				buf->bpl * (dev->height >> 1), 0,
 				buf->bpl, 0,
@@ -418,7 +419,7 @@ static int buffer_prepare(struct vb2_buffer *vb)
 		buf, buf->vb.vb2_buf.index,
 		dev->width, dev->height, dev->fmt->depth, dev->fmt->fourcc,
 		(unsigned long)buf->risc.dma);
-	return 0;
+	return ret;
 }
 
 static void buffer_finish(struct vb2_buffer *vb)
-- 
2.25.1

