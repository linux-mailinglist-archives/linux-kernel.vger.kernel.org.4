Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E810700A16
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241499AbjELOPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241494AbjELOPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:15:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB3614370
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:15:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b8f324b3ef8so12331118276.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683900920; x=1686492920;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FfQ+/r7s1P5a9jjV8O7nCqUbRdU0vkaUxYBVOduQXjQ=;
        b=IBQZt7JbR+LudSxsdF3I2W7xeLwAEvXnvns938oEU3VVcdBX8lAvplQRg7xLBCUB4C
         ibIFadhFDSBkJSFTFTmgkfksiGNjcAaBORXO437XVKfkkkB7GVcSGu6rsigHjTGBODI2
         MWcaHPbDRpwxLs0HJz0hA8eAfv1TccaO1pNBYr0ZBV3LwULnXcqNv9myVmpjESVEcG90
         rhWaoqsxTJHrZkCQSCr4y7iMc0j6LT/JRTEqunc/ujfyQ6IMSf8X5LprFe5Wp7uTzytW
         vsyHe3eB7xsk7CNt0uDT/dS0HwFRgH1fmlICo8/Fz7mDK/QHxJGzWVWNDSZTPj2tG6tN
         kyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683900920; x=1686492920;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FfQ+/r7s1P5a9jjV8O7nCqUbRdU0vkaUxYBVOduQXjQ=;
        b=YH1nXEc5ehDVeFjXk+B3zPxf8xW7I8sFX0s56qnw2Hfu7P7WF1lF/bZvS1qJ/5LT3K
         0NL4AAdgGAppXHJhJ6LwBEf690oi8l+Pd1LWfytNPobyeeItKrebYtaQKKDT0Uc5m9bM
         +yiXdTH/Ww6oLTsi9BvVvER2/PHIE//PiUSofFKXhEF7pcZbZr2V8loUP05Ie4NGwOlv
         Cg10FZW2D9GwSPn/eMbyJ6cPXLvRNdzACD2nuUNIt4q4qUz8wE+cGOa/PFvSQuQv8UFX
         Y4fgmbzgx78POijke7qmz7l4lpUU6L/J8m7b4yplV02zLDMRX+A4Vj5pGqGpbGlU5ef1
         5kLQ==
X-Gm-Message-State: AC+VfDwHcODOSLBV0UTjWaSYS1T7uGIqkKhsBfHcFQGC9FgxNyzDyRRV
        e61zsswsGTrxa0yQT5FVJY1tB2jGJqt/gw==
X-Google-Smtp-Source: ACHHUZ5ymR5y6St7F++9mZcC0W4aDFurpqueRtd+CJ72Z1j3cHVCDRUWUF25Pc7VzIilNjjP/KgcUj6STOExXg==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:1d84:0:b0:ba2:526a:c84e with SMTP id
 d126-20020a251d84000000b00ba2526ac84emr12761168ybd.9.1683900920221; Fri, 12
 May 2023 07:15:20 -0700 (PDT)
Date:   Fri, 12 May 2023 14:14:43 +0000
In-Reply-To: <20230512141445.2026660-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230512141445.2026660-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512141445.2026660-5-joychakr@google.com>
Subject: [PATCH v2 4/6] dmaengine: pl330: Change unused arg "len" from get_burst_len()
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused length argument from get_burst_len() and add burst size as
an argument to allow usage of this function in other places as source and
destination burst sizes are handled separately.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/dma/pl330.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 746da0bbea92..e5e610c91f18 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2660,8 +2660,7 @@ __pl330_prep_dma_memcpy(struct dma_pl330_chan *pch, dma_addr_t dst,
 	return desc;
 }
 
-/* Call after fixing burst size */
-static inline int get_burst_len(struct dma_pl330_desc *desc, size_t len)
+static inline int get_burst_len(struct dma_pl330_desc *desc, unsigned int brst_size)
 {
 	struct dma_pl330_chan *pch = desc->pchan;
 	struct pl330_dmac *pl330 = pch->dmac;
@@ -2669,7 +2668,7 @@ static inline int get_burst_len(struct dma_pl330_desc *desc, size_t len)
 
 	burst_len = pl330->pcfg.data_bus_width / 8;
 	burst_len *= pl330->pcfg.data_buf_dep / pl330->pcfg.num_chan;
-	burst_len >>= desc->rqcfg.src_brst_size;
+	burst_len >>= brst_size;
 
 	/* src/dst_burst_len can't be more than 16 */
 	if (burst_len > PL330_MAX_BURST)
@@ -2805,7 +2804,7 @@ pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
 		burst /= 2;
 
 	desc->rqcfg.src_brst_size = __ffs(burst);
-	desc->rqcfg.src_brst_len = get_burst_len(desc, len);
+	desc->rqcfg.src_brst_len = get_burst_len(desc, desc->rqcfg.src_brst_size);
 	/*
 	 * If burst size is smaller than bus width then make sure we only
 	 * transfer one at a time to avoid a burst stradling an MFIFO entry.
-- 
2.40.1.606.ga4b1b128d6-goog

