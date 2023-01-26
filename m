Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EE767CFF5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjAZPTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjAZPS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:18:57 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEEDA270
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:18:13 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y11so2153166edd.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDYg2iMsJNzgV0foPqQk3vB8m7SDOB4BjLOoBWAaVoI=;
        b=qVvjUfInztdqE/AezWpCK0M6BGJg5la+DGWd4d54xN2vcFwQvi6VlF2ZxgNa87Us+S
         aEEgtG5E2e/X9YALxs1zJr9lk9jrgiwBT7rvgvBlL/ym/SunFYeb7KZyZs8LKCgvbv09
         hZagt0ehrv52ig82ZzGDMvJUROrTudZdrquCREFSaSP0ahdjrmL+QMZzmWBIx4xfkCz4
         BO+R23wFTCD5571+JPy7Fkqyijwh1mspiA13TyFDV0V1RJsAJk2ooU/nPCTqsxdGcEAY
         thWxI07tSADldODvzTOWrNYjuc9b6qourgxLKahGvir/J++o67mPn/u1E7oHyxYFnAJ3
         IFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDYg2iMsJNzgV0foPqQk3vB8m7SDOB4BjLOoBWAaVoI=;
        b=gkvb+tIFFvs4PxvqidzNxZwL2vSxwUFgxPhRfiLO4ZcHuMGnPz6KIIRzYfg9VhzrY3
         HERI1lW3olzMW6oSf5oNVT/ILc8EXtjVASOxLDerdUHEsRyJTG2xqtJLQw/KIyDy8ZdA
         5V2DqF5tvVP57MOQTEXILa664EDJNoWqge9DQwkIm64f+0qMihI1jkn3KxO9jLlPe5nT
         t9JfI/bmZT52oODyOtAKksZLBL/UhG2yk1/ByykOV92ggHeidJJGqAXm0Wi90ilyO0YI
         aXIOCQ6ID0VZmgjo4AL01F0j7ULC9vQXif03AF9k8nBqr7nYOzTBGBRBh28Wfsotcfqm
         +1Dw==
X-Gm-Message-State: AFqh2kp85K4lVZUszpeXnv6aQhk9WXXW51mxbMZ40dr1QTuSxWyMPBMw
        rg1SgcFu9H0fPvIHmcXGJ+dhlg==
X-Google-Smtp-Source: AMrXdXsEIZft+DpwljWA+Pr+MbyQ9p6JgElB0E6a05OvscCGE1slWGBUcjPnDDSoUeAdIILkO77mlA==
X-Received: by 2002:a05:6402:1846:b0:49e:ed53:d64a with SMTP id v6-20020a056402184600b0049eed53d64amr25296726edy.27.1674746281459;
        Thu, 26 Jan 2023 07:18:01 -0800 (PST)
Received: from localhost.localdomain (abyk108.neoplus.adsl.tpnet.pl. [83.9.30.108])
        by smtp.gmail.com with ESMTPSA id a16-20020aa7d910000000b00463bc1ddc76sm842808edr.28.2023.01.26.07.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 07:18:01 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/14] drm/msm/a6xx: Add A619_holi speedbin support
Date:   Thu, 26 Jan 2023 16:16:17 +0100
Message-Id: <20230126151618.225127-14-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126151618.225127-1-konrad.dybcio@linaro.org>
References: <20230126151618.225127-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A619_holi is implemented on at least two SoCs: SM4350 (holi) and SM6375
(blair). This is what seems to be a first occurrence of this happening,
but it's easy to overcome by guarding the SoC-specific fuse values with
of_machine_is_compatible(). Do just that to enable frequency limiting
on these SoCs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 31 +++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 452ba32699b2..89990bec897f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2091,6 +2091,34 @@ static u32 a618_get_speed_bin(u32 fuse)
 	return UINT_MAX;
 }
 
+static u32 a619_holi_get_speed_bin(u32 fuse)
+{
+	/*
+	 * There are (at least) two SoCs implementing A619_holi: SM4350 (holi)
+	 * and SM6375 (blair). Limit the fuse matching to the corresponding
+	 * SoC to prevent bogus frequency setting (as improbable as it may be,
+	 * given unexpected fuse values are.. unexpected! But still possible.)
+	 */
+
+	if (fuse == 0)
+		return 0;
+
+	if (of_machine_is_compatible("qcom,sm4350")) {
+		if (fuse == 138)
+			return 1;
+		else if (fuse == 92)
+			return 2;
+	} else if (of_machine_is_compatible("qcom,sm6375")) {
+		if (fuse == 190)
+			return 1;
+		else if (fuse == 177)
+			return 2;
+	} else
+		pr_warn("Unknown SoC implementing A619_holi!\n");
+
+	return UINT_MAX;
+}
+
 static u32 a619_get_speed_bin(u32 fuse)
 {
 	if (fuse == 0)
@@ -2150,6 +2178,9 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_rev rev, u32 fuse)
 	if (adreno_cmp_rev(ADRENO_REV(6, 1, 8, ANY_ID), rev))
 		val = a618_get_speed_bin(fuse);
 
+	else if (adreno_cmp_rev(ADRENO_REV(6, 1, 9, 1), rev))
+		val = a619_holi_get_speed_bin(fuse);
+
 	else if (adreno_cmp_rev(ADRENO_REV(6, 1, 9, ANY_ID), rev))
 		val = a619_get_speed_bin(fuse);
 
-- 
2.39.1

