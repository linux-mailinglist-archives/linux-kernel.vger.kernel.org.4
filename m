Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBFA6BE834
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjCQLeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjCQLeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:34:06 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6569B2CD
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:33:24 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a16so428533pjs.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1679052801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEWvzeZcqK871MfRmlZTSC0+Rvvt2fdWWI9+tB+ygs8=;
        b=A9d6Me/U+38g8tYFkHJboHIB24mipqPLRwBsFdf8QUZKGyqMVI3+7nJy7pjnKEW1cz
         7tyAc9Ar6ITDWVM3La5oW1UclxYpTBwGApriRVy/0QPOn9vPXrbBuLzv0CjvsznaqOPB
         zIz9Z2KSkNrX7wt/LUthw8aR8Xpib389ogzxBC99Jq41y5+GzBO0aw6O52qtv18dh4wO
         nKg6MOih323wL5HenFkvYjNokMPR/aZPQwe2+zKFM/XHWhbwKtkj7XM7JYMIRSzlxV14
         5EIKlT43jK7fnSN/cOFw2Hhtjpr3T2BdAOFqX7R/F+qzwjGTOHmcMWLXs/kp9ctvbqJj
         BDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679052801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEWvzeZcqK871MfRmlZTSC0+Rvvt2fdWWI9+tB+ygs8=;
        b=bFOHZ0nDDcq8HAHnG2Bt296eCHcYb9qbQ4OJBoPS613hXhMrDVJz+kugyfVwsPZWkU
         jkkBZJ8CrMAqb7kR3+NxmmLCxACRmKJKphhSu4V5Bi6Lrw9ESLdzG+K05enFzQljEVfY
         tspVin36gc+gfNTc7ToGi8rzpn1sCigAyYDSptL+4HbDFP/AdUvgllW3IZQeAL2VdQcG
         BROx86luXzyYPKD0kRYPkvZXVGvxPobBdk1y7KRmplZofqFzyTxKQzgaXr78jRNFEDVG
         vfF71Y2OdncQQq1fU6V77C6wiMHUHS9twGm/OA6Qi4aOkkVbQ/TIyN2tQiMfXTu/JXNp
         +8yg==
X-Gm-Message-State: AO0yUKXhJPJPultJU6I8BX6unX0r7sSzgMq9hlIsGw3KutnipLFFXOT2
        +TwzrJ6uFtxLQN9+wXSHNJfoZg==
X-Google-Smtp-Source: AK7set+TPpYwApi7RqjbM4INqbH8WoK4AaTlrq4ktuIO2IWD/jWG8Ua248P+wQDOKsbMN7p5EOdeRw==
X-Received: by 2002:a17:90b:17cb:b0:236:73d5:82cf with SMTP id me11-20020a17090b17cb00b0023673d582cfmr7715034pjb.9.1679052801454;
        Fri, 17 Mar 2023 04:33:21 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090a818300b00233aacab89esm1182904pjn.48.2023.03.17.04.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 04:33:21 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shunsuke Mie <mie@igel.co.jp>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [RFC PATCH 10/11] dmaengine: dw-edma: Fix to change for continuous transfer
Date:   Fri, 17 Mar 2023 20:32:37 +0900
Message-Id: <20230317113238.142970-11-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317113238.142970-1-mie@igel.co.jp>
References: <20230317113238.142970-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/dma/dw-edma/dw-edma-core.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 1906a836f0aa..c527af00ff4e 100644
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
@@ -602,14 +604,17 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
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
+			/* Continue to transfer in case of there are rest chunks, or issued
+			 * requests remain.
+			 */
+			chan->status = EDMA_ST_BUSY;
+			if (!dw_edma_start_transfer(chan))
+				chan->status = EDMA_ST_IDLE;
 			break;
 
 		case EDMA_REQ_STOP:
-- 
2.25.1

