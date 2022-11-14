Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F7762898A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbiKNTlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKNTlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:41:11 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEE01A38B;
        Mon, 14 Nov 2022 11:41:10 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id q9so12007303pfg.5;
        Mon, 14 Nov 2022 11:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3XrI4nxvGHUCxoc8HuMbGJ+vNpFCW7F3PwRmwEeEnBE=;
        b=gppJTB4ThxkXJZLbWfSW4pZ121wwq072YhQUh+SzfkcvR94GOYRlkaQZg7dO7+yQNN
         5k3gNK8L1xS3vged5EKsB/9a71x2UreuBfs7GFBWV2mE+xY9TTS16jvL7ki0RpsXfaJV
         Fn3lgL3+mHi9IE5wNArMI0w7WgUEH2JE4OjytDywiWxE+1stkdv2Cul5CrgXn6Szpt6z
         7jarednJ9M0GUC0dprQE4/2rcI04RCTEcgUkUfki2i9QZPbhAxvP1RrdSiIWznaI7VRa
         0N4RaT5hz1BpQw8R4j91f9AxlSovfy1IUhd/99Xnb4TxVGlPSo9zlNgObRNYNcjTmOyA
         pDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3XrI4nxvGHUCxoc8HuMbGJ+vNpFCW7F3PwRmwEeEnBE=;
        b=x4+SM8CKue60fFAzDrRnAKQS43R9ZiDi/Pa5LX44sxsY+3cDpvKnXI+I8mLSBKDan6
         sIsfssffL+K0kpazCztnqWXrCUYN0g1pxSL0JkW+8GTfn5VUTvMgpIR4u431o18qxqQw
         ffdQ0tqomTi9izv1i+iLjW7EIYqt23Y3RzN6BxWeax414pndx2XQQyG9+Nab/n8Px0tJ
         z/sQafdMdmw+4CFZtEANwVMOYWjwQWbvBqGKORXWJePOWWYdEQuow9KTNDeo5KX4QrS3
         Kj9VHlhpLI0i5GAF/GXRCuW5ZVUApw9+EoGwFRgQaz31iOcb63gMZHWAcKk0WF+hVDD6
         BwvQ==
X-Gm-Message-State: ANoB5pl3eYvIp036UFz7/6Uoq4kOUwQfP50OI88FhLZ8EXaVhb0gh8BM
        25NLkcDARkRfGkuAlFoIusI=
X-Google-Smtp-Source: AA0mqf7ozzAVNmQ0762Wdq2RaoUHGyy3f7FD4K4fw0PZKL9JZzpVniJ6TDAEWGe0OS68Bc54J/2JBw==
X-Received: by 2002:a63:5206:0:b0:41a:5a80:5f20 with SMTP id g6-20020a635206000000b0041a5a805f20mr12701044pgb.442.1668454870081;
        Mon, 14 Nov 2022 11:41:10 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id gk9-20020a17090b118900b00205db4ff6dfsm6841481pjb.46.2022.11.14.11.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:41:09 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/a6xx: Fix speed-bin detection vs probe-defer
Date:   Mon, 14 Nov 2022 11:41:31 -0800
Message-Id: <20221114194133.1535178-1-robdclark@gmail.com>
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
stack.  Otherwise if the nvmem driver hasn't probed yet, we'll end up with
whatever OPP(s) are represented by bit zero.

Fixed: fe7952c629da ("drm/msm: Add speed-bin support to a618 gpu")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 7fe60c65a1eb..96de2202c86c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1956,7 +1956,7 @@ static int a6xx_set_supported_hw(struct device *dev, struct adreno_rev rev)
 		DRM_DEV_ERROR(dev,
 			      "failed to read speed-bin (%d). Some OPPs may not be supported by hardware",
 			      ret);
-		goto done;
+		return ret;
 	}
 
 	supp_hw = fuse_to_supp_hw(dev, rev, speedbin);
-- 
2.38.1

