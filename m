Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5E3659261
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 23:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiL2WKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 17:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiL2WKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 17:10:36 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8274B6560;
        Thu, 29 Dec 2022 14:10:35 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id b2so20157310pld.7;
        Thu, 29 Dec 2022 14:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kRyde3/fSKsKjFS+aPwf5uEQhzkfhK22Fr/7tHCPJdA=;
        b=DQdMsvS8ZUtWgRPvyO7PU438V0JhSyDrONOmWpJBDzHacXngRgWBil64F+xY7I5Zw6
         mKfnUjRbKIaspnl8Uazvq624XhEO8gli3jD54oIXccMxNbSedIUMEU7xPE/xGJ7pUSce
         0PZ0e7oWp6XZCLlv18zWDQc3GVfNk3u6rhhyFHnjjiGlyipe+054J8NjhzDzcm16ZuKN
         fDG9W8W9Yt214FezG1878nP7+vVTKXqU9I9X0TbuSM06W/OYakvGSiu/MGaMtjRJgaLd
         nVDBJMclGQ70Fq1HLBbJ/PeQG2zWalG467/ATKzC63fN1PcxN5mlKur+ThePH09nPXZo
         KRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRyde3/fSKsKjFS+aPwf5uEQhzkfhK22Fr/7tHCPJdA=;
        b=nEexOtRGj9VTXQCejLdxk3NGm6+0CfBDbPnO1xj+yFCxvi/XN7ua0J49iMg2rrgrrr
         6g0yd5KfSbMJHPrOPrZYbk+RW9EenVrKLOzR4BdonlZCpQKP42xc5diCpM52lPYUZB9e
         /Dql0NjuMR2Mn1jjJMUUVAt9iIeghvKMYt5u635vUxsl/912sgCwL4de+8MqBDod8J2z
         OHUZBtlVT8N5UTktIGui1G7tZm3BGV17aFsz8CtO9owDqujqAAyApBLrf1EV+GFvpHPh
         H59tWRrL8paQ6a3gJT25FakkjubH887xs9F8EdKXTdka5mQAkT4z5h4RP+HRZwtsjyAn
         zgDw==
X-Gm-Message-State: AFqh2koUspFHnYTCyyFHOiin8nPBkis5ZVKq0nZSApC845B5elKXDH/C
        2vs/jajNUok7TSOOH+AxUJw=
X-Google-Smtp-Source: AMrXdXtk9ysIPzG6lLR3ceBm7y+Qz32EHSryZjB+EMiLeHjPoXCqYtH6t3LaPxb14AMfH+lilsf4vg==
X-Received: by 2002:a17:902:70cb:b0:189:cada:4294 with SMTP id l11-20020a17090270cb00b00189cada4294mr29391770plt.5.1672351834917;
        Thu, 29 Dec 2022 14:10:34 -0800 (PST)
Received: from localhost (c-73-67-135-195.hsd1.or.comcast.net. [73.67.135.195])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001745662d568sm13469088plf.278.2022.12.29.14.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 14:10:34 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC] drm/msm/a6xx: Fix devcore register range bugs
Date:   Thu, 29 Dec 2022 14:10:27 -0800
Message-Id: <20221229221031.775463-1-robdclark@gmail.com>
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

RB_MRT_FLAG_BUFFER is 0x8903->0xa91a inclusive.. don't split it (with a
hole) in the ps_cluster_rac and don't accidentially re-dump part of the
range in ps_cluster_rbp.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
I'm not 100% sure about this, because the RB_RB_SUB_BLOCK_SEL_CNTL_CD
stuff makes me think the registers dumped are not what the offsets
imply.  But if this is the case, the devcore doesn't capture enough
information to decode these regs properly in the first place!  Either
way there is *something* wrong.

I noticed this because these result in the crashdec tool encountering
only _LO or _HI components of 64b regs that it expects to come in
pairs of 32b dwords.

 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
index 2fb58b7098e4..a03891d844a5 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
@@ -18,12 +18,12 @@ static const u32 a6xx_gras_cluster[] = {
 static const u32 a6xx_ps_cluster_rac[] = {
 	0x8800, 0x8806, 0x8809, 0x8811, 0x8818, 0x881e, 0x8820, 0x8865,
 	0x8870, 0x8879, 0x8880, 0x8889, 0x8890, 0x8891, 0x8898, 0x8898,
-	0x88c0, 0x88c1, 0x88d0, 0x88e3, 0x8900, 0x890c, 0x890f, 0x891a,
+	0x88c0, 0x88c1, 0x88d0, 0x88e3, 0x8900, 0x891a,
 	0x8c00, 0x8c01, 0x8c08, 0x8c10, 0x8c17, 0x8c1f, 0x8c26, 0x8c33,
 };
 
 static const u32 a6xx_ps_cluster_rbp[] = {
-	0x88f0, 0x88f3, 0x890d, 0x890e, 0x8927, 0x8928, 0x8bf0, 0x8bf1,
+	0x88f0, 0x88f3, 0x8927, 0x8928, 0x8bf0, 0x8bf1,
 	0x8c02, 0x8c07, 0x8c11, 0x8c16, 0x8c20, 0x8c25,
 };
 
-- 
2.38.1

