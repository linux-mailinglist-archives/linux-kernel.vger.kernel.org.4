Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14500672F57
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 04:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjASDCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 22:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjASDCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:02:41 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF17D5A837;
        Wed, 18 Jan 2023 19:02:30 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VZrtxIM_1674097321;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VZrtxIM_1674097321)
          by smtp.aliyun-inc.com;
          Thu, 19 Jan 2023 11:02:27 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     robdclark@gmail.com
Cc:     quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, airlied@gmail.com, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v3] drm/msm/dpu: add the regdma entries to .dma_cfg of these chipsets
Date:   Thu, 19 Jan 2023 11:01:31 +0800
Message-Id: <20230119030131.21904-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variables 'sc8280xp_regdma' and 'sm8350_regdma' are defined in the
dpu_hw_catalog.c file, but not used elsewhere, so adding the regdma
entries to .dma_cfg of these chipsets.

drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:2029:37: warning: unused
variable 'sc8280xp_regdma'.
drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c:2053:37: warning: unused
variable 'sm8350_regdma'.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3722
Fixes: 4a352c2fc15a ("drm/msm/dpu: Introduce SC8280XP")
Fixes: 0e91bcbb0016 ("drm/msm/dpu: Add SM8350 to hw catalog")
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v3:
  -Add Fixes tag and change the title.

 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 0f3da480b066..3318e1d18a0e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -2677,6 +2677,8 @@ static const struct dpu_mdss_cfg sc8280xp_dpu_cfg = {
 	.intf = sc8280xp_intf,
 	.vbif_count = ARRAY_SIZE(sdm845_vbif),
 	.vbif = sdm845_vbif,
+	.reg_dma_count = 1,
+	.dma_cfg = &sc8280xp_regdma,
 	.perf = &sc8280xp_perf_data,
 	.mdss_irqs = IRQ_SC8280XP_MASK,
 };
@@ -2732,7 +2734,7 @@ static const struct dpu_mdss_cfg sm8350_dpu_cfg = {
 	.vbif_count = ARRAY_SIZE(sdm845_vbif),
 	.vbif = sdm845_vbif,
 	.reg_dma_count = 1,
-	.dma_cfg = &sm8250_regdma,
+	.dma_cfg = &sm8350_regdma,
 	.perf = &sm8350_perf_data,
 	.mdss_irqs = IRQ_SM8350_MASK,
 };
-- 
2.20.1.7.g153144c

