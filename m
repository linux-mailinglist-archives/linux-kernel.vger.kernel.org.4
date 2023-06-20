Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF92736A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjFTLK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjFTLKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:10:51 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB6210D5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:10:48 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f640e48bc3so5887319e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687259445; x=1689851445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFAqDiLltNdklyeWnFl2VhcGAm3uwoOV8Onj4m150Sc=;
        b=INJmXdEmpvVXTm7i3mjAO0uySCULJiYlAGfi0xAC/HQG0TNF6pFPNOl3lRfnOcJmLV
         YTAsarOxgMOd1VtScH9QWuJzdxutC+CQzcDTWZzAggCpPr5HFxLK8PzB2hMeth75CCsK
         TDsMWhdivHMJC9nHTOEQnQCZZ9jgdgExA6AYseO9hp02lA4+ZoEnP/PJBsARms+8+2Uf
         iblB322RwEQAfICyC2mTbMlhG0UpgCiM/jOj7kw8dbYWUrEh789B1K+iwllvIjipSm0k
         UX68ERtZsgYYR7FQTUuBw4HXtDhcELRLDaiwqcFIrVqWn/AJvfNdJNW+vD3cDjKqRomQ
         7Vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687259445; x=1689851445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFAqDiLltNdklyeWnFl2VhcGAm3uwoOV8Onj4m150Sc=;
        b=C1GB4C3H6viq37eLdhzdOkHtr9nR6EgSYj6ZsqPdCB5SJ604qkycFla1D2TBTx5dXD
         QX4scacM1XFzWBzvqq3/nGFwrf0OnUAqFe0+2vDzzlxawu+aSDFN6mqhXnYLPpx/YWnP
         UoqTSFp+Zyfy/M1BJH2rWASvFZ3j2Tt2OCTWYlp/Ogub/6i2ll4Rv1r+rwVcpdk0kpOt
         AvuserInmEm9GpygrG8o3oGwKDx3MVMbbucHc7Z6BD6n0ZPksyeYrHhDqxlkdkCnqIPB
         Le6VeU5Fe8c1YweA14PvZw51/RUN4oOlv2gc/LBq8j+UWutCsVO/BDB5A3zew+6GCQOQ
         QaZg==
X-Gm-Message-State: AC+VfDyJiyAPBjx06v+KEbvwo2XlSgeiohSJodvsJGRtX3OMfqRflvRe
        +sGVRPvx3rureS6NEe9ikhTeyw==
X-Google-Smtp-Source: ACHHUZ5eqZqdWUBigkTrmkmwCMGTjarq6T+1Y4fXQLi7UIXvf2LYvX4zPoiELEETJW3uy09iyxY4DQ==
X-Received: by 2002:a19:8c18:0:b0:4f8:6ac4:84 with SMTP id o24-20020a198c18000000b004f86ac40084mr3396390lfd.8.1687259445484;
        Tue, 20 Jun 2023 04:10:45 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id u26-20020a056512041a00b004f764716afdsm314395lfk.257.2023.06.20.04.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 04:10:45 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 20 Jun 2023 13:10:39 +0200
Subject: [PATCH v4 4/6] drm/msm/a6xx: Ensure clean GMU state in
 a6xx_gmu_fw_start
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-topic-a7xx_prep-v4-4-b16f273a91d4@linaro.org>
References: <20230517-topic-a7xx_prep-v4-0-b16f273a91d4@linaro.org>
In-Reply-To: <20230517-topic-a7xx_prep-v4-0-b16f273a91d4@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687259438; l=1213;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=xLnqc6AHpOSP+ED80kyz8V2j7nuk18OJ2Jy8h13Cf1I=;
 b=QopZRc6EUyhns0KVw6SVS/mXnt2VY3dxbBXKlHwjamd0sOsHi9ILo2buRVPW4sflNOLzCCv/3
 uwALjCxRCfDCC8KElFRyXVUV2TMrXf3AA/bOjOARIuUN8DEdT/p0VHy
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While it's not very well understood, there is some sort of a fault
handler implemented in the GMU firmware which triggers when a certain
bit is set, resulting in the M3 core not booting up the way we expect
it to.

Write a magic value to a magic register to hopefully prevent that
from happening.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 5deb79924897..9929ff187368 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -790,6 +790,12 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 	gmu_write(gmu, REG_A6XX_GMU_AHB_FENCE_RANGE_0,
 		(1 << 31) | (0xa << 18) | (0xa0));
 
+	/*
+	 * Snapshots toggle the NMI bit which will result in a jump to the NMI
+	 * handler instead of __main. Set the M3 config value to avoid that.
+	 */
+	gmu_write(gmu, REG_A6XX_GMU_CM3_CFG, 0x4052);
+
 	chipid = adreno_gpu->rev.core << 24;
 	chipid |= adreno_gpu->rev.major << 16;
 	chipid |= adreno_gpu->rev.minor << 12;

-- 
2.41.0

