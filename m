Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51106F6E77
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjEDO7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjEDO7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:59:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A471455A8
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:58:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a6f15287eso11745432276.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 07:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683212294; x=1685804294;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZW3YbnOWzAROANQ0CBt1Fwgra5x6iOOxVOyhCTd/l4A=;
        b=5s2YzHT1XroaygOER5aXVBNbiAm4WFX/Ndy4UwMbss1mVh8cTf2unf4R4+e0d4uVb/
         DckxyB7Hs1Zd5MMcaR93B6CdU2DzzPS5CBG/6x9Q7ocGJxJZgYxyKDiDZsLHeGjJVi4/
         36dQnJ2hDhP7aSu/exokzIMmcOyJYKcnLHTNAqgTtsmt4nKCDDW7SUsI7oFKEfn/onF5
         o/YbzYvXxjfduWBsulERXdQDEgsuMTH3JrOWh9p/7jzRxPDCa/bteXRw563bEMPzIr7a
         aZaSYlihzs0DMnNmab5t2pNRTyqXJn7LjkxNHm1R/SQpvRIkl9Ww6qkgYlE8y7I0nsz/
         hmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683212294; x=1685804294;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZW3YbnOWzAROANQ0CBt1Fwgra5x6iOOxVOyhCTd/l4A=;
        b=Bd+/FcYctaQtSioBkyNakGs8CrQ6ij9fplUy8KIrO3V7Yv5E3zkQSw5YSC62ZWqG3F
         xrOfONgw8h2hoaJhzhcu/7XFgJZaWKfxx+Jg5avETwWQuUT59rmxNCL6wcK+Swshu4L9
         Qx5a06CqlLCug0URA5ZwbeAB8japoUY1IwXwdLZqpFq2liyp4MaokJ9GslQje3FzxgAS
         BNPfwkSxEZX4hD3R6SQQRpPOxVVLRV96JsRmf0sGEQz7nKcPfwGW7XXwiFYDWTYtZJ4I
         9zZJYY36Kb5JBJgviZOSH7p1lYbG/4QdldaBvLFYC+kkTrcIqur8mJCx/VQPALhZ4igw
         rCvQ==
X-Gm-Message-State: AC+VfDw8d2piA0vY9tVbY6r/A4SotLxj/K5FsMMdSCsLPqYMF1prpHgI
        +3D7xxyzt8SB3XRhqgtcH1v3ioYbw4UA/g==
X-Google-Smtp-Source: ACHHUZ7nk6pfnrO2Vl4gHjCqd8e1I6OuRinIyBbIqIcNsM/NimujGakIOUS4ok+jBP2y67mUnP9rgAnF5ho2fA==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:6902:990:b0:b8f:5b11:6d6c with SMTP
 id bv16-20020a056902099000b00b8f5b116d6cmr13858ybb.1.1683212294723; Thu, 04
 May 2023 07:58:14 -0700 (PDT)
Date:   Thu,  4 May 2023 14:57:33 +0000
In-Reply-To: <20230504145737.286444-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230504145737.286444-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230504145737.286444-4-joychakr@google.com>
Subject: [PATCH 3/7] dmaengine: pl330: Change if-else to switch-case for consistency
From:   Joy Chakraborty <joychakr@google.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, manugautam@google.com,
        danielmentz@google.com, sjadavani@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change if-else to switch-case in pl330_prep_slave_sg() function for
consistency with other peripheral transfer functions in the driver.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/dma/pl330.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 39a66ff29e27..746da0bbea92 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2883,16 +2883,21 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		else
 			list_add_tail(&desc->node, &first->node);
 
-		if (direction == DMA_MEM_TO_DEV) {
+		switch (direction) {
+		case DMA_MEM_TO_DEV:
 			desc->rqcfg.src_inc = 1;
 			desc->rqcfg.dst_inc = 0;
 			fill_px(&desc->px, pch->fifo_dma, sg_dma_address(sg),
 				sg_dma_len(sg));
-		} else {
+			break;
+		case DMA_DEV_TO_MEM:
 			desc->rqcfg.src_inc = 0;
 			desc->rqcfg.dst_inc = 1;
 			fill_px(&desc->px, sg_dma_address(sg), pch->fifo_dma,
 				sg_dma_len(sg));
+			break;
+		default:
+			break;
 		}
 
 		desc->rqcfg.src_brst_size = pch->burst_sz;
-- 
2.40.1.495.gc816e09b53d-goog

