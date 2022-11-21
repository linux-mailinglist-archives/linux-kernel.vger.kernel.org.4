Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566A8632FE9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 23:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiKUWf5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Nov 2022 17:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiKUWfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 17:35:51 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3CF2DF8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 14:35:50 -0800 (PST)
Received: from [127.0.0.1] (bband-dyn193.178-41-216.t-com.sk [178.41.216.193])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 8150C1F8A5;
        Mon, 21 Nov 2022 23:35:48 +0100 (CET)
Date:   Mon, 21 Nov 2022 23:35:46 +0100
From:   Martin Botka <martin.botka@somainline.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
CC:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_drm/msm/dpu=3A_Print_inte?= =?US-ASCII?Q?rrupt_index_in_addition_to_the_mask?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221121222456.437815-1-marijn.suijten@somainline.org>
References: <20221121222456.437815-1-marijn.suijten@somainline.org>
Message-ID: <60E46E34-763F-4D03-B0CC-70B5A8AA660D@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On November 21, 2022 11:24:55 PM GMT+01:00, Marijn Suijten <marijn.suijten@somainline.org> wrote:
>The mask only describes the `irq_idx % 32` part, making it generally
>impossible to deduce what interrupt is being enabled/disabled.  Since
>`debug/core_irq` in debugfs (and other prints) also include the full
>`DPU_IRQ_IDX()` value, print the same full value here for easier
>correlation instead of only adding the `irq_idx / 32` part.
>
>Furthermore, make the dbgstr messages more consistent.
>
>Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>---
> drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
>index cf1b6d84c18a..64589a9c2c51 100644
>--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
>+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
>@@ -252,9 +252,9 @@ static int dpu_hw_intr_enable_irq_locked(struct dpu_hw_intr *intr, int irq_idx)
> 
> 	cache_irq_mask = intr->cache_irq_mask[reg_idx];
> 	if (cache_irq_mask & DPU_IRQ_MASK(irq_idx)) {
>-		dbgstr = "DPU IRQ already set:";
>+		dbgstr = "already ";
> 	} else {
>-		dbgstr = "DPU IRQ enabled:";
>+		dbgstr = "";
> 
> 		cache_irq_mask |= DPU_IRQ_MASK(irq_idx);
> 		/* Cleaning any pending interrupt */
>@@ -268,7 +268,7 @@ static int dpu_hw_intr_enable_irq_locked(struct dpu_hw_intr *intr, int irq_idx)
> 		intr->cache_irq_mask[reg_idx] = cache_irq_mask;
> 	}
> 
>-	pr_debug("%s MASK:0x%.8lx, CACHE-MASK:0x%.8x\n", dbgstr,
>+	pr_debug("DPU IRQ %d %senabled: MASK:0x%.8lx, CACHE-MASK:0x%.8x\n", irq_idx, dbgstr,
> 			DPU_IRQ_MASK(irq_idx), cache_irq_mask);
> 
> 	return 0;
>@@ -301,9 +301,9 @@ static int dpu_hw_intr_disable_irq_locked(struct dpu_hw_intr *intr, int irq_idx)
> 
> 	cache_irq_mask = intr->cache_irq_mask[reg_idx];
> 	if ((cache_irq_mask & DPU_IRQ_MASK(irq_idx)) == 0) {
>-		dbgstr = "DPU IRQ is already cleared:";
>+		dbgstr = "already ";
> 	} else {
>-		dbgstr = "DPU IRQ mask disable:";
>+		dbgstr = "";
> 
> 		cache_irq_mask &= ~DPU_IRQ_MASK(irq_idx);
> 		/* Disable interrupts based on the new mask */
>@@ -317,7 +317,7 @@ static int dpu_hw_intr_disable_irq_locked(struct dpu_hw_intr *intr, int irq_idx)
> 		intr->cache_irq_mask[reg_idx] = cache_irq_mask;
> 	}
> 
>-	pr_debug("%s MASK:0x%.8lx, CACHE-MASK:0x%.8x\n", dbgstr,
>+	pr_debug("DPU IRQ %d %sdisabled: MASK:0x%.8lx, CACHE-MASK:0x%.8x\n", irq_idx, dbgstr,
> 			DPU_IRQ_MASK(irq_idx), cache_irq_mask);
> 
> 	return 0;

Looks good to me.

Reviewed-by: Martin Botka <martin.botka@somainline.org>
