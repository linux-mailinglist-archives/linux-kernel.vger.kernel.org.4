Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE651629DF6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiKOPql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238390AbiKOPqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:46:15 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0062E68F;
        Tue, 15 Nov 2022 07:46:14 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id f3so7203698pgc.2;
        Tue, 15 Nov 2022 07:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L+yMIbf0sILuUn/zPTVTjnjYR0wuNHaFeLrP/pUKrjw=;
        b=lpyEvhCVexFe+URWzn5JK3i7TBsdFL7Pu2qdFiw9Vy2J0MEJjW9cdwsEJqIpoO1/0c
         YJ+TEjdYw8OVWmcwaJAFz9pkHTc089X3XVaW8KD4xjjaSn52H9qnDg/j5fyNqxl3hyP3
         B1WbLIawt4TZLtFWIHmv8MOo4nVJhrAwOfX74Wu+tq3b7AdXyqoHwX8o9geFf6BOzo/q
         vzJlTCgJR4f2zRrW+tSacN+mxRtFfIGI3zhmbHtyF6E+uKbiPrVFjD2V6Oxb/yY0sJa3
         1ejFdwMHgfKu0DoF6QpeMw9LpA2DiiPHP097DDToFpgDYWxhl3dTkCahuKfkOjNv7jPC
         91VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+yMIbf0sILuUn/zPTVTjnjYR0wuNHaFeLrP/pUKrjw=;
        b=Ux+v1TpS47jyx35vbjy3tw5yGRx2xiedyUnFjOg5yEI1D3K9RwAy5PBeBfb/wNxIlb
         g+SlS3XFKmDZ+Onizv0DDBAUtVTIEac+uX3ATe7G4nPMF5N+5XXmlOSNcsiye6xwhwxs
         fVzqJTmqFsMETmJmxF6FtFUjxVe4LotPx8mrf/KwnX/ttzaX6iMb01COxcmwoT+0zP0v
         eBf3/H+w/itf2h/qr26Z4WE4TjZ7w9aL1AULRTOuEy0yl4XaIu756btAcn1w0ylrkLh4
         ZTekdPeDsBVrm2hOqjkzRfCGpPFnksPkcke9b5/VFnuRr/9FZuup7IFQboIDUY1bUsgx
         VOeA==
X-Gm-Message-State: ANoB5pmg06BQTqDyj7DK00o2ixbjBhswUjCpJ7gDMHCifSvdXILYy8jb
        3aC9yCGF6MwMkWG1j7epr6Y=
X-Google-Smtp-Source: AA0mqf6sAEQYc95aTWVRmax3Bm9my4SWPwUC3yTXSS6fOB58SfOgyWmGsn0n3MwtRPEJ6Sw2M4pUsw==
X-Received: by 2002:a65:4c89:0:b0:476:c9bd:c0d9 with SMTP id m9-20020a654c89000000b00476c9bdc0d9mr1752225pgt.415.1668527173629;
        Tue, 15 Nov 2022 07:46:13 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id q13-20020a17090311cd00b00174f7d10a03sm5799992plh.86.2022.11.15.07.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 07:46:13 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Chia-I Wu <olvaffe@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] drm/msm/a6xx: Fix speed-bin detection vs probe-defer
Date:   Tue, 15 Nov 2022 07:46:34 -0800
Message-Id: <20221115154637.1613968-1-robdclark@gmail.com>
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
v3: Add previously missing \n's

Fixed: fe7952c629da ("drm/msm: Add speed-bin support to a618 gpu")
Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 7fe60c65a1eb..ebe9599a8316 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1931,7 +1931,7 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_rev rev, u32 fuse)
 
 	if (val == UINT_MAX) {
 		DRM_DEV_ERROR(dev,
-			"missing support for speed-bin: %u. Some OPPs may not be supported by hardware",
+			"missing support for speed-bin: %u. Some OPPs may not be supported by hardware\n",
 			fuse);
 		return UINT_MAX;
 	}
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
+			      "failed to read speed-bin. Some OPPs may not be supported by hardware\n");
+		return ret;
 	}
 
 	supp_hw = fuse_to_supp_hw(dev, rev, speedbin);
 
-done:
 	ret = devm_pm_opp_set_supported_hw(dev, &supp_hw, 1);
 	if (ret)
 		return ret;
-- 
2.38.1

