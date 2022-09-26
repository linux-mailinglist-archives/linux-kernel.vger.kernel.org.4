Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34BC5E9D8E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbiIZJ0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbiIZJZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:25:46 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5E31E0CD;
        Mon, 26 Sep 2022 02:24:49 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id F2DCF1E80D99;
        Mon, 26 Sep 2022 17:20:46 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RtFvrhUFBcKz; Mon, 26 Sep 2022 17:20:44 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id AC4901E80D96;
        Mon, 26 Sep 2022 17:20:43 +0800 (CST)
From:   Li Qiong <liqiong@nfschina.com>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yu Zhe <yuzhe@nfschina.com>, Li Qiong <liqiong@nfschina.com>
Subject: [PATCH] drm/msm/gem: Use size_add() against integer overflow
Date:   Mon, 26 Sep 2022 17:23:15 +0800
Message-Id: <20220926092315.17193-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"struct_size() + n" may cause a integer overflow,
use size_add() to handle it.

Signed-off-by: Li Qiong <liqiong@nfschina.com>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index c9e4aeb14f4a..3dec87e46e50 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -30,8 +30,8 @@ static struct msm_gem_submit *submit_create(struct drm_device *dev,
 	uint64_t sz;
 	int ret;
 
-	sz = struct_size(submit, bos, nr_bos) +
-			((u64)nr_cmds * sizeof(submit->cmd[0]));
+	sz = size_add(struct_size(submit, bos, nr_bos),
+			((u64)nr_cmds * sizeof(submit->cmd[0])));
 
 	if (sz > SIZE_MAX)
 		return ERR_PTR(-ENOMEM);
-- 
2.11.0

