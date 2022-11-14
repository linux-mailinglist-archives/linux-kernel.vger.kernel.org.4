Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EE1628ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbiKNUuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbiKNUuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:50:35 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78AA62C7;
        Mon, 14 Nov 2022 12:50:34 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b11so11455155pjp.2;
        Mon, 14 Nov 2022 12:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QXeA+y+MM1L5GCQKRlS8sHVhUjtEuhwBzouoQoIPKAg=;
        b=R+WSP8EB91o8AyNj0awZIrD1OG47NnQDd1LvocHtU2qwVretNZi39qGTppPQdk9dhr
         R9d23QxaizOi+AJfTwyWhiSHC8wH/tsw4awjTmmZZGtVYf5PJdFXcLIjBH23CIagb2hF
         cy1uUWdMRHQQR0ov4xBYg6JsrEjmSeay5fYuApn3psXmBPIS4XiSpCYarbe+mpNJjsP8
         1O9DsAAshBRVfk097hnyHenZZoE70NYcAwCz7FrtdL6IjBpzkVuX/dIibEOUPy+CjNdn
         8NqdI88n93O+X9/5Ca+N29Z7FGV+8hkIjt2H+Mg4o/I1jdtaDj2ezhAvGsgDhktASXUp
         +Awg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXeA+y+MM1L5GCQKRlS8sHVhUjtEuhwBzouoQoIPKAg=;
        b=1viXUx8Rp1KpAc0RfJ6TMVDBSwpEh1/fYMLQcD5qJz+odPEvBDA7TSurvuHUYoxLvJ
         SW3YKilI3Wxq9nvdSajBewnBASM+sCSimeYp7xyvghJWoImf5AXSt63wISvPlKhvLDGx
         hSWp+xbtIluH6HZmvxuOucSRPrmYl+iqg+vVPWxGilE9iqmZwAs/kn5abMuPAMUUcT21
         CnzoUjSlIo2dU3P9kqnTmPJr6ocpbebhMwohbtI2pSFPr7kfEeyozoUMBE8LnnGH/CTr
         YdFJ7qwC16e2JKNXbuxNPMLYAlcHb+ovHVT6zcmhKQawsOlTHAj7QJXMdksSRVMNqZuS
         8K6Q==
X-Gm-Message-State: ANoB5pmZtHOSuSUgPP8R8bVEGRhke4dnrV5xHT9kVqu8mPE4e609XQ9z
        IurdWXiFyDZeomhOGRewstw=
X-Google-Smtp-Source: AA0mqf7pvZO/46MnyFzwdRFWRLAvLvWkgsxE5il3I8AEPtYOWHaydI9zLZQjD0WFq8NQFdvIiTuT5Q==
X-Received: by 2002:a17:90a:138d:b0:213:b853:5e45 with SMTP id i13-20020a17090a138d00b00213b8535e45mr15373339pja.97.1668459034137;
        Mon, 14 Nov 2022 12:50:34 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902d2cc00b001767f6f04efsm7983959plc.242.2022.11.14.12.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 12:50:33 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Chia-I Wu <olvaffe@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm/msm/a6xx: Fix speed-bin detection vs probe-defer
Date:   Mon, 14 Nov 2022 12:50:53 -0800
Message-Id: <20221114205055.1547497-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

If we get an error (other than -ENOENT) we need to propagate that up the
stack.  Otherwise if the nvmem driver hasn't probed yet, we'll end up
end up claiming that we support all the OPPs which is not likely to be
true (and on some generations impossible to be true, ie. if there are
conflicting OPPs).

v2: Update commit msg, gc unused label, etc

Fixed: fe7952c629da ("drm/msm: Add speed-bin support to a618 gpu")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 7fe60c65a1eb..6ae77e88060f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1941,7 +1941,7 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_rev rev, u32 fuse)
 
 static int a6xx_set_supported_hw(struct device *dev, struct adreno_rev rev)
 {
-	u32 supp_hw = UINT_MAX;
+	u32 supp_hw;
 	u32 speedbin;
 	int ret;
 
@@ -1953,15 +1953,13 @@ static int a6xx_set_supported_hw(struct device *dev, struct adreno_rev rev)
 	if (ret == -ENOENT) {
 		return 0;
 	} else if (ret) {
-		DRM_DEV_ERROR(dev,
-			      "failed to read speed-bin (%d). Some OPPs may not be supported by hardware",
-			      ret);
-		goto done;
+		dev_err_probe(dev, ret,
+			      "failed to read speed-bin. Some OPPs may not be supported by hardware");
+		return ret;
 	}
 
 	supp_hw = fuse_to_supp_hw(dev, rev, speedbin);
 
-done:
 	ret = devm_pm_opp_set_supported_hw(dev, &supp_hw, 1);
 	if (ret)
 		return ret;
-- 
2.38.1

