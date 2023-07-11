Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D13C74F794
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjGKRyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjGKRyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:54:19 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4D8E75;
        Tue, 11 Jul 2023 10:54:18 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b895a06484so30662265ad.1;
        Tue, 11 Jul 2023 10:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689098058; x=1691690058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=51D9c0yVqzyFZCZkTJ0kt3i/VPXv4eay4HZNWC1auNY=;
        b=Gcs0mnql8X3fsKI4gmoydVQVgblWa79bdy2+0+otEJiCi1adxEiy9VHGCNDkKW8YgL
         6Tt4mVCfrwo+Xatv5kG92nimpb5P60z2S93KR3RYlAvisz1GWKFOg6YorffdFlFMDDOJ
         pp/XRTTmTQ1jHfu/tgDyNpMc0wg8iCiurHDY60lrPMVMu0BTYD7oO+BIZP/mWORRAYBa
         yKYa+i5BQVwpyqPFx2ihW0gtMLfuTNwSVN/XUtxaHT3xsoFO60hB1dnHH7sJ4bGBO2PY
         X41+jBiiHzyQsx1XITHYpYrLHA65bjv/X2UQqfBt0J4wkWATpMj38zKnDmeMI4HMWJq5
         o4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689098058; x=1691690058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=51D9c0yVqzyFZCZkTJ0kt3i/VPXv4eay4HZNWC1auNY=;
        b=i/fqAkQgzeLI3aL6XAiaKZDjUO23sN/4DYTvJrbKupGpRA8ix+PBGPrtHAwQY80mSg
         8bIvEAEOjN+OxvQ8NncgzI7++zEf7NiGFaAz4aSQBpW0pQHhS5iRIOh7ihEzyo+z5As1
         bePBH4BPb9mj9T/B3liWS2KhvaBJrZ3T+yl2oUyPsUgDpGpqiJ2pZi2AjUQx0D32QdBs
         1rRZH7hMmWs8h+fLNAWIE93DaGr3znQu5kp7FcEy/1m1MaX1xAQ+3kchOPxbirmdyHeI
         XEQCFjJ+qnFGu+1tG59oXy4mrLl3IEKa8WDJz/IWKzrkRhVW9RplwFbl0D096KHvD+O0
         X70g==
X-Gm-Message-State: ABy/qLbflvVfFMZJJSkuyV/rsHMHTehikqtVzEHA/aHzDqUZQCmyYcia
        WNHIq2BXsH2pAn9JHYS+blk=
X-Google-Smtp-Source: APBJJlFiqtZa561h/NtpWyoYGEjlQjCnGiocVAnOqtntgECALUFn5OzNYw/w9eCMwwNevLA/drwf9A==
X-Received: by 2002:a17:902:e54a:b0:1b7:f99f:63c9 with SMTP id n10-20020a170902e54a00b001b7f99f63c9mr16862415plf.67.1689098058301;
        Tue, 11 Jul 2023 10:54:18 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902820b00b001b8a85489a3sm2191062pln.262.2023.07.11.10.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 10:54:17 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/adreno: Fix snapshot BINDLESS_DATA size
Date:   Tue, 11 Jul 2023 10:54:07 -0700
Message-ID: <20230711175409.157800-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

The incorrect size was causing "CP | AHB bus error" when snapshotting
the GPU state on a6xx gen4 (a660 family).

Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/26
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
index 790f55e24533..e788ed72eb0d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
@@ -206,7 +206,7 @@ static const struct a6xx_shader_block {
 	SHADER(A6XX_SP_LB_3_DATA, 0x800),
 	SHADER(A6XX_SP_LB_4_DATA, 0x800),
 	SHADER(A6XX_SP_LB_5_DATA, 0x200),
-	SHADER(A6XX_SP_CB_BINDLESS_DATA, 0x2000),
+	SHADER(A6XX_SP_CB_BINDLESS_DATA, 0x800),
 	SHADER(A6XX_SP_CB_LEGACY_DATA, 0x280),
 	SHADER(A6XX_SP_UAV_DATA, 0x80),
 	SHADER(A6XX_SP_INST_TAG, 0x80),
-- 
2.41.0

