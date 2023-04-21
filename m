Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2706EB31F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 22:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjDUUyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 16:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjDUUyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 16:54:06 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0681F1FCE
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 13:54:03 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id EE9C33F5D8;
        Fri, 21 Apr 2023 22:54:00 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
Date:   Fri, 21 Apr 2023 22:53:52 +0200
Subject: [PATCH v2 2/3] drm/msm/dpu: Drop unused members from HW structs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230418-dpu-drop-useless-for-lookup-v2-2-acb08e82ef19@somainline.org>
References: <20230418-dpu-drop-useless-for-lookup-v2-0-acb08e82ef19@somainline.org>
In-Reply-To: <20230418-dpu-drop-useless-for-lookup-v2-0-acb08e82ef19@somainline.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of these members were initialized while never read, while others
were not even assigned any pointer value at all.  Drop them to save some
space, and above all confusion when looking at or accidentally
dereferencing these members.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c | 1 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h | 1 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c | 1 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h | 2 --
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c   | 1 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h   | 5 -----
 6 files changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
index 84ee2efa9c664..a9c90249a6aca 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -374,7 +374,6 @@ struct dpu_hw_intf *dpu_hw_intf_init(enum dpu_intf idx,
 	 */
 	c->idx = idx;
 	c->cap = cfg;
-	c->mdss = m;
 	_setup_intf_ops(&c->ops, c->cap->features);
 
 	return c;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
index 643dd10bc0306..e07b2e33af3e2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
@@ -90,7 +90,6 @@ struct dpu_hw_intf {
 	/* intf */
 	enum dpu_intf idx;
 	const struct dpu_intf_cfg *cap;
-	const struct dpu_mdss_cfg *mdss;
 
 	/* ops */
 	struct dpu_hw_intf_ops ops;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
index cf70a9bd1034f..bb3ddec5c7d73 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
@@ -812,7 +812,6 @@ struct dpu_hw_sspp *dpu_hw_sspp_init(enum dpu_sspp idx,
 	}
 
 	/* Assign ops */
-	hw_pipe->catalog = catalog;
 	hw_pipe->ubwc = catalog->ubwc;
 	hw_pipe->idx = idx;
 	hw_pipe->cap = cfg;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
index 74b98b6b3bc3a..5004a02fd61e2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
@@ -341,7 +341,6 @@ struct dpu_hw_sspp_ops {
  * struct dpu_hw_sspp - pipe description
  * @base: hardware block base structure
  * @hw: block hardware details
- * @catalog: back pointer to catalog
  * @ubwc: ubwc configuration data
  * @idx: pipe index
  * @cap: pointer to layer_cfg
@@ -350,7 +349,6 @@ struct dpu_hw_sspp_ops {
 struct dpu_hw_sspp {
 	struct dpu_hw_blk base;
 	struct dpu_hw_blk_reg_map hw;
-	const struct dpu_mdss_cfg *catalog;
 	const struct dpu_ubwc_cfg *ubwc;
 
 	/* Pipe */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
index a3e413d277175..f33b48045b5c7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
@@ -263,7 +263,6 @@ struct dpu_hw_wb *dpu_hw_wb_init(enum dpu_wb idx,
 	}
 
 	/* Assign ops */
-	c->mdp = &m->mdp[0];
 	c->idx = idx;
 	c->caps = cfg;
 	_setup_wb_ops(&c->ops, c->caps->features);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h
index 3ff5a48541e2e..b91923f879f13 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h
@@ -76,15 +76,12 @@ struct dpu_hw_wb_ops {
 /**
  * struct dpu_hw_wb : WB driver object
  * @hw: block hardware details
- * @mdp: pointer to associated mdp portion of the catalog
  * @idx: hardware index number within type
  * @wb_hw_caps: hardware capabilities
  * @ops: function pointers
- * @hw_mdp: MDP top level hardware block
  */
 struct dpu_hw_wb {
 	struct dpu_hw_blk_reg_map hw;
-	const struct dpu_mdp_cfg *mdp;
 
 	/* wb path */
 	int idx;
@@ -92,8 +89,6 @@ struct dpu_hw_wb {
 
 	/* ops */
 	struct dpu_hw_wb_ops ops;
-
-	struct dpu_hw_mdp *hw_mdp;
 };
 
 /**

-- 
2.40.0

