Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F309D6AB940
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjCFJGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCFJGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:06:47 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEDC222CC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:06:44 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:b745:671d:a946:57fa])
        by xavier.telenet-ops.be with bizsmtp
        id Ux6a2900J4LuvSS01x6aeG; Mon, 06 Mar 2023 10:06:42 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pZ6nC-00B4Fr-6Q;
        Mon, 06 Mar 2023 10:06:34 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pZ6ni-000HC1-5x;
        Mon, 06 Mar 2023 10:06:34 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] drm/msm/dpu: Fix bit-shifting UB in DPU_HW_VER() macro
Date:   Mon,  6 Mar 2023 10:06:33 +0100
Message-Id: <20230306090633.65918-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc-5 and CONFIG_UBSAN_SHIFT=y:

    drivers/gpu/drm/msm/msm_mdss.c: In function 'msm_mdss_enable':
    drivers/gpu/drm/msm/msm_mdss.c:296:2: error: case label does not reduce to an integer constant
      case DPU_HW_VER_800:
      ^
    drivers/gpu/drm/msm/msm_mdss.c:299:2: error: case label does not reduce to an integer constant
      case DPU_HW_VER_810:
      ^
    drivers/gpu/drm/msm/msm_mdss.c:300:2: error: case label does not reduce to an integer constant
      case DPU_HW_VER_900:
      ^

This happens because for major revisions 8 or greather, the non-sign bit
of the major revision number is shifted into bit 31 of a signed integer,
which is undefined behavior.

Fix this by casting the major revision number to unsigned int.

Fixes: efcd0107727c4f04 ("drm/msm/dpu: add support for SM8550")
Fixes: 4a352c2fc15aec1e ("drm/msm/dpu: Introduce SC8280XP")
Fixes: 100d7ef6995d1f86 ("drm/msm/dpu: add support for SM8450")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index ddab9caebb18c40d..bbd3cbdd77956c5d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -19,8 +19,9 @@
  */
 #define MAX_BLOCKS    12
 
-#define DPU_HW_VER(MAJOR, MINOR, STEP) (((MAJOR & 0xF) << 28)    |\
-		((MINOR & 0xFFF) << 16)  |\
+#define DPU_HW_VER(MAJOR, MINOR, STEP)			\
+		((((unsigned int)MAJOR & 0xF) << 28) |	\
+		((MINOR & 0xFFF) << 16) |		\
 		(STEP & 0xFFFF))
 
 #define DPU_HW_MAJOR(rev)		((rev) >> 28)
-- 
2.34.1

