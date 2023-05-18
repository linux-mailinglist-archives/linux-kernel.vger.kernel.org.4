Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E18708A96
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjERVbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjERVat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:30:49 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0BF19B3;
        Thu, 18 May 2023 14:30:29 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 6613A200CF;
        Thu, 18 May 2023 23:29:08 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
Date:   Thu, 18 May 2023 23:29:08 +0200
Subject: [PATCH] drm/msm/dpu: Use V4.0 PCC DSPP sub-block in SC7[12]80
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230518-dpu-sc7180-pcc-version-v1-1-ec9ca4949e3e@somainline.org>
X-B4-Tracking: v=1; b=H4sIAKOYZmQC/x3N0QrCMAyF4VcZuTbQdhOrryK7aLLoCqOWlA1h7
 N3NvPwPfJwdmmiWBo9uB5Utt/wpFv7SAc+pvAXzZA3Bhd5dfcSprtj45qPDyoyb6Emwj/cUaBB
 iCmCYUhMkTYVn42VdFhuryit//2/P8Th+urb/QX0AAAA=
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kalyan Thota <quic_kalyant@quicinc.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to various downstream sources the PCC sub-block inside DSPP is
version 4.0 since DPU 4.0 and higher, including SC7[12]80 at DPU version
6.2 and 7.2 respectively.  After correcting the version this struct
becomes identical to sm8150_dspp_sblk which is used all across the
catalog: replace uses of sc7180_dspp_sblk with that and remove
the struct definition for sc7180_dspp_sblk entirely.

Fixes: 4259ff7ae509e ("drm/msm/dpu: add support for pcc color block in dpu driver")
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h | 2 +-
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h | 2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c         | 5 -----
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h
index 8799ed7571190..e39fcfd4e46b1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h
@@ -76,7 +76,7 @@ static const struct dpu_lm_cfg sc7180_lm[] = {
 
 static const struct dpu_dspp_cfg sc7180_dspp[] = {
 	DSPP_BLK("dspp_0", DSPP_0, 0x54000, DSPP_SC7180_MASK,
-		 &sc7180_dspp_sblk),
+		 &sm8150_dspp_sblk),
 };
 
 static const struct dpu_pingpong_cfg sc7180_pp[] = {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
index 5957de1859844..307a8edc94076 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
@@ -83,7 +83,7 @@ static const struct dpu_lm_cfg sc7280_lm[] = {
 
 static const struct dpu_dspp_cfg sc7280_dspp[] = {
 	DSPP_BLK("dspp_0", DSPP_0, 0x54000, DSPP_SC7180_MASK,
-		 &sc7180_dspp_sblk),
+		 &sm8150_dspp_sblk),
 };
 
 static const struct dpu_pingpong_cfg sc7280_pp[] = {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 03f162af1a50b..47523751b2023 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -453,11 +453,6 @@ static const struct dpu_dspp_sub_blks msm8998_dspp_sblk = {
 		.len = 0x90, .version = 0x10007},
 };
 
-static const struct dpu_dspp_sub_blks sc7180_dspp_sblk = {
-	.pcc = {.id = DPU_DSPP_PCC, .base = 0x1700,
-		.len = 0x90, .version = 0x10000},
-};
-
 static const struct dpu_dspp_sub_blks sm8150_dspp_sblk = {
 	.pcc = {.id = DPU_DSPP_PCC, .base = 0x1700,
 		.len = 0x90, .version = 0x40000},

---
base-commit: 798d276b39e984345d52b933a900a71fa0815928
change-id: 20230518-dpu-sc7180-pcc-version-389a2b4ebcb2

Best regards,
-- 
Marijn Suijten <marijn.suijten@somainline.org>

