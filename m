Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACB46DD7B8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjDKKSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDKKSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:18:05 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2B71BD1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:18:03 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id e13so7059781plc.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1681208283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xCwSNc+RZNs4kaUNl6Q6MFm7xs7aEHy8Tuqz3FTq1lk=;
        b=kiJqAn9CYVGlR7ndEQ0HOiaOjGyDmrHw3F9l0BxFGxvfzfQg+jDcigcGPT9qq1VyRn
         JfBzGI3Ea7QNqgpuaVMrNO0xdO/Uq0hjft+zSfLCb9lQmuFv07G4mfEI9iH0MLiEkMPA
         SBo1E4oSGib2LgC04Fk+HtZjbkcpKOD28qnP5nqO/JfmEGY02doVzEZhbH2dARd8RdoQ
         gPAIMY4cagZn232gJZgAUQsgdL5yeJvkJyWfUcDNZpl70iBnlVh7bLwyqmGKH3W4M2mv
         i/Vy/iFoQSc68BTxo9YEdJbTUJU5PYZ8gfi525Agz9VDM8iN/CBP7aoRcfOEJ20sVW46
         KGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681208283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xCwSNc+RZNs4kaUNl6Q6MFm7xs7aEHy8Tuqz3FTq1lk=;
        b=yblC2Kyc4lZfCczsaJGO/VgXDUjP6QcMo/qjqfEpNgLss2CPpx/eJ4TZZSEpMoIy4P
         boK9CbcqKFsdZPvBjD3MpcgIKzKg49x3+6Y8Ji5BbokNBtw7WUhdXJz6IAQGqqrYlgst
         Q6vimXxSdVtsg57jiELf9DCPL19eqLMj13JqcPx3dk9XcQhc82y0jrHz3KyJ9bJCtRiP
         rgXP30npJwiYAqodZejcWGFVHyzLnXl61FnARLlqcdSawGJo1zLx8itFzd/BJ6GCMN18
         LjimPubV8erexCFuS8nDAbdYerOAGooYXrxmyEfLmQNrqEKosbpHKExzYpQO0h60Rf37
         37vg==
X-Gm-Message-State: AAQBX9e5ZRKzmlX26CwVzuX3OuM6XHU2AZGFNyGkRWLUoVzeMynUxgLS
        bk9OgQDc/FeYUMkWVF6F4FqfAA==
X-Google-Smtp-Source: AKy350bEGyfbtMXxQVd7FJ3cHLSPGYjkr7y7Bba7p3tW1TTHqROY1wKKT7s7ZjZ5WNl9v+y2v7cnlg==
X-Received: by 2002:a17:903:288e:b0:19e:8075:5545 with SMTP id ku14-20020a170903288e00b0019e80755545mr15421707plb.54.1681208283110;
        Tue, 11 Apr 2023 03:18:03 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id iz4-20020a170902ef8400b00195f0fb0c18sm7629794plb.31.2023.04.11.03.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 03:18:02 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shunsuke Mie <mie@igel.co.jp>
Subject: [PATCH v2 1/2] dmaengine: dw-edma: Fix to change for continuous transfer
Date:   Tue, 11 Apr 2023 19:17:57 +0900
Message-Id: <20230411101758.438472-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dw-edma driver stops after processing a DMA request even if a request
remains in the issued queue, which is not the expected behavior. The DMA
engine API requires continuous processing.

Add a trigger to start after one processing finished if there are requests
remain.

Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
Changes

v2:
- Refactor code
- Rebase to next-20230411

v1: https://lore.kernel.org/dmaengine/20221223022608.550697-1-mie@igel.co.jp/
- Initial patch

 drivers/dma/dw-edma/dw-edma-core.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 1906a836f0aa..26a395d02f5d 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -181,7 +181,7 @@ static void vchan_free_desc(struct virt_dma_desc *vdesc)
 	dw_edma_free_desc(vd2dw_edma_desc(vdesc));
 }
 
-static void dw_edma_start_transfer(struct dw_edma_chan *chan)
+static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 {
 	struct dw_edma_chunk *child;
 	struct dw_edma_desc *desc;
@@ -189,16 +189,16 @@ static void dw_edma_start_transfer(struct dw_edma_chan *chan)
 
 	vd = vchan_next_desc(&chan->vc);
 	if (!vd)
-		return;
+		return 0;
 
 	desc = vd2dw_edma_desc(vd);
 	if (!desc)
-		return;
+		return 0;
 
 	child = list_first_entry_or_null(&desc->chunk->list,
 					 struct dw_edma_chunk, list);
 	if (!child)
-		return;
+		return 0;
 
 	dw_edma_v0_core_start(child, !desc->xfer_sz);
 	desc->xfer_sz += child->ll_region.sz;
@@ -206,6 +206,8 @@ static void dw_edma_start_transfer(struct dw_edma_chan *chan)
 	list_del(&child->list);
 	kfree(child);
 	desc->chunks_alloc--;
+
+	return 1;
 }
 
 static void dw_edma_device_caps(struct dma_chan *dchan,
@@ -602,14 +604,14 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 		switch (chan->request) {
 		case EDMA_REQ_NONE:
 			desc = vd2dw_edma_desc(vd);
-			if (desc->chunks_alloc) {
-				chan->status = EDMA_ST_BUSY;
-				dw_edma_start_transfer(chan);
-			} else {
+			if (!desc->chunks_alloc) {
 				list_del(&vd->node);
 				vchan_cookie_complete(vd);
-				chan->status = EDMA_ST_IDLE;
 			}
+
+			/* Continue transferring if there are remaining chunks or issued requests.
+			 */
+			chan->status = dw_edma_start_transfer(chan) ? EDMA_ST_BUSY : EDMA_ST_IDLE;
 			break;
 
 		case EDMA_REQ_STOP:
-- 
2.25.1

