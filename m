Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D505700A13
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240862AbjELOPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241475AbjELOPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:15:24 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC341491C
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:15:16 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-552cb28adfeso110550697b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683900916; x=1686492916;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AwCGXSf8iY+/DH2QgsH2WgzsBbqjZwTLYrp1XXczDUM=;
        b=OY9dkKT5GQA0dusKiKaS7jrpoAGc7STMoAC5iq8ZfQ23vIfNvff8zDGgoY30mJ/5tD
         9i5nx/eeF4spSmwJa6idZkSXZNinZO9XvLfzF6UvdZkIqXG9NT4b8J8zNPdj8LzTmHxk
         7REBcii9VONQpxmUV1ZgJuykuVbQPVtAhPWlMybn7UfMyv8CfnQ7ky/YyFRHSkAev3PK
         MeZXSlsVN9NAYV0dajL373J8mY+unWtwU0Y3WI1cw/zYGoJPInHFFssN72jUC6uC7mFG
         TIRG8oqiyD1k+RdxYwV8T1XyV86Lt927tbp7/DrwyLP1upxf9Pd2O0L0eEZ2NhxUSfZf
         BmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683900916; x=1686492916;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AwCGXSf8iY+/DH2QgsH2WgzsBbqjZwTLYrp1XXczDUM=;
        b=TLL4w+cv6k25hK85NLjo+36C79Ht7uYl4J3aeCKdTBozFM+SKtxIyOiTi/pWwAlqQy
         7bvvCzWuksKfcFWDe4ELNaJroDXElHDRB4IkSiCvMShYVsMseW0DZZnoPiUsyEtCsWy0
         IcbeO7Us/ET5LPLaqsnXf5346jJdyKMRtUjUMwdQuPoqfWt9Yvs5bHyY1hsUrtVBp1ZT
         eXS9SbE0sZVL7Qy/R2AGdxjEi+ZJGRgUW2kfe3ENq5WM/6P3WJe50ci7mmvRBfKcghOH
         5/+qS8ItSsB7OQgd2UcEgeVKoO9dELrYcPXx/AjZcZEjxFjcRn0KxO99QPl6jD3P0c4V
         GaDA==
X-Gm-Message-State: AC+VfDxR/F/R+kCg4y7sybH3YTDLaqa0uVldDtN7mLslQ7IE4MbCEKUx
        zkxgW75Z5pPpNRo9WhMT3oV3AC6hwN25zQ==
X-Google-Smtp-Source: ACHHUZ6vj73ZJJY9u+8pIa7SQmcBCLaiwjS1XLKrddb4JGDp5BRcKH1etJcsBSg/adpZUKOfhQdn8y9RDHibrQ==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a81:a9c3:0:b0:54c:a67:90b with SMTP id
 g186-20020a81a9c3000000b0054c0a67090bmr16185230ywh.5.1683900915935; Fri, 12
 May 2023 07:15:15 -0700 (PDT)
Date:   Fri, 12 May 2023 14:14:42 +0000
In-Reply-To: <20230512141445.2026660-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230512141445.2026660-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512141445.2026660-4-joychakr@google.com>
Subject: [PATCH v2 3/6] dmaengine: pl330: Change if-else to switch-case for consistency
From:   Joy Chakraborty <joychakr@google.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, manugautam@google.com,
        danielmentz@google.com, sjadavani@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
2.40.1.606.ga4b1b128d6-goog

