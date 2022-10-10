Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEBF5F0A98
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiI3LeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiI3LdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:33:18 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678D1C77D0;
        Fri, 30 Sep 2022 04:27:03 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mf7DV3SHhzHq0v;
        Fri, 30 Sep 2022 19:24:42 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 19:27:01 +0800
Received: from huawei.com (10.67.174.245) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 30 Sep
 2022 19:27:01 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>
CC:     <robdclark@gmail.com>, <quic_abhinavk@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <sean@poorly.run>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <swboyd@chromium.org>,
        <dianders@chromium.org>, <andersson@kernel.org>,
        <chenzhongjin@huawei.com>
Subject: [PATCH -next] drm/msm: Remove unused variables 'top'
Date:   Mon, 10 Oct 2022 10:40:10 +0800
Message-ID: <20221010024010.2873633-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.245]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_DATE_IN_FUTURE_96_Q autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'commit 1e5df24b996c ("drm/msm/dpu: drop length from struct dpu_hw_blk_reg_map")'
'commit 9403f9a42c88 ("drm/msm/dpu: merge base_off with blk_off in struct dpu_hw_blk_reg_map")'
These commits had merged hw.blk_off and hw.blk_off to mdp.
So we don't need to get dpu_hw_mdp in dpu_kms_mdp_snapshot() now.

Since there is no code using 'top' in this function. Remove it.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 008e1420e6e5..79e81f1443be 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -902,13 +902,9 @@ static void dpu_kms_mdp_snapshot(struct msm_disp_state *disp_state, struct msm_k
 	int i;
 	struct dpu_kms *dpu_kms;
 	const struct dpu_mdss_cfg *cat;
-	struct dpu_hw_mdp *top;
 
 	dpu_kms = to_dpu_kms(kms);
-
 	cat = dpu_kms->catalog;
-	top = dpu_kms->hw_mdp;
-
 	pm_runtime_get_sync(&dpu_kms->pdev->dev);
 
 	/* dump CTL sub-blocks HW regs info */
-- 
2.33.0

