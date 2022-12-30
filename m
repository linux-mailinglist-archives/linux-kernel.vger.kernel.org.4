Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83371654B19
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbiLWC0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiLWC0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:26:31 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4972A6308
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:26:30 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 130so2445489pfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PgePphIkJvS7Okl9Cj+x1SpvHHCufOw282m7NhoD9k=;
        b=GSlGi50L9w6iFdONQ34C/l/widp+H4tgsoFT87eYgfxSPJfOJAzdqdlwclCf+xEWJ7
         hYus1zP3Q84bDBIyh4xRW6Eo9kRqSVygNeYgw9pNXbmNpA3YWhpH2BWPFpObE1jO7wfF
         0AAOEvGuPboZm+NrS7bED9U+0k2v49wrFexhx3pGBJm1jDsx+oeD/aQVmG73Ae9Bnxc5
         XnLOZUFlSN5ddedKnB+S0BxWnlcZlmofiLz1comF57iHEAaOr7tRZs9MznAGan9r3Mjp
         c2tXVXLvfFmqDeXJf8AcMt6sruNgItBH1HjH+b8oM00EySJaK3JGk8R1BYxtN7CzH5Cf
         Irtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PgePphIkJvS7Okl9Cj+x1SpvHHCufOw282m7NhoD9k=;
        b=aWjt/Zd/3qnsFHJHDalZzrMjIAMGlGAdUoB+BGgXqcFFO21f2Em8MOpvpO1j40wA1r
         +Tlh996rJpynypY727vSsRL6HUjW2SObjYcaSBRc1GBM7fr+XW4rIzcleNd9cyB2xeMV
         LmqSJIh1cYvt1COom9BT+wREjedqwgs4EWrNyYLkAYM+MJA7uclCxp8uKnO2YfbR1XXe
         F6ER9iN4hk/KjfP1DW/RWjT5lYdfXSaQRkCBed82O+trwWQWiWK/gyTO9JT/ReMpkjfh
         +sX5U+NwYh129KzhzCjjy6Zze3JsGnZO0efnKCi1xow6XfSLXPYgwBPI213DjewOTTbN
         Obzg==
X-Gm-Message-State: AFqh2kpKGGjgu02I8pi3kkNNagS+ADMruHh9TwRS3hHpXj3nBP7H4h8g
        U2la5x6qP1Gr7kBm2DCItZeWag==
X-Google-Smtp-Source: AMrXdXtZoqDXNrz8Az2mo7F6aXKG/yTYiRdDlROuqIHUtfwf0f/ELE/cbOdy+OQ/h19/XlWL6U0XFg==
X-Received: by 2002:aa7:97ba:0:b0:576:d2cc:1ad2 with SMTP id d26-20020aa797ba000000b00576d2cc1ad2mr7689262pfq.6.1671762389794;
        Thu, 22 Dec 2022 18:26:29 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id w186-20020a6262c3000000b005772f762e43sm1418471pfb.13.2022.12.22.18.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 18:26:29 -0800 (PST)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shunsuke Mie <mie@igel.co.jp>
Subject: [PATCH 2/2] dmaengine: dw-edma: Fix to enable to issue dma request on DMA processing
Date:   Fri, 23 Dec 2022 11:26:08 +0900
Message-Id: <20221223022608.550697-2-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221223022608.550697-1-mie@igel.co.jp>
References: <20221223022608.550697-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The issue_pending request is ignored while driver is processing a DMA
request. Fix to issue the pending requests on any dma channel status.

Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 669b97313911..80323b7a8bce 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -279,9 +279,12 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
 	unsigned long flags;
 
+	if (!chan->configured)
+		return;
+
 	spin_lock_irqsave(&chan->vc.lock, flags);
-	if (chan->configured && chan->request == EDMA_REQ_NONE &&
-	    chan->status == EDMA_ST_IDLE && vchan_issue_pending(&chan->vc)) {
+	if (vchan_issue_pending(&chan->vc) && chan->request == EDMA_REQ_NONE &&
+	    chan->status == EDMA_ST_IDLE) {
 		chan->status = EDMA_ST_BUSY;
 		dw_edma_start_transfer(chan);
 	}
-- 
2.25.1

