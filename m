Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6E46634F3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbjAIXQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237675AbjAIXQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:16:13 -0500
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A815E2A1
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:16:10 -0800 (PST)
Received: from localhost.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 5D8883EB5B;
        Tue, 10 Jan 2023 00:16:07 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
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
        Drew Davenport <ddavenport@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/msm/dpu: Disallow unallocated resources to be returned
Date:   Tue, 10 Jan 2023 00:15:55 +0100
Message-Id: <20230109231556.344977-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the event that the topology requests resources that have not been
created by the system (because they are typically not represented in
dpu_mdss_cfg ^1), the resource(s) in global_state (in this case DSC
blocks, until their allocation/assignment is being sanity-checked in
"drm/msm/dpu: Reject topologies for which no DSC blocks are available")
remain NULL but will still be returned out of
dpu_rm_get_assigned_resources, where the caller expects to get an array
containing num_blks valid pointers (but instead gets these NULLs).

To prevent this from happening, where null-pointer dereferences
typically result in a hard-to-debug platform lockup, num_blks shouldn't
increase past NULL blocks and will print an error and break instead.
After all, max_blks represents the static size of the maximum number of
blocks whereas the actual amount varies per platform.

^1: which can happen after a git rebase ended up moving additions to
_dpu_cfg to a different struct which has the same patch context.

Fixes: bb00a452d6f7 ("drm/msm/dpu: Refactor resource manager")
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---

Changes since v2:
- Dropped all 7 other patches that were queued for -next;
- Reworded error message to clarify that the requested resource should
  have already been allocated, rather than sounding like
  dpu_rm_get_assigned_resources is (re)allocating/(re)assigning
  resources here;
- This patch is now (implicitly!) based after "drm/msm/dpu: Reject
  topologies for which no DSC blocks are available", which should make
  it impossible to reach this condition, making it more of a safeguard
  in case of future code changes and/or hidden issues: and is more
  clearly conveyed in the patch message as well.

v2: https://lore.kernel.org/linux-arm-msm/20221221231943.1961117-5-marijn.suijten@somainline.org/

 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index 73b3442e7467..7ada957adbbb 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -660,6 +660,11 @@ int dpu_rm_get_assigned_resources(struct dpu_rm *rm,
 				  blks_size, enc_id);
 			break;
 		}
+		if (!hw_blks[i]) {
+			DPU_ERROR("Allocated resource %d unavailable to assign to enc %d\n",
+				  type, enc_id);
+			break;
+		}
 		blks[num_blks++] = hw_blks[i];
 	}
 
-- 
2.39.0

