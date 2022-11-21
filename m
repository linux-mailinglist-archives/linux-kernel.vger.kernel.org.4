Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C62D632FC8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 23:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiKUWZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 17:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiKUWZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 17:25:11 -0500
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8C567F42
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 14:25:09 -0800 (PST)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 712A13F20C;
        Mon, 21 Nov 2022 23:25:06 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dpu: Print interrupt index in addition to the mask
Date:   Mon, 21 Nov 2022 23:24:55 +0100
Message-Id: <20221121222456.437815-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mask only describes the `irq_idx % 32` part, making it generally
impossible to deduce what interrupt is being enabled/disabled.  Since
`debug/core_irq` in debugfs (and other prints) also include the full
`DPU_IRQ_IDX()` value, print the same full value here for easier
correlation instead of only adding the `irq_idx / 32` part.

Furthermore, make the dbgstr messages more consistent.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
index cf1b6d84c18a..64589a9c2c51 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
@@ -252,9 +252,9 @@ static int dpu_hw_intr_enable_irq_locked(struct dpu_hw_intr *intr, int irq_idx)
 
 	cache_irq_mask = intr->cache_irq_mask[reg_idx];
 	if (cache_irq_mask & DPU_IRQ_MASK(irq_idx)) {
-		dbgstr = "DPU IRQ already set:";
+		dbgstr = "already ";
 	} else {
-		dbgstr = "DPU IRQ enabled:";
+		dbgstr = "";
 
 		cache_irq_mask |= DPU_IRQ_MASK(irq_idx);
 		/* Cleaning any pending interrupt */
@@ -268,7 +268,7 @@ static int dpu_hw_intr_enable_irq_locked(struct dpu_hw_intr *intr, int irq_idx)
 		intr->cache_irq_mask[reg_idx] = cache_irq_mask;
 	}
 
-	pr_debug("%s MASK:0x%.8lx, CACHE-MASK:0x%.8x\n", dbgstr,
+	pr_debug("DPU IRQ %d %senabled: MASK:0x%.8lx, CACHE-MASK:0x%.8x\n", irq_idx, dbgstr,
 			DPU_IRQ_MASK(irq_idx), cache_irq_mask);
 
 	return 0;
@@ -301,9 +301,9 @@ static int dpu_hw_intr_disable_irq_locked(struct dpu_hw_intr *intr, int irq_idx)
 
 	cache_irq_mask = intr->cache_irq_mask[reg_idx];
 	if ((cache_irq_mask & DPU_IRQ_MASK(irq_idx)) == 0) {
-		dbgstr = "DPU IRQ is already cleared:";
+		dbgstr = "already ";
 	} else {
-		dbgstr = "DPU IRQ mask disable:";
+		dbgstr = "";
 
 		cache_irq_mask &= ~DPU_IRQ_MASK(irq_idx);
 		/* Disable interrupts based on the new mask */
@@ -317,7 +317,7 @@ static int dpu_hw_intr_disable_irq_locked(struct dpu_hw_intr *intr, int irq_idx)
 		intr->cache_irq_mask[reg_idx] = cache_irq_mask;
 	}
 
-	pr_debug("%s MASK:0x%.8lx, CACHE-MASK:0x%.8x\n", dbgstr,
+	pr_debug("DPU IRQ %d %sdisabled: MASK:0x%.8lx, CACHE-MASK:0x%.8x\n", irq_idx, dbgstr,
 			DPU_IRQ_MASK(irq_idx), cache_irq_mask);
 
 	return 0;
-- 
2.38.1

