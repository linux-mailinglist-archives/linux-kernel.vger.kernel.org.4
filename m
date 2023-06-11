Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C4572B274
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 17:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjFKPX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 11:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjFKPX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 11:23:57 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36182E46
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 08:23:53 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Bxb+sH54Vkp9wCAA--.6403S3;
        Sun, 11 Jun 2023 23:23:51 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxVeQH54VkHBATAA--.55302S2;
        Sun, 11 Jun 2023 23:23:51 +0800 (CST)
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Konig <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alvin Lee <Alvin.Lee2@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        Samson Tam <samson.tam@amd.com>,
        Dillon Varone <Dillon.Varone@amd.com>,
        Alan Liu <HaoPing.Liu@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/amdgpu: Add error reporting code for the display core
Date:   Sun, 11 Jun 2023 23:23:51 +0800
Message-Id: <20230611152351.24569-1-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxVeQH54VkHBATAA--.55302S2
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr1kAFykJryDJF1xCryxCrX_yoW5uFW7pw
        4fGa1YgrWUAwnIqrZxJay0vF1fAa4fKF40yry3Cw1Sqa9rtrn3Jr48Gr1ayay3JFZxWa4I
        qFZ0y3y5uF12krcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
        xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI
        0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
        67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
        IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
        14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2Vyx
        DUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[why]

Because the drm/amdgpu drivers do not work with Navi 10 [RX 5700] series
GPUs on non-x86 platforms, this patch helps find out where the drivers fail.
After applying his patch, the following error message can be found:

[drm:dc_create [amdgpu]] *ERROR* dc_construct: failed to create resource pool
[drm:dc_create [amdgpu]] *ERROR* dc_create: dc construct failed
[drm] Display Core failed to initialize with v3.2.230!

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 29 ++++++++++++++++--------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 52564b93f7eb..d33b78aa3e58 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -951,7 +951,7 @@ static bool dc_construct(struct dc *dc,
 		goto fail;
 	}
 
-        dc_ctx = dc->ctx;
+	dc_ctx = dc->ctx;
 
 	/* Resource should construct all asic specific resources.
 	 * This should be the only place where we need to parse the asic id
@@ -990,16 +990,21 @@ static bool dc_construct(struct dc *dc,
 	}
 
 	dc->res_pool = dc_create_resource_pool(dc, init_params, dc_ctx->dce_version);
-	if (!dc->res_pool)
+	if (!dc->res_pool) {
+		dm_error("%s: failed to create resource pool\n", __func__);
 		goto fail;
+	}
 
 	/* set i2c speed if not done by the respective dcnxxx__resource.c */
 	if (dc->caps.i2c_speed_in_khz_hdcp == 0)
 		dc->caps.i2c_speed_in_khz_hdcp = dc->caps.i2c_speed_in_khz;
 
 	dc->clk_mgr = dc_clk_mgr_create(dc->ctx, dc->res_pool->pp_smu, dc->res_pool->dccg);
-	if (!dc->clk_mgr)
+	if (!dc->clk_mgr) {
+		dm_error("%s: failed to create clk manager\n", __func__);
 		goto fail;
+	}
+
 #ifdef CONFIG_DRM_AMD_DC_FP
 	dc->clk_mgr->force_smu_not_present = init_params->force_smu_not_present;
 
@@ -1022,14 +1027,18 @@ static bool dc_construct(struct dc *dc,
 		goto fail;
 	}
 
-	if (!create_links(dc, init_params->num_virtual_links))
+	if (!create_links(dc, init_params->num_virtual_links)) {
+		dm_error("%s: failed to create links\n", __func__);
 		goto fail;
+	}
 
 	/* Create additional DIG link encoder objects if fewer than the platform
 	 * supports were created during link construction.
 	 */
-	if (!create_link_encoders(dc))
+	if (!create_link_encoders(dc)) {
+		dm_error("%s: failed to create link encoders\n", __func__);
 		goto fail;
+	}
 
 	dc_resource_state_construct(dc, dc->current_state);
 
@@ -1314,11 +1323,15 @@ struct dc *dc_create(const struct dc_init_data *init_params)
 		return NULL;
 
 	if (init_params->dce_environment == DCE_ENV_VIRTUAL_HW) {
-		if (!dc_construct_ctx(dc, init_params))
+		if (!dc_construct_ctx(dc, init_params)) {
+			DC_LOG_ERROR("%s: dc construct failed\n", __func__);
 			goto destruct_dc;
+		}
 	} else {
-		if (!dc_construct(dc, init_params))
+		if (!dc_construct(dc, init_params)) {
+			DC_LOG_ERROR("%s: dc construct failed\n", __func__);
 			goto destruct_dc;
+		}
 
 		full_pipe_count = dc->res_pool->pipe_count;
 		if (dc->res_pool->underlay_pipe_index != NO_UNDERLAY_PIPE)
@@ -1349,8 +1362,6 @@ struct dc *dc_create(const struct dc_init_data *init_params)
 
 	DC_LOG_DC("Display Core initialized\n");
 
-
-
 	return dc;
 
 destruct_dc:
-- 
2.25.1

